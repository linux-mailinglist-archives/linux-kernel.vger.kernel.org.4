Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01D05B5405
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiILGS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiILGSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:18:21 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4278C2A40A
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:12 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y18so9311387ljh.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ShPxgoMmuatqdGQWqNcZcpEJgDBD4NgqwMQX8EaKFn0=;
        b=Fc6pcgSEjUllry/Al9MHF/KiX476+f53LdQEuOfMlDgUBS0Y2Lysc5JDWCUJWQf/YR
         mRFsv6PSjAGrtHwJx0Xih2EBD9/NlJc2y4Pb00QpZlzGGHusAbnUn3OSEOy7U+ho1nQw
         Bxtw/FZYD0UVc8WE5M04VI0pWEfH88l2vEQZKCg7UTF5Mr2zRan172kVk/yiTBXWXjJD
         E5K7/zTPSikIe+QF+UtZBnoHqhCJMYeYIvbJPWpkM6cdUd4X/8WURI3c2oRGVgvS4kE3
         o5lvrBXuf2AqSQ3CfdWB1eC7CC154Dh/VZ88zoxSOwBsvX/nWfwWfnVIhzPW+EyKxs9y
         MfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ShPxgoMmuatqdGQWqNcZcpEJgDBD4NgqwMQX8EaKFn0=;
        b=ysv2g22haP31Ht6tI2cm6kQ5YqK/RL6fmGie4NCFqyQG8XSifjsBTPv0FHOUfUYQ+Z
         sJwBpzyWBlIzqQueFLa03mnz3GSS17gRKOKWxLdgf0ziVlim/HXEX+mOah92DyWrK8Rz
         xEd8TJ74NSoTs8ZvgoPRha3dzSoJHaZYI8mdP0V1uTsOkPgiKg1BOf25N9ZmBME4u0SR
         y64DWAG0fiE9Qd4BpGmkF8qQz3LilZjqv9zGqM4JRgCDZNpIlUyP8TnzKByyYhEM4Txe
         +npjb49NpBKqaU9m1RemDu0H9MMQQ1MgSOiHG8VvaMBbn4JP3Bxm8GIhYbkzVO7ehzL1
         f+Tw==
X-Gm-Message-State: ACgBeo0M5MENvHFQM2w2ZKQ5BoBOVMByCC6B8RBVTmFoNwXY42T0xr2J
        IjP0MLlGUqqOgi0TLWORX8hfyMbRg6d4PQ==
X-Google-Smtp-Source: AA6agR75yTn57lU+jCF17X4UVDBlpwHYMObteomolVN1OiWv6zhw6uhH6I3NQc12mYKAd+lqers/MA==
X-Received: by 2002:a05:651c:160a:b0:25a:62a4:9085 with SMTP id f10-20020a05651c160a00b0025a62a49085mr7579297ljq.214.1662963491657;
        Sun, 11 Sep 2022 23:18:11 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t19-20020ac24c13000000b004996fbfd75esm876805lfq.71.2022.09.11.23.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:18:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 14/40] dt-bindings: pinctrl: qcom,sm8250-pinctrl: reference tlmm common pins
Date:   Mon, 12 Sep 2022 08:17:20 +0200
Message-Id: <20220912061746.6311-15-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
References: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each subnode configuring pins (so the final -pins or pinconf) should
reference common TLMM pin definition.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
index 12bdc2e67c4d..bccc83f22aae 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
@@ -112,6 +112,7 @@ patternProperties:
         - pins
 
       allOf:
+        - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
         - if:
             properties:
               pins:
-- 
2.34.1

