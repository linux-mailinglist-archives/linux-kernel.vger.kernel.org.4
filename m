Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF668638C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiKYOlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiKYOlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:41:17 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9EF32061
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:41:16 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id h5so1173499ljk.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZxzl2A5/f0Nu9GQT/zxkNHpCx5mo9Jy0WjixkJ1XUM=;
        b=S9G339dprGDXBsCCn8xX1solyXElnLxqlP+SgmMN3Nl85ZBrl6XGvC0BwacaBPZkpx
         otoDygeJPDSChO+PaGb7miVVQ7842D9nm1uxVqjTSp0Hx7dM73F61jERy/P89OLP936D
         ydxNR87/VH1Qq4NEO2gi7tZAyRotQt2YSVxyVbCFE/Bdf5fKRBRpLy5tfrnhTgYxXaxE
         mlSpG1ZyjiogOw4W8d9WJJI371G4Kv63P5gcLiWxyI444i3HfJwfGAj+IEo0psE1oFJn
         hAWrXnCgy6TOMgI5Kc+ysIJDdAA1Yl3Q3iBWj6wcHlmXrUbaRNKEMDtQdQ5deiwYCZNd
         Krhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZxzl2A5/f0Nu9GQT/zxkNHpCx5mo9Jy0WjixkJ1XUM=;
        b=NCCKF7XQoBMTY/RvDFYTDwKilJdHr/MN3Hzdfz5JcFylzGQ5TyzHhaAhe+mYtGaYhz
         HgzvX0Plq/wHIIP3LlomQNF2em3dPbLwWdmJvmtInY45WuO7Wxt+3cnwlL17qcvKL9ta
         bXtWGD5MAsidb6DHysHmanRg7F9pB02qonmgNqoeakskD0a44RjFrrQVxye16b9MtFTL
         TbwTR5l3yBuNrsfqyy7/W0YEO30tmgBct5k7f7Pj5T7udyBLm4bdVMmV8QML2yvXj4qq
         F7qRrx5wgaNkRY+pqGPY0j2+nE8JmKqgVyp2zGs9iiEi3QW6iIJ2iG+iaMlMzNgUq48Z
         h0JQ==
X-Gm-Message-State: ANoB5plG74FvopJ5BdE+O5wtBLA1LE521EGplFeVkrxtexg6e3mMtivR
        vruBVqnWzMOuNxanFyz+cil1KA==
X-Google-Smtp-Source: AA0mqf4a4xUmfO1WiuoLYVtcXRTvNYDv4tJtTqOq7gs0+CA9QGsQQSkk7JjBAAaFjD4WrcxAa/Im8Q==
X-Received: by 2002:a05:651c:1107:b0:277:4275:a837 with SMTP id e7-20020a05651c110700b002774275a837mr12752082ljo.393.1669387274474;
        Fri, 25 Nov 2022 06:41:14 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t9-20020a056512030900b00494618889c0sm551411lfp.42.2022.11.25.06.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:41:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: vexpress: align LED node names with dtschema
Date:   Fri, 25 Nov 2022 15:41:12 +0100
Message-Id: <20221125144112.476817-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

  vexpress-v2p-ca9.dtb: leds: 'user1', 'user2', 'user3', 'user4', 'user5', 'user6', 'user7', 'user8' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/vexpress-v2m.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2m.dtsi b/arch/arm/boot/dts/vexpress-v2m.dtsi
index f434fe5cf4a1..def538ce8769 100644
--- a/arch/arm/boot/dts/vexpress-v2m.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m.dtsi
@@ -383,49 +383,49 @@ v2m_refclk32khz: refclk32khz {
 			leds {
 				compatible = "gpio-leds";
 
-				user1 {
+				led-user1 {
 					label = "v2m:green:user1";
 					gpios = <&v2m_led_gpios 0 0>;
 					linux,default-trigger = "heartbeat";
 				};
 
-				user2 {
+				led-user2 {
 					label = "v2m:green:user2";
 					gpios = <&v2m_led_gpios 1 0>;
 					linux,default-trigger = "mmc0";
 				};
 
-				user3 {
+				led-user3 {
 					label = "v2m:green:user3";
 					gpios = <&v2m_led_gpios 2 0>;
 					linux,default-trigger = "cpu0";
 				};
 
-				user4 {
+				led-user4 {
 					label = "v2m:green:user4";
 					gpios = <&v2m_led_gpios 3 0>;
 					linux,default-trigger = "cpu1";
 				};
 
-				user5 {
+				led-user5 {
 					label = "v2m:green:user5";
 					gpios = <&v2m_led_gpios 4 0>;
 					linux,default-trigger = "cpu2";
 				};
 
-				user6 {
+				led-user6 {
 					label = "v2m:green:user6";
 					gpios = <&v2m_led_gpios 5 0>;
 					linux,default-trigger = "cpu3";
 				};
 
-				user7 {
+				led-user7 {
 					label = "v2m:green:user7";
 					gpios = <&v2m_led_gpios 6 0>;
 					linux,default-trigger = "cpu4";
 				};
 
-				user8 {
+				led-user8 {
 					label = "v2m:green:user8";
 					gpios = <&v2m_led_gpios 7 0>;
 					linux,default-trigger = "cpu5";
-- 
2.34.1

