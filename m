Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D54C60D537
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiJYUFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiJYUFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:05:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E264D4EC;
        Tue, 25 Oct 2022 13:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666728316; x=1698264316;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f3Jh3AVXGV6VuJD1/X7liT3ATYe2I+2m+J6yWYsvcn0=;
  b=SjINtVU/JseLrX1ZEwdSIvx1scV/5Qyn3WKMsRJ1+1V59SyrA29FvGgE
   MVfRE9BVL9s/U0dQ9vT3lMPuGHB5+WpS/zAOPdTZdUQmxHvcYMb0hPdvH
   veP+6kWuGXltWXEFgnWJsR36BZ14FClVzj+QgykxA21QnKymBnnOwKg5w
   raWBr2jzKhJCVTDBVrrgbgizLg2yDpFZ2yR34JiJ1kZ9lZJCAJRJFU6C8
   3OH6Ym/KYUWcJr2vCAfVJgWdXWbzPSAj8ybGMcKDp2KhD16EHGBnqix7C
   XPRJRAn4dfyHvqc/DSycqg6PArxwOXVWuAUfQQKtIFqxZ5zpn+Rmlee5k
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="306508871"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="306508871"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 13:05:14 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="960948375"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="960948375"
Received: from shines-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.106.233])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 13:05:13 -0700
Subject: [PATCH v4] memregion: Add cpu_cache_invalidate_memregion() interface
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Tue, 25 Oct 2022 13:05:12 -0700
Message-ID: <166672803035.2801111.9244172033971411169.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

With CXL security features, global CPU cache flushing nvdimm requirements
are no longer specific to that subsystem, even beyond the scope of
security_ops. CXL will need such semantics for features not necessarily
limited to persistent memory.

The functionality this is enabling is to be able to instantaneously
secure erase potentially terabytes of memory at once and the kernel
needs to be sure that none of the data from before the erase is still
present in the cache. It is also used when unlocking a memory device
where speculative reads and firmware accesses could have cached poison
from before the device was unlocked. Lastly this facility is used when
mapping new devices, or new capacity into an established physical
address range. I.e. when the driver switches DeviceA mapping AddressX to
DeviceB mapping AddressX then any cached data from DeviceA:AddressX
needs to be invalidated.

This capability is typically only used once per-boot (for unlock), or
once per bare metal provisioning event (secure erase), like when handing
off the system to another tenant or decommissioning a device. It may
also be used for dynamic CXL region provisioning.

Users must first call cpu_cache_has_invalidate_memregion() to know whether
this functionality is available on the architecture. Only enable it on
x86-64 via the wbinvd() hammer. Hypervisors are not supported as TDX
guests may trigger a virtualization exception and may need proper handling
to recover. See:

   e2efb6359e62 ("ACPICA: Avoid cache flush inside virtual machines")

This global cache invalidation facility,
cpu_cache_invalidate_memregion(), is exported to modules since NVDIMM
and CXL support can be built as a module. However, the intent is that
this facility is not available outside of specific "device-memory" use
cases. To that end the API is scoped to a new "DEVMEM" module namespace
that only applies to the NVDIMM and CXL subsystems.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v3: https://lore.kernel.org/r/20220919110605.3696-1-dave@stgolabs.net
- Add more details about the use of this facility in the memory
  provisioning flow in the changelog
- Introduce the DEVMEM symbol namespace to indicate that this facility is not
  for general consumption (Dave H)
- Update the kernel-doc for cpu_cache_invalidate_memregion() to clarify
  that it is not to be used outside of the CXL and NVDIMM subsystems (Dave H)

 arch/x86/Kconfig             |    1 +
 arch/x86/mm/pat/set_memory.c |   15 +++++++++++++++
 drivers/acpi/nfit/intel.c    |   43 ++++++++++++++++++++----------------------
 include/linux/memregion.h    |   37 ++++++++++++++++++++++++++++++++++++
 lib/Kconfig                  |    3 +++
 5 files changed, 76 insertions(+), 23 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 67745ceab0db..b68661d0633b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -69,6 +69,7 @@ config X86
 	select ARCH_ENABLE_THP_MIGRATION if X86_64 && TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_CACHE_LINE_SIZE
+	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION  if X86_64
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 97342c42dda8..8650bb6481a8 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -330,6 +330,21 @@ void arch_invalidate_pmem(void *addr, size_t size)
 EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
 #endif
 
+#ifdef CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
+bool cpu_cache_has_invalidate_memregion(void)
+{
+	return !cpu_feature_enabled(X86_FEATURE_HYPERVISOR);
+}
+EXPORT_SYMBOL_NS_GPL(cpu_cache_has_invalidate_memregion, DEVMEM);
+
+int cpu_cache_invalidate_memregion(int res_desc)
+{
+	wbinvd_on_all_cpus();
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cpu_cache_invalidate_memregion, DEVMEM);
+#endif
+
 static void __cpa_flush_all(void *arg)
 {
 	unsigned long cache = (unsigned long)arg;
diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
index 8dd792a55730..fa0e57e35162 100644
--- a/drivers/acpi/nfit/intel.c
+++ b/drivers/acpi/nfit/intel.c
@@ -3,6 +3,7 @@
 #include <linux/libnvdimm.h>
 #include <linux/ndctl.h>
 #include <linux/acpi.h>
+#include <linux/memregion.h>
 #include <asm/smp.h>
 #include "intel.h"
 #include "nfit.h"
@@ -190,8 +191,6 @@ static int intel_security_change_key(struct nvdimm *nvdimm,
 	}
 }
 
-static void nvdimm_invalidate_cache(void);
-
 static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
 		const struct nvdimm_key_data *key_data)
 {
@@ -213,6 +212,9 @@ static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
 	if (!test_bit(NVDIMM_INTEL_UNLOCK_UNIT, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
+	if (!cpu_cache_has_invalidate_memregion())
+		return -EINVAL;
+
 	memcpy(nd_cmd.cmd.passphrase, key_data->data,
 			sizeof(nd_cmd.cmd.passphrase));
 	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
@@ -228,7 +230,7 @@ static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
 	}
 
 	/* DIMM unlocked, invalidate all CPU caches before we read it */
-	nvdimm_invalidate_cache();
+	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
 
 	return 0;
 }
@@ -297,8 +299,11 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
 	if (!test_bit(cmd, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
+	if (!cpu_cache_has_invalidate_memregion())
+		return -EINVAL;
+
 	/* flush all cache before we erase DIMM */
-	nvdimm_invalidate_cache();
+	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
 	memcpy(nd_cmd.cmd.passphrase, key->data,
 			sizeof(nd_cmd.cmd.passphrase));
 	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
@@ -318,7 +323,7 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
 	}
 
 	/* DIMM erased, invalidate all CPU caches before we read it */
-	nvdimm_invalidate_cache();
+	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
 	return 0;
 }
 
@@ -341,6 +346,9 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
 	if (!test_bit(NVDIMM_INTEL_QUERY_OVERWRITE, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
+	if (!cpu_cache_has_invalidate_memregion())
+		return -EINVAL;
+
 	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
 	if (rc < 0)
 		return rc;
@@ -355,7 +363,7 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
 	}
 
 	/* flush all cache before we make the nvdimms available */
-	nvdimm_invalidate_cache();
+	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
 	return 0;
 }
 
@@ -380,8 +388,11 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
 	if (!test_bit(NVDIMM_INTEL_OVERWRITE, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
+	if (!cpu_cache_has_invalidate_memregion())
+		return -EINVAL;
+
 	/* flush all cache before we erase DIMM */
-	nvdimm_invalidate_cache();
+	cpu_cache_invalidate_memregion(IORES_DESC_PERSISTENT_MEMORY);
 	memcpy(nd_cmd.cmd.passphrase, nkey->data,
 			sizeof(nd_cmd.cmd.passphrase));
 	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
@@ -401,22 +412,6 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
 	}
 }
 
-/*
- * TODO: define a cross arch wbinvd equivalent when/if
- * NVDIMM_FAMILY_INTEL command support arrives on another arch.
- */
-#ifdef CONFIG_X86
-static void nvdimm_invalidate_cache(void)
-{
-	wbinvd_on_all_cpus();
-}
-#else
-static void nvdimm_invalidate_cache(void)
-{
-	WARN_ON_ONCE("cache invalidation required after unlock\n");
-}
-#endif
-
 static const struct nvdimm_security_ops __intel_security_ops = {
 	.get_flags = intel_security_flags,
 	.freeze = intel_security_freeze,
@@ -775,3 +770,5 @@ static const struct nvdimm_fw_ops __intel_fw_ops = {
 };
 
 const struct nvdimm_fw_ops *intel_fw_ops = &__intel_fw_ops;
+
+MODULE_IMPORT_NS(DEVMEM);
diff --git a/include/linux/memregion.h b/include/linux/memregion.h
index c04c4fd2e209..6667af64840d 100644
--- a/include/linux/memregion.h
+++ b/include/linux/memregion.h
@@ -20,4 +20,41 @@ static inline void memregion_free(int id)
 {
 }
 #endif
+
+/**
+ * cpu_cache_invalidate_memregion - drop any CPU cached data for
+ *     memregions described by @res_desc
+ * @res_desc: one of the IORES_DESC_* types
+ *
+ * Perform cache maintenance after a memory event / operation that
+ * changes the contents of physical memory in a cache-incoherent manner.
+ * For example, device memory technologies like NVDIMM and CXL have
+ * device secure erase, or dynamic region provision features where such
+ * semantics.
+ *
+ * Limit the functionality to architectures that have an efficient way
+ * to writeback and invalidate potentially terabytes of memory at once.
+ * Note that this routine may or may not write back any dirty contents
+ * while performing the invalidation. It is only exported for the
+ * explicit usage of the NVDIMM and CXL modules in the 'DEVMEM' symbol
+ * namespace.
+ *
+ * Returns 0 on success or negative error code on a failure to perform
+ * the cache maintenance.
+ */
+#ifdef CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
+int cpu_cache_invalidate_memregion(int res_desc);
+bool cpu_cache_has_invalidate_memregion(void);
+#else
+static inline bool cpu_cache_has_invalidate_memregion(void)
+{
+	return false;
+}
+
+int cpu_cache_invalidate_memregion(int res_desc)
+{
+	WARN_ON_ONCE("CPU cache invalidation required");
+	return -EINVAL;
+}
+#endif
 #endif /* _MEMREGION_H_ */
diff --git a/lib/Kconfig b/lib/Kconfig
index 9bbf8a4b2108..9eb514abcdec 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -672,6 +672,9 @@ config ARCH_HAS_PMEM_API
 config MEMREGION
 	bool
 
+config ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
+	bool
+
 config ARCH_HAS_MEMREMAP_COMPAT_ALIGN
 	bool
 

