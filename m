Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD065FB95E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiJKR1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiJKR0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:26:42 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D862F69F50
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:26:28 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id mx8so9375844qvb.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVlpIeK3DosLFJYRvI8e5R35sYlWCbAuX/Ps8Xg/6Kc=;
        b=vk4MaOFZy2wQLV/dKUG/OlkhxbugaCG2GYj0djINOC5b6L7UQMd331o1NIVGOsbXfu
         hcAAF/tP0zZokSq4pSpHT1BYyNGKmcIdH7bvJjS4rRwFfVc66ELba8PJF3yloZOXkjtv
         cH6Yz7oFIB/sHVA43zXTrtAHuhRyGL/X8l66AvhhBA7POfZXpQxyYUIb2MaA+5AOO313
         fis+DL3vg9CwuewcLI/nJYcoN5p2p15LqB4nKz+XXLR77/MQF+gfQ0QUdo86Ef1OH4Br
         nNBGh2Z/1b9J3FwsxTYVF6I5qO0/YIDlaUvpCUhpDOEGIDMQaRq1hr72s+YwO+1RB/Vw
         jNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVlpIeK3DosLFJYRvI8e5R35sYlWCbAuX/Ps8Xg/6Kc=;
        b=sCRl44YOaea2Z0EdtVHJpKaY82CDjsZzt2CkJEBTfBMED6qgQ2MGAiFeIDOXVna82U
         uERgl3rEWPsggDyKx20ay+7ZID6QJUvLu4dxp9HE477aqU4Ec1lI4aLqwjYZ6Pr75sa2
         q3MdGITqnFrDxNrG2GTr/FqtyJ11wDxWVLjUFwKkyovboe9PiS/h351U0JOBLVvWd0wr
         oQBtojOteYuE2/xMVxMMX5658EmMWfBHjsMNIU8KVSzGONrtc3EFIYq2oUWca+8OWm3e
         LTKzKpI3dPggDG32LydUKFkR+hADzNNiMorsQcUzB44lMV15t+f8WZjemQbD3/KgtF5n
         UzDg==
X-Gm-Message-State: ACrzQf1fw/P4WK+sKT5IT8sORCpIPBT/Oj5oaxcQgKOykEWRNWHoPqiD
        YMgUbQcQc7rpUT+FFnFM+ATnFA==
X-Google-Smtp-Source: AMsMyM5/ocYTJJQakPQ75u6EbK7nIqw54n5FQc87TIOOYCzAC3UiXiqr+1TwhWzPynnxH9fdd+uK9w==
X-Received: by 2002:a0c:8b0a:0:b0:4b1:9500:4703 with SMTP id q10-20020a0c8b0a000000b004b195004703mr19714014qva.124.1665509188279;
        Tue, 11 Oct 2022 10:26:28 -0700 (PDT)
Received: from krzk-bin.home (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006bba46e5eeasm14289087qkn.37.2022.10.11.10.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:26:27 -0700 (PDT)
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
Subject: [PATCH v2 15/34] dt-bindings: pinctrl: qcom,sm8350: drop checks used in common TLMM
Date:   Tue, 11 Oct 2022 13:23:39 -0400
Message-Id: <20221011172358.69043-16-krzysztof.kozlowski@linaro.org>
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

The common Qualcomm TLMM pin controller schema already brings
requirement of function for GPIO pins.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/qcom,sm8350-pinctrl.yaml         | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml
index 1c0186050dcc..cae726b5fc79 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-pinctrl.yaml
@@ -53,6 +53,7 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
 
     properties:
       pins:
@@ -107,16 +108,6 @@ $defs:
     required:
       - pins
 
-    allOf:
-      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
-      - if:
-          properties:
-            pins:
-              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-3])$"
-        then:
-          required:
-            - function
-
     additionalProperties: false
 
 examples:
-- 
2.34.1

