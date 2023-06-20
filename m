Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8498A737248
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjFTRHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjFTRHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:07:31 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E55D10DC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:07:30 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-78f1dd09289so1329209241.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687280849; x=1689872849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KD/qvxJOc3b4KgS6sdlf1So0mk1/jsrGWQamnUQ/Qk=;
        b=VP5bdClvPlybw7aor+YaCPJnNF7rxyDbY2AUMA4Sd8REXUfOq3H2Toy3dhRaO3y2gg
         jC7M4iFwq3HEsirmo6qFnq4Gp5Ydi5YVUgnEUQOfJKOKs5B3+t6ttVJyC5y4GIyBptz0
         q6yTL4D4e57FdDnbX21X1NVu1QzJC9EVZGDRfu+a/qHcBfW8pJo/VYlfo7w8mndN40Lh
         KjBHXI9hNnH+6dVW3XkO2uzEX0qYSrzq+1hnNI2u3fVnqNtdqJ19N1PZLixyEjHQC8FH
         1Vbk/Y2Nt/cBXkuCDJMgspVZo9hJHhyEBmQoui87+vWdVvPcu/+Z1FnjAlqlxMyN/oA3
         OU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687280849; x=1689872849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KD/qvxJOc3b4KgS6sdlf1So0mk1/jsrGWQamnUQ/Qk=;
        b=ZqyigDLS4JfidD3uUAvlsP6P7vR0MyOwqdMubv2rWcW2GvKcLh78gY7Cwy9Vlr/QX9
         l1hopRgGKZ0QPMOgNs9cqaG49DIrOOCWv7WAk1Pd9eXG8dTvzzEGt5rPGg/OdU6bWA/4
         gSmkM4kQNhaBka27cI6ZB8KtBcMoUZJFt3ZvXgU7XbA1NMsFnWSEomMAKpLhUA4aHqHT
         qgMFskjJewRMiny2xyBh5LsHCMaZJEDu4fZw3VpNMI0eJoon0USarJy2ICMzGtZ/qttY
         E3KfHK5qkqmQgGj3XwUzbW872OHQdj1vD0nCuIr+6QsHPzKwVFA1mD4lrl2E/kfWc3E9
         yF3Q==
X-Gm-Message-State: AC+VfDzr9MydEmsGETnA2OEpzewLwzOnQ9L/PP+MX2HC8D0s+mPWn63b
        6FclyI3yLr/Ry5UEosC96qmFJg==
X-Google-Smtp-Source: ACHHUZ6WoDeirwgdHBEytEMjfupCjGvK1KdKZCdmgtbK8JRrohidVrJDX9lb0R7kEPKmxzvnPVjVAg==
X-Received: by 2002:a05:6102:4ae:b0:440:cf20:3f90 with SMTP id r14-20020a05610204ae00b00440cf203f90mr386481vsa.18.1687280849073;
        Tue, 20 Jun 2023 10:07:29 -0700 (PDT)
Received: from jassi-Alienware-x17-R2.. (wnpgmb0311w-ds01-45-177-228.dynamic.bellmts.net. [206.45.177.228])
        by smtp.gmail.com with ESMTPSA id i10-20020ac860ca000000b003f9cca00552sm1288795qtm.93.2023.06.20.10.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:07:28 -0700 (PDT)
From:   jaswinder.singh@linaro.org
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        ilias.apalodimas@linaro.org, masahisa.kojima@linaro.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCHv2] dt-bindings: arm: socionext: add Synquacer platforms
Date:   Tue, 20 Jun 2023 12:07:25 -0500
Message-Id: <20230620170725.13794-1-jaswinder.singh@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230616035813.255062-1-jaswinder.singh@linaro.org>
References: <20230616035813.255062-1-jaswinder.singh@linaro.org>
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

From: Jassi Brar <jaswinder.singh@linaro.org>

Socionext's DeveloperBox is based on the SC2A11B SoC (Synquacer).
Specify bindings for the platform and boards based on that.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 .../bindings/arm/socionext/synquacer.yaml     | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/synquacer.yaml

diff --git a/Documentation/devicetree/bindings/arm/socionext/synquacer.yaml b/Documentation/devicetree/bindings/arm/socionext/synquacer.yaml
new file mode 100644
index 000000000000..c582d9c31213
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/socionext/synquacer.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/socionext/synquacer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Socionext Synquacer platform
+
+maintainers:
+  - Masahisa Kojima <masahisa.kojima@linaro.org>
+  - Jassi Brar <jaswinder.singh@linaro.org>
+
+description:
+  Socionext SC2A11B (Synquacer) SoC based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - socionext,developer-box
+              - socionext,synquacer
+          - const: socionext,sc2a11b
+
+additionalProperties: true
+
+...
-- 
2.34.1

