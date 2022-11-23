Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B83F636ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbiKWUSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbiKWURH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:17:07 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C318C087
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:17:00 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id f9so13484170pgf.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2u8LyoWpuGJKs90W/isntEUifUyrzn4HqkGt/n722dY=;
        b=TWKVCf+AkXePti1g5nvWc+GxZvx4Q3gcHLZbmuN2LaFEg0QZboh8qbWyjfHkZb7pnO
         Xr5iohtHAofTYt6e+rkqqExFKaLAEmQqO/K7mLSRhQLYxB04dNNZbP7AzzggY7YIdP1g
         VeeK2soLJ3pclH1ix+EoY8sygCc5juLdETV40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2u8LyoWpuGJKs90W/isntEUifUyrzn4HqkGt/n722dY=;
        b=wSo2jtCxoBjZBsxQ+a/NFmz6Axkf4NumPi14oLEp6Btw0Z7NegyuhiGZrheSCRPnCU
         W5KroPf+38oX3tOkOEJk14BJffMi7J7GL1UaMH/fTkoNbRk2TccpvkaD3v3ZNoyU/cqr
         39B2Hpzadmm3CYta+ZRRO4udS91LnprDWdumQycae/zpVRSj48Z5IOz/XyamG6XTnGAA
         oF0KIAC0HI/SIIPQqPWf0nz4c/83dk7UCRKOtVxU5PhcvJftYRESXP7BfEKjJoHYgOi8
         5k544JR51yB+Z71Y4Vx6IuRlbKwnEsUNLr3DohX2MSS1qDyOJRwdCC9XTMjYXgovmpv3
         tAgA==
X-Gm-Message-State: ANoB5pkoWvhVD7/881i9B6+a73h+BMnCaZE3Fm1FuPfl/m+dpeDD7EPy
        y+uQubpH5kT+p+vlcBB8Zo88ng==
X-Google-Smtp-Source: AA0mqf5CM6t5V033kYFIoUizZyVgDnqL4DZ9YSOTiUWkHBHYjB1a8j5JXatH6UXmtSYIw1NQlOYdiQ==
X-Received: by 2002:aa7:92c7:0:b0:574:39dd:f162 with SMTP id k7-20020aa792c7000000b0057439ddf162mr6022060pfa.44.1669234620229;
        Wed, 23 Nov 2022 12:17:00 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (30.161.125.34.bc.googleusercontent.com. [34.125.161.30])
        by smtp.gmail.com with ESMTPSA id 85-20020a621958000000b0056b4c5dde61sm13474210pfz.98.2022.11.23.12.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 12:16:59 -0800 (PST)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, gregkh@linuxfoundation.org, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        brauner@kernel.org, cmllamas@google.com, surenb@google.com,
        arnd@arndb.de, masahiroy@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, hridya@google.com,
        smoreland@google.com
Cc:     kernel-team@android.com
Subject: [PATCH v3 1/1] binder: return pending info for frozen async txns
Date:   Wed, 23 Nov 2022 12:16:54 -0800
Message-Id: <20221123201654.589322-2-dualli@chromium.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221123201654.589322-1-dualli@chromium.org>
References: <20221123201654.589322-1-dualli@chromium.org>
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
by returning BR_TRANSACTION_PENDING_FROZEN.

Signed-off-by: Li Li <dualli@google.com>
---
 drivers/android/binder.c            | 32 +++++++++++++++++++++++------
 drivers/android/binder_internal.h   |  3 ++-
 include/uapi/linux/android/binder.h |  7 ++++++-
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 880224ec6abb..acd53147d5d1 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2728,7 +2728,10 @@ binder_find_outdated_transaction_ilocked(struct binder_transaction *t,
  *
  * Return:	0 if the transaction was successfully queued
  *		BR_DEAD_REPLY if the target process or thread is dead
- *		BR_FROZEN_REPLY if the target process or thread is frozen
+ *		BR_FROZEN_REPLY if the target process or thread is frozen and
+ *			the sync transaction was rejected
+ *		BR_TRANSACTION_PENDING_FROZEN if the target process is frozen
+ *		and the async transaction was successfully queued
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
+		return BR_TRANSACTION_PENDING_FROZEN;
+
 	return 0;
 }
 
@@ -3607,9 +3615,17 @@ static void binder_transaction(struct binder_proc *proc,
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
+		if (return_error == BR_TRANSACTION_PENDING_FROZEN)
+			tcomplete->type = BINDER_WORK_TRANSACTION_PENDING;
+		binder_enqueue_thread_work(thread, tcomplete);
+		if (return_error &&
+		    return_error != BR_TRANSACTION_PENDING_FROZEN)
 			goto err_dead_proc_or_thread;
 	}
 	if (target_thread)
@@ -4440,10 +4456,13 @@ static int binder_thread_read(struct binder_proc *proc,
 			binder_stat_br(proc, thread, cmd);
 		} break;
 		case BINDER_WORK_TRANSACTION_COMPLETE:
+		case BINDER_WORK_TRANSACTION_PENDING:
 		case BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT: {
 			if (proc->oneway_spam_detection_enabled &&
 				   w->type == BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT)
 				cmd = BR_ONEWAY_SPAM_SUSPECT;
+			else if (w->type == BINDER_WORK_TRANSACTION_PENDING)
+				cmd = BR_TRANSACTION_PENDING_FROZEN;
 			else
 				cmd = BR_TRANSACTION_COMPLETE;
 			binder_inner_proc_unlock(proc);
@@ -6170,6 +6189,7 @@ static const char * const binder_return_strings[] = {
 	"BR_FAILED_REPLY",
 	"BR_FROZEN_REPLY",
 	"BR_ONEWAY_SPAM_SUSPECT",
+	"BR_TRANSACTION_PENDING_FROZEN"
 };
 
 static const char * const binder_command_strings[] = {
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index abe19d88c6ec..28ef5b3704b1 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -133,7 +133,7 @@ enum binder_stat_types {
 };
 
 struct binder_stats {
-	atomic_t br[_IOC_NR(BR_ONEWAY_SPAM_SUSPECT) + 1];
+	atomic_t br[_IOC_NR(BR_TRANSACTION_PENDING_FROZEN) + 1];
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
index e72e4de8f452..5f636b5afcd7 100644
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
+	BR_TRANSACTION_PENDING_FROZEN = _IO('r', 20),
+	/*
+	 * The target of the last async transaction is frozen.  No parameters.
+	 */
 };
 
 enum binder_driver_command_protocol {
-- 
2.38.1.584.g0f3c55d4c2-goog

