Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4B55B546D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiILGVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiILGVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:21:03 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B5B2C10F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:59 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s6so1946199lfo.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Z/95Brm84Hs/a3P501KqW9gtmX0Qfi6hmXE/MDLL0vI=;
        b=PLoAGfgYNr7od2O4N2jBATlyy9GsidtsOIMLThrsH+SM3UaH/dbI0LB74rLQz7mTld
         BXMJAwXOEC+24QzIPIaMlrAcZTTiWY4OgQDhPMxzxdtgEULAWYZvemx2eE3TBxKA1OSg
         F0plECT478eM9Y7YmoosYIi+S49h+4fb7ZJqaCF1pH2q4T9gA36lsULF9RWpN7oLFSCW
         VRTDRuhFLxE7eZ71cXkrLSyH8nCfNfJoFgB/CbGB5FEmaQDNzYDSli9PqfiRUzSC6nq4
         0cJFwnb4PJmd98hCiAKVjbdR90vSU6SpukpLUGdvA0rMCJcMrsk+txXTzVVTSN4wmqYe
         JYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Z/95Brm84Hs/a3P501KqW9gtmX0Qfi6hmXE/MDLL0vI=;
        b=RdMsLjE/7Z5DhxKkrVBq3JXgYcwkhMC23hsCyUhbtoNrYtECH1im3eqNbprlZYKD3G
         b3GmUBS/mSsKXVgc60CiwEB2tpU9IidknLUl4x6V5HiliTxYdpn8gUf0HMgobws32Csd
         K8NnvUDrAyrMw0EI8n/ZFbVOm3K/WrTW8XXc9c9AoSpSoiZ8gaI0/mvQWzy6jWGm9MaK
         RuhrBU+fUynsrpGhEZYCq2il4q13Mv3NI6eGwbf4obkX9gl4MqtEXuiU4EsHDjGupwY/
         MZpUPpFS2r+4zaHRM7sC4bbekQOcs6LLoYGYcMPtYYR25uG5X9MVO/V4o1yn6t0Uxnzc
         kjjw==
X-Gm-Message-State: ACgBeo2EDDDkT/IQf9XWzj3mMcU+PM+77cR6jJ5l+VQ9CKXMYYI2URH9
        pn+MMZ5Hv8KTkVWEwtDf/3tnOQ==
X-Google-Smtp-Source: AA6agR5oG2zgeaH/mojNn55ZSx64wxS+B+6Ny6B04LZFluXVKFQhqrN6oR2dY8galG82Ymg64bJlzQ==
X-Received: by 2002:a05:6512:24b:b0:497:a7a7:2ddf with SMTP id b11-20020a056512024b00b00497a7a72ddfmr8890896lfo.379.1662963514996;
        Sun, 11 Sep 2022 23:18:34 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t19-20020ac24c13000000b004996fbfd75esm876805lfq.71.2022.09.11.23.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:18:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 29/40] dt-bindings: pinctrl: qcom,sc8180x-pinctrl: do not require function on non-GPIOs
Date:   Mon, 12 Sep 2022 08:17:35 +0200
Message-Id: <20220912061746.6311-30-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
References: <20220912061746.6311-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain pins, like SDcard related, do not have functions and such should
not be required:

  sdc1-clk-pins: 'function' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Another question is whether 'function' should be disallowed for such
pins?
---
 .../bindings/pinctrl/qcom,sc8180x-pinctrl.yaml       | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml
index 646fabdf81f7..4afe20bac87c 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-pinctrl.yaml
@@ -61,7 +61,6 @@ patternProperties:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
 
     properties:
       pins:
@@ -112,7 +111,16 @@ patternProperties:
 
     required:
       - pins
-      - function
+
+    allOf:
+      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
+      - if:
+          properties:
+            pins:
+              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-8][0-9])$"
+        then:
+          required:
+            - function
 
     additionalProperties: false
 
-- 
2.34.1

