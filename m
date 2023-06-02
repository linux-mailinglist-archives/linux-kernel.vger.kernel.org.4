Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0138971FF5B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbjFBKb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbjFBKaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:30:09 -0400
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAF71FC0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:28:09 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="119231456"
X-IronPort-AV: E=Sophos;i="6.00,212,1681138800"; 
   d="scan'208";a="119231456"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 19:27:12 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 5D096C68E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 19:27:10 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9878DD20AF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 19:27:09 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 89B3840FE2;
        Fri,  2 Jun 2023 19:27:08 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     kexec@lists.infradead.org, nvdimm@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        bhe@redhat.com, ruansy.fnst@fujitsu.com, y-goto@fujitsu.com,
        yangx.jy@fujitsu.com, Li Zhijian <lizhijian@fujitsu.com>,
        Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Subject: [RFC PATCH makedumpfile v3 3/3] makedumpfile: get metadata boundaries from pmem's infoblock
Date:   Fri,  2 Jun 2023 18:26:56 +0800
Message-Id: <20230602102656.131654-8-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230602102656.131654-1-lizhijian@fujitsu.com>
References: <20230602102656.131654-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27666.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27666.006
X-TMASE-Result: 10--22.341900-10.000000
X-TMASE-MatchedRID: 44XoofGiUa/SFChHF48gQTiEPRj9j9rvUh4weWPqOWS638ZUY6gSd1YI
        HeJwbhUqNmVYIPY+Gy2YlVLttZCaEDBF7stuNMMxEVuC0eNRYvLxKR2kbb+f1wYkj8pwyAod12k
        t5HuVFgCbKneFtGQ4N1LlTv2kQ2/LP06ke90qDvPum6Nvy6t3NgmWvXEqQTm5wLkNMQzGl5B+Kr
        WCPbERP2XM/1LvxbWDZva/ER92lB2cfX6Ug1yFMM36paW7ZnFoGB9/bxS68hPk6Qbi+9i6Dz/zI
        kvUoSsdD7X3CqobQahpM4uQJ+eFBvdZ3f2rISMmfOaYwP8dcX6BiLDUCsch2+uLH9BII+4qlfC3
        WuSrCNRwmg9/GN+fyAQTZYEbCLsYrJKo/rFyHQGVOwZbcOalSxZSD+Gbjz3IWH7Bxw4ADCPmKXL
        lUHkJC+EjtnMuJXJurgv6vPEWDp7YsZWA4GRU5h1qGr6sYOf/wJjn8yqLU6I1Y73PdzvXZKKJ8y
        eXnfHAZZ1LvVb67BW23YOnZxHtRsOrmarpjDAkngIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPI6T/LT
        DsmJmg=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

some code are copied from ndctl.

This change requires libndctl which provides interface to walk through
all existing namespaces.

This also requires the namespace entered the force_raw mode(the kernel will
ensure that).

The resource interface provides the start of namespace, and device's
superblock provides the usedata's offset of namespace. According to this
information, we can caculate the scope of metadata.

A new dump level(-d 63) is introduced to skip the metadata as well in
this patch.

CC: Baoquan He <bhe@redhat.com>
CC: Vivek Goyal <vgoyal@redhat.com>
CC: Dave Young <dyoung@redhat.com>
CC: kexec@lists.infradead.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 Makefile       |   2 +-
 makedumpfile.c | 196 +++++++++++++++++++++++++++++++++++++++++++++++--
 makedumpfile.h |   3 +-
 3 files changed, 192 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index 0608035e913f..fd0a792c5647 100644
--- a/Makefile
+++ b/Makefile
@@ -50,7 +50,7 @@ OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
 SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/loongarch64.c
 OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
 
-LIBS = -ldw -lbz2 -ldl -lelf -lz
+LIBS = -ldw -lbz2 -ldl -lelf -lz -lndctl
 ifneq ($(LINKTYPE), dynamic)
 LIBS := -static $(LIBS) -llzma
 endif
diff --git a/makedumpfile.c b/makedumpfile.c
index f304f752b0ec..b68d261f3d1e 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -27,6 +27,8 @@
 #include <limits.h>
 #include <assert.h>
 #include <zlib.h>
+#include <sys/types.h>
+#include <ndctl/libndctl.h>
 
 struct symbol_table	symbol_table;
 struct size_table	size_table;
@@ -100,6 +102,7 @@ mdf_pfn_t pfn_user;
 mdf_pfn_t pfn_free;
 mdf_pfn_t pfn_hwpoison;
 mdf_pfn_t pfn_offline;
+mdf_pfn_t pfn_pmem_metadata;
 mdf_pfn_t pfn_pmem_userdata;
 mdf_pfn_t pfn_elf_excluded;
 
@@ -6374,6 +6377,173 @@ exclude_range(mdf_pfn_t *counter, mdf_pfn_t pfn, mdf_pfn_t endpfn,
 	}
 }
 
+struct pmem_metadata_node {
+	unsigned long long start;
+	unsigned long long end;
+	struct pmem_metadata_node *next;
+} pmem_metadata_head;
+
+struct pmem_metadata_node *pmem_head = NULL;
+
+static void pmem_add_next(unsigned long long start, unsigned long long dataoff)
+{
+	struct pmem_metadata_node *tail = pmem_head, *node;
+
+	node = calloc(1, sizeof(*node));
+	if (!node)
+		return;
+
+	node->start = start >> info->page_shift;
+	node->end = (start + dataoff) >> info->page_shift;
+	node->next = NULL;
+
+	if (!pmem_head) {
+		pmem_head = node;
+		return;
+	}
+	while (tail->next)
+		tail = tail->next;
+	tail->next = node;
+}
+
+static void cleanup_pmem_metadata(void)
+{
+	struct pmem_metadata_node *head = pmem_head;
+	while (head) {
+		struct pmem_metadata_node *next = head->next;
+		free(head);
+		head = next;
+	}
+}
+
+static int is_pmem_metadata_range(unsigned long long start, unsigned long long end)
+{
+	struct pmem_metadata_node *head = pmem_head;
+	while (head) {
+		if (head->start <= start && head->end > end)
+			return TRUE;
+		head = head->next;
+	}
+
+	return FALSE;
+}
+
+static void dump_pmem_range(void)
+{
+	int i = 0;
+	struct pmem_metadata_node *node= pmem_head;
+
+	fprintf(stderr, "dump_pmem_range start......\n\n\n");
+	while (node) {
+		fprintf(stderr, "namespace[%d]: metadata[%llx, %llx]\n", i++, node->start, node->end);
+		node = node->next;
+	}
+	fprintf(stderr, "dump_pmem_range end........\n\n\n");
+}
+
+#define INFOBLOCK_SZ (8192)
+#define SZ_4K (4096)
+#define PFN_SIG_LEN 16
+
+typedef uint64_t u64;
+typedef int64_t s64;
+typedef uint32_t u32;
+typedef int32_t s32;
+typedef uint16_t u16;
+typedef int16_t s16;
+typedef uint8_t u8;
+typedef int8_t s8;
+
+typedef int64_t le64;
+typedef int32_t le32;
+typedef int16_t le16;
+
+struct pfn_sb {
+	u8 signature[PFN_SIG_LEN];
+	u8 uuid[16];
+	u8 parent_uuid[16];
+	le32 flags;
+	le16 version_major;
+	le16 version_minor;
+	le64 dataoff; /* relative to namespace_base + start_pad */
+	le64 npfns;
+	le32 mode;
+	/* minor-version-1 additions for section alignment */
+	le32 start_pad;
+	le32 end_trunc;
+	/* minor-version-2 record the base alignment of the mapping */
+	le32 align;
+	/* minor-version-3 guarantee the padding and flags are zero */
+	/* minor-version-4 record the page size and struct page size */
+	le32 page_size;
+	le16 page_struct_size;
+	u8 padding[3994];
+	le64 checksum;
+};
+
+static int nd_read_infoblock_dataoff(struct ndctl_namespace *ndns)
+{
+	int fd, rc;
+	char path[50];
+	char buf[INFOBLOCK_SZ + 1];
+	struct pfn_sb *pfn_sb = (struct pfn_sb *)(buf + SZ_4K);
+
+	sprintf(path, "/dev/%s", ndctl_namespace_get_block_device(ndns));
+
+	fd = open(path, O_RDONLY|O_EXCL);
+	if (fd < 0)
+		return -1;
+
+	rc = read(fd, buf, INFOBLOCK_SZ);
+	if (rc < INFOBLOCK_SZ) {
+		return -1;
+	}
+
+	return pfn_sb->dataoff;
+}
+
+int inspect_pmem_namespace(void)
+{
+	struct ndctl_ctx *ctx;
+	struct ndctl_bus *bus;
+	int rc = -1;
+
+	fprintf(stderr, "\n\ninspect_pmem_namespace!!\n\n");
+	rc = ndctl_new(&ctx);
+	if (rc)
+		return -1;
+
+	ndctl_bus_foreach(ctx, bus) {
+		struct ndctl_region *region;
+
+		ndctl_region_foreach(bus, region) {
+			struct ndctl_namespace *ndns;
+
+			ndctl_namespace_foreach(region, ndns) {
+				enum ndctl_namespace_mode mode;
+				long long start, end_metadata;
+
+				mode = ndctl_namespace_get_mode(ndns);
+				/* kdump kernel should set force_raw, mode become *safe* */
+				if (mode == NDCTL_NS_MODE_SAFE) {
+					fprintf(stderr, "Only raw can be dumpable\n");
+					continue;
+				}
+
+				start = ndctl_namespace_get_resource(ndns);
+				end_metadata = nd_read_infoblock_dataoff(ndns);
+
+				/* metadata really starts from 2M alignment */
+				if (start != ULLONG_MAX && end_metadata > 2 * 1024 * 1024) // 2M
+					pmem_add_next(start, end_metadata);
+			}
+		}
+	}
+
+	ndctl_unref(ctx);
+	return 0;
+}
+
 int
 __exclude_unnecessary_pages(unsigned long mem_map,
     mdf_pfn_t pfn_start, mdf_pfn_t pfn_end, struct cycle *cycle)
@@ -6447,9 +6617,17 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 
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
@@ -8130,7 +8308,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
 	 * Reset counter for debug message.
 	 */
 	if (info->flag_cyclic) {
-		pfn_zero = pfn_cache = pfn_cache_private = 0;
+		pfn_zero = pfn_cache = pfn_cache_private = pfn_pmem_metadata = 0;
 		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_pmem_userdata = 0;
 		pfn_memhole = info->max_mapnr;
 	}
@@ -9468,7 +9646,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 		/*
 		 * Reset counter for debug message.
 		 */
-		pfn_zero = pfn_cache = pfn_cache_private = 0;
+		pfn_zero = pfn_cache = pfn_cache_private = pfn_pmem_metadata = 0;
 		pfn_user = pfn_free = pfn_hwpoison = pfn_offline = pfn_pmem_userdata = 0;
 		pfn_memhole = info->max_mapnr;
 
@@ -10418,7 +10596,7 @@ print_report(void)
 	pfn_original = info->max_mapnr - pfn_memhole;
 
 	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private + pfn_pmem_userdata
-	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
+	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline + pfn_pmem_metadata;
 
 	REPORT_MSG("\n");
 	REPORT_MSG("Original pages  : 0x%016llx\n", pfn_original);
@@ -10434,6 +10612,7 @@ print_report(void)
 	REPORT_MSG("    Free pages              : 0x%016llx\n", pfn_free);
 	REPORT_MSG("    Hwpoison pages          : 0x%016llx\n", pfn_hwpoison);
 	REPORT_MSG("    Offline pages           : 0x%016llx\n", pfn_offline);
+	REPORT_MSG("    pmem metadata pages     : 0x%016llx\n", pfn_pmem_metadata);
 	REPORT_MSG("    pmem userdata pages     : 0x%016llx\n", pfn_pmem_userdata);
 	REPORT_MSG("  Remaining pages  : 0x%016llx\n",
 	    pfn_original - pfn_excluded);
@@ -10475,7 +10654,7 @@ print_mem_usage(void)
 	pfn_original = info->max_mapnr - pfn_memhole;
 
 	pfn_excluded = pfn_zero + pfn_cache + pfn_cache_private + pfn_pmem_userdata
-	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline;
+	    + pfn_user + pfn_free + pfn_hwpoison + pfn_offline + pfn_pmem_metadata;
 	shrinking = (pfn_original - pfn_excluded) * 100;
 	shrinking = shrinking / pfn_original;
 	total_size = info->page_size * pfn_original;
@@ -10768,6 +10947,8 @@ create_dumpfile(void)
 		}
 	}
 
+	inspect_pmem_namespace();
+	dump_pmem_range();
 	print_vtop();
 
 	num_retry = 0;
@@ -12441,6 +12622,7 @@ out:
 		}
 	}
 	free_elf_info();
+	cleanup_pmem_metadata();
 
 	return retcd;
 }
diff --git a/makedumpfile.h b/makedumpfile.h
index 85e5a4932983..ecb2fb4d7a4c 100644
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
+#define DL_EXCLUDE_PMEM_META   (0x020) /* Exclude pmem metadata Pages */
 
 
 /*
-- 
2.29.2

