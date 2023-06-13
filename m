Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B64272EBDB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239492AbjFMTXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFMTXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:23:17 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352D01A5;
        Tue, 13 Jun 2023 12:23:14 -0700 (PDT)
Received: from fpc.intra.ispras.ru (unknown [10.10.165.7])
        by mail.ispras.ru (Postfix) with ESMTPSA id 4AFEC40737DA;
        Tue, 13 Jun 2023 19:23:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4AFEC40737DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1686684189;
        bh=hIRs6Uzx3zjkKCTmplY/Pi+dHaV4Bk/epLmdjrJuCpU=;
        h=From:To:Cc:Subject:Date:From;
        b=gk5PMbPcjnyrxDmuuKVB1Jfl6MY4re3uzov615Wm4y+5VHIIZjhshadNqXpi2PaQS
         qgNE+00grlAlcoepwp3VpOZgku5iOaibXnSIX1FOZ8sAP+BuxoSuvW7PMWHaV2/GRj
         WtvS7APzt8bZZ8lUjigxkcDuaK9WBi2l9O/mv5AA=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Raed Salem <raeds@nvidia.com>,
        Lior Nahmanson <liorna@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH] net: macsec: fix double free of percpu stats
Date:   Tue, 13 Jun 2023 22:22:20 +0300
Message-Id: <20230613192220.159407-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside macsec_add_dev() we free percpu macsec->secy.tx_sc.stats and
macsec->stats on some of the memory allocation failure paths. However, the
net_device is already registered to that moment: in macsec_newlink(), just
before calling macsec_add_dev(). This means that during unregister process
its priv_destructor - macsec_free_netdev() - will be called and will free
the stats again.

Remove freeing percpu stats inside macsec_add_dev() because
macsec_free_netdev() will correctly free the already allocated ones. The
pointers to unallocated stats stay NULL, and free_percpu() treats that
correctly.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 0a28bfd4971f ("net/macsec: Add MACsec skb_metadata_dst Tx Data path support")
Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/macsec.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 3427993f94f7..984dfa5d6c11 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3997,17 +3997,15 @@ static int macsec_add_dev(struct net_device *dev, sci_t sci, u8 icv_len)
 		return -ENOMEM;
 
 	secy->tx_sc.stats = netdev_alloc_pcpu_stats(struct pcpu_tx_sc_stats);
-	if (!secy->tx_sc.stats) {
-		free_percpu(macsec->stats);
+	if (!secy->tx_sc.stats)
 		return -ENOMEM;
-	}
 
 	secy->tx_sc.md_dst = metadata_dst_alloc(0, METADATA_MACSEC, GFP_KERNEL);
-	if (!secy->tx_sc.md_dst) {
-		free_percpu(secy->tx_sc.stats);
-		free_percpu(macsec->stats);
+	if (!secy->tx_sc.md_dst)
+		/* macsec and secy percpu stats will be freed when unregistering
+		 * net_device in macsec_free_netdev()
+		 */
 		return -ENOMEM;
-	}
 
 	if (sci == MACSEC_UNDEF_SCI)
 		sci = dev_to_sci(dev, MACSEC_PORT_ES);
-- 
2.34.1

