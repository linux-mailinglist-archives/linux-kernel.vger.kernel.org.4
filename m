Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643B86B0B1B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjCHO20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjCHO2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:28:09 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADB0C3E2D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:27:40 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cy23so66356026edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 06:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678285635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6eWDufY7+zICzKzyI2+VEmOCWAqgAtsARp3qb0zhsY8=;
        b=BbZ8k/NJjVEkIKWYoM90mY7gjrv4bUl1XdxfHAG6Pi0Su+OTW7idKqhV6e0Pjq8ufx
         9KVQq7qXfucc2dvxlDhTg+J/VLx9VjFnNqNyssrrvsPawSv0MIrTlaGMnzgDwgRhFBzg
         OTWG0hvelzCAcDgfVNwjMkQUJIs7GuM7SF6O6MqBB57PJJlBiVC4Uf+SY1q5WpyxOTQx
         KjR3rfVTF/PI/hsKELbOKTB8BHLd5JZWLvycEo8iQmJvo07Ve+uB3FoP5p699G9XG6DK
         s3VjIiTuj5ru68btyODXBVcXf88h64RPo2EY4VaBzGvy2nrYpxPOslpYufM5P0aAAZ15
         gi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678285635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eWDufY7+zICzKzyI2+VEmOCWAqgAtsARp3qb0zhsY8=;
        b=r7pZwYwYHwKVqZPYy888VMtXUwUbGjstUiULSL1QRKIOp04DsmItwC8geF1LobPCZs
         DrGTrvsElN3abgU2E3nb31MomqaJUJDIovr3ey9/EWnkoLyc7C2BWVvUcgZTDGLfyoPj
         XvRklbObK+vcIh8I9ImmVpbpdTkc8PZdTWBJ7cnHaGhN1Q9TWGnz+/tqBlKf7otAloH/
         tX3UQZgv7rbUMp2xS2Chdfsdk7AaEBD7ICHwiP6UGhacs0+utMphjVUHpYEZF3nfoDZ8
         iYEhqXdpydcbMtegrZaaYoqoL2EzaoBA+DHbzX50v6NEdai9+4KL7H2iPdfb4uXqpHzO
         01Kg==
X-Gm-Message-State: AO0yUKWviEdgIUyprrYBr9UnblORv9kPgRV4x4VfTb4eb8+yR7U1gXWs
        OREO5JMYvJpf4ogCihpHouwN/w==
X-Google-Smtp-Source: AK7set/yMNClsydz5D6EJJmjLHRDwVO5AMyRxnNSFx4c+gK6vbvDUFLhJrXDLDEFGhR5pwi+GZcmkw==
X-Received: by 2002:a17:907:c297:b0:8f6:88b7:73a7 with SMTP id tk23-20020a170907c29700b008f688b773a7mr15975693ejc.7.1678285635284;
        Wed, 08 Mar 2023 06:27:15 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id p14-20020a170906a00e00b008b1b644c9fbsm7543553ejy.103.2023.03.08.06.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:27:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sm8450-hdk: use recommended drive strength for speaker SD_N
Date:   Wed,  8 Mar 2023 15:27:12 +0100
Message-Id: <20230308142712.277659-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Downstream DTS (and sc8280xp-lenovo-thinkpad-x13s with the same
speakers) uses 16 mA drive strength for the WSA8835 speaker SD_N
reset/shutdown pin.  Use the same for HDK8450, as it is seem the
recommended value.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not adding Fixes tag because 4 mA seems to work, so this is just
choosing safer value, based on downstream DTS.
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 9fa1a83d9554..e04de4bb7fae 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -754,7 +754,7 @@ &tlmm {
 	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
 		pins = "gpio1";
 		function = "gpio";
-		drive-strength = <4>;
+		drive-strength = <16>;
 		bias-disable;
 		output-low;
 	};
@@ -762,7 +762,7 @@ spkr_1_sd_n_active: spkr-1-sd-n-active-state {
 	spkr_2_sd_n_active: spkr-2-sd-n-active-state {
 		pins = "gpio89";
 		function = "gpio";
-		drive-strength = <4>;
+		drive-strength = <16>;
 		bias-disable;
 		output-low;
 	};
-- 
2.34.1

