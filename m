Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16803685E13
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 04:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjBADmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 22:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBADmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 22:42:08 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82C52B2BF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 19:42:06 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso693587pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 19:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B9gFWLBbXJO+fTDUkJEhDE5AAFHtlij46AyAy+kzk8A=;
        b=GKVuK+BQJLSYEymgkJUxh8Dw/ZsSmcYWiU+b1qmS0eN3ZqS0imn5FW6nWzGfxgR/H9
         pHNj/GU92PlZQ+iwET4xzhDDJ0p86+k947xodsf/HUfh+yLx2IS5gQr22p7MHYPM5JmF
         D53waLbG7LDxKOFC/ZqzI4viIz+U6BeV+7rKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9gFWLBbXJO+fTDUkJEhDE5AAFHtlij46AyAy+kzk8A=;
        b=tXDlB+QmZ0XciMrhf5f2T/eu/I4i063Hstz8FbfDJS5VZ7hzn8b21CWo9W0ngnmWTV
         WghOSEkmmAjNrd8FvcnEZZTPsQ5/T2hnSKsoTWGmES0yknn3UzRfvVSgcefGaDb45VP2
         o8aXp2BkiCR/qUS8cj0PD2RfL08BvlYNrGJBpowIZpvEL8gI0H5k7Udd4ipu4V/rtmCT
         Vdu/1TaWayIl5xuZo/N319/POa6cuA1qT0eOeROOH7nJj/jmZyY/dn+xRUNo0Rrfd9Wq
         vRKUZs6+hAysWcSceLY0iRyyYsH+nYwmDyGrFNJdPNveNhYZGMEInD8D5GH3OZyj6xpp
         v+kQ==
X-Gm-Message-State: AO0yUKX1Sd0sTtxTDGWESN39Al8Fp7p4T019rQqBShlYJ5ZvUaDZObU/
        Yum6AOIdbmjH5qOqzvYw06mszuQw+Qc63R9q
X-Google-Smtp-Source: AK7set//Rgle2d/HSuclPsF6r6tDzpB8dTbPaMn3vTeq1onPvJg8TCuez/OhN4vx4gDSXr6Y3YpXIw==
X-Received: by 2002:a17:90a:30d:b0:22c:932:2870 with SMTP id 13-20020a17090a030d00b0022c09322870mr568622pje.33.1675222926348;
        Tue, 31 Jan 2023 19:42:06 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:e9a3:1082:396d:c1c1])
        by smtp.gmail.com with UTF8SMTPSA id l63-20020a639142000000b004d1d89ec63fsm9584677pge.6.2023.01.31.19.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 19:42:05 -0800 (PST)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH] mm/khugepaged: skip shmem with armed userfaultfd
Date:   Wed,  1 Feb 2023 12:41:37 +0900
Message-Id: <20230201034137.2463113-1-stevensd@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Collapsing memory in a vma that has an armed userfaultfd results in
zero-filling any missing pages, which breaks user-space paging for those
filled pages. Avoid khugepage bypassing userfaultfd by not collapsing
pages in shmem reached via scanning a vma with an armed userfaultfd if
doing so would zero-fill any pages.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 mm/khugepaged.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 79be13133322..48e944fb8972 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1736,8 +1736,8 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
  *    + restore gaps in the page cache;
  *    + unlock and free huge page;
  */
-static int collapse_file(struct mm_struct *mm, unsigned long addr,
-			 struct file *file, pgoff_t start,
+static int collapse_file(struct mm_struct *mm, struct vm_area_struct *vma,
+			 unsigned long addr, struct file *file, pgoff_t start,
 			 struct collapse_control *cc)
 {
 	struct address_space *mapping = file->f_mapping;
@@ -1784,6 +1784,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	 * be able to map it or use it in another way until we unlock it.
 	 */
 
+	if (is_shmem)
+		mmap_read_lock(mm);
+
 	xas_set(&xas, start);
 	for (index = start; index < end; index++) {
 		struct page *page = xas_next(&xas);
@@ -1792,6 +1795,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		VM_BUG_ON(index != xas.xa_index);
 		if (is_shmem) {
 			if (!page) {
+				if (userfaultfd_armed(vma)) {
+					result = SCAN_EXCEED_NONE_PTE;
+					goto xa_locked;
+				}
 				/*
 				 * Stop if extent has been truncated or
 				 * hole-punched, and is now completely
@@ -2095,6 +2102,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		hpage->mapping = NULL;
 	}
 
+	if (is_shmem)
+		mmap_read_unlock(mm);
 	if (hpage)
 		unlock_page(hpage);
 out:
@@ -2108,8 +2117,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	return result;
 }
 
-static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
-				    struct file *file, pgoff_t start,
+static int hpage_collapse_scan_file(struct mm_struct *mm, struct vm_area_struct *vma,
+				    unsigned long addr, struct file *file, pgoff_t start,
 				    struct collapse_control *cc)
 {
 	struct page *page = NULL;
@@ -2118,6 +2127,9 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 	int present, swap;
 	int node = NUMA_NO_NODE;
 	int result = SCAN_SUCCEED;
+	bool uffd_was_armed = userfaultfd_armed(vma);
+
+	mmap_read_unlock(mm);
 
 	present = 0;
 	swap = 0;
@@ -2193,13 +2205,16 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 	}
 	rcu_read_unlock();
 
+	if (uffd_was_armed && present < HPAGE_PMD_NR)
+		result = SCAN_EXCEED_SWAP_PTE;
+
 	if (result == SCAN_SUCCEED) {
 		if (cc->is_khugepaged &&
 		    present < HPAGE_PMD_NR - khugepaged_max_ptes_none) {
 			result = SCAN_EXCEED_NONE_PTE;
 			count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
 		} else {
-			result = collapse_file(mm, addr, file, start, cc);
+			result = collapse_file(mm, vma, addr, file, start, cc);
 		}
 	}
 
@@ -2207,8 +2222,8 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 	return result;
 }
 #else
-static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
-				    struct file *file, pgoff_t start,
+static int hpage_collapse_scan_file(struct mm_struct *mm, struct vm_area_struct *vma,
+				    unsigned long addr, struct file *file, pgoff_t start,
 				    struct collapse_control *cc)
 {
 	BUILD_BUG();
@@ -2304,8 +2319,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 				pgoff_t pgoff = linear_page_index(vma,
 						khugepaged_scan.address);
 
-				mmap_read_unlock(mm);
-				*result = hpage_collapse_scan_file(mm,
+				*result = hpage_collapse_scan_file(mm, vma,
 								   khugepaged_scan.address,
 								   file, pgoff, cc);
 				mmap_locked = false;
@@ -2656,9 +2670,8 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 			struct file *file = get_file(vma->vm_file);
 			pgoff_t pgoff = linear_page_index(vma, addr);
 
-			mmap_read_unlock(mm);
 			mmap_locked = false;
-			result = hpage_collapse_scan_file(mm, addr, file, pgoff,
+			result = hpage_collapse_scan_file(mm, vma, addr, file, pgoff,
 							  cc);
 			fput(file);
 		} else {
-- 
2.39.1.456.gfc5497dd1b-goog

