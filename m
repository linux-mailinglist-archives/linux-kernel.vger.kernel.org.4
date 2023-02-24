Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F376A1CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjBXNIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjBXNIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:08:07 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99B7113C5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:08:05 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id n2so14555372lfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677244084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPreAIsPBs0vo9Qsm+CM5kGjxjzbL2RRreZgJMx8oPk=;
        b=cJdEzQNdVzHBlQVlfDkZ4stM6P+/jhwF5aDU9BVUr5epgTQZrsOmTCdIcFh3ew1/Ui
         eFeGRMjuHUErKRT6h/3VN26wS6UoJ8FdId4RY+dEFNfkPr7VH8G1auSMMLNsT6NCR27W
         m6xWUU3u9lkIHwT9BKScyBCbFXBPGWwJHF5wPEvPdgnqPeMIsA970HoTRrTKt64t9JLP
         vQfrmFfo1UBtYE6oExAtVX12C3I0K4Ks0dnnEaCMMuUadrDXZ/xf2NyqK5vIrGafb673
         vOprKJVEGlz6nrcYNLMFj4pMufGbn7EuakGc/6LWEaL3Rfa/gA/bzpttKMp0XbTZqFHJ
         82bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677244084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPreAIsPBs0vo9Qsm+CM5kGjxjzbL2RRreZgJMx8oPk=;
        b=6aHbXd4yGAhSxuLrWYQHgsVXAp38q8qK+4TFfOaFCdfBYmxqNFhZ1ZC0/a8IcZg+zW
         SzE7SaT/FJgbd1tny+9+96w5WnCSmty7Q4PlFPmRZaFTf+b/cjGVZeV611DJX8laYmdA
         YJ/w69hgPBYcOf3eBOcmAku9xMhp3SOEa79sPgH00QC5AA7x+j1nR0i9hbT67VrYdnEi
         +JMyFATwqKz9EkPgyv6R9wOsyIOWbhTNNAVbo76h3Qe3R787My37vB/FJO/D0kf4bTmS
         h9k7CtCfXBtysmNGlpxg3fphJeMwvYDl0vbCiD2ssQitjQgnB/btoMN2+25GKkLmMPbr
         x68Q==
X-Gm-Message-State: AO0yUKV7IZcjFX2vwM+1kZoTsMajCGqYoIJxrbtTc4AEtKOXcNoLA/ur
        2a+Z4KkyYP2xn9QaVxINMg14Og==
X-Google-Smtp-Source: AK7set8+cjo3A4v4txcKI1tpKNOIYdz++lPbFizEkFnGvQRsMB9gq98YcsVIBQ02klbWKAU+VDL43w==
X-Received: by 2002:ac2:48b7:0:b0:4db:3a6f:df17 with SMTP id u23-20020ac248b7000000b004db3a6fdf17mr5132455lfg.51.1677244083883;
        Fri, 24 Feb 2023 05:08:03 -0800 (PST)
Received: from localhost.localdomain (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id i19-20020a056512007300b004dd7fefd2c8sm524046lfo.242.2023.02.24.05.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 05:08:03 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Luca Weiss <luca@z3ntu.xyz>, Iskren Chernev <me@iskren.info>,
        Conor Dooley <conor.dooley@microchip.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: sc8280xp: Use correct CPU compatibles
Date:   Fri, 24 Feb 2023 14:07:58 +0100
Message-Id: <20230224130759.45579-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224130759.45579-1-konrad.dybcio@linaro.org>
References: <20230224130759.45579-1-konrad.dybcio@linaro.org>
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

Cores 0-3 are CA78C r0p0, cores 4-7 are CX1C r0p0. Use the correct
compatibles instead of the placeholder qcom,kryo.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 0d02599d8867..9c186ba55cdc 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -43,7 +43,7 @@ cpus {
 
 		CPU0: cpu@0 {
 			device_type = "cpu";
-			compatible = "qcom,kryo";
+			compatible = "arm,cortex-a78c";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <602>;
@@ -67,7 +67,7 @@ L3_0: l3-cache {
 
 		CPU1: cpu@100 {
 			device_type = "cpu";
-			compatible = "qcom,kryo";
+			compatible = "arm,cortex-a78c";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <602>;
@@ -87,7 +87,7 @@ L2_100: l2-cache {
 
 		CPU2: cpu@200 {
 			device_type = "cpu";
-			compatible = "qcom,kryo";
+			compatible = "arm,cortex-a78c";
 			reg = <0x0 0x200>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <602>;
@@ -107,7 +107,7 @@ L2_200: l2-cache {
 
 		CPU3: cpu@300 {
 			device_type = "cpu";
-			compatible = "qcom,kryo";
+			compatible = "arm,cortex-a78c";
 			reg = <0x0 0x300>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <602>;
@@ -127,7 +127,7 @@ L2_300: l2-cache {
 
 		CPU4: cpu@400 {
 			device_type = "cpu";
-			compatible = "qcom,kryo";
+			compatible = "arm,cortex-x1c";
 			reg = <0x0 0x400>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
@@ -147,7 +147,7 @@ L2_400: l2-cache {
 
 		CPU5: cpu@500 {
 			device_type = "cpu";
-			compatible = "qcom,kryo";
+			compatible = "arm,cortex-x1c";
 			reg = <0x0 0x500>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
@@ -167,7 +167,7 @@ L2_500: l2-cache {
 
 		CPU6: cpu@600 {
 			device_type = "cpu";
-			compatible = "qcom,kryo";
+			compatible = "arm,cortex-x1c";
 			reg = <0x0 0x600>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
@@ -187,7 +187,7 @@ L2_600: l2-cache {
 
 		CPU7: cpu@700 {
 			device_type = "cpu";
-			compatible = "qcom,kryo";
+			compatible = "arm,cortex-x1c";
 			reg = <0x0 0x700>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-- 
2.39.2

