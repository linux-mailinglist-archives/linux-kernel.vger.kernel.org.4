Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6452F60EC17
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 01:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbiJZXRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 19:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbiJZXRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 19:17:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407D9A3F43;
        Wed, 26 Oct 2022 16:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666826229; x=1698362229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9naEc5Q1KNqWjDLUU/UeXJJ78BMkahd5CfuqhHu+8/k=;
  b=gTw5A6lNHCZpQBPc48jCZ0q2jc0IU5q2f4Wfyt7kYs0850wcyNz/nn6h
   /SasDJPYr+N3KXcIwr50COdwpQMKJEScNiRxDMH+prxu+fCFEixuX3Eec
   4OOkrqINbeRxiDhUywbkWVyLoqMEKRzKLYPxWH50P4zL757lDETmAFisE
   84jiPLA0QTSxb+pZsUMDzp1rKrvcEoTmn8Zsx2y+5pyU+8kbAcRPzCE1h
   90EX9Lp8gvnq21lrxS2LO6+yWbNnxckl/FZZshFMpBlS/H7uhndbRmjGK
   E3wOraUyQ+tHU4kKoVn/SPWVpuwSjesaQKnk55UKrIFGk+bQhyzAPloNP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="306814199"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="306814199"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 16:17:09 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="737446205"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="737446205"
Received: from fordon1x-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.24.177])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 16:17:04 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     linux-mm@kvack.org, seanjc@google.com, pbonzini@redhat.com,
        dave.hansen@intel.com, dan.j.williams@intel.com,
        rafael.j.wysocki@intel.com, kirill.shutemov@linux.intel.com,
        reinette.chatre@intel.com, len.brown@intel.com,
        tony.luck@intel.com, peterz@infradead.org, ak@linux.intel.com,
        isaku.yamahata@intel.com, chao.gao@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, bagasdotme@gmail.com,
        sagis@google.com, imammedo@redhat.com, kai.huang@intel.com
Subject: [PATCH v6 02/21] x86/virt/tdx: Detect TDX during kernel boot
Date:   Thu, 27 Oct 2022 12:16:01 +1300
Message-Id: <f7024d85d0a4b3643f944f53c60f460110cf9993.1666824663.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666824663.git.kai.huang@intel.com>
References: <cover.1666824663.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
host and certain physical attacks.  A CPU-attested software module
called 'the TDX module' runs inside a new isolated memory range as a
trusted hypervisor to manage and run protected VMs.

Pre-TDX Intel hardware has support for a memory encryption architecture
called MKTME.  The memory encryption hardware underpinning MKTME is also
used for Intel TDX.  TDX ends up "stealing" some of the physical address
space from the MKTME architecture for crypto-protection to VMs.  The
BIOS is responsible for partitioning the "KeyID" space between legacy
MKTME and TDX.  The KeyIDs reserved for TDX are called 'TDX private
KeyIDs' or 'TDX KeyIDs' for short.

TDX doesn't trust the BIOS.  During machine boot, TDX verifies the TDX
private KeyIDs are consistently and correctly programmed by the BIOS
across all CPU packages before it enables TDX on any CPU core.  A valid
TDX private KeyID range on BSP indicates TDX has been enabled by the
BIOS, otherwise the BIOS is buggy.

The TDX module is expected to be loaded by the BIOS when it enables TDX,
but the kernel needs to properly initialize it before it can be used to
create and run any TDX guests.  The TDX module will be initialized at
runtime by the user (i.e. KVM) on demand.

Add a new early_initcall(tdx_init) to do TDX early boot initialization.
Only detect TDX private KeyIDs for now.  Some other early checks will
follow up.  Also add a new function to report whether TDX has been
enabled by BIOS (TDX private KeyID range is valid).  Kexec() will also
need it to determine whether need to flush dirty cachelines that are
associated with any TDX private KeyIDs before booting to the new kernel.

To start to support TDX, create a new arch/x86/virt/vmx/tdx/tdx.c for
TDX host kernel support.  Add a new Kconfig option CONFIG_INTEL_TDX_HOST
to opt-in TDX host kernel support (to distinguish with TDX guest kernel
support).  So far only KVM is the only user of TDX.  Make the new config
option depend on KVM_INTEL.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
---

v5 -> v6:
  - Removed SEAMRR detection to make code simpler.
  - Removed the 'default N' in the KVM_TDX_HOST Kconfig (Kirill).
  - Changed to use 'obj-y' in arch/x86/virt/vmx/tdx/Makefile (Kirill).

---
 arch/x86/Kconfig               | 12 +++++
 arch/x86/Makefile              |  2 +
 arch/x86/include/asm/tdx.h     |  7 +++
 arch/x86/virt/Makefile         |  2 +
 arch/x86/virt/vmx/Makefile     |  2 +
 arch/x86/virt/vmx/tdx/Makefile |  2 +
 arch/x86/virt/vmx/tdx/tdx.c    | 95 ++++++++++++++++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h    | 15 ++++++
 8 files changed, 137 insertions(+)
 create mode 100644 arch/x86/virt/Makefile
 create mode 100644 arch/x86/virt/vmx/Makefile
 create mode 100644 arch/x86/virt/vmx/tdx/Makefile
 create mode 100644 arch/x86/virt/vmx/tdx/tdx.c
 create mode 100644 arch/x86/virt/vmx/tdx/tdx.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b52ad13f0f44..b9bd5d994ba7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1955,6 +1955,18 @@ config X86_SGX
 
 	  If unsure, say N.
 
+config INTEL_TDX_HOST
+	bool "Intel Trust Domain Extensions (TDX) host support"
+	depends on CPU_SUP_INTEL
+	depends on X86_64
+	depends on KVM_INTEL
+	help
+	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
+	  host and certain physical attacks.  This option enables necessary TDX
+	  support in host kernel to run protected VMs.
+
+	  If unsure, say N.
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1640e005092b..bba792a26f0e 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -252,6 +252,8 @@ archheaders:
 
 libs-y  += arch/x86/lib/
 
+core-y += arch/x86/virt/
+
 # drivers-y are linked after core-y
 drivers-$(CONFIG_MATH_EMULATION) += arch/x86/math-emu/
 drivers-$(CONFIG_PCI)            += arch/x86/pci/
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 1c166fb9c22f..9b63f33e9c91 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -120,5 +120,12 @@ static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
 	return -ENODEV;
 }
 #endif /* CONFIG_INTEL_TDX_GUEST && CONFIG_KVM_GUEST */
+
+#ifdef CONFIG_INTEL_TDX_HOST
+bool platform_tdx_enabled(void);
+#else	/* !CONFIG_INTEL_TDX_HOST */
+static inline bool platform_tdx_enabled(void) { return false; }
+#endif	/* CONFIG_INTEL_TDX_HOST */
+
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASM_X86_TDX_H */
diff --git a/arch/x86/virt/Makefile b/arch/x86/virt/Makefile
new file mode 100644
index 000000000000..1e36502cd738
--- /dev/null
+++ b/arch/x86/virt/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y	+= vmx/
diff --git a/arch/x86/virt/vmx/Makefile b/arch/x86/virt/vmx/Makefile
new file mode 100644
index 000000000000..feebda21d793
--- /dev/null
+++ b/arch/x86/virt/vmx/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_INTEL_TDX_HOST)	+= tdx/
diff --git a/arch/x86/virt/vmx/tdx/Makefile b/arch/x86/virt/vmx/tdx/Makefile
new file mode 100644
index 000000000000..93ca8b73e1f1
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y += tdx.o
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
new file mode 100644
index 000000000000..982d9c453b6b
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright(c) 2022 Intel Corporation.
+ *
+ * Intel Trusted Domain Extensions (TDX) support
+ */
+
+#define pr_fmt(fmt)	"tdx: " fmt
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/printk.h>
+#include <asm/msr-index.h>
+#include <asm/msr.h>
+#include <asm/tdx.h>
+#include "tdx.h"
+
+static u32 tdx_keyid_start __ro_after_init;
+static u32 tdx_keyid_num __ro_after_init;
+
+/*
+ * Detect TDX private KeyIDs to see whether TDX has been enabled by the
+ * BIOS.  Both initializing the TDX module and running TDX guest require
+ * TDX private KeyID.
+ *
+ * TDX doesn't trust BIOS.  TDX verifies all configurations from BIOS
+ * are correct before enabling TDX on any core.  TDX requires the BIOS
+ * to correctly and consistently program TDX private KeyIDs on all CPU
+ * packages.  Unless there is a BIOS bug, detecting a valid TDX private
+ * KeyID range on BSP indicates TDX has been enabled by the BIOS.  If
+ * there's such BIOS bug, it will be caught later when initializing the
+ * TDX module.
+ */
+static int __init detect_tdx(void)
+{
+	int ret;
+
+	/*
+	 * IA32_MKTME_KEYID_PARTIONING:
+	 *   Bit [31:0]:	Number of MKTME KeyIDs.
+	 *   Bit [63:32]:	Number of TDX private KeyIDs.
+	 */
+	ret = rdmsr_safe(MSR_IA32_MKTME_KEYID_PARTITIONING, &tdx_keyid_start,
+			&tdx_keyid_num);
+	if (ret)
+		return -ENODEV;
+
+	if (!tdx_keyid_num)
+		return -ENODEV;
+
+	/*
+	 * KeyID 0 is for TME.  MKTME KeyIDs start from 1.  TDX private
+	 * KeyIDs start after the last MKTME KeyID.
+	 */
+	tdx_keyid_start++;
+
+	pr_info("TDX enabled by BIOS. TDX private KeyID range: [%u, %u)\n",
+			tdx_keyid_start, tdx_keyid_start + tdx_keyid_num);
+
+	return 0;
+}
+
+static void __init clear_tdx(void)
+{
+	tdx_keyid_start = tdx_keyid_num = 0;
+}
+
+static int __init tdx_init(void)
+{
+	if (detect_tdx())
+		return -ENODEV;
+
+	/*
+	 * Initializing the TDX module requires one TDX private KeyID.
+	 * If there's only one TDX KeyID then after module initialization
+	 * KVM won't be able to run any TDX guest, which makes the whole
+	 * thing worthless.  Just disable TDX in this case.
+	 */
+	if (tdx_keyid_num < 2) {
+		pr_info("Disable TDX as there's only one TDX private KeyID available.\n");
+		goto no_tdx;
+	}
+
+	return 0;
+no_tdx:
+	clear_tdx();
+	return -ENODEV;
+}
+early_initcall(tdx_init);
+
+/* Return whether the BIOS has enabled TDX */
+bool platform_tdx_enabled(void)
+{
+	return !!tdx_keyid_num;
+}
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
new file mode 100644
index 000000000000..d00074abcb20
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _X86_VIRT_TDX_H
+#define _X86_VIRT_TDX_H
+
+/*
+ * This file contains both macros and data structures defined by the TDX
+ * architecture and Linux defined software data structures and functions.
+ * The two should not be mixed together for better readability.  The
+ * architectural definitions come first.
+ */
+
+/* MSR to report KeyID partitioning between MKTME and TDX */
+#define MSR_IA32_MKTME_KEYID_PARTITIONING	0x00000087
+
+#endif
-- 
2.37.3

