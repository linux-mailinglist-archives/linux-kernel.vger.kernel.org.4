Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2D267191A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjARKin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjARKf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:35:56 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEBD4941F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:42:47 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r2so33295734wrv.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pt/JJm940Gam2LIRx3QSoWkgX4byqrIffvsI/C/KsV0=;
        b=sfUS1CMDwRFsBQe4i3PY2aPaQmBKZrLHLl3G5sbouMWcToQfpFwjIYLh8nodluXetJ
         hndujeMsUchYZ++V2+eZr4Lzg9jM8K8DUn3d7d06RblUYDOJftIVU6/btuLjDmD4hbrJ
         gGGf00COG2NW1UpRcLKlX0Vw8vJyeJffbGvJfRCzzuKExQ3WUtXctxVmr+e6pAWYAgKB
         saQDd/F+1BO0Lld2ADAkKTimszTC+Dh/Al38Sf/DLnXGF+41JImAm1D13U7LFDGYFBlF
         96NZXnrDSdlcpo/kShMULGR2DCXYp8IMXIru1POWzrHDhs0RWNFWZCc73WC84XOCaC9l
         aHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pt/JJm940Gam2LIRx3QSoWkgX4byqrIffvsI/C/KsV0=;
        b=ZcKQOdTI4aSku/8BeKyPJ7C/r6w+Ccfyuhrskn54xEdwfqX3GknbGjKW7ezTdS1RxK
         /ToIMUAxAkTLK/EScQeTH55Vroh8C/+0fTtHR8q+6R5gRphsBtN0Ui14qmA2GUy28GRY
         iUQBY2bFra+fh5A2KodGYgWB/5Ff79TGYx28skyToyE5QqgzzYBLyNxPEFrj2fp40Ng6
         Pe9Un65XqCDNp8HS0C8Fp3WWMM5smF6bVO28uSfrBRGFEK0F4YUpii7jcmYYZanLmhLk
         ikdJmhc7GY/FSn5irIrRe9vO0c44pwQ5VRbI7Q3LjAIT4HQ1lCXraarjqDOLCd6fi32n
         FRYA==
X-Gm-Message-State: AFqh2koOCFMmcU3pJvwXIOMhPOAxQlQzpXinr+xz8EpdSoZAZXGmudNX
        MFVQNj2WtoqbQw8ZSZJ1L4+0Xw==
X-Google-Smtp-Source: AMrXdXt2JOaGMIqFBYWHx4lU4Y1wPUXsbD0FeV7DgwFkSD9ULgjwbFyUSc2kWinK/CEE1qW0HQ4aNQ==
X-Received: by 2002:a5d:4d4f:0:b0:2bb:e7ef:ed8a with SMTP id a15-20020a5d4d4f000000b002bbe7efed8amr5690130wru.50.1674034952393;
        Wed, 18 Jan 2023 01:42:32 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m13-20020adfe94d000000b002714b3d2348sm30972662wrn.25.2023.01.18.01.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 01:42:31 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/3] arm64: dts: qcom: sc8280xp: drop bogus clock-controller property
Date:   Wed, 18 Jan 2023 10:42:23 +0100
Message-Id: <20230118094224.51704-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118094224.51704-1-krzysztof.kozlowski@linaro.org>
References: <20230118094224.51704-1-krzysztof.kozlowski@linaro.org>
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

There is no "clock-controller" property:

  sa8295p-adp.dtb: service@2: clock-controller: 'clock-controller' does not match any of the regexes: 'pinctrl-[0-9]+'
    From schema: Documentation/devicetree/bindings/sound/qcom,q6prm.yaml

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Split from SDM845 audio patchset, so this can easily be picked up.
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 547454866c1b..fb1aa08c2524 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1716,7 +1716,6 @@ q6prm: service@2 {
 									 "msm/adsp/audio_pd";
 						q6prmcc: clock-controller {
 							compatible = "qcom,q6prm-lpass-clocks";
-							clock-controller;
 							#clock-cells = <2>;
 						};
 					};
-- 
2.34.1

