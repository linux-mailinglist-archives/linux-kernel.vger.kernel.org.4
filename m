Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AEA734050
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 12:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234737AbjFQKkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 06:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbjFQKkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 06:40:18 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9825136
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 03:40:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51a2c60c529so2092480a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 03:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686998415; x=1689590415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSnihe6/3LsI4jFSKnj7YtNbRA5nWcr5gKNA2Dnynwk=;
        b=T9G+PZ+eoawTUj6hMyXcjssFlBnmGy5bXDwAjpFiHyt4XOAEQ4oDbChwjxoU80Q4AB
         yOeSo1vmZAqFjpzTajVTo2cKrKwcrYyPbi58bNwUK1bWu7ay7LINS0UlDhTIFnYkHkbp
         0Ppa6NBxZvofyO4X6tLYc68k0JUuNBs2+aiEdCc7dqRhPfO5IHFf30Yttgw/T0gLQXB6
         zzaZsco/c7v3qvb6dyT5dkyrvkI/oCSKxXLd2nkvv2LODhT2IQxXw0K51TXwfJZfOG0B
         NIRxYA8SxRkcX8Qv02/cLeAaaE+BWPAbtSWomUSXRyQM26Sk277T6K3KapjVsNw6djlB
         Jjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686998415; x=1689590415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSnihe6/3LsI4jFSKnj7YtNbRA5nWcr5gKNA2Dnynwk=;
        b=LfKNl3Qy8+KI4WN2y3y+NDliIV3aEhnSFlN6JCRTUXipWSm7VHaUzXxMqvWG7u1GGW
         RW4jtFo5hWOHYe6wD4R8oUpb0ux/br8O09ky2sEUw0q3FF52Q8e7QnXiyrzu8UXoyf1m
         6PNAEeEIMYSIWMRPlYEhAOgOtU+fuLOnCNOZG1AHLfpSaqtD/0AAKAPIDWQ1LGAvgcMt
         2/XFQxdU6nR6oMOkSC3tWM3eGKK0dP8E2DPyVS3PcE4KgvlWXZcCEjIv7aszq1xjrhy2
         X8z22zgC6Jdg1BAAW3fQaW7hNaNwFCW4ud57idGRHsv1DAit7PQdB0D3EPAaQRi+as+n
         OBng==
X-Gm-Message-State: AC+VfDzJ2ESNHKFcGAW4Ue3BEdzRqpaQz8bYTIXl97co4W8nOq/mOdCM
        HtJ7+/ZEN8zer6enYcGq9K+HUw==
X-Google-Smtp-Source: ACHHUZ7tV6WpfiqDGYeU/OBZDJDwz25cQ8/HxmzDiCuSWUNZCf3rdqHHuo4zpPKdi5/fPYMi7R4YsA==
X-Received: by 2002:aa7:c912:0:b0:518:a5e5:47b6 with SMTP id b18-20020aa7c912000000b00518a5e547b6mr3334973edt.24.1686998415162;
        Sat, 17 Jun 2023 03:40:15 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g25-20020a50ee19000000b0050bfeb15049sm10677124eds.60.2023.06.17.03.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 03:40:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH 2/2] dt-bindings: iio: semtech,sx9324: reference common schema for label
Date:   Sat, 17 Jun 2023 12:36:58 +0200
Message-Id: <20230617103658.114453-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230617103658.114453-1-krzysztof.kozlowski@linaro.org>
References: <20230617103658.114453-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference iio.yaml schema from dtschema to allow already used
label property:

  sc7180-trogdor-pazquel360-lte.dtb: proximity@28: 'label' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>

---

Resending with ack as dependency (dtschema patch) was applied.
---
 .../devicetree/bindings/iio/proximity/semtech,sx9324.yaml    | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
index b3aa2ebf9661..48f221463166 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
@@ -13,6 +13,9 @@ maintainers:
 description: |
   Semtech's SX9324 proximity sensor.
 
+allOf:
+  - $ref: /schemas/iio/iio.yaml#
+
 properties:
   compatible:
     const: semtech,sx9324
@@ -167,7 +170,7 @@ required:
   - reg
   - "#io-channel-cells"
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

