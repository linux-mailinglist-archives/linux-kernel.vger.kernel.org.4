Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0106001CB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJPRDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJPRCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:02:51 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FCD3A4A9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:14 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 8so5447768qka.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhbTeBROl4/tOR51peuLJrLs0zaAX19oqYrmPX71dUc=;
        b=k7kG1MHuqLhkp8dyErlwgoIwyDXpGaiIg6IVJ7KEfhVnnakONcJ9A/LmL4ZKAsUeDJ
         1gRV3Wude+1SE09DrhjIL49BY6nVnlcsMOCSw/ey7jp45psaMwSV5AxpcyykUafPZ94u
         tU1yvdqKVvBtuRKbpsALcPauSDegT10/RmhBdoRqBeW4m5B5rDiDeEntFkExamEhMiWo
         ddpMLq6ZpBzTjjtlFBTO3d7Mzr0ogAINXrdmXIMugGYtKGUAJ2UfapzQwkux8YljSa+O
         VcdURNNj14eeui20hjsaj9iYlvfDvOzQhpnNS99yOQKVof5g6kU5UOLustGkbSt/TDMW
         t4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhbTeBROl4/tOR51peuLJrLs0zaAX19oqYrmPX71dUc=;
        b=NRnHgz1jODJO5AaorCs7qeHPa3lfdOMYAN0op/3UrBLxynnWETxALWaqK/Uj7gyOZq
         /hKBFFQ8N26QRxDvRYu5oLyYSBiCQ/vbDLFz1SzgKG2iQj5qXtmdGqYfYmsuHmwyvzyU
         8rWpCTcvtAx8Fp0kRVeHnT6Ft3JP7a5EXOKotAnDXkwyFnzneQ7gEjROk3Y5c81F3v0p
         x2cZU6/GQD6EgKuhV1OnR57gejSEHFzrMEx1zf+O8pkmJT9d6SB564+ky1v/RsDJ3RDC
         Q3QQBn7ru7cUkYx/IcpyzRp64gwFzdS4GuzP50UvEVFw44Dy3DZjo0Vz5rMaG5UynsZz
         gtOw==
X-Gm-Message-State: ACrzQf2SOc185Wj35Cvm/YAsa1A+VfebLEStaBzn6s2usXY2egm1yDHu
        sfUGhD8v/gnUDB2T1j/LPv3X2g==
X-Google-Smtp-Source: AMsMyM5dhKmsy4shCCR2KeEmVtXPkIBp/p2L1w1jdvf9jzFKtgb9EtzxhWRHDdUlGTPOx/PWuBRR1A==
X-Received: by 2002:a05:620a:199e:b0:6ce:3ffc:b43e with SMTP id bm30-20020a05620a199e00b006ce3ffcb43emr5034374qkb.252.1665939730312;
        Sun, 16 Oct 2022 10:02:10 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id q6-20020a05620a0d8600b006ce7bb8518bsm7539967qkl.5.2022.10.16.10.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:02:08 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 18/34] dt-bindings: pinctrl: qcom,msm8909-tlmm: fix matching pin config
Date:   Sun, 16 Oct 2022 13:00:19 -0400
Message-Id: <20221016170035.35014-19-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
References: <20221016170035.35014-1-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml     | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
index e03530091478..b1735918fa90 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
@@ -43,8 +43,9 @@ patternProperties:
     oneOf:
       - $ref: "#/$defs/qcom-msm8909-tlmm-state"
       - patternProperties:
-          ".*":
+          "-pins$":
             $ref: "#/$defs/qcom-msm8909-tlmm-state"
+        additionalProperties: false
 
 $defs:
   qcom-msm8909-tlmm-state:
@@ -136,13 +137,13 @@ examples:
                 };
 
                 uart-w-subnodes-state {
-                        rx {
+                        rx-pins {
                                 pins = "gpio4";
                                 function = "blsp_uart1";
                                 bias-pull-up;
                         };
 
-                        tx {
+                        tx-pins {
                                 pins = "gpio5";
                                 function = "blsp_uart1";
                                 bias-disable;
-- 
2.34.1

