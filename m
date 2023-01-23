Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF39D678291
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjAWRHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjAWRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:07:50 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B01618C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:07:48 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id 123so15665859ybv.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0FW2Lu3pQY4jZR84HYv4JQ4VKgnKPsvFkN66d0OQdfk=;
        b=Rdkh5YvSKKbAMeVrmVNplinHHWb9L0j8rdsuQhapYgNXgo2gD8OT9rPe2ZaYeKAx5E
         pquLD54vscJdCDSHhWXmL1EWzDt5pyAG1htz3dnPZFHMU65k7/ecAz8h560ev1Whkpkx
         GmJi3/qAY1SytqJGcHyL7ZauQwcXJIeewko/PfLsfneDZVVLvC6oLIKSy4xP3e27K+yS
         i+du5yv0dwEDCaLuKuAjKsXUTksGEyuqnkOl0M4LdMY5aXamVLJ2M8zCnWuE09jvAmuF
         sB/MZ98fMFzyGzj/8ucdRz1+7hR1rvsj7rFOBbeWzzRB8MHHZmcx/qo6hKDyOuhNc/f8
         Lcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0FW2Lu3pQY4jZR84HYv4JQ4VKgnKPsvFkN66d0OQdfk=;
        b=jPOxV27NFBMBfA4x8+FZE3AcptMC3Ojxsy/vjxL8iOESw2J6Npq8i5FvIep+H7HHeH
         46cjUpNa+aYsU3V+9NH5KCy5A8Fmy68uxfQ/tECZEIkMJBK/er7LammhYfq7bZyW+Uia
         QO5X8RthUjXfTGIN88f/LLFwiWilMELGQ/zsnzISf0Re3wB2ekc2uH1TuBQlNubWwQOK
         4pSrJX8ZiNzEwwbG6imAVKBwPY4pnoD17nBc3XaKNP0BrZkrwch+G3F1vriGF/TASyTJ
         pqnC0aAQbMBs8/KcKo6+9878Doy7QWUXyrAdKiQoD01PGYvkXmzNc2rAQ4IVFdCR7lvG
         nQjA==
X-Gm-Message-State: AFqh2krwe76TaO6U4/tMgQ6mrkd8cyChqZqG69NXWaTJ+/aZSj01evkZ
        zwpkMg7Vx+anT9KG7d/pYkvt4i0MHVqSy5l/XvkTEg==
X-Google-Smtp-Source: AMrXdXuiJMyjRQftHqmMyvImwNLCOEQZDFoh5cTDm5Yhcc0MUbhCxbDK85e3u9MmqqS9nUopxnOnX6EdJLA1Sjcj6S4=
X-Received: by 2002:a25:ceca:0:b0:7e4:115c:9cf6 with SMTP id
 x193-20020a25ceca000000b007e4115c9cf6mr2777687ybe.316.1674493667105; Mon, 23
 Jan 2023 09:07:47 -0800 (PST)
MIME-Version: 1.0
References: <Y8pWW9Am3mDP53qJ@dhcp22.suse.cz> <CAJuCfpHeuckG8YuNTgdDcNHNzJ3sQExD_f1hwXG_xmS7Z-925g@mail.gmail.com>
 <CAJuCfpF20nuP6Meib9h7NVrJv+wybYS==vZFQXxUW6n-ir9bvQ@mail.gmail.com>
 <Y8rGJq8LvX2C+Cr7@casper.infradead.org> <20230120170815.yuylbs27r6xcjpq5@revolver>
 <CAJuCfpH4o-iCmzdUcYD9bKieJ6-k-MZYLuHFhH+bN9yE07sibw@mail.gmail.com>
 <Y8rQNj5dVyuxRBOf@casper.infradead.org> <CAJuCfpG3YaExGkzsSSm0tXjMiSoM6rVf0JQgfrWu4UY5gsw=-w@mail.gmail.com>
 <Y85Z0Ovl68o4cz2j@dhcp22.suse.cz> <CAJuCfpG86qc4odkpUbzuROb+jThQgXGWjcFXb0e-c2i0wEGg4g@mail.gmail.com>
 <Y868Fadajv27QMXh@dhcp22.suse.cz>
In-Reply-To: <Y868Fadajv27QMXh@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 23 Jan 2023 09:07:34 -0800
Message-ID: <CAJuCfpGSCHpnZwwVV_922fmMBpFPZL0HAHMABuDzMfuURF2sWg@mail.gmail.com>
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in vm_area_free
To:     Michal Hocko <mhocko@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
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

On Mon, Jan 23, 2023 at 8:55 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 23-01-23 08:22:53, Suren Baghdasaryan wrote:
> > On Mon, Jan 23, 2023 at 1:56 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 20-01-23 09:50:01, Suren Baghdasaryan wrote:
> > > > On Fri, Jan 20, 2023 at 9:32 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > [...]
> > > > > The page fault handler (or whatever other reader -- ptrace, proc, etc)
> > > > > should have a refcount on the mm_struct, so we can't be in this path
> > > > > trying to free VMAs.  Right?
> > > >
> > > > Hmm. That sounds right. I checked process_mrelease() as well, which
> > > > operated on mm with only mmgrab()+mmap_read_lock() but it only unmaps
> > > > VMAs without freeing them, so we are still good. Michal, do you agree
> > > > this is ok?
> > >
> > > Don't we need RCU procetions for the vma life time assurance? Jann has
> > > already shown how rwsem is not safe wrt to unlock and free without RCU.
> >
> > Jann's case requires a thread freeing the VMA to be blocked on vma
> > write lock waiting for the vma real lock to be released by a page
> > fault handler. However exit_mmap() means mm->mm_users==0, which in
> > turn suggests that there are no racing page fault handlers and no new
> > page fault handlers will appear. Is that a correct assumption? If so,
> > then races with page fault handlers can't happen while in exit_mmap().
> > Any other path (other than page fault handlers), accesses vma->lock
> > under protection of mmap_lock (for read or write, does not matter).
> > One exception is when we operate on an isolated VMA, then we don't
> > need mmap_lock protection, but exit_mmap() does not deal with isolated
> > VMAs, so out of scope here. exit_mmap() frees vm_area_structs under
> > protection of mmap_lock in write mode, so races with anything other
> > than page fault handler should be safe as they are today.
>
> I do not see you talking about #PF (RCU + vma read lock protected) with
> munmap. It is my understanding that the latter will synchronize over per
> vma lock (along with mmap_lock exclusive locking). But then we are back
> to the lifetime guarantees, or do I miss anything.

munmap() or any VMA-freeing operation other than exit_mmap() will free
using call_rcu(), as implemented today. The suggestion is to free VMAs
directly, without RCU grace period only when done from exit_mmap().
That' because VMA freeing flood has been seen so far only in the case
of exit_mmap() and we assume other cases are not that heavy to cause
call_rcu() flood to cause regressions. That assumption might prove
false but we can deal with that once we know it needs fixing.

> --
> Michal Hocko
> SUSE Labs
