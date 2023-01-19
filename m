Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F316742AB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjASTVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjASTUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:20:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916B79DC87
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:20:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7395161D23
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 19:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32D4C433F0;
        Thu, 19 Jan 2023 19:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674156002;
        bh=sNtFF/n9MnZh/97jwulEfUXTbaxJQPrJ55JS7ZpWQ8A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GZFSCrODvWxbeYJIxgxvUyLH5Bhha6cEF9ov6eaWW972FVwxQeMbcwRyDHwfbqatd
         P+lNv8xWOCofVqyXl8boy2P+eIVwPkIxaXJx5Mnmck6tlpuHh3bCM08xuLF3UssXLw
         nyEJeHwbrLPEdL41bo1JPvo+KlSP+mGoRoqvqvXTnUuzNGWwFcHIUkEszYMJTrLIX8
         m9v6OwccgV9ALZdgTrAmRxHhoaUxoeNrZ/jjI3dMs8rcbqYmMHmxZNqetFqn81O0HS
         lAGAVg0qzxG943YwiktwaXoRb8EQm5WIN9BqRqpuUPxzTkfw8PedrY4/ToF2MJHls3
         o+f0eY20owrdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5E4BB5C1A49; Thu, 19 Jan 2023 11:20:02 -0800 (PST)
Date:   Thu, 19 Jan 2023 11:20:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in
 vm_area_free
Message-ID: <20230119192002.GX2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-40-surenb@google.com>
 <Y8k+syJu7elWAjRj@dhcp22.suse.cz>
 <CAJuCfpEAL9y70KJ_a=Z_kJpJnNC-ge1aN2ofTupeQ5-FaKh84g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEAL9y70KJ_a=Z_kJpJnNC-ge1aN2ofTupeQ5-FaKh84g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 10:52:03AM -0800, Suren Baghdasaryan wrote:
> On Thu, Jan 19, 2023 at 4:59 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 09-01-23 12:53:34, Suren Baghdasaryan wrote:
> > > call_rcu() can take a long time when callback offloading is enabled.
> > > Its use in the vm_area_free can cause regressions in the exit path when
> > > multiple VMAs are being freed. To minimize that impact, place VMAs into
> > > a list and free them in groups using one call_rcu() call per group.
> >
> > After some more clarification I can understand how call_rcu might not be
> > super happy about thousands of callbacks to be invoked and I do agree
> > that this is not really optimal.
> >
> > On the other hand I do not like this solution much either.
> > VM_AREA_FREE_LIST_MAX is arbitrary and it won't really help all that
> > much with processes with a huge number of vmas either. It would still be
> > in housands of callbacks to be scheduled without a good reason.
> >
> > Instead, are there any other cases than remove_vma that need this
> > batching? We could easily just link all the vmas into linked list and
> > use a single call_rcu instead, no? This would both simplify the
> > implementation, remove the scaling issue as well and we do not have to
> > argue whether VM_AREA_FREE_LIST_MAX should be epsilon or epsilon + 1.
> 
> Yes, I agree the solution is not stellar. I wanted something simple
> but this is probably too simple. OTOH keeping all dead vm_area_structs
> on the list without hooking up a shrinker (additional complexity) does
> not sound too appealing either. WDYT about time domain throttling to
> limit draining the list to say once per second like this:
> 
> void vm_area_free(struct vm_area_struct *vma)
> {
>        struct mm_struct *mm = vma->vm_mm;
>        bool drain;
> 
>        free_anon_vma_name(vma);
> 
>        spin_lock(&mm->vma_free_list.lock);
>        list_add(&vma->vm_free_list, &mm->vma_free_list.head);
>        mm->vma_free_list.size++;
> -       drain = mm->vma_free_list.size > VM_AREA_FREE_LIST_MAX;
> +       drain = jiffies > mm->last_drain_tm + HZ;
> 
>        spin_unlock(&mm->vma_free_list.lock);
> 
> -       if (drain)
> +       if (drain) {
>               drain_free_vmas(mm);
> +             mm->last_drain_tm = jiffies;
> +       }
> }
> 
> Ultimately we want to prevent very frequent call_rcu() calls, so
> throttling in the time domain seems appropriate. That's the simplest
> way I can think of to address your concern about a quick spike in VMA
> freeing. It does not place any restriction on the list size and we
> might have excessive dead vm_area_structs if after a large spike there
> are no vm_area_free() calls but I don't know if that's a real problem,
> so not sure we should be addressing it at this time. WDYT?

Just to double-check, we really did try the very frequent call_rcu()
invocations and we really did see a problem, correct?

Although it is not perfect, call_rcu() is designed to take a fair amount
of abuse.  So if we didn't see a real problem, the frequent call_rcu()
invocations might be a bit simpler.

							Thanx, Paul
