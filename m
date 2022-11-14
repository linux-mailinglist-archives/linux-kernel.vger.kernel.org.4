Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7BD628251
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbiKNOVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbiKNOVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:21:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF8427B20;
        Mon, 14 Nov 2022 06:21:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1125B1FFF0;
        Mon, 14 Nov 2022 14:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668435661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O+nZKhPZ5sxjUHgZEx8PAo6m4rWcclTxMUKhua4g8c0=;
        b=aaZQf1+AUrfX8kg/sMyxO2GHlPhnvElMz5RWgtEV+1kCod6+oFhdXpby6p/KimMFfnS4Iv
        4sIk9JM0E9lSAXPyFGDrlf6Jc4aCu8v44qErtWU1alaJTXjMlt/73wBxsKvVecMN8h6wvn
        85qdc/cMtpiYOxBDawJGZ/Y0LsSQ7HQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668435661;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O+nZKhPZ5sxjUHgZEx8PAo6m4rWcclTxMUKhua4g8c0=;
        b=A/RCV+tTjfxrhjfym/hWAsYPmWR6mN7Ox7gsD5nBnZhOnm0Fy/7zN097n6qK7JbvI815WP
        95Tqe07rIjiz+pAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 784E713A92;
        Mon, 14 Nov 2022 14:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8VoKDMxOcmM9aAAAMHmgww
        (envelope-from <krisman@suse.de>); Mon, 14 Nov 2022 14:21:00 +0000
From:   Gabriel Krisman Bertazi <krisman@suse.de>
To:     Jan Kara <jack@suse.cz>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Liu Song <liusong@linux.alibaba.com>
Subject: [PATCH] sbitmap: Advance the queue index before waking up the queue
Organization: SUSE
References: <20221105231055.25953-1-krisman@suse.de>
        <20221114132313.5cqhvzxarm7rwvmt@quack3>
Date:   Mon, 14 Nov 2022 09:20:57 -0500
In-Reply-To: <20221114132313.5cqhvzxarm7rwvmt@quack3> (Jan Kara's message of
        "Mon, 14 Nov 2022 14:23:13 +0100")
Message-ID: <87wn7xk46u.fsf_-_@gbertazi.udp.ovpn1.prg.suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> Gabriel, when looking through this patch, I've noticed we can loose wakeups
> after your latest simplifications. See below for details:
>
> On Sat 05-11-22 19:10:55, Gabriel Krisman Bertazi wrote:
>> @@ -587,7 +571,7 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
>>  	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
>>  		struct sbq_wait_state *ws = &sbq->ws[wake_index];
>>  
>> -		if (waitqueue_active(&ws->wait) && atomic_read(&ws->wait_cnt)) {
>> +		if (waitqueue_active(&ws->wait)) {
>>  			if (wake_index != atomic_read(&sbq->wake_index))
>>  				atomic_set(&sbq->wake_index, wake_index);
>>  			return ws;
>
> Neither sbq_wake_ptr() nor sbitmap_queue_wake_up() now increment the
> wake_index after performing the wakeup. Thus we would effectively keep
> waking tasks from a single waitqueue until it becomes empty and only then
> go for the next waitqueue. This creates unnecessary unfairness in task
> wakeups and even possible starvation issues. So I think we need to advance
> wake_index somewhere. Perhaps here before returning waitqueue.

right. This is indeed a problem.  what do you think of the patch below?

> Now this may be also problematic - when we were checking the number of woken
> waiters in the older version of the patch (for others: internal version of
> the patch) this was fine but now it may happen that the 'ws' we have
> selected has no waiters anymore. And in that case we need to find another
> waitqueue because otherwise we'd be loosing too many wakeups and we could
> deadlock. So I think this rather needs to be something like:
>
> 	do {
> 		if (atomic_read(&sbq->completion_cnt) - wakeups < wake_batch)
> 			return;
> 	} while (!atomic_try_cmpxchg(&sbq->wakeup_cnt,
> 				     &wakeups, wakeups + wake_batch));
>
> 	do {
> 		ws = sbq_wake_ptr(sbq);
> 		if (!ws)
> 			return;
> 	} while (!wake_up_nr(&ws->wait, wake_batch));
>
> with our original version of wake_up_nr() returning number of woken
> waiters. What do you think?

I agree, and it wouldn't happen with the wake_up_nr patch we had before.
I will revive it quickly and follow up.  But, in this case, I want to be
cautious with benchmarking, so I will follow up still today, but as soon
as the new round of tests complete.

thanks,

-- >8 --
Subject: [PATCH] sbitmap: Advance the queue index before waking up the queue

When a queue is awaken, the wake_index written by sbq_wake_ptr currently
keeps pointing to the same queue.  On the next wake up, it will thus
retry the same queue, which is unfair to other queues, and can lead to
starvation.  This patch, moves the index update to happen before the
queue is returned, such that it will now try a different queue first on
the next wake up, improving fairness.

Reported-by: Jan Kara <jack@suse.cz>
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





