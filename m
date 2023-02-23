Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BE16A1177
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjBWUt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBWUtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:49:51 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF3E4BEA9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 12:49:38 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id j14so17823635vse.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 12:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SF3XhVP3fAY++OBxv67A9DpjZx+ZDC9K9+v7wrHIg4=;
        b=EpX9CHX76iRG0Fs24LnxWWmUrr6GORT9E0/M4Xni5oa8PVB+NyUf9xnluacNRHiJLi
         oTPsaXyvlxhYWm1ndp1ryFZ2TYjXOvmoy1HRUGzS0OcGc0zMZqTcHgAXNM4rvtYhkBVg
         qf1J0mPiiAUp/S0+3TAXNUeuKCd0ORgY+E6d2A7I7obvZdxZj53WV4QC5FeppMbcQG4J
         w3LEbf37wFLbDqttTYWl7EPewRkSSHAJUCRfzZv8DTS9QEc8hXTrQprXo+iEqU+77E4a
         oj0f9UT2zBFwspHpPsFBXYoak9R9do+2VFEDllmPwgJrEESjvU63PTjiVmuQ4E+SRpNl
         YYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SF3XhVP3fAY++OBxv67A9DpjZx+ZDC9K9+v7wrHIg4=;
        b=1aGV0YG3+0pFQEToA1RRYCWq7p83C/M12e/9xydv4QzWn1ZehN7UoKV9LxqCbJrbGS
         yfG5ZYyY8gE4YxTBGg9czEuyZAGBI6mBHi1BcUMD57DxOyV86tUdhpuWu2Oys2BqBv+d
         BgxGAky2qOh0aGxYSAT1kqYzz9BD17GB7VHMg5uX2LCrrmKJd1Dsk6SAKRJ4KJLM+obi
         FkzMqM7FIEYNUKNG/NAZpf8L0VCE95lOB9eBRyufcVf90hBCCvdSCNgpGZ8ZBG+BESSR
         oJ2Um7Bbfe/KObTC6xGRWc1IcrZzH/oz1RNZeIQJX3xBmwpGxImDHottrnj08pFyEqIl
         S9Fg==
X-Gm-Message-State: AO0yUKU05h3f3YUx4df1f0FjDh88hqhM9TlHNrns5bJmE87D76yQ2wxw
        0vNEZ4RJtyIaVBYqXWxgbcejxIXgIvA80JDU7MxHlA==
X-Google-Smtp-Source: AK7set+PFnbYU2JD49LX096IfpIl1qWCv3pt6jtJWvZdeEDsrHSa6XgcIEspmONr+RBUjp9C7QlPEAawwJ6rNQ/sErI=
X-Received: by 2002:a67:fb96:0:b0:411:bf89:685c with SMTP id
 n22-20020a67fb96000000b00411bf89685cmr800789vsr.6.1677185377290; Thu, 23 Feb
 2023 12:49:37 -0800 (PST)
MIME-Version: 1.0
References: <20230217041230.2417228-1-yuzhao@google.com> <20230217041230.2417228-6-yuzhao@google.com>
 <Y/elw7CTvVWt0Js6@google.com> <CAOUHufbAKpv95k6rVedstjD_7JzP0RrbOD652gyZh2vbAjGPOg@mail.gmail.com>
 <Y/e6Z+KIl6sYJoRg@google.com> <CAOUHufbwcqx21T=zmvYpnX_Mnd2A0KkPORbtxnJEwKuUKVSPzA@mail.gmail.com>
 <Y/fFWyYPu5Jf0de1@google.com> <CAOUHufYWktz4SNjL_o_2oZNcJLXserwCot-Prv4UEG9uzn57rg@mail.gmail.com>
 <Y/fMimvChfhhbCid@google.com>
In-Reply-To: <Y/fMimvChfhhbCid@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 23 Feb 2023 13:48:59 -0700
Message-ID: <CAOUHufb4yFPJ8bLt-YRC7eMAyT2PMA_JF82Z412+O=79edsuwQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 5/5] mm: multi-gen LRU: use mmu_notifier_test_clear_young()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <michael@michaellarabel.com>,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-mm@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Feb 23, 2023 at 1:29=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Feb 23, 2023, Yu Zhao wrote:
> > On Thu, Feb 23, 2023 at 12:58=E2=80=AFPM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > >
> > > On Thu, Feb 23, 2023, Yu Zhao wrote:
> > > > On Thu, Feb 23, 2023 at 12:11=E2=80=AFPM Sean Christopherson <seanj=
c@google.com> wrote:
> > > > >
> > > > > On Thu, Feb 23, 2023, Yu Zhao wrote:
> > > > > > > As alluded to in patch 1, unless batching the walks even if K=
VM does _not_ support
> > > > > > > a lockless walk is somehow _worse_ than using the existing mm=
u_notifier_clear_flush_young(),
> > > > > > > I think batching the calls should be conditional only on LRU_=
GEN_SPTE_WALK.  Or
> > > > > > > if we want to avoid batching when there are no mmu_notifier l=
isteners, probe
> > > > > > > mmu_notifiers.  But don't call into KVM directly.
> > > > > >
> > > > > > I'm not sure I fully understand. Let's present the problem on t=
he MM
> > > > > > side: assuming KVM supports lockless walks, batching can still =
be
> > > > > > worse (very unlikely), because GFNs can exhibit no memory local=
ity at
> > > > > > all. So this option allows userspace to disable batching.
> > > > >
> > > > > I'm asking the opposite.  Is there a scenario where batching+lock=
 is worse than
> > > > > !batching+lock?  If not, then don't make batching depend on lockl=
ess walks.
> > > >
> > > > Yes, absolutely. batching+lock means we take/release mmu_lock for
> > > > every single PTE in the entire VA space -- each small batch contain=
s
> > > > 64 PTEs but the entire batch is the whole KVM.
> > >
> > > Who is "we"?
> >
> > Oops -- shouldn't have used "we".
> >
> > > I don't see anything in the kernel that triggers walking the whole
> > > VMA, e.g. lru_gen_look_around() limits the walk to a single PMD.  I f=
eel like I'm
> > > missing something...
> >
> > walk_mm() -> walk_pud_range() -> walk_pmd_range() -> walk_pte_range()
> > -> test_spte_young() -> mmu_notifier_test_clear_young().
> >
> > MGLRU takes two passes: during the first pass, it sweeps entire VA
> > space on each MM (per MM/KVM); during the second pass, it uses the rmap=
 on each
> > folio (per folio).
>
> Ah.  IIUC, userspace can use LRU_GEN_SPTE_WALK to control whether or not =
to walk
> secondary MMUs, and the kernel further restricts LRU_GEN_SPTE_WALK to sec=
ondary
> MMUs that implement a lockless walk.  And if the answer is "no", secondar=
y MMUs
> are simply not consulted.

Sorry for the bad naming -- probably LRU_GEN_SPTE_BATCH_WALK would be
less confusing.

MGLRU always consults the secondary MMU for each page it's going to
reclaim (during the second pass), i.e., it checks the A-bit in the
SPTE mapping a page (by the rmap) it plans to reclaim so that it won't
take a hot page away from KVM.

If the lockless walk is supported, MGLRU doesn't need to work at page
granularity: (physical) pages on the LRU list may have nothing in
common (e.g., from different processes), checking their PTEs/SPTEs one
by one is expensive. Instead, it sweeps the entire KVM spaces in the
first pass and checks the *adjacent SPTEs* of a page it plans to
reclaim in the second pass. Both rely on the *assumption* there would
be some spatial locality to exploit. This assumption can be wrong, and
LRU_GEN_SPTE_WALK disables it.

> If that's correct, then the proper way to handle this is by extending mmu=
_notifier_ops
> to query (a) if there's at least one register listeners that implements
> test_clear_young() and (b) if all registered listeners that implement tes=
t_clear_young()
> support lockless walks.  That avoids direct dependencies on KVM, and avoi=
ds making
> assumptions that may not always hold true, e.g. that KVM is the only mmu_=
notifier
> user that supports the young APIs.
>
> P.S. all of this info absolutely belongs in documentation and/or changelo=
gs.

Will do.
