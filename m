Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7709E64BC0A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbiLMSdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236341AbiLMSdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:33:14 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12CA167F3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:33:13 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id cf42so6389642lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InRO1/GO0LBQ3WvVgtcrxY3ZeFfs/GA4+OpVrE/p20o=;
        b=KTcKJL49IKgvvm9rtYHQmyBT5w2u5eEINfLTFRGbc9177nexNqx6+dYUB6Ktb86p31
         GYD04ljYQzuOcRU4+kBRUG0buiQwHSJ0s3WnjI9mYj4il2C5Mno4jILs1RQVaNUWWH+L
         Q8eFCzuLzG/8PrGYgPRMJPLlHcGnJth3NeIj6URCt/hCVJ8ik0Zn10bQu/ulO4LP77MK
         W59MVlABQYhBdo+kzavDru5CwBuu0vgscaT2NHiFtN6pKZJVcdAWB6wy+YSVlcrB+pQT
         epQTmub+9RKKDdPG7XId9R6vsLaizYsXYV0CfJNEkkWliqcS4DIEF7bh1MmCOQXj7mxL
         kvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InRO1/GO0LBQ3WvVgtcrxY3ZeFfs/GA4+OpVrE/p20o=;
        b=cRzHi3ise2L52wgVbxpwFb3UyfzlS5KwISldP5XFAobII97JGje2qQGYW9r3LXgszB
         pSTyPc+1wNJDxbPH6y6JgX2iGg6hMx1Ll3taT1GaUOAN7SvmnsCDKEogJE4mbvPWq1Em
         D8UVs9pgvP7adKvnIND9XD8NRNiZ4CfppZKai2Wdj16mwV1AGoLZH58mQcq9+e25MpWr
         GXrnDxojhI569rpPQsLDSDOOSDux+RrkmnvxnUSmyXUXjjSMZ0mnVHr+V/V1QeXJYXWf
         FOIGoe/gqG8aZf+L3vyhDguXzo70U2ndlSV9aOhh7WP6N5lJY4sxyuFkMR72NcJxtO/6
         mcHg==
X-Gm-Message-State: ANoB5plzBBPVoD5qwgRM0R/QFBB54sPyZPBOCEGGJ79O4YgWY2LqQUGA
        PbMCFHgE4GMy1QXdomCow37J9Q==
X-Google-Smtp-Source: AA0mqf4ipHuTV4LvW/sFkWaOdyO2RF6zS72Eio4sCg4cccdPWkE0P84nDY+/pC8017xPOjQ1bnDDKA==
X-Received: by 2002:a05:6512:b8d:b0:4b5:a9ca:9725 with SMTP id b13-20020a0565120b8d00b004b5a9ca9725mr7308471lfv.28.1670956392201;
        Tue, 13 Dec 2022 10:33:12 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id t10-20020a056512208a00b004b501497b6fsm465963lfr.148.2022.12.13.10.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 10:33:11 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] arm64: dts: qcom: msm8916: Add fallback CCI compatible
Date:   Tue, 13 Dec 2022 19:33:01 +0100
Message-Id: <20221213183305.544644-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213183305.544644-1-konrad.dybcio@linaro.org>
References: <20221213183305.544644-1-konrad.dybcio@linaro.org>
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

Add a fallback CCI compatible, as required by bindings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
No changes in v2.

 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 2ca8e977fc2a..4c0a0078adb5 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1167,7 +1167,7 @@ ports {
 		};
 
 		cci: cci@1b0c000 {
-			compatible = "qcom,msm8916-cci";
+			compatible = "qcom,msm8916-cci", "qcom,msm8226-cci";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x01b0c000 0x1000>;
-- 
2.39.0

