Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5177016C2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 14:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbjEMMkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 08:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjEMMkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 08:40:02 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9AB268E
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 05:40:00 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pxoXG-0000NV-2p; Sat, 13 May 2023 14:39:42 +0200
Message-ID: <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
Date:   Sat, 13 May 2023 14:39:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Mike Christie <michael.christie@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        nicolas.dichtel@6wind.com, Christian Brauner <brauner@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
In-Reply-To: <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1683981600;e9bb33e9;
X-HE-SMSGID: 1pxoXG-0000NV-2p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing the regression list]

On 06.05.23 00:37, Mike Christie wrote:
> On 5/5/23 1:22 PM, Linus Torvalds wrote:
>> On Fri, May 5, 2023 at 6:40 AM Nicolas Dichtel
>> <nicolas.dichtel@6wind.com> wrote:
>>>
>>> Is this an intended behavior?
>>> This breaks some of our scripts.

Jumping in here, as I found another problem with that patch: it broke
s2idle on my laptop when a qemu-kvm VM is running, as freezing user
space processes now fails for me:

```
 [  195.442949] PM: suspend entry (s2idle)
 [  195.641271] Filesystems sync: 0.198 seconds
 [  195.833828] Freezing user space processes
 [  215.841084] Freezing user space processes failed after 20.007
seconds (1 tasks refusing to freeze, wq_busy=0):
 [  215.841255] task:vhost-3221      state:R stack:0     pid:3250
ppid:3221   flags:0x00004006
 [  215.841264] Call Trace:
 [  215.841266]  <TASK>
 [  215.841270]  ? update_rq_clock+0x39/0x270
 [  215.841283]  ? _raw_spin_unlock+0x19/0x40
 [  215.841290]  ? __schedule+0x3f/0x1510
 [  215.841296]  ? sysvec_apic_timer_interrupt+0xaf/0xd0
 [  215.841306]  ? schedule+0x61/0xe0
 [  215.841313]  ? vhost_worker+0x87/0xb0 [vhost]
 [  215.841329]  ? vhost_task_fn+0x1a/0x30
 [  215.841336]  ? __pfx_vhost_task_fn+0x10/0x10
 [  215.841341]  ? ret_from_fork+0x2c/0x50
 [  215.841352]  </TASK>
 [  215.841936] OOM killer enabled.
 [  215.841938] Restarting tasks ... done.
 [  215.844204] random: crng reseeded on system resumption
 [  215.957095] PM: suspend exit
 [  215.957185] PM: suspend entry (s2idle)
 [  215.967646] Filesystems sync: 0.010 seconds
 [  215.971326] Freezing user space processes
 [  235.974400] Freezing user space processes failed after 20.003
seconds (1 tasks refusing to freeze, wq_busy=0):
 [  235.974574] task:vhost-3221      state:R stack:0     pid:3250
ppid:3221   flags:0x00004806
 [  235.974583] Call Trace:
 [  235.974586]  <TASK>
 [  235.974593]  ? __schedule+0x184/0x1510
 [  235.974605]  ? sysvec_apic_timer_interrupt+0xaf/0xd0
 [  235.974616]  ? schedule+0x61/0xe0
 [  235.974624]  ? vhost_worker+0x87/0xb0 [vhost]
 [  235.974648]  ? vhost_task_fn+0x1a/0x30
 [  235.974656]  ? __pfx_vhost_task_fn+0x10/0x10
 [  235.974662]  ? ret_from_fork+0x2c/0x50
 [  235.974673]  </TASK>
 [  235.975190] OOM killer enabled.
 [  235.975192] Restarting tasks ... done.
 [  235.978131] random: crng reseeded on system resumption
 [  236.091219] PM: suspend exit
```

After running into the problem I booted 6.3.1-rc1 again and there s2idle
still worked. Didn't do a bisection, just looked at the vhost commits
during the latest merge window; 6e890c5d502 ("vhost: use vhost_tasks for
worker threads") looked suspicious, so I reverted it on top of latest
mainline and then things work again. Through a search on lore I arrived
in this thread and found below patch from Mike. Gave it a try on top of
latest mainline, but it didn't help.

Ciao, Thorsten

> [...]
> If it's ok to change the behavior of "ps -u root", then we can do this patch:
> (Nicolas, I confirmed it fixes the 'ps a' case, but couldn't replicate the 'ps'
> case. If you could test the ps only case or give me info on what /usr/bin/example
> was doing I can replicate and test here):
> 
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index ed4e01daccaa..eb9ffc58e211 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2269,8 +2269,14 @@ __latent_entropy struct task_struct *copy_process(
>  	/*
>  	 * Thread groups must share signals as well, and detached threads
>  	 * can only be started up within the thread group.
> +	 *
> +	 * A userworker's parent thread will normally have a signal handler
> +	 * that performs management operations, but the worker will not
> +	 * because the parent will handle the signal then user a worker
> +	 * specific interface to manage the thread and related resources.
>  	 */
> -	if ((clone_flags & CLONE_THREAD) && !(clone_flags & CLONE_SIGHAND))
> +	if ((clone_flags & CLONE_THREAD) && !(clone_flags & CLONE_SIGHAND) &&
> +	    !args->user_worker && !args->ignore_signals)
>  		return ERR_PTR(-EINVAL);
>  
>  	/*
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index b7cbd66f889e..3700c21ea39d 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -75,7 +78,8 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
>  				     const char *name)
>  {
>  	struct kernel_clone_args args = {
> -		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM,
> +		.flags		= CLONE_FS | CLONE_THREAD | CLONE_VM |
> +				  CLONE_UNTRACED,
>  		.exit_signal	= 0,
>  		.fn		= vhost_task_fn,
>  		.name		= name
