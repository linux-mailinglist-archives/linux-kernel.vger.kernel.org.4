Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979A565E2F3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 03:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjAECbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 21:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAECbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 21:31:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7C212AFA
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 18:31:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A14C6010F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69531C43396
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672885896;
        bh=XFa0qDGvl3SJvnLKs+mS95jGASNuLpjJhTDSQ9emNEM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rrXQT63Gy09Aa4zewLG9tXN6oN/qBVwvI06cW0HLhR7N09FyNwncn1hcRc0+FpBFo
         HI6NBYzsxhsM0KZ/NQfFLkelLsvBp7P+qH0vKpp6SKrXCqEgk73Q2GVvbksPlwPkry
         SpjOJmMVW+xGHnwe+7L5/dU8SkIDC8+MyChFr2zOmaQVz7TeBv0MzfNPOkpKvQhWY3
         Rx8Zj7bhHbJKS7fVfdHPfDrOr130pmtWE5rYVri3V5zL08h0cGnxx1UpOyDr7lnddr
         tLE2mRp7qjoXuNQfI1zjQi2UL65oo5dA2U1aPB02kIwdYNhd8dUT4Da7+9XSvz3Eqh
         8jtz+RbORZYjA==
Received: by mail-ej1-f48.google.com with SMTP id qk9so86895879ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 18:31:36 -0800 (PST)
X-Gm-Message-State: AFqh2kpyWehNs7dmJcdz9nsMGFp3ild8FGcMpFLnsfGpfCIG7pCiYRU6
        juacCesYhwFPJ737Rpvt3wWicApmu73c1CBD1E0=
X-Google-Smtp-Source: AMrXdXsKA4ZSzJIdxfEJVSXgTHZOR3Ls/3lwt/gR8TgAbrjUaElQjqF7HVv6rhFK3xn4rwmrPU+6y3ZFB10iVzNXmaw=
X-Received: by 2002:a17:907:8024:b0:84d:df2:81f5 with SMTP id
 ft36-20020a170907802400b0084d0df281f5mr3015ejc.406.1672885894594; Wed, 04 Jan
 2023 18:31:34 -0800 (PST)
MIME-Version: 1.0
References: <20221224120545.262989-1-guoren@kernel.org> <08ce1ab6-4678-74ce-43cc-2d3f04d1525d@redhat.com>
 <CAJF2gTS52jBm7_3c=9i1uPjmV90=42xs4dOs6woA4NnHf4RHgQ@mail.gmail.com>
 <b01060ba-6069-d33e-5151-22a7d9577f13@redhat.com> <e30f671d-8e74-d5b9-cdba-472d7297f257@redhat.com>
 <CAJF2gTTkLY+mUoG0oqw0mmJH0hK5bXYvrmYcLL1-zwNbzOb9TQ@mail.gmail.com> <Y7XfYPnQhLTcNZSh@gmail.com>
In-Reply-To: <Y7XfYPnQhLTcNZSh@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 5 Jan 2023 10:31:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT4yaH1i7zmKNwzt8OK1frFvre09wwNGABBo_3gC0pjBw@mail.gmail.com>
Message-ID: <CAJF2gTT4yaH1i7zmKNwzt8OK1frFvre09wwNGABBo_3gC0pjBw@mail.gmail.com>
Subject: Re: [PATCH] locking/qspinlock: Optimize pending state waiting for unlock
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 4:19 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Guo Ren <guoren@kernel.org> wrote:
>
> > > >> The situation is the SMT scenarios in the same core. Not an entering
> > > >> low-power state situation. Of course, the granularity between cores is
> > > >> "cacheline", but the granularity between SMT hw threads of the same
> > > >> core could be "byte" which internal LSU handles. For example, when a
> > > >> hw-thread yields the resources of the core to other hw-threads, this
> > > >> patch could help the hw-thread stay in the sleep state and prevent it
> > > >> from being woken up by other hw-threads xchg_tail.
> > > >>
> > > >> Finally, from the software semantic view, does the patch make it more
> > > >> accurate? (We don't care about the tail here.)
> > > >
> > > > Thanks for the clarification.
> > > >
> > > > I am not arguing for the simplification part. I just want to clarify
> > > > my limited understanding of how the CPU hardware are actually dealing
> > > > with these conditions.
> > > >
> > > > With that, I am fine with this patch. It would be nice if you can
> > > > elaborate a bit more in your commit log.
> > > >
> > > > Acked-by: Waiman Long <longman@redhat.com>
> > > >
> > > BTW, have you actually observe any performance improvement with this patch?
> > Not yet. I'm researching how the hardware could satisfy qspinlock
> > better. Here are three points I concluded:
> >  1. Atomic forward progress guarantee: Prevent unnecessary LL/SC
> > retry, which may cause expensive bus transactions when crossing the
> > NUMA nodes.
> >  2. Sub-word atomic primitive: Enable freedom from interference
> > between locked, pending, and tail.
> >  3. Load-cond primitive: Prevent processor from wasting loop
> > operations for detection.
>
> As to this patch, please send a -v2 version of this patch that has this
> discussion & explanation included in the changelog, as requested by Waiman.
Done

https://lore.kernel.org/lkml/20230105021952.3090070-1-guoren@kernel.org/

>
> Thanks,
>
>         Ingo



-- 
Best Regards
 Guo Ren
