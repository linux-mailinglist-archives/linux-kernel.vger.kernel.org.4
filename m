Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEBB5B33A7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiIIJVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiIIJVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:21:04 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D95FA698
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:20:56 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id v6so1146037ljj.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pqtLuKgHuRzFaU11WfzhWYMqklF7F2EiVQK9EioMBZA=;
        b=ZlXp+PmJqLsvdwupLcYuie/9CM78vetY58bKjKQ3mEiMG2BaMRtDgbCTQq1gTBw93L
         38Gv8jpajXn46UZHW2hLJKXO+m8XYFV2foA0ZJoCMDG34tgXuWM0qtAfAvKmPW4UaXkh
         s7TGXKYHkSTuVQpgrjLrhpatSfEI/IZca4hnlVz1ICVspEXM6oS12Uoo27cwMd0mLGIm
         bJjAGwMvI3nfS7HjPkWQpVi3lTKil5Y7p3EzPRSb5/uBPEwDeXOUtWaaeB+mHqYpN2Ii
         4eonD2gPW+H59F5bN5i9sqd00irxMq9QKkeU1Sev4Fea920O1bOwH7KEAUmAuNX2N9bO
         8A5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pqtLuKgHuRzFaU11WfzhWYMqklF7F2EiVQK9EioMBZA=;
        b=imh3pTrQu0FpuRZnvb7pnKwDYqPAm0pCaaMdtSadZK40bALOphd5K+IN6wYoGPDxg8
         v+b3QAp1oi8i3PlePxDUR2ZPPCzAQwI40WNkzRy1yYmZhL6PabAJz1HJVX6mZUzjpT3J
         fvrZaLsm7uFGMamNL/Zro7hAwUuKIYySJb2PTKsC5O6ltQxDv1cdpUDw8Vyfze1xeCnq
         6rt+HN38JtXwijgk7t5LENktKuqeS1hS6Nfd7ce/tVpo8ekp9Z4TWpJ1ViTrnH7NRg3I
         vLfeUkczfBedINjmk+ZJFZU7uQ7BuyaXlD3urtn16+C3KKNyzIdYluBuFeAGVZviGQN6
         U3Yw==
X-Gm-Message-State: ACgBeo2Ua838C1ddk8u1yps364HZSQu9SENbZUG7qT+3UoBueKLYTx1t
        SnoPn6vKPWC75mqWHipso1ToNA==
X-Google-Smtp-Source: AA6agR47LSlSrOfU1xiDHG/DGsDGjbpO2sinzLGdl0/c2WyMLhoLnJ99X9qL5bBPTvm/cDgoRCSPjA==
X-Received: by 2002:a05:651c:514:b0:25e:7113:396b with SMTP id o20-20020a05651c051400b0025e7113396bmr3462653ljp.65.1662715255586;
        Fri, 09 Sep 2022 02:20:55 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512214600b00498fe38ea0fsm2170lfr.174.2022.09.09.02.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 02:20:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 12/15] arm64: dts: qcom: msm8994: switch TCSR mutex to MMIO
Date:   Fri,  9 Sep 2022 11:20:32 +0200
Message-Id: <20220909092035.223915-13-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
References: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCSR mutex bindings allow device to be described only with address
space (so it uses MMIO, not syscon regmap).  This seems reasonable as
TCSR mutex is actually a dedicated IO address space and it also fixes DT
schema checks:

  qcom/msm8994-sony-xperia-kitakami-suzuran.dtb: hwlock: 'reg' is a required property
  qcom/msm8994-sony-xperia-kitakami-suzuran.dtb: hwlock: 'syscon' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 8bc6c070e306..6a9bca6c2c5f 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -164,12 +164,6 @@ memory@80000000 {
 		reg = <0 0x80000000 0 0>;
 	};
 
-	tcsr_mutex: hwlock {
-		compatible = "qcom,tcsr-mutex";
-		syscon = <&tcsr_mutex_regs 0 0x80>;
-		#hwlock-cells = <1>;
-	};
-
 	pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4)| IRQ_TYPE_LEVEL_HIGH)>;
@@ -762,9 +756,10 @@ spmi_bus: spmi@fc4c0000 {
 			#interrupt-cells = <4>;
 		};
 
-		tcsr_mutex_regs: syscon@fd484000 {
-			compatible = "syscon";
-			reg = <0xfd484000 0x2000>;
+		tcsr_mutex: hwlock@fd484000 {
+			compatible = "qcom,msm8994-tcsr-mutex", "qcom,tcsr-mutex";
+			reg = <0xfd484000 0x1000>;
+			#hwlock-cells = <1>;
 		};
 
 		tlmm: pinctrl@fd510000 {
-- 
2.34.1

