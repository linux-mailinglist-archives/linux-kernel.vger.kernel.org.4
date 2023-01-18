Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D56671E84
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjARNwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjARNvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:51:40 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D24A2B091
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:23:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v30so49588826edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60xbViVesinnCs8Gq9usNvmq6jftqqElQdF+JDe/eCU=;
        b=vMnArBtwFK+ZQHBIyDOCXanMsjFDGRnmqoZvZCRbbUB/mLky6/T/bIV+KhAzU8WYaA
         Wd/OWikKAqyta07XHjcZ8wtzKMfxryEPz7ZV4md8G0q0Y0USDT9dvDT6CrhchAcilTfV
         xn9CQPms374BHGV78tPJi7jBVAi3xNSH3xrjEUtv26WWP3uIeTfJG/k505qo8QH0wsSQ
         WhJcxuwCzeMqwQfY2mxT1lzI3ZTqucGW+u2d/oq+Gyy0ic14muFNc5znEimopr1+t9EL
         wo2jtrdeuUai6z2qI+0KjLYKwMA04Ey1ubCqKzGwksBO+4ZDasOZrNO7YG/HUij7Mh6Y
         rXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60xbViVesinnCs8Gq9usNvmq6jftqqElQdF+JDe/eCU=;
        b=pj4lBWcHI50gWoCOKXVVTSmnYCHwqMDpCzk2hr8es9Fae1IuV/2vK4z4grE9d5EAbR
         Ms4utmeN/mfthwoZJZIqiqszZIonUa4wJzhVP4t5p5pyDdeB8QISl26iiQ0FeoolERjm
         zdP/LFPGGkXub5SSb2ELyusYFDqNnxknFF7YtXkObMIoZyRJZzHczb8phs8m1XQtw9Of
         cyRRGTWdM1ec9ap8ME3OeEMAWlUh7gtQk/SOSJ1zt88FdrFJw79IbWUU23piub+QaXww
         5dlj7XGOb2w+F6WqU2yS6D1Gt28cOUMiHj6gv+W9EBjFochrWBMsdnbAWtyjd2JkFVhm
         FMig==
X-Gm-Message-State: AFqh2krKlyfDkq1x61ESeRiYboCHmLGDVGBHpSXhT4OrNLNCScrKhkJs
        jZaRLAFI2zvnMZLhoSWwx6BrpA==
X-Google-Smtp-Source: AMrXdXv4f7LT2d3zD2Ax7BTC3iK/2dSjk4ltLAGRw2xK239RRRMe20st10dqr45G9GJMjiROmYf+qw==
X-Received: by 2002:aa7:c709:0:b0:499:ef31:3549 with SMTP id i9-20020aa7c709000000b00499ef313549mr20674499edq.6.1674048178691;
        Wed, 18 Jan 2023 05:22:58 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709061da200b0083f91a32131sm14633831ejh.0.2023.01.18.05.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 05:22:58 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/7] dt-bindings: mailbox: qcom: enable syscon compatible for msm8976
Date:   Wed, 18 Jan 2023 15:22:49 +0200
Message-Id: <20230118132254.2356209-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118132254.2356209-1-dmitry.baryshkov@linaro.org>
References: <20230118132254.2356209-1-dmitry.baryshkov@linaro.org>
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

On msm8976 platform APCS also uses syscon compatible, so move it to the
block of compatibles using SoC-compat together with syscon.

Fixes: 60545466180e ("dt-bindings: mailbox: qcom,apcs-kpss-global: Add syscon const for relevant entries")
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 36deddca1524..ecc286ab49ef 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -20,7 +20,6 @@ properties:
           - enum:
               - qcom,ipq6018-apcs-apps-global
               - qcom,ipq8074-apcs-apps-global
-              - qcom,msm8976-apcs-kpss-global
               - qcom,msm8996-apcs-hmss-global
               - qcom,msm8998-apcs-hmss-global
               - qcom,qcm2290-apcs-hmss-global
@@ -37,6 +36,7 @@ properties:
               - qcom,msm8916-apcs-kpss-global
               - qcom,msm8939-apcs-kpss-global
               - qcom,msm8953-apcs-kpss-global
+              - qcom,msm8976-apcs-kpss-global
               - qcom,msm8994-apcs-kpss-global
               - qcom,qcs404-apcs-apps-global
               - qcom,sdx55-apcs-gcc
-- 
2.39.0

