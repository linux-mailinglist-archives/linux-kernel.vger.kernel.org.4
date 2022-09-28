Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0EF5ED4D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiI1GZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiI1GZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:25:21 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21978121116
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:25:17 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 28S6Krhg004275
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:25:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=lNy9IwFT/pB8FoN2EcoFvb2oxeuZHW9m7hh+oRRW86M=;
 b=RdW05zu+EiTPdRtX/XxQAZe1roV7UdgW4zgjpiGmISAwW6o+rOc21hDmX8yXNVGxDBGw
 z2/xzGEFSlLpxTLwNorhCpu6vdQ99zbORl/K8GeOUh2ge6s7NtZ6btcet4D3zeEoiXTn
 E/tohSeKqDamQTas7x4g20g7ziCujA3NNPg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3juxp6qdp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:25:16 -0700
Received: from twshared8247.08.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 23:25:15 -0700
Received: by devvm6390.atn0.facebook.com (Postfix, from userid 352741)
        id 6FBF6443E383; Tue, 27 Sep 2022 23:25:09 -0700 (PDT)
From:   <alexlzhu@fb.com>
To:     <linux-mm@kvack.org>
CC:     <willy@infradead.org>, <akpm@linux-foundation.org>,
        <riel@surriel.com>, <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Alexander Zhu <alexlzhu@fb.com>
Subject: [PATCH 1/3] mm: add thp_utilization metrics to sysfs
Date:   Tue, 27 Sep 2022 23:25:04 -0700
Message-ID: <0b223e6da5bd6681faca21524b64e314c5c5c57f.1664344829.git.alexlzhu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1664344829.git.alexlzhu@fb.com>
References: <cover.1664344829.git.alexlzhu@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: jwjcI5aJni7ZJwUCN8H3sT6i5F7JaNtO
X-Proofpoint-ORIG-GUID: jwjcI5aJni7ZJwUCN8H3sT6i5F7JaNtO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_02,2022-09-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Zhu <alexlzhu@fb.com>

This change introduces a tool that scans through all of physical
memory for anonymous THPs and groups them into buckets based
on utilization. It also includes an interface under
/sys/kernel/debug/thp_utilization.

Sample Output:

Utilized[0-50]: 1331 680884
Utilized[51-101]: 9 3983
Utilized[102-152]: 3 1187
Utilized[153-203]: 0 0
Utilized[204-255]: 2 539
Utilized[256-306]: 5 1135
Utilized[307-357]: 1 192
Utilized[358-408]: 0 0
Utilized[409-459]: 1 57
Utilized[460-512]: 400 13
Last Scan Time: 223.98s
Last Scan Duration: 70.65s

This indicates that there are 1331 THPs that have between 0 and 50
utilized (non zero) pages. In total there are 680884 zero pages in
this utilization bucket. THPs in the [0-50] bucket compose 76% of total
THPs, and are responsible for 99% of total zero pages across all
THPs. In other words, the least utilized THPs are responsible for almost
all of the memory waste when THP is always enabled. Similar results
have been observed across production workloads.

The last two lines indicate the timestamp and duration of the most recent
scan through all of physical memory. Here we see that the last scan
occurred 223.98 seconds after boot time and took 70.65 seconds.

Utilization of a THP is defined as the percentage of nonzero
pages in the THP. The worker thread will scan through all
of physical memory and obtain utilization of all anonymous
THPs. It will gather this information by periodically scanning
through all of physical memory for anonymous THPs, group them
into buckets based on utilization, and report utilization
information through sysfs under /sys/kernel/debug/thp_utilization.

Signed-off-by: Alexander Zhu <alexlzhu@fb.com>
---
 Documentation/admin-guide/mm/transhuge.rst |   9 +
 include/linux/huge_mm.h                    |   3 +
 mm/huge_memory.c                           | 202 +++++++++++++++++++++
 3 files changed, 214 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
index c9c37f16eef8..d883ff9fddc7 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -297,6 +297,15 @@ To identify what applications are mapping file trans=
parent huge pages, it
 is necessary to read ``/proc/PID/smaps`` and count the FileHugeMapped fi=
elds
 for each mapping.
=20
+The utilization of transparent hugepages can be viewed by reading
+``/sys/kernel/debug/thp_utilization``. The utilization of a THP is defin=
ed
+as the ratio of non zero filled 4kb pages to the total number of pages i=
n a
+THP. The buckets are labelled by the range of total utilized 4kb pages w=
ith
+one line per utilization bucket. Each line contains the total number of
+THPs in that bucket and the total number of zero filled 4kb pages summed
+over all THPs in that bucket. The last two lines show the timestamp and
+duration respectively of the most recent scan over all of physical memor=
y.
+
 Note that reading the smaps file is expensive and reading it
 frequently will incur overhead.
=20
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 768e5261fdae..d5520f5cc798 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -179,6 +179,9 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
 unsigned long thp_get_unmapped_area(struct file *filp, unsigned long add=
r,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
=20
+int thp_number_utilized_pages(struct page *page);
+int thp_utilization_bucket(int num_utilized_pages);
+
 void prep_transhuge_page(struct page *page);
 void free_transhuge_page(struct page *page);
=20
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f42bb51e023a..a05d6a42cf0a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -45,6 +45,16 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/thp.h>
=20
+/*
+ * The number of utilization buckets THPs will be grouped in
+ * under /sys/kernel/debug/thp_utilization.
+ */
+#define THP_UTIL_BUCKET_NR 10
+/*
+ * The number of PFNs (and hence hugepages) to scan through on each peri=
odic
+ * run of the scanner that generates /sys/kernel/debug/thp_utilization.
+ */
+#define THP_UTIL_SCAN_SIZE 256
 /*
  * By default, transparent hugepage support is disabled in order to avoi=
d
  * risking an increased memory footprint for applications that are not
@@ -70,6 +80,25 @@ static atomic_t huge_zero_refcount;
 struct page *huge_zero_page __read_mostly;
 unsigned long huge_zero_pfn __read_mostly =3D ~0UL;
=20
+static void thp_utilization_workfn(struct work_struct *work);
+static DECLARE_DELAYED_WORK(thp_utilization_work, thp_utilization_workfn=
);
+
+struct thp_scan_info_bucket {
+	int nr_thps;
+	int nr_zero_pages;
+};
+
+struct thp_scan_info {
+	struct thp_scan_info_bucket buckets[THP_UTIL_BUCKET_NR];
+	struct zone *scan_zone;
+	struct timespec64 last_scan_duration;
+	struct timespec64 last_scan_time;
+	unsigned long pfn;
+};
+
+static struct thp_scan_info thp_scan_debugfs;
+static struct thp_scan_info thp_scan;
+
 bool hugepage_vma_check(struct vm_area_struct *vma,
 			unsigned long vm_flags,
 			bool smaps, bool in_pf)
@@ -486,6 +515,7 @@ static int __init hugepage_init(void)
 	if (err)
 		goto err_slab;
=20
+	schedule_delayed_work(&thp_utilization_work, HZ);
 	err =3D register_shrinker(&huge_zero_page_shrinker, "thp-zero");
 	if (err)
 		goto err_hzp_shrinker;
@@ -600,6 +630,11 @@ static inline bool is_transparent_hugepage(struct pa=
ge *page)
 	       page[1].compound_dtor =3D=3D TRANSHUGE_PAGE_DTOR;
 }
=20
+static inline bool is_anon_transparent_hugepage(struct page *page)
+{
+	return PageAnon(page) && is_transparent_hugepage(page);
+}
+
 static unsigned long __thp_get_unmapped_area(struct file *filp,
 		unsigned long addr, unsigned long len,
 		loff_t off, unsigned long flags, unsigned long size)
@@ -650,6 +685,49 @@ unsigned long thp_get_unmapped_area(struct file *fil=
p, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
=20
+int thp_number_utilized_pages(struct page *page)
+{
+	struct folio *folio;
+	unsigned long page_offset, value;
+	int thp_nr_utilized_pages =3D HPAGE_PMD_NR;
+	int step_size =3D sizeof(unsigned long);
+	bool is_all_zeroes;
+	void *kaddr;
+	int i;
+
+	if (!page || !is_anon_transparent_hugepage(page))
+		return -1;
+
+	folio =3D page_folio(page);
+	for (i =3D 0; i < folio_nr_pages(folio); i++) {
+		kaddr =3D kmap_local_folio(folio, i);
+		is_all_zeroes =3D true;
+		for (page_offset =3D 0; page_offset < PAGE_SIZE; page_offset +=3D step=
_size) {
+			value =3D *(unsigned long *)(kaddr + page_offset);
+			if (value !=3D 0) {
+				is_all_zeroes =3D false;
+				break;
+			}
+		}
+		if (is_all_zeroes)
+			thp_nr_utilized_pages--;
+
+		kunmap_local(kaddr);
+	}
+	return thp_nr_utilized_pages;
+}
+
+int thp_utilization_bucket(int num_utilized_pages)
+{
+	int bucket;
+
+	if (num_utilized_pages < 0 || num_utilized_pages > HPAGE_PMD_NR)
+		return -1;
+	/* Group THPs into utilization buckets */
+	bucket =3D num_utilized_pages * THP_UTIL_BUCKET_NR / HPAGE_PMD_NR;
+	return min(bucket, THP_UTIL_BUCKET_NR - 1);
+}
+
 static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 			struct page *page, gfp_t gfp)
 {
@@ -3155,6 +3233,42 @@ static int __init split_huge_pages_debugfs(void)
 	return 0;
 }
 late_initcall(split_huge_pages_debugfs);
+
+static int thp_utilization_show(struct seq_file *seqf, void *pos)
+{
+	int i;
+	int start;
+	int end;
+
+	for (i =3D 0; i < THP_UTIL_BUCKET_NR; i++) {
+		start =3D i * HPAGE_PMD_NR / THP_UTIL_BUCKET_NR;
+		end =3D (i + 1 =3D=3D THP_UTIL_BUCKET_NR)
+			   ? HPAGE_PMD_NR
+			   : ((i + 1) * HPAGE_PMD_NR / THP_UTIL_BUCKET_NR - 1);
+		/* The last bucket will need to contain 100 */
+		seq_printf(seqf, "Utilized[%d-%d]: %d %d\n", start, end,
+			   thp_scan_debugfs.buckets[i].nr_thps,
+			   thp_scan_debugfs.buckets[i].nr_zero_pages);
+	}
+	seq_printf(seqf, "Last Scan Time: %lu.%02lus\n",
+		   (unsigned long)thp_scan_debugfs.last_scan_time.tv_sec,
+		   (thp_scan_debugfs.last_scan_time.tv_nsec / (NSEC_PER_SEC / 100)));
+
+	seq_printf(seqf, "Last Scan Duration: %lu.%02lus\n",
+		   (unsigned long)thp_scan_debugfs.last_scan_duration.tv_sec,
+		   (thp_scan_debugfs.last_scan_duration.tv_nsec / (NSEC_PER_SEC / 100)=
));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(thp_utilization);
+
+static int __init thp_utilization_debugfs(void)
+{
+	debugfs_create_file("thp_utilization", 0200, NULL, NULL,
+			    &thp_utilization_fops);
+	return 0;
+}
+late_initcall(thp_utilization_debugfs);
 #endif
=20
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
@@ -3240,3 +3354,91 @@ void remove_migration_pmd(struct page_vma_mapped_w=
alk *pvmw, struct page *new)
 	trace_remove_migration_pmd(address, pmd_val(pmde));
 }
 #endif
+
+static void thp_scan_next_zone(void)
+{
+	struct timespec64 current_time;
+	int i;
+	bool update_debugfs;
+	/*
+	 * THP utilization worker thread has reached the end
+	 * of the memory zone. Proceed to the next zone.
+	 */
+	thp_scan.scan_zone =3D next_zone(thp_scan.scan_zone);
+	update_debugfs =3D !thp_scan.scan_zone;
+	thp_scan.scan_zone =3D update_debugfs ? (first_online_pgdat())->node_zo=
nes
+			: thp_scan.scan_zone;
+	thp_scan.pfn =3D (thp_scan.scan_zone->zone_start_pfn + HPAGE_PMD_NR - 1=
)
+			& ~(HPAGE_PMD_SIZE - 1);
+	if (!update_debugfs)
+		return;
+	/*
+	 * If the worker has scanned through all of physical
+	 * memory. Then update information displayed in /sys/kernel/debug/thp_u=
tilization
+	 */
+	ktime_get_ts64(&current_time);
+	thp_scan_debugfs.last_scan_duration =3D timespec64_sub(current_time,
+							     thp_scan_debugfs.last_scan_time);
+	thp_scan_debugfs.last_scan_time =3D current_time;
+
+	for (i =3D 0; i < THP_UTIL_BUCKET_NR; i++) {
+		thp_scan_debugfs.buckets[i].nr_thps =3D thp_scan.buckets[i].nr_thps;
+		thp_scan_debugfs.buckets[i].nr_zero_pages =3D thp_scan.buckets[i].nr_z=
ero_pages;
+		thp_scan.buckets[i].nr_thps =3D 0;
+		thp_scan.buckets[i].nr_zero_pages =3D 0;
+	}
+}
+
+static void thp_util_scan(unsigned long pfn_end)
+{
+	struct page *page =3D NULL;
+	int bucket, num_utilized_pages, current_pfn;
+	int i;
+	/*
+	 * Scan through each memory zone in chunks of THP_UTIL_SCAN_SIZE
+	 * PFNs every second looking for anonymous THPs.
+	 */
+	for (i =3D 0; i < THP_UTIL_SCAN_SIZE; i++) {
+		current_pfn =3D thp_scan.pfn;
+		thp_scan.pfn +=3D HPAGE_PMD_NR;
+		if (current_pfn >=3D pfn_end)
+			return;
+
+		if (!pfn_valid(current_pfn))
+			continue;
+
+		page =3D pfn_to_page(current_pfn);
+		num_utilized_pages =3D thp_number_utilized_pages(page);
+		bucket =3D thp_utilization_bucket(num_utilized_pages);
+		if (bucket < 0)
+			continue;
+
+		thp_scan.buckets[bucket].nr_thps++;
+		thp_scan.buckets[bucket].nr_zero_pages +=3D (HPAGE_PMD_NR - num_utiliz=
ed_pages);
+	}
+}
+
+static void thp_utilization_workfn(struct work_struct *work)
+{
+	unsigned long pfn_end;
+
+	if (!thp_scan.scan_zone)
+		thp_scan.scan_zone =3D (first_online_pgdat())->node_zones;
+	/*
+	 * Worker function that scans through all of physical memory
+	 * for anonymous THPs.
+	 */
+	pfn_end =3D (thp_scan.scan_zone->zone_start_pfn +
+			thp_scan.scan_zone->spanned_pages + HPAGE_PMD_NR - 1)
+			& ~(HPAGE_PMD_SIZE - 1);
+	/* If we have reached the end of the zone or end of physical memory
+	 * move on to the next zone. Otherwise, scan the next PFNs in the
+	 * current zone.
+	 */
+	if (!populated_zone(thp_scan.scan_zone) || thp_scan.pfn >=3D pfn_end)
+		thp_scan_next_zone();
+	else
+		thp_util_scan(pfn_end);
+
+	schedule_delayed_work(&thp_utilization_work, HZ);
+}
--=20
2.30.2

