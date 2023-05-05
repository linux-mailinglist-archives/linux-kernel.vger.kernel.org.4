Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378AF6F8A2C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjEEUa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjEEUa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:30:27 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2DF40FB
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 13:30:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-55a7d1f6914so39500757b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 13:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683318625; x=1685910625;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u49N1WE91RjKtWnFkziisD2DY9qwqmVaBlv12v/gn1Y=;
        b=vNatYaiiBa4/4TgvUJ3HRW53R8r3fJLH9ryq5X57wj0DbPIIqjbv2guK4YJ+49Vkqi
         mpw6pwMLloURoTHu3mkHdGe/DAwatmm9usqI6A0+VsqhUX9Xv+59JuuXlAgFan5YacXW
         1cJq/tj1bbnNm4T4Lh4oz47szSKsu+qowlj6PyZSJD/CvOJVjbjFoJ13eqcZRVrpsCaC
         Oc6Jqh2qSSl4FTRAY0BaXtMMSiU0OC2S2U/GSSptWXI2fMrOfOkDZy881QkKNzvkf/Qr
         d80J7VuVNvamLt8npkFcjJYB2xA5WcyiPsgMmVexNuBPTvYd1FmQs9TaKuwW9EXEIsbA
         UWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683318625; x=1685910625;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u49N1WE91RjKtWnFkziisD2DY9qwqmVaBlv12v/gn1Y=;
        b=hUpoTBXwCrMNwEPGVNZq9OCd+C7jqZIWCrV+ncy0Xc68pMAGo5hY+bl++BxYTmqtk1
         Fceq6LoT83a+nYB3/aKoDX7rj5UCVHyVr9wJOJjGK3+m2NOzgl96XHYoyHNiaFfelRDf
         CkFcdb45m0SskYWF+Aa1fLHXw5dnGyLgi0i0zIbBIbKH0YWsbV737LWA8sWMZc+PAK/y
         ezSl2SYhEglBJXGu+EVox2tb9y+K8f1skUTFNXqsxtHgGLqedzEY2duEmeEQKSYuX3y4
         xSf96E6JMQEdPEbe8wNudYjGe+W3uMxXLYDd3KF5v3TxEnoMDKw1i3h4goNJIPklPEP/
         lQaQ==
X-Gm-Message-State: AC+VfDw5Djme1v1U/0A1Uo5J4F0Z8dXybe+omWIgp02IDBJGsQxK6c6n
        rxL/rSr+L8RmBFnCuyznQ4Q3vy3lE9ANjg==
X-Google-Smtp-Source: ACHHUZ57Nsy18pbRkdwZx/cFlryyGclk2YcU7DfFS7Ie73RMKLvApAmGlNXKOblNv3SvqIjkHxWzF7V/yK+TsQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a81:af54:0:b0:555:c893:cc9d with SMTP id
 x20-20020a81af54000000b00555c893cc9dmr1643508ywj.4.1683318625434; Fri, 05 May
 2023 13:30:25 -0700 (PDT)
Date:   Fri,  5 May 2023 20:30:20 +0000
In-Reply-To: <20230505064811.2982849-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20230505064811.2982849-1-cmllamas@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230505203020.4101154-1-cmllamas@google.com>
Subject: [PATCH v2] binder: fix UAF caused by faulty buffer cleanup
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
'failed_at' offset beforehand. This is renamed and wrapped in a helper
function to make it clear and convenient.

Fixes: 32e9f56a96d8 ("binder: don't detect sender/target during buffer cleanup")
Reported-by: Zi Fan Tan <zifantan@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
v2: rename 'failed_at' to 'off_end_offsets' and drop the now unecessary
    comments after the rename per Todd's feedback.

 drivers/android/binder.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index fb56bfc45096..8fb7672021ee 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1934,24 +1934,23 @@ static void binder_deferred_fd_close(int fd)
 static void binder_transaction_buffer_release(struct binder_proc *proc,
 					      struct binder_thread *thread,
 					      struct binder_buffer *buffer,
-					      binder_size_t failed_at,
+					      binder_size_t off_end_offset,
 					      bool is_failure)
 {
 	int debug_id = buffer->debug_id;
-	binder_size_t off_start_offset, buffer_offset, off_end_offset;
+	binder_size_t off_start_offset, buffer_offset;
 
 	binder_debug(BINDER_DEBUG_TRANSACTION,
 		     "%d buffer release %d, size %zd-%zd, failed at %llx\n",
 		     proc->pid, buffer->debug_id,
 		     buffer->data_size, buffer->offsets_size,
-		     (unsigned long long)failed_at);
+		     (unsigned long long)off_end_offset);
 
 	if (buffer->target_node)
 		binder_dec_node(buffer->target_node, 1, 0);
 
 	off_start_offset = ALIGN(buffer->data_size, sizeof(void *));
-	off_end_offset = is_failure && failed_at ? failed_at :
-				off_start_offset + buffer->offsets_size;
+
 	for (buffer_offset = off_start_offset; buffer_offset < off_end_offset;
 	     buffer_offset += sizeof(binder_size_t)) {
 		struct binder_object_header *hdr;
@@ -2111,6 +2110,21 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
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
+	binder_transaction_buffer_release(proc, thread, buffer,
+					  off_end_offset, is_failure);
+}
+
 static int binder_translate_binder(struct flat_binder_object *fp,
 				   struct binder_transaction *t,
 				   struct binder_thread *thread)
@@ -2806,7 +2820,7 @@ static int binder_proc_transaction(struct binder_transaction *t,
 		t_outdated->buffer = NULL;
 		buffer->transaction = NULL;
 		trace_binder_transaction_update_buffer_release(buffer);
-		binder_transaction_buffer_release(proc, NULL, buffer, 0, 0);
+		binder_release_entire_buffer(proc, NULL, buffer, false);
 		binder_alloc_free_buf(&proc->alloc, buffer);
 		kfree(t_outdated);
 		binder_stats_deleted(BINDER_STAT_TRANSACTION);
@@ -3775,7 +3789,7 @@ binder_free_buf(struct binder_proc *proc,
 		binder_node_inner_unlock(buf_node);
 	}
 	trace_binder_transaction_buffer_release(buffer);
-	binder_transaction_buffer_release(proc, thread, buffer, 0, is_failure);
+	binder_release_entire_buffer(proc, thread, buffer, is_failure);
 	binder_alloc_free_buf(&proc->alloc, buffer);
 }
 
-- 
2.40.1.521.gf1e218fcd8-goog

