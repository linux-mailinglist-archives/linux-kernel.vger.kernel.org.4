Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF44E74C59C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjGIPRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjGIPPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:15:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB01C18F;
        Sun,  9 Jul 2023 08:15:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80CF360C09;
        Sun,  9 Jul 2023 15:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E9FC433C9;
        Sun,  9 Jul 2023 15:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915705;
        bh=xbH6wIwOZG5M2DaP0ZJgalD+ZaD9fshGC5PX0Sdww5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kXpJxJPd0BDQz2GfcjEcAO2Or0OLnnmiKwHUc/SwDSaGZOfX0JEkevBah/02x2E/k
         5hbdLPkADcPH6g29iriRKww9AChQU827rvsOoPCv+L/T4IB88Xrp98HKszeZqo3H6e
         gXy1lnKJTxFGzh4iYUSmSbOXKA5NvWcoMnjd37uNl3I+bCfLZBJIzEzD2NRqrR+nZ5
         O25D9QZL8+PAee+FUuzfEkmJsC42caV4vgsnxLhwL6bZMUqg+x6vQisMwwxW2IP5Hl
         LPUOsdEhWI6YNJEO1nLG7xy4S+ZKfmvHOhWsBQoqhaqnaNpmm2pzoCh8IybNWIsc+r
         t/DSrU+qKqQnw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 11/18] net: ethernet: litex: add support for 64 bit stats
Date:   Sun,  9 Jul 2023 11:14:39 -0400
Message-Id: <20230709151446.513549-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151446.513549-1-sashal@kernel.org>
References: <20230709151446.513549-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.38
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

[ Upstream commit 18da174d865a87d47d2f33f5b0a322efcf067728 ]

Implement 64 bit per cpu stats to fix the overflow of netdev->stats
on 32 bit platforms. To simplify the code, we use net core
pcpu_sw_netstats infrastructure. One small drawback is some memory
overhead because litex uses just one queue, but we allocate the
counters per cpu.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Acked-by: Gabriel Somlo <gsomlo@gmail.com>
Link: https://lore.kernel.org/r/20230614162035.300-1-jszhang@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/litex/litex_liteeth.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/litex/litex_liteeth.c b/drivers/net/ethernet/litex/litex_liteeth.c
index 35f24e0f09349..ffa96059079c6 100644
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
2.39.2

