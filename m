Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206D66D8959
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbjDEVK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjDEVKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:10:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BD476A9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:10:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f048b144eeso84585e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680729005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghxKNRoR0FZ6RC9U8oDSfHTOCg4Vl7TWo9AvFAhVJL8=;
        b=i6chEb9vGW/gixaqqJDYTVYxj4WC/ZoB6hJEJfG87LKH5mDe8yGKQqXeWDYkcImmmP
         BUqUgnzI5uUZ98CRt1WBMLCmFoTnaEzW4ndD2uhv4wWQPb8H0c2hSYYr4VxPlDAfmlT2
         4M8vDxwmC0WgYubDDkoyWnLN21bNYlU8xHj7my+BI13+AJxRMHcmv9gSImI4Xs2DYwsL
         C0ZZRPHSgCfPHwl+iQ4OGn3HrF9MYvMA8S0IsX9cL/CrUzbNfzqOxGk4djevBRlS+BZS
         Bc+o/V1XGTxeWUo1SQgtlPZ8OAKFHiiw2dosuxU88Tn0CDrZU/0M/q+/HDTxMWqa00sT
         R79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680729005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghxKNRoR0FZ6RC9U8oDSfHTOCg4Vl7TWo9AvFAhVJL8=;
        b=Wm9q6+2RgynJX6loGogDXDKgM8wwc65wVjPujJYpqc6dNFSkAq8GfJ08cqgK+nL6IB
         XSoz605Q3w4YTEjh50QDFQyVWPtmSeNTWuxLwwsQuqoIsZcCkdgq72kgGSrJycKPjiA1
         NZfHHgb70gGQ+giwuYwgS0+dmICliZ0gM6pgCOfap2lUVSyG5wqulGEvsQsDfooNxwTC
         h0vYwVQsxZPDUfc9iUWViHh1pvrNR8Zv/UDzmZd/gkoinw9dSz7mTlh4d+XuczrvdEBI
         ncJBMXNUAtGeEouP3B3jQGtFXRVTv8DiSXGc4cIdyrX2p1PxK4yV0eKLmcDUbyE24NR8
         E4/Q==
X-Gm-Message-State: AAQBX9craRwSU6X8P1Zo3e1nBkH7RdK5lNX7UjtnEI9Cm0RRo8+2CBpe
        GtpEG5rLpEhbYe2Yoo6jEDtRbu+1/VCPVGfEKhk87gXXl9OE/GUWBzomjQ==
X-Google-Smtp-Source: AKy350Y8dlY71Bwmyq0R41xrR/A+ov96ltf+DinHLAU+LRjlwWHipLLESWLVC/ufr+l0ytpTF7306GYWNmHIsnWRLKI=
X-Received: by 2002:a05:600c:4f8d:b0:3f0:3dd2:8c24 with SMTP id
 n13-20020a05600c4f8d00b003f03dd28c24mr48308wmq.6.1680729004672; Wed, 05 Apr
 2023 14:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230405200150.GA35884@cmpxchg.org>
In-Reply-To: <20230405200150.GA35884@cmpxchg.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 5 Apr 2023 15:09:27 -0600
Message-ID: <CAOUHufYCxdAXtw_b1qFT_02L3gWcs3of6Y0-5mmLwr+CeWvLQQ@mail.gmail.com>
Subject: Re: global_reclaim() and code documentation (was: Re: [PATCH v3 3/3]
 mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 2:01=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Fri, Mar 31, 2023 at 12:30:11AM -0700, Yosry Ahmed wrote:
> > On Fri, Mar 31, 2023 at 12:25=E2=80=AFAM Yu Zhao <yuzhao@google.com> wr=
ote:
> > > On Fri, Mar 31, 2023 at 1:08=E2=80=AFAM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > >
> > > ...
> > >
> > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > index a3e38851b34ac..bf9d8e175e92a 100644
> > > > --- a/mm/vmscan.c
> > > > +++ b/mm/vmscan.c
> > > > @@ -533,7 +533,35 @@ EXPORT_SYMBOL(mm_account_reclaimed_pages);
> > > >  static void flush_reclaim_state(struct scan_control *sc,
> > > >                                 struct reclaim_state *rs)
> > > >  {
> > > > -       if (rs) {
> > > > +       /*
> > > > +        * Currently, reclaim_state->reclaimed includes three types=
 of pages
> > > > +        * freed outside of vmscan:
> > > > +        * (1) Slab pages.
> > > > +        * (2) Clean file pages from pruned inodes.
> > > > +        * (3) XFS freed buffer pages.
> > > > +        *
> > > > +        * For all of these cases, we have no way of finding out wh=
ether these
> > > > +        * pages were related to the memcg under reclaim. For examp=
le, a freed
> > > > +        * slab page could have had only a single object charged to=
 the memcg
> > > > +        * under reclaim. Also, populated inodes are not on shrinke=
r LRUs
> > > > +        * anymore except on highmem systems.
> > > > +        *
> > > > +        * Instead of over-reporting the reclaimed pages in a memcg=
 reclaim,
> > > > +        * only count such pages in system-wide reclaim. This preve=
nts
> > > > +        * unnecessary retries during memcg charging and false posi=
tive from
> > > > +        * proactive reclaim (memory.reclaim).
> > >
> > > What happens when writing to the root memory.reclaim?
> > >
> > > > +        *
> > > > +        * For uncommon cases were the freed pages were actually si=
gnificantly
> > > > +        * charged to the memcg under reclaim, and we end up under-=
reporting, it
> > > > +        * should be fine. The freed pages will be uncharged anyway=
, even if
> > > > +        * they are not reported properly, and we will be able to m=
ake forward
> > > > +        * progress in charging (which is usually in a retry loop).
> > > > +        *
> > > > +        * We can go one step further, and report the uncharged obj=
cg pages in
> > > > +        * memcg reclaim, to make reporting more accurate and reduc=
e
> > > > +        * under-reporting, but it's probably not worth the complex=
ity for now.
> > > > +        */
> > > > +       if (rs && !cgroup_reclaim(sc)) {
> > >
> > > To answer the question above, global_reclaim() would be preferred.
> >
> > Great point, global_reclaim() is fairly recent. I didn't see it
> > before. Thanks for pointing it out. I will change it for v4 -- will
> > wait for more feedback before respinning.
>
> I didn't realize it came back, I deleted it a while ago:
>
> commit b5ead35e7e1d3434ce436dfcb2af32820ce54589
> Author: Johannes Weiner <hannes@cmpxchg.org>
> Date:   Sat Nov 30 17:55:40 2019 -0800
>
>     mm: vmscan: naming fixes: global_reclaim() and sane_reclaim()
>
>     Seven years after introducing the global_reclaim() function, I still =
have
>     to double take when reading a callsite.  I don't know how others do i=
t,
>     this is a terrible name.
>
>     Invert the meaning and rename it to cgroup_reclaim().
>
> Could you shed some light on why it was brought back? It's not clear
> to me from the changelog in a579086c99ed70cc4bfc104348dbe3dd8f2787e6.

Sorry about the confusion. I was asking Yosry to post an RFC to clear that =
up.

> We also now have this:
>
> static bool cgroup_reclaim(struct scan_control *sc)
> {
>         return sc->target_mem_cgroup;
> }
>
> static bool global_reclaim(struct scan_control *sc)
> {
>         return !sc->target_mem_cgroup || mem_cgroup_is_root(sc->target_me=
m_cgroup);
> }
>
> The name suggests it's the same thing twice, with opposite
> polarity. But of course they're subtly different, and not documented.
>
> When do you use which?

The problem I saw is that target_mem_cgroup is set when writing to the
root memory.reclaim. And for this case, a few places might prefer
global_reclaim(), e.g., in shrink_lruvec(), in addition to where it's
being used.

If this makes sense, we could 1) document it (or rename it) and apply
it to those places, or 2) just unset target_mem_cgroup for root and
delete global_reclaim(). Option 2 might break ABI but still be
acceptable.

If we don't want to decide right now, I can rename global_reclaim() to
root_reclaim() and move it within #ifdef CONFIG_LRU_GEN and probably
come back and revisit later.
