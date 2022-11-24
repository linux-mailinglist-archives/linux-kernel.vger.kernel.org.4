Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28E8637F49
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiKXSpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiKXSoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:44:34 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104D4134110
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:44:01 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a29so3680552lfj.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVrcHr8M8g+X+IjIamBy7xJQroBzKdxIzP2voTF9VV0=;
        b=hDXo6BZhUv/y2cwG63DN+/++48ELKOiqMPH8mrPvSvGT6vNs+wDJQAUQ6YV05qiTJ0
         vExfY3dsgfYBpm5CXbOeHgImIsM6RyTF1neUfPi1IliquK2XerIEA2D8Nwy56l1yBM5V
         0/0gG4hREL9dm13097+9vX4fSHDcimf+d2rP7SEP6hCrE0hRLE67f0+PnI79Pl7g3Jr0
         MezRE4HUJZ+xZ0jdV8oQBPS4AsoUC0HHX2ua7AxhX3JJNLmly1+u+n5vhvqtzMnYMXCM
         SzE5vqU3LOlyxm7wOEEEkZptGaqP72vnLuAHME+rnwqqQrtreGrMo2UrGXn/xPVeb0Vb
         Tv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVrcHr8M8g+X+IjIamBy7xJQroBzKdxIzP2voTF9VV0=;
        b=hNKv4gmgqVLygd4Mw1ezYah8HQBUpRvQxJ1rI+fQdGUpxf2ldio+avSyK9xQU8ORjT
         2goJMkTd7U60+kOa5CK6RAbmNst2shj+fyc1a2b78M0/HvkXughRX0x+j0OQVUCOJA1T
         WhVWyvByA+d6ILO4+E7IGb13ZB3aG18QR8/IWbaG2c3bVpT2zrc4pejvpb289Phc9p2/
         bN+Ec6xeG44WgZVg1FqGz8gS0DGJ+ihBp2sFKSjN1Q7sjdIVGZrzSsggL5sROlM3WlrZ
         ev1rNJhydeKw//4NXtu5qqwbKvYPtExIS8xZvVaQb1WuZeitFjqKWJ0M/Ug1eI8NpsSI
         y9KQ==
X-Gm-Message-State: ANoB5pkxcdnntYHDosZYDVn/Ca3rCl/sHtbuS2b5+WqVziMBfxNrVAC5
        7kNIO4fhXLD/w6qeoxuKD12YaA==
X-Google-Smtp-Source: AA0mqf4JvI3oYpINOWGsJnFaudDZbsRl7z2AV+MaaauJxlKO80rZ13T5Dgrxk2+SNVpf9mDyJ9JdFQ==
X-Received: by 2002:ac2:5f42:0:b0:4a2:645b:15cd with SMTP id 2-20020ac25f42000000b004a2645b15cdmr6213235lfz.308.1669315441409;
        Thu, 24 Nov 2022 10:44:01 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v7-20020a2ea607000000b0026e0434eb1esm159098ljp.67.2022.11.24.10.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 10:44:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 15/15] dt-bindings: remoteproc: qcom,adsp: correct msm8996-slpi-pil clocks
Date:   Thu, 24 Nov 2022 19:43:33 +0100
Message-Id: <20221124184333.133911-16-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
References: <20221124184333.133911-1-krzysztof.kozlowski@linaro.org>
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

According to DTS and Linux driver, the MSM8996 SLPI PIL takes two clocks
- xo and aggre2:

  qcom/msm8996-oneplus3t.dtb: remoteproc@1c00000: clocks: [[20], [3, 64]] is too long
  qcom/msm8996-oneplus3t.dtb: remoteproc@1c00000: clock-names: ['xo', 'aggre2'] is too long

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. New patch.
---
 Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 7848d1d658f4..9af2db72b337 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -54,7 +54,6 @@ allOf:
               - qcom,msm8226-adsp-pil
               - qcom,msm8974-adsp-pil
               - qcom,msm8996-adsp-pil
-              - qcom,msm8996-slpi-pil
               - qcom,msm8998-adsp-pas
               - qcom,sdm845-adsp-pas
               - qcom,sdm845-cdsp-pas
@@ -72,6 +71,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,msm8996-slpi-pil
               - qcom,msm8998-slpi-pas
     then:
       properties:
-- 
2.34.1

