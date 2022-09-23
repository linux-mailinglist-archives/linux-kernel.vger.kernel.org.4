Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6955E7F7B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiIWQRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiIWQQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:16:22 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA25F13EE97
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:16:16 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id a8so1004268lff.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rQi7cXeOGY/HNtdfUBGhQ3z+Yj+bhensaF8Epr2+VKg=;
        b=bP+EYhTbDFAc/wpZjl1F+uUYw0akkDcMgOciFC6ZrTsiuDtJHRDli2oc+mgz1bjBEB
         bnhvHFeOAwNM2l6f7BThVz+vU96aoGVEJkK5fdG3sgYxl1lmP4B92j3L6yyXFAWWq0+4
         V36Sb4LRJYOLhjOtaFEsrYiwanKnuwGvDtJjQwJWrLS7npcOu8MvFXs5od+poKHQ8ziT
         Ar0hGKSeaxWWuwpO6YDVm10TkyFq1MzJ/ky6K7kq0tmONOPlgnnbJ0vjM3Yjbef7Y+7c
         rtikQwEl5zIMmSRfMvu27qOm9jryi4+IiGImadCpa0rZA9BGdNGOL2F1CXwqMCJfyu5d
         LT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rQi7cXeOGY/HNtdfUBGhQ3z+Yj+bhensaF8Epr2+VKg=;
        b=VUfEC7k1ixXYXi0Qr0iFcSSPk6d2iCVPjbYha5V2Ifc11lJ6ygCYwPtT/qvUBg7A0M
         b4FV+cpKp/q0znl5TmMi1tSsKqlmvxWBFG1A7vbBPdKmyCJZud2sglwv8KFrLj9Xaa1x
         MXC4DIaT1TKGGgLQ/fjHGMFSdA3kyY1xqw7i0EW384xZ4FWhUZtLahEy42k1R6wFmFK+
         ql8bo5OUIRcRk288dFbSuWpMyTMjwIuxsrQByRIaYzBKGuOaP9o71sEda6gffKsbYSmo
         9CtChFDmcoXdrDtbIgH28DIzLU2CFB6EySUPTNNDG6lP4o0zpn2lzBariiVso6oqOzwG
         az1g==
X-Gm-Message-State: ACrzQf0FABPXPnku5Duv3fuY3qnhc2MNvI08hKnYq1TVjGK2dcd26fgz
        eq0pKC1YnSYQp2YP93AdawIqCg==
X-Google-Smtp-Source: AMsMyM45foDdKrFAiARyJ50xgSYYLky1sNK6COgku8DrtsekyXVpzDgebpoNqHI+fdvo0Gp4kR4Fjg==
X-Received: by 2002:a05:6512:2586:b0:4a0:54f2:772e with SMTP id bf6-20020a056512258600b004a054f2772emr1218043lfb.663.1663949774809;
        Fri, 23 Sep 2022 09:16:14 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f9-20020ac25cc9000000b00492f45cbbfcsm1493491lfq.302.2022.09.23.09.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 09:16:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 08/11] arm64: dts: qcom: msm8996: align node names with DT schema
Date:   Fri, 23 Sep 2022 18:14:50 +0200
Message-Id: <20220923161453.469179-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923161453.469179-1-krzysztof.kozlowski@linaro.org>
References: <20220923161453.469179-1-krzysztof.kozlowski@linaro.org>
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

New slimbus DT schema expect only SLIMbus bus nodes to be named
"slimbus".  In case of Qualcomm SLIMbus NGD, the bus node is what was
called "ngd".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8b31f4655cb8..341295be7609 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3309,7 +3309,7 @@ slimbam: dma-controller@9184000 {
 			qcom,num-ees = <2>;
 		};
 
-		slim_msm: slim@91c0000 {
+		slim_msm: slim-ngd@91c0000 {
 			compatible = "qcom,slim-ngd-v1.5.0";
 			reg = <0x091c0000 0x2C000>;
 			interrupts = <0 163 IRQ_TYPE_LEVEL_HIGH>;
@@ -3317,7 +3317,7 @@ slim_msm: slim@91c0000 {
 			dma-names = "rx", "tx";
 			#address-cells = <1>;
 			#size-cells = <0>;
-			ngd@1 {
+			slim@1 {
 				reg = <1>;
 				#address-cells = <2>;
 				#size-cells = <0>;
-- 
2.34.1

