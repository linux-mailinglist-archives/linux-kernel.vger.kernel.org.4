Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C6D5FB950
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJKR07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiJKR0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:26:37 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7AD3134C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:26:19 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id d13so2602896qko.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+/y5DQHVlPqDEJxbMYvIvUIy9E2WmWV37aVNLexaIU=;
        b=J+nDgP5O2QZW3FD4hy8X13w17NGGjyv/z8wOOrdBaA32E56n5VOETRKPsB9Gp80tv2
         /4sDcnmBHUz/p/1/01jSZxDONRMH6OYAAezU5i89uc9LYqoYqPIXVGH6kQZlivAPNdij
         IRBW030CcZsadkZW24SA+SVTkD351d2nx8IkYFXS0/MpSCGKTgNg0EugvHUqb0yrT5ME
         uKpCS2bj6p35Z8In8oy9Cb4oUsGNxdGbTiXlZLe8I2MwqjqXrh+adK3ry9z9kkwKesBW
         UULwm1OsOnw2EKK43keEMWK32+/LsiWKtC52/fDEOcNHbyLVq/6Dyh/Zit3/5xEwx58h
         Q6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+/y5DQHVlPqDEJxbMYvIvUIy9E2WmWV37aVNLexaIU=;
        b=eQOgOyHbu2XIzOsn6ltUi51NTlGVIw6mX/vYjeOWc/tzdtSXvpLwcKl1r0Ll4PoRVz
         IwEGhtANPCZTW4ko/pEaL6X22MRrK7OUxAKdiwuqJ5SqZNf/2XLPoLv5ZF1kDO1ZpZLx
         7Bsr6cD8oLwX+wk5MKc46yQw33fIJ8oYhtB43bnDhmHwyRms9bcM6euJIXaEI9QqVr89
         2sEv0foydoLee2lJWenl/1JNsKBwNThCHTZxTG618YAQkKzc7tf6UJlzZDue6zGrUV7C
         1u8enTz2gwYIIGduQyjZfX1O35tzZ6GznDlkkXXgVmdLAjroHRxRV465BM8bBv2mXUH0
         bIhQ==
X-Gm-Message-State: ACrzQf3bWc0i/Lm8wFlrbJYSre3Km60AuarG6Ds4sYqPr4iIPtMSe0lp
        6cGQSQVyeB1uHsKqL6PBGBNIYQ==
X-Google-Smtp-Source: AMsMyM4VhEILdrPDZTNYufQ0ygnOX9eIhHHmYEShCRZ/+1LJa6CdeGCPCOa9PMdIMIQwVJTMHE6yAQ==
X-Received: by 2002:a05:620a:2b42:b0:6ed:f368:c717 with SMTP id dp2-20020a05620a2b4200b006edf368c717mr5807981qkb.154.1665509177589;
        Tue, 11 Oct 2022 10:26:17 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006bba46e5eeasm14289087qkn.37.2022.10.11.10.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:26:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 08/34] dt-bindings: pinctrl: qcom,sm6125: drop ref to pinctrl.yaml
Date:   Tue, 11 Oct 2022 13:23:32 -0400
Message-Id: <20221011172358.69043-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011172358.69043-1-krzysztof.kozlowski@linaro.org>
References: <20221011172358.69043-1-krzysztof.kozlowski@linaro.org>
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

The binding references common Qualcomm TLMM pin controller schema, which
references pinctrl.yaml.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml         | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml
index 843d110df240..50f721d5f843 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml
@@ -13,7 +13,6 @@ description: |
   in the SM6125 platform.
 
 allOf:
-  - $ref: "pinctrl.yaml#"
   - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
 
 properties:
-- 
2.34.1

