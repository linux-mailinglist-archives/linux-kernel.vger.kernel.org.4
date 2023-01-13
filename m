Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8833266A4A6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjAMU4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjAMU4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:56:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB40589BFC;
        Fri, 13 Jan 2023 12:54:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FD61B82204;
        Fri, 13 Jan 2023 20:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA1AC433EF;
        Fri, 13 Jan 2023 20:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673643295;
        bh=FtiBLTIIxRKrUFuxQPho8qOkR0xS+7biqTJS94FSsf8=;
        h=From:To:Cc:Subject:Date:From;
        b=jahGQN6Ymb35+gI9w+hi+AJvljoA70BwULuRwPyQfFdXdo/XWRlIGkVx6/CVIyvrn
         2C5ewSx1RM/JEOVz1w/PZjB9GuvHYZLvOfGiAGHxKzP6V8cqgdhMEeeOTWBqLv+4LR
         VDUwgChO2o14fEo142GyHu1wyq6ttuIIKwTGessNcDA48toCDIxmOVDZHy0XEoSFQq
         Zh5As4YQNLggnBHhdxzTxWr0K85u/xOBKnEZU/nFBXxnOOrKQhiwTc8UtHo5YObjyO
         eZEdaF+z42bteHOPErz9GXn+PNXpGRWSbUT9jYLXR4OWtqu+X0040hlx/g2uSud7kZ
         4QJl4UhnHfvaQ==
From:   Conor Dooley <conor@kernel.org>
To:     conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        atishp@rivosinc.com
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, apatel@ventanamicro.com,
        will@kernel.org, mark.rutland@arm.com, opensbi@lists.infradead.org,
        samuel@sholland.org, ajones@ventanamicro.com
Subject: [PATCH v5] dt-bindings: riscv: add SBI PMU event mappings
Date:   Fri, 13 Jan 2023 20:54:35 +0000
Message-Id: <20230113205435.122712-1-conor@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The SBI PMU extension requires a firmware to be aware of the event to
counter/mhpmevent mappings supported by the hardware. OpenSBI may use
DeviceTree to describe the PMU mappings. This binding is currently
described in markdown in OpenSBI (since v1.0 in Dec 2021) & used by QEMU
since v7.2.0.

Import the binding for use while validating dtb dumps from QEMU and
upcoming hardware (eg JH7110 SoC) that will make use of the event
mapping.

Link: https://github.com/riscv-software-src/opensbi/blob/master/docs/pmu_support.md
Link: https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc # Performance Monitoring Unit Extension
Co-developed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v5:
- Remove the word hook from top level description & reword some of the
  statements that sound clumsy when removed from the context of OpenSBI.

Changes in v4:
- A bunch of minor description/comment changes suggested by Drew

Changes in v3:
- align descriptions to SBI spec (and fix a misinterpretation of mine)
- switch to a nested items description, since the descriptions are for
  the elements of each entry, not the entries themselves

Changes in v2:
- use the schema mechanism for dependancies between properties
- +CC perf maintainers...
- move the matrix element descriptions into regular item descriptions
  rather than doing so freeform in the property description
- drop some description text that no longer applies since changes were
  made to the SBI spec
- drop mention of the "generic platform" which is OpenSBI specific
- drop the min/max items from the matrices, they don't appear to be
  needed?

OpenSBI is BSD-2-Clause licensed, hence the license here.
---
 .../devicetree/bindings/perf/riscv,pmu.yaml   | 161 ++++++++++++++++++
 1 file changed, 161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/riscv,pmu.yaml

diff --git a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
new file mode 100644
index 000000000000..a55a4d047d3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
@@ -0,0 +1,161 @@
+# SPDX-License-Identifier: BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/riscv,pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V SBI PMU events
+
+maintainers:
+  - Atish Patra <atishp@rivosinc.com>
+
+description: |
+  The SBI PMU extension allows supervisor software to configure, start and
+  stop any performance counter at anytime. Thus, a user can leverage all
+  capabilities of performance analysis tools, such as perf, if the SBI PMU
+  extension is enabled. The following constraints apply:
+
+    The platform must provide information about PMU event to counter mappings
+    either via device tree or another way, specific to the platform.
+    Without the event to counter mappings, the SBI PMU extension cannot be used.
+
+    Platforms should provide information about the PMU event selector values
+    that should be encoded in the expected value of MHPMEVENTx while configuring
+    MHPMCOUNTERx for that specific event. The can either be done via device tree
+    or another way, specific to the platform.
+    The exact value to be written to MHPMEVENTx is completely dependent on the
+    platform.
+
+    For information on the SBI specification see the section "Performance
+    Monitoring Unit Extension" of:
+      https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
+
+properties:
+  compatible:
+    const: riscv,pmu
+
+  riscv,event-to-mhpmevent:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description:
+      Represents an ONE-to-ONE mapping between a PMU event and the event
+      selector value that the platform expects to be written to the MHPMEVENTx
+      CSR for that event.
+      The mapping is encoded in an matrix format where each element represents
+      an event.
+      This property shouldn't encode any raw hardware event.
+    items:
+      items:
+        - description: event_idx, a 20-bit wide encoding of the event type and
+            code. Refer to the SBI specification for a complete description of
+            the event types and codes.
+        - description: upper 32 bits of the event selector value for MHPMEVENTx
+        - description: lower 32 bits of the event selector value for MHPMEVENTx
+
+  riscv,event-to-mhpmcounters:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description:
+      Represents a MANY-to-MANY mapping between a range of events and all the
+      MHPMCOUNTERx in a bitmap format that can be used to monitor these range
+      of events. The information is encoded in an matrix format where each
+      element represents a certain range of events and corresponding counters.
+      This property shouldn't encode any raw event.
+    items:
+      items:
+        - description: first event_idx of the range of events
+        - description: last event_idx of the range of events
+        - description: bitmap of MHPMCOUNTERx for this event
+
+  riscv,raw-event-to-mhpmcounters:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description:
+      Represents an ONE-to-MANY or MANY-to-MANY mapping between the rawevent(s)
+      and all the MHPMCOUNTERx in a bitmap format that can be used to monitor
+      that raw event.
+      The encoding of the raw events are platform specific. The information is
+      encoded in a matrix format where each element represents the specific raw
+      event(s).
+      If a platform directly encodes each raw PMU event as a unique ID, the
+      value of variant must be 0xffffffff_ffffffff.
+    items:
+      items:
+        - description:
+            upper 32 invariant bits for the range of events
+        - description:
+            lower 32 invariant bits for the range of events
+        - description:
+            upper 32 bits of the variant bit mask for the range of events
+        - description:
+            lower 32 bits of the variant bit mask for the range of events
+        - description:
+            bitmap of all MHPMCOUNTERx that can monitor the range of events
+
+dependencies:
+  "riscv,event-to-mhpmevent": [ "riscv,event-to-mhpmcounters" ]
+  "riscv,event-to-mhpmcounters": [ "riscv,event-to-mhpmevent" ]
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    pmu {
+        compatible = "riscv,pmu";
+        riscv,event-to-mhpmevent = <0x0000B 0x0000 0x0001>;
+        riscv,event-to-mhpmcounters = <0x00001 0x00001 0x00000001>,
+                                      <0x00002 0x00002 0x00000004>,
+                                      <0x00003 0x0000A 0x00000ff8>,
+                                      <0x10000 0x10033 0x000ff000>;
+        riscv,raw-event-to-mhpmcounters =
+            /* For event ID 0x0002 */
+            <0x0000 0x0002 0xffffffff 0xffffffff 0x00000f8>,
+            /* For event ID 0-4 */
+            <0x0 0x0 0xffffffff 0xfffffff0 0x00000ff0>,
+            /* For event ID 0xffffffff0000000f - 0xffffffff000000ff */
+            <0xffffffff 0x0 0xffffffff 0xffffff0f 0x00000ff0>;
+    };
+
+  - |
+    /*
+     * For HiFive Unmatched board the encodings can be found here
+     * https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf
+     *
+     * This example also binds standard SBI PMU hardware IDs to U74 PMU event
+     * codes, U74 uses a bitfield for events encoding, so several U74 events
+     * can be bound to a single perf ID.
+     * See SBI PMU hardware IDs in arch/riscv/include/asm/sbi.h
+     */
+    pmu {
+          compatible = "riscv,pmu";
+          riscv,event-to-mhpmevent =
+              /* SBI_PMU_HW_CACHE_REFERENCES -> Instruction or Data cache/ITIM busy */
+              <0x00003 0x00000000 0x1801>,
+              /* SBI_PMU_HW_CACHE_MISSES -> Instruction or Data cache miss or MMIO access */
+              <0x00004 0x00000000 0x0302>,
+              /* SBI_PMU_HW_BRANCH_INSTRUCTIONS -> Conditional branch retired */
+              <0x00005 0x00000000 0x4000>,
+              /* SBI_PMU_HW_BRANCH_MISSES -> Branch or jump misprediction */
+              <0x00006 0x00000000 0x6001>,
+              /* L1D_READ_MISS -> Data cache miss or MMIO access */
+              <0x10001 0x00000000 0x0202>,
+              /* L1D_WRITE_ACCESS -> Data cache write-back */
+              <0x10002 0x00000000 0x0402>,
+              /* L1I_READ_ACCESS -> Instruction cache miss */
+              <0x10009 0x00000000 0x0102>,
+              /* LL_READ_MISS -> UTLB miss */
+              <0x10011 0x00000000 0x2002>,
+              /* DTLB_READ_MISS -> Data TLB miss */
+              <0x10019 0x00000000 0x1002>,
+              /* ITLB_READ_MISS-> Instruction TLB miss */
+              <0x10021 0x00000000 0x0802>;
+          riscv,event-to-mhpmcounters = <0x00003 0x00006 0x18>,
+                                        <0x10001 0x10002 0x18>,
+                                        <0x10009 0x10009 0x18>,
+                                        <0x10011 0x10011 0x18>,
+                                        <0x10019 0x10019 0x18>,
+                                        <0x10021 0x10021 0x18>;
+          riscv,raw-event-to-mhpmcounters = <0x0 0x0 0xffffffff 0xfc0000ff 0x18>,
+                                            <0x0 0x1 0xffffffff 0xfff800ff 0x18>,
+                                            <0x0 0x2 0xffffffff 0xffffe0ff 0x18>;
+    };
-- 
2.39.0

