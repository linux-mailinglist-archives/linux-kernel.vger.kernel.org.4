Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84985737553
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjFTTtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFTTtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:49:03 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAB010F4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:49:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-982a88ca610so615590066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687290540; x=1689882540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9s/u3hFtd0IBE7tUBIwuAjEIEeFQht4qufYbFXV/XQk=;
        b=SoIHZ9gNZGx9ulbJa5FGNGB4riPB8xOL2DywLVaBAbznxmtY4QCbC+3YwLyjupKFnx
         73HVqeqPytzCIhX3q/nh28darjjANhLeb3J8d/Y6aavGlNk81grVrzMkDX30omguC3R+
         TrDtiraYFxOQiurn/IrKPsy8ERQKN+a72nJB4WkDGxGQPJx7AwPZXUr7gWRXgQCkwYIn
         oxNRo9Xcmvi9lySgr6VtN2p4xFu7lRmpGG7BtOn7GI62F/W8qKWzqiKrxYo/6PvcNkxR
         yLIdWg/55z9q+wXKedzzn+/Yxc+awJmt0kbnFBBmkCOzJZsHaiac39FgV9dJgAI1TGtr
         guYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290540; x=1689882540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9s/u3hFtd0IBE7tUBIwuAjEIEeFQht4qufYbFXV/XQk=;
        b=kphmEJhKHn9GOgPR905HWpILER6xxk2CCHGsLX4F5AddLlNPwnahZK6MWQe0A55QbL
         SLfC5Pfap1AbIyMoOzZ5XIdYabrCAE0D9xyNbAdZ486EGXyJJ+yqPIqFw/eGLl7eDghQ
         UjCF0E4zvD1lQXvi4uOutywTAbLnaVXIhhAnj/oKyWpJGA9pIssmjb6wKhbxcRndIy0Q
         z+sDPbKmYOhjtlTe0KBUJ7TMyDdwh4Blokhw36cM6KN+wjYEP3tr3c/kN8zSWvkXGtv1
         rc6YeIfTPrm91z1mfNcNvyHhr7gHQGPrWcI26Cgd68r0f2aq3bHGhMvKv/cf6uEAEBUd
         r74A==
X-Gm-Message-State: AC+VfDzJVYTAkLCxRmBdBgW3ZZHHNHpPKE2hRiIMQ9QBneJ3BRHG2T5H
        AJcRYJXH/hgMDTCZv9lRqHX+cnDLkI6h3YlGWx9Fqg==
X-Google-Smtp-Source: ACHHUZ4LTDrkAw0L7HlPtzAoKEGy6vu6rfRW948Z4uR9/WEvIGUKJtHdHiA7WMkNsH/gMkPcTprmuK5NDMCE6G0gdGA=
X-Received: by 2002:a17:907:1607:b0:96f:dd14:f749 with SMTP id
 hb7-20020a170907160700b0096fdd14f749mr12248458ejc.23.1687290540158; Tue, 20
 Jun 2023 12:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230531022911.1168524-1-yosryahmed@google.com>
 <20230601155825.GF102494@cmpxchg.org> <CAJD7tkaFSfpTtB_ua_9QzR2voE1-hixv6RMJZd=WqpGmY93dSw@mail.gmail.com>
 <20230602164942.GA215355@cmpxchg.org> <CAJD7tkbp96S8MdrcH8y0V2G5Q-Zq6U4DAuweYhP-MjUWgcmjsQ@mail.gmail.com>
 <20230602183410.GB215355@cmpxchg.org> <CAJD7tka18Vw7HpA1gh6wWJcaCJ_U6jNfCC696pX=UkbiXKZMvQ@mail.gmail.com>
 <20230602202453.GA218605@cmpxchg.org> <CAJD7tkZBxddm1c4f99KmY+VwKU3jbYBMaNuTtfpis7a1E6242Q@mail.gmail.com>
 <CAJD7tkaraXuLKR8rsKw_8sp9YZga1caM7r0jA8DZC2Y6DxJNfQ@mail.gmail.com>
 <ZInV6Wju2NdLyzC6@cmpxchg.org> <CAJD7tkZ0BS5+0P_QiLnYKjm2tV6GGwzdSSXEZX67RLM3Ft9QmA@mail.gmail.com>
In-Reply-To: <CAJD7tkZ0BS5+0P_QiLnYKjm2tV6GGwzdSSXEZX67RLM3Ft9QmA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 20 Jun 2023 12:48:23 -0700
Message-ID: <CAJD7tkaN7mQEMf2P6grROmB36UOPXpYodp-MUBm-pZzpkVzoCQ@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: multiple zpool support
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Wed, Jun 14, 2023 at 1:50=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Wed, Jun 14, 2023 at 7:59=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Tue, Jun 13, 2023 at 01:13:59PM -0700, Yosry Ahmed wrote:
> > > On Mon, Jun 5, 2023 at 6:56=E2=80=AFPM Yosry Ahmed <yosryahmed@google=
.com> wrote:
> > > >
> > > > On Fri, Jun 2, 2023 at 1:24=E2=80=AFPM Johannes Weiner <hannes@cmpx=
chg.org> wrote:
> > > > > Sorry, I should have been more precise.
> > > > >
> > > > > I'm saying that using NR_CPUS pools, and replacing the hash with
> > > > > smp_processor_id(), would accomplish your goal of pool concurrenc=
y.
> > > > > But it would do so with a broadly-used, well-understood scaling
> > > > > factor. We might not need a config option at all.
> > > > >
> > > > > The lock would still be there, but contention would be reduced fa=
irly
> > > > > optimally (barring preemption) for store concurrency at least. No=
t
> > > > > fully eliminated due to frees and compaction, though, yes.
> > >
> > > I thought about this again and had some internal discussions, and I a=
m
> > > more unsure about it. Beyond the memory overhead, having too many
> > > zpools might result in higher fragmentation within the zpools. For
> > > zsmalloc, we do not compact across multiple zpools for example.
> > >
> > > We have been using a specific number of zpools in our production for
> > > years now, we know it can be tuned to achieve performance gains. OTOH=
,
> > > percpu zpools (or NR_CPUS pools) seems like too big of a hammer,
> > > probably too many zpools in a lot of cases, and we wouldn't know how
> > > many zpools actually fits our workloads.
> >
> > Is it the same number across your entire fleet and all workloads?
>
> Yes.
>
> >
> > How large *is* the number in relation to CPUs?
>
> It differs based on the number of cpus on the machine. We use 32
> zpools on all machines.
>
> >
> > > I see value in allowing the number of zpools to be directly
> > > configurable (it can always be left as 1), and am worried that with
> > > percpu we would be throwing away years of production testing for an
> > > unknown.
> > >
> > > I am obviously biased, but I don't think this adds significant
> > > complexity to the zswap code as-is (or as v2 is to be precise).
> >
> > I had typed out this long list of reasons why I hate this change, and
> > then deleted it to suggest the per-cpu scaling factor.
> >
> > But to summarize my POV, I think a user-facing config option for this
> > is completely inappropriate. There are no limits, no guidance, no sane
> > default. And it's very selective about micro-optimizing this one lock
> > when there are several locks and datastructures of the same scope in
> > the swap path. This isn't a reasonable question to ask people building
> > kernels. It's writing code through the Kconfig file.
>
> It's not just swap path, it's any contention that happens within the
> zpool between its different operations (map, alloc, compaction, etc).
> My thought was that if a user observes high contention in any of the
> zpool operations, they can increase the number of zpools -- basically
> this should be empirically decided. If unsure, the user can just leave
> it as a single zpool.
>
> >
> > Data structure scalability should be solved in code, not with config
> > options.
>
> I agree, but until we have a more fundamental architectural solution,
> having multiple zpools to address scalability is a win. We can remove
> the config option later if needed.
>
> >
> > My vote on the patch as proposed is NAK.
>
> I hear the argument about the config option not being ideal here, but
> NR_CPUs is also not ideal.
>
> How about if we introduce it as a constant in the kernel? We have a
> lot of other constants around the kernel that do not scale with the
> machine size (e.g. SWAP_CLUSTER_MAX). We can start with 32, which is a
> value that we have tested in our data centers for many years now and
> know to work well. We can revisit later if needed.
>
> WDYT?

I sent v3 [1] with the proposed constant instead of a config option,
hopefully this is more acceptable.

[1]https://lore.kernel.org/lkml/20230620194644.3142384-1-yosryahmed@google.=
com/
