Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FB866DF45
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 14:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjAQNso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 08:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjAQNsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 08:48:03 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CE934C1F;
        Tue, 17 Jan 2023 05:48:02 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso6239512pjg.2;
        Tue, 17 Jan 2023 05:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsZvgpdsbOSZhJAZ1QAJPedjqfxUnjeKrZqaXm358r0=;
        b=Y0aqBtoOHjCVqYsvR98g7ZosHRR3wcidEggRSlAS73WqTuKhr0y1bCfXnTshMho+4c
         u4yJoh3kRcHoOAQlItFDcr9kQ733A4bCElXX9l7MPOo60dl5ZZknfZ/7ZFL+stS8Mb4y
         ZUxh3exectYTZre84JGIPrgKieU8WCd2AWzz9izq40ACJzf9KTs9cFdRt1E4obi8V2ib
         7o1HhrqhYneJyNYoZy0ynyoAz20U/NHHqhzrYlcwWIc1dkS7eMQQKqYuD+EEUUz2a7wg
         ZMPATcxthLmkKPQHTPsCYeCZCAjv0ZeqzgswFWF5eSPP4IV1jQvEOFv6amj5Aj2AXWhO
         6Obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsZvgpdsbOSZhJAZ1QAJPedjqfxUnjeKrZqaXm358r0=;
        b=kAs/XcscsmzouA/mzrscmH6VFB+Z7AUnYf1C5mVcseu9L5mUDW2FN0HGmzvhnDjuKa
         /z5nuMQASzic7Dd5CNMKNJJITja/zUW+o90FnYXu82chqZSQ917xyUvHOxPv/bQW522A
         54SPBAtUd7+GkJxJS/yvKBWKZVKrdRYRJFyamXd8FzzDydVBFV5v8HbsymlcTz8Nqfd0
         KyS44TODZ9zbDPqhpCQI9vJLs0nerBD/ruLd6K1k2eetZb56AgzTNnSllbtg0LsWqDEy
         a+aVSaVp1EhI89HUI+7kuT95SPokPohPG7rtwz4EMy7xPArGU6os22LiPFBJ4H94s3Tb
         nxCw==
X-Gm-Message-State: AFqh2kqxRATeycY2ogcBTjzu+D2x0Hg2sDyCca7vnhA3J9GOz9WBS/WU
        bHk7HvhuD4QU/sGxPB4C2Dc=
X-Google-Smtp-Source: AMrXdXu/zWBQUKC6ZNgX4gXkB2pdzeuGV+K0owx8758eOjlAQC+ZwRI1EVhNsBftFCuNwmBqxEowSA==
X-Received: by 2002:a17:902:c10d:b0:191:3aad:cf33 with SMTP id 13-20020a170902c10d00b001913aadcf33mr4164697pli.55.1673963281835;
        Tue, 17 Jan 2023 05:48:01 -0800 (PST)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902900300b00189393ab02csm3747958plp.99.2023.01.17.05.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:48:01 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-fbdev@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v4 2/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866 backlight
Date:   Tue, 17 Jan 2023 21:47:42 +0800
Message-Id: <20230117134742.23238-2-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230117134742.23238-1-lujianhua000@gmail.com>
References: <20230117134742.23238-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kinetic KTZ8866 backlight binding documentation.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
Changes in v2:
  - Remove "items" between "compatible" and "const: kinetic,ktz8866"
  - Change "additionalProperties" to "unevaluatedProperties"

Changes in v3:
  - Add Krzysztof's R-b

Changes in v4:
  - Drop Krzysztof's R-b
  - Add some new properties

 .../leds/backlight/kinetic,ktz8866.yaml       | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
new file mode 100644
index 000000000000..18571d69accb
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktz8866.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktz8866.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kinetic Technologies KTZ8866 backlight
+
+maintainers:
+  - Jianhua Lu <lujianhua000@gmail.com>
+
+description: |
+  The Kinetic Technologies KTZ8866 is a high efficiency 6-sinks led backlight
+  with dual lcd bias power.
+  https://www.kinet-ic.com/ktz8866/
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: kinetic,ktz8866
+
+  current-num-sinks:
+    description: Number of LED current sinks.
+
+  current-ramping-time:
+    description: LED current ramping time.
+
+  led-ramping-time:
+    description: LED on/off ramping time.
+
+  enable-lcd-bias:
+    description: Set if we want to output bias power supply for LCD.
+    type: boolean
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    backlight {
+        compatible = "kinetic,ktz8866";
+
+        pinctrl-names = "default";
+        pinctrl-0 = <&bl_en_default>;
+
+        current-num-sinks = <5>;
+        current-ramping-time = <128>;
+        led-ramping-time = <1>;
+        enable-lcd-bias;
+    };
-- 
2.38.2

