Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FB76E2B77
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 23:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjDNVDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 17:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDNVDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 17:03:41 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26B53A84
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:03:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id lh8so6640758plb.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 14:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681506217; x=1684098217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WZCFnEyZCPOZULi6aWVfblgCZydsGMA1WowXRWrNQ+U=;
        b=RRSiY34E+HrRgT5YmvRV5t1XHPy1bu4cS88Q9/FAVqlFCqIlY7aVpZEkZ0Ofpbfk7N
         VqCsL7qVTkKPknwO3G888fMqjvVnjhxEhpi7N0DajL+9E95wyTEBJGA3bbk13d0WfKKj
         d73qa4OM7db2ouhoEtuPQ8/cnUzzWqy9O/qKdYb1dL1c8kZxUmJ+E3Q1M1BIb0miUHuj
         9Frv9hvrQ0elH0VucIBPaJHO4R6ijP0LE5Qzl1CuilfqxE+TASMxjzEuuvChmTlXr+t0
         ErP1pFyDx3i3Tk3WvbB7n8xZngRq7bOz3Gn7xXPZhpjz4PBHPtSrw3xb10MBdMAiZHqb
         0uIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681506217; x=1684098217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZCFnEyZCPOZULi6aWVfblgCZydsGMA1WowXRWrNQ+U=;
        b=FCCXz1HRno1U8EyYbFA7s74YP8MAeNCanUNevafwT1PmcvBKC2VO2koUD00zhLXB19
         Ke2z5HVBscn2G6Jn38RjJCWwmpcQJQWMlO+2NywPEn7HxRrCQqWlgkNlpiJiEvuCoxI7
         p2qBbIDuxxaeDi3GIUljuSS1JNNM591LwgG1RPvk9VGSrBH4ljKmo3kD2+MM5z7VoUtU
         mgTN4zfeu8fzmNoqRLhAgaEr0RKxTdsE+Rlmh7D1ajfvUF3aVI157GWIXWY7kjirZqIe
         p5qnyA2dR4zBcNsNPWLX74zwrxhniq6J0YC2IjaAm51ChWrINiOUIu+vlnnROhOZuegT
         S/gw==
X-Gm-Message-State: AAQBX9f3e+1yjYmQsJgGWM8W7S2WF5SWJMHw5AJzEOFlI2EVEA8h1gsV
        0e0XwiH03pot14/pvh+Ig2wDzA==
X-Google-Smtp-Source: AKy350ayy60QRYNn9pd0jrgd6OhDHo69tFpjZCVIDDepN3FQgp1zwejBxjTdoggQhYwZYoCVPfKtxw==
X-Received: by 2002:a17:90b:38ce:b0:247:2300:87d9 with SMTP id nn14-20020a17090b38ce00b00247230087d9mr6680586pjb.34.1681506216756;
        Fri, 14 Apr 2023 14:03:36 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w3-20020a1709029a8300b001a66c4afe0asm2098932plp.255.2023.04.14.14.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 14:03:36 -0700 (PDT)
Date:   Fri, 14 Apr 2023 21:03:32 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Chuang Zhang <zhangchuang3@xiaomi.corp-partner.google.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        surenb@google.com, linux-kernel@vger.kernel.org,
        Chuang Zhang <zhangchuang3@xiaomi.com>
Subject: Re: [PATCH] Binder: Add timestamp and async from pid/tid to
 transaction record
Message-ID: <ZDm/pLQefIyTBAqb@google.com>
References: <20230413104047.388861-1-zhangchuang3@xiaomi.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413104047.388861-1-zhangchuang3@xiaomi.corp-partner.google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

Can you clarify how are you using this information? It seems the
timestamp here is only applicable for in-flight transactions correct?
Also, why not use the current trace points to generate this information?
The standard to measure transaction latency seems to be Perfetto.

> 
> Signed-off-by: Chuang Zhang <zhangchuang3@xiaomi.com>
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

The start_time will be more accurate if taken earlier. Several spinlocks
will delay the timestamp here. You can cache this value in a local
variable upon entry, actually similar to the t_debug_id.

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

The t->from is not populated for oneway transactions as it is not safe
to access. However, I don't see a reason for not populating the from_pid
and from_tid in synchronous here. Why make this async only?

> +	} else  {
>  		t->from = NULL;
> +		t->async_from_pid = thread->proc->pid;

nit: just proc->pid is shorter and equivalent.

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
>  		   prefix, t->debug_id, t,
> -		   t->from ? t->from->proc->pid : 0,
> -		   t->from ? t->from->pid : 0,
> +		   t->from ? t->from->proc->pid : t->async_from_pid,
> +		   t->from ? t->from->pid : t->async_from_tid,

You could always use t->from_pid and t->from_tid here regardless if
t->from is populated or not. But as mentioned above, you'd need to drop
the async only portion.

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
> +	ktime_t start_time;
>  	struct list_head fd_fixups;
>  	binder_uintptr_t security_ctx;
>  	/**
> -- 
> 2.34.1
> 

Thanks,
Carlos Llamas
