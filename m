Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B9F63C4D7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbiK2QMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbiK2QLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:11:44 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5E34B982
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:11:43 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p16so11317685wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2vfd4NfyR8Z3X2IKQ3UwNsmTJuUT8Ra5+BTS98+T/M=;
        b=g8+XUIGNkJTWNQdsPmr+SbneZPTadvXo7j73gjOuKUkfZwkueu2u7AA00jqX826/Hn
         qNgG7J0oA/7d0uTzxVYbUbs+KbThTOW4YKstyUoDeX8dMKzvMhlc3obp5nUCzjtDuw2P
         mSl/dzFzl8tqvsF5eRnqeXfL/i/jsGUxMEM+UNY529EaAdD0MCkKlRZNGPQQEye0Qfus
         XSsUBFU740nnzguQ05Tl6PvahVSVq9YMgVj+O1Mu4jzE9arcm4tYNeoIAnVaIMTdoFcU
         8n7JbZttKLXz2lPIT43AgU5vDZgiLv2CvWRPRAfVXLaTLo4WVj+vN4jD7pmERBo8NjO2
         NagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2vfd4NfyR8Z3X2IKQ3UwNsmTJuUT8Ra5+BTS98+T/M=;
        b=DNWg6/eOFceod1q7qkIZMx8VaRKumFEo3s/WcreL7hWcqLv5bu33BvNdrkLzLmZnYK
         VNDzGkzcnXcgp8T7/DW1zD3n3Ak2mlmHatGO+Jz8PqEfyPsGWSIOwsYLKbLcbn3r0bJp
         B/2JghOZz0cgLlwSjWvMn9CfFVQKRDzfKCACvCMOv3e9XuWDQzNs/aa+jS3QIKRcjtVB
         /bCgltPWdOaepphkGTLBjpJfJ4J3bDyVGwKbIoUkkV6UOmBOJ7ereH/1POVhYE5iYAyu
         ImdWxuGyBA/HG5IWA9zloXh1ew29uscLaSAWmR8KrRFJShtmAwImCJ36gU13HEiEuV4U
         Jylw==
X-Gm-Message-State: ANoB5pkGi5a2H0m5gfhTvBRFL1Lb0lSIUM+bnCqz5GPrX6OYWGK9C5DW
        3lfeSbXTCUs4va50H8sgy+Lwkw==
X-Google-Smtp-Source: AA0mqf5tKEJz4bthMkhUAZ7s02kYzqS6x/DLf1zCSjX5wrLLL//XLjag3ptA2Y16+XswrWxwPB8axA==
X-Received: by 2002:a05:600c:1603:b0:3cf:8279:c80c with SMTP id m3-20020a05600c160300b003cf8279c80cmr28508694wmn.169.1669738302208;
        Tue, 29 Nov 2022 08:11:42 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id n26-20020a05600c3b9a00b003c6b70a4d69sm3144522wms.42.2022.11.29.08.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 08:11:41 -0800 (PST)
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
Subject: [PATCH v8 1/4] dt-bindings: hwmon: fan: Add Common Fan Properties
Date:   Tue, 29 Nov 2022 17:11:31 +0100
Message-Id: <20221129161134.2672474-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221129161134.2672474-1-Naresh.Solanki@9elements.com>
References: <20221129161134.2672474-1-Naresh.Solanki@9elements.com>
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
 .../devicetree/bindings/hwmon/fan-common.yaml | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
new file mode 100644
index 000000000000..330fb1552821
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Fan Properties
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
+    maxItems: 1
+    description:
+      PWM signal for the fan
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

