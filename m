Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB346B7DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjCMQeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjCMQdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:33:55 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F8B29E06
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:33:21 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a32so13228857ljr.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678725189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSc8pdztz7YC2+kdzyKEr489JlBiPBYV24c6ezZhuYc=;
        b=ov0boAcHk+sGUxh3kGSKlKU0aSEF9ty47KSX5AIjCLelWuGOBA4x4+j6M6tXZEBe1L
         wPKjXAiukcSzSPoQbZEOnrDpYkH9Eoik837dBg4Z1CVup/2sqOakXOmR53nDlfCRBhg5
         QBHWOO1DMNAht6/exmw6uhudYcLxgGBLHU183jSUpOrTnIK36GyI7ManSzklXMJxOaGt
         EOIZ8gZqd0yxiWZrGwWwmSYc8AgJRRg2/qrCAXPEoLQDryT0BAoo/n1DoIrS/dwsrmwn
         CtUo3vokP2iduxo6J8TaEtUkpQzLCtfRZ6RqrP/1dTuuJVnf15nuEkYDMayJ0A6kWWp4
         RYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678725189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSc8pdztz7YC2+kdzyKEr489JlBiPBYV24c6ezZhuYc=;
        b=JZj0kiHbrU4qNBRV7AQKvQ3bQYdC0P07brzTyyxvomYTYU0Xy3cVO7Id93jbcIM5ZQ
         SicFQcwTJOk0GpFQPeTuPpWjmGlRVhIH1+ZiGRjbw0n4a5J6V0TRpy8+AZBe1mBWmXHT
         aWryYqiFybxpcZae1480VL1+xgEQvXiceY8GdQDc2xDQXrfHQK3e0SlOoy4NE9QySOgV
         9cfEJX3Ny5AO3Df7+ycqTDh8D0R/wZnGYnbFdJOL8BZpQIMmQr9qO89+PazvKKIG0MKO
         BEMJtEHRCj8/tp1w/50u1qpcupFn8YF6QTCbquiZNrWqHx4/zarDLhPTv4vIvG5mPm/x
         +J8g==
X-Gm-Message-State: AO0yUKV/maHaabgPngqAlplT+kSbYh1wYWwYEvKmADCRFPirp9cWan1z
        KUYwFvn++iVugubxPANtlBV4vQ==
X-Google-Smtp-Source: AK7set/wZYR06yV2hgQoOC6MKduF8VWdbcerEH5xqurHJJa/qGycAKGh+BnzUXnb79BOq4SckRsjZQ==
X-Received: by 2002:a2e:9ec5:0:b0:295:ae71:8e94 with SMTP id h5-20020a2e9ec5000000b00295ae718e94mr9650450ljk.29.1678725189364;
        Mon, 13 Mar 2023 09:33:09 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id q62-20020a2e5c41000000b00295765966d9sm57417ljb.86.2023.03.13.09.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 09:33:08 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 13 Mar 2023 17:32:38 +0100
Subject: [PATCH v2 3/6] arm64: dts: qcom: sdm845-tama: Add
 regulator-system-load to l14a/l28a
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-topic-tama_disp-v2-3-37ececf43770@linaro.org>
References: <20230313-topic-tama_disp-v2-0-37ececf43770@linaro.org>
In-Reply-To: <20230313-topic-tama_disp-v2-0-37ececf43770@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678725183; l=1137;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=OCpkkklEUVuqR/x/RpVRHJ6DVsFhq3jeyr3zezic+B0=;
 b=yRIHHrD/8JB4zS8Y+Ril2JdisTqPGrDXiUs9vCIazkxF3a9zxhxqo9dpL7PGc3ezgRGBFdbDEE3Y
 eTT6LvmYCbtADrDH7x9nALYa6op2Xfp0TAW9zjj3ZByuvH2ZmLaU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add the properties to ensure the ever so delicate touchscreen setup
matches downstream.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 967c9b81f061..0e03a4f3449e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -228,6 +228,7 @@ vreg_l14a_1p8: ldo14 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-system-load = <62000>;
 		};
 
 		vreg_l15a_1p8: ldo15 {
@@ -314,6 +315,7 @@ vreg_l28a_2p8: ldo28 {
 			regulator-min-microvolt = <2856000>;
 			regulator-max-microvolt = <3008000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-system-load = <100000>;
 		};
 
 		vreg_lvs1a_1p8: lvs1 {

-- 
2.39.2

