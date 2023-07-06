Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA98749C41
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjGFMon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjGFMof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:44:35 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40531BF0;
        Thu,  6 Jul 2023 05:44:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51dec0b6fecso947657a12.1;
        Thu, 06 Jul 2023 05:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688647436; x=1691239436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TE1n+MGQuKs3FdA5Q59+sPT4axcOEYjNeOfcfoQUrI=;
        b=ToqjMYUcVhSZGh/fmk+F2ssrFSqxuIIt4Zn3zOICqukfLcAUDWS5bIly0svw61bGDJ
         eHkGzLzbhbPw1jIXNcaHxNIozx60JzblQzlX7Gw3JrbflF8eLzV6JcZAAxnoivRuFlly
         YAdJoX2ONIh1UWqCk0K3MZB/gC9o0kdiMoaxdFuCzxTwB3W1tGILdsXnLP+uaDBxR0Po
         iKwSI57EUwmro56XsYEM9Y2dBSXHOpEOMIdQMqjWtuTRKUMF8VWJF+At68Gg9Y3Qlb9L
         agBDXYL8ShSvGfPWVzaCdAw1ekek1XSju/5w0DUbJXYmSw8c2aWyFuuDf4ZFCMIT+r/u
         6/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688647436; x=1691239436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TE1n+MGQuKs3FdA5Q59+sPT4axcOEYjNeOfcfoQUrI=;
        b=kCtH1S9OwAzDT9zUeyebymPbYd1kG9Z8UBzk+dIusP3fB4kgcCzEkbxVzRagwKDp/w
         VxWCs7VOCQOZhyg/0BE3Eb+45Ahd7vK4JjdiZWmfJ5pf46pV66dy6eRkhUryG497uPW3
         Ny1gzKqgT407Ru6i54bL2vdpYS9tIo8d1T6T1parRIH2RPN5Q68KHe1v/jo/Rl9plVri
         qUqN66wo76y6/+4HZjjqDyLwVfEou8Wr1xqSWn02hA4Zeu1p5TMKFTIZhzeRYr/byi7X
         TdDHtkqLjs1Gf6Bp1WDz7eQRBSrhrrqsmMrncj9/0+NA6cNHJ/q44CbVzVkzPYqbqs+k
         dEhg==
X-Gm-Message-State: ABy/qLaXDsM8QPcuus3X0uIK4XG45bTSp3dZbC1JnFBIckNGFHEOBtRV
        slHyDdp7Fg5EkZHbwbW1JHE=
X-Google-Smtp-Source: APBJJlF3CKrgK8GgYjAumb5530dT9DHmA0U/+EP0j94TuIMcSTorWhd8GKDSQ1uY0sFFSi6Lx6nxHA==
X-Received: by 2002:a17:906:2201:b0:973:e79c:3da8 with SMTP id s1-20020a170906220100b00973e79c3da8mr1305851ejs.17.1688647436195;
        Thu, 06 Jul 2023 05:43:56 -0700 (PDT)
Received: from david-ryuzu.fritz.box (ipbcc3a9b0.dynamic.kabel-deutschland.de. [188.195.169.176])
        by smtp.googlemail.com with ESMTPSA id w14-20020a170906b18e00b00992ca779f42sm775915ejy.97.2023.07.06.05.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 05:43:55 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH v2 5/7] arm64: dts: qcom: pm6150: Add resin and rtc nodes
Date:   Thu,  6 Jul 2023 14:40:24 +0200
Message-ID: <20230706124339.134272-6-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706124339.134272-1-davidwronek@gmail.com>
References: <20230706124339.134272-1-davidwronek@gmail.com>
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
index 2e6afa296141..43c50f890e8b 100644
--- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -53,6 +53,14 @@ pm6150_pwrkey: pwrkey {
 				bias-pull-up;
 				linux,code = <KEY_POWER>;
 			};
+
+			pm6150_resin: resin {
+				compatible = "qcom,pm8941-resin";
+				interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
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
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
 		pm6150_gpios: gpio@c000 {
 			compatible = "qcom,pm6150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.41.0

