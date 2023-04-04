Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4546D5820
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjDDFo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 01:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDDFoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:44:55 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F23910E7;
        Mon,  3 Apr 2023 22:44:54 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u10so30264329plz.7;
        Mon, 03 Apr 2023 22:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680587094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d+F0dZyiKU33/0WvR2UeV+9/wtxwNMTO8WsL5WoTX7o=;
        b=RsEywNBljP5SQTDWGasJGwoCh7g81TmHS4a6UJOXairEHdx6g/wWQu8IJI5dgNaz6s
         vyYQfzfaDZHioGpHf2VYGhaYQo5aLxQog4LV7OlkNZEFRvJtRxXcaKJleRtgzelZZ24B
         NZDQWadzXkBzUrYXmRvKeWZjXU7RM36XWwddaICO4jaHyPc0AN6jn9Gnp4VuEL4xcvhf
         UsGDwc5rresJ9Cy1l1wi/tF9rFEndtXYuKEGZmazFQULHPvc7zMCnNsHg12G14FK9GDb
         gMITVEDucn9egBYp7N5FjQCTr4ZVIyyzkbx19mIDI4DhMf+8JJdf6xRvsFhUXNrGJypW
         +hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680587094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+F0dZyiKU33/0WvR2UeV+9/wtxwNMTO8WsL5WoTX7o=;
        b=7nnFJXSM8CHe1BcFGQl2wPkNbHnK6STP+k5WpVyhP5JBZMi/Pv4b7KOaYGMc3Bsazl
         SiCa13CT6mALqecKRFIHeSKVafCjljhUqe5iEJeKJaGbF3r3j84VR/geNvWcPVIV8Wvd
         YMS+3auUWw1HrgY+LmSMNBkoegDRzrhBV6dBKmeuY4ijR0T4TBwHPZ6117798Gkr/xLW
         IPpfmubEBsHgy8uQ9dExR78gV8QJ1v48T/Zz9fGFsHEmNp8uztgmEs/yau7wbBQ/ni+Q
         dQoUpMwow057kb5XJzB52VWZ6RKd9WzFMkaa34KksIM0SFYvoT2gnII3O+QYrdb/3vsb
         9/0g==
X-Gm-Message-State: AAQBX9f0svOYntSIHcAAasN+1XNfnoyPc/Hs+zv3JkFq5GM5AKENnvTj
        7L4flPjflNS8BZNiejGBJ80=
X-Google-Smtp-Source: AKy350YtPKdZBGjXSSDeuONJcN7dsaU2ZhZuFQDhwWcrAsPRJlTUwTagqO1GZWQoSzXgapGVf6ujxw==
X-Received: by 2002:a05:6a20:b806:b0:d9:9d04:2c73 with SMTP id fi6-20020a056a20b80600b000d99d042c73mr857102pzb.45.1680587093639;
        Mon, 03 Apr 2023 22:44:53 -0700 (PDT)
Received: from otabekn-virtual-machine.localdomain ([211.169.38.26])
        by smtp.gmail.com with ESMTPSA id s21-20020a056a00195500b0062dbafced27sm7802624pfk.27.2023.04.03.22.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 22:44:53 -0700 (PDT)
From:   Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>
Cc:     Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: dt-bindings: armada-37xx-wdt: convert text binding
Date:   Tue,  4 Apr 2023 14:44:08 +0900
Message-Id: <20230404054449.5665-1-otabeknazrullaev1998@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Armada 37xx watchdog timer controller to YAML format

Signed-off-by: Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>
---
 .../bindings/watchdog/armada-37xx-wdt.txt     | 23 --------
 .../bindings/watchdog/armada-37xx-wdt.yaml    | 54 +++++++++++++++++++
 2 files changed, 54 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt b/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
deleted file mode 100644
index a8d00c31a1d8..000000000000
--- a/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-* Armada 37xx CPU Watchdog Timer Controller
-
-Required properties:
-- compatible : must be "marvell,armada-3700-wdt"
-- reg : base physical address of the controller and length of memory mapped
-	region.
-- clocks : the clock feeding the watchdog timer. See clock-bindings.txt
-- marvell,system-controller : reference to syscon node for the CPU Miscellaneous
-	Registers
-
-Example:
-
-	cpu_misc: system-controller@d000 {
-		compatible = "marvell,armada-3700-cpu-misc", "syscon";
-		reg = <0xd000 0x1000>;
-	};
-
-	wdt: watchdog@8300 {
-		compatible = "marvell,armada-3700-wdt";
-		reg = <0x8300 0x40>;
-		marvell,system-controller = <&cpu_misc>;
-		clocks = <&xtalclk>;
-	};
diff --git a/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.yaml b/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.yaml
new file mode 100644
index 000000000000..e9bdae720bed
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/armada-37xx-wdt.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/watchdog/armada-37xx-wdt.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+maintainers:
+  - Otabek Nazrullaev <otabeknazrullaev1998@gmail.com>
+
+title: Armada 37xx CPU Watchdog Timer Controller
+
+allOf:
+  - $ref: "watchdog.yaml#"
+
+properties:
+  compatible:
+    const: marvell,armada-3700-wdt
+
+  reg:
+    maxItems: 1
+    description: |
+      base physical address of the controller and length of memory mapped
+      region.
+
+  clocks:
+    maxItems: 1
+    description: the clock feeding the watchdog timer.
+
+  marvell,system-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: |
+      reference to syscon node for the CPU Miscellaneous Registers
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - marvell,system-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    cpu_misc: system-controller@d000 {
+      compatible = "marvell,armada-3700-cpu-misc", "syscon";
+      reg = <0xd000 0x1000>;
+    };
+
+    watchdog@8300 {
+      compatible = "marvell,armada-3700-wdt";
+      reg = <0x8300 0x40>;
+      marvell,system-controller = <&cpu_misc>;
+      clocks = <&xtalclk>;
+    };
-- 
2.34.1

