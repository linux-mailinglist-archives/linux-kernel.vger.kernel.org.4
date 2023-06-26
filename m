Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FCB73E04D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjFZNQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjFZNQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:16:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BCC125
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:16:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A34C51F896;
        Mon, 26 Jun 2023 13:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687785369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sxr7NE9BPbbo/jsxfHlnNeotXkyELOXzCC549+pDCjE=;
        b=GNr7J8UB8CfYSClNe8OFHRnp2aV1oCBLQ3iCKYNOlVWam5EN4a56PnewlemRsTLEmDLMTU
        eKXGGJr1Nr/sKIXvGteqfkQdD7MeqCBGwVaqH85lA/mzcPGH8lCa688rGmtNHSGYYmT9Y7
        0XFeTdKNDaKLLQXr1809WB35vlLoOMw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CA0013483;
        Mon, 26 Jun 2023 13:16:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gTcLHJmPmWR/YQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 26 Jun 2023 13:16:09 +0000
Date:   Mon, 26 Jun 2023 15:16:08 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/2] seqlock: Do the lockdep annotation before locking
 in do_write_seqcount_begin_nested()
Message-ID: <ZJmPmMzFk1nCDYc9@dhcp22.suse.cz>
References: <20230623171232.892937-1-bigeasy@linutronix.de>
 <20230623171232.892937-2-bigeasy@linutronix.de>
 <d9b7c170-ed0d-5d37-e099-20d233115943@I-love.SAKURA.ne.jp>
 <20230626081254.XmorFrhs@linutronix.de>
 <0a0c768c-227d-c0cd-1b91-5a884d161c1b@I-love.SAKURA.ne.jp>
 <20230626104831.GT4253@hirez.programming.kicks-ass.net>
 <3a4ad958-a9a5-c367-a16d-bd89a173a628@I-love.SAKURA.ne.jp>
 <ZJl4C7aVk3gLLyMs@dhcp22.suse.cz>
 <c6ad3e8f-cccf-fede-de1b-7a9c56594f36@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ad3e8f-cccf-fede-de1b-7a9c56594f36@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-06-23 21:27:05, Tetsuo Handa wrote:
> On 2023/06/26 20:35, Michal Hocko wrote:
> > On Mon 26-06-23 20:26:02, Tetsuo Handa wrote:
> >> On 2023/06/26 19:48, Peter Zijlstra wrote:
> >>> On Mon, Jun 26, 2023 at 06:25:56PM +0900, Tetsuo Handa wrote:
> >>>> On 2023/06/26 17:12, Sebastian Andrzej Siewior wrote:
> >>>>> On 2023-06-24 15:54:12 [+0900], Tetsuo Handa wrote:
> >>>>>> Why not to do the same on the end side?
> >>>>>>
> >>>>>>  static inline void do_write_seqcount_end(seqcount_t *s)
> >>>>>>  {
> >>>>>> - 	seqcount_release(&s->dep_map, _RET_IP_);
> >>>>>>  	do_raw_write_seqcount_end(s);
> >>>>>> +	seqcount_release(&s->dep_map, _RET_IP_);
> >>>>>>  }
> >>>>>
> >>>>> I don't have a compelling argument for doing it. It is probably better
> >>>>> to release the lock from lockdep's point of view and then really release
> >>>>> it (so it can't be acquired before it is released).
> >>>>
> >>>> We must do it because this is a source of possible printk() deadlock.
> >>>> Otherwise, I will nack on PATCH 2/2.
> >>>
> >>> Don't be like that... just hate on prink like the rest of us. In fact,
> >>> i've been patching out the actual printk code for years because its
> >>> unusable garbage.
> >>>
> >>> Will this actually still be a problem once all the fancy printk stuff
> >>> lands? That shouldn't do synchronous prints except to 'atomic' consoles
> >>> by default IIRC.
> >>
> >> Commit 1007843a9190 ("mm/page_alloc: fix potential deadlock on zonelist_update_seq
> >> seqlock") was applied to 4.14-stable trees, and CONFIG_PREEMPT_RT is available
> >> since 5.3. Thus, we want a fix which can be applied to 5.4-stable and later.
> >> This means that we can't count on all the fancy printk stuff being available.
> > 
> > Is there any reason to backport RT specific fixup to stable trees? I
> > mean seriously, is there any actual memory hotplug user using
> > PREEMPT_RT? I would be more than curious to hear the usecase.
> 
> Even if we don't backport RT specific fixup to stable trees, [PATCH 2/2] requires
> that [PATCH 1/2] guarantees that synchronous printk() never happens (for whatever
> reasons) between write_seqlock_irqsave(&zonelist_update_seq, flags) and
> write_sequnlock_irqrestore(&zonelist_update_seq, flags).

I suspect you are overcomplicating this. I do understand that you want
to have this 100% airtight but I would argue that this is actually not
really necessary. I would be perfectly fine living in the world where
this particular path could trigger an unintended printk. IIUC we are
mostly talking about lockup detector only, right? AFAIK there is no such
na issue _now_ so we are talking about a potential _risk_ only.
 
> If [PATCH 1/2] cannot guarantee it, [PATCH 2/2] will be automatically rejected.
> 
> If [PATCH 2/2] cannot be applied, we have several alternatives.
> 
> Alternative 1:
> 
>   Revert both commit 3d36424b3b58 ("mm/page_alloc: fix race condition between build_all_zonelists and page allocation")
>   and commit 1007843a9190 ("mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock").
>   I don't think this will happen, for nobody will be happy.
> 
> Alternative 2:
> 
>   Revert commit 1007843a9190 ("mm/page_alloc: fix potential deadlock on zonelist_update_seq seqlock")
>   and apply "mm/page_alloc: don't check zonelist_update_seq from atomic allocations" at
>   https://lkml.kernel.org/r/dfdb9da6-ca8f-7a81-bfdd-d74b4c401f11@I-love.SAKURA.ne.jp .
>   I think this is reasonable, for this reduces locking dependency. But Michal Hocko did not like it.
> 
> Alternative 3:
> 
>   Somehow preserve printk_deferred_enter() => write_seqlock(&zonelist_update_seq) and
>   write_sequnlock(&zonelist_update_seq) => printk_deferred_exit() pattern. Something like below?
> 

Alternative 4:
stop chasing shadows and deal with the fact that this code won't be
perfect. Seriously you are trying to address a non-existing problem and
blocking a working RT solution which doesn't clutter the code with RT
specific baggage.
-- 
Michal Hocko
SUSE Labs
