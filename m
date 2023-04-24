Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA2E6EC975
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjDXJvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjDXJvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:51:39 -0400
X-Greylist: delayed 320 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Apr 2023 02:51:33 PDT
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A536A30ED;
        Mon, 24 Apr 2023 02:51:32 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward501b.mail.yandex.net (Yandex) with ESMTP id EA3AB5EB34;
        Mon, 24 Apr 2023 12:36:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-Qq9jPfHD;
        Mon, 24 Apr 2023 12:36:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328963;
        bh=MwMLTayp0HWys1iBszBqm87up2I6e5D4xWwTL2iUXGA=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=qnsIM3s4872q0KHboA9Et3gXfLnlrYx9lWPyd36l2BnEgvEtG53vznqXcUxIC+dG0
         K0vuBQJoyfzzDrS3zZOS8Fksy4b1R3CPdTy/vBvoHJc5TRT8izE4sQFVlHoMOJUURD
         +VbFQbBdMLS9+C+AHT9q0NDh4hLDjwEjB0xVoAI0=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 30/43] dt-bindings: wdt: Add DT binding ts72xx wdt
Date:   Mon, 24 Apr 2023 15:34:46 +0300
Message-Id: <20230424123522.18302-31-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding for Technologic Systems TS-72xx watchdog.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../watchdog/technologic,ts72xx-wdt.yaml      | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/technologic,ts72xx-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/technologic,ts72xx-wdt.yaml b/Documentation/devicetree/bindings/watchdog/technologic,ts72xx-wdt.yaml
new file mode 100644
index 000000000000..0e06dbaec85f
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/technologic,ts72xx-wdt.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/technologic,ts72xx-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Technologic Systems TS-72xx based SBCs watchdog bindings
+
+maintainers:
+  - Wim Van Sebroeck <wim@linux-watchdog.org>
+  - Guenter Roeck <linux@roeck-us.net>
+
+allOf:
+  - $ref: "watchdog.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - technologic,ts7200-wdt
+
+  reg:
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog0: watchdog@5a002000 {
+      compatible = "technologic,ts7200-wdt";
+      reg = <0x23800000 0x01>, <0x23c00000 0x01>;
+      timeout-sec = <30>;
+    };
+
+...
+
-- 
2.39.2

