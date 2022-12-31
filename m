Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F4965A477
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbiLaNAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235711AbiLaM7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 07:59:37 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45103DF55
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:36 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id y25so35167055lfa.9
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 04:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvCj7sLe5EEXOiZsxA6DWV2OM1HHkgdGS5svQOsp/pk=;
        b=KUF5ypykotlLGND+PTwg7I55UoeeawnlT0V9ZA0tHRsnPQWJA6zdh/mLr/DS70t5XM
         +nRCRbZruSiRRydBuoDT/lyOhqws7o7CmtCVrOZmPx8YCBi8cxL1V/fq0JHoCG9iaEp7
         tygRn6JcoFhwgtIZub3XZNcQpHuFxsdpaRPNm1rFHQX34upyitsHtkagxN0ugHR5BeWY
         ZqItygv4SvbSZncvwjI626wrdzMwI/OqxtQqA0tM9s0nhwAqPwoqSjSeXxdQWC+C1dWw
         3vCXhkQCPPRoOKMNF62llk5GR79ZR9cimiF0oZzWO3oP3zyyAwnttfeml+jErojrb3jf
         jL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AvCj7sLe5EEXOiZsxA6DWV2OM1HHkgdGS5svQOsp/pk=;
        b=bbeSJ9rCcH8d+tBe4rUn4/2ru/pFB5bXO8rvjfOOClAK7O5AwEgHS73aiGXBwzVad5
         0AfgTUaf/PGFpCDMmsonakK1Lzs8dyQ9m93L92EEToCYa8KZvY7w6sp4h/coVKsPY9ec
         5XThszDtN667kMDP9DvzOELLOc9otA93nOi4ruDmosVj2mnMKBwuklvS8BRhzFA8xad0
         k5emqJ/SZf5VPISUTLWS1iGASmEXRF6VTUr1VseC/cvR7BgDpyctn2TZwnHVGHzfLZiD
         1mEopu6BeeBACbFCsxGjR7CMnrRNzx+fc2yqa7AitNINfnQXgkWcBQwBlZn1aDO83IxI
         +RIg==
X-Gm-Message-State: AFqh2kopUIyvUaDTQjsMXprFn3Ibjny0oNGKSGK8Y+ZBcreB+IBGHcbI
        KraztpOHl+1U5pJT2VRCsUp1gCj78pFS0NM4
X-Google-Smtp-Source: AMrXdXv0ycHwyn6NLb9oBYtU/qIwc+gR0tf3+GgAmqSuyYTmR5fquuY5DJATi9FcxBHJDlc6ZfhBtA==
X-Received: by 2002:a05:6512:2286:b0:4b5:9891:d6ff with SMTP id f6-20020a056512228600b004b59891d6ffmr11937811lfu.46.1672491575853;
        Sat, 31 Dec 2022 04:59:35 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id d10-20020a0565123d0a00b004cb344a8c77sm22266lfv.54.2022.12.31.04.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 04:59:35 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/18] arm64: dts: qcom: sc7180: Pad addresses to 8 hex digits
Date:   Sat, 31 Dec 2022 13:59:06 +0100
Message-Id: <20221231125911.437599-14-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221231125911.437599-1-konrad.dybcio@linaro.org>
References: <20221231125911.437599-1-konrad.dybcio@linaro.org>
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

Some addresses were 7-hex-digits long, or less. Fix that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index f71cf21a8dd8..67b9ae3eff83 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -690,8 +690,8 @@ gpu_speed_bin: gpu_speed_bin@1d2 {
 
 		sdhc_1: mmc@7c4000 {
 			compatible = "qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
-			reg = <0 0x7c4000 0 0x1000>,
-				<0 0x07c5000 0 0x1000>;
+			reg = <0 0x007c4000 0 0x1000>,
+				<0 0x007c5000 0 0x1000>;
 			reg-names = "hc", "cqhci";
 
 			iommus = <&apps_smmu 0x60 0x0>;
@@ -1421,9 +1421,9 @@ ipa: ipa@1e40000 {
 
 			iommus = <&apps_smmu 0x440 0x0>,
 				 <&apps_smmu 0x442 0x0>;
-			reg = <0 0x1e40000 0 0x7000>,
-			      <0 0x1e47000 0 0x2000>,
-			      <0 0x1e04000 0 0x2c000>;
+			reg = <0 0x01e40000 0 0x7000>,
+			      <0 0x01e47000 0 0x2000>,
+			      <0 0x01e04000 0 0x2c000>;
 			reg-names = "ipa-reg",
 				    "ipa-shared",
 				    "gsi";
@@ -3116,11 +3116,11 @@ mdss_dp: displayport-controller@ae90000 {
 				compatible = "qcom,sc7180-dp";
 				status = "disabled";
 
-				reg = <0 0xae90000 0 0x200>,
-				      <0 0xae90200 0 0x200>,
-				      <0 0xae90400 0 0xc00>,
-				      <0 0xae91000 0 0x400>,
-				      <0 0xae91400 0 0x400>;
+				reg = <0 0x0ae90000 0 0x200>,
+				      <0 0x0ae90200 0 0x200>,
+				      <0 0x0ae90400 0 0xc00>,
+				      <0 0x0ae91000 0 0x400>,
+				      <0 0x0ae91400 0 0x400>;
 
 				interrupt-parent = <&mdss>;
 				interrupts = <12>;
-- 
2.39.0

