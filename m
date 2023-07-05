Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F88E747AAE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 02:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGEAWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 20:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGEAWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 20:22:05 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E312BD8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 17:22:03 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-401d1d967beso795801cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 17:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688516522; x=1691108522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXr7GRLlBKX4b8iUsbUAWkSJYd3+XLs/QXyV/h+r82o=;
        b=2gstzQ66MBhazWZtX0mKLT/XaluMubOgVx28ED31+TQX1Gg0Jpz/inHl6FOFnEQFlL
         Wr2xe06RdgzqBVA0wM/O89KZbFt9BC7MUv4n7eP3Z129v2BthG2ZoIApnbIqCqSJq6vW
         iWQExmyWk4Evnax5i6J+7xgB86pg8HmbkmF3N4ms7cmbd5wxbhRNsbennMNJogNoUlz4
         GO2DmZ5bkjwAGyfmOmqSfewAgF3fhsYQip1yIswEMPnmXFEJJJcuUhRfWG9vWTEXZ3lu
         favnTi4DQXhzEpSDWmza6MqeZ1bcjdlm40G7dmc/ZP5gDfBZhCji5YE2XcAJVx/q03se
         u/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688516522; x=1691108522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXr7GRLlBKX4b8iUsbUAWkSJYd3+XLs/QXyV/h+r82o=;
        b=D0AKapYVm+VKZ6rxGl8+xt8tWaPAm1zVJediDDgoG9lXQ2gZeKFD5jBk5L+eHgU3UV
         rik1fA9GRZOpB6LyXmJj1I0QbXcHRVy5dam5W8alw02HjepMb8VxSL46TGzhSQ7b7do+
         xo4tjp3s19iO/hRbfrZ5URnwCZJC18NSj50RN++XpWL2FouNl/VoU8HbZF4uLerV0orI
         SfoYDf3tAVfyBPdL7w9RUl5mUg50AC1VuWSsqQOPK7hLJFmYjdkM+ubqK68PPTcufmZG
         /I7cxxhABhmtSQXOajQu7Wj4SI8euqf6+SvgYlzPvtyTreYSaAWDuxjoE7rAnRaB4oFY
         1U5w==
X-Gm-Message-State: ABy/qLYywHDl49dpN6MzEaQBuA5MBcc8kREgz0dsLjape9dAbjJnYFNT
        U0rRDcc/YZljfuDZ8p6J9c0dTK+6RIdzbJ556MRt5g==
X-Google-Smtp-Source: APBJJlFxKqQTImwWVc8NmsoGdPEjlLx2JxHDyVUjrvoTiBaFG8w7QkDvWKEDSWpv/5Xz6N1WwgyTj1BdG7ing5HfrKQ=
X-Received: by 2002:a05:622a:199c:b0:3f8:99c1:52a1 with SMTP id
 u28-20020a05622a199c00b003f899c152a1mr29598qtc.10.1688516522353; Tue, 04 Jul
 2023 17:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <CAOUHufYB2kB0r9hhSbzfEzdF85MkXVfWoFOhy3LwLfJ5Qo8H6g@mail.gmail.com>
 <69aada71-0b3f-e928-6413-742fe7926576@intel.com> <CAOUHufYsOdywAJMxdh6W-=uLykD=7JrUwgBvUJWvfWJeQ5XxnA@mail.gmail.com>
 <467afd30-c85a-8b9d-97b9-a9ef9d0983af@arm.com> <449183bd-76ef-2a3a-c3f5-0478a7c574ef@intel.com>
In-Reply-To: <449183bd-76ef-2a3a-c3f5-0478a7c574ef@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 4 Jul 2023 18:21:26 -0600
Message-ID: <CAOUHufZkMbgsTU+MqDVDjPbavvisT6EXfcNnWO8oN4XtK9Bgvw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] variable-order, large folios for anonymous memory
To:     Yin Fengwei <fengwei.yin@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 4, 2023 at 5:53=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.com> =
wrote:
>
>
>
> On 7/4/23 23:36, Ryan Roberts wrote:
> > On 04/07/2023 08:11, Yu Zhao wrote:
> >> On Tue, Jul 4, 2023 at 12:22=E2=80=AFAM Yin, Fengwei <fengwei.yin@inte=
l.com> wrote:
> >>>
> >>> On 7/4/2023 10:18 AM, Yu Zhao wrote:
> >>>> On Mon, Jul 3, 2023 at 7:53=E2=80=AFAM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>>
> >>>>> Hi All,
> >>>>>
> >>>>> This is v2 of a series to implement variable order, large folios fo=
r anonymous
> >>>>> memory. The objective of this is to improve performance by allocati=
ng larger
> >>>>> chunks of memory during anonymous page faults. See [1] for backgrou=
nd.
> >>>>
> >>>> Thanks for the quick response!
> >>>>
> >>>>> I've significantly reworked and simplified the patch set based on c=
omments from
> >>>>> Yu Zhao (thanks for all your feedback!). I've also renamed the feat=
ure to
> >>>>> VARIABLE_THP, on Yu's advice.
> >>>>>
> >>>>> The last patch is for arm64 to explicitly override the default
> >>>>> arch_wants_pte_order() and is intended as an example. If this serie=
s is accepted
> >>>>> I suggest taking the first 4 patches through the mm tree and the ar=
m64 change
> >>>>> could be handled through the arm64 tree separately. Neither has any=
 build
> >>>>> dependency on the other.
> >>>>>
> >>>>> The one area where I haven't followed Yu's advice is in the determi=
nation of the
> >>>>> size of folio to use. It was suggested that I have a single preferr=
ed large
> >>>>> order, and if it doesn't fit in the VMA (due to exceeding VMA bound=
s, or there
> >>>>> being existing overlapping populated PTEs, etc) then fallback immed=
iately to
> >>>>> order-0. It turned out that this approach caused a performance regr=
ession in the
> >>>>> Speedometer benchmark.
> >>>>
> >>>> I suppose it's regression against the v1, not the unpatched kernel.
> >>> From the performance data Ryan shared, it's against unpatched kernel:
> >>>
> >>> Speedometer 2.0:
> >>>
> >>> | kernel                         |   runs_per_min |
> >>> |:-------------------------------|---------------:|
> >>> | baseline-4k                    |           0.0% |
> >>> | anonfolio-lkml-v1              |           0.7% |
> >>> | anonfolio-lkml-v2-simple-order |          -0.9% |
> >>> | anonfolio-lkml-v2              |           0.5% |
> >>
> >> I see. Thanks.
> >>
> >> A couple of questions:
> >> 1. Do we have a stddev?
> >
> > | kernel                    |   mean_abs |   std_abs |   mean_rel |   s=
td_rel |
> > |:------------------------- |-----------:|----------:|-----------:|----=
------:|
> > | baseline-4k               |      117.4 |       0.8 |       0.0% |    =
  0.7% |
> > | anonfolio-v1              |      118.2 |         1 |       0.7% |    =
  0.9% |
> > | anonfolio-v2-simple-order |      116.4 |       1.1 |      -0.9% |    =
  0.9% |
> > | anonfolio-v2              |        118 |       1.2 |       0.5% |    =
  1.0% |
> >
> > This is with 3 runs per reboot across 5 reboots, with first run after r=
eboot
> > trimmed (it's always a bit slower, I assume due to cold page cache). So=
 10 data
> > points per kernel in total.
> >
> > I've rerun the test multiple times and see similar results each time.
> >
> > I've also run anonfolio-v2 with Kconfig FLEXIBLE_THP=3Ddisabled and in =
this case I
> > see the same performance as baseline-4k.
> >
> >
> >> 2. Do we have a theory why it regressed?
> >
> > I have a woolly hypothesis; I think Chromium is doing mmap/munmap in wa=
ys that
> > mean when we fault, order-4 is often too big to fit in the VMA. So we f=
allback
> > to order-0. I guess this is happening so often for this workload that t=
he cost
> > of doing the checks and fallback is outweighing the benefit of the memo=
ry that
> > does end up with order-4 folios.
> >
> > I've sampled the memory in each bucket (once per second) while running =
and its
> > roughly:
> >
> > 64K: 25%
> > 32K: 15%
> > 16K: 15%
> > 4K: 45%
> >
> > 32K and 16K obviously fold into the 4K bucket with anonfolio-v2-simple-=
order.
> > But potentially, I suspect there is lots of mmap/unmap for the smaller =
sizes and
> > the 64K contents is more static - that's just a guess though.
> So this is like out of vma range thing.
>
> >
> >> Assuming no bugs, I don't see how a real regression could happen --
> >> falling back to order-0 isn't different from the original behavior.
> >> Ryan, could you `perf record` and `cat /proc/vmstat` and share them?
> >
> > I can, but it will have to be a bit later in the week. I'll do some mor=
e test
> > runs overnight so we have a larger number of runs - hopefully that migh=
t tell us
> > that this is noise to a certain extent.
> >
> > I'd still like to hear a clear technical argument for why the bin-packi=
ng
> > approach is not the correct one!
> My understanding to Yu's (Yu, correct me if I am wrong) comments is that =
we
> postpone this part of change and make basic anon large folio support in. =
Then
> discuss which approach we should take. Maybe people will agree retry is t=
he
> choice, maybe other approach will be taken...
>
> For example, for this out of VMA range case, per VMA order should be cons=
idered.
> We don't need make decision that the retry should be taken now.

I've articulated the reasons in another email. Just summarize the most
important point here:
using more fallback orders makes a system reach equilibrium faster, at
which point it can't allocate the order of arch_wants_pte_order()
anymore. IOW, this best-fit policy can reduce the number of folios of
the h/w prefered order for a system running long enough.
