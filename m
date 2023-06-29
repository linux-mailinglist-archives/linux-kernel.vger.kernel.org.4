Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DA1741DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjF2BnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjF2BnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:43:06 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79234A2;
        Wed, 28 Jun 2023 18:43:04 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-55b8f1c930eso107884eaf.3;
        Wed, 28 Jun 2023 18:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688002984; x=1690594984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQVTjdj6R0O33JrX4xkaOPdKxSIQjrzX3EEzQH2s0Vk=;
        b=pDKRiJJlgBe4sN/3o6EQ4K9yZzpGzSdILGCbYh8Wahba1JD6GZg9xrJXIKE8uf/m0V
         syrNcXnmM6QxZOFXwLLP9rua0hXLTYfI3I9RRNPKG0WtTfF10MYGN+FvrRAPuGqo+0Mp
         AUQssIg9pSb/0r5NMGrxKLVpW0CNnWbJ93gKFdvFoTW7ZCFR7yZ+5X9e0oxlD+lvg1/A
         xbTRDXGLR7thD/NoPgZOETtiHpNfwg2UTJasOGG9wVDU4r9A0YEHXkfobC+YcwegO4V/
         BKpi61OUOW/eRaZfiZvocW0BBS+M877/5WvNag3J7P2rsuRT/HNsK05DuR0PeszTbJXy
         ltMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688002984; x=1690594984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQVTjdj6R0O33JrX4xkaOPdKxSIQjrzX3EEzQH2s0Vk=;
        b=kVO0eakG+7Q6WRSCgpsN5+uNuqZIYcJje+3JW5GOQSyGPhZDfR63ndcTLIzJOCroay
         UJMUI4y1d3S6KBftUKdHuT1c9DPdwFmbylKeMKy4/ZjMypHf9LZZzeNyVHcbSfL+VfXP
         PSeMeRJeJSKjjA4/lIcMZpCkqy0ENOMtobTV5jSoEhlquEeIP3zCAgzFJE5XGJ3l80XG
         04VAJj7pUFDiMhJn0fetK6M1aAH9CLcReuenecfCpl91IRCjE98QcADT3KXevgcysuEz
         1+Oyka8I1inXerIXAJY9MPVoD7rhPWpRmRmsQquj3ay9GGPoo0lULsH5Il0gp5LhgS5C
         RNbQ==
X-Gm-Message-State: AC+VfDzuTc1mdcaubBRdym91jo2E+Emt+prOVCF4k5tbZtq2+9Rhp2ZU
        XW/hz/c23ACiicMfqnChelk=
X-Google-Smtp-Source: ACHHUZ6SRDH4l7iQxdbln7GcYeMzKcfDOXKin1gI7C/kNxF6648WRZ7CSVOC4XaL6RZHdly0u+DI0Q==
X-Received: by 2002:a05:6808:1691:b0:3a0:492f:b05f with SMTP id bb17-20020a056808169100b003a0492fb05fmr24378831oib.58.1688002983602;
        Wed, 28 Jun 2023 18:43:03 -0700 (PDT)
Received: from anyang.. ([106.250.177.234])
        by smtp.googlemail.com with ESMTPSA id m7-20020a17090a414700b00262d368b220sm7707123pjg.40.2023.06.28.18.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 18:43:03 -0700 (PDT)
From:   Dongjin Kim <tobetter@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: meson-g12b: reorder device aliases
Date:   Thu, 29 Jun 2023 10:42:52 +0900
Message-Id: <20230629014253.2007625-2-tobetter@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629014253.2007625-1-tobetter@gmail.com>
References: <20230629014253.2007625-1-tobetter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is simply to reoder the device aliases.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts          | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts            | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts         | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi   | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi       | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid.dtsi         | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi           | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 4fb31c2ba31c..1e98ca09af4e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -29,8 +29,8 @@ button-onoff {
 	};
 
 	aliases {
-		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		serial0 = &uart_AO;
 	};
 
 	mono_dac: audio-codec-0 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
index 4b5d11e56364..826a490fa3e6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
@@ -14,8 +14,8 @@ / {
 	model = "Amlogic Meson G12A U200 Development Board";
 
 	aliases {
-		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		serial0 = &uart_AO;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index b2bb94981838..ddaa51efb8dc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -15,8 +15,8 @@ / {
 	model = "Shenzhen Amediatech Technology Co., Ltd X96 Max";
 
 	aliases {
-		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		serial0 = &uart_AO;
 	};
 
 	spdif_dit: audio-codec-1 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
index 97e522921b06..b4a38b2eeaaf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
@@ -8,8 +8,8 @@
 
 / {
 	aliases {
-		serial0 = &uart_AO;
 		rtc1 = &vrtc;
+		serial0 = &uart_AO;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
index 83709787eb91..23c262ce16aa 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
@@ -12,9 +12,9 @@
 
 / {
 	aliases {
-		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
 		rtc1 = &vrtc;
+		serial0 = &uart_AO;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
index 29d642e746d4..4bcbda5df867 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
@@ -17,8 +17,8 @@ / {
 	model = "Hardkernel ODROID-GO-Ultra";
 
 	aliases {
-		serial0 = &uart_AO;
 		rtc0 = &vrtc;
+		serial0 = &uart_AO;
 	};
 
 	adc-joystick-left {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid.dtsi
index 9e12a34b2840..707c1c560d30 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid.dtsi
@@ -11,9 +11,9 @@
 
 / {
 	aliases {
-		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
 		rtc1 = &vrtc;
+		serial0 = &uart_AO;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
index b40d2c1002c9..a9b95f328620 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
@@ -14,8 +14,8 @@
 
 / {
 	aliases {
-		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		serial0 = &uart_AO;
 	};
 
 	chosen {
-- 
2.34.1

