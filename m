Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F0863450A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiKVT6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbiKVT6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:58:11 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478B62338C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:58:06 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3a1cfadbcbaso62731957b3.23
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NW0Mw/qHQ9FIGEA+rYwuphRFxEn0u6CmWZPIH+7Q52E=;
        b=WRPvZ4wPW3a3gPE25QfY5FbQTs4oV7y90ry376Wn2mRUOvOP/z+i/MUN5ChborZs44
         WbqVuEY1M0h9xbB3TLjGbdtxYlnxHPifZ2dMBtWHRv/Yvk+mvuHLDsM37icIe5ErjCnZ
         mNWiwC+RkIOJiwzosAgkycpQgi3Cqg1sJjl9u324v/8Dgnys6205OpofRDj1DvzYSX6r
         3OIcR0nuvLx3JExExXq8McNOVs3d1Bx8y2ukK1U6kPDrS8es6DQSR4CrhQ+VNhylWFQo
         /4Q14hWqvjpM82tfV5+MMY/I3eQwlsI6IkX1P0XQl/Jykpqb+c1ssNb9+Dv51J9Xw65J
         fCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NW0Mw/qHQ9FIGEA+rYwuphRFxEn0u6CmWZPIH+7Q52E=;
        b=e6NsNwB35RgR7W17V/8wHtcWqoKPXcitagqLwh3aGtmLy/F82JACFfHf5qnZ+DR2bE
         BLHfQ29OzCqx6msoeJYTxYtaw63nn651EF+n6liw3RcxlNJ0cU2zR8LFTXxm78luyahL
         xfMOVbgMTaU0BeVS7YHHdLh3McRzg2nRuIdPpnU+tQXYS8PejWqIhNFnn21mdKyIkPtG
         iJjcwVWcdmxL02mG/E4A27fJj90fPgdAL4nlxxiesdWrTq8M3J+2hIUx8+XJCsJtKzZl
         mUH/pQp9rZCWvg64EJtsgL7cjCy2iyGoX08FL3aiKEHIr7/x+AxKtYfyvnYQ18yvwo8b
         Tkxg==
X-Gm-Message-State: ANoB5pk9gG6C0m73xx4mPtFurW3wSMROGAo8+6iQb7RsuUHfW6G9EXhX
        cCmBwGj6JYXPGMIEQTfYlktDqjup2bk4sBo=
X-Google-Smtp-Source: AA0mqf4j35koIfqEdWf70iMBzDHrg9LCXVRqEQou4dZ1CPLsn89DHaamQjU2iSDTHTGDczXQ7sCSTknhB24iPzw=
X-Received: from lixiaoyan-desktop.svl.corp.google.com ([2620:15c:2c4:201:d85f:1168:cf63:556b])
 (user=lixiaoyan job=sendgmr) by 2002:a81:c5:0:b0:392:f16a:23e3 with SMTP id
 188-20020a8100c5000000b00392f16a23e3mr5ywa.57.1669147085558; Tue, 22 Nov 2022
 11:58:05 -0800 (PST)
Date:   Tue, 22 Nov 2022 11:32:39 -0800
In-Reply-To: <20221122193239.3159985-1-lixiaoyan@google.com>
Mime-Version: 1.0
References: <20221122193239.3159985-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122193239.3159985-2-lixiaoyan@google.com>
Subject: [PATCH net-next 2/2] bnxt: Use generic HBH removal helper in tx path
From:   Coco Li <lixiaoyan@google.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michael Chan <michael.chan@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet implemented Big TCP that allowed bigger TSO/GRO packet sizes
for IPv6 traffic. See patch series:
'commit 89527be8d8d6 ("net: add IFLA_TSO_{MAX_SIZE|SEGS} attributes")'

This reduces the number of packets traversing the networking stack and
should usually improves performance. However, it also inserts a
temporary Hop-by-hop IPv6 extension header.

Using the HBH header removal method in the previous path, the extra header
be removed in bnxt drivers to allow it to send big TCP packets (bigger
TSO packets) as well.

If bnxt folks could help with testing this patch on the driver (as I
don't have access to one) that would be wonderful. Thank you!

Tested:
Compiled locally

To further test functional correctness, update the GSO/GRO limit on the
physical NIC:

ip link set eth0 gso_max_size 181000
ip link set eth0 gro_max_size 181000

Note that if there are bonding or ipvan devices on top of the physical
NIC, their GSO sizes need to be updated as well.

Then, IPv6/TCP packets with sizes larger than 64k can be observed.

Signed-off-by: Coco Li <lixiaoyan@google.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0fe164b42c5d..2bfa5e9fb179 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -389,6 +389,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			return NETDEV_TX_BUSY;
 	}
 
+	if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
+		goto tx_free;
+
 	length = skb->len;
 	len = skb_headlen(skb);
 	last_frag = skb_shinfo(skb)->nr_frags;
@@ -13657,6 +13660,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev->features &= ~NETIF_F_LRO;
 	dev->priv_flags |= IFF_UNICAST_FLT;
 
+	netif_set_tso_max_size(dev, GSO_MAX_SIZE);
 #ifdef CONFIG_BNXT_SRIOV
 	init_waitqueue_head(&bp->sriov_cfg_wait);
 #endif
-- 
2.38.1.584.g0f3c55d4c2-goog

