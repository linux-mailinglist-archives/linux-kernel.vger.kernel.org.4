Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7146AA115
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 22:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjCCVY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 16:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjCCVYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 16:24:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D9E168AD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 13:24:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACD1D618F3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 21:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B929BC433EF;
        Fri,  3 Mar 2023 21:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677878662;
        bh=aTd5q13k2EFGgwcu4FNuxPS5KUcHhTjNs9xKvrYeZeM=;
        h=Date:From:To:Cc:Subject:From;
        b=mnBWwGmH0v5hdNVCzcx/VJ5iyv8MO9zGjZO8ECfrwR11atY9fqLuYDJqOBQzI3Tvd
         IXoruTbJvLRYOVyKfRDqkIzGAa4xXbnrj+0P3xXwHjENWL3Ktvw7v1qmsDWYQ2P/SK
         ex9gv4a9/RngBfd/WXUJTHrOagJTrzdCN7Kk2zs75r8ATRc1655GDR/3mDu7DWTMG3
         hbmIL5Vis4pwXPDjIeQz6krNr04l7kKRCv9tkFb80/9z7lDOBGhJUwS2EgW1g1cw34
         WGROpmpDEYys1U0epUOYzg5ZFgI68FWwArt32d/zJB55EfF/Yyrj3CC1vwVEJq9piE
         L47ajlkpKaqwA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 154BC4049F; Fri,  3 Mar 2023 18:24:19 -0300 (-03)
Date:   Fri, 3 Mar 2023 18:24:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Aaron Lewis <aaronlewis@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Ian Rogers <irogers@google.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kees Kook <keescook@chromium.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Sean Christopherson <seanjc@google.com>,
        withthekernelsources@ghostprotocols.net
Subject: [PATCH 1/1 fyi] tools headers kvm: Sync uapi/{asm/linux} kvm.h
 headers
Message-ID: <ZAJlg7/fWDVGX0F3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick up the changes in:

  89b0e7de3451a17f ("KVM: arm64: nv: Introduce nested virtualization VCPU feature")
  14329b825ffb7f27 ("KVM: x86/pmu: Introduce masked events to the pmu event filter")
  6213b701a9df0472 ("KVM: x86: Replace 0-length arrays with flexible arrays")
  3fd49805d19d1c56 ("KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg")
  14329b825ffb7f27 ("KVM: x86/pmu: Introduce masked events to the pmu event filter")

That don't change functionality in tools/perf, as no new ioctl is added
for the 'perf trace' scripts to harvest.

This addresses these perf build warnings:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
  Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs from latest version at 'arch/x86/include/uapi/asm/kvm.h'
  diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
  Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
  diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h

Cc: Aaron Lewis <aaronlewis@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kees Kook <keescook@chromium.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/uapi/asm/kvm.h |  1 +
 tools/arch/x86/include/uapi/asm/kvm.h   | 34 +++++++++++++++++++++++--
 tools/include/uapi/linux/kvm.h          |  9 +++++++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index a7a857f1784d80d6..f8129c624b070981 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -109,6 +109,7 @@ struct kvm_regs {
 #define KVM_ARM_VCPU_SVE		4 /* enable SVE for this CPU */
 #define KVM_ARM_VCPU_PTRAUTH_ADDRESS	5 /* VCPU uses address authentication */
 #define KVM_ARM_VCPU_PTRAUTH_GENERIC	6 /* VCPU uses generic authentication */
+#define KVM_ARM_VCPU_HAS_EL2		7 /* Support nested virtualization */
 
 struct kvm_vcpu_init {
 	__u32 target;
diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index e48deab8901d4ecb..7f467fe05d42ea70 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -9,6 +9,7 @@
 
 #include <linux/types.h>
 #include <linux/ioctl.h>
+#include <linux/stddef.h>
 
 #define KVM_PIO_PAGE_OFFSET 1
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 2
@@ -507,8 +508,8 @@ struct kvm_nested_state {
 	 * KVM_{GET,PUT}_NESTED_STATE ioctl values.
 	 */
 	union {
-		struct kvm_vmx_nested_state_data vmx[0];
-		struct kvm_svm_nested_state_data svm[0];
+		__DECLARE_FLEX_ARRAY(struct kvm_vmx_nested_state_data, vmx);
+		__DECLARE_FLEX_ARRAY(struct kvm_svm_nested_state_data, svm);
 	} data;
 };
 
@@ -525,6 +526,35 @@ struct kvm_pmu_event_filter {
 #define KVM_PMU_EVENT_ALLOW 0
 #define KVM_PMU_EVENT_DENY 1
 
+#define KVM_PMU_EVENT_FLAG_MASKED_EVENTS BIT(0)
+#define KVM_PMU_EVENT_FLAGS_VALID_MASK (KVM_PMU_EVENT_FLAG_MASKED_EVENTS)
+
+/*
+ * Masked event layout.
+ * Bits   Description
+ * ----   -----------
+ * 7:0    event select (low bits)
+ * 15:8   umask match
+ * 31:16  unused
+ * 35:32  event select (high bits)
+ * 36:54  unused
+ * 55     exclude bit
+ * 63:56  umask mask
+ */
+
+#define KVM_PMU_ENCODE_MASKED_ENTRY(event_select, mask, match, exclude) \
+	(((event_select) & 0xFFULL) | (((event_select) & 0XF00ULL) << 24) | \
+	(((mask) & 0xFFULL) << 56) | \
+	(((match) & 0xFFULL) << 8) | \
+	((__u64)(!!(exclude)) << 55))
+
+#define KVM_PMU_MASKED_ENTRY_EVENT_SELECT \
+	(GENMASK_ULL(7, 0) | GENMASK_ULL(35, 32))
+#define KVM_PMU_MASKED_ENTRY_UMASK_MASK		(GENMASK_ULL(63, 56))
+#define KVM_PMU_MASKED_ENTRY_UMASK_MATCH	(GENMASK_ULL(15, 8))
+#define KVM_PMU_MASKED_ENTRY_EXCLUDE		(BIT_ULL(55))
+#define KVM_PMU_MASKED_ENTRY_UMASK_MASK_SHIFT	(56)
+
 /* for KVM_{GET,SET,HAS}_DEVICE_ATTR */
 #define KVM_VCPU_TSC_CTRL 0 /* control group for the timestamp counter (TSC) */
 #define   KVM_VCPU_TSC_OFFSET 0 /* attribute for the TSC offset */
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 55155e262646e5fc..d77aef872a0a07e7 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -583,6 +583,8 @@ struct kvm_s390_mem_op {
 		struct {
 			__u8 ar;	/* the access register number */
 			__u8 key;	/* access key, ignored if flag unset */
+			__u8 pad1[6];	/* ignored */
+			__u64 old_addr;	/* ignored if cmpxchg flag unset */
 		};
 		__u32 sida_offset; /* offset into the sida */
 		__u8 reserved[32]; /* ignored */
@@ -595,11 +597,17 @@ struct kvm_s390_mem_op {
 #define KVM_S390_MEMOP_SIDA_WRITE	3
 #define KVM_S390_MEMOP_ABSOLUTE_READ	4
 #define KVM_S390_MEMOP_ABSOLUTE_WRITE	5
+#define KVM_S390_MEMOP_ABSOLUTE_CMPXCHG	6
+
 /* flags for kvm_s390_mem_op->flags */
 #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
 #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
 #define KVM_S390_MEMOP_F_SKEY_PROTECTION	(1ULL << 2)
 
+/* flags specifying extension support via KVM_CAP_S390_MEM_OP_EXTENSION */
+#define KVM_S390_MEMOP_EXTENSION_CAP_BASE	(1 << 0)
+#define KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG	(1 << 1)
+
 /* for KVM_INTERRUPT */
 struct kvm_interrupt {
 	/* in */
@@ -1175,6 +1183,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_DIRTY_LOG_RING_ACQ_REL 223
 #define KVM_CAP_S390_PROTECTED_ASYNC_DISABLE 224
 #define KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP 225
+#define KVM_CAP_PMU_EVENT_MASKED_EVENTS 226
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.39.2

