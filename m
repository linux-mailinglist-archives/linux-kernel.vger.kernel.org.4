Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9489C738100
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjFUJZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjFUJY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:24:26 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9192E1BCA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:24:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-311367a3e12so4736735f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339446; x=1689931446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgGolVUD4UXN/bgzsidi7fKnE4pGiXRO6QM6WC6v+Ds=;
        b=eeErYS/yb7l1i94wnKW/4Cz9K5CztVnCkeoHKYlRJbv6aKHhjqDbxr5yk1K8Dh6Wyt
         40pkE4VoeBGzSSC6tms4qeLrWDSDYvoWGiaBdoxIJHvuwS7uLp52NWnvyo/zAOewXd6U
         6I1dUMnevaP8a7cVpGeYHO2M1aQNTM0fmy/8cprYfhLSYhLHqjZim0w0rIcA57DqKmpt
         0ZU3Po/sP+qBwzIu+JJym4fqY8wvZJklDDIvXwMGMSbzcAKnGoQT8jorbUbN++Daxi9R
         XlXoifqwqUqQYfB7+1KUcNiHhBvhdZ1AREav+zvUbRIRJ0Wj7Jo6czmgHUuQzP4x+a/r
         RCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339446; x=1689931446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgGolVUD4UXN/bgzsidi7fKnE4pGiXRO6QM6WC6v+Ds=;
        b=ZLCVPfHnoZcQ3QPP+Xt1+qUwNtTCKnQognkz9RmcwpjvMGy/ObyJz2vPv5rr8LRz4B
         Q6YcvLPChbJTER9PyHliQzwcMKxV4+iicvpGf8kTwFAe2PSjmqF0Nvl7CUka4CLESWJk
         hbi5q3vtbPB7mVMgSoAHmVnoTdUz7D//I2kkKz9w5AUL2kjOTa21vrsduOB+UueGaoko
         skrZvk8hoczfOIch5w4V9mhnaxUn88MiMFBj5gJJ5CWzZN9EC2khMa+3qos5XeZsDTcv
         FKi7wIOfRX37YzrmOvUnpLfes7iLtU9mMKKkWQvQNTVSK4Cblk2jeElxT7YHat6+6Qy9
         fSVA==
X-Gm-Message-State: AC+VfDzDbE/Xh4I729GhZjo5SyTimZbFQUMtdbdiy9WON9hskgYV/CQD
        lc0QBriFAZERHOjklauZB0R85g==
X-Google-Smtp-Source: ACHHUZ6Q5XHXe8GPfNxwkYzofX+JhnhyhMamRQS6suM/w5rFj1aiAFzwbLttIaFm4TwvZo2i7ahFHg==
X-Received: by 2002:a05:6000:11d2:b0:30f:c473:dfd0 with SMTP id i18-20020a05600011d200b0030fc473dfd0mr11415466wrx.12.1687339446086;
        Wed, 21 Jun 2023 02:24:06 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id i11-20020adffdcb000000b002fda1b12a0bsm4022115wrs.2.2023.06.21.02.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:24:05 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v4 09/12] can: m_can: Introduce a tx_fifo_in_flight counter
Date:   Wed, 21 Jun 2023 11:23:47 +0200
Message-Id: <20230621092350.3130866-10-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621092350.3130866-1-msp@baylibre.com>
References: <20230621092350.3130866-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep track of the number of transmits in flight.

This patch prepares the driver to control the network interface queue
based on this counter. By itself this counter be
implemented with an atomic, but as we need to do other things in the
critical sections later I am using a spinlock instead.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 41 ++++++++++++++++++++++++++++++++++-
 drivers/net/can/m_can/m_can.h |  4 ++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 88c8d6a418f0..3353fd9fb3a2 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -465,6 +465,7 @@ static u32 m_can_get_timestamp(struct m_can_classdev *cdev)
 static void m_can_clean(struct net_device *net)
 {
 	struct m_can_classdev *cdev = netdev_priv(net);
+	unsigned long irqflags;
 
 	for (int i = 0; i != cdev->tx_fifo_size; ++i) {
 		if (!cdev->tx_ops[i].skb)
@@ -476,6 +477,10 @@ static void m_can_clean(struct net_device *net)
 
 	for (int i = 0; i != cdev->can.echo_skb_max; ++i)
 		can_free_echo_skb(cdev->net, i, NULL);
+
+	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
+	cdev->tx_fifo_in_flight = 0;
+	spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
 }
 
 /* For peripherals, pass skb to rx-offload, which will push skb from
@@ -1046,6 +1051,24 @@ static void m_can_tx_update_stats(struct m_can_classdev *cdev,
 	stats->tx_packets++;
 }
 
+static void m_can_finish_tx(struct m_can_classdev *cdev, int transmitted)
+{
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
+	cdev->tx_fifo_in_flight -= transmitted;
+	spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
+}
+
+static void m_can_start_tx(struct m_can_classdev *cdev)
+{
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
+	++cdev->tx_fifo_in_flight;
+	spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
+}
+
 static int m_can_echo_tx_event(struct net_device *dev)
 {
 	u32 txe_count = 0;
@@ -1055,6 +1078,7 @@ static int m_can_echo_tx_event(struct net_device *dev)
 	int i = 0;
 	int err = 0;
 	unsigned int msg_mark;
+	int processed = 0;
 
 	struct m_can_classdev *cdev = netdev_priv(dev);
 
@@ -1084,12 +1108,15 @@ static int m_can_echo_tx_event(struct net_device *dev)
 
 		/* update stats */
 		m_can_tx_update_stats(cdev, msg_mark, timestamp);
+		++processed;
 	}
 
 	if (ack_fgi != -1)
 		m_can_write(cdev, M_CAN_TXEFA, FIELD_PREP(TXEFA_EFAI_MASK,
 							  ack_fgi));
 
+	m_can_finish_tx(cdev, processed);
+
 	return err;
 }
 
@@ -1168,6 +1195,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 				timestamp = m_can_get_timestamp(cdev);
 			m_can_tx_update_stats(cdev, 0, timestamp);
 			netif_wake_queue(dev);
+			m_can_finish_tx(cdev, 1);
 		}
 	} else  {
 		if (ir & (IR_TEFN | IR_TEFW)) {
@@ -1854,11 +1882,22 @@ static netdev_tx_t m_can_start_peripheral_xmit(struct m_can_classdev *cdev,
 	}
 
 	netif_stop_queue(cdev->net);
+
+	m_can_start_tx(cdev);
+
 	m_can_tx_queue_skb(cdev, skb);
 
 	return NETDEV_TX_OK;
 }
 
+static netdev_tx_t m_can_start_fast_xmit(struct m_can_classdev *cdev,
+					 struct sk_buff *skb)
+{
+	m_can_start_tx(cdev);
+
+	return m_can_tx_handler(cdev, skb);
+}
+
 static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 				    struct net_device *dev)
 {
@@ -1870,7 +1909,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 	if (cdev->is_peripheral)
 		return m_can_start_peripheral_xmit(cdev, skb);
 	else
-		return m_can_tx_handler(cdev, skb);
+		return m_can_start_fast_xmit(cdev, skb);
 }
 
 static int m_can_open(struct net_device *dev)
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 38b154fea04b..5c182aece15c 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -109,6 +109,10 @@ struct m_can_classdev {
 	// Store this internally to avoid fetch delays on peripheral chips
 	u32 tx_fifo_putidx;
 
+	/* Protects shared state between start_xmit and m_can_isr */
+	spinlock_t tx_handling_spinlock;
+	int tx_fifo_in_flight;
+
 	struct m_can_tx_op *tx_ops;
 	int tx_fifo_size;
 	int next_tx_op;
-- 
2.40.1

