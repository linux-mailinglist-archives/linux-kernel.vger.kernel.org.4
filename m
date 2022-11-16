Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EF762BA85
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiKPK77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbiKPK7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:59:20 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047D44298B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:47:47 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id j15so29265622wrq.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJxUFcdHKjr4TP8R8EA3QBzwAhzzVXzRHDnLtXx5EIY=;
        b=FrBA40W+GiQxCiSP3KgQ7VPBV0ymcitTnFVrBs+OrIo4B7rDcYuGIi4ZgoCrcmOTPY
         cdYm9j4cgHGiYi6nXR8Phwvoa2s8W8Os5mdR8g1sEb1tweWFBZK/0PSc3PZuEV9GjmHf
         Lra9qUkDqMnVCM3RBC0d2M9TEV23QztteqvHIVBJbdiW2MmKtRsN1ltEa+S7TxqqBBhy
         LqpVBYstFXbPj3bPJ0vLGpgnLtj2P0Yi/ofdtbX5+8WO5vE21ah5mU9cS6vaXxnMyf/B
         s062ZGMPvzYfLZ6PxA0w+sju7GC1gtl6yt0EHQ3i2A8LQIB7UefRb0Mqwme46d+ZBF0n
         BWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJxUFcdHKjr4TP8R8EA3QBzwAhzzVXzRHDnLtXx5EIY=;
        b=rf4Bpd8kY+fbFkJgcbKAj62ucG+Q11tlJlE6hESbruu/y1l+AtJEkEJDT21G4e9CR/
         l8H+hks+1UwTWW2oOCzhXRWS5bUqALr7QLJggEJHnCf7f10DmFWoDxE3oGZo8+rSXBV/
         uIrXFM0CZGll80HZa7kdTmSjcB9Q/C99wM8CbPdRcTko7xbVxbtOcJm2yKVvDAtTyu7n
         lEi0ySg/8Swn1pd02GuWkTVFPJfhIcxgPZW/gh63CLiTc2xkop2MOxmdj8uV0XYQ8kTx
         HVgr0gpMBDXPOztnIJkzRadjxUID9tNtlFjOclv/+xuxBSpHQ2EduUGSRw0McsEDwHdA
         34kQ==
X-Gm-Message-State: ANoB5pn4bVd2BhtaY3fLRXdVmamurOvoY3+nDZ5WGQ05J50ApxMpBXul
        HbB+qAZILWt0U3nXFmK6w0FIIg==
X-Google-Smtp-Source: AA0mqf4AqhTYO9x1Xkm75kGlNZ7hDL6G2zUadHc/kedvGRm13FKOvotd8qFlifEdm21f8XLWhcKINw==
X-Received: by 2002:adf:f18e:0:b0:236:b8b9:b018 with SMTP id h14-20020adff18e000000b00236b8b9b018mr13826296wro.596.1668595666489;
        Wed, 16 Nov 2022 02:47:46 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id b3-20020adff903000000b002366fb99cdasm14674206wrr.50.2022.11.16.02.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:47:46 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 5/9] dt-bindings: clock: Add RPMHCC bindings for SM8550
Date:   Wed, 16 Nov 2022 12:47:12 +0200
Message-Id: <20221116104716.2583320-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116104716.2583320-1-abel.vesa@linaro.org>
References: <20221116104716.2583320-1-abel.vesa@linaro.org>
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

Add bindings and update documentation for clock rpmh driver on SM8550.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index fccb91e78e49..b405da7700be 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -31,6 +31,7 @@ properties:
       - qcom,sm8250-rpmh-clk
       - qcom,sm8350-rpmh-clk
       - qcom,sm8450-rpmh-clk
+      - qcom,sm8550-rpmh-clk
 
   clocks:
     maxItems: 1
-- 
2.34.1

