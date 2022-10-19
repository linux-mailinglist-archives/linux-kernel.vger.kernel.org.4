Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3396660510A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 22:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiJSUJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 16:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJSUJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 16:09:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA6024BF1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 13:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666210172; x=1697746172;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l4m25spAE1rAU5YjmiQHfjM5t0sBwCCtecDZV0wPr5A=;
  b=CfVxeDaL94LNEGaR2ZarrLCEkUYV+z8EzGUxuKUhb+5XgCmTuInlbM6v
   ajNeLsrASLUHBSx1WeURXgseEegEfd7SNVUusExZclA5Y4dv8/wgCvZ2M
   vixxB14A3IrdqU72AlmGITrxboaQUi9x8O8U0aXbuLy/vuJDrimfSBqlm
   OZyKjuf4rr5yxWcXOxm4wKVcdnMC57yZNI0GC0JLfB1HIO9hLF3GQ0V53
   ++JeZNzmFSR1ESObXhnfS3v5dJF++CVSsLjmqTmfUNqH2eObmy+zgexkj
   SejY3MvnvEPEAdQgKr7X3jBP2ixQv93NbUN5NIOIUo3p9S46XHE2NY0gq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="305253664"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="305253664"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 13:09:31 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="692561919"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="692561919"
Received: from vyomapat-mobl.ger.corp.intel.com (HELO [10.213.202.155]) ([10.213.202.155])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 13:09:30 -0700
Message-ID: <8acc3e4a-abbc-32bc-626e-7a216f6755c3@linux.intel.com>
Date:   Wed, 19 Oct 2022 21:09:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: signal: break out of wait loops on kthread_stop()
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org,
        "Intel-gfx@lists.freedesktop.org" <Intel-gfx@lists.freedesktop.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
References: <0029af41-bf24-9972-10ac-f52e1bdcbf08@linux.intel.com>
 <CAHmME9o25v0kZUV-7qEY=6XXAyOA7q0sG8gpQfxHgr3sSVdsWw@mail.gmail.com>
 <41455798-1dcb-135f-516d-25ab9a8082f5@linux.intel.com>
 <Y1A+9kN6bwfXeqVt@zx2c4.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <Y1A+9kN6bwfXeqVt@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/10/2022 19:16, Jason A. Donenfeld wrote:
> On Wed, Oct 19, 2022 at 06:57:38PM +0100, Tvrtko Ursulin wrote:
>>
>> On 19/10/2022 17:00, Jason A. Donenfeld wrote:
>>> On Wed, Oct 19, 2022 at 7:31 AM Tvrtko Ursulin
>>> <tvrtko.ursulin@linux.intel.com> wrote:
>>>>
>>>>
>>>> Hi,
>>>>
>>>> A question regarding a7c01fa93aeb ("signal: break out of wait loops on
>>>> kthread_stop()") if I may.
>>>>
>>>> We have a bunch code in i915, possibly limited to self tests (ie debug
>>>> builds) but still important for our flows, which spawn kernel threads
>>>> and exercises parts of the driver.
>>>>
>>>> Problem we are hitting with this patch is that code did not really need
>>>> to be signal aware until now. Well to say that more accurately - we were
>>>> able to test the code which is normally executed from userspace, so is
>>>> signal aware, but not worry about -ERESTARTSYS or -EINTR within the test
>>>> cases itself.
>>>>
>>>> For example threads which exercise an internal API for a while until the
>>>> parent calls kthread_stop. Now those tests can hit unexpected errors.
>>>>
>>>> Question is how to best approach working around this change. It is of
>>>> course technically possible to rework our code in more than one way,
>>>> although with some cost and impact already felt due reduced pass rates
>>>> in our automated test suites.
>>>>
>>>> Maybe an opt out kthread flag from this new behavior? Would that be
>>>> acceptable as a quick fix? Or any other comments?
>>>
>>> You can opt out by running `clear_tsk_thread_flag(current,
>>> TIF_NOTIFY_SIGNAL);` at the top of your kthread. But you should really
>>> fix your code instead. Were I your reviewer, I wouldn't merge code
>>> that took the lazy path like that. However, that should work, if you
>>> do opt for the quick fix.
>>
>> Also, are you confident that the change will not catch anyone else by
>> surprise? In the original thread I did not spot any concerns about the
>> kthreads being generally unprepared to start receiving EINTR/ERESTARTSYS
>> from random call chains.
> 
> Pretty sure, yea. i915 is unique in its abuse of the API. Keep in mind
> that kthread_stop() also sets KTHREAD_SHOULD_STOP and such. Your code is
> abusing the API by calling kthread_run() followed by kthread_stop().

Hm why is kthread_stop() after kthread_run() abuse? I don't see it in 
kerneldoc that it must not be used for stopping threads.

> As evidence of how broken your code actually is, the kthread_stop()
> function has a comment that makes it clear, "This can also be called
> after kthread_create() instead of calling wake_up_process(): the thread
> will exit without calling threadfn()," yet i915 has attempted to hack
> around it with ridiculous yields and msleeps. For example:
> 
>                  threads[n] = kthread_run(__igt_breadcrumbs_smoketest,
>                                           &t, "igt/%d", n);
> ...
> 
>          yield(); /* start all threads before we begin */
>          msleep(jiffies_to_msecs(i915_selftest.timeout_jiffies));
> ...
>                  err = kthread_stop(threads[n]);
> 
> 
> Or here's another one:
> 
>                  tsk = kthread_run(fn, &thread[i], "igt-%d", i);
> ...
>          msleep(10); /* start all threads before we kthread_stop() */
> ...
>                  status = kthread_stop(tsk);
> 
> I mean come on.
> 
> This is brittle and bad and kind of ridiculous that it shipped this way.
> Now you're asking to extend your brittleness, so that you can avoid the
> work of cleaning up 5 call sites. Just clean up those 5 call sites. It's
> only 5, as far as I can tell.

Yep the yields and sleeps are horrible and will go. But they are also 
not relevant for the topic at hand. Issue is signal_pending() in the 
thread which just happens to now let kthread_stop() exit the thread 
before the work it used to do. And lack of consistent EINTR/ERESTARTSYS 
handling throughout.

Luckily I am almost sure this hasn't "shipped" anywhere real, in the 
sense it is debug only part of the driver.

Never mind, I was not looking for anything more than a suggestion on how 
to maybe work around it in piece as someone is dealing with the affected 
call sites.

kthread_wait below is perhaps a bit too indirect, since overall 
refactoring of the approach will be needed, but thanks anyway.

Thanks,

Tvrtko

>> Right, but our hand is a bit forced at the moment. Since 6.1-rc1 has
>> propagated to our development tree on Monday, our automated testing
>> started failing significantly, which prevents us merging new work until
>> resolved. So a quick fix trumps the ideal road in the short term. Just
>> because it is quick.
> 
> "Short term" -- somehow I can imagine the short term hack will turn into
> a long term one.
> 
> Anyway, what I suspect you might actually want as a bandaid is a
> "kthread_wait()"-like function, that doesn't try to stop the thread with
> KTHREAD_SHOULD_STOP and such, but just waits for the completion:
> 
> diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> index 30e5bec81d2b..2699cc45ad15 100644
> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
> @@ -86,6 +86,7 @@ void free_kthread_struct(struct task_struct *k);
>   void kthread_bind(struct task_struct *k, unsigned int cpu);
>   void kthread_bind_mask(struct task_struct *k, const struct cpumask *mask);
>   int kthread_stop(struct task_struct *k);
> +int kthread_wait(struct task_struct *k);
>   bool kthread_should_stop(void);
>   bool kthread_should_park(void);
>   bool __kthread_should_park(struct task_struct *k);
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index f97fd01a2932..d581d78a3a26 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -715,6 +715,22 @@ int kthread_stop(struct task_struct *k)
>   }
>   EXPORT_SYMBOL(kthread_stop);
> 
> +int kthread_wait(struct task_struct *k)
> +{
> +	struct kthread *kthread;
> +	int ret;
> +
> +	get_task_struct(k);
> +	kthread = to_kthread(k);
> +	wake_up_process(k);
> +	wait_for_completion(&kthread->exited);
> +	ret = kthread->result;
> +	put_task_struct(k);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(kthread_stop);
> +
>   int kthreadd(void *unused)
>   {
>   	struct task_struct *tsk = current;
> 
