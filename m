Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BD86A0EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 18:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjBWRqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 12:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjBWRqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 12:46:21 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89DC584A6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:46:18 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-536bbe5f888so208679117b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g/PLDPGKQjPZMyA7q+2mFnv6mahBdE0bikjr2yluVPY=;
        b=dummwTyKyVw0SoCKQB2T+CwBI/Ypb4Xjjntbgjy5yY3C5JfegBtvOFcckYNV17WdQ/
         0w5jao6F1lAd1zF6E9RI9/RWGb80R3PDgmBk2m8yqC+Gi9Cz8dqE6Quoai9BJdhJlqEh
         HXWjKep0uNLo6oQwpJ0si4E5CdSInQ6nVrYPpOZOZDmYeky4HyVGIjYgVtIRp21yjlXY
         GGlDKZIvbQYER09r+RZ/9BDfYBpNR1R7LQbtmEy4HPIjt4ErWpQfPwxeLOIuF7azgaN9
         TZCm0VAiYi4HMUn+5S8/JEaDBL3nNNe95Tqa3VX6huByAmE5cf905UXPLAp2GPZwk+ll
         sIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/PLDPGKQjPZMyA7q+2mFnv6mahBdE0bikjr2yluVPY=;
        b=LYUOwrt5EjDzHMZM0kBjomLO/zmLXLZGPfqA9ObK3uI7szXt7/WBaJYf0dVonYY7uc
         sd57YXrDQuDapyw2I1sbyBmoj3PELiwocgidZ18zeqWEPXwxOtNbxRho5u7WEQDBOC0g
         cB6LAHgQIla4jKc2TeGAIDead3prFjL/gllmOcCurZFnUg5obyL1QunDQA7OVJqC9CxK
         BOxRJ7meK4orcQkgxuIdTPilDQUM2rQnNYCCbvAN3ET5L2sogd6D0FAu7o4ot6rt17YS
         ktZz8DRMp1dJpCQDkzBlvxs2r1RMIPW8/hDNCRcCdJOn3U4DCR38+NUIZCy8We4mEh2C
         O+Cg==
X-Gm-Message-State: AO0yUKU5++KTEUrJS2FXNlsz7OvaUwrS5Ob+yfmdhWeNyAdZ1Fif76nN
        a0P1YEWVBGnf89ol256L5dwDivSObbW16pLvB66xzw==
X-Google-Smtp-Source: AK7set8VspgWW+dqkUupWcrMtXnPa8I+wv5kJWT4xioj+Je37AbwwoY0FONlPTo7MjbvDCQNHSJjmEXD8ltyQIw5ZGk=
X-Received: by 2002:a81:b71b:0:b0:533:8f19:4576 with SMTP id
 v27-20020a81b71b000000b005338f194576mr2731678ywh.0.1677174377752; Thu, 23 Feb
 2023 09:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com> <20230216051750.3125598-17-surenb@google.com>
 <Y/d9b5Ev6vAEzzVO@localhost>
In-Reply-To: <Y/d9b5Ev6vAEzzVO@localhost>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 23 Feb 2023 09:46:06 -0800
Message-ID: <CAJuCfpFmQYJ-0jFfO1YW7vgZ_DAm-ftrWfTm2AtFQ5u=AGgwVg@mail.gmail.com>
Subject: Re: [PATCH v3 16/35] mm/mmap: write-lock VMAs before merging,
 splitting or expanding them
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
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

On Thu, Feb 23, 2023 at 6:51 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> On Wed, Feb 15, 2023 at 09:17:31PM -0800, Suren Baghdasaryan wrote:
> > Decisions about whether VMAs can be merged, split or expanded must be
> > made while VMAs are protected from the changes which can affect that
> > decision. For example, merge_vma uses vma->anon_vma in its decision
>
> Did you mean vma_merge()?

Correct.

>
> > whether the VMA can be merged. Meanwhile, page fault handler changes
> > vma->anon_vma during COW operation.
> > Write-lock all VMAs which might be affected by a merge or split operation
> > before making decision how such operations should be performed.
> >
>
> It doesn't make sense (to me) to update vma->anon_vma during COW fault.
>
> AFAIK children's vma->anon_vma is allocated during fork() and
> page->anon_vma is updated on COW to reduce rmap walking because it's now
> unshared, no?
>
> As patch 26 just falls back to mmap_lock if no anon_vma is set,
> I think we can assume nothing updates vma->anon_vma (and its interval
> tree) if we are holding mmap_lock in write mode.
>
> Or am I missing something?

No, I think you are right. Patch 26 was added in the later versions of
this patchset and at the time this patch was written vma->anon_vma
could change during page fault handling under only per-VMA lock
protection.
So, this patch can be simplified. We still want to prevent concurrent
page faults while VMA is being merged or split (simply because par-VMA
lock that page fault handler holds might become the wrong one if the
VMA is split or merged from under it) but the timing of taking per-VMA
lock does not have to be *before* can_vma_merge_{before|after}. Does
that make sense?

>
> --
> Regards,
> Hyeonggon
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
