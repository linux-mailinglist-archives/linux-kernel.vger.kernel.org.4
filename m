Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9026474771C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjGDQmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjGDQmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:42:21 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E101984;
        Tue,  4 Jul 2023 09:42:17 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6a084a34cso87120461fa.1;
        Tue, 04 Jul 2023 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688488935; x=1691080935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JazmJwoS+QUKiY3Y4s7xGpV3TmYB/IflMd4mhIwdcIQ=;
        b=PUdACvo3tY9qL6ip/NwFK9RNrEZpMZ/AW0wLOfb8GKZqa5BqSkv8mGtLumfRlDEbMR
         RXFSMJLOYg6V+WcCEt8Ywbkuc472hPlbc/5sUlyFVl1i79VByr+as+Ud7/5bHohzC3GT
         ThhXwnUrTi+0Cj6EW/bSV6wpT+lvvEq0QesjA0qP0VNT7t4lIGwxavWisR/V7kloHTEI
         M7xcTvdVJP+5RDHuKSIAUsknNrxllkoOZ2sbrwds4zMK6wnha3S2HWPcqfrB1D91shi6
         wYK5XmL90F0q5PH7GugD4lQtKtCrbsbU9mbeyF1MMJwgc2PlRXvw/XtT/Fee4Uz6JawL
         eV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688488935; x=1691080935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JazmJwoS+QUKiY3Y4s7xGpV3TmYB/IflMd4mhIwdcIQ=;
        b=N85ME6jWfY/QCcMEeSxEmDqoh+qvoX5EfnZBgK3wZbFrtTzhVFw5+3kWVCWOwcYnGW
         cuGsmWwolvzP+U5p7qj9V/CGgjYLHZo0+2fK1t3RhToA/C02OinkvHc0klTDPkWT7+oc
         aWVEyW6rP66xhlUCm07YKNf+krUtpGGrbhm7X+Yy3yT38EEBbUc/OMLT63fR0GtEodnx
         dYiKyR6nyc8uj3V457wdTLVags+lvPFOXdrFXWqF0tswa93iDcU1SiYOZW3fwQdAXUlb
         s1U+M3so8luETCmSOCajpOFIRb76Z2M+XBHp4ooSx59BtzNJ98Rz0tMSWvDXAHKQL7ZM
         TBag==
X-Gm-Message-State: ABy/qLakevO0OcoogC6r5Z6jAwYsIcz4jcnc8pGj4C4+Cv29YjAtMZEm
        NSpseB4Wcn9qAMaSVbVUcIM=
X-Google-Smtp-Source: APBJJlEF0IvXOK/PkMKZQI6B0t3SDMWpOpRzqzQ/3s+Ml+HWa6vUGeesEyJ/qMfOXc1XI8I65DPVbA==
X-Received: by 2002:a2e:7c0f:0:b0:2b6:d7a0:c27d with SMTP id x15-20020a2e7c0f000000b002b6d7a0c27dmr7077749ljc.37.1688488935094;
        Tue, 04 Jul 2023 09:42:15 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.169.176])
        by smtp.googlemail.com with ESMTPSA id u15-20020a2e2e0f000000b002b6eb5db863sm1181920lju.43.2023.07.04.09.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:42:14 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH 5/7] arm64: dts: qcom: pm6150: Add resin and rtc nodes
Date:   Tue,  4 Jul 2023 18:31:58 +0200
Message-ID: <20230704163848.169853-7-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704163848.169853-2-davidwronek@gmail.com>
References: <20230704163848.169853-2-davidwronek@gmail.com>
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

Add support for the RTC which is the same as on other PMICs and add the
resin child node to the PM6150 PON device and disable it by default.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 arch/arm64/boot/dts/qcom/pm6150.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index 2e6afa296141..9a7c532f7a12 100644
--- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -53,6 +53,14 @@ pm6150_pwrkey: pwrkey {
 				bias-pull-up;
 				linux,code = <KEY_POWER>;
 			};
+
+			pm6150_resin: resin {
+				compatible = "qcom,pm8941-resin";
+				interrupts = <GIC_SPI 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				status = "disabled";
+			};
 		};
 
 		pm6150_temp: temp-alarm@2400 {
@@ -88,6 +96,13 @@ pm6150_adc_tm: adc-tm@3500 {
 			status = "disabled";
 		};
 
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
+		};
+
 		pm6150_gpios: gpio@c000 {
 			compatible = "qcom,pm6150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.41.0

