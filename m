Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C27637442
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiKXInO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiKXInN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:43:13 -0500
Received: from us-smtp-delivery-115.mimecast.com (us-smtp-delivery-115.mimecast.com [170.10.133.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277DC72982
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1669279336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9oc/CybFzgvV8B8FFM+ex66MR6wvz6dieP3wlzbGgsM=;
        b=hnVDSPhrQrbb21oQZKyLQ0Gil3XP81LcVM8sdwZ6dK1xQZDvg09kI17KSnXw/CtgmqBY33
        2Q4yXtuZMhgQKu3ZquE+JwAWcoM6NMNGEeaUU78FUSVwdnUh2std8ri2Jt0VF2whw4EAig
        O4SFfS71jebNNs3EE8rPf5FdtOnxb4EXkiGuOSes1HIxuXAl0lHYIZWh7HLxrWCWQoy+T5
        Gfx/V1+WOr7cpSZrlqW2dtnhFJWns7mseddayYONnjw0UXXkeF2oqB2izYIojIIV19sc6h
        0AyLDHS3YzXQWQHxPgdYquItJYuCEYSP5H3vMxonhpNMuZkzIwCim+NL3WXr/w==
Received: from mail.maxlinear.com (174-47-1-84.static.ctl.one [174.47.1.84])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 us-mta-224-Cmjdxds4MA606ZxQugMShw-1; Thu, 24 Nov 2022 03:42:15 -0500
X-MC-Unique: Cmjdxds4MA606ZxQugMShw-1
Received: from sgsxdev001.isng.phoenix.local (10.226.81.111) by
 mail.maxlinear.com (10.23.38.119) with Microsoft SMTP Server id 15.1.2375.24;
 Thu, 24 Nov 2022 00:42:09 -0800
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-lgm-soc@maxlinear.com>
Subject: [PATCH v5 1/4] dt-bindings: x86: apic: Convert Intel's APIC bindings to YAML schema
Date:   Thu, 24 Nov 2022 16:41:40 +0800
Message-ID: <20221124084143.21841-2-rtanwar@maxlinear.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221124084143.21841-1-rtanwar@maxlinear.com>
References: <20221124084143.21841-1-rtanwar@maxlinear.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel's APIC family of interrupt controllers support local APIC
(lapic) & I/O APIC (ioapic). Convert existing bindings for lapic
& ioapic from text to YAML schema. Separate lapic & ioapic schemas.
Addditionally, add description which was missing in text file and
add few more required standard properties which were also missing
in text file.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
---
 .../intel,ce4100-ioapic.txt                   | 26 --------
 .../intel,ce4100-ioapic.yaml                  | 60 +++++++++++++++++++
 .../intel,ce4100-lapic.yaml                   | 57 ++++++++++++++++++
 3 files changed, 117 insertions(+), 26 deletions(-)
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
index 000000000000..39ab8cdd19b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-i=
oapic.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/intel,ce4100-ioap=
ic.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel I/O Advanced Programmable Interrupt Controller (IO APIC)
+
+maintainers:
+  - Rahul Tanwar <rtanwar@maxlinear.com>
+
+description: |
+  Intel's Advanced Programmable Interrupt Controller (APIC) is a
+  family of interrupt controllers. The APIC is a split
+  architecture design, with a local component (LAPIC) integrated
+  into the processor itself and an external I/O APIC. Local APIC
+  (lapic) receives interrupts from the processor's interrupt pins,
+  from internal sources and from an external I/O APIC (ioapic).
+  And it sends these to the processor core for handling.
+  See [1] Chapter 8 for more details.
+
+  Many of the Intel's generic devices like hpet, ioapic, lapic have
+  the ce4100 name in their compatible property names because they
+  first appeared in CE4100 SoC.
+
+  This schema defines bindings for I/O APIC interrupt controller.
+
+  [1] https://pdos.csail.mit.edu/6.828/2008/readings/ia32/IA32-3A.pdf
+
+properties:
+  compatible:
+    const: intel,ce4100-ioapic
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
+        interrupt-controller;
+        #interrupt-cells =3D <2>;
+    };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/intel,c=
e4100-lapic.yaml b/Documentation/devicetree/bindings/interrupt-controller/i=
ntel,ce4100-lapic.yaml
new file mode 100644
index 000000000000..55184cb49432
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-l=
apic.yaml
@@ -0,0 +1,57 @@
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
+  - Rahul Tanwar <rtanwar@maxlinear.com>
+
+description: |
+  Intel's Advanced Programmable Interrupt Controller (APIC) is a
+  family of interrupt controllers. The APIC is a split
+  architecture design, with a local component (LAPIC) integrated
+  into the processor itself and an external I/O APIC. Local APIC
+  (lapic) receives interrupts from the processor's interrupt pins,
+  from internal sources and from an external I/O APIC (ioapic).
+  And it sends these to the processor core for handling.
+  See [1] Chapter 8 for more details.
+
+  Many of the Intel's generic devices like hpet, ioapic, lapic have
+  the ce4100 name in their compatible property names because they
+  first appeared in CE4100 SoC.
+
+  This schema defines bindings for local APIC interrupt controller.
+
+  [1] https://pdos.csail.mit.edu/6.828/2008/readings/ia32/IA32-3A.pdf
+
+properties:
+  compatible:
+    const: intel,ce4100-lapic
+
+  reg:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
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
+    lapic0: interrupt-controller@fee00000 {
+        compatible =3D "intel,ce4100-lapic";
+        reg =3D <0xfee00000 0x1000>;
+        interrupt-controller;
+        #interrupt-cells =3D <2>;
+    };
--=20
2.17.1

