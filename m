Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1D06720B6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjARPKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjARPJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:09:37 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8697BE3A0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:09:36 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id i65so22942052pfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USFa3vv6r3M6at72+GYbrAEuQqTIcmw3cLL2W4/Vhuk=;
        b=cmYuIhAANGcRKBwdTJwKQYuynjulC3J5OWILnvz3+ACzJlZVyh5/WDOPws7HzqlY9j
         DfGoUQcwA9N1U1O8iA+nl5AEuab2iF9HIUJI6E6crHtvRRQTqAAJpIMMm7aelwAYcJMI
         Taj2lHHQjSyhGoGXCsASVyAUW7KrsSNOztUA3kTLLFnDMn0OOJbCxY4c7/9mh7Pr7eWB
         clPFv5Kpqu+KxuevvdPhh1oLiGKWjDDwDg2JRGx9z+pMjE+QPWbh7b4ewCmKxGGcfJEg
         +OdopkIYXpraF0P7bc6lTymbKPla27sQvZ1U4P0RJ9w/FVf9GuqhSmNOlhKV+z1wnqh2
         E9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USFa3vv6r3M6at72+GYbrAEuQqTIcmw3cLL2W4/Vhuk=;
        b=IJzsxQVm9RzHxYCdil/aJsZXeQRinERj2jip7ilZn21mzUAcdY3rTxRxK+MhZLlvc9
         hiHiKHZqYELcer++G+W+1igYtwQqjLJAE0EYQX8IhowNfxT3XX6feka+ROy23CCTNJv6
         A4h4MEYjk1vBMv8ZgcWkXQ9mqkIcfpLQnY2lp0jZ24gDsZ1t59xZuZg//K+1gGGyTX6O
         H8GoW33actscEh06x+V4PE92XEAa9UF9fOu8hBwlD2EfhNYwUw9sGiPtsJvZzWKLTSXV
         CiHUCm7v872UV83iX4adMnZs9IqZjiJIYUURQGCBzP4mWTZr2dpabUoMfr8wbeSJjBDW
         K+eg==
X-Gm-Message-State: AFqh2kpVxScy10TxZ18BEfxcyX/x3E7yGzcnL2xTfvX3oPTPd7Su1tI5
        HyRX50ngKAPo9GPLRGGcLciv
X-Google-Smtp-Source: AMrXdXs54CBzg+HOKSHpxtO01KYBqOTPdBnnl6Nwh/U6zt7gCduOwGc8JQgJvjVzLUxgDl8g0pAOrA==
X-Received: by 2002:a05:6a00:438c:b0:58d:a0ad:6d72 with SMTP id bt12-20020a056a00438c00b0058da0ad6d72mr8866852pfb.17.1674054576064;
        Wed, 18 Jan 2023 07:09:36 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.61])
        by smtp.gmail.com with ESMTPSA id i15-20020aa796ef000000b0058d9623e7f1sm6721544pfq.73.2023.01.18.07.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:09:35 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 04/17] dt-bindings: arm: msm: Update the maintainers for LLCC
Date:   Wed, 18 Jan 2023 20:38:51 +0530
Message-Id: <20230118150904.26913-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
References: <20230118150904.26913-1-manivannan.sadhasivam@linaro.org>
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

Rishabh Bhatnagar has left Qualcomm, and there is no evidence of him
maintaining with a new identity. So his entry needs to be removed.

Also, Sai Prakash Ranjan's email address should be updated to use
quicinc domain.

Cc: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Acked-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
index 38efcad56dbd..d1df49ffcc1b 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
@@ -7,8 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Last Level Cache Controller
 
 maintainers:
-  - Rishabh Bhatnagar <rishabhb@codeaurora.org>
-  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
+  - Sai Prakash Ranjan <quic_saipraka@quicinc.com>
 
 description: |
   LLCC (Last Level Cache Controller) provides last level of cache memory in SoC,
-- 
2.25.1

