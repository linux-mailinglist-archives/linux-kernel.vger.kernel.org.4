Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537CB6F3538
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjEARue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjEARuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:50:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ED910C6
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 10:50:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-559d35837bbso54144037b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682963430; x=1685555430;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vjmy9npoFS1ltTIQSU6SYKXLbdap9UrmwfWM+Y2ixPk=;
        b=dZCcwJncaHug3B8HkBJA8I4rogyge1EVTo4b3P8k7VcTSJVpEkICoBGsnhmO7W+EaQ
         BIxtz97RUXIfYWYlU1CJsKlwqGVGZ7x+vS+3P/rfb8ANuZUjR7SbifV/F6aSBN5z7ZRt
         /AMQ4KNfWlhXtFlPUDhe7iDHC11AWgJzvh0HYI/QSVDj28sAvGrMcNoB1jrqM2PiCRxV
         MKWY+ho9Y/9MhG5dJ5YP+l84eWwLxXehtDV3C+sB45yhtiKFovPsBc0ojtZnWpwnmUO1
         OgbB8QClj+k71UJXHVn/U9WcLkhMORsNKUzA9GKVhmcWDmrnB5+OYkqWUJRZdkLT90UK
         DpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682963430; x=1685555430;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vjmy9npoFS1ltTIQSU6SYKXLbdap9UrmwfWM+Y2ixPk=;
        b=BsilZOOoLlkgaf5L8TRwYqLod7zmE88nRCfmPpYLrDiEB+xbxtKui2Rhvn84eE052T
         pOe6yBSzTCfniX9Gns3SQgvqqou0xpD8rjxFiBCmG2CMEr6twTt3Lgt0TJPQL+cNe7Xm
         imTpxXSg1PSGoLZ+djL/MfIMjMQOrlp5lxQxIoSFXKGTw25o9+xWOGaSdpOzxIImMvBZ
         qsPp8xz93J+798z2ruU7+roaDzl2mwl+fx782e0+4eZKTA44FBI7Og2hESkzv9kJ/lBV
         Q0jFN3rdZ9HLNQqLhfcVEOxi6Nudz2JVjMRjAkFWJEqmte1OOvT1WvRBh7OWBfmYCGAx
         8vkQ==
X-Gm-Message-State: AC+VfDy69IhJ9RyvZmrqrmWx6lT4npRUZeUxIWvKNHS4mS3nd+54/ce0
        55Gt05d3yaSr3L7D6OdzqsDPvKWzYh0=
X-Google-Smtp-Source: ACHHUZ64NZ3/9tsMewuAy2AdTfarKe08wL+z4DEH/85FRjs3ZEIBqL9XqLFWxrB85BCLpG0FPVBpKygFEUY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a81:9f09:0:b0:559:e830:60f1 with SMTP id
 s9-20020a819f09000000b00559e83060f1mr4687408ywn.8.1682963430249; Mon, 01 May
 2023 10:50:30 -0700 (PDT)
Date:   Mon,  1 May 2023 10:50:23 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501175025.36233-1-surenb@google.com>
Subject: [PATCH 1/3] mm: handle swap page faults under VMA lock if page is uncontended
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When page fault is handled under VMA lock protection, all swap page
faults are retried with mmap_lock because folio_lock_or_retry
implementation has to drop and reacquire mmap_lock if folio could
not be immediately locked.
Instead of retrying all swapped page faults, retry only when folio
locking fails.
Drivers implementing ops->migrate_to_ram might still rely on mmap_lock,
therefore fall back to mmap_lock in this case.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/filemap.c |  6 ++++++
 mm/memory.c  | 14 +++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a34abfe8c654..84f39114d4de 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1706,6 +1706,8 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
  *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
  *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
  *     which case mmap_lock is still held.
+ *     If flags had FAULT_FLAG_VMA_LOCK set, meaning the operation is performed
+ *     with VMA lock only, the VMA lock is still held.
  *
  * If neither ALLOW_RETRY nor KILLABLE are set, will always return true
  * with the folio locked and the mmap_lock unperturbed.
@@ -1713,6 +1715,10 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
 bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
 			 unsigned int flags)
 {
+	/* Can't do this if not holding mmap_lock */
+	if (flags & FAULT_FLAG_VMA_LOCK)
+		return false;
+
 	if (fault_flag_allow_retry_first(flags)) {
 		/*
 		 * CAUTION! In this case, mmap_lock is not released
diff --git a/mm/memory.c b/mm/memory.c
index f69fbc251198..41f45819a923 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3711,11 +3711,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!pte_unmap_same(vmf))
 		goto out;
 
-	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
-		ret = VM_FAULT_RETRY;
-		goto out;
-	}
-
 	entry = pte_to_swp_entry(vmf->orig_pte);
 	if (unlikely(non_swap_entry(entry))) {
 		if (is_migration_entry(entry)) {
@@ -3725,6 +3720,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			vmf->page = pfn_swap_entry_to_page(entry);
 			ret = remove_device_exclusive_entry(vmf);
 		} else if (is_device_private_entry(entry)) {
+			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+				/*
+				 * migrate_to_ram is not yet ready to operate
+				 * under VMA lock.
+				 */
+				ret |= VM_FAULT_RETRY;
+				goto out;
+			}
+
 			vmf->page = pfn_swap_entry_to_page(entry);
 			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					vmf->address, &vmf->ptl);
-- 
2.40.1.495.gc816e09b53d-goog

