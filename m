Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602C96F7D3C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjEEGsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjEEGsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:48:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4B810C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 23:48:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a6f15287eso16185720276.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 23:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683269300; x=1685861300;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AYep1Ny0kQwWKACNqYvjEM8O17wY9ZF5ldxrC8z/e80=;
        b=5CVSJW65GZH+DA1CPql2ETYPAj170/fFgh/93JRG3f41dd2GhplzDeY/18lRRODlaA
         wiRfzAqpCeYftVLgW2O5jnTBO0tfZI5AOBIlX8n62F2O5pMqd00kOmhfKG2IE/mS2Fgx
         2ydbVjcj2bY+XfwUgwm4/n1izggbZ3neGQjWZWmArchNJ1+aFyRZ4PrJna2/SK+g2hH9
         Lq1nffobQOR6jZ5ksTlmoXE+/uGbnXZiSK0M7O6nMJCMK1K5CJlGXPG6x2EugIZEZgGm
         C8dIZer63iXSsyDyliZtcG/9acZht+q7gerrKmnOx1SY36EwusQcItXFw6suHvuu2+Pr
         WCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683269300; x=1685861300;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYep1Ny0kQwWKACNqYvjEM8O17wY9ZF5ldxrC8z/e80=;
        b=kpoBTHtKM8hD7j/ValDMhrsG8dnBJkaHsrPHsWk8jsqsSmZFyk07nhgGUW1RrUuCW9
         7zhBkfAUrVIquZmM2wSaBW/f77wyEfa9+YCtXHwxwpPgwwUX35Kww5N5HvwedxLGifYr
         EPWf4CTV4OtOnogPFmI2h5snQUy67fRyE4iZAvAX2gQ+nbpwvyYJfBUxDl7ptt6YUBaU
         5H61h07VGlK6uGw8WmJ+IeK9CNEAUuI5DiMmqXPBI8qzXXz/gM1iKEwdhNYNIvFZBiGP
         igpiqGQkNzI4GCdaVsjyBgaQiPLHoq4p2sJtKrBrUNjGaHMK3krcM11ZrfPRdQkzUjq8
         rBhQ==
X-Gm-Message-State: AC+VfDydmoLaAiDEaAq/6VelITFiMCoWZB4yGXqGDQ9edvfPnYk4CihK
        KRQpA+AGoDMKKp62O8nHjteZIKnx3x4NZA==
X-Google-Smtp-Source: ACHHUZ7l61qDV2B6jFlru5dKX380CQIBKUnZbFrfS/02oUgqBmWi7AhTxsdFrijzinhJv7L/5fbTBA5BePNpMw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:10c:b0:55c:a5db:869 with SMTP id
 bd12-20020a05690c010c00b0055ca5db0869mr3497779ywb.4.1683269300306; Thu, 04
 May 2023 23:48:20 -0700 (PDT)
Date:   Fri,  5 May 2023 06:48:10 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230505064811.2982849-1-cmllamas@google.com>
Subject: [PATCH] binder: fix UAF caused by faulty buffer cleanup
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
        Zi Fan Tan <zifantan@google.com>, stable@vger.kernel.org,
        Todd Kjos <tkjos@google.com>
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

In binder_transaction_buffer_release() the 'failed_at' offset indicates
the number of objects to clean up. However, this function was changed by
commit 44d8047f1d87 ("binder: use standard functions to allocate fds"),
to release all the objects in the buffer when 'failed_at' is zero.

This introduced an issue when a transaction buffer is released without
any objects having been processed so far. In this case, 'failed_at' is
indeed zero yet it is misinterpreted as releasing the entire buffer.

This leads to use-after-free errors where nodes are incorrectly freed
and subsequently accessed. Such is the case in the following KASAN
report:

  ==================================================================
  BUG: KASAN: slab-use-after-free in binder_thread_read+0xc40/0x1f30
  Read of size 8 at addr ffff4faf037cfc58 by task poc/474

  CPU: 6 PID: 474 Comm: poc Not tainted 6.3.0-12570-g7df047b3f0aa #5
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   dump_backtrace+0x94/0xec
   show_stack+0x18/0x24
   dump_stack_lvl+0x48/0x60
   print_report+0xf8/0x5b8
   kasan_report+0xb8/0xfc
   __asan_load8+0x9c/0xb8
   binder_thread_read+0xc40/0x1f30
   binder_ioctl+0xd9c/0x1768
   __arm64_sys_ioctl+0xd4/0x118
   invoke_syscall+0x60/0x188
  [...]

  Allocated by task 474:
   kasan_save_stack+0x3c/0x64
   kasan_set_track+0x2c/0x40
   kasan_save_alloc_info+0x24/0x34
   __kasan_kmalloc+0xb8/0xbc
   kmalloc_trace+0x48/0x5c
   binder_new_node+0x3c/0x3a4
   binder_transaction+0x2b58/0x36f0
   binder_thread_write+0x8e0/0x1b78
   binder_ioctl+0x14a0/0x1768
   __arm64_sys_ioctl+0xd4/0x118
   invoke_syscall+0x60/0x188
  [...]

  Freed by task 475:
   kasan_save_stack+0x3c/0x64
   kasan_set_track+0x2c/0x40
   kasan_save_free_info+0x38/0x5c
   __kasan_slab_free+0xe8/0x154
   __kmem_cache_free+0x128/0x2bc
   kfree+0x58/0x70
   binder_dec_node_tmpref+0x178/0x1fc
   binder_transaction_buffer_release+0x430/0x628
   binder_transaction+0x1954/0x36f0
   binder_thread_write+0x8e0/0x1b78
   binder_ioctl+0x14a0/0x1768
   __arm64_sys_ioctl+0xd4/0x118
   invoke_syscall+0x60/0x188
  [...]
  ==================================================================

In order to avoid these issues, let's always calculate the intended
'failed_at' offset beforehand. This is wrapped in a helper function to
make it clear and convenient.

Fixes: 32e9f56a96d8 ("binder: don't detect sender/target during buffer cleanup")
Reported-by: Zi Fan Tan <zifantan@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index fb56bfc45096..6678a862ea84 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1938,7 +1938,7 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 					      bool is_failure)
 {
 	int debug_id = buffer->debug_id;
-	binder_size_t off_start_offset, buffer_offset, off_end_offset;
+	binder_size_t off_start_offset, buffer_offset;
 
 	binder_debug(BINDER_DEBUG_TRANSACTION,
 		     "%d buffer release %d, size %zd-%zd, failed at %llx\n",
@@ -1950,9 +1950,8 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 		binder_dec_node(buffer->target_node, 1, 0);
 
 	off_start_offset = ALIGN(buffer->data_size, sizeof(void *));
-	off_end_offset = is_failure && failed_at ? failed_at :
-				off_start_offset + buffer->offsets_size;
-	for (buffer_offset = off_start_offset; buffer_offset < off_end_offset;
+
+	for (buffer_offset = off_start_offset; buffer_offset < failed_at;
 	     buffer_offset += sizeof(binder_size_t)) {
 		struct binder_object_header *hdr;
 		size_t object_size = 0;
@@ -2111,6 +2110,25 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 	}
 }
 
+/* Clean up all the objects in the buffer */
+static inline void binder_release_entire_buffer(struct binder_proc *proc,
+						struct binder_thread *thread,
+						struct binder_buffer *buffer,
+						bool is_failure)
+{
+	binder_size_t off_end_offset;
+
+	off_end_offset = ALIGN(buffer->data_size, sizeof(void *));
+	off_end_offset += buffer->offsets_size;
+
+	/* We always pass the end of the buffer here to make sure that
+	 * binder_transaction_buffer_release() loops through all the
+	 * objects in the buffer.
+	 */
+	binder_transaction_buffer_release(proc, thread, buffer,
+					  off_end_offset, is_failure);
+}
+
 static int binder_translate_binder(struct flat_binder_object *fp,
 				   struct binder_transaction *t,
 				   struct binder_thread *thread)
@@ -2806,7 +2824,7 @@ static int binder_proc_transaction(struct binder_transaction *t,
 		t_outdated->buffer = NULL;
 		buffer->transaction = NULL;
 		trace_binder_transaction_update_buffer_release(buffer);
-		binder_transaction_buffer_release(proc, NULL, buffer, 0, 0);
+		binder_release_entire_buffer(proc, NULL, buffer, false);
 		binder_alloc_free_buf(&proc->alloc, buffer);
 		kfree(t_outdated);
 		binder_stats_deleted(BINDER_STAT_TRANSACTION);
@@ -3775,7 +3793,7 @@ binder_free_buf(struct binder_proc *proc,
 		binder_node_inner_unlock(buf_node);
 	}
 	trace_binder_transaction_buffer_release(buffer);
-	binder_transaction_buffer_release(proc, thread, buffer, 0, is_failure);
+	binder_release_entire_buffer(proc, thread, buffer, is_failure);
 	binder_alloc_free_buf(&proc->alloc, buffer);
 }
 
-- 
2.40.1.521.gf1e218fcd8-goog

