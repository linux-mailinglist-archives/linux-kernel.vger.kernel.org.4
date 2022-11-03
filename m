Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55E161882D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiKCTGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiKCTF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:05:59 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B92C18349
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:05:57 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id q9so2503633pfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJkdqC6xaSvasH+b4tdtU/3z+ZeTWR3odHCTd4ISmW8=;
        b=UL6HrfpC5hh15df7tf6WCRbbdFW3ms99n+B2dkgGdkQ8146HutoXC5edrOgoaW6VF2
         Aregj3BzB4hftUZzYkNbhr4KUNRiGjDiApd/UhYFl9ggp+kiOLFpIzcNGBDPftccbZAv
         SOuZ1o9CvdNoM4ugC55ull1XbyPVaUVak8WGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJkdqC6xaSvasH+b4tdtU/3z+ZeTWR3odHCTd4ISmW8=;
        b=aO2jb2etRmneeSAo9sYznMzgwEP7Zbcg6/vPXrhYIlQZspG3dB5sqfdzk/LKlyaSkD
         9WPRhTKAiV4pxkIQ8KW0QV3gI73guL4rnbtxXRuwYoIqCJHpmT5vg1G8YlxGH2Fnmt9G
         RSSYEHuJADTjvPLoZ3UbvyveorM6qtQcKzyUFiGKcMAuEfs+gpGFgH+jHCgElw7lTekj
         DVuvx3YzT4RbOZmwFDKDWbx75kYvJWNd7JT48CzoKYJgT4uSE1Aj/n12sCSCXUg2bQty
         NFzgHg5HDMBrPwYxCmU+59l8z7bUjbukueffckkDDbR+rTBlswSe34frQKXzmnREFVho
         O24w==
X-Gm-Message-State: ACrzQf32OuD/6szYCz6zU0J2Bzi+wsieIxLVylPV1Zv2PfNoFPK8MSb/
        qYqETPXiJJtBffSUzuFHFEkv8g==
X-Google-Smtp-Source: AMsMyM6VmJaDWQ7kyIuH99F4LBWwwJ6XDI1Ebv0Uf5iHJKSoyuk0AZUPlLRNEzujaLQ2XmcX9ZsYHw==
X-Received: by 2002:a63:c65:0:b0:470:cb4:aca3 with SMTP id 37-20020a630c65000000b004700cb4aca3mr7351966pgm.389.1667502357107;
        Thu, 03 Nov 2022 12:05:57 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (30.161.125.34.bc.googleusercontent.com. [34.125.161.30])
        by smtp.gmail.com with ESMTPSA id q13-20020a63d60d000000b0046ae5cfc3d5sm1070973pgg.61.2022.11.03.12.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:05:56 -0700 (PDT)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, gregkh@linuxfoundation.org, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        brauner@kernel.org, cmllamas@google.com, surenb@google.com,
        arnd@arndb.de, masahiroy@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, hridya@google.com,
        smoreland@google.com
Cc:     kernel-team@android.com
Subject: [PATCH v1 1/1] binder: return pending info for frozen async txns
Date:   Thu,  3 Nov 2022 12:05:49 -0700
Message-Id: <20221103190549.3446167-2-dualli@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103190549.3446167-1-dualli@chromium.org>
References: <20221103190549.3446167-1-dualli@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Li <dualli@google.com>

An async transaction to a frozen process will still be successsfully
put in the queue. But this pending async transaction won't be processed
until the target process is unfrozen at an unspecified time in the
future. Pass this important information back to the user space caller
by returning BR_TRANSACTION_PENDING.

Signed-off-by: Li Li <dualli@google.com>
---
 drivers/android/binder.c            | 23 ++++++++++++++++++++---
 drivers/android/binder_internal.h   |  3 ++-
 include/uapi/linux/android/binder.h |  7 ++++++-
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 880224ec6abb..a097b89f6a7a 100644
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
@@ -2807,6 +2810,9 @@ static int binder_proc_transaction(struct binder_transaction *t,
 		binder_stats_deleted(BINDER_STAT_TRANSACTION);
 	}
 
+	if (oneway && proc->is_frozen)
+		return BR_TRANSACTION_PENDING;
+
 	return 0;
 }
 
@@ -3607,9 +3613,16 @@ static void binder_transaction(struct binder_proc *proc,
 	} else {
 		BUG_ON(target_node == NULL);
 		BUG_ON(t->buffer->async_transaction != 1);
-		binder_enqueue_thread_work(thread, tcomplete);
 		return_error = binder_proc_transaction(t, target_proc, NULL);
-		if (return_error)
+		/*
+		 * Let the caller know its async transaction reaches a frozen
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
@@ -4440,10 +4453,13 @@ static int binder_thread_read(struct binder_proc *proc,
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
@@ -6170,6 +6186,7 @@ static const char * const binder_return_strings[] = {
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

