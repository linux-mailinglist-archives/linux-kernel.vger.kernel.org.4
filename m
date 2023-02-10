Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B07692374
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjBJQjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjBJQi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:38:59 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9022375F45
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:38:57 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a2so5629605wrd.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xLYgLKmbZNDw4ZTbUshQjWmr9kZe7rczWa1zK2HXrmw=;
        b=rbwe1An4wV8Ylfyuue6rCuH+8GSaGhqlZ2s8Y/naXgB/CguV0FqElMCGzAvWNuokDq
         7cVFaIcxWjQZwDzkVLdrdu351ANLyKx7/qKCxyg4lpsLPIgHsqGQhSfLlAlMzMLtZHuo
         pimsE0NZ+s06Gz07k7EnOTbm72Ts+N+g047MD6ia5oSW+S4yzWzH3gBVJogzzKiArz+7
         Pya3wNtbPlZ8OIsjSU3HaTlMNwKv6YIo1AKtHcQij42o0RqH9Fo50trx+FuKLYDiaxAq
         M8o6a3fhx9jOP8KgocWKQuw1pBSHH875lXdfBnI66baKZT6kVrxRxZ8cQ7FAYCUDULp4
         O2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLYgLKmbZNDw4ZTbUshQjWmr9kZe7rczWa1zK2HXrmw=;
        b=Qmk2gza6y3zKII/ed2DPo0P8VeSwO2KTOeO+zErdUdquahivcX3aj1Je/RK5r5+o5N
         whV4+f0QBtViLSm4c7o3SadSUhKtguFtKnv1uG3OuDQxtz29538nqsQet59Ukzu7hUQw
         1ouvJc4tOQk3hN5kchu3WGUc0TSD/Svw6zPymLpSntA6TEDN8b0M7mVXTdwIBaadiLzM
         Aqjpv3YCurzsVgZ+XnTcHEmqXcv36GDCKd6y2/02zabJYq4hqd+DABrOiJBMBRMQ6dtt
         ldlZrshI3rKX5Q2S4yhBHKA5HJHoiGS3uq/kMATI+Ydg4iJpfTqL6zplJuSqvTSzhQOh
         TupQ==
X-Gm-Message-State: AO0yUKUSfUq8D5VLu6ewfSM/pk7Qnr/duT2AnfkrKh5CEva+PKr0xYYu
        5mlRK+Bx8w+ES6wYlwHnQ0c7Ng==
X-Google-Smtp-Source: AK7set+5m3/VbYfTUW5W2vgZPXjPLi2ZHQEIqmrm3TlVrH6DGSVKfdph2Ir/Ff9BPaAGfWjqLppWiw==
X-Received: by 2002:a5d:49c3:0:b0:2c4:7cc:b345 with SMTP id t3-20020a5d49c3000000b002c407ccb345mr6023609wrs.8.1676047136131;
        Fri, 10 Feb 2023 08:38:56 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o16-20020a5d6850000000b002bfbda53b98sm4045792wrw.35.2023.02.10.08.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 08:38:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: arm: qcom: add QRD8550
Date:   Fri, 10 Feb 2023 17:38:43 +0100
Message-Id: <20230210163844.765074-1-krzysztof.kozlowski@linaro.org>
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

Add board compatible for QRD8550 - a mobile-like development board with
SM8550.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 8b90b8d7e858..b1c6f0ad8c36 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -903,6 +903,7 @@ properties:
       - items:
           - enum:
               - qcom,sm8550-mtp
+              - qcom,sm8550-qrd
           - const: qcom,sm8550
 
   # Board compatibles go above
-- 
2.34.1

