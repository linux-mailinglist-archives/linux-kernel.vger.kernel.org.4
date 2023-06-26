Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A9473E049
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjFZNPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjFZNOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:14:44 -0400
Received: from outbound-smtp46.blacknight.com (outbound-smtp46.blacknight.com [46.22.136.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DBD10A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:14:43 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id 43A69FABDD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 14:14:41 +0100 (IST)
Received: (qmail 26953 invoked from network); 26 Jun 2023 13:14:41 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.103])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Jun 2023 13:14:40 -0000
Date:   Mon, 26 Jun 2023 14:14:38 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 2/2] mm/page_alloc: Use write_seqlock_irqsave()
 instead write_seqlock() + local_irq_save().
Message-ID: <20230626131438.54bupbuujbqe4b5a@techsingularity.net>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-3-bigeasy@linutronix.de>
 <ZJXhxJU2jFccMjkg@dhcp22.suse.cz>
 <20230623201517.yw286Knb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230623201517.yw286Knb@linutronix.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 10:15:17PM +0200, Sebastian Andrzej Siewior wrote:
> __build_all_zonelists() acquires zonelist_update_seq by first disabling
> interrupts via local_irq_save() and then acquiring the seqlock with
> write_seqlock(). This is troublesome and leads to problems on
> PREEMPT_RT. The problem is that the inner spinlock_t becomes a sleeping
> lock on PREEMPT_RT and must not be acquired with disabled interrupts.
> 
> The API provides write_seqlock_irqsave() which does the right thing in
> one step.
> printk_deferred_enter() has to be invoked in non-migrate-able context to
> ensure that deferred printing is enabled and disabled on the same CPU.
> This is the case after zonelist_update_seq has been acquired.
> 
> There was discussion on the first submission that the order should be:
> 	local_irq_disable();
> 	printk_deferred_enter();
> 	write_seqlock();
> 
> to avoid pitfalls like having an unaccounted printk() coming from
> write_seqlock_irqsave() before printk_deferred_enter() is invoked. The
> only origin of such a printk() can be a lockdep splat because the
> lockdep annotation happens after the sequence count is incremented.
> This is exceptional and subject to change.
> 
> It was also pointed that PREEMPT_RT can be affected by the printk
> problem since its write_seqlock_irqsave() does not really disable
> interrupts. This isn't the case because PREEMPT_RT's printk
> implementation differs from the mainline implementation in two important
> aspects:
> - Printing happens in a dedicated threads and not at during the
>   invocation of printk().
> - In emergency cases where synchronous printing is used, a different
>   driver is used which does not use tty_port::lock.
> 
> Acquire zonelist_update_seq with write_seqlock_irqsave() and then defer
> printk output.
> 
> Fixes: 1007843a91909 ("mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
