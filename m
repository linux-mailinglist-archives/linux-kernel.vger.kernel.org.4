Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF70A601CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiJQXBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiJQXAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:00:50 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30567A533
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:00:48 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c23so8719089qtw.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eexU8QFju8foCFKK6LIrBeBMIjjHKwOcOdgfsoR5Zts=;
        b=QW6mhLWqdDjkWW5XD+q1AJqczk9Rnm2f5FWSxjElAubT7r6Q9IsMCIVw30R83pO4TG
         h5OEDA7y4ORyZdAztXv7//43xjHkJmowP6P9IaUOonDXGZiU63+Pi05rIjtGelMSd8hU
         HDSaFPlPCcrFTOFO1d62jFKcUsUaBF/buHB/UfZd0yourNnv9IpgM5WC//PH747XULsD
         QIqppIBz3zjHPVzzevlNZgwe9HEJFffVS+QSJJSWtE9fr8zOUOynC4O2bVmEUhsU67Q8
         +bOKlFxXVW58+EgLBd8y3+QqyU6skQ18ypdrs2FqUDOEAa8plOSq24qmNnsUccBNyrOg
         2s1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eexU8QFju8foCFKK6LIrBeBMIjjHKwOcOdgfsoR5Zts=;
        b=dOnMNUt94+PTy3ZzQSlvUeqCPyLJb4WQrEKl9enB3rPPMydVxXHYm2P2F2VA2bo9Db
         mXB89ePqJ7YkYnXyfic5oDXWSKXon0ujer2PUzsi/ay6Nzvar1ZdtrV3ZAXRoGqwTe+D
         wVRVideWrzDNchmjD0nnpadL8Ux2eyQTeKRPXHFYG4Oqyly3UqE4jiDrb/509sg72cMs
         J3E7rWBXY7QHxtdsdDcM3U5FOUqED2oqfjSyeVxwvT+KbRYID4UK6fmVWe7RtAVllBF5
         zfoCS8Z3V2tcWQEETfIh7i+cezLQORrxtMNGEAua0P44idAFRQQvzwXs6Xmd9i2NW8S9
         3/iA==
X-Gm-Message-State: ACrzQf2UHu5gFRAqlJ+eSGjpBvqTtBLnlIolJfu+NjlMDg/vqqtaDfIU
        9JVHAkr3KVwIMqMd5WH6SXTOFg==
X-Google-Smtp-Source: AMsMyM7aJxmu4hyn0xgbF+OwvfaLPc5WujImVyTQaSPobFjqhA9DeIQwAhwDKK3wCMdhMAPgbLNhQg==
X-Received: by 2002:a05:622a:14ce:b0:391:6892:1665 with SMTP id u14-20020a05622a14ce00b0039168921665mr10655682qtx.431.1666047647222;
        Mon, 17 Oct 2022 16:00:47 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id fg11-20020a05622a580b00b0039cb9b6c390sm729670qtb.79.2022.10.17.16.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 16:00:46 -0700 (PDT)
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
Subject: [PATCH v3 06/33] dt-bindings: pinctrl: qcom,sm6125: drop checks used in common TLMM
Date:   Mon, 17 Oct 2022 18:59:45 -0400
Message-Id: <20221017230012.47878-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
References: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
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

The common Qualcomm TLMM pin controller schema already brings
requirement of function for GPIO pins.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/qcom,sm6125-pinctrl.yaml         | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml
index 5cb8b272cb7d..843d110df240 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml
@@ -61,6 +61,7 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
 
     properties:
       pins:
@@ -112,16 +113,6 @@ $defs:
     required:
       - pins
 
-    allOf:
-      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
-      - if:
-          properties:
-            pins:
-              pattern: "^gpio[0-9]|[1-9][0-9]|1[0-2][0-9]|13[0-2]$"
-        then:
-          required:
-            - function
-
     additionalProperties: false
 
 examples:
-- 
2.34.1

