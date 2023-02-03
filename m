Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D54689744
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbjBCKss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjBCKsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:48:41 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFFF23114
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:48:37 -0800 (PST)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 313Ama1H044424;
        Fri, 3 Feb 2023 19:48:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Fri, 03 Feb 2023 19:48:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 313AmaVt044421
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 3 Feb 2023 19:48:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp>
Date:   Fri, 3 Feb 2023 19:48:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [syzbot] WARNING: locking bug in umh_complete
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+6cd18e123583550cf469@syzkaller.appspotmail.com>,
        Hillf Danton <hdanton@sina.com>
References: <20230127014137.4906-1-hdanton@sina.com>
 <9d9b9652-c1ac-58e9-2eab-9256c17b1da2@I-love.SAKURA.ne.jp>
In-Reply-To: <9d9b9652-c1ac-58e9-2eab-9256c17b1da2@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/02/03 19:22, Tetsuo Handa wrote:
> Yes, this bug is caused by commit f5d39b020809 ("freezer,sched: Rewrite core freezer
> logic"), for that commit for unknown reason omits wait_for_completion(&done) call
> when wait_for_completion_state(&done, state) returned -ERESTARTSYS.
> 
> Peter, is it safe to restore wait_for_completion(&done) call?
> 

Something like this?

diff --git a/kernel/umh.c b/kernel/umh.c
index 850631518665..97230edb1849 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -441,8 +441,8 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 	if (wait & UMH_KILLABLE)
 		state |= TASK_KILLABLE;
 
-	if (wait & UMH_FREEZABLE)
-		state |= TASK_FREEZABLE;
+	//if (wait & UMH_FREEZABLE)
+	//	state |= TASK_FREEZABLE;
 
 	retval = wait_for_completion_state(&done, state);
 	if (!retval)
@@ -452,7 +452,9 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 		/* umh_complete() will see NULL and free sub_info */
 		if (xchg(&sub_info->complete, NULL))
 			goto unlock;
+		/* fallthrough, umh_complete() was already called */
 	}
+	wait_for_completion(&done);
 
 wait_done:
 	retval = sub_info->retval;

How does TASK_FREEZABLE affect here? Since call_usermodehelper_exec() is a function
for starting and waiting for termination of a userspace process (which is subjected
to freezing), the caller of call_usermodehelper_exec() can't wait for the termination
of that userspace process if that process was frozen, and wait_for_completion()
blocks forever?

