Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E553687ED5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjBBNie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjBBNia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:38:30 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA1188F02
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:38:29 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso1406692wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 05:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlnEmmK+mxpU2hlLI+Gvfd0nScZypGzNM1BgswRGTnA=;
        b=D/nQ4GR3dSQbLqg6I6//g3oBsSG/b41aAlnM5Yufajj05bmK/+DsKRO+n9oumxgDRI
         G2RhKUVYG8EWkwk6AquEpFY7mo7ENGkqqn9/58rzLIrcphE9KFK8LotJnFGF98o5eG/j
         BBta75jGyHpzijTzIe80l9wsn1ehQxvKs3ekgQPdjzOv9zk7Amqm1mrZX6G4RnG7IA+1
         mYyLuKLlxJ0VYsKRZtajgxpjwnm1tu/6nrev06GFZlHlRiA1Ae6MCpgK3AlpewhOHCJx
         mGgvHPsLmEUYGm5niLk2stCIBSRLnZAuKNPmbCSLOAbis4w56YgkUD/GSiZJWEyr9rOo
         8vmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlnEmmK+mxpU2hlLI+Gvfd0nScZypGzNM1BgswRGTnA=;
        b=HEy/V+j4hBlplcTfaDnPL3kxWJ4jNivTzG1gNx1NH0WHmO4/c0TAmp6LbhOCLWRlnN
         28TEpm3lZ+jUfbUj3RPRqD9OWdLEHMyfNK/AOJBfEzMEwpaS0jz3bwa93w1Hrc2Fpttk
         6iG4j09cSLJ9A4oL/vhxNdkD4+Kig3K0bKCj8y8MeFCmGkWtmtqTsDdPBXQu8s3WMQZ0
         k2uZizZ9027Ap32Wz+wjztJ7o8WnMLED0ELoIm6piSY44tiW1Iv7poqte2s3QNsvZfJY
         Yp1uaZeNGufnealZEIFp324lrNn20P0HjXSE/6LJtMCjpV2SFrxdKFoLunR9Ddk790MB
         aAxQ==
X-Gm-Message-State: AO0yUKVvQjQSoQgXb2sBx3PpkpaQRkFaHiHTL3sApKegwAiZum9m405l
        QWKcZqz0IRgIoBogYrC3XKHMbA==
X-Google-Smtp-Source: AK7set/HruKLuPPKZqpPir9fHCiHYxHpi8qYjeVph/FYB2s7tGyUsL58Of7GtXwbLYNB13s2fnE7gg==
X-Received: by 2002:a7b:cc83:0:b0:3de:25f2:3aee with SMTP id p3-20020a7bcc83000000b003de25f23aeemr5981561wma.31.1675345107899;
        Thu, 02 Feb 2023 05:38:27 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id y10-20020a05600c364a00b003daf7721bb3sm4672657wmq.12.2023.02.02.05.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 05:38:27 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: [RFC v3 1/7] dt-bindings: mfd: qcom,spmi-pmic: Add pattern property for phy
Date:   Thu,  2 Feb 2023 15:38:10 +0200
Message-Id: <20230202133816.4026990-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202133816.4026990-1-abel.vesa@linaro.org>
References: <20230202133816.4026990-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phy pattern property will be used for providing eUSB2 repeater
functionality. This will be modelled as a Qualcomm PHY driver.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index adf88245c409..1e6fadec1301 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -135,6 +135,10 @@ patternProperties:
     type: object
     $ref: /schemas/pinctrl/qcom,pmic-gpio.yaml#
 
+  "phy@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/phy/qcom,snps-eusb2-repeater.yaml#
+
   "pon@[0-9a-f]+$":
     type: object
     $ref: /schemas/power/reset/qcom,pon.yaml#
-- 
2.34.1

