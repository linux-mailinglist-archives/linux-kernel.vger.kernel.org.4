Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED9F7381BD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjFUJYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjFUJYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:24:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A15919BE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:23:59 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3111cb3dda1so6539000f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339438; x=1689931438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YG6xa4Mbl+d0vaAdAyRdBK5qcXVedx+n3F0VVlmxXq4=;
        b=o7gQISJbu5AFv6piaVytdRxRrDk6G7BRNFqjAZYFCSw/ZswAdv+NrzyRHFaIO29+B0
         OlSBDO56lBGikCjgmcbj1drM6C/xE3Wu+OAThQIDgIpRCGp+QB0qYXYlZ1ed+xE6ELxO
         SHdwvleOro53n3sx6iLX2jF+hO5ojaRhOAqrrOKE7OBG0oH6Vt2wH6uPAyE9BBmnTod0
         rpsn6Aft1C7vKF+v1qpQX8Yplg132muYNxvZwdM56j8eW0XDd+DNzd894BTKBNbUTymV
         uV7zE9c+PxzquJb90JYAhFfhNoE1XdEGghe7vVvmuxMAkB87e4EP7fajG3yynP3WtHAk
         Hpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339438; x=1689931438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YG6xa4Mbl+d0vaAdAyRdBK5qcXVedx+n3F0VVlmxXq4=;
        b=FqVWYOhJF8ZVv3SH22xB2AzLT3Hw0abastlWqqA54BgG5DPrsfrvQgovCy29K7Rtfx
         avcZ23b1ifsfL6ygWFEuEFq0S7VY5UI83X5/AvWhR/25YMoiJHriCxx5JYXirj8wx77L
         WhMcLEQSCwTz+iG2LKcOusAN2y3xAb+Wkd4TkG5SNPc0ag6tIpdeqifC2EcKFYVeNPEh
         aLJHphDsnyk1Cu1SvxtwXbJ2ANJvDOQL97xM2krbmRBWivCGgX9wYrTb3Hl9/a0RLPsq
         ZsuOG1kFKGknSaa+dUAbnZ3V6JOIsXSVYsTrzOJGInub/Yt2JfC7tLkDIfBHklZL0Euv
         zjhg==
X-Gm-Message-State: AC+VfDz3oNC8AnFEnQSJFK33C8K+X9NyykYBieu/HuBrSskYKWWEAYsC
        LLeyL1SMqtoSwlKswDUdOyP4Pg==
X-Google-Smtp-Source: ACHHUZ6Hb9HpnncPgQ9LdPdtiAT+mz4NwKMXpLveLYbH7GGbIH7UayOOYMk5VicZoZRUYHq26goIWw==
X-Received: by 2002:a5d:4d4e:0:b0:311:d5d:1326 with SMTP id a14-20020a5d4d4e000000b003110d5d1326mr15128365wru.27.1687339438053;
        Wed, 21 Jun 2023 02:23:58 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id i11-20020adffdcb000000b002fda1b12a0bsm4022115wrs.2.2023.06.21.02.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:23:57 -0700 (PDT)
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
Subject: [PATCH v4 02/12] can: m_can: Implement receive coalescing
Date:   Wed, 21 Jun 2023 11:23:40 +0200
Message-Id: <20230621092350.3130866-3-msp@baylibre.com>
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

m_can offers the possibility to set an interrupt on reaching a watermark
level in the receive FIFO. This can be used to implement coalescing.
Unfortunately there is no hardware timeout available to trigger an
interrupt if only a few messages were received within a given time. To
solve this I am using a hrtimer to wake up the irq thread after x
microseconds.

The timer is always started if receive coalescing is enabled and new
received frames were available during an interrupt. The timer is stopped
if during a interrupt handling no new data was available.

If the timer is started the new item interrupt is disabled and the
watermark interrupt takes over. If the timer is not started again, the
new item interrupt is enabled again, notifying the handler about every
new item received.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 70 ++++++++++++++++++++++++++++++++---
 drivers/net/can/m_can/m_can.h |  7 ++++
 2 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 5251073987ee..02dfb416fbd2 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -419,6 +419,22 @@ static void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
 	}
 }
 
+static void m_can_interrupt_enable(struct m_can_classdev *cdev, u32 interrupts)
+{
+	if (cdev->active_interrupts == interrupts)
+		return;
+	cdev->ops->write_reg(cdev, M_CAN_IE, interrupts);
+	cdev->active_interrupts = interrupts;
+}
+
+static void m_can_coalescing_disable(struct m_can_classdev *cdev)
+{
+	u32 new_interrupts = cdev->active_interrupts | IR_RF0N;
+
+	hrtimer_cancel(&cdev->irq_timer);
+	m_can_interrupt_enable(cdev, new_interrupts);
+}
+
 static inline void m_can_enable_all_interrupts(struct m_can_classdev *cdev)
 {
 	/* Only interrupt line 0 is used in this driver */
@@ -427,6 +443,7 @@ static inline void m_can_enable_all_interrupts(struct m_can_classdev *cdev)
 
 static inline void m_can_disable_all_interrupts(struct m_can_classdev *cdev)
 {
+	m_can_coalescing_disable(cdev);
 	m_can_write(cdev, M_CAN_ILE, 0x0);
 }
 
@@ -1076,15 +1093,39 @@ static int m_can_echo_tx_event(struct net_device *dev)
 	return err;
 }
 
+static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
+{
+	u32 new_interrupts = cdev->active_interrupts;
+	bool enable_timer = false;
+
+	if (cdev->rx_coalesce_usecs_irq > 0 && (ir & (IR_RF0N | IR_RF0W))) {
+		enable_timer = true;
+		new_interrupts &= ~IR_RF0N;
+	} else if (!hrtimer_active(&cdev->irq_timer)) {
+		new_interrupts |= IR_RF0N;
+	}
+
+	m_can_interrupt_enable(cdev, new_interrupts);
+	if (enable_timer) {
+		hrtimer_start(&cdev->irq_timer,
+			      ns_to_ktime(cdev->rx_coalesce_usecs_irq * NSEC_PER_USEC),
+			      HRTIMER_MODE_REL);
+	}
+}
+
 static irqreturn_t m_can_isr(int irq, void *dev_id)
 {
 	struct net_device *dev = (struct net_device *)dev_id;
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	u32 ir;
 
-	if (pm_runtime_suspended(cdev->dev))
+	if (pm_runtime_suspended(cdev->dev)) {
+		m_can_coalescing_disable(cdev);
 		return IRQ_NONE;
+	}
+
 	ir = m_can_read(cdev, M_CAN_IR);
+	m_can_coalescing_update(cdev, ir);
 	if (!ir)
 		return IRQ_NONE;
 
@@ -1099,13 +1140,17 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	 * - state change IRQ
 	 * - bus error IRQ and bus error reporting
 	 */
-	if ((ir & IR_RF0N) || (ir & IR_ERR_ALL_30X)) {
+	if (ir & (IR_RF0N | IR_RF0W | IR_ERR_ALL_30X)) {
 		cdev->irqstatus = ir;
 		if (!cdev->is_peripheral) {
 			m_can_disable_all_interrupts(cdev);
 			napi_schedule(&cdev->napi);
-		} else if (m_can_rx_peripheral(dev, ir) < 0) {
-			goto out_fail;
+		} else {
+			int pkts;
+
+			pkts = m_can_rx_peripheral(dev, ir);
+			if (pkts < 0)
+				goto out_fail;
 		}
 	}
 
@@ -1141,6 +1186,15 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static enum hrtimer_restart m_can_irq_timer(struct hrtimer *timer)
+{
+	struct m_can_classdev *cdev = container_of(timer, struct m_can_classdev, irq_timer);
+
+	irq_wake_thread(cdev->net->irq, cdev->net);
+
+	return HRTIMER_NORESTART;
+}
+
 static const struct can_bittiming_const m_can_bittiming_const_30X = {
 	.name = KBUILD_MODNAME,
 	.tseg1_min = 2,		/* Time segment 1 = prop_seg + phase_seg1 */
@@ -1281,7 +1335,7 @@ static int m_can_chip_config(struct net_device *dev)
 	/* Disable unused interrupts */
 	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TEFW | IR_TFE |
 			IR_TCF | IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N |
-			IR_RF0F | IR_RF0W);
+			IR_RF0F);
 
 	m_can_config_endisable(cdev, true);
 
@@ -1325,6 +1379,7 @@ static int m_can_chip_config(struct net_device *dev)
 
 	/* rx fifo configuration, blocking mode, fifo size 1 */
 	m_can_write(cdev, M_CAN_RXF0C,
+		    FIELD_PREP(RXFC_FWM_MASK, cdev->rx_max_coalesced_frames_irq) |
 		    FIELD_PREP(RXFC_FS_MASK, cdev->mcfg[MRAM_RXF0].num) |
 		    cdev->mcfg[MRAM_RXF0].off);
 
@@ -1383,7 +1438,7 @@ static int m_can_chip_config(struct net_device *dev)
 		else
 			interrupts &= ~(IR_ERR_LEC_31X);
 	}
-	m_can_write(cdev, M_CAN_IE, interrupts);
+	m_can_interrupt_enable(cdev, interrupts);
 
 	/* route all interrupts to INT0 */
 	m_can_write(cdev, M_CAN_ILS, ILS_ALL_INT0);
@@ -2048,6 +2103,9 @@ int m_can_class_register(struct m_can_classdev *cdev)
 
 	of_can_transceiver(cdev->net);
 
+	hrtimer_init(&cdev->irq_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	cdev->irq_timer.function = m_can_irq_timer;
+
 	dev_info(cdev->dev, "%s device registered (irq=%d, version=%d)\n",
 		 KBUILD_MODNAME, cdev->net->irq, cdev->version);
 
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index a839dc71dc9b..c59099d3f5b9 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -84,6 +84,8 @@ struct m_can_classdev {
 	struct sk_buff *tx_skb;
 	struct phy *transceiver;
 
+	struct hrtimer irq_timer;
+
 	struct m_can_ops *ops;
 
 	int version;
@@ -92,6 +94,11 @@ struct m_can_classdev {
 	int pm_clock_support;
 	int is_peripheral;
 
+	// Cached M_CAN_IE register content
+	u32 active_interrupts;
+	u32 rx_max_coalesced_frames_irq;
+	u32 rx_coalesce_usecs_irq;
+
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 };
 
-- 
2.40.1

