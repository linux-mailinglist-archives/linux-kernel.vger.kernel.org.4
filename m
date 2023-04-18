Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF696E67E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjDRPSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjDRPSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:18:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247F410267
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:18:41 -0700 (PDT)
Date:   Tue, 18 Apr 2023 17:18:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681831119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=USQxfv2J4XGMo19BRenhzA7oRuaF4G8/6oKxnGD66XI=;
        b=D8Icnh60hBt0y55GIy7KN2ipsqaDqXh9AFZyJVth56c/qKj+GDhuGkPqmXm5tcfpUO/ROX
        KbKDTCywBQnKFcFshu2r/Dr+62FdZQzrOxgSc2dPTDYY4mTcJOAXVTnAguEVTfsUz0APVN
        9DBR7g0a2naXJmfLoFZPwy+d4JjTabE2Y4gmn6BJ8QGtO5cHcA0oOzbNdNG7ieZMSqOthp
        pRaZH5gbye+nkZixadywcq/dugZgOQoYXcWFfdXQhDuy3oJCP73yc+UfZSI6NFCoN/WRsO
        0rGoTHP4b7PouWwEokAPSVlKlE70OywWLMdHiNuE33/dn4ouu3n8UDnjRFHI3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681831119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=USQxfv2J4XGMo19BRenhzA7oRuaF4G8/6oKxnGD66XI=;
        b=5LYu/izUPCtXm1MSWAG8kRhdJXDEAs6ea999LlqulUzmcsYIXxXMo6DxYkVJXC9wNCTj83
        nGSjn+nnfjwUZnDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Crystal Wood <swood@redhat.com>, John Keeping <john@metanate.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] locking/rtmutex: Flush the plug before entering the
 slowpath.
Message-ID: <20230418151838.jNcnnDqL@linutronix.de>
References: <20230322162719.wYG1N0hh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322162719.wYG1N0hh@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-22 17:27:21 [+0100], To Thomas Gleixner wrote:
> blk_flush_plug() is invoked on schedule() to flush out the IO progress
> that has been made so far so that it is globally visible. This is
> important to avoid deadlocks because a lock owner can wait for IO.
> Therefore the IO must be first flushed before a thread can block on a
> lock.
> 
> The plug flush routine can acquire a sleeping lock which is contended.
> Blocking on a lock requires an assignment to task_struct::pi_blocked_on.
> If blk_flush_plug() is invoked from the slow path on schedule() then the
> variable is already set and will be overwritten by the lock in
> blk_flush_plug().
> Therefore it is needed to invoke blk_flush_plug() (and block on
> potential locks in the process) before the blocking on the actual lock.
> 
> Invoke blk_flush_plug() before blocking on a sleeping lock. The
> PREEMPT_RT only sleeping locks (spinlock_t and rwlock_t) are excluded
> because their slow path does not invoke blk_flush_plug().
> 
> Fixes: e17ba59b7e8e1 ("locking/rtmutex: Guard regular sleeping locks specific functions")
> Reported-by: Crystal Wood <swood@redhat.com>
> Link: https://lore.kernel.org/4b4ab374d3e24e6ea8df5cadc4297619a6d945af.camel@redhat.com
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

polite ping.

Sebastian
