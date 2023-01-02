Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF7D65AF0A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjABJsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjABJrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:47:06 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C2EE5B
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:47:01 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f34so40882761lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 01:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJ/hfRwhQ0c59jlHVEfk+NFha27lg0+WGDLLVU4imkI=;
        b=uCcjSUzHYaZFnUAs8agusTLrAiR7eNCKASqJ4P69Dh+GaRufCyne1HeS3Y9lYedxVP
         Lfezo6wHYAxChMIlrbsWn+q50yMv3tw6xleiq7dY8/T9cRldbVb3zNV4mXYHaKmslZjh
         pjMcXYFA3zJhi/6+HLS6rUmaRkxpfjjYhs4UA3OoyqmmxUFWoP4hW7LcOWcsK/PF4k9q
         kcH/kQ9qcWNykyQoiBz1b5MpkrD1pwWO49M6RvVjyeohDMbIQvRBWkzrhgCG0dq/obH1
         qPcbRRNZ2r5Xrd8KcHKOG9LBib07qU93/bXvHYy7sLSg+MFQT+fbfQo3mOKOyA6R9Mc7
         Dy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJ/hfRwhQ0c59jlHVEfk+NFha27lg0+WGDLLVU4imkI=;
        b=fx8js1Nwo1fya2SL58DPdy8ZbK5ff4UO2ckPvnCxheC7kFIdBD3LkUUh36oiqKE08K
         x8rvs9zX+ZOoZBXaG9MK7daPIvDep8eW5mfeHxEmsTYlnFxUxiUKCaC9cnGUZC08VKC+
         p+WGFFJmz1lr0H5SnFW5VI9FvKym5kvMlKgGZ7LUZyH/kM/MX/KNTAh+t5CF7JydcxY5
         hDfehzqTOyKWvYRKQ9hZI9XQky6MjUiij0Kff1wMOMHtaO4fu8kbAt+e3tMnwrAV/x/d
         PF2KqUdZCOcsqUf9vdBOQWpZr/OiHJPbsdatjS3LACWPv7CUlZdJCcuHPtjG72EiYxVA
         t5Vw==
X-Gm-Message-State: AFqh2kokOlI5kGuX1RezH5jgVSrrwA/ZYm0llte9lgptXLgeL1j2bQE3
        TqcX0RgAZzzU8DsokKjgoDa6fg==
X-Google-Smtp-Source: AMrXdXu3pNJyDy3nC6Jz42KOn5g6tSoCJFyDJtMcoI4qnx5nWns5W9cwSUpEbO3bsbUQS8cH/oEzHQ==
X-Received: by 2002:a05:6512:ba5:b0:4a4:68b9:19f9 with SMTP id b37-20020a0565120ba500b004a468b919f9mr12347290lfv.33.1672652821009;
        Mon, 02 Jan 2023 01:47:01 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id x11-20020a0565123f8b00b004b5adb59ed5sm4382143lfa.297.2023.01.02.01.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 01:47:00 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/17] arm64: dts: qcom: sc7180: Pad addresses to 8 hex digits
Date:   Mon,  2 Jan 2023 10:46:37 +0100
Message-Id: <20230102094642.74254-13-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230102094642.74254-1-konrad.dybcio@linaro.org>
References: <20230102094642.74254-1-konrad.dybcio@linaro.org>
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

Some addresses were 7-hex-digits long, or less. Fix that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
No changes

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

