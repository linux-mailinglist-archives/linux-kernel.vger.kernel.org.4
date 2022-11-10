Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F68624BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiKJUeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiKJUeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:34:12 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A918CE19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:34:11 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id g24so2517519plq.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVR4UIDOLtSWVj2wHASg+l8eU278cy2uXh7YL7xWXDs=;
        b=jvwY0/sPLLzNFezDxJxiAq9jV2WRqJVcvqwxzciGTTjg3WCIMG1H01qTV4qUwyR/Qn
         FmuSgtmAHhAA2+jFKhkYu7R/uV5Gb9MbRjMOkLUiXymhh/qWxEFqr7g2xUD0XvqHsKKE
         q5D76trwbkUvuBhknY999jdVYRprb0dfDIwqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVR4UIDOLtSWVj2wHASg+l8eU278cy2uXh7YL7xWXDs=;
        b=bC24Vc7x8T1E5ZyTR9oW3CI4kBNGzQz6/87QLN7gvcx9M8vUxjimTNjJ5ODnJ2Y3FS
         Jt7/06JB2rAZANxi/4njyz0YbPzQHjTvMeMDb6drmO8o/iT1/WAX0bCLfiHWc+N+opFr
         eqQYPrzvZ9jcCoYcwOiL8511nqgf566jI1v/1lNHYWy4aOkio7p1mbfIZolzNVIhEgAk
         FK8Ae+/50uSkAJO1WllZkHBoI4mXlQ1gsfGkiDE9QZ3IIDfOtNH1Pq+SFWtQr1NjjcwF
         q/sSW7qOsp/fqQfqv+7YpycN09sXUC0ptOvY7OEfgBtHugdc0tTiIvxMqC87t/tVPyFo
         zz+Q==
X-Gm-Message-State: ACrzQf09/Q/EMCZfLphyzsT2FsJKnuqLW1lrZsmfXGcdYCQEae2yMNpe
        nQvudPVKWpsIZJmfHX6P9xc84Q==
X-Google-Smtp-Source: AMsMyM4MISvHjZMMqXcCVPcKIfs/sqXdPc9WpI9R+izp93VuEkjms8Uq5icOhfqVC1TxPukiZ1Dmrg==
X-Received: by 2002:a17:902:f214:b0:186:b065:eedb with SMTP id m20-20020a170902f21400b00186b065eedbmr64183100plc.45.1668112451212;
        Thu, 10 Nov 2022 12:34:11 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (30.161.125.34.bc.googleusercontent.com. [34.125.161.30])
        by smtp.gmail.com with ESMTPSA id d207-20020a621dd8000000b0056be1581126sm67703pfd.143.2022.11.10.12.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 12:34:10 -0800 (PST)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, gregkh@linuxfoundation.org, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        brauner@kernel.org, cmllamas@google.com, surenb@google.com,
        arnd@arndb.de, masahiroy@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, hridya@google.com,
        smoreland@google.com
Cc:     kernel-team@android.com
Subject: [PATCH v2 1/1] binder: return pending info for frozen async txns
Date:   Thu, 10 Nov 2022 12:34:05 -0800
Message-Id: <20221110203405.611600-2-dualli@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221110203405.611600-1-dualli@chromium.org>
References: <20221110203405.611600-1-dualli@chromium.org>
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

From: Li Li <dualli@google.com>

An async transaction to a frozen process will still be successfully
put in the queue. But this pending async transaction won't be processed
until the target process is unfrozen at an unspecified time in the
future. Pass this important information back to the user space caller
by returning BR_TRANSACTION_PENDING.

Signed-off-by: Li Li <dualli@google.com>
---
 drivers/android/binder.c            | 31 +++++++++++++++++++++++------
 drivers/android/binder_internal.h   |  3 ++-
 include/uapi/linux/android/binder.h |  7 ++++++-
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 880224ec6abb..a798f6661488 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2728,7 +2728,10 @@ binder_find_outdated_transaction_ilocked(struct binder_transaction *t,
  *
  * Return:	0 if the transaction was successfully queued
  *		BR_DEAD_REPLY if the target process or thread is dead
- *		BR_FROZEN_REPLY if the target process or thread is frozen
+ *		BR_FROZEN_REPLY if the target process or thread is frozen and
+ *			the sync transaction was rejected
+ *		BR_TRANSACTION_PENDING if the target process is frozen and the
+ *			async transaction was successfully queued
  */
 static int binder_proc_transaction(struct binder_transaction *t,
 				    struct binder_proc *proc,
@@ -2738,6 +2741,7 @@ static int binder_proc_transaction(struct binder_transaction *t,
 	bool oneway = !!(t->flags & TF_ONE_WAY);
 	bool pending_async = false;
 	struct binder_transaction *t_outdated = NULL;
+	bool frozen = false;
 
 	BUG_ON(!node);
 	binder_node_lock(node);
@@ -2751,15 +2755,16 @@ static int binder_proc_transaction(struct binder_transaction *t,
 
 	binder_inner_proc_lock(proc);
 	if (proc->is_frozen) {
+		frozen = true;
 		proc->sync_recv |= !oneway;
 		proc->async_recv |= oneway;
 	}
 
-	if ((proc->is_frozen && !oneway) || proc->is_dead ||
+	if ((frozen && !oneway) || proc->is_dead ||
 			(thread && thread->is_dead)) {
 		binder_inner_proc_unlock(proc);
 		binder_node_unlock(node);
-		return proc->is_frozen ? BR_FROZEN_REPLY : BR_DEAD_REPLY;
+		return frozen ? BR_FROZEN_REPLY : BR_DEAD_REPLY;
 	}
 
 	if (!thread && !pending_async)
@@ -2770,7 +2775,7 @@ static int binder_proc_transaction(struct binder_transaction *t,
 	} else if (!pending_async) {
 		binder_enqueue_work_ilocked(&t->work, &proc->todo);
 	} else {
-		if ((t->flags & TF_UPDATE_TXN) && proc->is_frozen) {
+		if ((t->flags & TF_UPDATE_TXN) && frozen) {
 			t_outdated = binder_find_outdated_transaction_ilocked(t,
 									      &node->async_todo);
 			if (t_outdated) {
@@ -2807,6 +2812,9 @@ static int binder_proc_transaction(struct binder_transaction *t,
 		binder_stats_deleted(BINDER_STAT_TRANSACTION);
 	}
 
+	if (oneway && frozen)
+		return BR_TRANSACTION_PENDING;
+
 	return 0;
 }
 
@@ -3607,9 +3615,16 @@ static void binder_transaction(struct binder_proc *proc,
 	} else {
 		BUG_ON(target_node == NULL);
 		BUG_ON(t->buffer->async_transaction != 1);
-		binder_enqueue_thread_work(thread, tcomplete);
 		return_error = binder_proc_transaction(t, target_proc, NULL);
-		if (return_error)
+		/*
+		 * Let the caller know when async transaction reaches a frozen
+		 * process and is put in a pending queue, waiting for the target
+		 * process to be unfrozen.
+		 */
+		if (return_error == BR_TRANSACTION_PENDING)
+			tcomplete->type = BINDER_WORK_TRANSACTION_PENDING;
+		binder_enqueue_thread_work(thread, tcomplete);
+		if (return_error && return_error != BR_TRANSACTION_PENDING)
 			goto err_dead_proc_or_thread;
 	}
 	if (target_thread)
@@ -4440,10 +4455,13 @@ static int binder_thread_read(struct binder_proc *proc,
 			binder_stat_br(proc, thread, cmd);
 		} break;
 		case BINDER_WORK_TRANSACTION_COMPLETE:
+		case BINDER_WORK_TRANSACTION_PENDING:
 		case BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT: {
 			if (proc->oneway_spam_detection_enabled &&
 				   w->type == BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT)
 				cmd = BR_ONEWAY_SPAM_SUSPECT;
+			else if (w->type == BINDER_WORK_TRANSACTION_PENDING)
+				cmd = BR_TRANSACTION_PENDING;
 			else
 				cmd = BR_TRANSACTION_COMPLETE;
 			binder_inner_proc_unlock(proc);
@@ -6170,6 +6188,7 @@ static const char * const binder_return_strings[] = {
 	"BR_FAILED_REPLY",
 	"BR_FROZEN_REPLY",
 	"BR_ONEWAY_SPAM_SUSPECT",
+	"BR_TRANSACTION_PENDING"
 };
 
 static const char * const binder_command_strings[] = {
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index abe19d88c6ec..6c51325a826f 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -133,7 +133,7 @@ enum binder_stat_types {
 };
 
 struct binder_stats {
-	atomic_t br[_IOC_NR(BR_ONEWAY_SPAM_SUSPECT) + 1];
+	atomic_t br[_IOC_NR(BR_TRANSACTION_PENDING) + 1];
 	atomic_t bc[_IOC_NR(BC_REPLY_SG) + 1];
 	atomic_t obj_created[BINDER_STAT_COUNT];
 	atomic_t obj_deleted[BINDER_STAT_COUNT];
@@ -152,6 +152,7 @@ struct binder_work {
 	enum binder_work_type {
 		BINDER_WORK_TRANSACTION = 1,
 		BINDER_WORK_TRANSACTION_COMPLETE,
+		BINDER_WORK_TRANSACTION_PENDING,
 		BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT,
 		BINDER_WORK_RETURN_ERROR,
 		BINDER_WORK_NODE,
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index e72e4de8f452..c21b3b3eb4e4 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -450,7 +450,7 @@ enum binder_driver_return_protocol {
 
 	BR_FROZEN_REPLY = _IO('r', 18),
 	/*
-	 * The target of the last transaction (either a bcTRANSACTION or
+	 * The target of the last sync transaction (either a bcTRANSACTION or
 	 * a bcATTEMPT_ACQUIRE) is frozen.  No parameters.
 	 */
 
@@ -460,6 +460,11 @@ enum binder_driver_return_protocol {
 	 * asynchronous transaction makes the allocated async buffer size exceed
 	 * detection threshold.  No parameters.
 	 */
+
+	BR_TRANSACTION_PENDING = _IO('r', 20),
+	/*
+	 * The target of the last async transaction is frozen.  No parameters.
+	 */
 };
 
 enum binder_driver_command_protocol {
-- 
2.38.1.431.g37b22c650d-goog

