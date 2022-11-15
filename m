Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5959B62AE84
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiKOWqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiKOWqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:46:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CC51F623;
        Tue, 15 Nov 2022 14:46:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C6F5A34318;
        Tue, 15 Nov 2022 22:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668552366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IYrVaqsmS8b3jCtQozwiIPWEpoyeeH8SinlJYdcy0ko=;
        b=lylnNgvkIbjdtaQ9et/CbJnSyquYdtzCSKuOBWIWt0UcfL2pkHMfFzlKPazE7jYTNfMiMJ
        v/ZMjL6hM3beSzbsHVHl8q+TGRtDgJRoPKuFg5wx+aJ3ABNgEcYO+dAOb4ViozPeNdUGPY
        1jK+Ok3OuTLAx/eGRwsSHkwmilZXju0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668552366;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IYrVaqsmS8b3jCtQozwiIPWEpoyeeH8SinlJYdcy0ko=;
        b=gbePz9b6hhi2tyEhmmJ7CShlR+h8KxYE4FaERpycstPN4ddmV9K9gwiCna5M1PHlByfzSa
        t9prs6macy3B8tDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A2B913273;
        Tue, 15 Nov 2022 22:46:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mvHfNa0WdGPcSwAAMHmgww
        (envelope-from <krisman@suse.de>); Tue, 15 Nov 2022 22:46:05 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     axboe@kernel.dk
Cc:     mingo@redhat.com, peterz@infradead.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        liusong@linux.alibaba.com, chaitanyak@nvidia.com,
        Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH 1/3] sbitmap: Advance the queue index before waking up a queue
Date:   Tue, 15 Nov 2022 17:45:51 -0500
Message-Id: <20221115224553.23594-2-krisman@suse.de>
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

When a queue is awaken, the wake_index written by sbq_wake_ptr currently
keeps pointing to the same queue.  On the next wake up, it will thus
retry the same queue, which is unfair to other queues, and can lead to
starvation.  This patch, moves the index update to happen before the
queue is returned, such that it will now try a different queue first on
the next wake up, improving fairness.

Fixes: 4f8126bb2308 ("sbitmap: Use single per-bitmap counting to wake up queued tags")
Reported-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 lib/sbitmap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index eca462cba398..bea7984f7987 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -571,13 +571,19 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		struct sbq_wait_state *ws = &sbq->ws[wake_index];
 
+		/*
+		 * Advance the index before checking the current queue.
+		 * It improves fairness, by ensuring the queue doesn't
+		 * need to be fully emptied before trying to wake up
+		 * from the next one.
+		 */
+		wake_index = sbq_index_inc(wake_index);
+
 		if (waitqueue_active(&ws->wait)) {
 			if (wake_index != atomic_read(&sbq->wake_index))
 				atomic_set(&sbq->wake_index, wake_index);
 			return ws;
 		}
-
-		wake_index = sbq_index_inc(wake_index);
 	}
 
 	return NULL;
-- 
2.35.3

