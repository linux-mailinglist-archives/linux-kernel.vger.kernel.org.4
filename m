Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EB95F0248
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 03:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiI3BgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 21:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiI3Bf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 21:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CA11FD8B9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 18:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664501753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=id5jS9GIl5YUAGyi9JHeiLoaOFFBXFXBzzRQ0BDhWCQ=;
        b=hLd+08iwHuzjd9FHYMplnkvOSkdwsLtdf6f73wlkx1840mrYq4JpOJAk5emEOrrLGwMD05
        1Z5+9CXNZehSM3ez9324ReHsbKwiD8Kj+Xw/UUTZhQZ92NZBKzEDIEp3CFbsYTDKlhet+R
        m5uDY2J3fbaXJ4Q2AWhvaFEXDtKbzhY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-256-Obl0d3K7PeGs7LbToKIaIQ-1; Thu, 29 Sep 2022 21:35:48 -0400
X-MC-Unique: Obl0d3K7PeGs7LbToKIaIQ-1
Received: by mail-qk1-f200.google.com with SMTP id bj42-20020a05620a192a00b006cf663bca6aso2658004qkb.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 18:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=id5jS9GIl5YUAGyi9JHeiLoaOFFBXFXBzzRQ0BDhWCQ=;
        b=XpIMGyJRhU8RvVtczET5j5+jKwdxLueS6YasoucOv2UV6DQnHxFYoe8QiIzOnMMpAk
         tYvSytQCWGjyMpu0pMpLgwLVI0y7kFbXJA/ZPAPAc1h5lGtW6SXfHooN71sUbERB+P1y
         b+5Zj8Q0e5PYgO7bMDLsyixiW4+CQb09n4kwTRIXcMGnPK2i2modNno1+/Aaa3yXyAbJ
         tOGKG5LIhrLUMiCQvCEYNqfKx8fPjVUaCb9Ip9/doowTrjgpfkTL21bFsYaSUy66rGj2
         fNJMM/TyTVyJoFFCPd9HGWpX46dekiuM6eOUgZ4pT9FDFpyWYy7yzu0uWutsLqdNvyXz
         +lag==
X-Gm-Message-State: ACrzQf3iRLWrDT8hFS2Zok29F/6FMnWVCMmIHHWDYlSmqrfeefDIefwV
        zN0p3X1lMHF8pkWL5I0Rl+VNetYxhczHpBHWox71doVMdMmhqGkcfj/rMRsRV8PA3kZMF0mubPl
        j+CWsLmd1j1WLOHjwBQcg48K2
X-Received: by 2002:a05:622a:1883:b0:35b:b7fc:24ac with SMTP id v3-20020a05622a188300b0035bb7fc24acmr4972658qtc.182.1664501747915;
        Thu, 29 Sep 2022 18:35:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7hwGFnM0XdWDVcazOEqGszR1x6gBn90V179XMk0fqa7T91LVp01wdQt1g89vtZwvruAPkiqA==
X-Received: by 2002:a05:622a:1883:b0:35b:b7fc:24ac with SMTP id v3-20020a05622a188300b0035bb7fc24acmr4972628qtc.182.1664501747607;
        Thu, 29 Sep 2022 18:35:47 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id c26-20020ac8519a000000b0035d4344a389sm660594qtn.94.2022.09.29.18.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 18:35:46 -0700 (PDT)
Date:   Thu, 29 Sep 2022 21:35:45 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+152d76c44ba142f8992b@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, songmuchun@bytedance.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [syzbot] general protection fault in PageHeadHuge
Message-ID: <YzZH8fqmItIS0cu4@xz-m1.local>
References: <Yy4g/BKpnJga1toG@monkey>
 <7693a84-bdc2-27b5-2695-d0fe8566571f@google.com>
 <Yy5WHvioerD2Sev1@x1n>
 <Yy8dBrmvDmqlsRXE@x1n>
 <Yy9T/JmVb4ymf6WM@monkey>
 <YzDuHbuo2x/b2Mbr@x1n>
 <YzMjxY5O6Hf/IPTx@monkey>
 <YzMomT+OusJnLOPC@x1n>
 <YzYrYVeA0b9d5dos@monkey>
 <YzZGkhNpluNHhTc3@xz-m1.local>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6BJDNHv8LiVvXy5W"
Content-Disposition: inline
In-Reply-To: <YzZGkhNpluNHhTc3@xz-m1.local>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6BJDNHv8LiVvXy5W
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Sep 29, 2022 at 09:29:54PM -0400, Peter Xu wrote:
> Hi, Mike,
> 
> On Thu, Sep 29, 2022 at 04:33:53PM -0700, Mike Kravetz wrote:
> > I added some TLB flushing to hugetlb_mcopy_atomic_pte, but it did not make
> > any difference.  Suggestions would be appreciated as cache/tlb/???  flushing
> > issues take me a while to figure out.
> 
> It seems the UFFDIO_COPY for hugetlb is the major issue here, in that for
> private mappings we don't inject the page cache.
> 
> I think it makes sense in that e.g. we don't want to allow a private
> mapping to be able to write to the page cache.  But afaict that's not
> correct because UFFDIO_COPY resolves exactly page faults in page cache
> layer for file backed memories.  So what we should do is inject page cache
> but mark the page RO, waiting for a coming CoW if needed.
> 
> I'll attach one patch fix that will start to inject the page into page
> cache for UFFDIO_COPY+hugetlb even if mapping is private.  Another test
> patch is also added because otherwise the private hugetlb selftest won't
> work after the fix applied - in the selftest we used to use DONTNEED to
> drop the private mapping, but IMHO that's not enough, we need to drop the
> page cache too (after the fix).  I've also have the test patch attached.
> 
> Feel free to try out with the two patches applied.  It started to work for
> me for current issue.
> 
> I didn't yet post them out yet because after I applied the two patches I
> found other issues - the reserved pages are messed up and leaked.  I'll
> keep looking tomorrow on the leak issue, but please also let me know if you
> figured anything suspecious as I know you're definitely must more fluent on
> the reservation code.
> 
> And that's not the only issue I found - shmem can have other issues
> regarding private mappings; shmem does it right on the page cache insertion
> but not the rest I think..  I'll look into them one by one.  It's quite
> interesting to dig multiple things out of the write check symptons..

The patches..

-- 
Peter Xu

--6BJDNHv8LiVvXy5W
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mm-hugetlb-Insert-page-cache-for-UFFDIO_COPY-even-if.patch"

From 1255fabde4f950bef4751ef337791b93f5373a1f Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 28 Sep 2022 17:44:00 -0400
Subject: [PATCH 1/2] mm/hugetlb: Insert page cache for UFFDIO_COPY even if
 private
Content-type: text/plain

UFFDIO_COPY resolves page fault in page cache layer for file backed
memories on shmem and hugetlbfs.  It also means for each UFFDIO_COPY we
should inject the new page into page cache no matter whether it's private
or shared mappings.

We used to not do that probably because for private mappings we should not
allow the page cache be written for the private mapped process. However it
can be done by removing the write bit (as what this patch does) so that CoW
will trigger properly for the page cache.

Leaving the page cache empty could lead to below sequence:

  (1) map hugetlb privately, register with uffd missing+wp
  (2) read page, trigger MISSING event with READ
  (3) UFFDIO_COPY(wp=1) resolve page fault, keep wr-protected
  (4) write page, trigger MISSING event again (because page cache missing!)
      with WRITE

This behavior existed since the initial commit of hugetlb MISSING mode
support, which is commit 1c9e8def43a3 ("userfaultfd: hugetlbfs: add
UFFDIO_COPY support for shared mappings", 2017-02-22).  In most cases it
should be fine as long as the hugetlb page/pte will be stable (e.g., no
wr-protect, no MADV_DONTNEED, ...).  However for any reason if a further
page fault is triggered, it could cause issue.  Recently due to the newly
introduced uffd-wp on hugetlbfs and also a recent locking rework from Mike,
we can easily fail userfaultfd kselftest with hugetlb private mappings.

One further step is we can do early CoW if the private mapping is
writable, but let's leave that for later.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9679fe519b90..a43fc6852f27 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5933,14 +5933,12 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	int ret = -ENOMEM;
 	struct page *page;
 	int writable;
-	bool page_in_pagecache = false;
 
 	if (is_continue) {
 		ret = -EFAULT;
 		page = find_lock_page(mapping, idx);
 		if (!page)
 			goto out;
-		page_in_pagecache = true;
 	} else if (!*pagep) {
 		/* If a page already exists, then it's UFFDIO_COPY for
 		 * a non-missing case. Return -EEXIST.
@@ -6014,8 +6012,8 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	 */
 	__SetPageUptodate(page);
 
-	/* Add shared, newly allocated pages to the page cache. */
-	if (vm_shared && !is_continue) {
+	/* Add newly allocated pages to the page cache for UFFDIO_COPY. */
+	if (!is_continue) {
 		size = i_size_read(mapping->host) >> huge_page_shift(h);
 		ret = -EFAULT;
 		if (idx >= size)
@@ -6030,7 +6028,6 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 		ret = hugetlb_add_to_page_cache(page, mapping, idx);
 		if (ret)
 			goto out_release_nounlock;
-		page_in_pagecache = true;
 	}
 
 	ptl = huge_pte_lock(h, dst_mm, dst_pte);
@@ -6044,18 +6041,13 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
 		goto out_release_unlock;
 
-	if (page_in_pagecache) {
-		page_dup_file_rmap(page, true);
-	} else {
-		ClearHPageRestoreReserve(page);
-		hugepage_add_new_anon_rmap(page, dst_vma, dst_addr);
-	}
+	page_dup_file_rmap(page, true);
 
 	/*
-	 * For either: (1) CONTINUE on a non-shared VMA, or (2) UFFDIO_COPY
-	 * with wp flag set, don't set pte write bit.
+	 * For either: (1) a non-shared VMA, or (2) UFFDIO_COPY with wp
+	 * flag set, don't set pte write bit.
 	 */
-	if (wp_copy || (is_continue && !vm_shared))
+	if (wp_copy || !vm_shared)
 		writable = 0;
 	else
 		writable = dst_vma->vm_flags & VM_WRITE;
@@ -6083,18 +6075,14 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
 	spin_unlock(ptl);
 	if (!is_continue)
 		SetHPageMigratable(page);
-	if (vm_shared || is_continue)
-		unlock_page(page);
+	unlock_page(page);
 	ret = 0;
 out:
 	return ret;
 out_release_unlock:
 	spin_unlock(ptl);
-	if (vm_shared || is_continue)
-		unlock_page(page);
+	unlock_page(page);
 out_release_nounlock:
-	if (!page_in_pagecache)
-		restore_reserve_on_error(h, dst_vma, dst_addr, page);
 	put_page(page);
 	goto out;
 }
-- 
2.32.0


--6BJDNHv8LiVvXy5W
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0002-selftests-vm-Use-memfd-for-hugetlb-tests.patch"

From 046ba2d1f5a74d86c6546a4f1bc8081f7c0fd3f8 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 29 Sep 2022 11:55:26 -0400
Subject: [PATCH 2/2] selftests/vm: Use memfd for hugetlb tests
Content-type: text/plain

We already used memfd for shmem test, move it forward with hugetlb too so
that we don't need user to specify the hugetlb file path explicitly when
running hugetlb shared tests.

More importantly, this patch will start to correctly release hugetlb pages
using fallocate(FALLOC_FL_PUNCH_HOLE) even for private mappings, because
for private mappings MADV_DONTNEED may not be enough to test UFFDIO_COPY
which only zap the pgtables but not evicting the page caches.

Here unfortunately we need to cache the ptr<->offset relationship for
hugetlb for using fallocate() by adding mem_fd_[src|dst]_offset, because
that's the only way to evict the page cache for private mappings.  IOW
MADV_REMOVE doesn't work.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 98 +++++++++++++-----------
 1 file changed, 53 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 74babdbc02e5..4561e9d443e4 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -93,10 +93,11 @@ static volatile bool test_uffdio_zeropage_eexist = true;
 static bool test_uffdio_wp = true;
 /* Whether to test uffd minor faults */
 static bool test_uffdio_minor = false;
-
 static bool map_shared;
-static int shm_fd;
-static int huge_fd;
+static int mem_fd;
+/* File offset for area_src/area_dst upon mem_fd.  Needed for hole punching */
+static off_t mem_fd_src_offset;
+static off_t mem_fd_dst_offset;
 static unsigned long long *count_verify;
 static int uffd = -1;
 static int uffd_flags, finished, *pipefd;
@@ -247,48 +248,59 @@ static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
 {
 }
 
+static off_t ptr_to_offset(char *ptr)
+{
+	if (ptr == area_src)
+		return mem_fd_src_offset;
+	else
+		return mem_fd_dst_offset;
+}
+
 static void hugetlb_release_pages(char *rel_area)
 {
+	off_t size = nr_pages * page_size, offset = ptr_to_offset(rel_area);
+
 	if (!map_shared) {
 		if (madvise(rel_area, nr_pages * page_size, MADV_DONTNEED))
 			err("madvise(MADV_DONTNEED) failed");
-	} else {
-		if (madvise(rel_area, nr_pages * page_size, MADV_REMOVE))
-			err("madvise(MADV_REMOVE) failed");
-	}
+
+		/* Evict page cache explibitly for private mappings */
+		if (fallocate(mem_fd,
+			      FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+			      offset, size))
+			err("fallocate(FALLOC_FL_PUNCH_HOLE) failed");
+       } else {
+               if (madvise(rel_area, nr_pages * page_size, MADV_REMOVE))
+                       err("madvise(MADV_REMOVE) failed");
+       }
 }
 
 static void hugetlb_allocate_area(void **alloc_area, bool is_src)
 {
+	off_t size = nr_pages * page_size;
+	off_t offset = is_src ? 0 : size;
 	void *area_alias = NULL;
 	char **alloc_area_alias;
 
-	if (!map_shared)
-		*alloc_area = mmap(NULL,
-			nr_pages * page_size,
-			PROT_READ | PROT_WRITE,
-			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB |
-				(is_src ? 0 : MAP_NORESERVE),
-			-1,
-			0);
-	else
-		*alloc_area = mmap(NULL,
-			nr_pages * page_size,
-			PROT_READ | PROT_WRITE,
-			MAP_SHARED |
-				(is_src ? 0 : MAP_NORESERVE),
-			huge_fd,
-			is_src ? 0 : nr_pages * page_size);
+	*alloc_area = mmap(NULL, size, PROT_READ | PROT_WRITE,
+			   (map_shared ? MAP_SHARED : MAP_PRIVATE) |
+			   (is_src ? 0 : MAP_NORESERVE),
+			   mem_fd, offset);
 	if (*alloc_area == MAP_FAILED)
 		err("mmap of hugetlbfs file failed");
 
+	/*
+	 * Only hugetlb needs to cache ptr<->offset because it needs to
+	 * fallocate(FALLOC_FL_PUNCH_HOLE).
+	 */
+	if (is_src)
+		mem_fd_src_offset = offset;
+	else
+		mem_fd_dst_offset = offset;
+
 	if (map_shared) {
-		area_alias = mmap(NULL,
-			nr_pages * page_size,
-			PROT_READ | PROT_WRITE,
-			MAP_SHARED,
-			huge_fd,
-			is_src ? 0 : nr_pages * page_size);
+		area_alias = mmap(NULL, size, PROT_READ | PROT_WRITE,
+				  MAP_SHARED, mem_fd, offset);
 		if (area_alias == MAP_FAILED)
 			err("mmap of hugetlb file alias failed");
 	}
@@ -334,14 +346,14 @@ static void shmem_allocate_area(void **alloc_area, bool is_src)
 	}
 
 	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
-			   shm_fd, offset);
+			   mem_fd, offset);
 	if (*alloc_area == MAP_FAILED)
 		err("mmap of memfd failed");
 	if (test_collapse && *alloc_area != p)
 		err("mmap of memfd failed at %p", p);
 
 	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
-			  shm_fd, offset);
+			  mem_fd, offset);
 	if (area_alias == MAP_FAILED)
 		err("mmap of memfd alias failed");
 	if (test_collapse && area_alias != p_alias)
@@ -1629,7 +1641,7 @@ static int userfaultfd_stress(void)
 
 		/* prepare next bounce */
 		swap(area_src, area_dst);
-
+		swap(mem_fd_src_offset, mem_fd_dst_offset);
 		swap(area_src_alias, area_dst_alias);
 
 		uffd_stats_report(uffd_stats, nr_cpus);
@@ -1821,21 +1833,17 @@ int main(int argc, char **argv)
 	}
 	nr_pages = nr_pages_per_cpu * nr_cpus;
 
-	if (test_type == TEST_HUGETLB && map_shared) {
-		if (argc < 5)
-			usage();
-		huge_fd = open(argv[4], O_CREAT | O_RDWR, 0755);
-		if (huge_fd < 0)
-			err("Open of %s failed", argv[4]);
-		if (ftruncate(huge_fd, 0))
-			err("ftruncate %s to size 0 failed", argv[4]);
-	} else if (test_type == TEST_SHMEM) {
-		shm_fd = memfd_create(argv[0], 0);
-		if (shm_fd < 0)
+	if (test_type == TEST_SHMEM || test_type == TEST_HUGETLB) {
+		unsigned int memfd_flags = 0;
+
+		if (test_type == TEST_HUGETLB)
+			memfd_flags = MFD_HUGETLB;
+		mem_fd = memfd_create(argv[0], memfd_flags);
+		if (mem_fd < 0)
 			err("memfd_create");
-		if (ftruncate(shm_fd, nr_pages * page_size * 2))
+		if (ftruncate(mem_fd, nr_pages * page_size * 2))
 			err("ftruncate");
-		if (fallocate(shm_fd,
+		if (fallocate(mem_fd,
 			      FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
 			      nr_pages * page_size * 2))
 			err("fallocate");
-- 
2.32.0


--6BJDNHv8LiVvXy5W--

