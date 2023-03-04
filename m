Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD3E6AA8CB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 09:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjCDIn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 03:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCDInq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 03:43:46 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A93014E90;
        Sat,  4 Mar 2023 00:43:45 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id y14so4660934ljq.4;
        Sat, 04 Mar 2023 00:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677919424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cvh0M4miY/BiqN/UdWftX82fG+Lj6GlwYOBUkwznvo=;
        b=m1ToztVg71sF//PDkJ4aaec1p1ekpe4vM1Qq33sQPo64MSs2jYzSiYQomfzKLk7BYl
         88hDn6JA/rRnl7AjHsK3civP46hb4J2M4x9k6b6nC9ZNnhM9zpzrKJoGGAC4f6yFk/mv
         gKC61jroGglFbpd4zsDvKr/q+1g1bGxHfjgOCkY3p2JeS3pmlp47SuUfQHQMxWW2QexG
         9Spf59og2Kmld3Ku5a7rrocR1uEVqp/uoYO1V0vjZ043I2Eud1GETiUrdjCT54+yfF6L
         rtHWEXgZZMirf+2atu9BTQN+ajZ8q5ZlqowRMICIOyjLCZnBSV+BArHypbCsWqxxuL9j
         JAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677919424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cvh0M4miY/BiqN/UdWftX82fG+Lj6GlwYOBUkwznvo=;
        b=zxGl9Nk4CKTrGcAKoZuHqxI2Gjs7tbM7kn/PI3iZI6mxIEyZ+Oh+AEPw/+xUEkJ8J1
         Fza1H+gXaLIZ4TBG6ZB8h4enJEM56My8XqbmHwo8+7bo5gE9LzPIIyRVL1dCZLvkpxZu
         vtzyeGz/Cb0hg4MVVr/VtCyHDTfQrAYAm5/1gKxjE2inlWnXboIhRh0vBUBeNBncLGb+
         P5YRx642I99iDG1HlOsy+st8SzmPMVSnFbM3vYSLsxuezbeIA58IZVc740se0q4AqQeH
         IlzUfHBuny+6Klq0QxMUkCsYxlQ+AGG8Kg0g+UY1uRj6nd3VIAB7fWuwVk7o84/GlyUw
         eK8w==
X-Gm-Message-State: AO0yUKWqq0DI+APQp+zaa00JIzMVNOQ2u+2meiDt8jCuRzc6AYJNa/+J
        PKLwwuyyminDkBizMk/9n2zLQPZQdo8=
X-Google-Smtp-Source: AK7set8/zLn/KQKDsTNXArki7yWZ4e/yRiyPsJZcALWB7N1eOVwB/wRHbJV6j1lNM/OzckIqnQYVWg==
X-Received: by 2002:a2e:9d51:0:b0:295:8a9b:d8d6 with SMTP id y17-20020a2e9d51000000b002958a9bd8d6mr1350936ljj.4.1677919423679;
        Sat, 04 Mar 2023 00:43:43 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id u5-20020a2ea165000000b00293cc5f83b4sm693575ljl.27.2023.03.04.00.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 00:43:43 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] ARM: tegra: transformer: use labels for mmc in aliases
Date:   Sat,  4 Mar 2023 10:43:17 +0200
Message-Id: <20230304084319.18424-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230304084319.18424-1-clamor95@gmail.com>
References: <20230304084319.18424-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since mmc devices in common dtsi are labeled let's use labels
for simpler comprehension of tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
index 08ea9cb32d0e..70f7f279fd35 100644
--- a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
@@ -12,9 +12,9 @@ / {
 	chassis-type = "convertible";
 
 	aliases {
-		mmc0 = "/mmc@78000600"; /* eMMC */
-		mmc1 = "/mmc@78000000"; /* uSD slot */
-		mmc2 = "/mmc@78000400"; /* WiFi */
+		mmc0 = &sdmmc4; /* eMMC */
+		mmc1 = &sdmmc1; /* uSD slot */
+		mmc2 = &sdmmc3; /* WiFi */
 
 		rtc0 = &pmic;
 		rtc1 = "/rtc@7000e000";
-- 
2.37.2

