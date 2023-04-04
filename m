Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948446D6A7C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbjDDRYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbjDDRXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5EC59F2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:23:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id er13so92599016edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffX6tYkShhHdyHthSV48egZWIylzQga0AguSbk+fhVU=;
        b=Z8n4csuGKIzZxlP8DBUC2z+H06eocPVGFPZfaiacqqc4wjxVR/CASnYlLluX5uMEOz
         Rhnfk+obi6KkOBIEly9ZdGnaYWuR73rIVhB+lP1iXnV614j9Ai6SYLsaVY7PCvwVvUAh
         aIz+mmHOHgDuc66QNT0YQjXGr/uVGDJMjJvWj8T9dVSRMbX/cxHrBf57o2+m1sTW08nZ
         AH9oD3rkU9WoufYc9wEdIBG8KeyS0TOqHV6H5Y8IEa97fngC4VA/tvDc4TRLT42bAY1N
         u8E0/iRk434AXNVVKtKrt01iAx8XBvbVXYmWpgE9/rutthFRz86dx9mLK7FaUXhMYKF5
         lftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffX6tYkShhHdyHthSV48egZWIylzQga0AguSbk+fhVU=;
        b=ir5aSi0q68tUI0Y0ADblUU5a4FGBxm7KIOfZHOuJ6dlIewRdfA5pVKzU/MC8NYWg2i
         WIWIa5Hb8bgCdXmRaUk9wSxzWkzOsGoJ5uKD2cg7tM6aE9BBvw0ymNiZokk/9laT26O4
         dKEQEX7LDzfOQkZKR3qR2DjeSdarcGkKDjxpDu98ih6RAGJPZj70IpNmKGxnYvE/hzS/
         wTPnYoZ/CmuFEHFEHp2ZO5J3lhFm9MDoaudnYKfqzWLWmQe3yIAiJrb9zrsTR2CY2m4K
         9C/RsTj7yaShj5Bc/xnxxvrXCJhOpOhEwF04ntuR5F9vSdZphywWW8qAZJxbVpskwcWK
         +Qxw==
X-Gm-Message-State: AAQBX9eHERZrHtmuJ/RC8qHw8JRSfyTbLXqWCiKBKo6pRA72Mn8WaJXx
        EGapRXD3VSF8Pe8geJeu6dm8+Q==
X-Google-Smtp-Source: AKy350bM4+TOxZ1k6cDLckP6zhB+GuHGGSy5ExH/I9z7rTrXW5m3g2T6NDdrYXJvCs05vf4u62dU0w==
X-Received: by 2002:a17:906:c7d9:b0:946:c1d2:8b53 with SMTP id dc25-20020a170906c7d900b00946c1d28b53mr267541ejb.72.1680628982148;
        Tue, 04 Apr 2023 10:23:02 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:23:01 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 28/40] dt-bindings: nvmem: Add compatible for SM6350
Date:   Tue,  4 Apr 2023 18:21:36 +0100
Message-Id: <20230404172148.82422-29-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@linaro.org>

Docuemnt the QFPROM on SM6350.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index e952907ad1d5..c20bd9bdcea4 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -32,6 +32,7 @@ properties:
           - qcom,sdm670-qfprom
           - qcom,sdm845-qfprom
           - qcom,sm6115-qfprom
+          - qcom,sm6350-qfprom
           - qcom,sm8150-qfprom
           - qcom,sm8250-qfprom
       - const: qcom,qfprom
-- 
2.25.1

