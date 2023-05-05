Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FDE6F7F2D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjEEIgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjEEIgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:36:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5F617FF5
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 01:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e1TkxjYsiEXsfClsV4v52Vou4gXGXVMmKNos6iSrf1s=; b=Gvo6oV5K7nj2izacjFFTf/9fdJ
        r5rp7L2mTGvVOA9PsqMN/nlyhKLKXneZXmluxjCk3bZ5T7zfINkmpeq2Ow/dY9pDfjY8JCI+gVoqO
        DcJT1z3pYXS6UW1epgM8ipMxOELNsMaFh8pAGsj1PS+nJ2KWQXI9BPQtl+LR4NY4fCDYf0QcBfIlE
        noBYUSxgDRjtMjQuqhrQrgMSibcCYeVLdDQHaLhAiVCDTNlikblual7E6ytDd1RnAj5D+ZbtVwDUA
        vu/5/BZywWbpPmUvT8Ap0TfA4KXj48Ac488hW4QzQzHQCMDtnzOhFCijP0NoAYL0I+ClaAerygy31
        HAOIPbpQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puqus-003CNr-33;
        Fri, 05 May 2023 08:35:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D0CF30022D;
        Fri,  5 May 2023 10:35:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5520C23CC0167; Fri,  5 May 2023 10:35:49 +0200 (CEST)
Date:   Fri, 5 May 2023 10:35:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+222aa26d0a5dbc2e84fe@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] INFO: task hung in synchronize_rcu (4)
Message-ID: <20230505083549.GB1770668@hirez.programming.kicks-ass.net>
References: <20230504061613.3901-1-hdanton@sina.com>
 <7ea26a76-5c8c-a0d2-5b5e-63e370cdcb99@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ea26a76-5c8c-a0d2-5b5e-63e370cdcb99@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 04:01:23PM +0900, Tetsuo Handa wrote:
> On 2023/05/04 15:16, Hillf Danton wrote:
> >> 4 locks held by syz-executor.2/5077:
> >>  #0: ffff8880b993c2d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2f/0x120 kernel/sched/core.c:539
> >>  #1: ffff88802296aef0 (&mm->cid_lock#2){....}-{2:2}, at: mm_cid_get kernel/sched/sched.h:3280 [inline]
> >>  #1: ffff88802296aef0 (&mm->cid_lock#2){....}-{2:2}, at: switch_mm_cid kernel/sched/sched.h:3302 [inline]
> >>  #1: ffff88802296aef0 (&mm->cid_lock#2){....}-{2:2}, at: prepare_task_switch kernel/sched/core.c:5117 [inline]
> >>  #1: ffff88802296aef0 (&mm->cid_lock#2){....}-{2:2}, at: context_switch kernel/sched/core.c:5258 [inline]
> >>  #1: ffff88802296aef0 (&mm->cid_lock#2){....}-{2:2}, at: __schedule+0x2802/0x5770 kernel/sched/core.c:6625
> >>  #2: ffff8880b9929698 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x5a/0x1f0 kernel/time/timer.c:999
> >>  #3: ffffffff91fb4ac8 (&obj_hash[i].lock){-.-.}-{2:2}, at: debug_object_activate+0x134/0x3f0 lib/debugobjects.c:690
> > 
> > What is hard to understand in this report is, how could acquire the
> > timer base lock with the mm cid lock held [1]?
> 
> Please be aware that lockdep_print_held_locks() is not an atomic action.
> Since synchronous printk() is slow, it can sometimes happen that
> task_is_running(p) becomes true after passing the
> 
> 	if (p != current && task_is_running(p))
> 		return;
> 
> check. I think that this trace is an example where print_lock() by chance hit
> hlock_class(p->held_locks + 2) != NULL. If sched_show_task() were also available,
> we can know it via mismatch between sched_show_task() and lockdep_print_held_locks().
> 
> Linus, I think that "[PATCH v3 (repost)] locking/lockdep: add debug_show_all_lock_holders()"
> helps here, but I can't wake up locking people. What can we do?

How is that not also racy ?

I think I've seen that patch, and it had a some 'blurb' Changelog that
leaves me wondering wtf the actual problem is and how it attempts to
solve it and I went on with looking at regressions because more
important than random weird patch.
