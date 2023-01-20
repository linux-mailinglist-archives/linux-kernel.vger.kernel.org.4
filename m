Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2025675D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjATTC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjATTC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:02:26 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C12285347;
        Fri, 20 Jan 2023 11:02:25 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-15ebfdf69adso7366784fac.0;
        Fri, 20 Jan 2023 11:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML/rF7kF1SaTj4j5/ZJzUsj/h2DG3Q7mK3i99v+DSLQ=;
        b=L6wLACquDlqMxqvXkyh+Ok3t9fNKo8EDGsGK5N0sp5U65CgkNX5nwg3ArQWuFe8KjX
         AYCu3pzlL8Sx8cp1rKjZ6TvSVA7TgjpHgjARoSLwms+fAlSDZeAt0LK+dWkX36qmmJIG
         toXXKYmEwhML0FjDYgBi6ytc1hTLDpeHbHGJurcvR0+QEr9AfEU9285CnWndZVs5JQLC
         t4oQA5m9X21edc6y97jCZHd8euZm3tP4zs0a95+Nn941YisdXE25yryMrmfB+NxjmQB1
         pmWsuY8ehEt/mDkXl0kniRqASW5LnThmL82kehQKKLvdzygsTDF0g+cusYDWjVl0fZrB
         dnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ML/rF7kF1SaTj4j5/ZJzUsj/h2DG3Q7mK3i99v+DSLQ=;
        b=sBapNBbqrFTN5KaVhXMYtjYyfU0zCsPqbo6GT7Jm9L9t2p1n82GuFMZPFluWhhbUJn
         ho1eiz8Er8Byx7GyjTZePtLC4cYveywgAmZ/gP5AAju/20PRH2gvd3Rgwxl76Y9RAH9N
         El9e3ZBr2X6S8rGSiShYNGTAUUkbu/RPi4jdwTZMj4nPWBC2uxWKiq3qXxdRNLfGFOAG
         H4R0w1k+iLqRfPwOozufR5xpC3Tey5aQht4jmriMSrwoBAnA2Kd7hHNTwpP8R/IwqKTr
         6/lsZHDjiXsVCGC1D55Ti85K5MeLiAeOSAFz2D3IrsChoURudN/QHiqvD+u2kGwYsr2h
         EmIQ==
X-Gm-Message-State: AFqh2kqd2ANkafxtfGP1tj5vUVv2ugteLAHkLGUd6eQ63re6vjeWYgRy
        0o0jqEspAyszeZR4YisAz2I=
X-Google-Smtp-Source: AMrXdXsK3rb24IkcXVqFKHwUF49SEPlnN/5ksK/9sve7PrZGtMncS1IEl2kZYoWbgrc+oTCVV7/8sQ==
X-Received: by 2002:a05:6870:b0d:b0:15f:930a:5cd0 with SMTP id lh13-20020a0568700b0d00b0015f930a5cd0mr5300530oab.26.1674241344705;
        Fri, 20 Jan 2023 11:02:24 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y13-20020a37f60d000000b006fa2b1c3c1esm10379806qkj.58.2023.01.20.11.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:02:24 -0800 (PST)
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
Subject: [PATCH 1/6] rtc: brcmstb-waketimer: introduce WKTMR_ALARM_EVENT flag
Date:   Fri, 20 Jan 2023 11:01:42 -0800
Message-Id: <20230120190147.718976-2-opendmb@gmail.com>
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

This commit defines bit 0 as the bit of interest within the
BRCMSTB_WKTMR_EVENT register to make the implementation more
readable.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/rtc/rtc-brcmstb-waketimer.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
index c74130e8f496..fbeb8be6664b 100644
--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -34,6 +34,7 @@ struct brcmstb_waketmr {
 };
 
 #define BRCMSTB_WKTMR_EVENT		0x00
+#define  WKTMR_ALARM_EVENT		BIT(0)
 #define BRCMSTB_WKTMR_COUNTER		0x04
 #define BRCMSTB_WKTMR_ALARM		0x08
 #define BRCMSTB_WKTMR_PRESCALER		0x0C
@@ -41,9 +42,17 @@ struct brcmstb_waketmr {
 
 #define BRCMSTB_WKTMR_DEFAULT_FREQ	27000000
 
+static inline bool brcmstb_waketmr_is_pending(struct brcmstb_waketmr *timer)
+{
+	u32 reg;
+
+	reg = readl_relaxed(timer->base + BRCMSTB_WKTMR_EVENT);
+	return !!(reg & WKTMR_ALARM_EVENT);
+}
+
 static inline void brcmstb_waketmr_clear_alarm(struct brcmstb_waketmr *timer)
 {
-	writel_relaxed(1, timer->base + BRCMSTB_WKTMR_EVENT);
+	writel_relaxed(WKTMR_ALARM_EVENT, timer->base + BRCMSTB_WKTMR_EVENT);
 	(void)readl_relaxed(timer->base + BRCMSTB_WKTMR_EVENT);
 }
 
@@ -147,7 +156,6 @@ static int brcmstb_waketmr_getalarm(struct device *dev,
 {
 	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
 	time64_t sec;
-	u32 reg;
 
 	sec = readl_relaxed(timer->base + BRCMSTB_WKTMR_ALARM);
 	if (sec != 0) {
@@ -156,8 +164,7 @@ static int brcmstb_waketmr_getalarm(struct device *dev,
 		rtc_time64_to_tm(sec, &alarm->time);
 	}
 
-	reg = readl_relaxed(timer->base + BRCMSTB_WKTMR_EVENT);
-	alarm->pending = !!(reg & 1);
+	alarm->pending = brcmstb_waketmr_is_pending(timer);
 
 	return 0;
 }
-- 
2.25.1

