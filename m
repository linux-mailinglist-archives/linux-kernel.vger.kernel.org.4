Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDC46996FA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjBPOSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBPOSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:18:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AAE4EC7;
        Thu, 16 Feb 2023 06:18:06 -0800 (PST)
Date:   Thu, 16 Feb 2023 15:17:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676557083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yC70dxR3j3o6dABPqhp3X+zunb/UJz6Yh+UqMQ9x8v0=;
        b=GYxNiX9V2EWsDAli1sgzN6Erxn3zxIom6rvzvUwcYW5yHbug400DMTmaHz3kDpF9Iz0JR8
        A/YZa3blN5fpTiaZWlaJ6LVEmaKYHI89WETGz3EDERF8gI9+nGCd56M6bQAXIo0Jtl6bQ4
        JhkcdPk8B8URAn4T2F8oDOqDwM3oFH2Vy9HUabTIMgGxX9nkstUyOZ4J901CRJt0bbZYq2
        bZ946cz/Oq8Vl8psdpY/Nsy4NqG+Jqe8rWKhH9YL6cfNMdOlr9S/KXEhyRF6ejexPycabo
        084lNSeTJZIPwk8xZDKd6Pl/4sO1Z43Tq/sV2KqFd6Vsm1c9yRVd9vBvU8T/Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676557083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yC70dxR3j3o6dABPqhp3X+zunb/UJz6Yh+UqMQ9x8v0=;
        b=5+9pvFUkhxXBGMs6TLBuyPGAh9RI+q3+DwLnyBsJ6RQCjsyJk7QKgtqbJh/2qKJFkCczk6
        sWZMfEKtXXz+u6Aw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Crystal Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Keeping <john@metanate.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: rtmutex, pi_blocked_on, and blk_flush_plug()
Message-ID: <Y+47FVJ+hI+NA2In@linutronix.de>
References: <4b4ab374d3e24e6ea8df5cadc4297619a6d945af.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b4ab374d3e24e6ea8df5cadc4297619a6d945af.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-09 22:31:57 [-0600], Crystal Wood wrote:
> Hello!
Hi,

> It is possible for blk_flush_plug() to be called while
> current->pi_blocked_on is set, in the process of trying to acquire an rwsem.
> If the block flush blocks trying to acquire some lock, then it appears that
> current->pi_blocked_on will be overwritten, and then set to NULL once that
> lock is acquired, even though the task is still blocked on the original
> rwsem.  Am I missing something that deals with this situation?  It seems
> like the lock types that are supposed to call blk_flush_plug() should do so
> before calling task_blocks_on_rt_mutex().

Do you experience a problem in v6.1-RT?

> I originally noticed this while investigating a related issue on an older
> RHEL kernel where task_blocked_on_mutex() has a BUG_ON if entered with
> current->pi_blocked_on non-NULL.  Current kernels lack this check.

The logic is different but the deadlock should be avoided:
- mutex_t and rw_semaphore invoke schedule() while blocking on a lock.
  As part of schedule() sched_submit_work() is invoked.
  This is the same in RT and !RT so I don't expect any dead lock since
  the involved locks are the same.

- spinlock_t invokes schedule_rtlock() which avoids sched_submit_work().
  This is the behaviour as with !RT because it spins and does not submit
  work either.
  rwlock_t should be have the same way but invokes schedule() instead.
  This looks wrong. And it could deadlock in sched_submit_work().

> To demonstrate that the recursive blocking scenario can happen (without
> actually waiting to hit the scenario where the second lock is contended),
> I put a WARN_ON_ONCE(current->pi_blocked_on) in rtlock_lock() (plus a few
> other places, but this is the one I hit):

XFS does not use rwlock_t directly.

> -Crystal

Sebastian
