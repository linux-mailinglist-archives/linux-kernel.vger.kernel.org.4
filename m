Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBCF6ED662
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 22:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjDXU4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 16:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjDXU4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 16:56:31 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B3F6EBB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:56:27 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-63b27afef94so5986212b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682369787; x=1684961787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ADZiPMV7kfxDbFL72Ucg55MMg3IA8yugLYxgHtNcXF8=;
        b=gnSp+kTU0zeTn3bsrhh+oonUq3iGT3bgPuifsWydRyoLzPBfgLF327oySZ4NajfIjY
         ziHhqcDe51TsHZMjGQqP1OJAcAOfoQi+spTceZdcg/Cs5Npc+k3f+G2QqxSZUeruSSYr
         jecEnJso3VgjqZSq5TYfWrIh1hwl5ziEekkISIUr1lpDpmEi9o/QEdBFdFEIhYrAPrw9
         JEuTe3HHm+h1VLg4oKotpiCpL90vdHjTnj5F3CYToUoiqhUIjgi3OrgSpd15pnZU1Vor
         DAHkhOgYEeygnj03d9VMOXfe+aTnmdPYl2avp0g/yBJ5Kj6bnPC8VRm1mBqqpMnATTDd
         JonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682369787; x=1684961787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADZiPMV7kfxDbFL72Ucg55MMg3IA8yugLYxgHtNcXF8=;
        b=knwpqRTK7Ek9e/i6l+KG05Y8ku7Drk/ctsSpb5l/s2pRIgpkevI4hx41pLS8EauJfx
         MVXd8g0OqoCqzQk2JCELsl34Bd/abDyyr1+Z+plmo54Cy9/5QECEnbM8c/cvEO1gNkzA
         GlZoygRZPkdMPQWcBndfxKCTnygY0cwCaR45mg2LD/WJuDVWylayPKNz9ynSFAdqriN4
         eyz1urkCF3+17UahusJ6j5MbKkJTW8iWyhqioJieDLALackbx8zURY3lMo9snPc7IEFI
         +s7JKpdiNEMwNaf/qYjPWDdUViwMWYOVQxmjHO+AW5yodK02L5+EElu9pp9GxL1Pj18E
         0uFw==
X-Gm-Message-State: AAQBX9dq1R8dWeIpKGFyvmVpIr+WnaKWy7cV+H5gTqGmZLGH3YpmzTbN
        Fg/vQHB65Y0j6pyMQSruxkicUlZrFvNpLQ==
X-Google-Smtp-Source: AKy350Z3hYLzMm14deUODamREau7SOfCblipcgR1UQDlM5qNYYuy+d2pzJ0Gng9PwCM9q3C/DDRoivtDHLnNrA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:17a2:b0:63d:4598:ff1e with SMTP
 id s34-20020a056a0017a200b0063d4598ff1emr6491809pfg.3.1682369787144; Mon, 24
 Apr 2023 13:56:27 -0700 (PDT)
Date:   Mon, 24 Apr 2023 20:55:47 +0000
In-Reply-To: <20230424205548.1935192-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20230424205548.1935192-1-cmllamas@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230424205548.1935192-2-cmllamas@google.com>
Subject: [RFC PATCH 2/3] Revert "android: binder: stop saving a pointer to the VMA"
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Liam Howlett <liam.howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a43cfc87caaf46710c8027a8c23b8a55f1078f19.

This patch fixed an issue reported by syzkaller in [1]. However, this
turned out to be only a band-aid in binder. The root cause, as bisected
by syzkaller, was fixed by commit 5789151e48ac ("mm/mmap: undo ->mmap()
when mas_preallocate() fails"). We no longer need the patch for binder.

Reverting such patch allows us to have a lockless access to alloc->vma
in specific cases where the mmap_lock is not required. This approach
avoids the contention that caused a performance regression.

[1] https://lore.kernel.org/all/0000000000004a0dbe05e1d749e0@google.com

[cmllamas: resolved conflicts with rework of alloc->mm and removal of
 binder_alloc_set_vma() also fixed comment section]

Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c          | 17 +++++++++--------
 drivers/android/binder_alloc.h          |  4 ++--
 drivers/android/binder_alloc_selftest.c |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 92c814ec44fe..eb082b33115b 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -213,7 +213,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 
 	if (mm) {
 		mmap_read_lock(mm);
-		vma = vma_lookup(mm, alloc->vma_addr);
+		vma = alloc->vma;
 	}
 
 	if (!vma && need_mm) {
@@ -314,9 +314,11 @@ static inline struct vm_area_struct *binder_alloc_get_vma(
 {
 	struct vm_area_struct *vma = NULL;
 
-	if (alloc->vma_addr)
-		vma = vma_lookup(alloc->mm, alloc->vma_addr);
-
+	if (alloc->vma) {
+		/* Look at description in binder_alloc_set_vma */
+		smp_rmb();
+		vma = alloc->vma;
+	}
 	return vma;
 }
 
@@ -775,7 +777,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	buffer->free = 1;
 	binder_insert_free_buffer(alloc, buffer);
 	alloc->free_async_space = alloc->buffer_size / 2;
-	alloc->vma_addr = vma->vm_start;
+	alloc->vma = vma;
 
 	return 0;
 
@@ -805,8 +807,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 
 	buffers = 0;
 	mutex_lock(&alloc->mutex);
-	BUG_ON(alloc->vma_addr &&
-	       vma_lookup(alloc->mm, alloc->vma_addr));
+	BUG_ON(alloc->vma);
 
 	while ((n = rb_first(&alloc->allocated_buffers))) {
 		buffer = rb_entry(n, struct binder_buffer, rb_node);
@@ -958,7 +959,7 @@ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
  */
 void binder_alloc_vma_close(struct binder_alloc *alloc)
 {
-	alloc->vma_addr = 0;
+	alloc->vma = 0;
 }
 
 /**
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 0f811ac4bcff..138d1d5af9ce 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -75,7 +75,7 @@ struct binder_lru_page {
 /**
  * struct binder_alloc - per-binder proc state for binder allocator
  * @mutex:              protects binder_alloc fields
- * @vma_addr:           vm_area_struct->vm_start passed to mmap_handler
+ * @vma:                vm_area_struct passed to mmap_handler
  *                      (invariant after mmap)
  * @mm:                 copy of task->mm (invariant after open)
  * @buffer:             base of per-proc address space mapped via mmap
@@ -99,7 +99,7 @@ struct binder_lru_page {
  */
 struct binder_alloc {
 	struct mutex mutex;
-	unsigned long vma_addr;
+	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	void __user *buffer;
 	struct list_head buffers;
diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index 43a881073a42..c2b323bc3b3a 100644
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -287,7 +287,7 @@ void binder_selftest_alloc(struct binder_alloc *alloc)
 	if (!binder_selftest_run)
 		return;
 	mutex_lock(&binder_selftest_lock);
-	if (!binder_selftest_run || !alloc->vma_addr)
+	if (!binder_selftest_run || !alloc->vma)
 		goto done;
 	pr_info("STARTED\n");
 	binder_selftest_alloc_offset(alloc, end_offset, 0);
-- 
2.40.0.634.g4ca3ef3211-goog

