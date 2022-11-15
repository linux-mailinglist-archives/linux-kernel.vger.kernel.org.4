Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECB46299B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiKONJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiKONJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:09:48 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7A226AFB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:09:46 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gv23so3155563ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvSvTZo/5/UU/uYr7LgQNU6IXEbMw9wen9MRMPzB5ks=;
        b=WZHbue2QXLVWwCieM9kXtHQY5gWeZ/uCP7SRq1E2GqsGpijP8m0MYMRWUI6/fDvRrR
         HGRqkQSNP956M47qssQZ1QSTAL2+XVHYh267fW2fsK/k74I0vxiqBIszPQ9RD/y6D00y
         ozMi2ZItb5clgRPvmB/Ehbko7ouG9pdPwDcJcg+D/ZtgbsNIKqxUo/U+Bpam2Ol3uwMs
         fSkfu1bm9O0ES9KaRyPoNznlPkEWbbJeR6wCLoOFVcz5ccCWdkJloQ2Uh8nIpb8T8wQR
         XstgXwi3rCmE7wWCsb5MzcRa4rwi9v+XPx4Q6ZeXi7PicVed4iEZxWam1hckUbMdVA0w
         DL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvSvTZo/5/UU/uYr7LgQNU6IXEbMw9wen9MRMPzB5ks=;
        b=72LmYYcMtRbZgPoQUiEgXI14qek2vmmN8esSZ5ddFluCeG80R+42sQB6bKxUKzFRJ4
         WyNUCo+3OI+S1cFaknn2/Z+2lBKhH039hhpb0lqDYpWeE/Zwbx3DYOaMJklwe7BZL+En
         lRkdmF5TNrCRncRWxslVhTkBy76haCidVzGvHatbiEWvLJh2L2wXlxfnq+hoHQ4NehDf
         lsB16B7kUfB5J2tg7S7vTYaSolr0FJuZqcy6L3N2+YbEuZE5XC+eHmDT6vZUCkGnq5FO
         9PgDqmWEi9y44Tc45djw3lTCa3i9Mzeo44shUr5J8GhAZ7gKotmpsFFuPIiF+IMu+EKE
         HmrQ==
X-Gm-Message-State: ANoB5pkcyxW5ydctCF0w8zHfu800Feu/DVg/RVn2k04FcgPdWqar1qaz
        c0np5ez5oezVnADsj2z4xaDGjA==
X-Google-Smtp-Source: AA0mqf6FKl8R4ONv2F1AhlS1hrTy+b069L2XPAWwQdIPCfF2P3xA87K7OB1cMwG+YFyt9MH5UqufVA==
X-Received: by 2002:a17:906:154f:b0:78d:9bcf:4d9f with SMTP id c15-20020a170906154f00b0078d9bcf4d9fmr13664381ejd.749.1668517785199;
        Tue, 15 Nov 2022 05:09:45 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id ay26-20020a056402203a00b00461816beef9sm6093260edb.14.2022.11.15.05.09.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Nov 2022 05:09:44 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: sm8150: Use defines for power domain indices
Date:   Tue, 15 Nov 2022 14:09:36 +0100
Message-Id: <20221115130936.6830-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221115130936.6830-1-konrad.dybcio@linaro.org>
References: <20221115130936.6830-1-konrad.dybcio@linaro.org>
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

Use the defines from qcom-rpmpd.h instead of bare numbers for
readability.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index f9321b4384a4..212594aa448f 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2074,8 +2074,8 @@ remoteproc_slpi: remoteproc@2400000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd 3>,
-					<&rpmhpd 2>;
+			power-domains = <&rpmhpd SM8150_LCX>,
+					<&rpmhpd SM8150_LMX>;
 			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&slpi_mem>;
@@ -2619,8 +2619,8 @@ remoteproc_mpss: remoteproc@4080000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd 7>,
-					<&rpmhpd 0>;
+			power-domains = <&rpmhpd SM8150_CX>,
+					<&rpmhpd SM8150_MSS>;
 			power-domain-names = "cx", "mss";
 
 			memory-region = <&mpss_mem>;
@@ -3246,7 +3246,7 @@ remoteproc_cdsp: remoteproc@8300000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd 7>;
+			power-domains = <&rpmhpd SM8150_CX>;
 
 			memory-region = <&cdsp_mem>;
 
@@ -3747,7 +3747,7 @@ remoteproc_adsp: remoteproc@17300000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd 7>;
+			power-domains = <&rpmhpd SM8150_CX>;
 
 			memory-region = <&adsp_mem>;
 
-- 
2.38.1

