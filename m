Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314D360F163
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiJ0HrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbiJ0Hq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:46:59 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ECC168E71;
        Thu, 27 Oct 2022 00:46:56 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f9so552802pgj.2;
        Thu, 27 Oct 2022 00:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7eZPMxhWXLAdP7JOTovMyPi4TE0q0a0Jvomoy/MT8tw=;
        b=Vsy6ZN8gN8QvBnQr03269m+9k5zizOLHe3hBf79CANsb7LyA1/zH+HWj36gdXoFvKc
         SwuDRXtPoL9x9kVL66wnByKZD7iHRkU8jwhYQCNQTVuvqx9M4+JGove6EnxQNXu0oLwO
         fmK4M9lsIlIUnid+HyTKRSs9twfGen+mJp2tlnAgELiuLZjL4aCP1pIkg3EoAg+94TPB
         8SHEHdF9cLSjCKo0oah8Jlua5t6SuZS9Wscgnd41JoO98l/WYemMKVf1kYw+tY8Gn7cG
         r5EZ93OaCsFVhSEZ7yd/HN8d/k71cLbR7K1kEtehFPiwh8Rks2syPRj4UYTs9PJ6lgJC
         5o1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eZPMxhWXLAdP7JOTovMyPi4TE0q0a0Jvomoy/MT8tw=;
        b=bjgqyJAkC8m9K4HMr3w748JBrD38gWVqRM8+xsUXKtU1haDro+C0fTHAd90X+1DPwA
         h4Vtnzqpe7ydklwWkrOw3Ov3hLoyjY6dCxUSx+Dp5BMX+1PpIg5kMTIZUjOskiCwHtuA
         Scj/s2hHtW7fl8o4wUsWzrnWoeYOLd/kXNOUy2+ZabI3SFkzhmtIXSgzmUA/BOKwRIh2
         OEQ9y5Id4U44PLs2XGCCFiz2aEAmmhkcWQLu/IiLBOpfoWQuLvmpBGNVezF/nH4cnvEH
         9znhYp2gyfArsKDjQsGqyCLoUWnLb4VfDY8qz6KAg6UrdZw/Jjpv8bz5MtGb01baMsCx
         qIog==
X-Gm-Message-State: ACrzQf09VuBZ11fH9rOKfD2bL4x6ok2I9ft/2iiZXPxV+DgXpEj/kuRT
        Sf7QlWZcIV0TdykBrDXauVE=
X-Google-Smtp-Source: AMsMyM5PGiH/y2F3FFolvyUUUvcKWHQq2NBuOq+yFYxmeaH75p/1LDgLZHZQ/ZvK7ktzxwNEi++vVw==
X-Received: by 2002:a63:194b:0:b0:457:7295:8de0 with SMTP id 11-20020a63194b000000b0045772958de0mr41849875pgz.612.1666856815733;
        Thu, 27 Oct 2022 00:46:55 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:99d6:ae15:f9aa:1819])
        by smtp.gmail.com with ESMTPSA id i4-20020a056a00004400b0056ba02feda1sm611386pfk.94.2022.10.27.00.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 00:46:55 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] arm64: dts: qcom: msm8996: fix sound card reset line polarity
Date:   Thu, 27 Oct 2022 00:46:47 -0700
Message-Id: <20221027074652.1044235-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When resetting the block, the reset line is being driven low and then
high, which means that the line in DTS should be annotated as "active
low". It will become important when wcd9335 driver will be converted
to gpiod API that respects declared line polarities.

Fixes: f3eb39a55a1f ("arm64: dts: db820c: Add sound card support")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 5ff8de3e3de7..d5271718d03c 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3354,7 +3354,7 @@ wcd9335: codec@1,0 {
 					interrupt-names = "intr1", "intr2";
 					interrupt-controller;
 					#interrupt-cells = <1>;
-					reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
+					reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
 
 					slim-ifc-dev = <&tasha_ifd>;
 
-- 
2.38.0.135.g90850a2211-goog

