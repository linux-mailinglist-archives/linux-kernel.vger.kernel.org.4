Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6F267F06D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjA0V2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjA0V1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:27:31 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1700A3A87C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:27:30 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j17so4358489wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wufxP51EWGGk9HXvgWg83TOisM7XYlAWLVo728uV5hA=;
        b=TNh0kQVqhFnNqu+G4pM9Oc4M6cePC/63S8gdsyMqkTslrWbQDlS/J9kJFWBMD1uYQq
         GC8WJIGE+wIbDdmM20nqVIGiSx2tV1fXN9W0yoVcq18u46qVw/Y1aIxbkPjlL8CV2gbP
         X7UfnZFWSCxDk8Z5VmyGvbZ0HnT+9b2idsd3AvkP3853iFpWojQFHF4njPIeOdDQp0nz
         zJFF1xQWjcZ5Sqfw0KQCRzwFvmndDMTDTVrExJt7qMNa+Z6/DAONPWkeCzaIoVCs0bZ0
         IaKQzSVcBq0jXX5ckuKrSgK3YPg5bUb8I/W0u5zWZliCUxuOWJN0ApMETnFd9MrV++Z6
         8meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wufxP51EWGGk9HXvgWg83TOisM7XYlAWLVo728uV5hA=;
        b=JdasFvsTlVeEVvC5t3Ttp64YonxSruuSBe761+UzxKVAxUuCFcG8vfe6YAs5baCOVV
         2qZtTcYYaVUX3PiQeDFaa2O0BJgBfahI2FvJTr3CkkJGUgJ1dW2L3NADOEHkPmgKjWwG
         5GY0S0Mn1CllXaE7bGHXFGWOsCBGOxR5V2AAwW6KGBt0qM/e1pN/ijIgT7HsjLn1m7qZ
         fmtG7p/gGKJUH7ETRP7Q0JfQmGIOS2YNXFy/8EBYxh5lvHxt5kyQ53nKWnHTmQrxWIRm
         n9fiSak97d5/8c6qcwG0U1MMS1+nfEuQM4+IYui8i1a78TAeq2GRrdQ+N8N74KGG97ZU
         VUmg==
X-Gm-Message-State: AFqh2kpWxr3+VEbrWSxy4sPK7YecOufObUfSkrfLFinZgyP4HfToQkOl
        l6o9FAV+4FvsYWGLCfN3JUjv0Q==
X-Google-Smtp-Source: AMrXdXuxJSnrinJ8RLzt8CTuozc6iwrAzQwFHVN8Hco1FzCN0sBy5xGjIVn+L+D1CcmXgSb3sQWagg==
X-Received: by 2002:a05:600c:35d0:b0:3db:c4c:9224 with SMTP id r16-20020a05600c35d000b003db0c4c9224mr40221166wmq.3.1674854849674;
        Fri, 27 Jan 2023 13:27:29 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d11-20020a05600c3acb00b003db30be4a54sm8645303wms.38.2023.01.27.13.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 13:27:29 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v3 4/4] arm64: dts: exynos: add unit address to DWC3 node wrapper in Exynos7
Date:   Fri, 27 Jan 2023 22:27:13 +0100
Message-Id: <20230127212713.267014-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127212713.267014-1-krzysztof.kozlowski@linaro.org>
References: <20230127212713.267014-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither simple-bus bindings nor dtc W=1 accept device nodes in soc@ node
which do not have unit address.  Therefore usethe address space
of child device (actual DWC3 Controller) as the wrapper's address to
fix:

  exynos7-espresso.dtb: soc@0: usb: {'compatible': ['samsung,exynos7-dwusb3'], ...
    should not be valid under {'type': 'object'}

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. New patch
---
 arch/arm64/boot/dts/exynos/exynos7.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 82fee1b7caab..b1fa68835b09 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -690,7 +690,7 @@ usbdrd_phy: phy@15500000 {
 			#phy-cells = <1>;
 		};
 
-		usbdrd: usb {
+		usbdrd: usb@15400000 {
 			compatible = "samsung,exynos7-dwusb3";
 			clocks = <&clock_fsys0 ACLK_USBDRD300>,
 			       <&clock_fsys0 SCLK_USBDRD300_SUSPENDCLK>,
@@ -699,11 +699,11 @@ usbdrd: usb {
 				"usbdrd30_axius_clk";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges;
+			ranges = <0x0 0x15400000 0x10000>;
 
-			usb@15400000 {
+			usb@0 {
 				compatible = "snps,dwc3";
-				reg = <0x15400000 0x10000>;
+				reg = <0x0 0x10000>;
 				interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&usbdrd_phy 0>, <&usbdrd_phy 1>;
 				phy-names = "usb2-phy", "usb3-phy";
-- 
2.34.1

