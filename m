Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADCA67A3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjAXUPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjAXUOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:14:55 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AF31E5C6;
        Tue, 24 Jan 2023 12:14:54 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so19817656pjg.4;
        Tue, 24 Jan 2023 12:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEtY5LynS2vkRPJ1R/kvYmV9SRofdb2LH2C1cStAz2M=;
        b=YLqMn6DXAHVh1XoLozY4AjSZ2agwCfvhkAMhaBbQlDjZBccFd5CgQll9zu3+eXv+T3
         lut752J6pdicDNwtPw0D/+VEKasV0TNfcTCgXpPB0+JjUkK9ObZ5KeUXHB4eBdiCgMkS
         rAsMHZUlC4kZpqXMwZFqItpHxhcsPA2Noz9zjHKcdCT3BueUIdmHnnQRZNxkxJqrQKcx
         73PR4NrdkovewfZ3usoqswNOzbAYl+8khJh3bxc7hzSMHjXLOYeeH6BYtu/OA+CUrS4O
         3PzgLegGlYVKJyk9LsJVomZ987ObpTgG9tGRWdgemBqxaQ6xBdhniwDIeH/nvK/6pAuE
         rP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEtY5LynS2vkRPJ1R/kvYmV9SRofdb2LH2C1cStAz2M=;
        b=Vg6VeW8lC4EhbhXBwPmcsYfSihSdRr5etMv1R1Fyy3+FwHd9TrqUeEXjA2b5uKTL0A
         ZgJt2RpaCo8EQlf5bRdh/0z8aUddKnYgaMCeo3E+ptDrrxhIzJw8+SVYNwsn47teRwxy
         1cYLrXZqlkIhPdTBmGFxJTEZgM7gawbtvVMQgmkDIWo68m7atE80cW6P9DGLKPgCw5iO
         hQLQwrvNBUDXBP2YAP1UslpvvCJVPoZJWxZ+R7OHZQbo85l3QX8al4ct5SGI9dJ998BP
         Cr2dWEhaKn87FZJf7roPL4+jmjAJuJNJy9zV5xcaQRNll7V8s49gULsNRZyYm/IiPfcn
         81RA==
X-Gm-Message-State: AO0yUKWKASRiHYug93PVla9D+aozZGyRUfiDcxc1KLw04qrAPcYn3ALs
        q0O7Wg2rKdbXgezTmgSLFpk=
X-Google-Smtp-Source: AK7set/SVm0TL+nwZtkO3KuT5ojyygCFXTfAneUC4EiVvIR5DnLMNpB8e+WyXau6/07/j3+AxU1FYg==
X-Received: by 2002:a05:6a20:6985:b0:bb:a0a2:c37a with SMTP id t5-20020a056a20698500b000bba0a2c37amr4187151pzk.33.1674591293717;
        Tue, 24 Jan 2023 12:14:53 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902728d00b00174f61a7d09sm2057824pll.247.2023.01.24.12.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:14:53 -0800 (PST)
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
Subject: [PATCH v2 2/2] rtc: brcmstb-waketimer: allow use as non-wake alarm
Date:   Tue, 24 Jan 2023 12:14:30 -0800
Message-Id: <20230124201430.2502371-3-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230124201430.2502371-1-opendmb@gmail.com>
References: <20230124201430.2502371-1-opendmb@gmail.com>
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
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
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

