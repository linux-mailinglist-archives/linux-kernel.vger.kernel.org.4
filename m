Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161D3631930
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 05:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKUE0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 23:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiKUE0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 23:26:10 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD25248E3;
        Sun, 20 Nov 2022 20:26:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669004756; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=NtsxhcrC2wzFQZOlFCxsJZPDDQFKsEBsNkR7UEv2lxf1ucCsV6yrCYhh5KpYYqKz9dXzLtTIVnWlL5Mz6dJhA/OzEp02o+b/A7Tv/LKFcZR6Ec3TT/Ysv8hDTbRzueyc3XnzFrMzSLaSjqQw5N4vsytluBpKgx9nRFhd9Q7UcMk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669004756; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=MQp3Bcww7uwH34e0QnChRkJJwq/5NAzIg0lalgR19co=; 
        b=I4pi6Ji0iUgRMNAS9d4rKn2cf4HlU+ux9mYoa9D4f3654iieJgQgvBBXsRJJBKzKSNhihIFBkB4LzZu9Pq+PkiKpvLu6l4VZt6C/Ar97DkWi23mpcVyteZw5sUsW4gV3ojCS8SsnLxWy2dRcumfgGxjtcKqnFsy1sM9ChaFtuXU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669004756;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=MQp3Bcww7uwH34e0QnChRkJJwq/5NAzIg0lalgR19co=;
        b=CyMiwpmLl7/Whx6Sai27+Bqy58g7Yq2HjxGs92yFF6og+Ltfq2e5UtRruKwRP5a4
        9YdwTka9zZa0npfTQxcLi1x9R7pk/zrqPui33H7+1q0FvC2+40limBgXpOFq/BjBNrI
        386P/oCMKY+XZ0LA49IkIgeDKrSB5iHWO+mFM8Tg=
Received: from edelgard.fodlan.icenowy.me (112.94.100.29 [112.94.100.29]) by mx.zohomail.com
        with SMTPS id 1669004754310175.0741417958027; Sun, 20 Nov 2022 20:25:54 -0800 (PST)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 1/2] dt-bindings: timer: add a binding for LiteX Timer
Date:   Mon, 21 Nov 2022 12:25:44 +0800
Message-Id: <20221121042545.421532-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LiteX SoC generator has a timer core, which by default only
generates a simple down counter.

Add a DT binding for it.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 .../bindings/timer/litex,timer.yaml           | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/litex,timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/litex,timer.yaml b/Documentation/devicetree/bindings/timer/litex,timer.yaml
new file mode 100644
index 000000000000..bece07586c6b
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/litex,timer.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/litex,timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LiteX Timer
+
+maintainers:
+  - Icenowy Zheng <uwu@icenowy.me>
+
+description: |
+  The LiteX Timer is a count-down timer that is defaultly embedded
+  into all LiteX SoCs, unless explicitly disabled. It's fed directly
+  by the system clock like other LiteX peripherals.
+
+properties:
+  compatible:
+    const: litex,timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  litex,width:
+    description:
+      The width of the timer's value, specified as the width argument
+      when creating an instance of litex.soc.cores.Timer.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - litex,width
+
+additionalProperties: false
+
+examples:
+  - |
+     timer@a0006000 {
+        compatible = "litex,timer";
+        reg = <0xa0006000 0x20>;
+        clocks = <&sys_clk>;
+        interrupts = <17>;
+        litex,width = <32>;
+     };
-- 
2.37.1

