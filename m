Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEA7675D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjATTCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjATTC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:02:28 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B74C4E8A;
        Fri, 20 Jan 2023 11:02:27 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id p12so3160637ilq.10;
        Fri, 20 Jan 2023 11:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PT42Zl2MuPs/Wu9jh4sQMK4BVAdg3CNaxRS3csl2Gmk=;
        b=YgMU1Tm/SWN5kuzg9KE0Cq1L9BqLdj77L+ImuL3FdAEO30CVMjJzhspc7fXWo45AOw
         fBcRb0NkdP9N3aY+rceOTA7NNYEzQimVr2aq4Nw3ram5kpP0Gs9YNTZnO53nc6VpEmXd
         Imue2WitnqlW/k6aNpZe0+rU1oesQiKsfdIMrGIf+JvdE4UC4A25Jgndwscx57+MK2iL
         Aw26dwMqQu/IWcQDok3S8jzIWw+bEknjwhBMIMliCBF2uSJDrarjlKj568SFleWZJ3Um
         +CKC6EjY0GIs403gJqLiZESoCFY7h7VBwt5KvYAbhH3Hn/54Zr0yhi+j4fVsV7Gi3V//
         edTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PT42Zl2MuPs/Wu9jh4sQMK4BVAdg3CNaxRS3csl2Gmk=;
        b=YOcNjivh2cPE2gJlc5fU5lI2vNHdfoGDu7C+hBm1yo7JU1e5mIuuu4krc1vZHRPCow
         cn86mq+UPR0F3HVwAsSOZPOQaXxbfVNCJL2dvCy+vKZfNVMRxGhZgf8aGqnTRLp5mhma
         97c3KxA8R72gr2aPmuDNglBXxzRo8KrQywCFRoOG5quE2EWim3ldb18GlJfDw1AXZcHb
         v/4akpXYVRVcoz/FFYp5lf4e8xxLLFWT9vy5yra8WVhRW2IovOtHdOC5a/kOKHbgbuF0
         8YE2RLUV/IUvZbL0zIAwOreiuzkjSpwu6oRxqOMKEPyqBejX20cfbySsa72zRVKddJRh
         6J6w==
X-Gm-Message-State: AFqh2kpvzrK2xXaN/xCeiqqLPMWt32el846SvVCe8zWmo2lWlGSFW8cP
        klmJi9EOMJ80/KDEFkSyh/c=
X-Google-Smtp-Source: AMrXdXvZu4EKcElFlDs9p4MYW7HJf6M/QTeoUR8FTyxRiUnhim6OBaeJFtX0+Tx5ki+8TU0bfImN6Q==
X-Received: by 2002:a05:6e02:1ba2:b0:30f:63f0:b215 with SMTP id n2-20020a056e021ba200b0030f63f0b215mr854272ili.26.1674241346839;
        Fri, 20 Jan 2023 11:02:26 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y13-20020a37f60d000000b006fa2b1c3c1esm10379806qkj.58.2023.01.20.11.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:02:26 -0800 (PST)
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
Subject: [PATCH 2/6] rtc: brcmstb-waketimer: non-functional code changes
Date:   Fri, 20 Jan 2023 11:01:43 -0800
Message-Id: <20230120190147.718976-3-opendmb@gmail.com>
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

These changes are not intended to affect functionality, but
simplify the source code. They are performed here to simplify
review and reduce confusion with other changes in this set.

Since set_alarm includes the alarm_irq_enable functionality call
it directly from that function for simplicity (even though it
does nothing at the moment). The order of the declarations is
changed to prevent the need for a prototype.

The function device_init_wakeup() is used to replace the
functions device_set_wakeup_capable() and device_wakeup_enable()
since it is equivalent.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/rtc/rtc-brcmstb-waketimer.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
index fbeb8be6664b..582c23793550 100644
--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -169,6 +169,16 @@ static int brcmstb_waketmr_getalarm(struct device *dev,
 	return 0;
 }
 
+/*
+ * Does not do much but keep the RTC class happy. We always support
+ * alarms.
+ */
+static int brcmstb_waketmr_alarm_enable(struct device *dev,
+					unsigned int enabled)
+{
+	return 0;
+}
+
 static int brcmstb_waketmr_setalarm(struct device *dev,
 				     struct rtc_wkalrm *alarm)
 {
@@ -182,17 +192,7 @@ static int brcmstb_waketmr_setalarm(struct device *dev,
 
 	brcmstb_waketmr_set_alarm(timer, sec);
 
-	return 0;
-}
-
-/*
- * Does not do much but keep the RTC class happy. We always support
- * alarms.
- */
-static int brcmstb_waketmr_alarm_enable(struct device *dev,
-					unsigned int enabled)
-{
-	return 0;
+	return brcmstb_waketmr_alarm_enable(dev, alarm->enabled);
 }
 
 static const struct rtc_class_ops brcmstb_waketmr_ops = {
@@ -228,8 +228,7 @@ static int brcmstb_waketmr_probe(struct platform_device *pdev)
 	 * Set wakeup capability before requesting wakeup interrupt, so we can
 	 * process boot-time "wakeups" (e.g., from S5 soft-off)
 	 */
-	device_set_wakeup_capable(dev, true);
-	device_wakeup_enable(dev);
+	device_init_wakeup(dev, true);
 
 	timer->irq = platform_get_irq(pdev, 0);
 	if (timer->irq < 0)
-- 
2.25.1

