Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEBA62B9B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiKPKov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbiKPKoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:44:20 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BBD326D8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:32:23 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j15so29201134wrq.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/17qFFdiyY8/qqzcwQc7JrCxEfqjOBVfmroYZxPEvcg=;
        b=lv8j/VygZ2Jknu5BYv9QAT2AkZ+ZRoYTxCuAFEx6BwPx8DuuVJ/dcSKBWoIa2+LGmZ
         qt8y8PRBhh0evs1Fl/qQZLo2W/TAQhDv9OyDHmUZlQHEa11GvmsFObj8Q1GAJ/IM02yV
         HSlPUHZJDzziRffY2guYgvP1+IrqRVK5Wh7PX5C+RAOeljyGkBB5P7vDIYLX8xWYIv99
         wB8+6p1IOG572HZBPP9mHXc/Edol+Caj9TLbdoIuJ7WlTvmMUmVzLv3rmNLok9isycPr
         TQPVX8hvGSn5y166hyKG9s9uRR2/soflJ+PRQXwK1rP1+2sbapNPv4f69XiX983vVruZ
         7Zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/17qFFdiyY8/qqzcwQc7JrCxEfqjOBVfmroYZxPEvcg=;
        b=wk1se6Kd8dyTi3gW+41X7h8bHxZV8Z668MaYMZ194+4GAT0nXMmZeH8lkGrGbMJ7EM
         A4yjfSwrIYVAObez7aUEEufkp0uObIMMJVmPBMMGrL6DI/7NI8QKdHYon1lBwCVFpKwn
         tn+1QKJ28vQGdW975lQ402CXermjFMKzVogHsFXt15nHGHMfZwbWg+sxLKVahFpK9YKd
         o0Cw+vp/m5XTqAHuNThEtMrd1fRU1DWc7xrTB0Hc6zJmLHZX+83EbueVnNA2Ohj9y2t9
         zFDNvFLMwpDFHJsHx+TS87jq74codKbtmK5YW0Znn0KM4/UJ1GMl1CG+TaQ8X8GMLTg2
         6Vkw==
X-Gm-Message-State: ANoB5pnkkH/i5+plEGJGWkZlWEFyousFlT2xuuXALNK5tSc8eF9K360A
        1l8r9ac2/U5L1Ci6Mi5vQ2sdgQ==
X-Google-Smtp-Source: AA0mqf5Uh4GdPBdY7E3OEzJD4PeNvqlCmmVxP+pAXPszmSQdlo8K3GxcP384DjGWot17DX0/cWjH4g==
X-Received: by 2002:adf:f845:0:b0:236:7d20:cd63 with SMTP id d5-20020adff845000000b002367d20cd63mr12512055wrq.284.1668594742274;
        Wed, 16 Nov 2022 02:32:22 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id bh9-20020a05600005c900b0022e36c1113fsm15107032wrb.13.2022.11.16.02.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:32:21 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/10] dt-bindings: arm: qcom: Document SM8550 SoC and boards
Date:   Wed, 16 Nov 2022 12:31:37 +0200
Message-Id: <20221116103146.2556846-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116103146.2556846-1-abel.vesa@linaro.org>
References: <20221116103146.2556846-1-abel.vesa@linaro.org>
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

Document the SM8550 SoC binding and the MTP board.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 7637cf27d799..a586a38c3461 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -68,6 +68,7 @@ description: |
         sm8250
         sm8350
         sm8450
+        sm8550
 
   The 'board' element must be one of the following strings:
 
@@ -818,6 +819,11 @@ properties:
               - sony,pdx223
           - const: qcom,sm8450
 
+      - items:
+          - enum:
+              - qcom,sm8550-mtp
+          - const: qcom,sm8550
+
   # Board compatibles go above
 
   qcom,msm-id:
-- 
2.34.1

