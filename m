Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB5A67853A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjAWSrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjAWSrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:47:16 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2335B4497
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:47:15 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-4a263c4ddbaso185983377b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EEZWpRCqDnFRlmuW2ysCODSPytTJZRpx7aAYLqFc7io=;
        b=XUYoLqkWsCaBJ04HPvri04PJii+UnFNZfkttGO5DhZ8O2cDkfdoED9gTGKUpCW9h1a
         JBcTELRdCohSIRirMa+mImJm53I336wxROakhil5KRb9AkilXbhbOf8RDwpNO5TUNRN6
         5v1+iN4dIzrHw8ZxFeWt3klOFn3U+XFIWQpG90bfiWFj3EU8yyCx+D4tyHkyiB5MXlEH
         hHlT66itrO9FizYgORvZRn5EsQbfXCI4h1yRuSQMhdrtoQQExigoat0ejKguLIelNJmb
         HKo6I8eKidhP2zQ97/alMJnO+/yx1DXIiS5235nyc/LfXHwRMP9rsCWu2SLVdJz56lXN
         bCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEZWpRCqDnFRlmuW2ysCODSPytTJZRpx7aAYLqFc7io=;
        b=NgyJnUbHQDxTFWssESNMn2hKPUbV22YOMBtSCMCYzaCwhlKE1+3eBPuK7u/1JqMJmj
         +rztLEtEdrM/MIqRML47rc9zDGdbBJ5MLoSu3Qu6M+2f7AaGqJc6dkBn9NDD1Or0PzqC
         /mvgKy/o8/QkxxBsuksFSJgB8EVrDo4oUaEy8KlGrnkqa+IE80Nd9bE7xUKIet+dfvvB
         TTQrMQTmSzdw4OgGuVFQl0ACmtqP7grQHaRN1f+c5V+h7djzzb2llkORmAMylh7kOp5P
         DTIi49W/0XhRtX7yJOp+DCpIECwoF73HUIpRLPY4LCdv0EioIj1mbmEfz9RvBoJNeA0n
         100A==
X-Gm-Message-State: AFqh2kphd+qFgmllala8cZ7oLuBoaWpXaTj4qu3UOBP6wQLK2g6/HdDs
        ZXhgv1Io92bJS6OhJ2IT/IKsJWsxh9GCnbynBsdLpw==
X-Google-Smtp-Source: AMrXdXulFktynQi9i95G9lw3C1GDLWNlJVNyrZN3qPgr/W6spDmnmjN0faCW1cv674kzUn8t1U2hk+KJr7613dnjJc4=
X-Received: by 2002:a81:708c:0:b0:479:b6a1:d9a4 with SMTP id
 l134-20020a81708c000000b00479b6a1d9a4mr2744223ywc.263.1674499634132; Mon, 23
 Jan 2023 10:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20230120170815.yuylbs27r6xcjpq5@revolver> <CAJuCfpH4o-iCmzdUcYD9bKieJ6-k-MZYLuHFhH+bN9yE07sibw@mail.gmail.com>
 <Y8rQNj5dVyuxRBOf@casper.infradead.org> <CAJuCfpG3YaExGkzsSSm0tXjMiSoM6rVf0JQgfrWu4UY5gsw=-w@mail.gmail.com>
 <Y85Z0Ovl68o4cz2j@dhcp22.suse.cz> <CAJuCfpG86qc4odkpUbzuROb+jThQgXGWjcFXb0e-c2i0wEGg4g@mail.gmail.com>
 <Y868Fadajv27QMXh@dhcp22.suse.cz> <CAJuCfpGSCHpnZwwVV_922fmMBpFPZL0HAHMABuDzMfuURF2sWg@mail.gmail.com>
 <Y87A2CEKAugfgfHC@dhcp22.suse.cz> <CAJuCfpGJRZATfc8eUurvV5kGkSNkG=vK=sfwJbU72PESOyATSw@mail.gmail.com>
 <Y87QjHH2aDG5XCGv@casper.infradead.org>
In-Reply-To: <Y87QjHH2aDG5XCGv@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 23 Jan 2023 10:47:02 -0800
Message-ID: <CAJuCfpGZVL+pRbooamUwOdSMahvnTX-rzf6Ag+sZqiPqhSbK0A@mail.gmail.com>
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in vm_area_free
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 10:23 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Jan 23, 2023 at 09:46:20AM -0800, Suren Baghdasaryan wrote:
> > On Mon, Jan 23, 2023 at 9:16 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 23-01-23 09:07:34, Suren Baghdasaryan wrote:
> > > > On Mon, Jan 23, 2023 at 8:55 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Mon 23-01-23 08:22:53, Suren Baghdasaryan wrote:
> > > > > > On Mon, Jan 23, 2023 at 1:56 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > >
> > > > > > > On Fri 20-01-23 09:50:01, Suren Baghdasaryan wrote:
> > > > > > > > On Fri, Jan 20, 2023 at 9:32 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > > > [...]
> > > > > > > > > The page fault handler (or whatever other reader -- ptrace, proc, etc)
> > > > > > > > > should have a refcount on the mm_struct, so we can't be in this path
> > > > > > > > > trying to free VMAs.  Right?
> > > > > > > >
> > > > > > > > Hmm. That sounds right. I checked process_mrelease() as well, which
> > > > > > > > operated on mm with only mmgrab()+mmap_read_lock() but it only unmaps
> > > > > > > > VMAs without freeing them, so we are still good. Michal, do you agree
> > > > > > > > this is ok?
> > > > > > >
> > > > > > > Don't we need RCU procetions for the vma life time assurance? Jann has
> > > > > > > already shown how rwsem is not safe wrt to unlock and free without RCU.
> > > > > >
> > > > > > Jann's case requires a thread freeing the VMA to be blocked on vma
> > > > > > write lock waiting for the vma real lock to be released by a page
> > > > > > fault handler. However exit_mmap() means mm->mm_users==0, which in
> > > > > > turn suggests that there are no racing page fault handlers and no new
> > > > > > page fault handlers will appear. Is that a correct assumption? If so,
> > > > > > then races with page fault handlers can't happen while in exit_mmap().
> > > > > > Any other path (other than page fault handlers), accesses vma->lock
> > > > > > under protection of mmap_lock (for read or write, does not matter).
> > > > > > One exception is when we operate on an isolated VMA, then we don't
> > > > > > need mmap_lock protection, but exit_mmap() does not deal with isolated
> > > > > > VMAs, so out of scope here. exit_mmap() frees vm_area_structs under
> > > > > > protection of mmap_lock in write mode, so races with anything other
> > > > > > than page fault handler should be safe as they are today.
> > > > >
> > > > > I do not see you talking about #PF (RCU + vma read lock protected) with
> > > > > munmap. It is my understanding that the latter will synchronize over per
> > > > > vma lock (along with mmap_lock exclusive locking). But then we are back
> > > > > to the lifetime guarantees, or do I miss anything.
> > > >
> > > > munmap() or any VMA-freeing operation other than exit_mmap() will free
> > > > using call_rcu(), as implemented today. The suggestion is to free VMAs
> > > > directly, without RCU grace period only when done from exit_mmap().
> > >
> > > OK, I have clearly missed that. This makes more sense but it also adds
> > > some more complexity and assumptions - a harder to maintain code in the
> > > end. Whoever wants to touch this scheme in future would have to
> > > re-evaluate all of them. So, I would just avoid that special casing if
> > > that is feasible.
> >
> > Ok, I understand your point.
> >
> > >
> > > Dealing with the flood of call_rcu during exit_mmap is a trivial thing
> > > to deal with as proposed elsewhere (just batch all of them in a single
> > > run). This will surely add some more code but at least the locking would
> > > consistent.
> >
> > Yes, batching the vmas into a list and draining it in remove_mt() and
> > exit_mmap() as you suggested makes sense to me and is quite simple.
> > Let's do that if nobody has objections.
>
> I object.  We *know* nobody has a reference to any of the VMAs because
> you have to have a refcount on the mm before you can get a reference
> to a VMA.  If Michal is saying that somebody could do:
>
>         mmget(mm);
>         vma = find_vma(mm);
>         lock_vma(vma);
>         mmput(mm);
>         vma->a = b;
>         unlock_vma(mm, vma);

More precisely, it's:
         mmget(mm);
         vma = lock_vma_under_rcu(mm, addr); -> calls vma_read_trylock(vma)
         mmput(mm);
         vma->a = b;
         vma_read_unlock(vma);

To be fair, vma_read_unlock() does not take mm as a parameter, so one
could have an impression that mm doesn't need to be pinned at the time
of its call.


>
> then that's something we'd catch in review -- you obviously can't use
> the mm after you've dropped your reference to it.
>
> Having all this extra code to solve two problems badly is a very poor
> choice.  We have two distinct problems, each of which has a simple,
> efficient solution.
>
