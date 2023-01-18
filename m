Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EE7671917
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjARKhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjARKfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:35:47 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D72149400
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:42:45 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b5so12131510wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c11ZbMdZ6CbR/mvUDBlMS1lilf+DHkhh5Ihu84dTUVE=;
        b=hZKZz+lnxUovUiiGxVM3l+A/RSBOtJaBnGY3UkTiMlcVqLx1VEBqtrh9rk0Xopo+HA
         HWkLfIQ7e87UA5S03VQelaYMkftUxBrh1sUUa8isG4h2sw02xRQjj7F1Xs+J1c/DE/2d
         coKhqajODBmQsSdCdYQFgkas5mOV5Fbomhb3aqS4mxFBmni4LKH9y1QCqwSdsq3t2N4P
         OMeNnFo5eurFs5vaQ8eSIx87qg7qXnFPnV7JMRgy4Hcq2vcWYJvlUF5Vb9HH5Pw2PYCY
         f2TiKGNCCgKvdWExVP1oaWHSBrO3bNR87HOkPFnTXE2Fg1qVEj9W9YSDG5hGbuBYSsCC
         yilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c11ZbMdZ6CbR/mvUDBlMS1lilf+DHkhh5Ihu84dTUVE=;
        b=ebYjohqQ4qNzkfwJVwSDbZKxTcJjNtS/ZASYFwmuBixceGkn4VSHGJrz77zDyZiN1U
         Ajq4u3MtqmMmEP4m6txpI6clThNlT4npyno2YkmkCUFzM6va4ssgSWLwL695aX5Eyc17
         Qzd3KqV0LE3K5a3G+I+ZW56Epq8k+wwdqZ6iEAMck/Xt0Spu4zmKhio0DeAIgek+XAmp
         bmXdF01HZ9Tz7nXrVWT2pg0dQkgvh1LenZ/rn1bn1bJVEoGzEsuJRZoN6NUN6GQOL8WM
         91dokyjkgSxYUIABtD+nfzcZCqqtADDJhfZWGNIKB26G7VjF7Sc9fP62F870kSUOK/VF
         QAtA==
X-Gm-Message-State: AFqh2kpU3VTSXHYqgPZWyb6/PY1oE0r1UgzhgOQWQ4IbH8rpSDBq0nl1
        nuBTQXnz6vVFG9MKf6njfPB9lQ==
X-Google-Smtp-Source: AMrXdXuN6LTcHYyVsgIQEDbl/n4CyNNDt40KrlPNntvuUqzdcGb+sAFsWbqCydmGsTKrPJ1lIy87vQ==
X-Received: by 2002:a5d:4606:0:b0:2bd:e960:9855 with SMTP id t6-20020a5d4606000000b002bde9609855mr5663227wrq.18.1674034949954;
        Wed, 18 Jan 2023 01:42:29 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m13-20020adfe94d000000b002714b3d2348sm30972662wrn.25.2023.01.18.01.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 01:42:29 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] arm64: dts: qcom: sm8250: drop unused clock-frequency from rx-macro
Date:   Wed, 18 Jan 2023 10:42:22 +0100
Message-Id: <20230118094224.51704-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Neither qcom,sm8250-lpass-rx-macro bindings nor the driver use
"clock-frequency" property.

  sm8250-mtp.dtb: rxmacro@3200000: Unevaluated properties are not allowed ('clock-frequency' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. Add Rb tag.
2. Split from SDM845 audio patchset, so this can easily be picked up.
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index f614992709d2..b22569101314 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2301,7 +2301,6 @@ rxmacro: rxmacro@3200000 {
 			clock-names = "mclk", "npl", "macro", "dcodec", "fsgen";
 
 			#clock-cells = <0>;
-			clock-frequency = <9600000>;
 			clock-output-names = "mclk";
 			#sound-dai-cells = <1>;
 		};
-- 
2.34.1

