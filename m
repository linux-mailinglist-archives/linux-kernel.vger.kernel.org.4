Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E53C686AC5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjBAPvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjBAPvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:51:19 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B18274A48
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:51:18 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d14so17734568wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8fMKAAdBe60LyrW1GiaGrm1GztSVGVImruAPaAqIHU=;
        b=i3oTJDZB7uXkZcw5uj83S6gdpSUW7UoZqiLH0RFiaLv5tUHosVfDEGGbGPMxoKgqAq
         lxkF+PCOEXdYHHgRJlzGy0onLWzEuyk1vxddcw/ozpu2pOR2oWIVLpzmAnP4em98Pmwz
         gEnVfm6yYRr+HJNEGZiCxqz+LwtW53BNl5/ZEi8dUGdEJqu8fbdvYivae0NXXzHCBGgg
         d0r63PK0dpB0SOgQLBAtlbaArrVY/c3ZbijdHXtI+oEb6SVYnigSIf8f620RlpAeUo4S
         Mo2414U+mgcG9SY9VoZkvILbdYjw2C8v+QS0FwS6WJedy6CI+Rg8vxl6xoKa6NlWQwTQ
         OqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8fMKAAdBe60LyrW1GiaGrm1GztSVGVImruAPaAqIHU=;
        b=eLhAvrMURtK0zG54uRwG5Edv7GZaw0JbZBNycspTxAxIOOyviuzW+OxLTydHjzu6Ys
         vFeNKIj3R4PSldQI1SuVaYwP35Kk+hZVeZW8YPams1MxYEGu1dbFCJGYIwgHqGEz2dwg
         OJLWfVxte6I/jSqcw+FHABJvYj4QWmZRLR7s2KS0Dz7+qlAc3iyoUZfbkT3ohZFLbk6o
         c+p2bF+p2DEgDwKXqYxpf+FIqev5D+xUui6YufwOPGz3qntU1FrXTiICCcB5sNph2Ia+
         J5xGLpj2CwHqqqMiVd5n5YDQ98Ny85e0CHVDbQdU0F4an9nzQuckxjCaLy0MhoisQ1Hu
         7QIA==
X-Gm-Message-State: AO0yUKUMdGMZ1VwOutytllIV/9j6pOnIHPmxWOLxH5Tsgop6U+FChCL+
        UhZdPrK6Z0aqtVPhTg2MXOrdVg==
X-Google-Smtp-Source: AK7set8tVWniErKogHMyokhOsYmoIvNj7PbBYh1oUUq1235lb07Qyq/qsXVOkpy9mrXvozFPfVg/Ug==
X-Received: by 2002:a05:6000:186a:b0:2c3:9851:e644 with SMTP id d10-20020a056000186a00b002c39851e644mr3703390wri.63.1675266677075;
        Wed, 01 Feb 2023 07:51:17 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t1-20020adfe441000000b002bfd524255esm14816189wrm.43.2023.02.01.07.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:51:16 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH 05/14] arm64: dts: qcom: sc8280xp: correct TLMM gpio-ranges
Date:   Wed,  1 Feb 2023 16:50:56 +0100
Message-Id: <20230201155105.282708-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201155105.282708-1-krzysztof.kozlowski@linaro.org>
References: <20230201155105.282708-1-krzysztof.kozlowski@linaro.org>
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

Correct the number of GPIOs in TLMM pin controller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index fa2d0d7d1367..17e8c26a9ae6 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3533,7 +3533,7 @@ tlmm: pinctrl@f100000 {
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			gpio-ranges = <&tlmm 0 0 230>;
+			gpio-ranges = <&tlmm 0 0 228>;
 		};
 
 		apps_smmu: iommu@15000000 {
-- 
2.34.1

