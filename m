Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725B26F0415
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243555AbjD0KUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243535AbjD0KUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:20:10 -0400
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74C959CA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:20:06 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="94534352"
X-IronPort-AV: E=Sophos;i="5.99,230,1677510000"; 
   d="scan'208";a="94534352"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 19:19:01 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 66CADD6473
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:18:59 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 89E0CD55C6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 19:18:58 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 8D6B01145FC8;
        Thu, 27 Apr 2023 19:18:55 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     x86@kernel.org, nvdimm@lists.linux.dev, kexec@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, y-goto@fujitsu.com,
        yangx.jy@fujitsu.com, ruansy.fnst@fujitsu.com,
        Li Zhijian <lizhijian@fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>
Subject: [RFC PATCH v2 makedumpfile 3/3] makedumpfile.c: Allow excluding metadata of pmem region
Date:   Thu, 27 Apr 2023 18:18:38 +0800
Message-Id: <20230427101838.12267-8-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427101838.12267-1-lizhijian@fujitsu.com>
References: <20230427101838.12267-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27590.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27590.006
X-TMASE-Result: 10--17.343100-10.000000
X-TMASE-MatchedRID: 9L013dfUpyvvnOSC+jk4DioiRKlBVkYI2+EDPw+8xrc6FHRWx2FGsL8F
        Hrw7frluf146W0iUu2uCJEtlOxU1W01QH6PUk2DDutvHF25zoU+u2GmdldmiUHH5y9+1Ef464rl
        +FHG3VoCuNMNPg+YVh/Na/9C36NYhcxNXyOjdrDtYUconbBJWJBeK/B+WKxKsuzdiHYg4JjNOyY
        xJZlS6a2+74QBQ4LHTNyno03YkG3nS5A6Ae0UgqqzGfgakLdjaoR62RNvkvOuysPB8dBBorUX1x
        YMqj/2QjNfBKGsNCNcr9TEMd9mL1I0TO6yT9XrPAoNa2r+Edw2061diBteN175TVqwOzxj8o6yI
        pLdrAfigzMqEdGA7shh6q/5LKwqLlwV2iaAfSWcURSScn+QSXt0H8LFZNFG7JQhrLH5KSJ0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend -d option(BIT(5)) to allow user excluding metadata

CC: Baoquan He <bhe@redhat.com>
CC: Vivek Goyal <vgoyal@redhat.com>
CC: Dave Young <dyoung@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 makedumpfile.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++---
 makedumpfile.h |  10 +++-
 2 files changed, 145 insertions(+), 8 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 98c3b8c7ced9..e4d036505311 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -100,6 +100,7 @@ mdf_pfn_t pfn_user;
 mdf_pfn_t pfn_free;
 mdf_pfn_t pfn_hwpoison;
 mdf_pfn_t pfn_offline;
+mdf_pfn_t pfn_pmem_metadata;
 mdf_pfn_t pfn_pmem_userdata;
 mdf_pfn_t pfn_elf_excluded;
 
@@ -1623,6 +1624,7 @@ get_symbol_info(void)
 	SYMBOL_INIT(mem_map, "mem_map");
 	SYMBOL_INIT(vmem_map, "vmem_map");
 	SYMBOL_INIT(mem_section, "mem_section");
+	SYMBOL_INIT(devm_memmap_vmcore_head, "devm_memmap_vmcore_head");
 	SYMBOL_INIT(pkmap_count, "pkmap_count");
 	SYMBOL_INIT_NEXT(pkmap_count_next, "pkmap_count");
 	SYMBOL_INIT(system_utsname, "system_utsname");
@@ -1727,6 +1729,11 @@ get_structure_info(void)
 		info->flag_use_count = FALSE;
 	}
 
+	SIZE_INIT(devm_memmap_vmcore, "devm_memmap_vmcore");
+	OFFSET_INIT(devm_memmap_vmcore.entry, "devm_memmap_vmcore", "entry");
+	OFFSET_INIT(devm_memmap_vmcore.start, "devm_memmap_vmcore", "start");
+	OFFSET_INIT(devm_memmap_vmcore.end, "devm_memmap_vmcore", "end");
+
 	OFFSET_INIT(page.mapping, "page", "mapping");
 	OFFSET_INIT(page._mapcount, "page", "_mapcount");
 	OFFSET_INIT(page.private, "page", "private");
@@ -2757,6 +2764,7 @@ read_vmcoreinfo(void)
 	READ_SYMBOL("mem_map", mem_map);
 	READ_SYMBOL("vmem_map", vmem_map);
 	READ_SYMBOL("mem_section", mem_section);
+	READ_SYMBOL("devm_memmap_vmcore_head", devm_memmap_vmcore_head);
 	READ_SYMBOL("pkmap_count", pkmap_count);
 	READ_SYMBOL("pkmap_count_next", pkmap_count_next);
 	READ_SYMBOL("system_utsname", system_utsname);
@@ -2805,6 +2813,7 @@ read_vmcoreinfo(void)
 	READ_STRUCTURE_SIZE("pageflags", pageflags);
 	READ_STRUCTURE_SIZE("vmemmap_backing", vmemmap_backing);
 	READ_STRUCTURE_SIZE("mmu_psize_def", mmu_psize_def);
+	READ_STRUCTURE_SIZE("devm_memmap_vmcore", devm_memmap_vmcore);
 
 
 	READ_MEMBER_OFFSET("page.flags", page.flags);
@@ -2852,6 +2861,9 @@ read_vmcoreinfo(void)
 	READ_MEMBER_OFFSET("mmu_psize_def.shift", mmu_psize_def.shift);
 	READ_MEMBER_OFFSET("cpu_spec.mmu_features", cpu_spec.mmu_features);
 	READ_MEMBER_OFFSET("uts_namespace.name", uts_namespace.name);
+	READ_MEMBER_OFFSET("devm_memmap_vmcore.entry", devm_memmap_vmcore.entry);
+	READ_MEMBER_OFFSET("devm_memmap_vmcore.start", devm_memmap_vmcore.start);
+	READ_MEMBER_OFFSET("devm_memmap_vmcore.end", devm_memmap_vmcore.end);
 
 	READ_STRUCTURE_SIZE("printk_log", printk_log);
 	READ_STRUCTURE_SIZE("printk_ringbuffer", printk_ringbuffer);
@@ -3210,6 +3222,88 @@ pgdat4:
 	return SYMBOL(contig_page_data);
 }
 
+struct devm_memmap_entry {
+	unsigned long start, end;
+	struct devm_memmap_entry *next;
+};
+
+static struct devm_memmap_entry *devm_memmap;
+
+static void pmem_add_next(unsigned long start, unsigned long end)
+{
+	struct devm_memmap_entry *tail = devm_memmap, *node;
+
+	node = calloc(1, sizeof(*node));
+	if (!node)
+		return;
+
+	node->start = start;
+	node->end = end;
+	node->next = NULL;
+
+	if (!devm_memmap) {
+		devm_memmap = node;
+		return;
+	}
+
+	while (tail->next)
+		tail = tail->next;
+
+	tail->next = node;
+}
+
+static void dump_pmem_metadata(int i)
+{
+	long head_next;
+	long entry, head = SYMBOL(devm_memmap_vmcore_head);
+	long devm_entry, start_p, end_p;
+	unsigned long start, end;
+	static int cnt = 0;
+
+	entry = head;
+
+	if (head == NOT_FOUND_SYMBOL ||
+	    OFFSET(list_head.next) == NOT_FOUND_STRUCTURE ||
+	    OFFSET(devm_memmap_vmcore.start) == NOT_FOUND_STRUCTURE ||
+	    OFFSET(devm_memmap_vmcore.end) == NOT_FOUND_STRUCTURE ||
+	    OFFSET(devm_memmap_vmcore.entry) == NOT_FOUND_STRUCTURE)
+		return;
+
+	MSG("list_head.next: %ld\n", OFFSET(list_head.next));
+	MSG("devm_memmap_vmcore.start: %ld\n", OFFSET(devm_memmap_vmcore.start));
+	MSG("devm_memmap_vmcore.end: %ld\n", OFFSET(devm_memmap_vmcore.end));
+	MSG("devm_memmap_vmcore.entry: %ld\n", OFFSET(devm_memmap_vmcore.entry));
+
+again:
+	if (!readmem(VADDR, entry + OFFSET(list_head.next), &head_next, sizeof(head_next)))
+		return;
+
+	if (head_next == head) {
+		return;
+	}
+
+	entry = head_next;
+
+	devm_entry = entry - OFFSET(devm_memmap_vmcore.entry);
+	start_p = devm_entry + OFFSET(devm_memmap_vmcore.start);
+	end_p = devm_entry + OFFSET(devm_memmap_vmcore.end);
+
+	if (!readmem(VADDR, start_p, &start, sizeof(unsigned long))) {
+		goto fail;
+	}
+
+	if (!readmem(VADDR, end_p, &end, sizeof(unsigned long))) {
+		goto fail;
+	}
+
+	MSG("devm_memmap_vmcore[%d]: addr: %lx, [%lx - %lx )\n", cnt++, devm_entry, start, end);
+	pmem_add_next(start, end);
+	goto again;
+
+fail:
+	return;
+}
+
 void
 dump_mem_map(mdf_pfn_t pfn_start, mdf_pfn_t pfn_end,
     unsigned long mem_map, int num_mm)
@@ -3728,6 +3822,7 @@ get_mem_section(unsigned int mem_section_size, unsigned long *mem_maps,
 		return FALSE;
 	}
 
+	dump_pmem_metadata(1);
 	/*
 	 * There was a report that the first validation wrongly returned TRUE
 	 * with -x vmlinux and SPARSEMEM_EXTREME v2 on s390x, so skip it.
@@ -6311,6 +6406,30 @@ exclude_range(mdf_pfn_t *counter, mdf_pfn_t pfn, mdf_pfn_t endpfn,
 	}
 }
 
+static int is_pmem_metadata_range(unsigned long start, unsigned long end)
+{
+	struct devm_memmap_entry *head = devm_memmap;
+
+	while (head) {
+		if (head->start <= start && head->end >= end)
+			return TRUE;
+		head = head->next;
+	}
+
+	return FALSE;
+}
+
+static void cleanup_pmem_metadata(void)
+{
+	struct devm_memmap_entry *head = devm_memmap;
+
+	while (head) {
+		struct devm_memmap_entry *next = head->next;
+		free(head);
+		head = next;
+	}
+}
+
 int
 __exclude_unnecessary_pages(unsigned long mem_map,
     mdf_pfn_t pfn_start, mdf_pfn_t pfn_end, struct cycle *cycle)
@@ -6381,9 +6500,17 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 
 		is_pmem = is_pmem_pt_load_range(pfn << PAGESHIFT(), (pfn + 1) << PAGESHIFT());
 		if (is_pmem) {
-			pfn_pmem_userdata++;
-			clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle);
-			continue;
+			if (is_pmem_metadata_range(pfn, pfn + 1)) {
+				if (info->dump_level & DL_EXCLUDE_PMEM_META) {
+					pfn_pmem_metadata++;
+					clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle);
+					continue;
+				}
+			} else {
+				pfn_pmem_userdata++;
+				clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle);
+				continue;
+			}
 		}
 
 		index_pg = pfn % PGMM_CACHED;
@@ -8092,7 +8219,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	 * Reset counter for debug message.
 	 */
 	if (info->flag_cyclic) {
-		pfn_zero = pfn_cache = pfn_cache_private = 0;
+		pfn_zero = pfn_cache = pfn_cache_private = pfn_pmem_metadata = 0;
 		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_pmem_userdata = 0;
 		pfn_memhole = info->max_mapnr;
 	}
@@ -9430,7 +9557,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 		/*
 		 * Reset counter for debug message.
 		 */
-		pfn_zero = pfn_cache = pfn_cache_private = 0;
+		pfn_zero = pfn_cache = pfn_cache_private = pfn_pmem_metadata = 0;
 		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_pmem_userdata = 0;
 		pfn_memhole = info->max_mapnr;
 
@@ -10380,7 +10507,7 @@ print_report(void)
 	pfn_original = info->max_mapnr - pfn_memhole;
 
 	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private + pfn_pmem_userdata
-	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
+	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline + pfn_pmem_metadata;
 
 	REPORT_MSG("\n");
 	REPORT_MSG("Original pages  : 0x%016llx\n", pfn_original);
@@ -10396,6 +10523,7 @@ print_report(void)
 	REPORT_MSG("    Free pages              : 0x%016llx\n", pfn_free);
 	REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpoison);
 	REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offline);
+	REPORT_MSG("    pmem metadata pages     : 0x%016llx\n", pfn_pmem_metadata);
 	REPORT_MSG("    pmem userdata pages     : 0x%016llx\n", pfn_pmem_userdata);
 	REPORT_MSG("  Remaining pages  : 0x%016llx\n",
 	    pfn_original - pfn_excluded);
@@ -10437,7 +10565,7 @@ print_mem_usage(void)
 	pfn_original = info->max_mapnr - pfn_memhole;
 
 	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private + pfn_pmem_userdata
-	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
+	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline + pfn_pmem_metadata;
 	shrinking = (pfn_original - pfn_excluded) * 100;
 	shrinking = shrinking / pfn_original;
 	total_size = info->page_size * pfn_original;
@@ -12403,6 +12531,7 @@ out:
 		}
 	}
 	free_elf_info();
+	cleanup_pmem_metadata();
 
 	return retcd;
 }
diff --git a/makedumpfile.h b/makedumpfile.h
index 21dec7d1145c..790fa698bb0e 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -206,7 +206,7 @@ test_bit(int nr, unsigned long addr)
  * Dump Level
  */
 #define MIN_DUMP_LEVEL		(0)
-#define MAX_DUMP_LEVEL		(31)
+#define MAX_DUMP_LEVEL		(63)
 #define NUM_ARRAY_DUMP_LEVEL	(MAX_DUMP_LEVEL + 1) /* enough to allocate
 							all the dump_level */
 #define DL_EXCLUDE_ZERO		(0x001) /* Exclude Pages filled with Zeros */
@@ -216,6 +216,7 @@ test_bit(int nr, unsigned long addr)
 				           with Private Pages */
 #define DL_EXCLUDE_USER_DATA	(0x008) /* Exclude UserProcessData Pages */
 #define DL_EXCLUDE_FREE		(0x010)	/* Exclude Free Pages */
+#define DL_EXCLUDE_PMEM_META	(0x020)	/* Exclude pmem metadata Pages */
 
 
 /*
@@ -1711,6 +1712,7 @@ struct symbol_table {
 	unsigned long long	mem_map;
 	unsigned long long	vmem_map;
 	unsigned long long	mem_section;
+	unsigned long long	devm_memmap_vmcore_head;
 	unsigned long long	pkmap_count;
 	unsigned long long	pkmap_count_next;
 	unsigned long long	system_utsname;
@@ -1817,6 +1819,7 @@ struct size_table {
 	long	node_memblk_s;
 	long	nodemask_t;
 	long	printk_log;
+	long	devm_memmap_vmcore;
 
 	/*
 	 * for lockless printk ringbuffer
@@ -1896,6 +1899,11 @@ struct offset_table {
 		long	next;
 		long	prev;
 	} list_head;
+	struct devm_memmap_vmcore {
+		long	entry;
+		long	start;
+		long	end;
+	} devm_memmap_vmcore;
 	struct node_memblk_s {
 		long	start_paddr;
 		long	size;
-- 
2.29.2

