Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C5A678386
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjAWRqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAWRqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:46:33 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652021E5FD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:46:32 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 188so15801464ybi.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XGfK59iWA2VlvgRXkqRDqLtLKye7Z5SSTP2RGu4Ar9c=;
        b=SdR/39hwgrAyKI4iGTaqEHY0PZx07Qq2iedH3AUTUZ1UbDUzkBukyUzn44oMlC56Q3
         lkroO9Cs7sD/B778Bv2Qfm5VLknd6XgJWRlnBxIG40CWw30+itJvuAQtdRVW9AH1Xay1
         KHj4xgWmJVEYuFp1ks8zPeSyal00rHWScfhwzQK3TM6RuZ9KJBIooS8YCnaAfUjDoSaR
         OKvFhrSSIlS7uiQQ/Jz51PzTN/X8l55QxRJYPJV2dK0vYMsU2JePdTp7/piHNQHUsCuO
         xKSnavE7rZxGa/wdyvkSpsuC03skPO5h7FOhPT10JRmp/3aHuwtuBNCTcnCuwJlm9dGH
         BTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGfK59iWA2VlvgRXkqRDqLtLKye7Z5SSTP2RGu4Ar9c=;
        b=EyuXvb3lY7IqZNH36oM44oBR7EUrvaA4Y6JqinI1sGpdxdNQHHB1X5ryJFdNCdMl4+
         0FzcGiu5vJgmPqJgU7rhv4qtGDLRqn4UEnohD56w214n306ji+jfob4N1qk3pwk0jJrt
         Qgjz+VutZMP/luESDtMuM3xinMrslsKzP5eTRxRkIElJ8movOplBcd7OfHjXws3/9SrG
         WGq0b0gy/JkF+unG0W4W6p0EjdOhe7I0i+kKV8Mp1p/kaPdGSXpY6w9eZOauc+IW5Vbw
         /R31/rKs6VLY7rvPdVugpq1viNO8QqvZvag1518KdjbQx+aQkWSxfHGeb6aV4vnjEDTC
         tz7A==
X-Gm-Message-State: AFqh2kquxKCxrxcgnb9g7T2VsSrGqToTheJGRpitOYBVjlwaRgNAarCT
        jrndJo8iRPzoR01ViJy2csKwu2Nrn11XIoYXysgw4A==
X-Google-Smtp-Source: AMrXdXteaJfzBdOfhYOTTo0923koQH1CezojDs1FTte0YsILtf2ySXsBRH58x0a8KuKynJ5TyY0FxTcWX+1TjHC2E1Q=
X-Received: by 2002:a25:9801:0:b0:7d5:b884:3617 with SMTP id
 a1-20020a259801000000b007d5b8843617mr2229246ybo.380.1674495991353; Mon, 23
 Jan 2023 09:46:31 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpF20nuP6Meib9h7NVrJv+wybYS==vZFQXxUW6n-ir9bvQ@mail.gmail.com>
 <Y8rGJq8LvX2C+Cr7@casper.infradead.org> <20230120170815.yuylbs27r6xcjpq5@revolver>
 <CAJuCfpH4o-iCmzdUcYD9bKieJ6-k-MZYLuHFhH+bN9yE07sibw@mail.gmail.com>
 <Y8rQNj5dVyuxRBOf@casper.infradead.org> <CAJuCfpG3YaExGkzsSSm0tXjMiSoM6rVf0JQgfrWu4UY5gsw=-w@mail.gmail.com>
 <Y85Z0Ovl68o4cz2j@dhcp22.suse.cz> <CAJuCfpG86qc4odkpUbzuROb+jThQgXGWjcFXb0e-c2i0wEGg4g@mail.gmail.com>
 <Y868Fadajv27QMXh@dhcp22.suse.cz> <CAJuCfpGSCHpnZwwVV_922fmMBpFPZL0HAHMABuDzMfuURF2sWg@mail.gmail.com>
 <Y87A2CEKAugfgfHC@dhcp22.suse.cz>
In-Reply-To: <Y87A2CEKAugfgfHC@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 23 Jan 2023 09:46:20 -0800
Message-ID: <CAJuCfpGJRZATfc8eUurvV5kGkSNkG=vK=sfwJbU72PESOyATSw@mail.gmail.com>
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

On Mon, Jan 23, 2023 at 9:16 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 23-01-23 09:07:34, Suren Baghdasaryan wrote:
> > On Mon, Jan 23, 2023 at 8:55 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 23-01-23 08:22:53, Suren Baghdasaryan wrote:
> > > > On Mon, Jan 23, 2023 at 1:56 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Fri 20-01-23 09:50:01, Suren Baghdasaryan wrote:
> > > > > > On Fri, Jan 20, 2023 at 9:32 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > [...]
> > > > > > > The page fault handler (or whatever other reader -- ptrace, proc, etc)
> > > > > > > should have a refcount on the mm_struct, so we can't be in this path
> > > > > > > trying to free VMAs.  Right?
> > > > > >
> > > > > > Hmm. That sounds right. I checked process_mrelease() as well, which
> > > > > > operated on mm with only mmgrab()+mmap_read_lock() but it only unmaps
> > > > > > VMAs without freeing them, so we are still good. Michal, do you agree
> > > > > > this is ok?
> > > > >
> > > > > Don't we need RCU procetions for the vma life time assurance? Jann has
> > > > > already shown how rwsem is not safe wrt to unlock and free without RCU.
> > > >
> > > > Jann's case requires a thread freeing the VMA to be blocked on vma
> > > > write lock waiting for the vma real lock to be released by a page
> > > > fault handler. However exit_mmap() means mm->mm_users==0, which in
> > > > turn suggests that there are no racing page fault handlers and no new
> > > > page fault handlers will appear. Is that a correct assumption? If so,
> > > > then races with page fault handlers can't happen while in exit_mmap().
> > > > Any other path (other than page fault handlers), accesses vma->lock
> > > > under protection of mmap_lock (for read or write, does not matter).
> > > > One exception is when we operate on an isolated VMA, then we don't
> > > > need mmap_lock protection, but exit_mmap() does not deal with isolated
> > > > VMAs, so out of scope here. exit_mmap() frees vm_area_structs under
> > > > protection of mmap_lock in write mode, so races with anything other
> > > > than page fault handler should be safe as they are today.
> > >
> > > I do not see you talking about #PF (RCU + vma read lock protected) with
> > > munmap. It is my understanding that the latter will synchronize over per
> > > vma lock (along with mmap_lock exclusive locking). But then we are back
> > > to the lifetime guarantees, or do I miss anything.
> >
> > munmap() or any VMA-freeing operation other than exit_mmap() will free
> > using call_rcu(), as implemented today. The suggestion is to free VMAs
> > directly, without RCU grace period only when done from exit_mmap().
>
> OK, I have clearly missed that. This makes more sense but it also adds
> some more complexity and assumptions - a harder to maintain code in the
> end. Whoever wants to touch this scheme in future would have to
> re-evaluate all of them. So, I would just avoid that special casing if
> that is feasible.

Ok, I understand your point.

>
> Dealing with the flood of call_rcu during exit_mmap is a trivial thing
> to deal with as proposed elsewhere (just batch all of them in a single
> run). This will surely add some more code but at least the locking would
> consistent.

Yes, batching the vmas into a list and draining it in remove_mt() and
exit_mmap() as you suggested makes sense to me and is quite simple.
Let's do that if nobody has objections.

> --
> Michal Hocko
> SUSE Labs
