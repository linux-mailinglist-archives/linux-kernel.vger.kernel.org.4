Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268786ED660
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 22:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjDXU4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 16:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDXU4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 16:56:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2574659EF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:56:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b8f57401d2aso11004986276.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682369782; x=1684961782;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B+rpZnEiPYUK5J2wUxrSzfB7CVikqVXo+yeoAdEGQi0=;
        b=Ax0EdMCT8lYmhYX6rrXsZ6jt/9Y3vZBWSoYKf6LT4XUz+Yp8qOZ8QrJyUBoIIk7mhi
         5IOZqY9JYF7907iUR1eQxgNqcCzimtFllGX08GxlTYiGVXZA9Ieblsr65xmg7+tiMDJK
         Q6t3zQPo6cNITlXxZ8NnQB5oxEo+H/sytBXqVAlDTMmdnBBVt/mx8dvZCajyTKTsV+0t
         r3jkCOBnFWYU8+zCTTw6HieRWaJ77l/TaSi1a+lU05ucQWD7vOwLt0q0Dg6wdJgDnEZw
         wDT56S3kcBQ4Ry82e0croqI0i8DfbWpen+5HU7ILo2oDoCB/9eIanc9Qnc3k18Vz7afd
         dDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682369782; x=1684961782;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B+rpZnEiPYUK5J2wUxrSzfB7CVikqVXo+yeoAdEGQi0=;
        b=R0M9QNXXPyhCmThVK+PuKVHuJgjv/4H1jeDrwzFO6IQQJ3YyuFxOGTL0LZQvbjjOq/
         mGHdyKXgTAwmRrnbiYziwzeRHU0r5htdB9C5FVCPQjxXDSl3UAgXyp1y7Qa5/GYc9fS8
         qtqpOsE5KgbiUnibYwLNJc3mdAenGY96iDSr/yF2G9MOKDJwGvBhK+fTepnO7Gp70/sS
         ZW9hS/r0r8ac4PeaLNDWM81/hbEobSbeZqJnkeAQa+NF7mIl2LXZ3vdQL7g/kar3ATuR
         9NTQeL3F4L/JHVfSD535NbScYJdi/hIjPpLF2CvQTaTkfznQc7rq/vuaH8DrTIGHoTxa
         GEuw==
X-Gm-Message-State: AAQBX9c8zUnXBceRJ4Co3/o9/hu8apc9TpO8ft2ZBhKdE8ctGC6MojZf
        F1IPVd25iTDQMnvKAnkKlfE7Zt8eKbhDXg==
X-Google-Smtp-Source: AKy350a5qP1b/TSYqjkqqSpHr6c8w6XBYeiI+1g+0GnujCmrbmQsCQLEU0lRTn1dciDrMdWdeV2qKF6Bau+EYA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:d8c1:0:b0:b8e:e0db:5b9d with SMTP id
 p184-20020a25d8c1000000b00b8ee0db5b9dmr5586350ybg.12.1682369782460; Mon, 24
 Apr 2023 13:56:22 -0700 (PDT)
Date:   Mon, 24 Apr 2023 20:55:46 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230424205548.1935192-1-cmllamas@google.com>
Subject: [RFC PATCH 1/3] Revert "binder_alloc: add missing mmap_lock calls
 when using the VMA"
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

This reverts commit 44e602b4e52f70f04620bbbf4fe46ecb40170bde.

This caused a performance regression particularly when pages are getting
reclaimed. We don't need to acquire the mmap_lock to determine when the
binder buffer has been fully initialized. A subsequent patch will bring
back the lockless approach for this.

[cmllamas: resolved trivial conflicts with renaming of alloc->mm]

Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 55a3c3c2409f..92c814ec44fe 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -380,15 +380,12 @@ static struct binder_buffer *binder_alloc_new_buf_locked(
 	size_t size, data_offsets_size;
 	int ret;
 
-	mmap_read_lock(alloc->mm);
 	if (!binder_alloc_get_vma(alloc)) {
-		mmap_read_unlock(alloc->mm);
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
 				   alloc->pid);
 		return ERR_PTR(-ESRCH);
 	}
-	mmap_read_unlock(alloc->mm);
 
 	data_offsets_size = ALIGN(data_size, sizeof(void *)) +
 		ALIGN(offsets_size, sizeof(void *));
@@ -916,25 +913,17 @@ void binder_alloc_print_pages(struct seq_file *m,
 	 * Make sure the binder_alloc is fully initialized, otherwise we might
 	 * read inconsistent state.
 	 */
-
-	mmap_read_lock(alloc->mm);
-	if (binder_alloc_get_vma(alloc) == NULL) {
-		mmap_read_unlock(alloc->mm);
-		goto uninitialized;
-	}
-
-	mmap_read_unlock(alloc->mm);
-	for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
-		page = &alloc->pages[i];
-		if (!page->page_ptr)
-			free++;
-		else if (list_empty(&page->lru))
-			active++;
-		else
-			lru++;
+	if (binder_alloc_get_vma(alloc) != NULL) {
+		for (i = 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
+			page = &alloc->pages[i];
+			if (!page->page_ptr)
+				free++;
+			else if (list_empty(&page->lru))
+				active++;
+			else
+				lru++;
+		}
 	}
-
-uninitialized:
 	mutex_unlock(&alloc->mutex);
 	seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
 	seq_printf(m, "  pages high watermark: %zu\n", alloc->pages_high);
-- 
2.40.0.634.g4ca3ef3211-goog

