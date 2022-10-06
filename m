Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99ADA5F6941
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiJFOJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiJFOIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:08:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060BDAC3B5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:07:23 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bu25so2894475lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kfd+OH8iFG6Pz6hjLeUQTVAPI9+qQMNdvKg+c7yH9ew=;
        b=lE9qLRKwmAnNvOAQBV35y1o9moz8HFdfhJE0cWJZU6wQ4Fe0QfXZMupK4Xo7vVRXxg
         MJ9xZD6nphFVbJtwQ+CNcQIIM5wLN+1YAS9fBf1r+BKy6ZXE0nTtmOoTr5GYrcwzg4HQ
         UQcV6MkgzsV71ahZELQGYFGr5pwJmQBLposhlKa7a6Nw9293U4ZRFbFSoAPUQ5ACFmSC
         7QZx0t1K1C3xBDsQi11sATkEipy2Htmp1JJAYSZoTQHk8owxdQTlt2OPHl8WuKXoCZCr
         zrkDHcCtt+v2Y1uTubWVapWsvAGCtKmL2rDgIqfPakWYy9iiNK+/hqFMkhp2XcMZ4q9X
         Dmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kfd+OH8iFG6Pz6hjLeUQTVAPI9+qQMNdvKg+c7yH9ew=;
        b=pyn28eHP8g5mYuKoZW0FQDz7lYW0hdf5WXInVY3JHzpJrsuRRE9sAjLpunUyUV5gEp
         G9WCZ5TAext0tKmHS9sgY4ECWfn8W6CBCHe4apTh/sPWzX0Hki0Q+ab29RLNJCWtojHy
         A5QflDanNcfUDKKq0+3InBbj14JmuVci0crX9X2i+2l7+HgHi2mYyAR2ToUTqu2YWgVa
         OCRpz66qftYHFTHYRZ9foEwH90pF6oUZd79vLjDDpIEvJ4eT642sKBoli6IkRZt+rPVE
         zry9wKusD50bQoTTe4VpGTN8rjIkoyiYchMxSCCnCoyFC970MygyIqdgszkkR6VE1hCn
         Llsg==
X-Gm-Message-State: ACrzQf3Sj7HDDa3jDdWeXbB8upXvIwmp90mpUvMDPDtJGdywv2Rxdsm2
        TyXmug86Ir7SUyNCmUQPNlnOpA==
X-Google-Smtp-Source: AMsMyM5mUjwpsdn7p/gRROHzMoPrewDnx9G1Hxijeph0AwaKTMrq8TZDQ8U14vjJMZa4dqOZeZavMw==
X-Received: by 2002:a05:6512:32c9:b0:4a2:6fd8:8172 with SMTP id f9-20020a05651232c900b004a26fd88172mr51679lfg.1.1665065232870;
        Thu, 06 Oct 2022 07:07:12 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z3-20020a056512370300b004a2386b8ce8sm1833929lfr.211.2022.10.06.07.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:07:12 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 23/34] dt-bindings: pinctrl: qcom,sm6115: minor style cleanups
Date:   Thu,  6 Oct 2022 16:06:26 +0200
Message-Id: <20221006140637.246665-24-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
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
pinctrl bindings), use double quotes consistently and drop redundant
quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
index 3f5f5229a86c..c6b8e8929e61 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
@@ -10,8 +10,8 @@ maintainers:
   - Iskren Chernev <iskren.chernev@gmail.com>
 
 description:
-  This binding describes the Top Level Mode Multiplexer block found in the
-  SM4250/6115 platforms.
+  Top Level Mode Multiplexer pin controller in Qualcomm SM4250 and SM6115
+  SoCs.
 
 properties:
   compatible:
@@ -36,9 +36,8 @@ properties:
   gpio-reserved-ranges: true
   wakeup-parent: true
 
-#PIN CONFIGURATION NODES
 patternProperties:
-  '-state$':
+  "-state$":
     oneOf:
       - $ref: "#/$defs/qcom-sm6115-tlmm-state"
       - patternProperties:
@@ -46,7 +45,7 @@ patternProperties:
             $ref: "#/$defs/qcom-sm6115-tlmm-state"
         additionalProperties: false
 
-'$defs':
+$defs:
   qcom-sm6115-tlmm-state:
     type: object
     description:
-- 
2.34.1

