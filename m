Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07C06D2604
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCaQpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjCaQpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:45:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF2FBDD6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:44:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x15so21022513pjk.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 09:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680281037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns2jPDGRWz/czfPYAkU0ANfXA6YC0owDF4gxQpajwV0=;
        b=aiimWe8pF/BriYtPf0PKn2U8465iFm5sNDYnZtgWj5CHvNm9VwbTArsIug5gxQlP2Z
         zrOvSMF/ptx4zOWzyWFjhYBBelyoVbcuPSXKJDcvVJBIkCwTc93woeMh/2IJDI747rDY
         CgzzdnLMZTIfli/q7zcINzyqmQw0eYwPFMxGeHlKfibPQCD9Jf2O8/Skgdg31EvJcEQA
         w1DhYtK2FdKnhkdIYIrP5rJIGrmXrjgxT7oQkr397823VjrmFDUEE2zhzgOLd5nvttcx
         gP/8GfSDhZRnXrNtQuXUIS+k4sL5WFxgURnXeERKDoIbyXQy+Q6eyZ3UKQNibkjGxVxv
         WrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680281037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ns2jPDGRWz/czfPYAkU0ANfXA6YC0owDF4gxQpajwV0=;
        b=GwHujkV7lHj8za4LuWT7UMk0XW8XazwvSoOHpS9zc2A6Uytxp025REXVKBvSxy6g8g
         SP/YeWAZZQwq7s3549m9fGzAiJKEJSPjE8wMfkKY2sboZjGInt5vLMKpXNkckQxbFmjT
         q5X+QN473zhMii6pEFFQZ0np2wz/K7S2MxLJbjaR8D85QwX51qoYxN7hQjOCbGnTef2+
         +2EiNJn9xu1C00xPeb/Va55lpL4cSqiTNalGIXuvg2Svo7hkcQ23rnaCkZXPOJRkhPOs
         hnkzgvBiacgXVAZ7xKFS3DOiU9nLeBiVSyP4WEXnpBbtPHRfmVoYf8Ot9ChZI7rw4m6i
         CWBg==
X-Gm-Message-State: AAQBX9cSXztJqKIIx9/26t1nkIV/fEm3VW/A/P1PUdWZGy1z6EvH0u9J
        zga/OO9OlksCq420Yzx/xLzTEQ==
X-Google-Smtp-Source: AKy350YBHz2GwuQS2tjXBT1r2+lcPRvkfPSLqAp9Kv6j/d4fJ/dNHxbGwE54Xnj5FtXfG3O9h4F+RQ==
X-Received: by 2002:a17:90b:1bd1:b0:23d:3fbe:2f7 with SMTP id oa17-20020a17090b1bd100b0023d3fbe02f7mr30224030pjb.20.1680281037447;
        Fri, 31 Mar 2023 09:43:57 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:53ce:1f39:30a5:d20f:f205])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902b40d00b0019b089bc8d7sm1798767plr.78.2023.03.31.09.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 09:43:57 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v4 05/11] dt-bindings: qcom-qce: Fix compatible combinations for SM8150 and IPQ4019 SoCs
Date:   Fri, 31 Mar 2023 22:13:17 +0530
Message-Id: <20230331164323.729093-6-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230331164323.729093-1-bhupesh.sharma@linaro.org>
References: <20230331164323.729093-1-bhupesh.sharma@linaro.org>
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

Currently the compatible list available in 'qce' dt-bindings does not
support SM8150 and IPQ4019 SoCs directly which may lead to potential
'dtbs_check' error(s).

Fix the same.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index e375bd981300..90ddf98a6df9 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -24,6 +24,12 @@ properties:
         deprecated: true
         description: Kept only for ABI backward compatibility
 
+      - items:
+          - enum:
+              - qcom,ipq4019-qce
+              - qcom,sm8150-qce
+          - const: qcom,qce
+
       - items:
           - enum:
               - qcom,ipq6018-qce
-- 
2.38.1

