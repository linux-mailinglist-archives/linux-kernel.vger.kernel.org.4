Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA7B7381D9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjFUJYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjFUJYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:24:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30601FC0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:24:00 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-312863a983fso785063f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339439; x=1689931439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8v5k5o/gMnpilWzbPmb6WUpQE5lj/WdytRr00JhzuWo=;
        b=1yoEyFt5GM967nuJr28zmMpjw2qA3oiqhf6CIy3w8pbT15KKygG3KPEktVrKijFGpv
         jj54cY3E0rWzM3U4xGlY+88q4YnZPTIXzO9K28Yqujd+Mvephs5uAKvnCjiKebdHpg9D
         Ptb0y2cm3Arhxo0rgUABNoe9Cn3qEWPmdIowVDiOLyzViuV3iM6/blucHS8zl0GOQKcn
         Q7Ja1geYPZE+/Axv0QnDiBNNPHUbvXeoxbGcZWJW1qyjdEAJqaCerkIScCpSZ12jQ4eI
         dxdb3Qz5o8wLtARdXWmd4OWlLWBIie+xGD1scLZ5DHtycSymIuO7m6h1iLzI3CcIWDrB
         4Uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339439; x=1689931439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8v5k5o/gMnpilWzbPmb6WUpQE5lj/WdytRr00JhzuWo=;
        b=Ts0s6WvTBp9xrfkvThhBu/KTaDtQIZXLfv9NRanN/Y3Zi2dHFANRvmEFEPkhInqEe9
         7mkd26LlrjLo/3F85FXZpuZSIbxQWSyZ/8aRJSUWDTMNtnFQMI9a2Y2py7BWfo7oQBOy
         CMRrIUdC/MtV/sqEBh2pfm5uq4uokR7drVDMA09pfDPOR0spYc7NORhLoJEC9JGoNkMH
         ip+vcN2/WvUBI71Om+QEfRbghe+wbGKdX9NXaueyI9pcsDXVyM2EMHw3F6BBV+fChgyQ
         CjlwCk5PLkdjIR4Af4Nl+vdzi4hxpSe5HSEDMcNomxN2l6QBPeQ/GhJCMAO3GODrfNnw
         PQaQ==
X-Gm-Message-State: AC+VfDy8jTiSvmQOftEnQPVBYWmnVI6Okxvhoj0ZnJ2K+juSRCIR7+nK
        7zixQL3s4GVIlI5pysNnt2yW4w==
X-Google-Smtp-Source: ACHHUZ4o2qzAHjJHwF5qlNPj90KrxHnrbA+4OWsUz/y8LumJsVxdyHo2OT7agpu/llRmxMyxikmQJQ==
X-Received: by 2002:adf:dcc3:0:b0:311:1946:fe7d with SMTP id x3-20020adfdcc3000000b003111946fe7dmr11672853wrm.53.1687339439115;
        Wed, 21 Jun 2023 02:23:59 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id i11-20020adffdcb000000b002fda1b12a0bsm4022115wrs.2.2023.06.21.02.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:23:58 -0700 (PDT)
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
Subject: [PATCH v4 03/12] can: m_can: Implement transmit coalescing
Date:   Wed, 21 Jun 2023 11:23:41 +0200
Message-Id: <20230621092350.3130866-4-msp@baylibre.com>
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

Extend the coalescing implementation for transmits.

In normal mode the chip raises an interrupt for every finished transmit.
This implementation switches to coalescing mode as soon as an interrupt
handled a transmit. For coalescing the watermark level interrupt is used
to interrupt exactly after x frames were sent. It switches back into
normal mode once there was an interrupt with no finished transmit and
the timer being inactive.

The timer is shared with receive coalescing. The time for receive and
transmit coalescing timers have to be the same for that to work. The
benefit is to have only a single running timer.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 33 ++++++++++++++++++++-------------
 drivers/net/can/m_can/m_can.h |  3 +++
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 02dfb416fbd2..781f287e7ce4 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -255,6 +255,7 @@ enum m_can_reg {
 #define TXESC_TBDS_64B		0x7
 
 /* Tx Event FIFO Configuration (TXEFC) */
+#define TXEFC_EFWM_MASK		GENMASK(29, 24)
 #define TXEFC_EFS_MASK		GENMASK(21, 16)
 
 /* Tx Event FIFO Status (TXEFS) */
@@ -429,7 +430,7 @@ static void m_can_interrupt_enable(struct m_can_classdev *cdev, u32 interrupts)
 
 static void m_can_coalescing_disable(struct m_can_classdev *cdev)
 {
-	u32 new_interrupts = cdev->active_interrupts | IR_RF0N;
+	u32 new_interrupts = cdev->active_interrupts | IR_RF0N | IR_TEFN;
 
 	hrtimer_cancel(&cdev->irq_timer);
 	m_can_interrupt_enable(cdev, new_interrupts);
@@ -1096,21 +1097,26 @@ static int m_can_echo_tx_event(struct net_device *dev)
 static void m_can_coalescing_update(struct m_can_classdev *cdev, u32 ir)
 {
 	u32 new_interrupts = cdev->active_interrupts;
-	bool enable_timer = false;
+	bool enable_rx_timer = false;
+	bool enable_tx_timer = false;
 
 	if (cdev->rx_coalesce_usecs_irq > 0 && (ir & (IR_RF0N | IR_RF0W))) {
-		enable_timer = true;
+		enable_rx_timer = true;
 		new_interrupts &= ~IR_RF0N;
-	} else if (!hrtimer_active(&cdev->irq_timer)) {
-		new_interrupts |= IR_RF0N;
 	}
+	if (cdev->tx_coalesce_usecs_irq > 0 && (ir & (IR_TEFN | IR_TEFW))) {
+		enable_tx_timer = true;
+		new_interrupts &= ~IR_TEFN;
+	}
+	if (!enable_rx_timer && !hrtimer_active(&cdev->irq_timer))
+		new_interrupts |= IR_RF0N;
+	if (!enable_tx_timer && !hrtimer_active(&cdev->irq_timer))
+		new_interrupts |= IR_TEFN;
 
 	m_can_interrupt_enable(cdev, new_interrupts);
-	if (enable_timer) {
-		hrtimer_start(&cdev->irq_timer,
-			      ns_to_ktime(cdev->rx_coalesce_usecs_irq * NSEC_PER_USEC),
+	if (enable_rx_timer | enable_tx_timer)
+		hrtimer_start(&cdev->irq_timer, cdev->irq_timer_wait,
 			      HRTIMER_MODE_REL);
-	}
 }
 
 static irqreturn_t m_can_isr(int irq, void *dev_id)
@@ -1165,7 +1171,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 			netif_wake_queue(dev);
 		}
 	} else  {
-		if (ir & IR_TEFN) {
+		if (ir & (IR_TEFN | IR_TEFW)) {
 			/* New TX FIFO Element arrived */
 			if (m_can_echo_tx_event(dev) != 0)
 				goto out_fail;
@@ -1333,9 +1339,8 @@ static int m_can_chip_config(struct net_device *dev)
 	}
 
 	/* Disable unused interrupts */
-	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TEFW | IR_TFE |
-			IR_TCF | IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N |
-			IR_RF0F);
+	interrupts &= ~(IR_ARA | IR_ELO | IR_DRX | IR_TEFF | IR_TFE | IR_TCF |
+			IR_HPM | IR_RF1F | IR_RF1W | IR_RF1N | IR_RF0F);
 
 	m_can_config_endisable(cdev, true);
 
@@ -1372,6 +1377,8 @@ static int m_can_chip_config(struct net_device *dev)
 	} else {
 		/* Full TX Event FIFO is used */
 		m_can_write(cdev, M_CAN_TXEFC,
+			    FIELD_PREP(TXEFC_EFWM_MASK,
+				       cdev->tx_max_coalesced_frames_irq) |
 			    FIELD_PREP(TXEFC_EFS_MASK,
 				       cdev->mcfg[MRAM_TXE].num) |
 			    cdev->mcfg[MRAM_TXE].off);
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index c59099d3f5b9..d0c21eddb6ec 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -85,6 +85,7 @@ struct m_can_classdev {
 	struct phy *transceiver;
 
 	struct hrtimer irq_timer;
+	ktime_t irq_timer_wait;
 
 	struct m_can_ops *ops;
 
@@ -98,6 +99,8 @@ struct m_can_classdev {
 	u32 active_interrupts;
 	u32 rx_max_coalesced_frames_irq;
 	u32 rx_coalesce_usecs_irq;
+	u32 tx_max_coalesced_frames_irq;
+	u32 tx_coalesce_usecs_irq;
 
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 };
-- 
2.40.1

