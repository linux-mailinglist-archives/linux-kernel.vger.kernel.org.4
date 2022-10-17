Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCF7601D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiJQXC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiJQXBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:01:39 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65C91BEB6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:00:58 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g11so8732307qts.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 16:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJWvSUtO1t5Yo44+0PDNHOUmm01FetjF9ArFB5CjIeY=;
        b=T2RCsRekSq7vW1Mto3+4bPybk9UJLuHbd+ho2LBxVM7sNuvSrcf5/inDCOup7q0pK+
         9xDfnAEAufqWwWNJx1Giu/8rv9XZrahrzv0ptEBZlm4OTnKng7uA8VvAKRyUGbfRy3Cn
         ukYGJlZAqjv4TT9f3wZxrPx4J6VDuhqmr6Et029y/60cHIZOfoeb1O0ErQtNzgkmgKB6
         2KxXTPRzHD8QT4llpX8z41x75Z7fqNaGddqy48ar7xOcM7ZdqtN88NBYusGZe7Aop8ii
         Mzj+IqgIKVBbgXmkbBgMHpsXk8zkHGUFtKk7PcrBwmljcVMr2OlWBnNwWJ+aVqWoShZP
         UoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJWvSUtO1t5Yo44+0PDNHOUmm01FetjF9ArFB5CjIeY=;
        b=QQ/rqzBbTw2/m7hPafHlBu2fsxqxmkiMIl1KoSAUkjx4li0ZK+x1DBPkO/7A5Qc4fH
         pEMqR6uYs+r+aRmnhcz7zDis0fHN6bQtjkU9U06+nMitaBwk82L/vRBSnA5oxWsLr6im
         0/rDCgGJrp/Rh875SG3qAURP4kXDacjgX/EZLup2Cl/V3mgzFH2YXTTXPvwfiyVDWsPa
         ojiLLdTLk0Rlu56h9Dfo8oD+ZIchmxsIHHmiKLPCYvH+U7/se4m1OX6gWYeBnmgU4gIJ
         37ulofWFrr2GQ7G5peGHuU3iEx73/SCoFNUMQokSMItjrpknUWEpaE4DjFI1pknXnmuD
         egcw==
X-Gm-Message-State: ACrzQf07KEB1Go54LFrrmu3RSvqO1rDXD7T/MwCmlrd3lDuQihTcgevK
        ldIuNS2VxwXGrkizxXEqQMS0Sg==
X-Google-Smtp-Source: AMsMyM57KMcy2ViLteuOUljX85ZLfWVtFnbwNyLkzXmCrblOuemHU3kJYbI3aSy59VlE45FkqhoDaA==
X-Received: by 2002:a05:622a:48b:b0:39c:c920:d8fd with SMTP id p11-20020a05622a048b00b0039cc920d8fdmr10902779qtx.330.1666047657968;
        Mon, 17 Oct 2022 16:00:57 -0700 (PDT)
Received: from localhost.localdomain (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id fg11-20020a05622a580b00b0039cb9b6c390sm729670qtb.79.2022.10.17.16.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 16:00:57 -0700 (PDT)
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
Subject: [PATCH v3 11/33] dt-bindings: pinctrl: qcom,sm6375-tlmm: drop checks used in common TLMM
Date:   Mon, 17 Oct 2022 18:59:50 -0400
Message-Id: <20221017230012.47878-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
References: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
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
 .../devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
index 8320e5ff17b9..4482625b6b1f 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
@@ -53,6 +53,7 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
+    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
 
     properties:
       pins:
@@ -119,16 +120,6 @@ $defs:
     required:
       - pins
 
-    allOf:
-      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
-      - if:
-          properties:
-            pins:
-              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9]|15[0-6])$"
-        then:
-          required:
-            - function
-
     additionalProperties: false
 
 examples:
-- 
2.34.1

