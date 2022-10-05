Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D255F542E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiJEMF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJEMFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:05:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC79329347
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 05:05:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so907002wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 05:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LRX7GpLdgFvRfe1C5DKcxd/ZrRqJlQC6DhuQ385RIqQ=;
        b=wY/qUjaA3apGo0Gn3YoQSlP+i/rJrR6NFQzrjw3Ks9dgh1lZdAbtAA02eY3deSRwJu
         YwX3UF9uJO+wgUbNA/sCaSgvKK1/8+rkenZVDL/cSEtKA9loqiZ8YM8qUm4p7Y1Jst7K
         mhw/UWardrSVYcqSH5GO2QtYAsEKAmcHgiaZ05pGz0vclD0jBFb/svUHz3Yc1SSUYJVt
         Q8iQjM4gmHtH72gcm4ukqE5qjDpBHpF1NUK3xlW0QddylLtLK13WG/BB/fjJZOXYfuFr
         rknTWHsL7IpSCfhU+IadnVmo0CAecCa2pXlSHqQxXeqJIZBdGgvODgxR97aXBxJsQjhM
         kHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LRX7GpLdgFvRfe1C5DKcxd/ZrRqJlQC6DhuQ385RIqQ=;
        b=BRPeVd1LXIYaI5C0vzvLH+OkNWeiRI9qb5lL1cA2gZViX5NXlI3twpncwtXbM9ezmA
         4sfpVEe6oeFt4NUUDaztncLU9H+1hnKacdTBLnRn/rGsnihR55Qh5bOFoaPNxoij/DXX
         Uy3WTg9vvV+TSz+ZFmxUWqXq7ZP5+jVtCHFiaE7ovnqhIDSZ/HkD++riwAKoBU5Eunbj
         Mq+8ezFmPhh4EdNvQuUcEf4nat5cOMcmLf82lgLl9Wt2YfpvONNmHnVtCd5h8VB0GRPv
         JgmMQBVJUuph9wSQvUhJCe+7qXbl4mHJGx93doSi93FDVbNrcj7wrRotKhm2s/5s8AtZ
         5RXQ==
X-Gm-Message-State: ACrzQf26sMN5kptMx37vJlb1quSfTe/X5WJFNZz6yEu75duYjPvgEu22
        ycBa43Rc9o9Tjz69soyvyMYY7w==
X-Google-Smtp-Source: AMsMyM7Yk3vdlh17NVAK2oPOvU3tuGQHb5qFBVbuApIzXz+EL8rx7HRn0PP3bIYV5aleBURRZ57r2Q==
X-Received: by 2002:a05:600c:1c19:b0:3b4:c1cb:d46d with SMTP id j25-20020a05600c1c1900b003b4c1cbd46dmr3055730wms.172.1664971510379;
        Wed, 05 Oct 2022 05:05:10 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v16-20020a5d6790000000b0022e3e7813f0sm7799583wru.107.2022.10.05.05.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 05:05:10 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, edumazet@google.com, khalasa@piap.pl,
        kuba@kernel.org, pabeni@redhat.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 4/4] net: ethernet: xscale: fix easy remaining style issues
Date:   Wed,  5 Oct 2022 12:05:01 +0000
Message-Id: <20221005120501.3527435-4-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005120501.3527435-1-clabbe@baylibre.com>
References: <20221005120501.3527435-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix all easy remaining styles issues.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index 11e5c00f638d..f3732b67cc44 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -356,8 +356,7 @@ static void ixp_tx_timestamp(struct port *port, struct sk_buff *skb)
 
 	regs = port->timesync_regs;
 
-	/*
-	 * This really stinks, but we have to poll for the Tx time stamp.
+	/* This really stinks, but we have to poll for the Tx time stamp.
 	 * Usually, the time stamp is ready after 4 to 6 microseconds.
 	 */
 	for (cnt = 0; cnt < 100; cnt++) {
@@ -653,7 +652,8 @@ static inline void queue_put_desc(unsigned int queue, u32 phys,
 	BUG_ON(phys & 0x1F);
 	qmgr_put_entry(queue, phys);
 	/* Don't check for queue overflow here, we've allocated sufficient
-	   length and queues >= 32 don't support this check anyway. */
+	 * length and queues >= 32 don't support this check anyway.
+	 */
 }
 
 static inline void dma_unmap_tx(struct port *port, struct desc *desc)
@@ -893,7 +893,8 @@ static netdev_tx_t eth_xmit(struct sk_buff *skb, struct net_device *dev)
 	port->tx_buff_tab[n] = mem;
 #endif
 	desc->data = phys + offset;
-	desc->buf_len = desc->pkt_len = len;
+	desc->buf_len = len;
+	desc->pkt_len = len;
 
 	/* NPE firmware pads short frames with zeros internally */
 	wmb();
@@ -941,7 +942,7 @@ static void eth_set_mcast_list(struct net_device *dev)
 			__raw_writel(allmulti[i], &port->regs->mcast_mask[i]);
 		}
 		__raw_writel(DEFAULT_RX_CNTRL0 | RX_CNTRL0_ADDR_FLTR_EN,
-			&port->regs->rx_control[0]);
+			     &port->regs->rx_control[0]);
 		return;
 	}
 
@@ -1321,7 +1322,8 @@ static int eth_close(struct net_device *dev)
 			BUG_ON(n < 0);
 			desc = tx_desc_ptr(port, n);
 			phys = tx_desc_phys(port, n);
-			desc->buf_len = desc->pkt_len = 1;
+			desc->buf_len = 1;
+			desc->pkt_len = 1;
 			wmb();
 			queue_put_desc(TX_QUEUE(port->id), phys, desc);
 		}
-- 
2.35.1

