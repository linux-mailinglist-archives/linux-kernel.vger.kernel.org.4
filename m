Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E2262AE86
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiKOWqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiKOWqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:46:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA201F9DA;
        Tue, 15 Nov 2022 14:46:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD50920A5E;
        Tue, 15 Nov 2022 22:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668552370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i4p+Bf1ZB3EMXcVQfO03WbaDQ0+xCKIhIBXxIum+x8w=;
        b=h58UqQnzUH6hYBmuAOffZG1ph12ApvePMQMxwfMqxYG7pzxE1cOc6bgOc1Vp7KB+y87Irq
        HOQfNpEd1tw5qxs71+IxhwW/J5CPYYRNykz/b2oBrLKO0u7ltJUDFb//i1hB0arjGmiBS2
        QKE9ZAvIMFqzrJb8R00e5r1zPpXKGuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668552370;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i4p+Bf1ZB3EMXcVQfO03WbaDQ0+xCKIhIBXxIum+x8w=;
        b=2uWtfTyuS96Crx4LlR88t0aGB3ngLNKGMOijm+WmBufIMPo0nlI9pjuH+IxnmJA0fb7gwI
        Vqrym3FAKWk5jABg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F1B313273;
        Tue, 15 Nov 2022 22:46:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yGbdK7EWdGPsSwAAMHmgww
        (envelope-from <krisman@suse.de>); Tue, 15 Nov 2022 22:46:09 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     axboe@kernel.dk
Cc:     mingo@redhat.com, peterz@infradead.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        liusong@linux.alibaba.com, chaitanyak@nvidia.com,
        Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH 2/3] wait: Return number of exclusive waiters awaken
Date:   Tue, 15 Nov 2022 17:45:52 -0500
Message-Id: <20221115224553.23594-3-krisman@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221115224553.23594-1-krisman@suse.de>
References: <20221115224553.23594-1-krisman@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sbitmap code will need to know how many waiters were actually woken for
its batched wakeups implementation.  Return the number of woken
exclusive waiters from __wake_up() to facilitate that.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 include/linux/wait.h |  2 +-
 kernel/sched/wait.c  | 18 +++++++++++-------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 7f5a51aae0a7..a0307b516b09 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -209,7 +209,7 @@ __remove_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry *wq
 	list_del(&wq_entry->entry);
 }
 
-void __wake_up(struct wait_queue_head *wq_head, unsigned int mode, int nr, void *key);
+int __wake_up(struct wait_queue_head *wq_head, unsigned int mode, int nr, void *key);
 void __wake_up_locked_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
 void __wake_up_locked_key_bookmark(struct wait_queue_head *wq_head,
 		unsigned int mode, void *key, wait_queue_entry_t *bookmark);
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 9860bb9a847c..133b74730738 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -121,11 +121,12 @@ static int __wake_up_common(struct wait_queue_head *wq_head, unsigned int mode,
 	return nr_exclusive;
 }
 
-static void __wake_up_common_lock(struct wait_queue_head *wq_head, unsigned int mode,
+static int __wake_up_common_lock(struct wait_queue_head *wq_head, unsigned int mode,
 			int nr_exclusive, int wake_flags, void *key)
 {
 	unsigned long flags;
 	wait_queue_entry_t bookmark;
+	int remaining = nr_exclusive;
 
 	bookmark.flags = 0;
 	bookmark.private = NULL;
@@ -134,10 +135,12 @@ static void __wake_up_common_lock(struct wait_queue_head *wq_head, unsigned int
 
 	do {
 		spin_lock_irqsave(&wq_head->lock, flags);
-		nr_exclusive = __wake_up_common(wq_head, mode, nr_exclusive,
+		remaining = __wake_up_common(wq_head, mode, remaining,
 						wake_flags, key, &bookmark);
 		spin_unlock_irqrestore(&wq_head->lock, flags);
 	} while (bookmark.flags & WQ_FLAG_BOOKMARK);
+
+	return nr_exclusive - remaining;
 }
 
 /**
@@ -147,13 +150,14 @@ static void __wake_up_common_lock(struct wait_queue_head *wq_head, unsigned int
  * @nr_exclusive: how many wake-one or wake-many threads to wake up
  * @key: is directly passed to the wakeup function
  *
- * If this function wakes up a task, it executes a full memory barrier before
- * accessing the task state.
+ * If this function wakes up a task, it executes a full memory barrier
+ * before accessing the task state.  Returns the number of exclusive
+ * tasks that were awaken.
  */
-void __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
-			int nr_exclusive, void *key)
+int __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
+	      int nr_exclusive, void *key)
 {
-	__wake_up_common_lock(wq_head, mode, nr_exclusive, 0, key);
+	return __wake_up_common_lock(wq_head, mode, nr_exclusive, 0, key);
 }
 EXPORT_SYMBOL(__wake_up);
 
-- 
2.35.3

