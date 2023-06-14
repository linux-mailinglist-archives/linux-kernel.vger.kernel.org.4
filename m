Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898E77217BD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 16:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjFDOar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 10:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjFDOae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 10:30:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F76DA;
        Sun,  4 Jun 2023 07:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685889031; x=1717425031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IRF0IxWtj2hY7KCOuUrS4zKsXIldIBcUH6GCih80GWk=;
  b=EVGtn0ImRGAS9WQB3eJ68LQumAvWyyEHRyiS4nvegneScbkldsj+7bK0
   yXNYrRvecRm7utuP9rkZVWxyt4srVbyHmknIIKLg7cHe9wSLeaGRJ2lsI
   1Wf3DpSM779SkREKEkHO9hPS4R73AosgEfhHsDPLLywRxtP4YK+VS71J3
   pxIxSYRiueX9MdE7LEgA/hIF+r7tFAgDXXlO7IH+QOspQshlbogLygiya
   PU9Ey+Na2d9f/hHXdxmvZjSxTAs+yLrG7P0NlEV3r7+JfISvPN2lWgZYA
   93vRKqx8cUzOFNzxYG3EIlNtotWXxnXy0Hod0Bqs5TXNCTIuN4mU/sPnJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="353683560"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="353683560"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 07:28:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="1038501110"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="1038501110"
Received: from tdhastx-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.50.31])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 07:28:37 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     linux-mm@kvack.org, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com, tony.luck@intel.com,
        peterz@infradead.org, tglx@linutronix.de, seanjc@google.com,
        pbonzini@redhat.com, david@redhat.com, dan.j.williams@intel.com,
        rafael.j.wysocki@intel.com, ying.huang@intel.com,
        reinette.chatre@intel.com, len.brown@intel.com, ak@linux.intel.com,
        isaku.yamahata@intel.com, chao.gao@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, bagasdotme@gmail.com,
        sagis@google.com, imammedo@redhat.com, kai.huang@intel.com
Subject: [PATCH v11 09/20] x86/virt/tdx: Use all system memory when initializing TDX module as TDX memory
Date:   Mon,  5 Jun 2023 02:27:22 +1200
Message-Id: <468533166590ff5ed11730350c4af8cdb0b99165.1685887183.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685887183.git.kai.huang@intel.com>
References: <cover.1685887183.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a step of initializing the TDX module, the kernel needs to tell the
TDX module which memory regions can be used by the TDX module as TDX
guest memory.

TDX reports a list of "Convertible Memory Region" (CMR) to tell the
kernel which memory is TDX compatible.  The kernel needs to build a list
of memory regions (out of CMRs) as "TDX-usable" memory and pass them to
the TDX module.  Once this is done, those "TDX-usable" memory regions
are fixed during module's lifetime.

To keep things simple, assume that all TDX-protected memory will come
from the page allocator.  Make sure all pages in the page allocator
*are* TDX-usable memory.

As TDX-usable memory is a fixed configuration, take a snapshot of the
memory configuration from memblocks at the time of module initialization
(memblocks are modified on memory hotplug).  This snapshot is used to
enable TDX support for *this* memory configuration only.  Use a memory
hotplug notifier to ensure that no other RAM can be added outside of
this configuration.

This approach requires all memblock memory regions at the time of module
initialization to be TDX convertible memory to work, otherwise module
initialization will fail in a later SEAMCALL when passing those regions
to the module.  This approach works when all boot-time "system RAM" is
TDX convertible memory, and no non-TDX-convertible memory is hot-added
to the core-mm before module initialization.

For instance, on the first generation of TDX machines, both CXL memory
and NVDIMM are not TDX convertible memory.  Using kmem driver to hot-add
any CXL memory or NVDIMM to the core-mm before module initialization
will result in failure to initialize the module.  The SEAMCALL error
code will be available in the dmesg to help user to understand the
failure.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
---

v10 -> v11:
 - Added Isaku's Reviewed-by.

v9 -> v10:
 - Moved empty @tdx_memlist check out of is_tdx_memory() to make the
   logic better.
 - Added Ying's Reviewed-by.

v8 -> v9:
 - Replace "The initial support ..." with timeless sentence in both
   changelog and comments(Dave).
 - Fix run-on sentence in changelog, and senstence to explain why to
   stash off memblock (Dave).
 - Tried to improve why to choose this approach and how it work in
   changelog based on Dave's suggestion.
 - Many other comments enhancement (Dave).

v7 -> v8:
 - Trimed down changelog (Dave).
 - Changed to use PHYS_PFN() and PFN_PHYS() throughout this series
   (Ying).
 - Moved memory hotplug handling from add_arch_memory() to
   memory_notifier (Dan/David).
 - Removed 'nid' from 'struct tdx_memblock' to later patch (Dave).
 - {build|free}_tdx_memory() -> {build|}free_tdx_memlist() (Dave).
 - Removed pfn_covered_by_cmr() check as no code to trim CMRs now.
 - Improve the comment around first 1MB (Dave).
 - Added a comment around reserve_real_mode() to point out TDX code
   relies on first 1MB being reserved (Ying).
 - Added comment to explain why the new online memory range cannot
   cross multiple TDX memory blocks (Dave).
 - Improved other comments (Dave).


---
 arch/x86/Kconfig            |   1 +
 arch/x86/kernel/setup.c     |   2 +
 arch/x86/virt/vmx/tdx/tdx.c | 165 +++++++++++++++++++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.h |   6 ++
 4 files changed, 172 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f0f3f1a2c8e0..2226d8a4c749 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1958,6 +1958,7 @@ config INTEL_TDX_HOST
 	depends on X86_64
 	depends on KVM_INTEL
 	depends on X86_X2APIC
+	select ARCH_KEEP_MEMBLOCK
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
 	  host and certain physical attacks.  This option enables necessary TDX
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 16babff771bd..fd94f8186b9c 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1159,6 +1159,8 @@ void __init setup_arch(char **cmdline_p)
 	 *
 	 * Moreover, on machines with SandyBridge graphics or in setups that use
 	 * crashkernel the entire 1M is reserved anyway.
+	 *
+	 * Note the host kernel TDX also requires the first 1MB being reserved.
 	 */
 	x86_platform.realmode_reserve();
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 9fde0f71dd8b..1504023f7f63 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -17,6 +17,13 @@
 #include <linux/spinlock.h>
 #include <linux/percpu-defs.h>
 #include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/memblock.h>
+#include <linux/memory.h>
+#include <linux/minmax.h>
+#include <linux/sizes.h>
+#include <linux/pfn.h>
 #include <asm/msr-index.h>
 #include <asm/msr.h>
 #include <asm/archrandom.h>
@@ -40,6 +47,9 @@ static DEFINE_PER_CPU(unsigned int, tdx_lp_init_status);
 static enum tdx_module_status_t tdx_module_status;
 static DEFINE_MUTEX(tdx_module_lock);
 
+/* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
+static LIST_HEAD(tdx_memlist);
+
 /*
  * Wrapper of __seamcall() to convert SEAMCALL leaf function error code
  * to kernel error code.  @seamcall_ret and @out contain the SEAMCALL
@@ -246,6 +256,79 @@ static int tdx_get_sysinfo(struct tdsysinfo_struct *sysinfo,
 	return 0;
 }
 
+/*
+ * Add a memory region as a TDX memory block.  The caller must make sure
+ * all memory regions are added in address ascending order and don't
+ * overlap.
+ */
+static int add_tdx_memblock(struct list_head *tmb_list, unsigned long start_pfn,
+			    unsigned long end_pfn)
+{
+	struct tdx_memblock *tmb;
+
+	tmb = kmalloc(sizeof(*tmb), GFP_KERNEL);
+	if (!tmb)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&tmb->list);
+	tmb->start_pfn = start_pfn;
+	tmb->end_pfn = end_pfn;
+
+	/* @tmb_list is protected by mem_hotplug_lock */
+	list_add_tail(&tmb->list, tmb_list);
+	return 0;
+}
+
+static void free_tdx_memlist(struct list_head *tmb_list)
+{
+	/* @tmb_list is protected by mem_hotplug_lock */
+	while (!list_empty(tmb_list)) {
+		struct tdx_memblock *tmb = list_first_entry(tmb_list,
+				struct tdx_memblock, list);
+
+		list_del(&tmb->list);
+		kfree(tmb);
+	}
+}
+
+/*
+ * Ensure that all memblock memory regions are convertible to TDX
+ * memory.  Once this has been established, stash the memblock
+ * ranges off in a secondary structure because memblock is modified
+ * in memory hotplug while TDX memory regions are fixed.
+ */
+static int build_tdx_memlist(struct list_head *tmb_list)
+{
+	unsigned long start_pfn, end_pfn;
+	int i, ret;
+
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL) {
+		/*
+		 * The first 1MB is not reported as TDX convertible memory.
+		 * Although the first 1MB is always reserved and won't end up
+		 * to the page allocator, it is still in memblock's memory
+		 * regions.  Skip them manually to exclude them as TDX memory.
+		 */
+		start_pfn = max(start_pfn, PHYS_PFN(SZ_1M));
+		if (start_pfn >= end_pfn)
+			continue;
+
+		/*
+		 * Add the memory regions as TDX memory.  The regions in
+		 * memblock has already guaranteed they are in address
+		 * ascending order and don't overlap.
+		 */
+		ret = add_tdx_memblock(tmb_list, start_pfn, end_pfn);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+err:
+	free_tdx_memlist(tmb_list);
+	return ret;
+}
+
 static int init_tdx_module(void)
 {
 	static DECLARE_PADDED_STRUCT(tdsysinfo_struct, tdsysinfo,
@@ -259,10 +342,25 @@ static int init_tdx_module(void)
 	if (ret)
 		return ret;
 
+	/*
+	 * To keep things simple, assume that all TDX-protected memory
+	 * will come from the page allocator.  Make sure all pages in the
+	 * page allocator are TDX-usable memory.
+	 *
+	 * Build the list of "TDX-usable" memory regions which cover all
+	 * pages in the page allocator to guarantee that.  Do it while
+	 * holding mem_hotplug_lock read-lock as the memory hotplug code
+	 * path reads the @tdx_memlist to reject any new memory.
+	 */
+	get_online_mems();
+
+	ret = build_tdx_memlist(&tdx_memlist);
+	if (ret)
+		goto out;
+
 	/*
 	 * TODO:
 	 *
-	 *  - Build the list of TDX-usable memory regions.
 	 *  - Construct a list of "TD Memory Regions" (TDMRs) to cover
 	 *    all TDX-usable memory regions.
 	 *  - Configure the TDMRs and the global KeyID to the TDX module.
@@ -271,7 +369,15 @@ static int init_tdx_module(void)
 	 *
 	 *  Return error before all steps are done.
 	 */
-	return -EINVAL;
+	ret = -EINVAL;
+out:
+	/*
+	 * @tdx_memlist is written here and read at memory hotplug time.
+	 * Lock out memory hotplug code while building it.
+	 */
+	put_online_mems();
+
+	return ret;
 }
 
 static int __tdx_enable(void)
@@ -361,6 +467,54 @@ static int __init record_keyid_partitioning(u32 *tdx_keyid_start,
 	return 0;
 }
 
+static bool is_tdx_memory(unsigned long start_pfn, unsigned long end_pfn)
+{
+	struct tdx_memblock *tmb;
+
+	/*
+	 * This check assumes that the start_pfn<->end_pfn range does not
+	 * cross multiple @tdx_memlist entries.  A single memory online
+	 * event across multiple memblocks (from which @tdx_memlist
+	 * entries are derived at the time of module initialization) is
+	 * not possible.  This is because memory offline/online is done
+	 * on granularity of 'struct memory_block', and the hotpluggable
+	 * memory region (one memblock) must be multiple of memory_block.
+	 */
+	list_for_each_entry(tmb, &tdx_memlist, list) {
+		if (start_pfn >= tmb->start_pfn && end_pfn <= tmb->end_pfn)
+			return true;
+	}
+	return false;
+}
+
+static int tdx_memory_notifier(struct notifier_block *nb, unsigned long action,
+			       void *v)
+{
+	struct memory_notify *mn = v;
+
+	if (action != MEM_GOING_ONLINE)
+		return NOTIFY_OK;
+
+	/*
+	 * Empty list means TDX isn't enabled.  Allow any memory
+	 * to go online.
+	 */
+	if (list_empty(&tdx_memlist))
+		return NOTIFY_OK;
+
+	/*
+	 * The TDX memory configuration is static and can not be
+	 * changed.  Reject onlining any memory which is outside of
+	 * the static configuration whether it supports TDX or not.
+	 */
+	return is_tdx_memory(mn->start_pfn, mn->start_pfn + mn->nr_pages) ?
+		NOTIFY_OK : NOTIFY_BAD;
+}
+
+static struct notifier_block tdx_memory_nb = {
+	.notifier_call = tdx_memory_notifier,
+};
+
 static int __init tdx_init(void)
 {
 	u32 tdx_keyid_start, nr_tdx_keyids;
@@ -384,6 +538,13 @@ static int __init tdx_init(void)
 		goto no_tdx;
 	}
 
+	err = register_memory_notifier(&tdx_memory_nb);
+	if (err) {
+		pr_info("initialization failed: register_memory_notifier() failed (%d)\n",
+				err);
+		goto no_tdx;
+	}
+
 	/*
 	 * Just use the first TDX KeyID as the 'global KeyID' and
 	 * leave the rest for TDX guests.
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 97f4d7e7f1a4..4b6fc0d8b420 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -106,6 +106,12 @@ enum tdx_module_status_t {
 	TDX_MODULE_ERROR
 };
 
+struct tdx_memblock {
+	struct list_head list;
+	unsigned long start_pfn;
+	unsigned long end_pfn;
+};
+
 struct tdx_module_output;
 u64 __seamcall(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 	       struct tdx_module_output *out);
-- 
2.40.1

