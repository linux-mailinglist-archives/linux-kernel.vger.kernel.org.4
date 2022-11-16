Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E30162CCC6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbiKPVgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbiKPVg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:36:28 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DC512778
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:36:23 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id z14so32068245wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqZxBgmVFxK0RvfpAaJX1POwshKoiOnk2il2KX/mpC4=;
        b=E6pZQI4Mmi3/a6ONx5vksspSvTZNGeyZ4k2vN/72UTTHl4xh+Gg2QsMoCMJxa+s1SL
         DBSJgHf4WUHSfAczvCPijUb1Z7uO7cU0S1i7EYLxHmsOvcXDI17t3HMX5FlX8MXn4fi8
         O2B6Vab1PDALGtW+Ke6Lv7txyGy93tqfXBi+iN6d854vFxNYIOIFPqgOmBXVPA18hzTM
         venlEkhDy5So9G4qttDNPYZ+ytl8Y9Qbij9Nt2q0J1jNjhyG8PQxOTiZh2IDHdXPFPai
         e55kj53xb35uZQoAjrOaw4r/T7W68eZHT4QlrH3KXtLCfzxqEl6hi4LXsLoAANjOCTI5
         A2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqZxBgmVFxK0RvfpAaJX1POwshKoiOnk2il2KX/mpC4=;
        b=gmPzusy10NMk9TnhbgZmqYFGBqZcjSOo15VqKjTPEYtbvfo9tuWxmxUFqe/g/oZZAj
         ahMo6YtNne6VffBFvVZ6QvR+B9/FqZOI3ign+YiLH5LG1QE3+rsezKWQKaovnHeS2wKb
         uMXBo8egdr+GaOmK75WQ9wATNrwJ5heqE1q2dj90TvR1H9go0wzNYHGP8vl9dVc4xGhi
         Tdj9eTAOU/Fuy53OkM6MFURVr/wUilk7056YwYoSXe9HhqrocVUixZMJn9fhcozMO5JE
         ufw1Sb7u1XeSWkB+KyM+y6WfK+c/egaH1pE190N26lX6bt5SllsPnzu5p7D5hAwj1q/c
         k3ZQ==
X-Gm-Message-State: ANoB5pmqUH17Hp3XxMI+bOyDSJtJTelB3euNSKZbIH5x4a2VoJfxv4c0
        svK11KpC38rAnQcsV53Tm2yocg==
X-Google-Smtp-Source: AA0mqf7c14HGlhArM1SFATdo/QKLxMofYz5UwE2bJtueWhSO6c2Fl/MIc2MnlekrtqaObQlxvCS6gw==
X-Received: by 2002:adf:f7c6:0:b0:236:7a11:b06a with SMTP id a6-20020adff7c6000000b002367a11b06amr15080222wrq.298.1668634581864;
        Wed, 16 Nov 2022 13:36:21 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id fn15-20020a05600c688f00b003b47ff307e1sm3133045wmb.31.2022.11.16.13.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:36:21 -0800 (PST)
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
Subject: [PATCH v6 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Date:   Wed, 16 Nov 2022 22:36:13 +0100
Message-Id: <20221116213615.1256297-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221116213615.1256297-1-Naresh.Solanki@9elements.com>
References: <20221116213615.1256297-1-Naresh.Solanki@9elements.com>
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
 .../devicetree/bindings/hwmon/fan-common.yaml | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
new file mode 100644
index 000000000000..1954882eed77
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
@@ -0,0 +1,42 @@
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

