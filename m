Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AAA5FB9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiJKRai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiJKR3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:29:30 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFCD67CB7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:27:22 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id z30so8921689qkz.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iE4vSe5hWotrWOkI1wwSCz4sPd387WiOtTSfYxWCa6o=;
        b=dZmo1b45YEmm2h0BhiXxBwGapZA58uQqNXW8KRfau6sjUUmFoy9OSGZaKnzElDtGhu
         V5Zeq1oqY8NJBF5xPgQstbwJG2+BOveHyKK8rVeXk7mpDxijSo9ZVpJHydgu4l9KF7M/
         r9r0thhFcu7rSrygSJNxlhSRaBdNz/N/cIsnNUaMI1Y3cMYms9FV0eeWClI/YEwZmpA9
         J/HcoG3LM3B2BX8AtG/ue3W5AarCElJg6i4uSb+HxdNWue3Q1IRP/7csaqrTgj17WhBU
         vK1utmJ9Gy8RgZrTHW+n6Yl+meKkK0n2f+MESecyOaOnLYIzj/asUSNxDt4BNWnOAXvP
         QyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iE4vSe5hWotrWOkI1wwSCz4sPd387WiOtTSfYxWCa6o=;
        b=HFEMJv8N54aP3ONrBlk1asLDr/KnwMNp5azrK+AMem7lWZ7p3mTfzSkILT5i2qp0ZP
         lP4BbtXfec7LvERZqxBFqVdmb3+PSBe1M87hHr+NqcokoC8NVQCiVpovVSQOePNj7tgR
         i2hkjTUNpbo/U2D9mhUlAZQrjgJ45CDqW/EixOoiUVoOAWOG/9bj7JHb0dluAKi0WODU
         D9Gx8nrHnOPv5Hq8Sgw3XvK4T/cUcUujgRFVebmFm1G+869D+SPwfaJ/EALLR3BzWw3T
         6Q6Rm5um1OEoLGavrnYsvsUEIt4CWFMStizFY3bjjVfr64XUUqjxUCjhEg2sH1RNX8yo
         2F7Q==
X-Gm-Message-State: ACrzQf1l6mcjRmaDIzoooL2KktrvL2UGeLBesH6p9sDKSRG0vgiMyoJH
        nf5IrtKoB3r5SxEYAcuyNhCfCw==
X-Google-Smtp-Source: AMsMyM70Q2EWNEsPAKjhKUqBIPhIiCqDrfR217oy86TT6OhSHRTMxCXNyPWhXrODcQ9maR4unzOkDg==
X-Received: by 2002:a05:620a:258a:b0:6cf:ca19:1ec2 with SMTP id x10-20020a05620a258a00b006cfca191ec2mr17791939qko.630.1665509215819;
        Tue, 11 Oct 2022 10:26:55 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006bba46e5eeasm14289087qkn.37.2022.10.11.10.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:26:55 -0700 (PDT)
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
Subject: [PATCH v2 32/34] dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: minor style cleanups
Date:   Tue, 11 Oct 2022 13:23:56 -0400
Message-Id: <20221011172358.69043-33-krzysztof.kozlowski@linaro.org>
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

Drop "binding" from description (and align it with other Qualcomm
pinctrl bindings), drop redundant minItems, use double quotes
consistently and drop redundant quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml   | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
index 290ba2375e92..bd45faa3f078 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
@@ -4,22 +4,20 @@
 $id: http://devicetree.org/schemas/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Technologies, Inc. Low Power Audio SubSystem (LPASS)
-  Low Power Island (LPI) TLMM block
+title: Qualcomm SM8250 SoC LPASS LPI TLMM
 
 maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
-description: |
-  This binding describes the Top Level Mode Multiplexer block found in the
-  LPASS LPI IP on most Qualcomm SoCs
+description:
+  Top Level Mode Multiplexer pin controller in the Low Power Audio SubSystem
+  (LPASS) Low Power Island (LPI) of Qualcomm SM8250 SoC.
 
 properties:
   compatible:
     const: qcom,sm8250-lpass-lpi-pinctrl
 
   reg:
-    minItems: 2
     maxItems: 2
 
   clocks:
@@ -34,7 +32,7 @@ properties:
 
   gpio-controller: true
 
-  '#gpio-cells':
+  "#gpio-cells":
     description: Specifying the pin number and flags, as defined in
       include/dt-bindings/gpio/gpio.h
     const: 2
@@ -110,7 +108,7 @@ $defs:
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
@@ -118,7 +116,7 @@ required:
   - clocks
   - clock-names
   - gpio-controller
-  - '#gpio-cells'
+  - "#gpio-cells"
   - gpio-ranges
 
 additionalProperties: false
-- 
2.34.1

