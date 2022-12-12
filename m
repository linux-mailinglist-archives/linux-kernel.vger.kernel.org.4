Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000FB649D5F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiLLLRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbiLLLQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:16:18 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F87AB56
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:10:51 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 1so17954522lfz.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X861dj5mvMIOcy/s40LZfm9fx6V/ezqUYT7sBt18gBc=;
        b=aQgWoMUKkTRvRmW/K8iKlw9r7MO/aj2CSNHZDURkdxOIDhNpXg7Iu9C01xsjKUPgXJ
         wj/lBe22iNClrGNGImhDNeNHhaUva55Fqg1Ib1T//zSpj0Jt1CgErBJlMAsK9LNwIH0W
         z573p6FoUM1yNkyiRZl2+UAeHTBgxKN1itA4Y2E3fmpqpxR5VWL2P38C8n38klebDOxR
         jVvEvqjMJmaFrjY9IyqUMKvBmontSsQMNPrWn3SK9WQzK5PAXqRZNa4nPIjSP30h2+Qg
         Ikl6vvgSMm1KFd7y7cLSgt5NURNyjKDmRm3vATo6J8YJauXtQLUeeMkIpKx+tVqATYHv
         m8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X861dj5mvMIOcy/s40LZfm9fx6V/ezqUYT7sBt18gBc=;
        b=hRMvVgacf0ywh9agHVk1Zm6eU/efG7rC2n5qoB9zijMaLOsvvHEJnMZ8rBLiyPPhuY
         +SXsVv1A45+xW8QamMC3oNxUdjWZvYoRvnOA6fuO195sFJxsBTLJkG4a9zA2lo7JSXgX
         pit8Y30UmClFgDAN5moKE7ct1px97exPu9CuSUIUSp+lKgDWjnnVRerEh1rgi7GfRe24
         o57lKWulT4LdUqTfJqZ4VqsXKzZz8UN0VNIMAtRiVskT3GC9fjejQngZo/cwzEpK1AsL
         ySCqe0/hcYS6z1ahGizCjer1PbYBqZslL5UE5FPOjmM2913mgnhBwEJD31acxzOMqBMl
         3qvA==
X-Gm-Message-State: ANoB5pk/JeiKdASAkwSJU5L6IzVYC+F5h78keYBCk2tJFk2znvr4Q4AH
        YRH6TSlVFZZE0FdVk3Jm6IRsHw==
X-Google-Smtp-Source: AA0mqf410jiIUAh4Q3cRPlLAomso/7bEP81QjYaCom8HEbdVbIdVk+pLYFHAUbdfwV8Wv9k14wqN0Q==
X-Received: by 2002:ac2:5f4c:0:b0:4b5:7282:868c with SMTP id 12-20020ac25f4c000000b004b57282868cmr3888292lfz.55.1670843449431;
        Mon, 12 Dec 2022 03:10:49 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512060400b004b57a810e09sm1599110lfe.288.2022.12.12.03.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 03:10:49 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] arm64: dts: qcom: msm8998: Use lowercase hex
Date:   Mon, 12 Dec 2022 12:10:31 +0100
Message-Id: <20221212111037.98160-4-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212111037.98160-1-konrad.dybcio@linaro.org>
References: <20221212111037.98160-1-konrad.dybcio@linaro.org>
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

Use lowercase hex, as that's the preferred and overwhermingly present
style.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index b53c631dd13f..2355fd10d244 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1478,43 +1478,43 @@ gpu_opp_table: opp-table {
 				opp-710000097 {
 					opp-hz = /bits/ 64 <710000097>;
 					opp-level = <RPM_SMD_LEVEL_TURBO>;
-					opp-supported-hw = <0xFF>;
+					opp-supported-hw = <0xff>;
 				};
 
 				opp-670000048 {
 					opp-hz = /bits/ 64 <670000048>;
 					opp-level = <RPM_SMD_LEVEL_NOM_PLUS>;
-					opp-supported-hw = <0xFF>;
+					opp-supported-hw = <0xff>;
 				};
 
 				opp-596000097 {
 					opp-hz = /bits/ 64 <596000097>;
 					opp-level = <RPM_SMD_LEVEL_NOM>;
-					opp-supported-hw = <0xFF>;
+					opp-supported-hw = <0xff>;
 				};
 
 				opp-515000097 {
 					opp-hz = /bits/ 64 <515000097>;
 					opp-level = <RPM_SMD_LEVEL_SVS_PLUS>;
-					opp-supported-hw = <0xFF>;
+					opp-supported-hw = <0xff>;
 				};
 
 				opp-414000000 {
 					opp-hz = /bits/ 64 <414000000>;
 					opp-level = <RPM_SMD_LEVEL_SVS>;
-					opp-supported-hw = <0xFF>;
+					opp-supported-hw = <0xff>;
 				};
 
 				opp-342000000 {
 					opp-hz = /bits/ 64 <342000000>;
 					opp-level = <RPM_SMD_LEVEL_LOW_SVS>;
-					opp-supported-hw = <0xFF>;
+					opp-supported-hw = <0xff>;
 				};
 
 				opp-257000000 {
 					opp-hz = /bits/ 64 <257000000>;
 					opp-level = <RPM_SMD_LEVEL_MIN_SVS>;
-					opp-supported-hw = <0xFF>;
+					opp-supported-hw = <0xff>;
 				};
 			};
 		};
-- 
2.38.1

