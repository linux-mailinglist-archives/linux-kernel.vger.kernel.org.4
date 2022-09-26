Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EA65E9B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiIZHtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiIZHrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:47:46 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB156140
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:24 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id b24so6433140ljk.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=t8+qCMdbFYWvCOtbDLsLD7tINzyrBmDRKDZb7KLMHDo=;
        b=U9E4/gkMQGH3XCUwZtjtGfgG8yh2OLUIGGA8wdi7F6vIWM2jipGP+wHEXG4ulA8bCO
         Q+PbBE4job3j4Yi9au/bAPbQYYfEKb2Mdy/B/vvNxOcAqIkZqMruzY3ypEnNHeBSDlTP
         LLec9ZNG5l2bcYh7NdM36oLctc/OV1Q7uSfTIBBMkmcjNbaRMdtMbYCIOrU6MoaAkM2h
         dnzoEbHeHR7IlZhTCqtEHadQHEiC7UTsh9KH/o09AXi9mpRgapFNMrPqrF3F9ClAe9gG
         JYfsXNnkKKIaeTKltftM3B1Wn8bqcs7YFb8kYR6d48h05iIPpco1LsFY1UumZnljASVU
         EpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=t8+qCMdbFYWvCOtbDLsLD7tINzyrBmDRKDZb7KLMHDo=;
        b=oeN4miz0tn2xrkzqJYHDf6DKFdtVuiWmwKV0KzGBPmkgrkuzUK2cAN/6ND6eVuPUBr
         Z1Kx18sr1tDEiqmLo4+at7SYmZB0h567obr1MgKBdjagvOd9QNi2KQabd0SFcLTBb3nz
         A68gVUcQ2k8WWULDnD5M+rjjVpfdnykkL9psLWF/tiKAlbEkZzIXw76ElLBXzbh3zxNY
         WxiKFq/QpXmmSJxLeSv9IBRi8/VdLlx8Ckw604EmIdHUbEqb7wPtoqMDLMLA9IK7k0wX
         upvawwgp9aUm/Hs+gxZXxJx+HKRNtRzBVn9cEm/mcegYy8eAZ6obtg+ToSJRFXyf/yw/
         nZrQ==
X-Gm-Message-State: ACrzQf3m9C6mU29vLwVZz2Waz/NEGAPGqZmutiQpLYLvgYPT1jM1s4Cm
        SILBqZ+sqiB4rfKJwsXY26mGiA==
X-Google-Smtp-Source: AMsMyM5PhH1F8ylIMzHyl50ckkysdU3Xc5D0+nmeJJzgr3WgdksJAIdoYPFXIHTwBGB6qFN27Wan2w==
X-Received: by 2002:a2e:bd09:0:b0:264:6516:93f9 with SMTP id n9-20020a2ebd09000000b00264651693f9mr7116421ljq.127.1664178323820;
        Mon, 26 Sep 2022 00:45:23 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a19e046000000b004978e51b691sm2453298lfj.266.2022.09.26.00.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 00:45:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 30/33] dt-bindings: pinctrl: qcom,sdx65: fix matching pin config
Date:   Mon, 26 Sep 2022 09:44:12 +0200
Message-Id: <20220926074415.53100-31-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
References: <20220926074415.53100-1-krzysztof.kozlowski@linaro.org>
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

The TLMM pin controller follows generic pin-controller bindings, so
should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
(level one and two) are not properly matched.  This method also unifies
the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml   | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
index cdfcf29dffee..0f796f1f0104 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-pinctrl.yaml
@@ -49,8 +49,10 @@ patternProperties:
     oneOf:
       - $ref: "#/$defs/qcom-sdx65-tlmm-state"
       - patternProperties:
-          ".*":
+          "-pins$":
             $ref: "#/$defs/qcom-sdx65-tlmm-state"
+        additionalProperties: false
+
 '$defs':
   qcom-sdx65-tlmm-state:
     type: object
@@ -175,13 +177,13 @@ examples:
         };
 
         uart-w-subnodes-state {
-            rx {
+            rx-pins {
                 pins = "gpio4";
                 function = "blsp_uart1";
                 bias-pull-up;
             };
 
-            tx {
+            tx-pins {
                 pins = "gpio5";
                 function = "blsp_uart1";
                 bias-disable;
-- 
2.34.1

