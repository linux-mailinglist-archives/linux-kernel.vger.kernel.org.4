Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414B17304F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjFNQcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjFNQb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:31:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68B410F7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ABA264467
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660DFC433C8;
        Wed, 14 Jun 2023 16:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686760316;
        bh=hIHHNwTZHZjjtMc5rO2ao0LGxA0PhO418XlFX+Ps8ZU=;
        h=From:To:Cc:Subject:Date:From;
        b=r1sBkNJhdzdt7GWyC+CoQpqUywo22wcglFqJu3zv+UHvvmM1YaLPY810WNxZp/KEC
         3bryukBOUxZiXqqxLc4qP8VXuTXtLvfcA7hj+XWzaKLojkpb79FPsngFvTN15hqO9h
         6J8Zma2VcwY3oMRHrtsnMHB5cl15a2KXHEMx7nEAFz4n6B4TSUw7sZ6gfPgNWAkAdA
         4uIU7Zg/P/0BfEHS3bbdPf6INXzEufxhyspiiRljsLB2ZE/6WZRoJIVIM3Vhnb8U8R
         nc3/a7W9rDdUS0F3zIZkllFYnuQz5idkzp0AZmelzR1nX7FIrRRxZlK6ChRjqAAER7
         +9UpK3kSbMWJg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethernet: litex: add support for 64 bit stats
Date:   Thu, 15 Jun 2023 00:20:35 +0800
Message-Id: <20230614162035.300-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement 64 bit per cpu stats to fix the overflow of netdev->stats
on 32 bit platforms. To simplify the code, we use net core
pcpu_sw_netstats infrastructure. One small drawback is some memory
overhead because litex uses just one queue, but we allocate the
counters per cpu.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/net/ethernet/litex/litex_liteeth.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/litex/litex_liteeth.c b/drivers/net/ethernet/litex/litex_liteeth.c
index 35f24e0f0934..ffa96059079c 100644
--- a/drivers/net/ethernet/litex/litex_liteeth.c
+++ b/drivers/net/ethernet/litex/litex_liteeth.c
@@ -78,8 +78,7 @@ static int liteeth_rx(struct net_device *netdev)
 	memcpy_fromio(data, priv->rx_base + rx_slot * priv->slot_size, len);
 	skb->protocol = eth_type_trans(skb, netdev);
 
-	netdev->stats.rx_packets++;
-	netdev->stats.rx_bytes += len;
+	dev_sw_netstats_rx_add(netdev, len);
 
 	return netif_rx(skb);
 
@@ -185,8 +184,7 @@ static netdev_tx_t liteeth_start_xmit(struct sk_buff *skb,
 	litex_write16(priv->base + LITEETH_READER_LENGTH, skb->len);
 	litex_write8(priv->base + LITEETH_READER_START, 1);
 
-	netdev->stats.tx_bytes += skb->len;
-	netdev->stats.tx_packets++;
+	dev_sw_netstats_tx_add(netdev, 1, skb->len);
 
 	priv->tx_slot = (priv->tx_slot + 1) % priv->num_tx_slots;
 	dev_kfree_skb_any(skb);
@@ -194,9 +192,17 @@ static netdev_tx_t liteeth_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static void
+liteeth_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
+{
+	netdev_stats_to_stats64(stats, &netdev->stats);
+	dev_fetch_sw_netstats(stats, netdev->tstats);
+}
+
 static const struct net_device_ops liteeth_netdev_ops = {
 	.ndo_open		= liteeth_open,
 	.ndo_stop		= liteeth_stop,
+	.ndo_get_stats64	= liteeth_get_stats64,
 	.ndo_start_xmit         = liteeth_start_xmit,
 };
 
@@ -242,6 +248,11 @@ static int liteeth_probe(struct platform_device *pdev)
 	priv->netdev = netdev;
 	priv->dev = &pdev->dev;
 
+	netdev->tstats = devm_netdev_alloc_pcpu_stats(&pdev->dev,
+						      struct pcpu_sw_netstats);
+	if (!netdev->tstats)
+		return -ENOMEM;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
-- 
2.40.1

