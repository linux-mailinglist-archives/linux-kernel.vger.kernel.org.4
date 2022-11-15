Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58BE62AE88
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiKOWq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiKOWqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:46:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147B61FCFE;
        Tue, 15 Nov 2022 14:46:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7A5CF20A90;
        Tue, 15 Nov 2022 22:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668552374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d3jRfb3u2UMhELX3RFNE2yKyqYVqcOMcurpZIDpUfqQ=;
        b=ICr7+PbdeP+cvI4LbyR8wehVSKXI9D+8UYj/5EI5AZlluzxdnsPEZEd1qGvXKzSRNwdWEr
        3+iX//2sCDWNtPdX61Ol2e1nAgZu7aUFQtYsYgMWy5NTcfMyT56IdlHqUfIoPx/JnyVmvA
        SbBZmECalYSPPyWnXXAK1mCm2KXGpBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668552374;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d3jRfb3u2UMhELX3RFNE2yKyqYVqcOMcurpZIDpUfqQ=;
        b=a5XL0CFX5ESUe67zQsjAkZjjyX5RwRLma+q2/quZ8SEzsSCciMKWsyEY+8PctohwjOaoRd
        XgjXOpMSoqafK9DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D122213273;
        Tue, 15 Nov 2022 22:46:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nvQtI7UWdGPzSwAAMHmgww
        (envelope-from <krisman@suse.de>); Tue, 15 Nov 2022 22:46:13 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     axboe@kernel.dk
Cc:     mingo@redhat.com, peterz@infradead.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        liusong@linux.alibaba.com, chaitanyak@nvidia.com,
        Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH 3/3] sbitmap: Try each queue to wake up at least one waiter
Date:   Tue, 15 Nov 2022 17:45:53 -0500
Message-Id: <20221115224553.23594-4-krisman@suse.de>
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

Jan reported the new algorithm as merged might be problematic if the
queue being awaken becomes empty between the waitqueue_active inside
sbq_wake_ptr check and the wake up.  If that happens, wake_up_nr will
not wake up any waiter and we loose too many wake ups.  In order to
guarantee progress, we need to wake up at least one waiter here, if
there are any.  This now requires trying to wake up from every queue.

Instead of walking through all the queues with sbq_wake_ptr, this call
moves the wake up inside that function.  In a previous version of the
patch, I found that updating wake_index several times when walking
through queues had a measurable overhead.  This ensures we only update
it once, at the end.

Fixes: 4f8126bb2308 ("sbitmap: Use single per-bitmap counting to wake up queued tags")
Reported-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 lib/sbitmap.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index bea7984f7987..586deb333237 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -560,12 +560,12 @@ void sbitmap_queue_min_shallow_depth(struct sbitmap_queue *sbq,
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_min_shallow_depth);
 
-static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
+static void __sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
 {
 	int i, wake_index;
 
 	if (!atomic_read(&sbq->ws_active))
-		return NULL;
+		return;
 
 	wake_index = atomic_read(&sbq->wake_index);
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
@@ -579,20 +579,22 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 		 */
 		wake_index = sbq_index_inc(wake_index);
 
-		if (waitqueue_active(&ws->wait)) {
-			if (wake_index != atomic_read(&sbq->wake_index))
-				atomic_set(&sbq->wake_index, wake_index);
-			return ws;
-		}
+		/*
+		 * It is sufficient to wake up at least one waiter to
+		 * guarantee forward progress.
+		 */
+		if (waitqueue_active(&ws->wait) &&
+		    wake_up_nr(&ws->wait, nr))
+			break;
 	}
 
-	return NULL;
+	if (wake_index != atomic_read(&sbq->wake_index))
+		atomic_set(&sbq->wake_index, wake_index);
 }
 
 void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
 {
 	unsigned int wake_batch = READ_ONCE(sbq->wake_batch);
-	struct sbq_wait_state *ws = NULL;
 	unsigned int wakeups;
 
 	if (!atomic_read(&sbq->ws_active))
@@ -604,16 +606,10 @@ void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
 	do {
 		if (atomic_read(&sbq->completion_cnt) - wakeups < wake_batch)
 			return;
-
-		if (!ws) {
-			ws = sbq_wake_ptr(sbq);
-			if (!ws)
-				return;
-		}
 	} while (!atomic_try_cmpxchg(&sbq->wakeup_cnt,
 				     &wakeups, wakeups + wake_batch));
 
-	wake_up_nr(&ws->wait, wake_batch);
+	__sbitmap_queue_wake_up(sbq, wake_batch);
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
 
-- 
2.35.3

