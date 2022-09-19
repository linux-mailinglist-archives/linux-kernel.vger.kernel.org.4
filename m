Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30C05BCAA7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiISL0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiISLZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:25:58 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935321C923;
        Mon, 19 Sep 2022 04:25:56 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 797081236BD;
        Mon, 19 Sep 2022 11:25:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a263 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B568E123220;
        Mon, 19 Sep 2022 11:25:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1663586754; a=rsa-sha256;
        cv=none;
        b=8HQK08uw8EUbz+K+TnRg9fP57KzbZtyCMGDt9BLYASen1sOJVGhJEONE8vNFISF+zCvoxb
        XaUbDFMGpDf683K0sEQ9wW6lMaqEa9bb0ScrnJM5YyayTKMP27AJ5NHpfPztjc3+13vvsC
        zSTGDokLCgpSnoENp6/7ewSBsaCX2kDvAzFV3VXIptO7y7j7azGouFHdLkY0+Ro4+hwMiZ
        yobUsk0hEwAIzUj9rc5FwZb9umVWeEHM8v8+4VOEkG+eoAajLvmJCUqAiiaFj0EgArJMvS
        DWEB670Z5CLH9Ttl2Lur49c+j5LZRMvShOH9xt2hrNWf4v3HPR8amZb37JA8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1663586754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=gg9aOCDP6c4mrsDjdaPERES3849dYDvvYWHpCqCjES0=;
        b=ssphTPaw4Q4pzWGkcGmJwmWl9Vyx9WmWiV1F3U9lf+FCp6INXQ0CXKGS7GCWdz0Ih+JbkT
        i98DvAh+lA5Y7It36FTXRCDLSU8f+mW/cVnkGobNk39D+g0m69tPapKIeW1l1JOtsuG3T6
        k2ki3gqibd4OqCmONe1+pnusIdl0OJBw9S7EJtpVJaqiT5Rb21kCs29tn3jxas8NuY/Z5u
        vMtD8OR1BEm6L4yqhu4pCwEhh4SIyRanOfAmumnP8bHNCB0PJTJDxQq1arCzWPFqKVrl9Q
        ubiz7eihKqARF6FSAAHytrqzR97tPRNT2yEn8vWczvNJ6Uq3hLrU9A2b0K7PFg==
ARC-Authentication-Results: i=1;
        rspamd-686945db84-m9jbc;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abaft-Zesty: 2ba7123e103cbe5c_1663586755151_102532906
X-MC-Loop-Signature: 1663586755151:944648257
X-MC-Ingress-Time: 1663586755151
Received: from pdx1-sub0-mail-a263 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.125.73 (trex/6.7.1);
        Mon, 19 Sep 2022 11:25:55 +0000
Received: from localhost.localdomain (unknown [83.137.2.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a263 (Postfix) with ESMTPSA id 4MWMmq67xlzMS;
        Mon, 19 Sep 2022 04:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1663586754;
        bh=gg9aOCDP6c4mrsDjdaPERES3849dYDvvYWHpCqCjES0=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=hnRfKmySTj74GdxiGVQdWOiPxRqhue/Yhi+h/mXCk8dE56pmUR+snmuyX6Hpwy58i
         ExunNJKntrce6xIxMsjU3wyCd9x+IJUwq5wsge3MFrhn67i2/ik98X2NSooJpYWnxA
         pjAfhZ2eCDN+VFelLRZf2m6qGyd0HLVhaG2t7OkDV61SmixzJQYXe3RxaCL2zZtMSf
         Uqqu0AilQMj3/1wfxLLrzHVGCkji0GVinLmic+ETFWQutD+d+fbwtfotUebKcRGSal
         fOoMgofdgyYTaldCKfiGPV60yl3qZn4n5nta+u7Z0il0I3sJymIsMmaPehYsDx9XaL
         d8zvri4QGnE5g==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     peterz@infradead.org, bp@alien8.de, akpm@linux-foundation.org,
        hch@lst.de, dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        a.manzanares@samsung.com, x86@kernel.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH v3 -next] memregion: Add cpu_cache_invalidate_memregion() interface
Date:   Mon, 19 Sep 2022 04:06:05 -0700
Message-Id: <20220919110605.3696-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CXL security features, global CPU cache flushing nvdimm requirements
are no longer specific to that subsystem, even beyond the scope of
security_ops. CXL will need such semantics for features not necessarily
limited to persistent memory.

The functionality this is enabling is to be able to instantaneously
secure erase potentially terabytes of memory at once and the kernel
needs to be sure that none of the data from before the erase is still
present in the cache. It is also used when unlocking a memory device
where speculative reads and firmware accesses could have cached poison
from before the device was unlocked.

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

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Changes from v2 (https://lore.kernel.org/all/20220829212918.4039240-1-dave@stgolabs.net/):
- Change the names and params (Dan).
- GPL symbols (Boris).
- Mentioned VMM check in the changelog (Boris).


 arch/x86/Kconfig             |  1 +
 arch/x86/mm/pat/set_memory.c | 15 +++++++++++++
 drivers/acpi/nfit/intel.c    | 41 ++++++++++++++++--------------------
 include/linux/memregion.h    | 35 ++++++++++++++++++++++++++++++
 lib/Kconfig                  |  3 +++
 5 files changed, 72 insertions(+), 23 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2e8f6fd28e59..fa5cc581315a 100644
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
index 0656db33574d..7d940ae2fede 100644
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
+EXPORT_SYMBOL_GPL(cpu_cache_has_invalidate_memregion);
+
+int cpu_cache_invalidate_memregion(int res_desc)
+{
+	wbinvd_on_all_cpus();
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpu_cache_invalidate_memregion);
+#endif
+
 static void __cpa_flush_all(void *arg)
 {
 	unsigned long cache = (unsigned long)arg;
diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
index 8dd792a55730..b2bfbf5797da 100644
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
diff --git a/include/linux/memregion.h b/include/linux/memregion.h
index e11595256cac..d3fafb6873b5 100644
--- a/include/linux/memregion.h
+++ b/include/linux/memregion.h
@@ -20,4 +20,39 @@ void memregion_free(int id)
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
+ * while performing the invalidation.
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
index 087e06b4cdfd..757ae7fff93d 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -652,6 +652,9 @@ config ARCH_HAS_PMEM_API
 config MEMREGION
 	bool
 
+config ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
+	bool
+
 config ARCH_HAS_MEMREMAP_COMPAT_ALIGN
 	bool
 
-- 
2.37.0

