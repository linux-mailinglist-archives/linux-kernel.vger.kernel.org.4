Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDB769D2B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 19:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjBTSVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 13:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBTSVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 13:21:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7CC1C7D4;
        Mon, 20 Feb 2023 10:21:53 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676917312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M2TNSYPxwb1ODjFRyTX0POYdUTVU1KaJqYYoaJTBKBA=;
        b=EzR9F3DfHz1Ny0/+LBtKFmc2kDfhTjTpFyimjfk1KGacauIbxgb96aGRazsDUDOA+AWag8
        QkGbwSlHEaJIZFFGhhKJAHcy5x18HlGsQL8tUENDzGN99d3gwgYUqyUNYp/TRK9Ss+v/3q
        hmy0mKdeTE1jYkwEBbLUK1TT/a0xdGyfLfotO3Q8BgshQCL4Cm4NoLy7/7Aatt3aFEJeSa
        HBpDPgq45ZJZGdLKWsuDOjvlm/ggNoKGXk3Qh8cFprIb8yomRfJ72Ai9gB3PwE3iaWab4n
        Jxi9pf7O1D7qLvKrRmm5DpzTQmPyxKTHdKIh+5Xi+JtuDkW2IT/gigYXy3H5lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676917312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M2TNSYPxwb1ODjFRyTX0POYdUTVU1KaJqYYoaJTBKBA=;
        b=FseAp8FNcz6pg3f/zV9z3wyjunHJR4ysWheg1Io44pXjja4jQPwoAFBpoQyt615vh4dJP0
        oCrwe2VlO0ocOCDg==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Crystal Wood <swood@redhat.com>, John Keeping <john@metanate.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: rtmutex, pi_blocked_on, and blk_flush_plug()
In-Reply-To: <Y/NcnrwKr2u6tamQ@linutronix.de>
References: <4b4ab374d3e24e6ea8df5cadc4297619a6d945af.camel@redhat.com>
 <Y+47FVJ+hI+NA2In@linutronix.de> <87k00cr7ix.ffs@tglx>
 <Y/NT1/ynarp9cDlS@linutronix.de> <Y/NcnrwKr2u6tamQ@linutronix.de>
Date:   Mon, 20 Feb 2023 19:21:51 +0100
Message-ID: <874jrgqjsw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20 2023 at 12:42, Sebastian Andrzej Siewior wrote:
> On 2023-02-20 12:04:56 [+0100], To Thomas Gleixner wrote:
>> The ->pi_blocked_on field is set by __rwbase_read_lock() before
>> schedule() is invoked while blocking on the sleeping lock. By doing this
>> we avoid __blk_flush_plug() and as such will may deadlock because we are
>> going to sleep and made I/O progress earlier which is not globally
>> visibly but might be (s/might be/is/ in the deadlock case) expected by
>> the owner of the lock.

Fair enough.

> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1700,6 +1700,13 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
>  	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
>  		return 0;
>  
> +	if (state != TASK_RTLOCK_WAIT) {
> +		/*
> +		 * If we are going to sleep and we have plugged IO queued,
> +		 * make sure to submit it to avoid deadlocks.
> +		 */
> +		blk_flush_plug(tsk->plug, true);

This still leaves the problem vs. io_wq_worker_sleeping() and it's
running() counterpart after schedule().

Aside of that for CONFIG_DEBUG_RT_MUTEXES=y builds it flushes on every
lock operation whether the lock is contended or not.

Grmbl.
