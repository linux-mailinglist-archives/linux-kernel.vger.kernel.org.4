Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F2E6E8351
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjDSVTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjDSVTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:19:06 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D8D55B2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a5so1663106ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 14:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681939143; x=1684531143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9sXuVfDtTEtcj09LqpGPu1s71CoqkhBhSS1LJGdjt0=;
        b=yq03X9VzdWaE4PNxtM/nyVT7uXaTmoxieq0VpfJKUBg7HJ5zM861O9NQUruSsja9OE
         co3byMGTx99C54l2xJEkUUB0GsB/FlsuKzMppgwBV6sgs40AnEAPybt/06stP93KLhiN
         /Ug5rDU+A92M2/NeA7GGXLf0fqJI8ZHhKtEGXnwwyQ6tnHTb4gnJh/P6Me77i9uUhbHc
         enObnMdSfo3Z+YApi6GVOG3rKGnFvTspzyRdHQzAgbWwwUxrcwki3cUalBKP2/5nHLue
         tKicwlmR+XChxYiNeZnbsKVkFQjWrhoNUSqpMZk1RZOtQ67Q+tuUZVudl9I3yFIutOCD
         5+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939143; x=1684531143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9sXuVfDtTEtcj09LqpGPu1s71CoqkhBhSS1LJGdjt0=;
        b=Gz1NzPqnqyk0DuH8HEZl8tLp8hRDtIcs6tfKqB74bcOnlIqa/vTCa5AqKutNHJbCim
         kDrJrCyr4USpi3HKRa6cefG/RNrww7EG+8bA2ODvQnW/6pQ4+CmRY0NPIW7U1wDHPdC4
         Y9zNrBVJyxmvpl5JZwtPQBZK+iKnQNeX+7/3VLzr15vAJE+d1n7X6ffW9WX9u6wMoyRE
         iEP1RydHOMvBIqyrBMnPXsgQN3ciVpyXMXQipiBjPA3cjL85kNRX15tYuqjx9xJND10X
         5zboQcAtIQXkFsRJouZ51OFapaGdmkuo2e7U9QW1HVoj4eYDOAw8l6coLaIHOam6f54B
         RKrw==
X-Gm-Message-State: AAQBX9ejSEnP/v5HgLMYpiJPnFscqDI6j/7M4YT3Y7XtkubP02NLz0Ps
        tSxhBwdn0TY7PTj95eNy9/QzzQ==
X-Google-Smtp-Source: AKy350YQMfUsTBcCO/aJgUFGI/BqiOsnannEgK3R2Ph4GqNtWbe8DQvv+DTgcy+F+JTu+Bt9EaDOLg==
X-Received: by 2002:a17:906:82c5:b0:93f:2256:fc05 with SMTP id a5-20020a17090682c500b0093f2256fc05mr18361664ejy.55.1681939143554;
        Wed, 19 Apr 2023 14:19:03 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:976c:1d6c:6ed0:8935])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090682cc00b0094f109a5b3asm7092739ejy.135.2023.04.19.14.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:19:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Todor Tomov <todor.too@gmail.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Robert Foss <rfoss@kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Molly Sophia <mollysophia379@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 03/18] arm64: dts: qcom: msm8916: correct MMC unit address
Date:   Wed, 19 Apr 2023 23:18:41 +0200
Message-Id: <20230419211856.79332-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
References: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match unit-address to reg entry to fix dtbs W=1 warnings:

  Warning (simple_bus_reg): /soc@0/mmc@7824000: simple-bus unit address format error, expected "7824900"
  Warning (simple_bus_reg): /soc@0/mmc@7864000: simple-bus unit address format error, expected "7864900"

Fixes: c4da5a561627 ("arm64: dts: qcom: Add msm8916 sdhci configuration nodes")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 894a99431158..f6ccce0dad4e 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1554,7 +1554,7 @@ lpass_codec: audio-codec@771c000 {
 			#sound-dai-cells = <1>;
 		};
 
-		sdhc_1: mmc@7824000 {
+		sdhc_1: mmc@7824900 {
 			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07824900 0x11c>, <0x07824000 0x800>;
 			reg-names = "hc", "core";
@@ -1572,7 +1572,7 @@ sdhc_1: mmc@7824000 {
 			status = "disabled";
 		};
 
-		sdhc_2: mmc@7864000 {
+		sdhc_2: mmc@7864900 {
 			compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07864900 0x11c>, <0x07864000 0x800>;
 			reg-names = "hc", "core";
-- 
2.34.1

