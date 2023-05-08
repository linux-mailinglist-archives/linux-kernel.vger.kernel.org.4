Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9346FB5C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjEHRNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEHRNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:13:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61C446AB
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 10:13:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38AD86427B
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 17:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE42C433EF;
        Mon,  8 May 2023 17:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683566014;
        bh=uNXUcIsvzCLohQIAh6OYzUn/+a+z0kaZVaP/zTa0rws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+hjgu9bN/HGrz7aHLXPf7HKC2H89xznOH4CP8ZS/GGxIhG23ocm+/TCNzTCOs8fe
         l84y/FHcy/qQD2xAngaVFyjtz5P4QG3ChMMTEJ347Wo59AvcHFjuEtyhLTUwlIzNSO
         ikSSI2tvbYKay/8vf92nPmj6xsXx4WAdnz0bsHQY5iU2l6IDFYqVhafnNBDU0mViKN
         TJXzvMK7OmDuJEKh2mCLuPJP3+qITPeBEKuzo3NeHqm/N19Z0hSRezmIZA12u/55g0
         lwegtrI3uiW+VixuIGpcE+g38xNE4HmEyWDE4QimRJ4UToZqyuXWvGlH5YwkCPITEg
         x9R06QNW/7HLQ==
Date:   Mon, 8 May 2023 19:13:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        nicolas.dichtel@6wind.com, hch@infradead.org, stefanha@redhat.com,
        jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Message-ID: <20230508-ebenfalls-unangebracht-1ef3cf2e35de@brauner>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 05:37:40PM -0500, Mike Christie wrote:
> On 5/5/23 1:22 PM, Linus Torvalds wrote:
> > On Fri, May 5, 2023 at 6:40 AM Nicolas Dichtel
> > <nicolas.dichtel@6wind.com> wrote:
> >>
> >> Is this an intended behavior?
> >> This breaks some of our scripts.
> > 
> > It doesn't just break your scripts (which counts as a regression), I
> > think it's really wrong.
> > 
> > The worker threads should show up as threads of the thing that started
> > them, not as processes.
> > 
> > So they should show up in 'ps' only when one of the "show threads" flag is set.
> > 
> > But I suspect the fix is trivial:  the virtio code should likely use
> > CLONE_THREAD for the copy_process() it does.
> > 
> > It should look more like "create_io_thread()" than "copy_process()", I think.
> > 
> > For example, do virtio worker threads really want their own signals
> > and files? That sounds wrong. create_io_thread() uses all of
> > 
> >  CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_IO
> > 
> > to share much more of the context with the process it is actually run within.
> > 
> 
> For the vhost tasks and the CLONE flags:
> 
> 1. I didn't use CLONE_FILES in the vhost task patches because you are right
> and we didn't need our own. We needed it to work like kthreads where there
> are no files, so I set the kernel_clone_args.no_files bit to have copy_files
> not do a dup or clone (task->files is NULL).
> 
> 2. vhost tasks didn't use CLONE_SIGHAND, because userspace apps like qemu use
> signals for management operations. But, the vhost thread's worker functions
> assume signals are ignored like they were with kthreads. So if they were doing
> IO and got a signal like a SIGHUP they might return early and fail from whatever
> network/block function they were calling. And currently the parent like qemu
> handles something like a SIGSTOP by shutting everything down by calling into
> the vhost interface to remove the device.
> 
> So similar to files I used the kernel_clone_args.ignore_signals bit so
> copy_process has the vhost thread have it's own signal handle that just ignores
> signals.
> 
> 3. I didn't use CLONE_THREAD because before my patches you could do
> "ps -u root" and see all the vhost threads. If we use CLONE_THREAD, then we
> can only see it when we do something like "ps -T -p $parent" like you mentioned
> above. I guess I messed up and did the reverse and thought it would be a
> regression if "ps -u root" no longer showed the vhost threads.
> 
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

I'm currently traveling due to LSFMM so that's why my responses will be
delayed this week. I'm not yet clear if CLONE_THREAD without
CLONE_SIGHAND is safe. If there's code that assumes that
$task_in_threadgroup->sighand->siglock always covers all threads in the
threadgroup then this change would break this assumption?

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
>  		.name		= name,
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
