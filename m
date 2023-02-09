Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFAF468FBEC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 01:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjBIAWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 19:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBIAWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 19:22:44 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AE71B557
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 16:22:42 -0800 (PST)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3190MdMR040407;
        Thu, 9 Feb 2023 09:22:39 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Thu, 09 Feb 2023 09:22:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3190MdPB040398
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 9 Feb 2023 09:22:39 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f79e93ef-cfe8-1373-7c36-15d046c0e3c5@I-love.SAKURA.ne.jp>
Date:   Thu, 9 Feb 2023 09:22:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drivers/core: Replace lockdep_set_novalidate_class() with
 unique class keys
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>
References: <Y965qEg0Re2QoQ7Q@rowland.harvard.edu>
 <CAHk-=wjoy=hObTmyRb9ttApjndt0LfqAfv71Cz+hEGrT0cLN+A@mail.gmail.com>
 <Y98FLlr7jkiFlV0k@rowland.harvard.edu>
 <827177aa-bb64-87a9-e1af-dfe070744045@I-love.SAKURA.ne.jp>
 <Y+Egr4MmqlE6G+mr@rowland.harvard.edu>
 <a7d0e143-1e68-5531-5c2e-1f853d794bc0@I-love.SAKURA.ne.jp>
 <Y+KOeJlvQMYAaheZ@rowland.harvard.edu>
 <a67e24eb-b68f-2abc-50af-ae4c2d4cdd95@I-love.SAKURA.ne.jp>
 <20230208080739.1649-1-hdanton@sina.com>
 <1ad499bb-0c53-7529-ff00-e4328823f6fa@I-love.SAKURA.ne.jp>
 <Y+O6toMmAKBSILMf@rowland.harvard.edu>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Y+O6toMmAKBSILMf@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/02/09 0:07, Alan Stern wrote:
> On Wed, Feb 08, 2023 at 07:30:25PM +0900, Tetsuo Handa wrote:
>> Commit 1704f47b50b5 ("lockdep: Add novalidate class for dev->mutex
>> conversion") made it impossible to find real deadlocks unless timing
>> dependent testings manage to trigger hung task like [1] and [2]. And
>> lockdep_set_novalidate_class() remained for more than one decade due to
>> a fear of false positives [3]. But not sharing mutex_init() could make
>> it possible to find real deadlocks without triggering hung task [4].
>> Thus, let's assign a unique class key on each "struct device"->mutex.
>>
>> Link: https://syzkaller.appspot.com/bug?extid=2d6ac90723742279e101 [1]
>> Link: https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb [2]
>> Link: https://lkml.kernel.org/r/Y98FLlr7jkiFlV0k@rowland.harvard.edu [3]
>> Link: https://lkml.kernel.org/r/827177aa-bb64-87a9-e1af-dfe070744045@I-love.SAKURA.ne.jp [4]
>> Suggested-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
>> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> You must never do this!
> 
> I did not put my Signed-off-by: on the patch I sent to you.  I do not 
> want it added to that patch or to this one.  You should never put 
> somebody else's Signed-off-by: on a patch unless they tell you it's okay 
> to do so.

Did I misuse the Co-developed-by: tag? I added your Signed-off-by: tag because
https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
states that "every Co-developed-by: must be immediately followed by a Signed-off-by:
of the associated co-author."

I don't know whether the Co-developed-by: tag is used only when somebody else takes over
a previously proposed formal patch. I use the Co-developed-by: tag in order to state
developer's contribution when he/she suggested some plain diff but does not propose
that diff as a formal patch with description. Unless changes are proposed as a formal
patch (by somebody), bugs won't be fixed.

> 
> I'm happy to have people test this patch, but I do not want anybody 
> think that it is ready to be merged into the kernel.

People (and build/test bots) won't test changes that are not proposed as
a formal patch with Signed-off-by: tag. As far as I am aware, bot is not
testing plain diff.

I expected you to post a formal patch with your Signed-off-by: tag, but you didn't.
Therefore, I took over. Namely, define a dummy function for CONFIG_LOCKDEP=n case,
apply Hillf's suggestion, and reduce lines changed in kernel/locking/lockdep.c
in order to make the patch smaller and easier to apply the change.

> 
>> Co-developed-by: Hillf Danton <hdanton@sina.com>
>> Signed-off-by: Hillf Danton <hdanton@sina.com>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> ---

>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>> index e3375bc40dad..74c0113646f1 100644
>> --- a/kernel/locking/lockdep.c
>> +++ b/kernel/locking/lockdep.c
>> @@ -857,6 +857,13 @@ static int static_obj(const void *obj)
>>  	 */
>>  	return is_module_address(addr) || is_module_percpu_address(addr);
>>  }
>> +
>> +int lockdep_static_obj(const void *obj)
>> +{
>> +	return static_obj(obj);
>> +}
>> +EXPORT_SYMBOL_GPL(lockdep_static_obj);
> 
> What's the point of adding a new function that just calls the old 
> function?  Why not simply rename the old function?

This makes the patch smaller and easier to apply the change. Of course,
I can update the patch if lockdep developers prefer rename over add.
What I worry is that lockdep developers do not permit static_obj() being
used by non-lockdep code.

