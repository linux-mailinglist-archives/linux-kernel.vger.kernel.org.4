Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC9D65335D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbiLUP17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbiLUP0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:26:24 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8B12494F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:25:58 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id i9so22493790edj.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fe+MrVyRK0YJrQ5IISCTbJAwTu34d4aUgYLMWTnozu8=;
        b=CDoXZtWSuqSgf1ZhWX4srtfwzRtK7hLLRRi08mtcnwwk5SpnA6XYeR1tPXz6hwdAw/
         jbOdmxt1q/2fsSR2MN6I21zFzf9NZG7/WRpyw3OcgYOQcO21UDLgrsT5Yj3SxDeWUPnR
         UzsYnjuK40f5jaGu8K/PKhAzZFm8cTXGlVS4G31nD6RX7p8EkQdQBaW9LO0Ji5Gn8O/U
         IbbskQA0G37X2gVZ+piZ5H2CeqH4MCtpPX69rXf36h7ijU00LbOFB1KxXfkBBGTK729l
         1iCbmMtueiiKU3iQe+NxrY+MMZY5tvQZuAOYjM/xUfvkZU1xi0FOl2Bbk5/glMMpPyv8
         2VIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fe+MrVyRK0YJrQ5IISCTbJAwTu34d4aUgYLMWTnozu8=;
        b=JWiUNewV3LO4I8YZpx3GKZBoT9nh74oUlyKZWGnxku+Q8kV3zEMOwhTxwnYFOeUOgU
         wuUQOnx6Z1O9vEZihbBp53kbX9SzqtOAE2yuoS+FtZD0BeUKhcGvpzx6mWernuVPDslc
         suvKt6Xo//ipMxRzCNFesO9Vogb4fI8KDabOigh4u6Mi/d3qLM5OnoIyf2GNZoLSKsVR
         i3K8pdiHjD2nj+Jny1TuCRBYEgQjF25k7YESQkZzp5P5stMhbsVgrBVLup+qs8VRpzzS
         DXGF0uCEEVOpn8TvuUHHiUwfsDp2hk5n+bmxOCHC25z3NjxjnjW85dxS0M7RT/K4FK56
         F4uQ==
X-Gm-Message-State: AFqh2kpnBPUeuo7BStpeIkSS/Npkbd9kJnDd7QPqzuMDrR9p5jHPfCZE
        SMAqj2pMjwX4f2THt0ur+Q8hQA==
X-Google-Smtp-Source: AMrXdXvagx9iDefg/JqtuxHtdTSeQ5ckwXThN02Rdlux8W1e5t2vbA1BQUAB64Ll+yhj6CeoIYtBIw==
X-Received: by 2002:aa7:dd13:0:b0:463:ba73:9139 with SMTP id i19-20020aa7dd13000000b00463ba739139mr1792081edv.2.1671636357033;
        Wed, 21 Dec 2022 07:25:57 -0800 (PST)
Received: from blmsp.fritz.box ([2001:4091:a245:805c:8713:84e4:2a9e:cbe8])
        by smtp.gmail.com with ESMTPSA id n19-20020aa7c793000000b0045cf4f72b04sm7105428eds.94.2022.12.21.07.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 07:25:56 -0800 (PST)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 17/18] can: m_can: Implement BQL
Date:   Wed, 21 Dec 2022 16:25:36 +0100
Message-Id: <20221221152537.751564-18-msp@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221221152537.751564-1-msp@baylibre.com>
References: <20221221152537.751564-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement byte queue limiting in preparation for the use of xmit_more().

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 43 ++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 076fa60317c2..719a7dfe154a 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -443,6 +443,8 @@ static void m_can_clean(struct net_device *net)
 	for (int i = 0; i != cdev->can.echo_skb_max; ++i)
 		can_free_echo_skb(cdev->net, i, NULL);
 
+	netdev_reset_queue(cdev->net);
+
 	spin_lock(&cdev->tx_handling_spinlock);
 	cdev->tx_fifo_in_flight = 0;
 	spin_unlock(&cdev->tx_handling_spinlock);
@@ -988,23 +990,25 @@ static int m_can_poll(struct napi_struct *napi, int quota)
  * echo. timestamp is used for peripherals to ensure correct ordering
  * by rx-offload, and is ignored for non-peripherals.
  */
-static void m_can_tx_update_stats(struct m_can_classdev *cdev,
-				  unsigned int msg_mark,
-				  u32 timestamp)
+static unsigned int m_can_tx_update_stats(struct m_can_classdev *cdev,
+					  unsigned int msg_mark, u32 timestamp)
 {
 	struct net_device *dev = cdev->net;
 	struct net_device_stats *stats = &dev->stats;
+	unsigned int frame_len;
 
 	if (cdev->is_peripheral)
 		stats->tx_bytes +=
 			can_rx_offload_get_echo_skb(&cdev->offload,
 						    msg_mark,
 						    timestamp,
-						    NULL);
+						    &frame_len);
 	else
-		stats->tx_bytes += can_get_echo_skb(dev, msg_mark, NULL);
+		stats->tx_bytes += can_get_echo_skb(dev, msg_mark, &frame_len);
 
 	stats->tx_packets++;
+
+	return frame_len;
 }
 
 static int m_can_echo_tx_event(struct net_device *dev)
@@ -1017,6 +1021,7 @@ static int m_can_echo_tx_event(struct net_device *dev)
 	int err = 0;
 	unsigned int msg_mark;
 	int processed = 0;
+	int processed_frame_len = 0;
 
 	struct m_can_classdev *cdev = netdev_priv(dev);
 
@@ -1045,10 +1050,14 @@ static int m_can_echo_tx_event(struct net_device *dev)
 		fgi = (++fgi >= cdev->mcfg[MRAM_TXE].num ? 0 : fgi);
 
 		/* update stats */
-		m_can_tx_update_stats(cdev, msg_mark, timestamp);
+		processed_frame_len += m_can_tx_update_stats(cdev, msg_mark,
+							     timestamp);
+
 		++processed;
 	}
 
+	netdev_completed_queue(cdev->net, processed, processed_frame_len);
+
 	if (ack_fgi != -1)
 		m_can_write(cdev, M_CAN_TXEFA, FIELD_PREP(TXEFA_EFAI_MASK,
 							  ack_fgi));
@@ -1148,10 +1157,12 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 		if (ir & IR_TC) {
 			/* Transmission Complete Interrupt*/
 			u32 timestamp = 0;
+			unsigned int frame_len;
 
 			if (cdev->is_peripheral)
 				timestamp = m_can_get_timestamp(cdev);
-			m_can_tx_update_stats(cdev, 0, timestamp);
+			frame_len = m_can_tx_update_stats(cdev, 0, timestamp);
+			netdev_completed_queue(cdev->net, 1, frame_len);
 			netif_wake_queue(dev);
 		}
 	} else  {
@@ -1667,6 +1678,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 	u32 cccr, fdflags;
 	int err;
 	int putidx;
+	unsigned int frame_len = can_skb_get_frame_len(skb);
 
 	/* Generate ID field for TX buffer Element */
 	/* Common to all supported M_CAN versions */
@@ -1712,7 +1724,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 		}
 		m_can_write(cdev, M_CAN_TXBTIE, 0x1);
 
-		can_put_echo_skb(skb, dev, 0, 0);
+		can_put_echo_skb(skb, dev, 0, frame_len);
 
 		m_can_write(cdev, M_CAN_TXBAR, 0x1);
 		/* End of xmit function for version 3.0.x */
@@ -1750,7 +1762,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 		/* Push loopback echo.
 		 * Will be looped back on TX interrupt based on message marker
 		 */
-		can_put_echo_skb(skb, dev, putidx, 0);
+		can_put_echo_skb(skb, dev, putidx, frame_len);
 
 		/* Enable TX FIFO element to start transfer  */
 		m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));
@@ -1833,14 +1845,23 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 				    struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
+	netdev_tx_t ret;
+	unsigned int frame_len;
 
 	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
+	frame_len = can_skb_get_frame_len(skb);
+
 	if (cdev->is_peripheral)
-		return m_can_start_peripheral_xmit(cdev, skb);
+		ret = m_can_start_peripheral_xmit(cdev, skb);
 	else
-		return m_can_start_fast_xmit(cdev, skb);
+		ret = m_can_start_fast_xmit(cdev, skb);
+
+	if (ret == NETDEV_TX_OK)
+		netdev_sent_queue(dev, frame_len);
+
+	return ret;
 }
 
 static int m_can_open(struct net_device *dev)
-- 
2.38.1

