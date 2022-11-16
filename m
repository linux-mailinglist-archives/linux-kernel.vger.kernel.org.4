Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEBD62BA3F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbiKPKye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbiKPKxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:53:43 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.129.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512AC554F5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1668595282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BxEZuRkRGD62WXnjbjEacCdYU53Qf097NU8Yuqsm2b8=;
        b=HdZCkQKA5FgqoP+AAebBVP9FKhFYfBk4tKoF2mYgSTMYc2dj4pCV3vom0zBAvYXPH/hcXV
        nRUpUprqEV8NVS+U6k/d2ElYX4v9gRbi9ZuezR9YTyyUY4W+26wiTOg4jTrLFXqKYYv4sJ
        ltOj+quGuG6nI8ughOkMD1ZcGov8iFhtZw+LMVv+sj6ohPPHRlpEPdit1SYvtT5TuRIzxe
        +2EnJpzSb762sqqzyVtVRZecEA6HK+yGnDWOF8tOZqnyA5nVB+j1Cqt63Vr/yjk8aMgHYn
        HIfOdkqjh+Je0TJbbrEj+0c4bqU3NEA/T7LeadtkWDyqR0/thMamXnHmtkenVg==
Received: from mail.maxlinear.com (174-47-1-83.static.ctl.one [174.47.1.83])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-643-XBWoGTwAOUOtqT3c9PDlWg-1; Wed, 16 Nov 2022 05:41:21 -0500
X-MC-Unique: XBWoGTwAOUOtqT3c9PDlWg-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.120) with Microsoft SMTP Server id 15.1.2375.24;
 Wed, 16 Nov 2022 02:41:15 -0800
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     <bigeasy@linutronix.de>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <hpa@zytor.com>,
        <alan@lxorguk.ukuu.org.uk>, <dirk.brandewie@gmail.com>,
        <grant.likely@secretlab.ca>, <sodaville@linutronix.de>,
        <devicetree-discuss@lists.ozlabs.org>,
        <linux-lgm-soc@maxlinear.com>,
        "Rahul Tanwar" <rtanwar@maxlinear.com>
Subject: [PATCH v2 2/2] x86/of: Convert & update Intel's APIC related binding schemas
Date:   Wed, 16 Nov 2022 18:41:02 +0800
Message-ID: <5ba7963fbd82a859ffd99c6d8edb4d717fce0e6c.1668589253.git.rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1668589253.git.rtanwar@maxlinear.com>
References: <cover.1668589253.git.rtanwar@maxlinear.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel's APIC family of interrupt controllers support local APIC
(lapic) & I/O APIC (ioapic). Convert existing bindings for lapic
& ioapic from text to YAML schema. Separate lapic & ioapic schemas.

Also, update more info and newly introduced optional property for
lapic to choose legacy PIC or virtual wire compatibility interrupt
delivery mode.

Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
---
 .../intel,ce4100-ioapic.txt                   | 26 --------
 .../intel,ce4100-ioapic.yaml                  | 62 ++++++++++++++++++
 .../intel,ce4100-lapic.yaml                   | 63 +++++++++++++++++++
 3 files changed, 125 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/=
intel,ce4100-ioapic.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/=
intel,ce4100-ioapic.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/=
intel,ce4100-lapic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,c=
e4100-ioapic.txt b/Documentation/devicetree/bindings/interrupt-controller/i=
ntel,ce4100-ioapic.txt
deleted file mode 100644
index 7d19f494f19a..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-i=
oapic.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Interrupt chips
----------------
-
-* Intel I/O Advanced Programmable Interrupt Controller (IO APIC)
-
-  Required properties:
-  --------------------
-     compatible =3D "intel,ce4100-ioapic";
-     #interrupt-cells =3D <2>;
-
-  Device's interrupt property:
-
-     interrupts =3D <P S>;
-
-  The first number (P) represents the interrupt pin which is wired to the
-  IO APIC. The second number (S) represents the sense of interrupt which
-  should be configured and can be one of:
-    0 - Edge Rising
-    1 - Level Low
-    2 - Level High
-    3 - Edge Falling
-
-* Local APIC
-  Required property:
-
-     compatible =3D "intel,ce4100-lapic";
diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,c=
e4100-ioapic.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
intel,ce4100-ioapic.yaml
new file mode 100644
index 000000000000..537bb69cf2d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-i=
oapic.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/intel,ce4100-ioap=
ic.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel I/O Advanced Programmable Interrupt Controller (I/O APIC)
+
+maintainers:
+  - Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+
+
+description: |
+  Intel's Advanced Programmable Interrupt Controller (APIC) is a
+  family of interrupt controllers. The APIC is a split
+  architecture design, with a local component (LAPIC) integrated
+  into the processor itself and an external I/O APIC. Local APIC
+  (lapic) receives interrupts from the processor's interrupt pins,
+  from internal sources and from an external I/O APIC (ioapic).
+  And it sends these to the processor core for handling.
+  See https://pdos.csail.mit.edu/6.828/2008/readings/ia32/IA32-3A.pdf
+  Chapter 8 for more details.
+
+  Many of the Intel's generic devices like hpet, ioapic, lapic have
+  the ce4100 name in their compatible property names because they
+  first appeared in CE4100 SoC. See bindings/x86/ce4100.txt for more
+  details on it.
+
+  This schema defines bindings for I/O APIC interrupt controller.
+ =20
+properties:
+  compatible:
+    - const: intel,ce4100-ioapic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - '#interrupt-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    ioapic1: interrupt-controller@fec00000 {
+        compatible =3D "intel,ce4100-ioapic";
+        reg =3D <0xfec00000 0x1000>;
+        #interrupt-cells =3D <2>;
+        #address-cells =3D <0>;
+        interrupt-controller;
+    };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,c=
e4100-lapic.yaml b/Documentation/devicetree/bindings/interrupt-controller/i=
ntel,ce4100-lapic.yaml
new file mode 100644
index 000000000000..890e07351506
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-l=
apic.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/intel,ce4100-lapi=
c.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel Local Advanced Programmable Interrupt Controller (LAPIC)
+
+maintainers:
+  - Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+
+
+description: |
+  Intel's Advanced Programmable Interrupt Controller (APIC) is a
+  family of interrupt controllers. The APIC is a split
+  architecture design, with a local component (LAPIC) integrated
+  into the processor itself and an external I/O APIC. Local APIC
+  (lapic) receives interrupts from the processor's interrupt pins,
+  from internal sources and from an external I/O APIC (ioapic).
+  And it sends these to the processor core for handling.
+  See https://pdos.csail.mit.edu/6.828/2008/readings/ia32/IA32-3A.pdf
+  Chapter 8 for more details.
+
+  Many of the Intel's generic devices like hpet, ioapic, lapic have
+  the ce4100 name in their compatible property names because they
+  first appeared in CE4100 SoC. See bindings/x86/ce4100.txt for more
+  details on it.
+
+  This schema defines bindings for local APIC interrupt controller.
+ =20
+properties:
+  compatible:
+    - const: intel,ce4100-lapic
+
+  reg:
+    maxItems: 1
+
+  intel,virtual-wire-mode:
+    description: Intel defines a few possible interrupt delivery
+      modes. With respect to boot/init time, mainly two interrupt
+      delivery modes are possible.
+      PIC Mode - Legacy external 8259 compliant PIC interrupt controller.
+      Virtual Wire Mode - use lapic as virtual wire interrupt delivery mod=
e.
+      For ACPI or MPS spec compliant systems, it is figured out by some re=
ad
+      only bit field/s available in their respective defined data structur=
es.
+      For OF based systems, it is by default set to PIC mode.
+      But if this optional boolean property is set, then the interrupt del=
ivery
+      mode is configured to virtual wire compatibility mode.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    lapic0: interrupt-controller@fee00000 {
+        compatible =3D "intel,ce4100-lapic";
+        reg =3D <0xfee00000 0x1000>;
+        intel,virtual-wire-mode;
+    };
--=20
2.17.1

