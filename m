Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A829675D5A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjATTCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjATTCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:02:42 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F8B3A88;
        Fri, 20 Jan 2023 11:02:35 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id i1so3161030ilu.8;
        Fri, 20 Jan 2023 11:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqkC6sovxRXM6xizruGfWT9Cuv1q7uo8QTDLi10Fn4g=;
        b=EKuaVn9G3pyj6UJjR4KsvEGeAKeMW/ybk5bDiRItK543Wilx6Jfd7+C6b2FRBQOjaX
         XBucpToQF7YKAbHpfvWaRfkUyIy9PYC6mDdD/oo24Z3uLTRohw8SZ/Pysy9V0JIdtv97
         hbLKehRGToyuPqdDqIZbFvlpJYEZNsqMkKCYWrLwwZgEfg0aJ7iRAGLWx4ThVSczPTE9
         CmN9LSgn34DRhElpbkwKzf3PSE2eQ8MtJxdvsesqaRzo4jry5rlCxm1K6HFQ8jWeO3kT
         MKI7c/CQR4yUMBdIeUP5H4lhcXicAji0+7Z5K63tO+X7zINQrNm2XF0RPOfmX52zNnCf
         aOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqkC6sovxRXM6xizruGfWT9Cuv1q7uo8QTDLi10Fn4g=;
        b=8Cb9gQN1D3Q1ieMQeOTRU2cg5UpyZRC0aoNEmJhcu7OXrmPK61ml4umgZA/Hwhb4l/
         xAxsIRaeR3bDFTXSgDJDVkwr3tlYeP2KDPswiIMe8j3qADHrPb6k4X2TkcJabiQvr5Vp
         ZGvF2uV5UlTxTNDuV8UjpuEz3fKW0rnzEaS178WHk/hSJFIYzlrHQKyllzGv6rc8Yi+n
         j+W53pthcmIr+t2Mokbo/JtoL6Fua2LLbPVB6tcb361SG9RLwBG4W9+zFvdS8lrurR/1
         ZrJDgwxLQLG/KzGXcrIhY+3/0Zjle6RDMT5GrCHDJUCJyAB2CKFAjB3yjLzzJH9iQpFh
         3wKw==
X-Gm-Message-State: AFqh2krS1t9UnFfoE+Zvn+EcV9WTOCqrFHnLsOxootXPN+aZTKE3lxHN
        +6eH5PHeT0EjPmqDKS2KCaQ=
X-Google-Smtp-Source: AMrXdXv5kk+vvblkJlrYDYP1ADRamyDuD/SOH21v7YiPKQRb/vaNuluVKYKQO50+vfcGSLMBXncyoA==
X-Received: by 2002:a05:6e02:1562:b0:30f:3736:25ab with SMTP id k2-20020a056e02156200b0030f373625abmr8463918ilu.28.1674241355300;
        Fri, 20 Jan 2023 11:02:35 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y13-20020a37f60d000000b006fa2b1c3c1esm10379806qkj.58.2023.01.20.11.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:02:34 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH 6/6] rtc: brcmstb-waketimer: allow use as non-wake alarm
Date:   Fri, 20 Jan 2023 11:01:47 -0800
Message-Id: <20230120190147.718976-7-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230120190147.718976-1-opendmb@gmail.com>
References: <20230120190147.718976-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wake interrupt only fires when the system is in a suspend
state. Fortunately we have another interrupt that fires in a
non-suspend state at the L2 controller UPG_AUX_AON. Add support
for this interrupt line so we can use the alarm in a non-wake
context.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/rtc/rtc-brcmstb-waketimer.c | 55 +++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
index e25f9fcd6ed1..1efa81cecc27 100644
--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -28,6 +28,7 @@ struct brcmstb_waketmr {
 	struct device *dev;
 	void __iomem *base;
 	unsigned int wake_irq;
+	unsigned int alarm_irq;
 	struct notifier_block reboot_notifier;
 	struct clk *clk;
 	u32 rate;
@@ -56,6 +57,8 @@ static inline void brcmstb_waketmr_clear_alarm(struct brcmstb_waketmr *timer)
 {
 	u32 reg;
 
+	if (timer->alarm_en && timer->alarm_irq)
+		disable_irq(timer->alarm_irq);
 	timer->alarm_en = false;
 	reg = readl_relaxed(timer->base + BRCMSTB_WKTMR_COUNTER);
 	writel_relaxed(reg - 1, timer->base + BRCMSTB_WKTMR_ALARM);
@@ -88,7 +91,25 @@ static irqreturn_t brcmstb_waketmr_irq(int irq, void *data)
 {
 	struct brcmstb_waketmr *timer = data;
 
-	pm_wakeup_event(timer->dev, 0);
+	if (!timer->alarm_irq)
+		pm_wakeup_event(timer->dev, 0);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t brcmstb_alarm_irq(int irq, void *data)
+{
+	struct brcmstb_waketmr *timer = data;
+
+	/* Ignore spurious interrupts */
+	if (!brcmstb_waketmr_is_pending(timer))
+		return IRQ_HANDLED;
+
+	if (timer->alarm_en) {
+		if (!device_may_wakeup(timer->dev))
+			writel_relaxed(WKTMR_ALARM_EVENT,
+				       timer->base + BRCMSTB_WKTMR_EVENT);
+		rtc_update_irq(timer->rtc, 1, RTC_IRQF | RTC_AF);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -114,7 +135,7 @@ static void wktmr_read(struct brcmstb_waketmr *timer,
 static int brcmstb_waketmr_prepare_suspend(struct brcmstb_waketmr *timer)
 {
 	struct device *dev = timer->dev;
-	int ret = 0;
+	int ret;
 
 	if (device_may_wakeup(dev)) {
 		ret = enable_irq_wake(timer->wake_irq);
@@ -122,9 +143,17 @@ static int brcmstb_waketmr_prepare_suspend(struct brcmstb_waketmr *timer)
 			dev_err(dev, "failed to enable wake-up interrupt\n");
 			return ret;
 		}
+		if (timer->alarm_en && timer->alarm_irq) {
+			ret = enable_irq_wake(timer->alarm_irq);
+			if (ret) {
+				dev_err(dev, "failed to enable rtc interrupt\n");
+				disable_irq_wake(timer->wake_irq);
+				return ret;
+			}
+		}
 	}
 
-	return ret;
+	return 0;
 }
 
 /* If enabled as a wakeup-source, arm the timer when powering off */
@@ -192,7 +221,11 @@ static int brcmstb_waketmr_alarm_enable(struct device *dev,
 		    !brcmstb_waketmr_is_pending(timer))
 			return -EINVAL;
 		timer->alarm_en = true;
+		if (timer->alarm_irq)
+			enable_irq(timer->alarm_irq);
 	} else if (!enabled && timer->alarm_en) {
+		if (timer->alarm_irq)
+			disable_irq(timer->alarm_irq);
 		timer->alarm_en = false;
 	}
 
@@ -269,6 +302,19 @@ static int brcmstb_waketmr_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_clk;
 
+	brcmstb_waketmr_clear_alarm(timer);
+
+	/* Attempt to initialize non-wake irq */
+	ret = platform_get_irq(pdev, 1);
+	if (ret > 0) {
+		timer->alarm_irq = (unsigned int)ret;
+		ret = devm_request_irq(dev, timer->alarm_irq, brcmstb_alarm_irq,
+				       IRQF_NO_AUTOEN, "brcmstb-waketimer-rtc",
+				       timer);
+		if (ret < 0)
+			timer->alarm_irq = 0;
+	}
+
 	timer->reboot_notifier.notifier_call = brcmstb_waketmr_reboot;
 	register_reboot_notifier(&timer->reboot_notifier);
 
@@ -317,6 +363,8 @@ static int brcmstb_waketmr_resume(struct device *dev)
 		return 0;
 
 	ret = disable_irq_wake(timer->wake_irq);
+	if (timer->alarm_en && timer->alarm_irq)
+		disable_irq_wake(timer->alarm_irq);
 
 	brcmstb_waketmr_clear_alarm(timer);
 
@@ -346,4 +394,5 @@ module_platform_driver(brcmstb_waketmr_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Brian Norris");
 MODULE_AUTHOR("Markus Mayer");
+MODULE_AUTHOR("Doug Berger");
 MODULE_DESCRIPTION("Wake-up timer driver for STB chips");
-- 
2.25.1

