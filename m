Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CAA6F4B0E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjEBUMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEBUMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:12:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B661FE2
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 13:12:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7e76b32bso5335474276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683058354; x=1685650354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxjFQ3K/e3w2fi3vlktbb/W0MlBQT457KX1eDyfRC9Y=;
        b=xsqOvq8tW2JJmE0CQGqFwsr5wkv/acIKYPM2xEurXXyvDMSNIxNYvkeIT+6p+En05m
         a5AieWxpum8iBxJXyi6yXrM6iB7jFzYwDoXpLa/1DnyH0FXrHwhlADKR37ViSYIn6YIS
         h1yZxyXZyQLtyjMbQy+f/PoOevJTYw8pgDo9ViSr5KS15mv1NvJjVmfw+xrmyzdADkwo
         +WbLDDl71vtD5dIYr8ZDUbnEUjrdRn6e18XTQizc2uwXZN/xEgGWYuNnw2SayBID5sv6
         AzKSUKsvnyuQf2DO+ygnTzDw0zZWfNlzp+oakUhlTRRud/oLzJ2In8bWXVCSPmWYzlce
         TPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058354; x=1685650354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxjFQ3K/e3w2fi3vlktbb/W0MlBQT457KX1eDyfRC9Y=;
        b=YJNYL8mYkaFWx5NsKd+j6u7/2Ot0FBbS3Webew3KA3ftMNfrgkD4cjyg9cnmiEGzX6
         RSqyvTOtB2rVjJ4ssnQwNDfx+kE9BB7TEs7Fcq2HdavzCKf43sMIqHNWvc/QtU/EZ50U
         A5TiVEciMukYARBMEF2temhuqx8JgTNGXRCXnvLSMYxmK5LEOk5Yuq570H67kZP9wl9E
         f2WhyS3121BxvcmukZawI0TFYc+YJTiJohUeX1LiXVeDOusbU8tWRfW45dhULrX+rY0p
         vZ5krPnLMD/DjDdbtH15vEauMY1ZXFvf3K0ey5hz9Vx5rF8Lzslj/E3z6Blg0yhybmJf
         kY8g==
X-Gm-Message-State: AC+VfDzuyrqSTdba++gjFaG2OSJ0xhjVEx+w0+8uH1KBNorbtcMBgC6q
        N5Oq7DbcQl2f1n00IVPdsrd8+vEWbquc4Q==
X-Google-Smtp-Source: ACHHUZ7o8RkcrSEOjSM3cJhifgxCs7beiWhdUh8WCIXABu5JJep3dzShxb2EyRvRA+twSi7PmQOt6E9q8d0b+g==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:e710:0:b0:b8f:35c1:e63e with SMTP id
 e16-20020a25e710000000b00b8f35c1e63emr11506603ybh.6.1683058353588; Tue, 02
 May 2023 13:12:33 -0700 (PDT)
Date:   Tue,  2 May 2023 20:12:18 +0000
In-Reply-To: <20230502201220.1756319-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20230502201220.1756319-1-cmllamas@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502201220.1756319-2-cmllamas@google.com>
Subject: [PATCH 2/3] Revert "android: binder: stop saving a pointer to the VMA"
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Liam Howlett <liam.howlett@oracle.com>, stable@vger.kernel.org
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

Fixes: a43cfc87caaf ("android: binder: stop saving a pointer to the VMA")
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
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
2.40.1.495.gc816e09b53d-goog

