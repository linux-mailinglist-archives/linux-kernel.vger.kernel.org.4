Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E9769C941
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjBTLFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjBTLFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:05:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58578EFBC;
        Mon, 20 Feb 2023 03:04:58 -0800 (PST)
Date:   Mon, 20 Feb 2023 12:04:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676891096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a5K+nNXU/aOhOrHEM+8WiqTHs4DgPAa77M4xUQIhQFA=;
        b=U19Z8M1ktqI7u2yK4OYbmyTdfEb7+iBxB5POxwnzKTdgcCxNBeRWA5aODFzCq/PTM8TPOQ
        w9nVzkYtL2gY68MF1bzoo0Dgdqe8NrbXHh5n9cjei/8svduobxPq0MS1/PNVgLZXawpX7f
        rHnKY4BvPDGCNlJmAsEeygU6N5NH1+dL69ThQ9ZjRJ461dss7NJNUZQ4fOyMnvAYCywwGm
        aRA/xjq70cFzz3RXqNBqyxEB7uMSYiOU7FDgmaMKE6YnRJH9jPSC3RiVN46rMbNxTU7ubJ
        sDn0Nu1OHdIBlBXXwHTHsEZRSisBx14gPNlNUsq9diIQyBJIWMU0UscZqJVawg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676891096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a5K+nNXU/aOhOrHEM+8WiqTHs4DgPAa77M4xUQIhQFA=;
        b=/ZcF1/bMaDLwLhua3sSEQzF1BKgfYID0a8wGlSvrkyHhkTg39pKxbGPpOCpDREyMhI3M9Z
        FUluMeZEaUB3nQAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Crystal Wood <swood@redhat.com>, John Keeping <john@metanate.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: rtmutex, pi_blocked_on, and blk_flush_plug()
Message-ID: <Y/NT1/ynarp9cDlS@linutronix.de>
References: <4b4ab374d3e24e6ea8df5cadc4297619a6d945af.camel@redhat.com>
 <Y+47FVJ+hI+NA2In@linutronix.de>
 <87k00cr7ix.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87k00cr7ix.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-20 10:49:26 [+0100], Thomas Gleixner wrote:
> > The logic is different but the deadlock should be avoided:
> > - mutex_t and rw_semaphore invoke schedule() while blocking on a lock.
> >   As part of schedule() sched_submit_work() is invoked.
> >   This is the same in RT and !RT so I don't expect any dead lock since
> >   the involved locks are the same.
> 
> Huch?
> 
> xlog_cil_commit()
>   down_read(&cil->xc_ctx_lock)
>     __rwbase_read_lock()
>        __rt_mutex_slowlock()
>          current->pi_blocked_on = ...
>          schedule()
>            __blk_flush_plug()
>              dd_insert_requests()
>                rt_spin_lock()
>                  WARN_ON(current->pi_blocked_on);
> 
> So something like the below is required. But that might not cut it
> completely. wq_worker_sleeping() is fine, but I'm not convinced that
> io_wq_worker_sleeping() is safe. That needs some investigation.

Okay, so this makes sense.

> Thanks,
> 
>         tglx
> ---
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6666,6 +6666,9 @@ static inline void sched_submit_work(str
>  	 */
>  	SCHED_WARN_ON(current->__state & TASK_RTLOCK_WAIT);
>  
> +	if (current->pi_blocked_on)
> +		return;
> +

The ->pi_blocked_on field is set by __rwbase_read_lock() before
schedule() is invoked while blocking on the sleeping lock. By doing this
we avoid __blk_flush_plug() and as such will may deadlock because we are
going to sleep and made I/O progress earlier which is not globally
visibly but might be (s/might be/is/ in the deadlock case) expected by
the owner of the lock.

We could trylock and if this fails, flush and do the proper lock.
This would ensure that we set pi_blocked_on after we flushed.

>  	/*
>  	 * If we are going to sleep and we have plugged IO queued,
>  	 * make sure to submit it to avoid deadlocks.

Sebastian
