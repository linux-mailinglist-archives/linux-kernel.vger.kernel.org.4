Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECA063CE21
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 04:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiK3D61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 22:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiK3D6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:58:23 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B1469DD6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:58:22 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 69-20020a630148000000b00478118684c4so6768960pgb.20
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R/mDU43axoS4cq3JBulkYGaq85aE3ZaiGZq+FgpPg9E=;
        b=HzZeQKtPp3RncupxgwQWA517UvaRhsRSjgANwNpAnbELTwwwOjoMwaCTH4AN+1U4Yv
         v7dIQ7b9chzgrHjDAn6mbDVlviS0kYeVjq7yP+tOk7bCvxodggOXzt4A0onGwh5LqQi6
         ScJ/eXxgkNdt6Q6HD3VKezMCuloUjHjgUNQdqRjHsML2ZGccLKxY8cmKDU0kVcL0V0kM
         U4KYnQcpy/gq53NGCTPOn3YxWAcpznuK/J7RTuca6wpK2Cp8YiavTatAV7YGk5SaYBh7
         j+A3E+OiIH9RTMXYQ4P7lrd3xcXlPRpmhWwqYO7CLhc69eK04TX47ZhC2zGMZvBd41zo
         uAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/mDU43axoS4cq3JBulkYGaq85aE3ZaiGZq+FgpPg9E=;
        b=VjLkZ5GUTsPhV7FTLdmM82ExsckSQt1vWtLNqy7N+VR+YQHbd4yeqT2tx54BkPGhXZ
         0dkqTeyMcnAOi6FHjYxYGqmKZp0btQ3BVWZYr1anuhLsT7frG1GYqMOQurufoUqTqwTa
         1FS1a/APAaq7FdVv6Xooxrug8XVyUmV97pMDp5M+6OBrq984//Ad9058o8AmOsVfjtWp
         PYGOVuI1UmfhSFrDLC4WklSwq4etNYoXPdJ/ZEF/L4RaoIq3IIeQcpOOmruUfWHSPk4q
         eoroBdQFyvgDmQwUGJHScmcJcw+ruUVLsjxcw1Pha1b7qRJA7Bm/fgoKpZ1/nIwCyoQ8
         d5iA==
X-Gm-Message-State: ANoB5pmPqwZ7tVIDOX5eQMies4nfW13Y1wARx2kLy2jvD3/iMJdRumE/
        j4WlX8o7BN3rtbsm1bXOv83ASiDYGBcIwg==
X-Google-Smtp-Source: AA0mqf7iX+LjrY8qaURMRLX8GrSlfHlXDhbWLj/rYiNtfPv1lOK2lPXJNrczcWwoAVcFK1CAyNohelKbwjLXTA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90b:1942:b0:219:42d8:bd3a with SMTP
 id nk2-20020a17090b194200b0021942d8bd3amr10353630pjb.177.1669780701588; Tue,
 29 Nov 2022 19:58:21 -0800 (PST)
Date:   Wed, 30 Nov 2022 03:58:00 +0000
In-Reply-To: <20221130035805.1823970-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20221130035805.1823970-1-cmllamas@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221130035805.1823970-2-cmllamas@google.com>
Subject: [PATCH 5.10 1/6] binder: avoid potential data leakage when copying txn
From:   Carlos Llamas <cmllamas@google.com>
To:     stable@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Brian Swetland <swetland@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Carlos Llamas <cmllamas@google.com>,
        Greg Kroah-Hartman <gregkh@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Kjos <tkjos@google.com>

commit 6d98eb95b450a75adb4516a1d33652dc78d2b20c upstream.

Transactions are copied from the sender to the target
first and objects like BINDER_TYPE_PTR and BINDER_TYPE_FDA
are then fixed up. This means there is a short period where
the sender's version of these objects are visible to the
target prior to the fixups.

Instead of copying all of the data first, copy data only
after any needed fixups have been applied.

Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Reviewed-by: Martijn Coenen <maco@android.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Todd Kjos <tkjos@google.com>
Link: https://lore.kernel.org/r/20211130185152.437403-3-tkjos@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[cmllamas: fix trivial merge conflict]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 94 ++++++++++++++++++++++++++++++----------
 1 file changed, 70 insertions(+), 24 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index cfb1393a0891..58ab76b7a787 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2008,15 +2008,21 @@ static void binder_cleanup_transaction(struct binder_transaction *t,
 /**
  * binder_get_object() - gets object and checks for valid metadata
  * @proc:	binder_proc owning the buffer
+ * @u:		sender's user pointer to base of buffer
  * @buffer:	binder_buffer that we're parsing.
  * @offset:	offset in the @buffer at which to validate an object.
  * @object:	struct binder_object to read into
  *
- * Return:	If there's a valid metadata object at @offset in @buffer, the
+ * Copy the binder object at the given offset into @object. If @u is
+ * provided then the copy is from the sender's buffer. If not, then
+ * it is copied from the target's @buffer.
+ *
+ * Return:	If there's a valid metadata object at @offset, the
  *		size of that object. Otherwise, it returns zero. The object
  *		is read into the struct binder_object pointed to by @object.
  */
 static size_t binder_get_object(struct binder_proc *proc,
+				const void __user *u,
 				struct binder_buffer *buffer,
 				unsigned long offset,
 				struct binder_object *object)
@@ -2026,10 +2032,16 @@ static size_t binder_get_object(struct binder_proc *proc,
 	size_t object_size = 0;
 
 	read_size = min_t(size_t, sizeof(*object), buffer->data_size - offset);
-	if (offset > buffer->data_size || read_size < sizeof(*hdr) ||
-	    binder_alloc_copy_from_buffer(&proc->alloc, object, buffer,
-					  offset, read_size))
+	if (offset > buffer->data_size || read_size < sizeof(*hdr))
 		return 0;
+	if (u) {
+		if (copy_from_user(object, u + offset, read_size))
+			return 0;
+	} else {
+		if (binder_alloc_copy_from_buffer(&proc->alloc, object, buffer,
+						  offset, read_size))
+			return 0;
+	}
 
 	/* Ok, now see if we read a complete object. */
 	hdr = &object->hdr;
@@ -2102,7 +2114,7 @@ static struct binder_buffer_object *binder_validate_ptr(
 					  b, buffer_offset,
 					  sizeof(object_offset)))
 		return NULL;
-	object_size = binder_get_object(proc, b, object_offset, object);
+	object_size = binder_get_object(proc, NULL, b, object_offset, object);
 	if (!object_size || object->hdr.type != BINDER_TYPE_PTR)
 		return NULL;
 	if (object_offsetp)
@@ -2167,7 +2179,8 @@ static bool binder_validate_fixup(struct binder_proc *proc,
 		unsigned long buffer_offset;
 		struct binder_object last_object;
 		struct binder_buffer_object *last_bbo;
-		size_t object_size = binder_get_object(proc, b, last_obj_offset,
+		size_t object_size = binder_get_object(proc, NULL, b,
+						       last_obj_offset,
 						       &last_object);
 		if (object_size != sizeof(*last_bbo))
 			return false;
@@ -2282,7 +2295,7 @@ static void binder_transaction_buffer_release(struct binder_proc *proc,
 		if (!binder_alloc_copy_from_buffer(&proc->alloc, &object_offset,
 						   buffer, buffer_offset,
 						   sizeof(object_offset)))
-			object_size = binder_get_object(proc, buffer,
+			object_size = binder_get_object(proc, NULL, buffer,
 							object_offset, &object);
 		if (object_size == 0) {
 			pr_err("transaction release %d bad object at offset %lld, size %zd\n",
@@ -2848,6 +2861,7 @@ static void binder_transaction(struct binder_proc *proc,
 	binder_size_t off_start_offset, off_end_offset;
 	binder_size_t off_min;
 	binder_size_t sg_buf_offset, sg_buf_end_offset;
+	binder_size_t user_offset = 0;
 	struct binder_proc *target_proc = NULL;
 	struct binder_thread *target_thread = NULL;
 	struct binder_node *target_node = NULL;
@@ -2862,6 +2876,8 @@ static void binder_transaction(struct binder_proc *proc,
 	int t_debug_id = atomic_inc_return(&binder_last_id);
 	char *secctx = NULL;
 	u32 secctx_sz = 0;
+	const void __user *user_buffer = (const void __user *)
+				(uintptr_t)tr->data.ptr.buffer;
 
 	e = binder_transaction_log_add(&binder_transaction_log);
 	e->debug_id = t_debug_id;
@@ -3173,19 +3189,6 @@ static void binder_transaction(struct binder_proc *proc,
 	t->buffer->clear_on_free = !!(t->flags & TF_CLEAR_BUF);
 	trace_binder_transaction_alloc_buf(t->buffer);
 
-	if (binder_alloc_copy_user_to_buffer(
-				&target_proc->alloc,
-				t->buffer, 0,
-				(const void __user *)
-					(uintptr_t)tr->data.ptr.buffer,
-				tr->data_size)) {
-		binder_user_error("%d:%d got transaction with invalid data ptr\n",
-				proc->pid, thread->pid);
-		return_error = BR_FAILED_REPLY;
-		return_error_param = -EFAULT;
-		return_error_line = __LINE__;
-		goto err_copy_data_failed;
-	}
 	if (binder_alloc_copy_user_to_buffer(
 				&target_proc->alloc,
 				t->buffer,
@@ -3230,6 +3233,7 @@ static void binder_transaction(struct binder_proc *proc,
 		size_t object_size;
 		struct binder_object object;
 		binder_size_t object_offset;
+		binder_size_t copy_size;
 
 		if (binder_alloc_copy_from_buffer(&target_proc->alloc,
 						  &object_offset,
@@ -3241,8 +3245,27 @@ static void binder_transaction(struct binder_proc *proc,
 			return_error_line = __LINE__;
 			goto err_bad_offset;
 		}
-		object_size = binder_get_object(target_proc, t->buffer,
-						object_offset, &object);
+
+		/*
+		 * Copy the source user buffer up to the next object
+		 * that will be processed.
+		 */
+		copy_size = object_offset - user_offset;
+		if (copy_size && (user_offset > object_offset ||
+				binder_alloc_copy_user_to_buffer(
+					&target_proc->alloc,
+					t->buffer, user_offset,
+					user_buffer + user_offset,
+					copy_size))) {
+			binder_user_error("%d:%d got transaction with invalid data ptr\n",
+					proc->pid, thread->pid);
+			return_error = BR_FAILED_REPLY;
+			return_error_param = -EFAULT;
+			return_error_line = __LINE__;
+			goto err_copy_data_failed;
+		}
+		object_size = binder_get_object(target_proc, user_buffer,
+				t->buffer, object_offset, &object);
 		if (object_size == 0 || object_offset < off_min) {
 			binder_user_error("%d:%d got transaction with invalid offset (%lld, min %lld max %lld) or object.\n",
 					  proc->pid, thread->pid,
@@ -3254,6 +3277,11 @@ static void binder_transaction(struct binder_proc *proc,
 			return_error_line = __LINE__;
 			goto err_bad_offset;
 		}
+		/*
+		 * Set offset to the next buffer fragment to be
+		 * copied
+		 */
+		user_offset = object_offset + object_size;
 
 		hdr = &object.hdr;
 		off_min = object_offset + object_size;
@@ -3349,9 +3377,14 @@ static void binder_transaction(struct binder_proc *proc,
 			}
 			ret = binder_translate_fd_array(fda, parent, t, thread,
 							in_reply_to);
-			if (ret < 0) {
+			if (!ret)
+				ret = binder_alloc_copy_to_buffer(&target_proc->alloc,
+								  t->buffer,
+								  object_offset,
+								  fda, sizeof(*fda));
+			if (ret) {
 				return_error = BR_FAILED_REPLY;
-				return_error_param = ret;
+				return_error_param = ret > 0 ? -EINVAL : ret;
 				return_error_line = __LINE__;
 				goto err_translate_failed;
 			}
@@ -3421,6 +3454,19 @@ static void binder_transaction(struct binder_proc *proc,
 			goto err_bad_object_type;
 		}
 	}
+	/* Done processing objects, copy the rest of the buffer */
+	if (binder_alloc_copy_user_to_buffer(
+				&target_proc->alloc,
+				t->buffer, user_offset,
+				user_buffer + user_offset,
+				tr->data_size - user_offset)) {
+		binder_user_error("%d:%d got transaction with invalid data ptr\n",
+				proc->pid, thread->pid);
+		return_error = BR_FAILED_REPLY;
+		return_error_param = -EFAULT;
+		return_error_line = __LINE__;
+		goto err_copy_data_failed;
+	}
 	tcomplete->type = BINDER_WORK_TRANSACTION_COMPLETE;
 	t->work.type = BINDER_WORK_TRANSACTION;
 
-- 
2.38.1.584.g0f3c55d4c2-goog

