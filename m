Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FB2675D51
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjATTCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjATTCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:02:30 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB46385347;
        Fri, 20 Jan 2023 11:02:29 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id h15so2874824ilh.4;
        Fri, 20 Jan 2023 11:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rhB+jCWXlDHeyaWPTfhoKZG0YZcAyGqC3yxhLv7U6w=;
        b=lknvwgacWgowNZLC4XECbtZKNlv6HqjFRHYejN+rgvjaZ5WNBGQWmWzQGZ+QtDTGRk
         Ca/IdGy/Fp/yIQEIdXDjKJas19zHXmPUiJgkKEyInmq/R1f/nIo/PkFD1Lwa0AG9NNTd
         b1jjB77CEuqFd5Z47Rn1DLAuM2pzQ71u/gUwp1bhMiRdLAcWPnNS/NMNBQnEhOtmLsPC
         2p5Pg0OMGn4IewYGDV9wTo8Sk5SkX02wnx3TlsEkIuEFcSuD2IsTdwI9kXUkq7zWXMq8
         +ccujkOLxcCK6C8lVneugYs6LpdYvkYuXnazLtwvjRG3osyWhJ6FbpndCJlfIup/+bVy
         h0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rhB+jCWXlDHeyaWPTfhoKZG0YZcAyGqC3yxhLv7U6w=;
        b=zA1BYhjYEKBkxMVit2LHGAbxgoNmU0HF7PB16yMo8CDr/2Rjnl55HmoO7SHc2TLmBY
         9DJjS5bgwtrzeaOeyGzWghPwIX3M9kzDXS7u3dw8MCJcD/TDY2A9m9URB+ntU8ozK0lr
         dApX2aDjkhn1zd4Y3OX+BF8jcxdpXnOIKodSRb4sX3CuLWOZOf6tIJb/iXqk3PIXQSJU
         7zMzCXcL3rogkAkNoDYyOGMH+XHOciiVLlDdk/7MM6qp0nJqmU/L6K6O174TnzUAYahe
         282cs/25Ht05iqo80hIvIi0V4i6KThqtuObr7lLYpJMPKtLsh+Qh3BnN9wDzClaYu6UG
         HVjw==
X-Gm-Message-State: AFqh2krOzW+02X/NSBuQ62MvQ6k+Bi6wJN/8HFPvGyZxnA2KvEkZcGdh
        C3HYM5SMfryptpn8EkZYqH4=
X-Google-Smtp-Source: AMrXdXv80xjIQ0RsNbyGUUz57F77A94w0EL9s2R0Rrmto+KRjhEpamBGGAuY5ReJGlNNSVACcPF0Ow==
X-Received: by 2002:a05:6e02:6cc:b0:30c:4846:57c3 with SMTP id p12-20020a056e0206cc00b0030c484657c3mr12050911ils.4.1674241348972;
        Fri, 20 Jan 2023 11:02:28 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y13-20020a37f60d000000b006fa2b1c3c1esm10379806qkj.58.2023.01.20.11.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:02:28 -0800 (PST)
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
Subject: [PATCH 3/6] rtc: brcmstb-waketimer: compensate for lack of wktmr disable
Date:   Fri, 20 Jan 2023 11:01:44 -0800
Message-Id: <20230120190147.718976-4-opendmb@gmail.com>
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

Since the WKTMR hardware block cannot be disabled it is necessary
for the driver to accommodate for associated timing hazards. This
commit targets the following possibilities:

A possible race between clearing a wktmr event and the alarm expiring
is made one-sided by setting the alarm to its maximum value before
clearing the event.

Programming alarm values close to the current time may not trigger
events if the counter advances while the alarm is being programmed.
After programming an alarm, a check is made to ensure that it is
either in the future or an expiration event is pending.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/rtc/rtc-brcmstb-waketimer.c | 52 +++++++++++++++++++----------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
index 582c23793550..c791e92532b8 100644
--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -31,6 +31,8 @@ struct brcmstb_waketmr {
 	struct notifier_block reboot_notifier;
 	struct clk *clk;
 	u32 rate;
+	unsigned long rtc_alarm;
+	bool alarm_en;
 };
 
 #define BRCMSTB_WKTMR_EVENT		0x00
@@ -52,6 +54,11 @@ static inline bool brcmstb_waketmr_is_pending(struct brcmstb_waketmr *timer)
 
 static inline void brcmstb_waketmr_clear_alarm(struct brcmstb_waketmr *timer)
 {
+	u32 reg;
+
+	timer->alarm_en = false;
+	reg = readl_relaxed(timer->base + BRCMSTB_WKTMR_COUNTER);
+	writel_relaxed(reg - 1, timer->base + BRCMSTB_WKTMR_ALARM);
 	writel_relaxed(WKTMR_ALARM_EVENT, timer->base + BRCMSTB_WKTMR_EVENT);
 	(void)readl_relaxed(timer->base + BRCMSTB_WKTMR_EVENT);
 }
@@ -59,12 +66,22 @@ static inline void brcmstb_waketmr_clear_alarm(struct brcmstb_waketmr *timer)
 static void brcmstb_waketmr_set_alarm(struct brcmstb_waketmr *timer,
 				      unsigned int secs)
 {
+	unsigned int now;
+
 	brcmstb_waketmr_clear_alarm(timer);
 
 	/* Make sure we are actually counting in seconds */
 	writel_relaxed(timer->rate, timer->base + BRCMSTB_WKTMR_PRESCALER);
 
-	writel_relaxed(secs + 1, timer->base + BRCMSTB_WKTMR_ALARM);
+	writel_relaxed(secs, timer->base + BRCMSTB_WKTMR_ALARM);
+	now = readl_relaxed(timer->base + BRCMSTB_WKTMR_COUNTER);
+
+	while ((int)(secs - now) <= 0 &&
+		!brcmstb_waketmr_is_pending(timer)) {
+		secs = now + 1;
+		writel_relaxed(secs, timer->base + BRCMSTB_WKTMR_ALARM);
+		now = readl_relaxed(timer->base + BRCMSTB_WKTMR_COUNTER);
+	}
 }
 
 static irqreturn_t brcmstb_waketmr_irq(int irq, void *data)
@@ -155,27 +172,30 @@ static int brcmstb_waketmr_getalarm(struct device *dev,
 				    struct rtc_wkalrm *alarm)
 {
 	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
-	time64_t sec;
 
-	sec = readl_relaxed(timer->base + BRCMSTB_WKTMR_ALARM);
-	if (sec != 0) {
-		/* Alarm is enabled */
-		alarm->enabled = 1;
-		rtc_time64_to_tm(sec, &alarm->time);
-	}
+	alarm->enabled = timer->alarm_en;
+	rtc_time64_to_tm(timer->rtc_alarm, &alarm->time);
 
 	alarm->pending = brcmstb_waketmr_is_pending(timer);
 
 	return 0;
 }
 
-/*
- * Does not do much but keep the RTC class happy. We always support
- * alarms.
- */
 static int brcmstb_waketmr_alarm_enable(struct device *dev,
 					unsigned int enabled)
 {
+	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
+
+	if (enabled && !timer->alarm_en) {
+		if ((int)(readl_relaxed(timer->base + BRCMSTB_WKTMR_COUNTER) -
+		    readl_relaxed(timer->base + BRCMSTB_WKTMR_ALARM)) >= 0 &&
+		    !brcmstb_waketmr_is_pending(timer))
+			return -EINVAL;
+		timer->alarm_en = true;
+	} else if (!enabled && timer->alarm_en) {
+		timer->alarm_en = false;
+	}
+
 	return 0;
 }
 
@@ -183,14 +203,10 @@ static int brcmstb_waketmr_setalarm(struct device *dev,
 				     struct rtc_wkalrm *alarm)
 {
 	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
-	time64_t sec;
 
-	if (alarm->enabled)
-		sec = rtc_tm_to_time64(&alarm->time);
-	else
-		sec = 0;
+	timer->rtc_alarm = rtc_tm_to_time64(&alarm->time);
 
-	brcmstb_waketmr_set_alarm(timer, sec);
+	brcmstb_waketmr_set_alarm(timer, timer->rtc_alarm);
 
 	return brcmstb_waketmr_alarm_enable(dev, alarm->enabled);
 }
-- 
2.25.1

