Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083236E4448
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjDQJrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjDQJr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:47:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCEB59D1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 02:46:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f16ecaad2eso7400815e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 02:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1681724801; x=1684316801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BMRR2hKuCu/JKO2oCNQezk6gvirEdv8nvtmKWfH9U8U=;
        b=vdYYL6yvM4/JfTWUml9xvF5ZxwOONVV6YegxD/WTC7erErJ5YFFW4WYIzFwpnUmz/4
         a2Aa59K9/FUlpkuZbigyxqiVmmDAgsd51q+xo0Lmyzb8QvVizFSWk4Pr0gf+JcmMe+xC
         7NCv6SHUSsR4oLkj31CW5aL3rQPCdCdmjhvHn8QDPJlXE/Oyi8SWdY8LHXgbIsj9gJf0
         KVD+iSf3Odg+8QT1sVOYvkmyRa/i/VQ38Ldglsft4Qza6JJm8pVK5m/ssaZDcyXNxguH
         Q8BV0Scmuq4QYLeH0Nkpz+4W9/PVidws84+UFlTs3gsTG6m7ZG3XXxcnSPenvarSPEEe
         FQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681724801; x=1684316801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMRR2hKuCu/JKO2oCNQezk6gvirEdv8nvtmKWfH9U8U=;
        b=IbjupJpoz5SH19a5C1ooqjEApiUWxL49JjTxp2tEAQOYKxoU7Fxrci7YfIbCWfxS/a
         1IsJIdLzoY1RR1Wp0ilbjrsyjNk81QGo7tVrLXBbYpOZ+kGeOzHm9B1zCjpeKwogZvDM
         A70u9HipnG7RI+E1tdppp2xNHT0zn8qjPh/azQinoArz9DUB2SAZGPJVvPW5GDMddwJ+
         I32hTC/9nDGw34uxYoPos5b5QeG32AyhAucViX5dnQ8ehIClcPz12OLI9bSepaQhcnA6
         qOZBIvD/5aDi0ppJIOoicmF17LckcqGZQTDWzA2Pn0dXBp2BHVUt07SOJJGv2r+3uFEZ
         5inQ==
X-Gm-Message-State: AAQBX9f1gV8bwqMKwwsbjU3kuuvNS16ozBn4BsmBCdk/FjqG9Xdl1gko
        eR42wiy0iktyIP33jcvOw0KUJA==
X-Google-Smtp-Source: AKy350YatggMsUogl9cvHq83kwA8h66HmCssDoR2GvvAaXPcrgLwWBI0eoDLRaMmBbNIkQ8MeqN+6Q==
X-Received: by 2002:adf:e68b:0:b0:2de:e7c3:1663 with SMTP id r11-20020adfe68b000000b002dee7c31663mr4666886wrm.10.1681724801155;
        Mon, 17 Apr 2023 02:46:41 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:374a:ffae:fd26:4893])
        by smtp.gmail.com with ESMTPSA id t5-20020adfeb85000000b002e71156b0fcsm10077164wrn.6.2023.04.17.02.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 02:46:40 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: interrupt-controller: qcom-pdc: add compatible for sa8775p
Date:   Mon, 17 Apr 2023 11:46:35 +0200
Message-Id: <20230417094635.302344-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a compatible for the Power Domain Controller on SA8775p platforms.
Increase the number of PDC pin mappings.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v1 -> v2:
- increase maxItems to a value that covers all other users of this schema and
  leaves some margin on top of that

 .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml     | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 94791e261c42..2f097f282715 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -26,6 +26,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,sa8775p-pdc
           - qcom,sc7180-pdc
           - qcom,sc7280-pdc
           - qcom,sc8280xp-pdc
@@ -53,7 +54,7 @@ properties:
   qcom,pdc-ranges:
     $ref: /schemas/types.yaml#/definitions/uint32-matrix
     minItems: 1
-    maxItems: 32 # no hard limit
+    maxItems: 128 # no hard limit
     items:
       items:
         - description: starting PDC port
-- 
2.37.2

