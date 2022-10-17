Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB416016AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiJQSwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiJQSwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:52:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37E174E30
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:52:42 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so1518561wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hOoiBfvvEGTlYBAxhGaLbe7mxHQExNNX83XB8bqvt8I=;
        b=pwRo7rJzq3f8d3BGRMSPdqYtplO1ESVt3D0D31INKks9R9upem0eRkw7t+yC0eCI5V
         ZMC6RVwzOh44gYyRppmfiAhXb5IGGOMRXqpKIB6FZAuv+84xKKjfvpGWJguAUwiuioXz
         cnNuaGmjliO+cMx3VVKVf8iAxM7v1Qfzj1emgCkSHD+oZqPCxUENIYu08hRBdfRO/r0E
         KaUSgjdWWPF1eWC0EwZdAQBWyVw/WP3kClDh88iOzmy2hVMa51i1czRd+eJvmm5ZBDY5
         XZAHOGB9v000dtfj0REfD8ktVSR5pUmrdc1leHsp9dG1cLQ1I7bAoiKHomChOQiPjvoF
         g/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOoiBfvvEGTlYBAxhGaLbe7mxHQExNNX83XB8bqvt8I=;
        b=C571h2X7MugqBfjGD70BPDLZBrNkkJtJKtkhlFrA9iWVGo8Y+7tEpVsjaqimazxPjz
         bN3+quN7Rjl7pPa4KigYlMk3QO/bMHYgdOCbO9lKwUDQxKD4lewI9589HjF4RArMWk2e
         BehOSfIKJmimD1fWugGIgdzccH1DJvRqU/0RmcAEDpaOeEwVmRyagbdm5P14ZxJSgyTH
         ZS9AqOtgw7sBh3NdCzod35bMKgnOGMFFOZWDOCBDVcMIHMgjaMTgw+++P3GW6uPSAuhX
         RFYVUuAIwyYnceoWlZGnKnw0HKnr5wBs6AuSoHlhN4EZFv0ewW1yO7uxi8/JvCTdlgzS
         IZxQ==
X-Gm-Message-State: ACrzQf0fw41YnTn1gshVsa24/PBa3goxV1AGctXLNEkuk7oiSLZS1E44
        aoJ9rcB5cQ4rTavMx0MCBsfgvg==
X-Google-Smtp-Source: AMsMyM68QFNLV/+5iOzmHpml1GxyAE1eFnYnlUdYK7u8n8ovdpKO7WV6G7FUEjBQxnCzt+pqFMLwXA==
X-Received: by 2002:a05:600c:5024:b0:3c6:e25f:64be with SMTP id n36-20020a05600c502400b003c6e25f64bemr15319936wmr.55.1666032761246;
        Mon, 17 Oct 2022 11:52:41 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net. [86.14.22.118])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d65ce000000b0022abcc1e3cesm9040501wrw.116.2022.10.17.11.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:52:40 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org
Cc:     Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2] dt-bindings: mfd: qcom,spmi-pmic: document rradc node
Date:   Mon, 17 Oct 2022 19:51:05 +0100
Message-Id: <20221017185105.2279129-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.38.0
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

Document the rradc node name, like adc-tm it's only used on a few
platforms, so differentiate it from the standard adc node.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---

V1: https://lore.kernel.org/linux-arm-msm/20221016175757.1911016-1-caleb.connolly@linaro.org/
Changes since v1:
 * Add a new node instead of using the adc@ node
 * no longer depend on Luca's patch
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 65cbc6dee545..631141f99bce 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -101,6 +101,10 @@ patternProperties:
     type: object
     $ref: /schemas/thermal/qcom-spmi-adc-tm5.yaml#
 
+  "^rradc@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/iio/adc/qcom,spmi-rradc.yaml#
+
   "^audio-codec@[0-9a-f]+$":
     type: object
     additionalProperties: true # FIXME qcom,pm8916-wcd-analog-codec binding not converted yet
-- 
2.38.0

