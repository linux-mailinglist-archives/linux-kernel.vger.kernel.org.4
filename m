Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E3B638C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiKYOnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiKYOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:43:17 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669415F6E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:42:30 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id n1so718485ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiERiOsZ4pVEaAqxAKBXwDZJaGfW7dFNKPlpwpIDqWA=;
        b=NRXLpMwW7X9DK+NL98jXMWu8i24bUL/OAjkShRBO1hf5rmp2FTSC70C9QbYPqo/cmQ
         nLEamcI/Ybwwafni5M6eQ/MDEwfz9ZkENHE+mJ9sLIsB8g8TnPXJwWPMWtrUYdZHcSKr
         kPlC/SXUtjt9lwgHr3B2rsIjWCX7mYS9Og5MSu5UtiRcub97cq7B1zxa2Pg6MNq8k5/e
         MHbgQlDHt8IMwcP0zfgmBrPhI0HX64HhQ+U43V1zwAGuKC2biL+pOHr2D1E67wmg7lG7
         D6cAMb1859O2OCdi0+QQKMBmj8vLeUuac8O7pAKOU6YqoQUUxBBdWLme8AqxwZWHjKfq
         iBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiERiOsZ4pVEaAqxAKBXwDZJaGfW7dFNKPlpwpIDqWA=;
        b=PiWAmiQVMQ0H2YgxxYNGtt3yfacQtrWLT9K+yQ1YHEqyG115++fDHsphT/Xz+uY29V
         j4JOiQNPskoo2tHHeiJ9oWBdawVoYEzPUyGXtuvAku6RNYS+e1tZotYhesjdhmF2n3jm
         QdVXWlkjPLdCeHoWvjCT9T4KiDBln6F6Ifcmcs9gftQEFJvxoh4tJ9PiBV32kFa41t0P
         gmJwhXZ0Yr9VByU0I0TSnT/6w4/8h2yLRBMDKq7/Fxahrh0pGEPUAPj6o3a1vcIuIc/A
         taEGP3E0Wq78R7pio8ax5gHBZp4EVar3vDYKtFonVs+GngcpOXnXH0uKLWKHXUMPkKbR
         PEtA==
X-Gm-Message-State: ANoB5pmDe8D/8Aj4Or7zkEkxtV+4qPPkreqYVwcAByRio4kndtGYZ9hz
        hoXWSuv8N/6QlL5qMn62xig56A==
X-Google-Smtp-Source: AA0mqf6c+z+D2O8d9XEc/lMtf7v2HqAYkr2/MDgd58qjhLl8mcUsACgMTyfC47DJKBxbT1iucs6SwA==
X-Received: by 2002:a2e:a884:0:b0:277:37a8:ba87 with SMTP id m4-20020a2ea884000000b0027737a8ba87mr6895845ljq.14.1669387348750;
        Fri, 25 Nov 2022 06:42:28 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c3-20020a056512074300b004aa0870b5e5sm548322lfs.147.2022.11.25.06.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:42:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] ARM: dts: vf610: align LED node names with dtschema
Date:   Fri, 25 Nov 2022 15:42:23 +0100
Message-Id: <20221125144223.477376-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221125144223.477376-1-krzysztof.kozlowski@linaro.org>
References: <20221125144223.477376-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and DT schema expects certain pattern.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/vf610-bk4.dts          | 2 +-
 arch/arm/boot/dts/vf610-zii-dev.dtsi     | 2 +-
 arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-bk4.dts b/arch/arm/boot/dts/vf610-bk4.dts
index 551a4c3ff4fa..e4f691d601cc 100644
--- a/arch/arm/boot/dts/vf610-bk4.dts
+++ b/arch/arm/boot/dts/vf610-bk4.dts
@@ -38,7 +38,7 @@ leds {
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
 		/* LED D5 */
-		led0: heartbeat {
+		led0: led-heartbeat {
 			label = "heartbeat";
 			gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi b/arch/arm/boot/dts/vf610-zii-dev.dtsi
index f8299f33a692..ce5e52896b19 100644
--- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
+++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
@@ -59,7 +59,7 @@ gpio-leds {
 		pinctrl-0 = <&pinctrl_leds_debug>;
 		pinctrl-names = "default";
 
-		debug {
+		led-debug {
 			label = "zii:green:debug1";
 			gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
index 040a1f8b6130..7b3276cd470f 100644
--- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
+++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
@@ -23,7 +23,7 @@ gpio-leds {
 		pinctrl-0 = <&pinctrl_leds_debug>;
 		pinctrl-names = "default";
 
-		debug {
+		led-debug {
 			label = "zii:green:debug1";
 			gpios = <&gpio3 0 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
-- 
2.34.1

