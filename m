Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BE671FA03
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 08:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjFBGUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 02:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjFBGUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 02:20:31 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA3B184
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 23:20:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f60e536250so22028875e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 23:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685686828; x=1688278828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sxi6eBq2jAphc7lu/U7YdSiDsxFMsrJEc61rGlwD/7s=;
        b=olJl3Xlxv+LgPENysCwb5KbDCryb9p/IF/YE/Q6tjOD1OlwlRGqHfEFK+Ero+OyxXD
         xVSpxNckWV5UXQIFWZZVABCkckvdMwkY2l+qVsvZx23R2hvw4jPzYr4hHzZjjr9nOFi6
         p2z3p0Xm8RmmEGYJe7L/ccr9EeM6nbQB9kb1MNxELua1gm7HAVGB3wcMuHiqkTJUrwZ+
         1trgeXpWZq9QEhnvOUm0kcet2scIIim5KnWtZquWVEIchmzZ4gj820hJx35mIrG8abcV
         MMfE8+lT5tvRbYqtCH24gXOIy6Snk3X8Fj21qiLeU1ZsXb7gP2vw6n63f0XH1kopd7V7
         EqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685686828; x=1688278828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sxi6eBq2jAphc7lu/U7YdSiDsxFMsrJEc61rGlwD/7s=;
        b=Ky4yzRU9Jivn74W2agrLy/8/yr8aEra1BApZnlkM9MQYnjhLHiJ7nL3ACGVmvKeszU
         sxVfkxHr8z6OP2RflLjj7tjj4gKxNvFvdo/lQSHvFRi40HKIINW9U8Ykq6zwhuv9z/On
         hdSqSRENnoBQwNwEIinAmrrqqwBBBzXIJgHuZnk5x54k3AZ6BePfPmA99ZFx5D88t3eW
         Z1FPXq/+/nTQTlELpYpcIkR44Fc5YaaNLnm700rXc3zEiGHO177s66/JdPr13XEE3z3H
         xl9hHnfpSu5TpoYmrpXXehahlzV1CCqf0E5Z1CkaCxhQWQnp/sy0UbYq4bn5KNDNHX/B
         dGzg==
X-Gm-Message-State: AC+VfDwZ5rolziTh5pvIel0LYDpB8ydnCELryub4J5s376LMNENVPLsr
        vp4vYOMMYUPSF5WzUtkcNp4+sg==
X-Google-Smtp-Source: ACHHUZ51FIa8CAzDZ/wVjNESoEwUB7SMLDC8difVTyRgvMOsSHMwo+6xIyF19ELQYO41s95/gqbN2Q==
X-Received: by 2002:a05:600c:ac9:b0:3f4:27ff:7d4e with SMTP id c9-20020a05600c0ac900b003f427ff7d4emr933880wmr.9.1685686828764;
        Thu, 01 Jun 2023 23:20:28 -0700 (PDT)
Received: from hackbox.lan ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b003f42894ebe2sm4388213wmf.23.2023.06.01.23.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 23:20:28 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/6] arm64: dts: qcom: sm8350: Add missing interconnect paths to USB HCs
Date:   Fri,  2 Jun 2023 09:20:15 +0300
Message-Id: <20230602062016.1883171-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602062016.1883171-1-abel.vesa@linaro.org>
References: <20230602062016.1883171-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB HCs nodes are missing the interconnect paths, so add them.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---

Changes since v1:
 * Added Konrad's R-b tag

 arch/arm64/boot/dts/qcom/sm8350.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 2798a5d6e5f7..88ef478cb5cc 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2304,6 +2304,10 @@ usb_1: usb@a6f8800 {
 
 			resets = <&gcc GCC_USB30_PRIM_BCR>;
 
+			interconnects = <&aggre1_noc MASTER_USB3_0 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_0 0>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
 			usb_1_dwc3: usb@a600000 {
 				compatible = "snps,dwc3";
 				reg = <0 0x0a600000 0 0xcd00>;
@@ -2373,6 +2377,10 @@ usb_2: usb@a8f8800 {
 
 			resets = <&gcc GCC_USB30_SEC_BCR>;
 
+			interconnects = <&aggre1_noc MASTER_USB3_1 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_1 0>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
 			usb_2_dwc3: usb@a800000 {
 				compatible = "snps,dwc3";
 				reg = <0 0x0a800000 0 0xcd00>;
-- 
2.34.1

