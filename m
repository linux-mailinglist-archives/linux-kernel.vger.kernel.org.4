Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB6864C7A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbiLNLBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238092AbiLNLA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:00:58 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251041ADA8;
        Wed, 14 Dec 2022 03:00:55 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h10so18873420wrx.3;
        Wed, 14 Dec 2022 03:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxEwCtwZkbo/SE2lM+SFwhtddp9U5nr3fRj5lE/pCQU=;
        b=qkIo8apE6wPveAxrTPls0JzOt/rL9PFCLyGUfd7u8N6CEsd+GnAynINEmMpFhDmCh3
         +qxl0KMr94ttaHM1+9vGi5TvBw2aP46Uzj0HYeqizB9gYpJYEsAp9w5+oSra3Jc50rjc
         XbFE5pvpA8woVsD4Wr2SdQBtZ2fKMCDSHY5Oua9rscOltiKOhVRNMd9mHJK09mAb4w8F
         JwCtAELfxo8zMslMPj8L3exc09pWQmAksKe5s8Cc7IqRDwJ+jy1Ph0RKJnZbiW0/hbQa
         93JYj0PWqkVPjrYG0fYTISnEPJ8cTvGIWY2SHUxMrSTv8DhUTbEt+wjIUX0e2RmXbxzP
         jjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxEwCtwZkbo/SE2lM+SFwhtddp9U5nr3fRj5lE/pCQU=;
        b=7evsxIGgzW2tuzpPRvocF7cAmHTfDPDswWLO3N3o4/JdydU6+lZP2MaZGgiMXER9q9
         KHBt69tHbm9r3IAij9drCL1CU16OsAvlrDTaP9W/INugl0WNCNd/zmKJYnw2U74wmMCp
         uDFbwXZVb//gbm6n1iIjjtqGrxywz0ANBj7M/ktCG06yKw52Y39EgriGVfw5A/HqGI1x
         VWbDFiOmSJW/4wNAgpua7ZpV/w5PIv9LBtT0peVPsyeM+Tz8qMeKOMHLVqHV4n4JMibz
         L9uuzMO6v0OGVkfaYaV788HiupuUtLb2Dxj+imFMdVtLMQj1gmvR1f6M9b5lsN+b7Gpd
         GMEw==
X-Gm-Message-State: ANoB5pmXkxCCoIhcqG/ERjl8TSaqPmhJIvTteiK3r4ZHaXaoibzg/s3L
        e0Cm+brqMW7mSp/D1b5EXNI=
X-Google-Smtp-Source: AA0mqf59FBVRgtaf6cj5kFR/HiVbmK7de5Q+pWQcjUEGezL/ocj+OLcGbULF+zUHMy1A/kYu6VKu7g==
X-Received: by 2002:a05:6000:910:b0:236:61bb:c79b with SMTP id bz16-20020a056000091000b0023661bbc79bmr16981257wrb.3.1671015653583;
        Wed, 14 Dec 2022 03:00:53 -0800 (PST)
Received: from localhost.localdomain (2a02-8428-46a0-7c01-bc7c-15f1-6c3b-ad74.rev.sfr.net. [2a02:8428:46a0:7c01:bc7c:15f1:6c3b:ad74])
        by smtp.gmail.com with ESMTPSA id h1-20020adfaa81000000b002366c3eefccsm2462096wrc.109.2022.12.14.03.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 03:00:52 -0800 (PST)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: display/panel: Add the Focaltech gpt3
Date:   Wed, 14 Dec 2022 12:00:37 +0100
Message-Id: <20221214110037.149387-3-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221214110037.149387-1-cbranchereau@gmail.com>
References: <20221214110037.149387-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the Forcaltech gpt3, which is a 640x480 3.0" 4:3
IPS LCD Panel found in the YLM/Anbernic RG300X handheld.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
---
 .../display/panel/focaltech,gpt3.yaml         | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml b/Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml
new file mode 100644
index 000000000000..d54e96b2a9e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/focaltech,gpt3.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/focaltech,gpt3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Focaltech GPT3 3.0" (640x480 pixels) IPS LCD panel
+
+maintainers:
+  - Christophe Branchereau <cbranchereau@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: focaltech,gpt3
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - power-supply
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "focaltech,gpt3";
+            reg = <0>;
+
+            spi-max-frequency = <3125000>;
+
+            reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
+
+            backlight = <&backlight>;
+            power-supply = <&vcc>;
+
+            port {
+                panel_input: endpoint {
+                    remote-endpoint = <&panel_output>;
+                };
+            };
+        };
+    };
-- 
2.35.1

