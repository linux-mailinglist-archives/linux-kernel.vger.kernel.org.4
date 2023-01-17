Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DE8670D69
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjAQX3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjAQX1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:27:43 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94EF38E82
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:28:42 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4c24993965eso435135767b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ov2HI3CdUQ+o/zqidsM3mX5Kp69NRx9NtPM0yxA19Es=;
        b=c9xxkcGEP3Ye/quI/NFLI8jX0YnrLxNGnHqR2fp0OMlpXEArjj/pF1vQu/FvXtpDdy
         2P3XSqLuk+kmfjnG6rpYrZFmaItZxF+QA1BzlBIFrCRrvOZ7YZaC7BuiM4sInT4nNTss
         P39YoaUBH1WHbYoxEBnNjRWMRcXtkydMsdBc9smvgMcDl+gePUxacD7TDnjmd+Ok8eHr
         UCtEUzGYQgr0JB2aA69UpZhKaYnCxA+E7CxSM5Ppx35IoEiRJVfF5n7xQNPiI80P/duK
         Iq5CwSrKFuLK9FbJJaqWXyM/YWpuN1Uqh0jrUd3BfTc4NHQaTV0IouF4IWoF3Y5UXvCI
         ondg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ov2HI3CdUQ+o/zqidsM3mX5Kp69NRx9NtPM0yxA19Es=;
        b=xxbRSikSqk8LQ7cGVsZD+3qQF37XFduEz/K+EFtdi97/ibNm9SbsuwQzCJMMYFSxRH
         34/4doQW0WVYn39NHkU5UIrSUAmunvmxMLbIMtEE/v+Obn5BBgBVcm4OwHqD8aOQGa38
         Rgs9fl+fjVQy9VbxBtDi/bQxdsWyDpS5g5Qam4EBEGQ2YOJsct7mO0HwGdZihjcXD+EC
         1rAoXWY3BDRtrOyjrZImrBeurP5DT+jv21lqQ8epj+b5VhmL9RXi4O2iFZJGgW8FWFeX
         fvN9KSL4qKjbHIHzfAFckaxIyRTyW6mYVPrrjog3hK5niF1I35JDeT2/g9koFE/P7Te/
         jjXw==
X-Gm-Message-State: AFqh2krRgYiyiv+RvJ1QL3Ook0dfePFXBv3E2jivL8nlk6ITlPnnczE+
        fjH1+aH2xXXzMNGv4/HQf4a5v4fNUijpwSdzS0zMvw==
X-Google-Smtp-Source: AMrXdXvNbPUYj/FTXP9jMwGpFUtrl5UX+b/2dnT1jMx2j8lGwbfTbtmjUt5vhRCKMdkNLOmIJWYnhuJB9a8X5pfKXE8=
X-Received: by 2002:a81:6d8d:0:b0:490:89c3:21b0 with SMTP id
 i135-20020a816d8d000000b0049089c321b0mr610621ywc.132.1673990920942; Tue, 17
 Jan 2023 13:28:40 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-13-surenb@google.com>
 <CAG48ez0RhQ6=W01brLUXDXqQxz2M1FEMNqd2OvL+LhcJQY=NqA@mail.gmail.com>
In-Reply-To: <CAG48ez0RhQ6=W01brLUXDXqQxz2M1FEMNqd2OvL+LhcJQY=NqA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 13:28:27 -0800
Message-ID: <CAJuCfpHawn-hj3yK6MEMHsvnH9xgO87h7Sj3_g0FA7rgut_mVg@mail.gmail.com>
Subject: Re: [PATCH 12/41] mm: add per-VMA lock and helper functions to
 control it
To:     Jann Horn <jannh@google.com>
Cc:     peterz@infradead.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, hughlynch@google.com, leewalsh@google.com,
        posk@google.com, linux-mm@kvack.org,
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

On Tue, Jan 17, 2023 at 10:03 AM Jann Horn <jannh@google.com> wrote:
>
> +locking maintainers

Thanks! I'll CC the locking maintainers in the next posting.

>
> On Mon, Jan 9, 2023 at 9:54 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > Introduce a per-VMA rw_semaphore to be used during page fault handling
> > instead of mmap_lock. Because there are cases when multiple VMAs need
> > to be exclusively locked during VMA tree modifications, instead of the
> > usual lock/unlock patter we mark a VMA as locked by taking per-VMA lock
> > exclusively and setting vma->lock_seq to the current mm->lock_seq. When
> > mmap_write_lock holder is done with all modifications and drops mmap_lock,
> > it will increment mm->lock_seq, effectively unlocking all VMAs marked as
> > locked.
> [...]
> > +static inline void vma_read_unlock(struct vm_area_struct *vma)
> > +{
> > +       up_read(&vma->lock);
> > +}
>
> One thing that might be gnarly here is that I think you might not be
> allowed to use up_read() to fully release ownership of an object -
> from what I remember, I think that up_read() (unlike something like
> spin_unlock()) can access the lock object after it's already been
> acquired by someone else. So if you want to protect against concurrent
> deletion, this might have to be something like:
>
> rcu_read_lock(); /* keeps vma alive */
> up_read(&vma->lock);
> rcu_read_unlock();

But for deleting VMA one would need to write-lock the vma->lock first,
which I assume can't happen until this up_read() is complete. Is that
assumption wrong?

>
> But I'm not entirely sure about that, the locking folks might know better.
>
> Also, it might not matter given that the rw_semaphore part is removed
> in the current patch 41/41 anyway...

This does matter because Michal suggested dropping that last 41/41
patch for now.
