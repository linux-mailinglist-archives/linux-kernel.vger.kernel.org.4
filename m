Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B775C689831
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjBCMBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjBCMBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:01:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0054953DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 04:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=11y57wpqO0jUchP58rm0Hy4isyaoxOgtIaNkgxr4gwM=; b=krHJemkCKnjw1vySw4wbRPzonA
        GcdbjfrMqf79LiiUZamIQYCi3trl34buHcBOCL70BfqcZcU1I0NiN1ZoLyraEGjz2ayCN1gi28sOk
        0TfLdgORVpQDLYWXrVxp5FvGcLqZ9JLdPZrWaIXtp2shlKxzQdGhbyXIFlemETxUhIczihJm/XwmV
        ugj5nUIg3p6ISceD4I4CQDYtg//bPylN9Z1nQce5jwSs3XHEwdj356/RrqIwLwblxYBOuQgCbGfsg
        Wm0STDA54e+zNvxlyEMQbx2At28xTYPKco1dZwNaAAb6mCvQXWvnj05kWGdJeLi2rnHsP9XNh4eiq
        stI7usYg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNukR-00EHpx-Io; Fri, 03 Feb 2023 12:00:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69B9C30013F;
        Fri,  3 Feb 2023 13:00:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4387D212BDE6A; Fri,  3 Feb 2023 13:00:54 +0100 (CET)
Date:   Fri, 3 Feb 2023 13:00:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Hillf Danton <hdanton@sina.com>, Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+6cd18e123583550cf469@syzkaller.appspotmail.com>
Subject: Re: [syzbot] WARNING: locking bug in umh_complete
Message-ID: <Y9z3dvOH4SkQhU7w@hirez.programming.kicks-ass.net>
References: <20230127014137.4906-1-hdanton@sina.com>
 <9d9b9652-c1ac-58e9-2eab-9256c17b1da2@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d9b9652-c1ac-58e9-2eab-9256c17b1da2@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 07:22:43PM +0900, Tetsuo Handa wrote:
> On 2023/01/27 10:41, Hillf Danton wrote:

> >> Call Trace:
> >>  <TASK>
> >>  lock_acquire kernel/locking/lockdep.c:5668 [inline]
> >>  lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
> >>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >>  _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
> >>  complete+0x1d/0x1f0 kernel/sched/completion.c:32
> >>  umh_complete+0x32/0x90 kernel/umh.c:59
> >>  call_usermodehelper_exec_sync kernel/umh.c:144 [inline]
> >>  call_usermodehelper_exec_work+0x115/0x180 kernel/umh.c:167
> >>  process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
> >>  worker_thread+0x669/0x1090 kernel/workqueue.c:2436
> >>  kthread+0x2e8/0x3a0 kernel/kthread.c:376
> >>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> >>  </TASK>
> > 
> > This is an interesting case - given done initialized on stack, no garbage
> > should have been detected by lockdep.
> > 
> > One explanation to the report is uaf on the waker side, and it can be
> > tested with the diff below when a reproducer is available.
> > 
> > Hillf
> > 
> > --- a/kernel/umh.c
> > +++ b/kernel/umh.c
> > @@ -452,6 +452,12 @@ int call_usermodehelper_exec(struct subp
> >  		/* umh_complete() will see NULL and free sub_info */
> >  		if (xchg(&sub_info->complete, NULL))
> >  			goto unlock;
> > +		else {
> > +			/* wait for umh_complete() to finish in a bid to avoid
> > +			 * uaf because done is destructed
> > +			 */

Invalid comment style at the very least.

> > +			wait_for_completion(&done);
> > +		}
> >  	}
> >  
> >  wait_done:
> > --
> 
> Yes, this bug is caused by commit f5d39b020809 ("freezer,sched: Rewrite core freezer
> logic"), for that commit for unknown reason omits wait_for_completion(&done) call
> when wait_for_completion_state(&done, state) returned -ERESTARTSYS.
> 
> Peter, is it safe to restore wait_for_completion(&done) call?

Urgh, that code is terrible.. the way I read it was that it would
wait_for_completion_killable() if KILLABLE and assumed the
second wait_for_completion() would NOP out because we'd already
completed on the first.

I don't see how adding a second wait is correct in the case of
-ERESTARTSYS, what's the stop this second wait to also get interrupted
like that?

Should there be a loop?
