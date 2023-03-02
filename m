Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603436A85A8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCBPxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCBPxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:53:03 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5831B2D5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 07:53:00 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id g3so13935941eda.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 07:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677772379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eziIgkYWOJiCmTVuxVTqjJdDZwB/8c2NA0L0jdj0/Uw=;
        b=Fu87gzOTQAPfY9cQ6aCuwsLHru/2r5kvivRd+hFFr67onDK5Zdlq0IfKTe8TMnZRMT
         sss9b/L9x0Wrz85dNBTODs33rzwnV6iQex3MiErEPqbWQ2BTZ024UudYxKi4KExii6vk
         X7QmGtDDcZ8V8sEz63q38WrCathbEOnMxaJOHQqE5pGhqyx8HcqIZFumlEB74YPhuicQ
         wZ61i507wQwiHo/8QziKrdEnpFFtLRG44kSCZTJwXt5hrWmWKV194qVDv9jn5x+dksDo
         TKsueyxbCzwwMyNvGSiuk3pHr/EwcldYPuYj+cduOjHORS2hCdLFPbo17vyKAfzzyN0l
         nHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677772379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eziIgkYWOJiCmTVuxVTqjJdDZwB/8c2NA0L0jdj0/Uw=;
        b=TgH5t4yS+/4fPOxcNuOVg5V2z8PKPOP+dzfTNKEjz9F31AxoAtWUpYEB05eUfa87dM
         FZ20jxoLpmtS5HsXGhJGvHHqmf4Cn+1jPZm5OXOhfhrrglXChlVavWsZOeUmYNCT7zIb
         o2BYebvo7FgY46kYRKOvVAENWmYPkfdtrwbPDtxM0BlSjOuIq76qwhJ60syygKPXGYl1
         y6eyqOYFvZyYS6YG1tkMgMnPYoRI6PiUYBSRmkgC5IpHcY66E4dvt007B7Jk55sTfPCN
         4S+7qaPriV3uP0FDFpUu338dh0awtYhzBpZPRhLx67n0J8+RrdAE6XGYv/Iv67K0yaW6
         9YHA==
X-Gm-Message-State: AO0yUKW+2ifneRqYNKOPAzGMfKjA8RkrgU9/Rn3NgBw4Z3R4EfUBoTX0
        7rwlTDWJNAEt+o7d2IgX3Poiyw==
X-Google-Smtp-Source: AK7set/W7p21Eu9xzjAjBDf/kyoaf0+JSX0Ydk6Dr//aPVX78s6utFzky51f8iRCBZkcvVke3kCiIw==
X-Received: by 2002:a17:906:f892:b0:872:27cb:9436 with SMTP id lg18-20020a170906f89200b0087227cb9436mr11322119ejb.43.1677772378901;
        Thu, 02 Mar 2023 07:52:58 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u9-20020a50a409000000b004af515d2dd8sm7050994edb.74.2023.03.02.07.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 07:52:58 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: pinctrl: qcom: lpass-lpi: correct description of second reg
Date:   Thu,  2 Mar 2023 16:52:55 +0100
Message-Id: <20230302155255.857065-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description of second IO address is a bit confusing.  It is supposed
to be the MCC range which contains the slew rate registers, not the slew
rate register base.  The Linux driver then accesses slew rate register
with hard-coded offset (0xa000).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml       | 2 +-
 .../bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml         | 2 +-
 .../bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
index 200b3b6ccd87..a9167dac9ab5 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
@@ -20,7 +20,7 @@ properties:
   reg:
     items:
       - description: LPASS LPI TLMM Control and Status registers
-      - description: LPASS LPI pins SLEW registers
+      - description: LPASS LPI MCC registers
 
   clocks:
     items:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
index 8bf51df0b231..1eefa9aa6a86 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
@@ -20,7 +20,7 @@ properties:
   reg:
     items:
       - description: LPASS LPI TLMM Control and Status registers
-      - description: LPASS LPI pins SLEW registers
+      - description: LPASS LPI MCC registers
 
   clocks:
     items:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml
index 5e90051ed314..691bf60abb8c 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml
@@ -21,7 +21,7 @@ properties:
   reg:
     items:
       - description: LPASS LPI TLMM Control and Status registers
-      - description: LPASS LPI pins SLEW registers
+      - description: LPASS LPI MCC registers
 
   clocks:
     items:
-- 
2.34.1

