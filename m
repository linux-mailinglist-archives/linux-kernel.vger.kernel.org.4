Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DEA69529A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjBMVDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjBMVDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:03:38 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DD81B55E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:03:36 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jg8so35085487ejc.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iji4WhAMH0Xmn8u5RXywgde50zqMluNVEZrLkL99lQI=;
        b=JWIN7BjsMXeTBrob8om/pfjSkeFrv+OedJ5dsaZOpjKajckRr4pYijEPUOh070ZigC
         KInhWm1zvQwCGNpCMrTjDMPtDtECn6wqMX5871O8oGpM2MH0PGAXPbZi1RNRu3swc9cx
         8I9SWsSiKn7Ti8EqELbAh851FFr32n4WO2mmni8krG8q6IEZ81gHfvrfQHiw38w2anUy
         dtuBqtlfO9uttQfMgx2NGQwSbi/206bSWijTfqUcBvFuINiw7hEcXUFnpryMz518HrFo
         iP6BMq+kymDiN/qfp37dQ9SLTUJk5hK8w9qwAVkrah9UlluxY9F3datvervED7NKKqou
         OPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iji4WhAMH0Xmn8u5RXywgde50zqMluNVEZrLkL99lQI=;
        b=VbcVxyvLSEX/3tLzAlYAQ5z/121glNYj+D84zDo4momfWm4r8kR6qw0+gQUJ/6T7L5
         cvDzrAsFIF3TyEsKtSBj5UgL9Dku6itj0yuOJCN7e0BySL64Y9RTDU6elafP1o2qV1zt
         nx+vaudUXQhX+tQpoY3ZdJMo+5utUABb6cAHC/1Bpw5foqQrEipnULkfko21bAwk60U8
         dg31zvKrdkfGnowkoJHlpNZFdg04BRab9a+QT/bOhMeGQ1YCDlB28HsNNDMOafLVJudC
         LEcMSrruVKQmnGmHHe/Ql/pbIH3Mbj1BYZEXE38eVSAuOhvd1TNHEgoSMwvhb7HTNoT3
         EFsA==
X-Gm-Message-State: AO0yUKWSgDvhCgNWNgrma96nGh+XywdSZEKKptDl56wFO4PffoEw45ZW
        APFHrlVoAl/OENZtbBtExeJhtQ==
X-Google-Smtp-Source: AK7set+bxnF/WKv8MHWQwYSGBhSYvo1XxGDGWMal/mZfydY/KsKfbm821kTrLrJcoqpSqj3N57ZDQQ==
X-Received: by 2002:a17:907:3f91:b0:8aa:9841:5e29 with SMTP id hr17-20020a1709073f9100b008aa98415e29mr326126ejc.77.1676322214542;
        Mon, 13 Feb 2023 13:03:34 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id n24-20020a170906379800b008af2c131d4csm7282148ejc.5.2023.02.13.13.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 13:03:34 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8998: Fix stm-stimulus-base reg name
Date:   Mon, 13 Feb 2023 22:03:31 +0100
Message-Id: <20230213210331.2106877-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
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

The name stm-data-base comes from ancient (msm-3.10 or older)
downstream kernels. Upstream uses stm-stimulus-base instead. Fix it.

Fixes: 783abfa2249a ("arm64: dts: qcom: msm8998: Add Coresight support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Not tested on hw.

 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 76b65732d8d8..9f94351f7460 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2547,7 +2547,7 @@ stm: stm@6002000 {
 			compatible = "arm,coresight-stm", "arm,primecell";
 			reg = <0x06002000 0x1000>,
 			      <0x16280000 0x180000>;
-			reg-names = "stm-base", "stm-data-base";
+			reg-names = "stm-base", "stm-stimulus-base";
 			status = "disabled";
 
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
-- 
2.39.1

