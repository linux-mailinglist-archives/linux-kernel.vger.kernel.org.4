Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8973B6ECA3B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 12:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjDXKV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 06:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjDXKVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 06:21:06 -0400
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8243C04;
        Mon, 24 Apr 2023 03:20:49 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id 940275EDD8;
        Mon, 24 Apr 2023 12:36:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-IWWSMic2;
        Mon, 24 Apr 2023 12:36:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328962;
        bh=d3R4SlbJR9GyKNTHeSNJIKou6BcJywQO8CN3xVIBaKM=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=OiJhIKfvqQJYJwfDut+7wSS0wQeQ/4nY/0VNMXXBNQ5ACuI91r7JkJ63nySQ+U8jJ
         9hf8AEjul23/MMiL7ihkOAM11yFpF+/MoZYiqCd7Nz4TQHgcBv1ryTZBjbIQZxPbPQ
         IVQwaFRJTLeNVNrBPTudKgefHg3wI5T4wJ/2HUwg=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 28/43] dt-bindings: rtc: Add DT binding m48t86 rtc
Date:   Mon, 24 Apr 2023 15:34:44 +0300
Message-Id: <20230424123522.18302-29-nikita.shubin@maquefel.me>
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

Add YAML bindings for ST M48T86 / Dallas DS12887 RTC.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 .../bindings/rtc/dallas,rtc-m48t86.yaml       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/dallas,rtc-m48t86.yaml

diff --git a/Documentation/devicetree/bindings/rtc/dallas,rtc-m48t86.yaml b/Documentation/devicetree/bindings/rtc/dallas,rtc-m48t86.yaml
new file mode 100644
index 000000000000..51f98bdbc385
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/dallas,rtc-m48t86.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/dallas,rtc-m48t86.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST M48T86 / Dallas DS12887 RTC bindings
+
+maintainers:
+  - Alessandro Zummo <a.zummo@towertech.it>
+
+properties:
+  compatible:
+    const: dallas,rtc-m48t86
+
+  reg:
+    maxItems: 2
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    rtc1: rtc@10800000 {
+        compatible = "dallas,rtc-m48t86";
+        reg = <0x10800000 0x1>, <0x11700000 0x1>;
+    };
+
+...
+
-- 
2.39.2

