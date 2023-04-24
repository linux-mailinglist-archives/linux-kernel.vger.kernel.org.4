Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C616EC932
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjDXJnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXJnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:43:23 -0400
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF6E1BE6;
        Mon, 24 Apr 2023 02:43:22 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward500b.mail.yandex.net (Yandex) with ESMTP id F26065EB6B;
        Mon, 24 Apr 2023 12:35:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-Qivh3H9j;
        Mon, 24 Apr 2023 12:35:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328939;
        bh=hEtxBdyI2HO9wKRIi0w86SPEAP4jiwD5d234QJI8KJM=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=Pg41pce8J2/HqfIkzznYYKb27LAhjQIPZtMdsv3D+qt7YuC0/8oxQoFXvEn0EqM3W
         UN8oZZhVzsrAJzCSlh+T+xFIHBcbrZa3nxmvcjspMYDf5nBw9oqWdbsBsCPgbaFX80
         6qTLA2T8nbT1YDP1JQXfH+GC6cneDlP2iMEdrdq8=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 05/43] dt-bindings: timers: add DT bindings for Cirrus EP93xx
Date:   Mon, 24 Apr 2023 15:34:21 +0300
Message-Id: <20230424123522.18302-6-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds device tree bindings for the Cirrus Logic EP93xx
timer block used in these SoCs.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    Arnd Bergmann:
    - replaced ep93xx wildcard with ep9301

 .../bindings/timer/cirrus,ep93xx-timer.yaml   | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/cirrus,ep93xx-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/cirrus,ep93xx-timer.yaml b/Documentation/devicetree/bindings/timer/cirrus,ep93xx-timer.yaml
new file mode 100644
index 000000000000..ce8b8a5cb90a
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/cirrus,ep93xx-timer.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/cirrus,ep93xx-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic EP93xx timers bindings
+
+maintainers:
+  - Hartley Sweeten <hsweeten@visionengravers.com>
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+
+properties:
+  compatible:
+    const: cirrus,ep9301-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@80810000 {
+        compatible = "cirrus,ep9301-timer";
+        reg = <0x80810000 0x100>;
+        interrupt-parent = <&vic1>;
+        interrupts = <19>;
+    };
+...
-- 
2.39.2

