Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E941A649D67
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiLLLS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiLLLQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:16:25 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D987513D72
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:10:53 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bp15so17903140lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhL8ojOEDCeRjq8lnqRotSOYRXvMJyFniRabRehKtW4=;
        b=bd3HjX6ZbkBuqIAYoGBHqPMGkLTwRC7KLY46M7Mi8Eprm7JA+6hYM33ku1fGMcvcT0
         Jt8ixYkzZvy0yAkXIxfE9TC3iBolE5PmHPrYFomKXuV+I7NnvcUu7anO2NiLbuC3QGUM
         7RfV0mhTFHVUB+JwWtJczV+rm5B7TQ0dKFmj581laZ5sZr1wzPbAOEsGoL/GeiprsvvO
         lTSiCNh3bqPYqLXfz/PP9xpLm0SyCHFMtqO+mSQ162az7nht3/7GHqIve+Nht/ONr474
         exk0jGVXf4Xf0gqOlySJ06lwJUWv9vtoVfL93tzhsF/c+iM6CnCSzbgrG7mFy08zPYj5
         H+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhL8ojOEDCeRjq8lnqRotSOYRXvMJyFniRabRehKtW4=;
        b=IUiKfaOmRjza936m8bXk/+xcTPZ1BzUItmxFyCcotHPhdSQDoulJG5GgPl/1AJBl2J
         JbsU0VTkeuBSrBrhYcnCckD691UlvkK4olN7Jc6VF5uzXIq4p9+vJzbKrHoCZwwfLxjF
         0boGRXmW3f4Z5xJ3b856oWdPA6BX1mUjhJ0UkWgMpF9fmIcXfYhYUNPk3YYFbgUR65s1
         Fm9qMviP3OboZ09OBF+W6Gp4gFx0nzJ8aLf2NF08CgT4YtE20GcUZjiKINYCYaLPNYe4
         S6eG+k2fBEtFpH4bDgBIfKDdnkowe9/VL2YIRqbjt7Caid/sErMZLkenDXy/LvmG1aDE
         +axA==
X-Gm-Message-State: ANoB5pk/hUtcyDgyvW/mWt2MOlHt+Z8Z8QoT67DgoHctt7HNZkuwHmrl
        jusOSYUpXIZYFhWPYNXcuycitw==
X-Google-Smtp-Source: AA0mqf4/fD4EDjMB1bngWUQ2vqkoaHzdMWonW/058SIDj6yLNm4bsrQU7QQaNSSa6/pu86YK3k4/8A==
X-Received: by 2002:ac2:4e12:0:b0:4a4:68b8:f4f6 with SMTP id e18-20020ac24e12000000b004a468b8f4f6mr5707082lfr.60.1670843453471;
        Mon, 12 Dec 2022 03:10:53 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512060400b004b57a810e09sm1599110lfe.288.2022.12.12.03.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 03:10:53 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] arm64: dts: qcom: sdm845: Use lowercase hex
Date:   Mon, 12 Dec 2022 12:10:34 +0100
Message-Id: <20221212111037.98160-7-konrad.dybcio@linaro.org>
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
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b5fd14b6285d..376fcbdc08ed 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3903,9 +3903,9 @@ swm: swm@c85 {
 
 						qcom,dout-ports = <6>;
 						qcom,din-ports = <2>;
-						qcom,ports-sinterval-low =/bits/ 8  <0x07 0x1F 0x3F 0x7 0x1F 0x3F 0x0F 0x0F>;
-						qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0C 0x6 0x12 0x0D 0x07 0x0A >;
-						qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1F 0x00 0x00 0x1F 0x00 0x00>;
+						qcom,ports-sinterval-low =/bits/ 8  <0x07 0x1f 0x3f 0x7 0x1f 0x3f 0x0f 0x0f>;
+						qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0c 0x6 0x12 0x0d 0x07 0x0a >;
+						qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1f 0x00 0x00 0x1f 0x00 0x00>;
 
 						#sound-dai-cells = <1>;
 						clocks = <&wcd9340>;
-- 
2.38.1

