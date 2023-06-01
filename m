Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5BA71929A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjFAFr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjFAFqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:46:47 -0400
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24CD198;
        Wed, 31 May 2023 22:46:21 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward103a.mail.yandex.net (Yandex) with ESMTP id A6CD546C82;
        Thu,  1 Jun 2023 08:46:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pjGDMhnDduQ0-hLahdx3m;
        Thu, 01 Jun 2023 08:46:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685598378;
        bh=8mv9WgoxbioXCOy16e14XS+bGBzb5G+x5fHcfpNSO94=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=bAdCoH4GwgznK3z6WyG85AD3cuS2Egc8kxwU4LQF2pAwXudQK4/8SyAz2zPd4g2pl
         tYafkfQB2IelK0f4aPYMNZXueyIXq78YEL7lWhbSuqEMscSUks5C85aQ9H07wwowdW
         +ldhDHbBc2TShyNOjNI9+/XGM1rxaaNDnAMOzSKU=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 29/43] dt-bindings: rtc: Add ST M48T86
Date:   Thu,  1 Jun 2023 08:45:34 +0300
Message-Id: <20230601054549.10843-11-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML bindings for ST M48T86 / Dallas DS12887 RTC.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    v0 -> v1:
    
    - s/dallas/st/
    - description for regs
    - s/additionalProperties/unevaluatedProperties/
    - add ref rtc.yaml
    - changed compatible to st,m48t86
    - dropped label in example
    - replaced Alessandro Alessandro to Alexandre Belloni

 .../bindings/rtc/st,m48t86-rtc.yaml           | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/st,m48t86-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/st,m48t86-rtc.yaml b/Documentation/devicetree/bindings/rtc/st,m48t86-rtc.yaml
new file mode 100644
index 000000000000..eb8e6451d7c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/st,m48t86-rtc.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/st,m48t86-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST M48T86 / Dallas DS12887 RTC wirh SRAM
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+properties:
+  compatible:
+    enum:
+      - st,m48t86
+
+  reg:
+    items:
+      - description: index register
+      - description: data register
+
+allOf:
+  - $ref: rtc.yaml
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    rtc@10800000 {
+      compatible = "st,m48t86";
+      reg = <0x10800000 0x1>, <0x11700000 0x1>;
+    };
+
+...
-- 
2.37.4

