Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D5E68A750
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 01:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjBDAsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 19:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjBDAsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 19:48:45 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4767A6C10
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 16:48:43 -0800 (PST)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3140meC5031612;
        Sat, 4 Feb 2023 09:48:40 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Sat, 04 Feb 2023 09:48:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3140mdlv031609
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 4 Feb 2023 09:48:40 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <caa13441-5f95-b7d6-dd5d-1cf49e709714@I-love.SAKURA.ne.jp>
Date:   Sat, 4 Feb 2023 09:48:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [syzbot] WARNING: locking bug in umh_complete
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+6cd18e123583550cf469@syzkaller.appspotmail.com>,
        Hillf Danton <hdanton@sina.com>
References: <20230127014137.4906-1-hdanton@sina.com>
 <9d9b9652-c1ac-58e9-2eab-9256c17b1da2@I-love.SAKURA.ne.jp>
 <7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp>
 <Y9z76ZLe4On96xIN@hirez.programming.kicks-ass.net>
 <Y9z+SerR8mlZYo16@hirez.programming.kicks-ass.net>
 <6c47dbcf-2a17-6bb2-719b-841d851c603b@I-love.SAKURA.ne.jp>
 <Y90ar35uKQoUrLEK@hirez.programming.kicks-ass.net>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Y90ar35uKQoUrLEK@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/02/03 23:31, Peter Zijlstra wrote:
> Yes, I meant something like so.
> 
> 
> diff --git a/kernel/umh.c b/kernel/umh.c
> index 850631518665..0e69e1e4b6fe 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -438,21 +438,24 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
>  	if (wait == UMH_NO_WAIT)	/* task has freed sub_info */
>  		goto unlock;
>  
> -	if (wait & UMH_KILLABLE)
> -		state |= TASK_KILLABLE;
> -
> -	if (wait & UMH_FREEZABLE)
> +	if (wait & UMH_FREEZABLE) {
>  		state |= TASK_FREEZABLE;
>  
> -	retval = wait_for_completion_state(&done, state);
> -	if (!retval)
> -		goto wait_done;
> -
>  	if (wait & UMH_KILLABLE) {
> +		retval = wait_for_completion_state(&done, state | TASK_KILLABLE);
> +		if (!retval)
> +			goto wait_done;
> +
>  		/* umh_complete() will see NULL and free sub_info */
>  		if (xchg(&sub_info->complete, NULL))
>  			goto unlock;
> +
> +		/*
> +		 * fallthrough; in case of -ERESTARTSYS now do uninterruptible
> +		 * wait_for_completion().
> +		 */
>  	}
> +	wait_for_completion_state(&done, state);
>  
>  wait_done:
>  	retval = sub_info->retval;

Please fold below diff, provided that wait_for_completion_state(TASK_FREEZABLE)
does not return when the current thread was frozen. (If
wait_for_completion_state(TASK_FREEZABLE) returns when the current thread was
frozen, we will fail to execute the

  retval = sub_info->retval;

line in order to get the exit code after the current thread is thawed...)

diff --git a/kernel/umh.c b/kernel/umh.c
index 0e69e1e4b6fe..a776920ec051 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -431,35 +431,38 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 	 * This makes it possible to use umh_complete to free
 	 * the data structure in case of UMH_NO_WAIT.
 	 */
 	sub_info->complete = (wait == UMH_NO_WAIT) ? NULL : &done;
 	sub_info->wait = wait;
 
 	queue_work(system_unbound_wq, &sub_info->work);
 	if (wait == UMH_NO_WAIT)	/* task has freed sub_info */
 		goto unlock;
 
-	if (wait & UMH_FREEZABLE) {
+	if (wait & UMH_FREEZABLE)
 		state |= TASK_FREEZABLE;
 
 	if (wait & UMH_KILLABLE) {
 		retval = wait_for_completion_state(&done, state | TASK_KILLABLE);
 		if (!retval)
 			goto wait_done;
 
 		/* umh_complete() will see NULL and free sub_info */
 		if (xchg(&sub_info->complete, NULL))
 			goto unlock;
 
 		/*
 		 * fallthrough; in case of -ERESTARTSYS now do uninterruptible
-		 * wait_for_completion().
+		 * wait_for_completion_state(). Since umh_complete() shall call
+		 * complete() in a moment if xchg() above returned NULL, this
+		 * uninterruptible wait_for_completion_state() will not block
+		 * SIGKILL'ed process for so long.
 		 */
 	}
 	wait_for_completion_state(&done, state);
 
 wait_done:
 	retval = sub_info->retval;
 out:
 	call_usermodehelper_freeinfo(sub_info);
 unlock:
 	helper_unlock();

