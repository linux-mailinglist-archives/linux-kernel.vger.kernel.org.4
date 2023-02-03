Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F9C689BC3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjBCOcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjBCOcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:32:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CE89D583
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=686ohwA2eY9DAHvlDa7p2qUCu5MZgEJ6AVfxC2H73aU=; b=CHJ+idfLu+OOu4flywwJ9iC4bH
        Y0J9cgxnvbBbjL+TU5YTl/zPQXx48lqQbF5ImhWCzQ0yiV0KJxYJyMyN1Z5eSFIInaOBjki0d1Rr8
        7vFokB+Ol3OGpqN5f13b8UDuXwgT7gcIhs6V3ACTCWP8Bc0N8tRqFya7t4vIUWdInsOFN7b/8Wgq4
        K6fiu1VyBBnvwFOYi+C9n0gbTwLfxo1QVWCNdrds+22XMUHaddRJQyCR+C7FICMHqVTWX6wlCJe+b
        UPkeaBFpQnviRxHjDvz3tpX1og1cUsa6KZ0D8L/HpGTd7LycIx1m9DbzLoU9J1egPDZrB1M30/3bK
        8VTSBAaA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNx5u-00ENCe-GR; Fri, 03 Feb 2023 14:31:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC70730012F;
        Fri,  3 Feb 2023 15:31:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA60020139FE0; Fri,  3 Feb 2023 15:31:11 +0100 (CET)
Date:   Fri, 3 Feb 2023 15:31:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+6cd18e123583550cf469@syzkaller.appspotmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [syzbot] WARNING: locking bug in umh_complete
Message-ID: <Y90ar35uKQoUrLEK@hirez.programming.kicks-ass.net>
References: <20230127014137.4906-1-hdanton@sina.com>
 <9d9b9652-c1ac-58e9-2eab-9256c17b1da2@I-love.SAKURA.ne.jp>
 <7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp>
 <Y9z76ZLe4On96xIN@hirez.programming.kicks-ass.net>
 <Y9z+SerR8mlZYo16@hirez.programming.kicks-ass.net>
 <6c47dbcf-2a17-6bb2-719b-841d851c603b@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c47dbcf-2a17-6bb2-719b-841d851c603b@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 09:59:51PM +0900, Tetsuo Handa wrote:
> On 2023/02/03 21:30, Peter Zijlstra wrote:
> >> I think the right fix is to:
> >>
> >> 	state &= ~TASK_KILLABLE;
> > 
> > 	state &= ~__TASK_WAKEKILL;
> > 
> > we don't want to mask out UNINTERUPTIBLE, that would be bad.
> 
> This code was made killable as a solution for CVE-2012-4398.
> Although OOM reaper is available today, making back to unkillable is not smart.

Yes, I meant something like so.


diff --git a/kernel/umh.c b/kernel/umh.c
index 850631518665..0e69e1e4b6fe 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -438,21 +438,24 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 	if (wait == UMH_NO_WAIT)	/* task has freed sub_info */
 		goto unlock;
 
-	if (wait & UMH_KILLABLE)
-		state |= TASK_KILLABLE;
-
-	if (wait & UMH_FREEZABLE)
+	if (wait & UMH_FREEZABLE) {
 		state |= TASK_FREEZABLE;
 
-	retval = wait_for_completion_state(&done, state);
-	if (!retval)
-		goto wait_done;
-
 	if (wait & UMH_KILLABLE) {
+		retval = wait_for_completion_state(&done, state | TASK_KILLABLE);
+		if (!retval)
+			goto wait_done;
+
 		/* umh_complete() will see NULL and free sub_info */
 		if (xchg(&sub_info->complete, NULL))
 			goto unlock;
+
+		/*
+		 * fallthrough; in case of -ERESTARTSYS now do uninterruptible
+		 * wait_for_completion().
+		 */
 	}
+	wait_for_completion_state(&done, state);
 
 wait_done:
 	retval = sub_info->retval;
