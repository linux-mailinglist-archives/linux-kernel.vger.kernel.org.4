Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA675E9B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiIZHtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiIZHrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:47:48 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D013F38464
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bu25so7596212lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xvXRb0zwWe37WFjqVxzmYbo7BlnZOnYHNQaO1Kmsw4c=;
        b=DPxlZU7raGu6va/8Im+f7FVskiI3JK21AngvG9g34u+n0PgP69595O9cs0R0P/8pQG
         dUl8RKX0Dk+kkvj/9wOXUkpY+Tsu5jPnsEFD1V1wyZmNSh6f7XwOCDFPeDqm6zaHp0hh
         o9hFIbZv7OrC/r87rd+cVtidn+/1RPYJuIcfS8RW+63WkIFaK/39DuqNVktGv5Aj9+p4
         s2sxivThMvSr37zZippE2RUufhkapSkmuBvA0AKL+vjnb3/eRK6tDnP05KLGXtZwFbUM
         r4JZO+hQL98/PououvHBKgsreK/Pf8vljQ9s1mOTIqMMXcCPbSYwv6OFOuf20RpBcLZc
         UAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xvXRb0zwWe37WFjqVxzmYbo7BlnZOnYHNQaO1Kmsw4c=;
        b=x70dkblSzzydgK/WIBKd6RLgNa2T2OZogEZA6RT3Gg/AjYT2/Ym3d4VVE2CQxUi/Cd
         coVzNTRbKYSMkIVFRTMiaAmEqIYCqn+xpBbAaVRftxPR1JHtneesmFGA6BqW3ZVF1Gyb
         o8qx4DSzvnlbC9eyj9HcBnvukaXREiItQM+l2a4tp4gbyMKUZUE9WLzewp9uUhrdW29+
         MaKbPI9sIH2U05TymsaQWo4DyXAndAh7uDxFgjieiuo8AXwruNA84NdegtpOL5zfyRjZ
         mnn6n7ua2ThpkLtAQnzE2amIth0P0iwvEMgA555NWee9jhbP0dWYsu0SoCgiR2ixA++c
         VC8Q==
X-Gm-Message-State: ACrzQf092a87JDlBp1J7BmUiyGwoxBKkqkgZneNuQpw1t4UW866gtwDD
        +WjvkQkJZqUX3FXvgyC8QvqwPA==
X-Google-Smtp-Source: AMsMyM5gFcyi/QPXT4QaUwy9kpvifQwECbGCYBAyrqnGSM5S8ZteCBbbtTMdTwsshPtSg34yaouk4A==
X-Received: by 2002:ac2:4891:0:b0:497:a9d0:4c4e with SMTP id x17-20020ac24891000000b00497a9d04c4emr7625947lfc.620.1664178312513;
        Mon, 26 Sep 2022 00:45:12 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g6-20020a19e046000000b004978e51b691sm2453298lfj.266.2022.09.26.00.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 00:45:11 -0700 (PDT)
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
Subject: [PATCH v2 25/33] dt-bindings: pinctrl: qcom,qcm2290: fix matching pin config
Date:   Mon, 26 Sep 2022 09:44:07 +0200
Message-Id: <20220926074415.53100-26-krzysztof.kozlowski@linaro.org>
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
 .../bindings/pinctrl/qcom,qcm2290-pinctrl.yaml           | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
index 3f4f1c0360b5..5324b61eb4f7 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-pinctrl.yaml
@@ -50,8 +50,9 @@ patternProperties:
     oneOf:
       - $ref: "#/$defs/qcom-qcm2290-tlmm-state"
       - patternProperties:
-          ".*":
+          "-pins$":
             $ref: "#/$defs/qcom-qcm2290-tlmm-state"
+        additionalProperties: false
 
 '$defs':
   qcom-qcm2290-tlmm-state:
@@ -146,19 +147,19 @@ examples:
         gpio-ranges = <&tlmm 0 0 127>;
 
         sdc2_on_state: sdc2-on-state {
-            clk {
+            clk-pins {
                 pins = "sdc2_clk";
                 bias-disable;
                 drive-strength = <16>;
             };
 
-            cmd {
+            cmd-pins {
                 pins = "sdc2_cmd";
                 bias-pull-up;
                 drive-strength = <10>;
             };
 
-            data {
+            data-pins {
                 pins = "sdc2_data";
                 bias-pull-up;
                 drive-strength = <10>;
-- 
2.34.1

