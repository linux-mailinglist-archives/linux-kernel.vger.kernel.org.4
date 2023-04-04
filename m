Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C799E6D6CD2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236213AbjDDTBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbjDDTB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:01:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854D0421F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:01:24 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t10so134516018edd.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 12:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680634884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJfzhfU8C0LMQ39+xZRczmG3MwdDxjd8/cU7F3h/DO0=;
        b=jYR2XcGOEiEkZeZ07K1e/e/Qf0RznZdzsoqGXWio0xrONB7hm7CO6Tsyfpz3VNooVQ
         T8PV4pSSMnefFFRXlDbxPEkt1sCBFsyHsRKkbatLPL3K55IqxXx3pGDYwmdL/B4K0I96
         7F4XgmZOOVsugw0ci+LNfITqtOZ+SylE/x22EB59PNn43ubCun+ceSFWsNvsGMStN6cc
         GMYAMnv74zEKpvW2jQrGglVIel6pFlz/OjKMdjicd6+IwBY16R1/KXnYykHjgVDj28QW
         3nTYb6cc1QplLsxheS6Jswy3N2afIIMR/So/455tDqFBZtv9c+ZrPhNI3RFLNMLo9Y65
         P07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680634884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJfzhfU8C0LMQ39+xZRczmG3MwdDxjd8/cU7F3h/DO0=;
        b=OyArRa2Chbmenr4CBd9s0LEvwRlhztxgExDYFhCwTnYDN/IfOaQ+BFt2o7n0wD4WU3
         dkh6R/x1Cl+c90aYLLwyYCZad+zajNw83OLDWfTDN7z7kWEwcyUtCY7Wx+b1lnjoVgzp
         tC/jDdu5joNv5kiGVizXjrQbdVHItq4p0czUtuBy6My/K/CZOw6vLIBYa7042HjLfXuk
         X8juqMDr4WNDCXgAM8QmltsozM14OhpCf4k0+cOiQ9mI1txg4R4hjn6HWajnS72M2Vrn
         Ja9BavfaoqtxAbU+KZidob0cEV/rPWo2Ukj8vy4wMKd4oiiEaABNyxhflj+QiJNinDPo
         n5eg==
X-Gm-Message-State: AAQBX9dtICcwYawjiKrBk3f4ox6X2Bz/L+LZTsDzn7/EMkqH7kMbklHH
        4EJ5ORzoTpQAWuWUJq74ORk2BA==
X-Google-Smtp-Source: AKy350acHNH4A4LEG3R+ql8VXDXLwRtEb9G1ykKetLMqq9tM4ME2+7+RzIaR442wiKJUZcJlfBlKcw==
X-Received: by 2002:a17:906:430a:b0:914:4277:f3e1 with SMTP id j10-20020a170906430a00b009144277f3e1mr585067ejm.53.1680634883969;
        Tue, 04 Apr 2023 12:01:23 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:7467:56f4:40b7:cba8])
        by smtp.gmail.com with ESMTPSA id dx21-20020a170906a85500b008d044ede804sm6257079ejb.163.2023.04.04.12.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 12:01:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Yuti Amonkar <yamonkar@cadence.com>, Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/5] dt-bindings: phy: ti,phy-j721e-wiz: document clock-output-names
Date:   Tue,  4 Apr 2023 21:01:15 +0200
Message-Id: <20230404190115.546973-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404190115.546973-1-krzysztof.kozlowski@linaro.org>
References: <20230404190115.546973-1-krzysztof.kozlowski@linaro.org>
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

Document the clock-output-names property of clock children, even though
the nodes are actually deprecated, to fix dtbs_check warnings like:

  k3-j7200-common-proc-board.dtb: wiz@5060000: refclk-dig: 'clock-output-names' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml        | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index 4f3841e6a307..651f23580930 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -89,6 +89,9 @@ properties:
       "#clock-cells":
         const: 0
 
+      clock-output-names:
+        maxItems: 1
+
       assigned-clocks:
         maxItems: 1
 
@@ -122,6 +125,9 @@ patternProperties:
       "#clock-cells":
         const: 0
 
+      clock-output-names:
+        maxItems: 1
+
       assigned-clocks:
         maxItems: 1
 
@@ -150,6 +156,9 @@ patternProperties:
       "#clock-cells":
         const: 0
 
+      clock-output-names:
+        maxItems: 1
+
     required:
       - clocks
       - "#clock-cells"
-- 
2.34.1

