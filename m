Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11FD6CD5E2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjC2JFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjC2JEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:04:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3C9109;
        Wed, 29 Mar 2023 02:04:35 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ew6so60308746edb.7;
        Wed, 29 Mar 2023 02:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680080674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Jvw7lCXM6klT4g7y4ectmTBzvvioBJrdjfCKfiCV2M=;
        b=mkn927X9y7hQT/e3mbUQodOELFdTFuo6a8aSvq040mCj8hzc1WlsbnfOIyHANqMRhh
         FVNcSvAmJH/c9C6MjynAPGPzQ3ZB+m/5fiWO8+91Ixq6S3aBhzO+UMdARBOVjhXiGtoy
         gWvnMv/NWam4OY/NndFelVNcA6Puh8sqRKcES3LVYeAp0iAPMV34QDZnx5JqpCFeqfeG
         hW7L3DY+sgqSl/0tBWD01iOo4lat77RFA+xTpDm2pdSw/EIXOy182KgeHy2CCkiU5RPY
         cHEzpWdVuhH9+IPblD+4LyISsCcjim3zYRD/s6/IBFnqEAFTA+ZPeOD5eS0/4A/A3vi6
         Sqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Jvw7lCXM6klT4g7y4ectmTBzvvioBJrdjfCKfiCV2M=;
        b=4IVpk57/XIxSuWBvbpML2HjdmNG79YnEy6er5b35Ia7fVhX0zxEGUkykGfmn5LoPA7
         Pkl/pxSVhnZFOoghtnfpPTM0jwp+O+dhU3CrCD0dQvVDZAcLQHhhtMWLMId/X7aFrSru
         +6D+VF5jHjwBuIR1U2I3rVEvnZYWhqJPHR+tMWqG8AlczuR4AdcNGGz5m9nq6KnWH/rQ
         XA2w4k4ZcjCDY4aEb3yrs4fqGAQrRnBFalFMjOaQNYfVPba+0GcAuWUyVsp2o5/8NJnG
         mc1PrQ6P/xKjV+/1cpoo7ZahflAzdgLhQnPY+k/uQyZWPlsNR5/BWF/jc1BKGDFOGgCq
         45Xg==
X-Gm-Message-State: AAQBX9e4EbdXldNJUZbsGB8M4UhrGT0qjr/gL5S3bizrT+WMT1AOudTt
        jKh7c2X0k9H1E233acDrk4s=
X-Google-Smtp-Source: AKy350aQCPq8bPYW984D+5+Jh+MLtGKQ/ZaHWaLmBqRqmERGETGj1WRzsR0wpE81UJJNsfRVfdRx6g==
X-Received: by 2002:a17:906:2b8e:b0:946:c022:8979 with SMTP id m14-20020a1709062b8e00b00946c0228979mr6248001ejg.21.1680080674212;
        Wed, 29 Mar 2023 02:04:34 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id n3-20020a170906088300b009327ed171f2sm15437127eje.129.2023.03.29.02.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:04:33 -0700 (PDT)
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
Subject: [PATCH v3 1/4] ARM: tegra: transformer: use labels for mmc in aliases
Date:   Wed, 29 Mar 2023 12:04:00 +0300
Message-Id: <20230329090403.5274-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230329090403.5274-1-clamor95@gmail.com>
References: <20230329090403.5274-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use phandle references for mmc instead of path in aliases.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/tegra114-asus-tf701t.dts           | 12 ++++++------
 .../boot/dts/tegra30-asus-transformer-common.dtsi    | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-asus-tf701t.dts b/arch/arm/boot/dts/tegra114-asus-tf701t.dts
index 84a3eb38e71d..3a420ac969ff 100644
--- a/arch/arm/boot/dts/tegra114-asus-tf701t.dts
+++ b/arch/arm/boot/dts/tegra114-asus-tf701t.dts
@@ -13,9 +13,9 @@ / {
 	chassis-type = "convertible";
 
 	aliases {
-		mmc0 = "/mmc@78000600"; /* eMMC */
-		mmc1 = "/mmc@78000400"; /* uSD slot */
-		mmc2 = "/mmc@78000000"; /* WiFi */
+		mmc0 = &sdmmc4; /* eMMC */
+		mmc1 = &sdmmc3; /* uSD slot */
+		mmc2 = &sdmmc1; /* WiFi */
 
 		rtc0 = &palmas;
 		rtc1 = "/rtc@7000e000";
@@ -605,12 +605,12 @@ i2s@70080300 {
 		};
 	};
 
-	mmc@78000000 {
+	sdmmc1: mmc@78000000 {
 		/* WiFi */
 	};
 
 	/* MicroSD card */
-	mmc@78000400 {
+	sdmmc3: mmc@78000400 {
 		status = "okay";
 
 		bus-width = <4>;
@@ -626,7 +626,7 @@ mmc@78000400 {
 		pinctrl-0 = <&sdmmc3_default>;
 	};
 
-	mmc@78000600 {
+	sdmmc4: mmc@78000600 {
 		/* eMMC */
 	};
 
diff --git a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
index 1861b2de2dc3..f32806f07989 100644
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
@@ -1388,7 +1388,7 @@ i2s@70080600 {		/* i2s3 */
 		};
 	};
 
-	mmc@78000000 {
+	sdmmc1: mmc@78000000 {
 		status = "okay";
 
 		/* FIXME: Full 208Mhz clock rate doesn't work reliably */
@@ -1401,7 +1401,7 @@ mmc@78000000 {
 		vqmmc-supply = <&vddio_usd>;	/* ldo3 */
 	};
 
-	mmc@78000400 {
+	sdmmc3: mmc@78000400 {
 		status = "okay";
 
 		#address-cells = <1>;
@@ -1431,7 +1431,7 @@ wifi@1 {
 		};
 	};
 
-	mmc@78000600 {
+	sdmmc4: mmc@78000600 {
 		status = "okay";
 		bus-width = <8>;
 		vmmc-supply = <&vcore_emmc>;
-- 
2.37.2

