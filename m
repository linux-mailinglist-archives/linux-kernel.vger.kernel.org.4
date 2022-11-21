Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1AE632206
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiKUMaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiKUM3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:29:45 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8DA617D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:29:44 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso10504249wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BRaWwAMGebNoGykx3XuMu8YkZSBESQuLHrSVaFuRcM=;
        b=RQoFUkkW5Zx+3GW0+cbvDbjfe6jWvx0d95QAlTBP9aNW4JxOqt08+yGXfc9Szu/UiO
         EoWV0RzB/Smh33j+4JaDeq/dwMXFkrlj8vbSd/cMoCcsbbJv/kVhS0Hb06eM9dQLWYpL
         MiFV8/OHF5i+f4jkObyBv7PY3Vc8XcqNTX7k09HOTv6TrIWdfTCV7Z6Y8GAfT8ccAC5z
         3BfqiysK9T4rHwKnmtB/4gtYKAKq4JvcFEUSqwey5IN1MrbLBeX0wxCOLwN4V3tRAAcu
         kBB8nTv4s3zuFXxxNHjGkm2mFCjm5plLyqrDWjiYt/TzhfXToP6Bu96fTQ7FgPmLycud
         /nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BRaWwAMGebNoGykx3XuMu8YkZSBESQuLHrSVaFuRcM=;
        b=Y3nyTfC4LimyPH8anViVFEjgS7hJUQ47vcOhn7mpr1IL7uNvslNfuGMmlBuxqquoBZ
         wVlKs6MqfENDLo5z70IWGy5lKuYfYmKPXxMbfOXPN2G5Krwrq7o3apP3xiPcr2z9xq6w
         YA8WWQ3DfV3/LQqfqDRO5WrjDOgauVTTDVc98o/x1pP25VEQGZRntYacwvRvR3dmIAju
         Jy6Ipmlq5NlvG7wY5HaykUZTEsMrb8JEClQBqccxEqal3KQwtW0KVeGy86fdjEBugi0g
         aQQbCB+9CwmSdIo4rPAUHjekc/jhOOMT98LwWBI7mClltN5b3T/xnbOe/lFOBdrqYwRk
         i7iQ==
X-Gm-Message-State: ANoB5pn5zskdScseH/hBANT1b7rOlnBiA2atwfXXUVN8nTaXdFEapKI4
        Z45LnU40USfZOAElgAT19PIJlw==
X-Google-Smtp-Source: AA0mqf4W0NWLDrtN8YSSF1bWEPq4SAUyqTKy3rmQY/zTB3qa0uUGNYU9fUbQ/k+cHkQfSW4lLk3xeA==
X-Received: by 2002:a05:600c:3ac9:b0:3cf:cfc8:9450 with SMTP id d9-20020a05600c3ac900b003cfcfc89450mr12332597wms.99.1669033782910;
        Mon, 21 Nov 2022 04:29:42 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id dn12-20020a05600c654c00b003cf6c2f9513sm13929015wmb.2.2022.11.21.04.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 04:29:42 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v7 1/4] dt-bindings: hwmon: fan: Add fan binding to schema
Date:   Mon, 21 Nov 2022 13:29:29 +0100
Message-Id: <20221121122932.2493174-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221121122932.2493174-1-Naresh.Solanki@9elements.com>
References: <20221121122932.2493174-1-Naresh.Solanki@9elements.com>
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

Add common fan properties bindings to a schema.

Bindings for fan controllers can reference the common schema for the
fan

child nodes:

  patternProperties:
    "^fan@[0-2]":
      type: object
      $ref: fan-common.yaml#

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 .../devicetree/bindings/hwmon/fan-common.yaml | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
new file mode 100644
index 000000000000..0535d37624cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common fan properties
+
+maintainers:
+  - Naresh Solanki <naresh.solanki@9elements.com>
+
+properties:
+  max-rpm:
+    description:
+      Max RPM supported by fan.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  min-rpm:
+    description:
+      Min RPM supported by fan.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  pulses-per-revolution:
+    description:
+      The number of pulse from fan sensor per revolution.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  target-rpm:
+    description:
+      Target RPM the fan should be configured during driver probe.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  pwms:
+    description:
+      PWM provider.
+
+  label:
+    description:
+      Optional fan label
+
+  fan-supply:
+    description:
+      Power supply for fan.
+
+additionalProperties: true
+
+...
-- 
2.37.3

