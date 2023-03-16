Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563BB6BD209
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjCPONz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjCPON3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:13:29 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF629DE2A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:13:16 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z42so1812348ljq.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678975995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69Z8vRyvMPD6eeHzgpN4kBWrOzTlmLDOTO1kOklog8w=;
        b=KVLUT26QGoY7jty33pYML5vRq7aIuxvZwwpygwRRjAQTHSc1qCh6TyV+Hka7LrU3Sh
         MCA1JvOF9Ac5vRY3Z3FUzsZonI/9mXLvFe6k710SzgHAIjlAhWsLOQAlRhkssdeVZvtl
         oMjcnb5s1d8NNeojKL5pSRCZKD1w/vd1SQFxPDr7cY7CncIhMMd2O3n4JOTAPzkOOtX5
         dc99HVbPjHbc16xynm2T8eeIhnQx8PWS7akV4p/LRfsHOWzH1tB5nGD6pHBEl74Xbo09
         tuh1M0I0WAtShQ3hc1o6Xg/FJO0SiX/1WHkMS/HPobQ/uDdH0jA9yBmquk0T676zmRxj
         +WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678975995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69Z8vRyvMPD6eeHzgpN4kBWrOzTlmLDOTO1kOklog8w=;
        b=5S8N34mpu9pdITnui/kNYdNn+TgI7BNLtHfw/bhAdhFwnEUsF00CokXCXnaViD8t/f
         iPLUPU1VRGqVmTx5GuEVe2rGQnLnEO+KCJC5mCA9wTsoIwKzBWK/5u6OnSyIWDXQg8Op
         MKt29ll751RUNPVxYG0a1vSyOguFdnKCfRGwpH5XaTky87ter4KmCpGMXp3HhdtSN9l+
         q3Q6LFBGOUNRLMXsAn3NFWHsvPfJT/DcC7hmCQAw55yL3AZsd7/ERtxUaIuTk46u41NJ
         6QE1zKGHP72yiMtvalzqHRSGsuyWY3a5JQKkGnf+M3wWeGY54cG9bMQjcNKs7knOifSC
         cpLA==
X-Gm-Message-State: AO0yUKV/814jp/8LEScuXjxnDlnzmUjiUxdb9KItZ0K+G5wp3ffyl4PM
        rE+DN9HH7jtIBzknv2Hqfo7/oQ==
X-Google-Smtp-Source: AK7set+CwIIe59VR5TnzyBggtxVU8o1LIw34rbQT7WLlUj9xjabjPrA++EbEdyf/fCj8fANH9OQpYA==
X-Received: by 2002:a05:651c:1986:b0:295:9d2c:c5b5 with SMTP id bx6-20020a05651c198600b002959d2cc5b5mr2302166ljb.12.1678975995043;
        Thu, 16 Mar 2023 07:13:15 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a9-20020a2eb549000000b00295735991edsm1261639ljn.38.2023.03.16.07.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:13:14 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 16 Mar 2023 15:12:58 +0100
Subject: [PATCH v2 09/14] arm64: dts: qcom: sm6375: Add CPUCP L3 node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v2-9-708b8191f7eb@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678975978; l=1031;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=qJFA3gnp5+qsVvXTr+LuzoDVV2GfdNaVud8C8hVxcw8=;
 b=CEOtCUVU+F/M8OU5WvP/wsLQQcbZu4R5ctBaSEtpjhEkXFNGQRxIAbLXaHDWexBuec8kzWqg61sL
 3DeLprBOCzTdwE3eoq/GrrqgewOHfGjuBR3A+45KcdCSsoQ4NE1T
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

Configure the L3 cache DVFS scaler within the CPUCP block to allow
for dynamic frequency switching.

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 90f18754a63b..59d7ed25aa36 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -1505,6 +1505,15 @@ frame@f42d000 {
 			};
 		};
 
+		cpucp_l3: interconnect@fd90000 {
+			compatible = "qcom,sm6375-cpucp-l3", "qcom,epss-l3";
+			reg = <0 0x0fd90000 0 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GPLL0>;
+			clock-names = "xo", "alternate";
+			#interconnect-cells = <1>;
+		};
+
 		cpufreq_hw: cpufreq@fd91000 {
 			compatible = "qcom,sm6375-cpufreq-epss", "qcom,cpufreq-epss";
 			reg = <0 0x0fd91000 0 0x1000>, <0 0x0fd92000 0 0x1000>;

-- 
2.39.2

