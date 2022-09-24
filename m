Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508D35E89D4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbiIXIIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiIXIHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:07:11 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B213014F835
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:46 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z25so3553136lfr.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=t8+qCMdbFYWvCOtbDLsLD7tINzyrBmDRKDZb7KLMHDo=;
        b=wj7gXW76HGRB4ISM4MbJMdaYz9RO4fFyboHkEeGWqC+otdROMPPTqYkvKLDiOFAr8K
         Uo3y95gDkuMIhGb5qsd2WCbgfha03bEBFCr6NIx0UtdXEN7dJw8/sdJasC707VG6x2K5
         leN/crNtKHx6waFfDRxju6XQthPyIFXk2TKWRwQcEOTetxUSz+pj534tQ9tyeU/mKk2F
         XvNDtCYkg5UYpVkfkmAH0d+EYe6sw/6KcPVuaYmNReu/Yw1kviUDpMg4hIbcG0aGkEpk
         ZZueB3jEI5+LqwruYZXteJDbOkbpwgJlCSf2v+ieXeWY+todgDrwelcTJZ8ucyBSiVzC
         TFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=t8+qCMdbFYWvCOtbDLsLD7tINzyrBmDRKDZb7KLMHDo=;
        b=ey9NyD0vqGfq5WmwP3JEx3175evi8Rl9eCQaTvYdSbPj+TuCgRQTAU/4As9on3sPFb
         ilBCxQc8+AZBM3IS4I8dyZ5ydc9loFDhGp8d9aaNsbr+vr+IcY/v8jtkYKfURSuPj64u
         DwMqvX40H6s+fIgBWLH89upwkdwhqgd5p5yc08WjrXwpoQM9uG2ERqtk5BOvQ4P8mywC
         /3k0JZ6hzd03k+/eZagLwI4izmjXYyAn3ViAhAW6zFydRURcxrSq6XnwO4k8KryDeAuH
         lF2GikPNJQmvK0+mnUpd8jvJZoyFo3kMaAhfVGL3gl0/h54thCOrEIbtyZDSFvm6Vsc+
         +CtQ==
X-Gm-Message-State: ACrzQf2KvsCBmsH34RsrM9238qV+Upo5KYYklZAdmObkvlclPPJrIUZ4
        XVn2pxp31hOgR2H/mWurOuTy+A==
X-Google-Smtp-Source: AMsMyM5xSGB3chGQKXCWHfGyEtRivWmbNTmoYpo9RPkM456N37aw4jVi501tdVB+m9LkbM3twVJ25A==
X-Received: by 2002:a05:6512:159a:b0:49f:6357:971 with SMTP id bp26-20020a056512159a00b0049f63570971mr4811667lfb.81.1664006745806;
        Sat, 24 Sep 2022 01:05:45 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y2-20020a2e5442000000b0026c41574790sm1696668ljd.30.2022.09.24.01.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 01:05:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 29/32] dt-bindings: pinctrl: qcom,sdx65: fix matching pin config
Date:   Sat, 24 Sep 2022 10:04:56 +0200
Message-Id: <20220924080459.13084-30-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
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

