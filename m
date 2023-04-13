Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938D66E0BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjDMKwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjDMKv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:51:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A1D8A4B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E1F463D90
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 10:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F12C433D2;
        Thu, 13 Apr 2023 10:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681383113;
        bh=A6jwleIi3Geg89RAm6mJf5xmtQ0hI5GwG9i4Or/UMTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sD/uG20pU621vFpsv+bmFhbeSP0Z1sjmZ0DNaC3tg85n7hg6ewuaWbpkuYGuwP3sz
         AVQCUDIE7mgWlh6UAKRbKSIrN6Lx7LSgGje5WLArVDPPqClT8iMElBT70HKHG8bIAw
         Ud9zCxCDWH317CuFP+l3D/OnqDgcl1uBfXzhx/h4=
Date:   Thu, 13 Apr 2023 12:51:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chuang Zhang <zhangchuang3@xiaomi.corp-partner.google.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        Chuang Zhang <zhangchuang3@xiaomi.com>
Subject: Re: [PATCH] Binder: Add timestamp and async from pid/tid to
 transaction record
Message-ID: <2023041302-uncut-tutor-0e6e@gregkh>
References: <20230413104047.388861-1-zhangchuang3@xiaomi.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413104047.388861-1-zhangchuang3@xiaomi.corp-partner.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 06:40:47PM +0800, Chuang Zhang wrote:
> From: Chuang Zhang <zhangchuang3@xiaomi.com>
> 
> This patch adds a timestamp field to the binder_transaction
> structure to track the time consumed during transmission
> when reading binder_transaction records.
> Additionally, it records the from pid and tid of asynchronous
> binder. This information is printed when reading binderfs
> related nodes to assist with debugging.

This should be broken up into 2 patches, one for each new feature you
are adding, right?

> 
> Signed-off-by: Chuang Zhang <zhangchuang3@xiaomi.com>

Much better, thanks!

Some comments on the code:

> ---
>  drivers/android/binder.c          | 24 ++++++++++++++++++------
>  drivers/android/binder_internal.h |  3 +++
>  2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index fb56bfc45096..e79f548bcbac 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -66,6 +66,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/task_work.h>
>  #include <linux/sizes.h>
> +#include <linux/ktime.h>
>  
>  #include <uapi/linux/android/binder.h>
>  
> @@ -3145,6 +3146,7 @@ static void binder_transaction(struct binder_proc *proc,
>  	binder_stats_created(BINDER_STAT_TRANSACTION_COMPLETE);
>  
>  	t->debug_id = t_debug_id;
> +	t->start_time = ktime_get();
>  
>  	if (reply)
>  		binder_debug(BINDER_DEBUG_TRANSACTION,
> @@ -3165,10 +3167,15 @@ static void binder_transaction(struct binder_proc *proc,
>  			     (u64)tr->data_size, (u64)tr->offsets_size,
>  			     (u64)extra_buffers_size);
>  
> -	if (!reply && !(tr->flags & TF_ONE_WAY))
> +	if (!reply && !(tr->flags & TF_ONE_WAY)) {
>  		t->from = thread;
> -	else
> +		t->async_from_pid = 0;
> +		t->async_from_tid = 0;
> +	} else  {
>  		t->from = NULL;
> +		t->async_from_pid = thread->proc->pid;
> +		t->async_from_tid = thread->pid;
> +	}
>  	t->sender_euid = task_euid(proc->tsk);
>  	t->to_proc = target_proc;
>  	t->to_thread = target_thread;
> @@ -4963,6 +4970,8 @@ static int binder_thread_release(struct binder_proc *proc,
>  		} else if (t->from == thread) {
>  			t->from = NULL;
>  			t = t->from_parent;
> +			t->async_from_pid = 0;
> +			t->async_from_tid = 0;
>  		} else
>  			BUG();
>  		spin_unlock(&last_t->lock);
> @@ -5930,17 +5939,20 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
>  {
>  	struct binder_proc *to_proc;
>  	struct binder_buffer *buffer = t->buffer;
> +	ktime_t current_time = ktime_get();
>  
>  	spin_lock(&t->lock);
>  	to_proc = t->to_proc;
>  	seq_printf(m,
> -		   "%s %d: %pK from %d:%d to %d:%d code %x flags %x pri %ld r%d",
> +		   "%s %d: %pK from %d:%d to %d:%d code %x elapsed %lldms flags %x pri %ld r%d",

Why not add this at the end of the line instead of in the middle?  That
way any existing code that looks at this line isn't as broken as it
might be with your change :)

>  		   prefix, t->debug_id, t,
> -		   t->from ? t->from->proc->pid : 0,
> -		   t->from ? t->from->pid : 0,
> +		   t->from ? t->from->proc->pid : t->async_from_pid,
> +		   t->from ? t->from->pid : t->async_from_tid,
>  		   to_proc ? to_proc->pid : 0,
>  		   t->to_thread ? t->to_thread->pid : 0,
> -		   t->code, t->flags, t->priority, t->need_reply);
> +		   t->code,
> +		   ktime_ms_delta(current_time, t->start_time),
> +		   t->flags, t->priority, t->need_reply);
>  	spin_unlock(&t->lock);
>  
>  	if (proc != to_proc) {
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index 28ef5b3704b1..7e60f547abb6 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -528,6 +528,9 @@ struct binder_transaction {
>  	long    priority;
>  	long    saved_priority;
>  	kuid_t  sender_euid;
> +	int async_from_pid;
> +	int async_from_tid;

As you are just using 0/1 for these variables, why not add them to the
bitfield location in this structure instead of wasting a whole int for
both of them?

thanks,

greg k-h
