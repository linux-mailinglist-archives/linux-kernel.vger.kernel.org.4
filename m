Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5E05B53F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiILGSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiILGSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:18:08 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F4527FE5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:01 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i26so13131729lfp.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 23:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XDfWSSZYnHMYa3I+jtVKxklgIjaIvR8V4Z96XPKAank=;
        b=JJKAJOgELOlwmCL+BnBq3mbcAiPTeSYOKDMEIK2H/haWGfWpmu5/LPNSSOZnV63G0k
         95Jr1uJEPAqaSaQXQbMRndo54Vxe+8a3prJ4xoHZmET55DephfF8RQoUH/fUyXNZkNQ0
         T+9xh9L8WQu3OeN0C4kERarcfgvWPnLEitgZGiQpD70oA0ocS0zNrWn+mJXsF46FmELY
         CicZzhYFu00I2xV42gltvePL1dvwP7GoVOcGOLWvWSO2DPOnNitLjo0b5CH1drHzoaki
         fXqAZzTyj1vOAlB1YTlsMDuQI8xFyJxT1kwQ0Xo2/wBhLcLRUlvIEZeOeERcUMR/XDI9
         74wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XDfWSSZYnHMYa3I+jtVKxklgIjaIvR8V4Z96XPKAank=;
        b=FNEvCrMSdgQLvmvs/H7RcQjHYSYLfJM7HO0Y6fp0WGFGZsAH3LhEbWhAiZhz/zHTzh
         xtESmVd3oADis5hwxtYNjjJ6JPtC8+Tz7tYGwD6f3eZunz2pJP5ovdRPfFcPO+mABlyZ
         tVvexQmQqQ6CsDMwgJzWuvusXHm0ZP6CSv2ZDwzZpjVvjF48ltYcH2g6yLFhj7fwfNWZ
         kSMFgWqDye0o2lhSFJdA5clOmF/GszD7f6BlKKDh93CCTf2PzcysJZoLFvN5jM1ozq0n
         w6ncIYDkM1yzJzFGx/pbAvn8iVQiGUi8hjNyk8UFQ7TCMPM/uyZyMlcXJND6/4aFLGDh
         leCg==
X-Gm-Message-State: ACgBeo3voF7BkV7DUIV9nWW/XPHZvbg1Vtg/k32Se0NKxAGJtCCsDTw6
        gWMT+MwQZ5ChiJ/DnxpatQm8cA==
X-Google-Smtp-Source: AA6agR6517MOdeUu/5+gzOzJj9LdfjK+/YCE3DzsF+tfaNofqE16a2BHRWuHpPnAx08dbTwm0qPPwA==
X-Received: by 2002:ac2:5a46:0:b0:498:f53b:d19a with SMTP id r6-20020ac25a46000000b00498f53bd19amr5921684lfn.674.1662963479739;
        Sun, 11 Sep 2022 23:17:59 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t19-20020ac24c13000000b004996fbfd75esm876805lfq.71.2022.09.11.23.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 23:17:59 -0700 (PDT)
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
Subject: [PATCH v2 04/40] dt-bindings: pinctrl: qcom,sm6125-pinctrl: fix matching pin config
Date:   Mon, 12 Sep 2022 08:17:10 +0200
Message-Id: <20220912061746.6311-5-krzysztof.kozlowski@linaro.org>
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

Matching PMIC GPIOs config nodes within a '-state' node by '.*' pattern
does not work as expected because of linux,phandle in the DTB:

    'pins' is a required property
    'function' is a required property
    'rx', 'tx' do not match any of the regexes: 'pinctrl-[0-9]+'
    [[59]] is not of type 'object'

Make the schema stricter and expect such nodes to be followed with a
'-pins' suffix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml       | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml
index c8eec845ade9..84ed16f9915d 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-pinctrl.yaml
@@ -51,8 +51,9 @@ patternProperties:
     oneOf:
       - $ref: "#/$defs/qcom-sm6125-tlmm-state"
       - patternProperties:
-          ".*":
+          "-pins$":
             $ref: "#/$defs/qcom-sm6125-tlmm-state"
+        additionalProperties: false
 
 $defs:
   qcom-sm6125-tlmm-state:
-- 
2.34.1

