Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B794774F5A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjGKQgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjGKQgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:36:18 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5E31BE7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:35:40 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-c1aad78d5b2so10227541276.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689093325; x=1691685325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK+/RLEKHvFTc2cBA37SaSmlotAdLXzjwYXHeGn0zbM=;
        b=Oq97RDu63Pf3YYxwzUoBG++FTpq8HiaaoJPKVEmYNFA5g8JgogfB3eLvNmR6xJKwM0
         /hjQ/PeaHoBMNE7ZSek0VnMIX5lh+HUKjnJ7awc53ycJUT/KukZ5ecjo7HLohFTHZdEJ
         g0Uk9kvWyZqrV7aI8KhBqZP/HFeBKqdy9HjK11RPzJ1ZzaUnZjbw+76tV3zCFJLqNfTu
         CuY1ByNMFO1pgxjYZumpMua10+h4rH0YB1NkyanJaoXI1Uq19cvCj9TRnvODki+yAo6R
         CAxAeeZe/2z/QUk9HmibAGd7ZoC+ncWYkfILRUYA2pk99E5DFi+79e6TF4s36p55XMLh
         OXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689093325; x=1691685325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FK+/RLEKHvFTc2cBA37SaSmlotAdLXzjwYXHeGn0zbM=;
        b=X32t2lBOgaPkpzZ9cNZv768zZDqE3zdjCYrD6B4bVCQj6OYyvREEYzaKA2wjifrUzq
         lScfuJdsQxgjUN3bb9nFsNJ0sNwPinAxLCPKWdd+JPHIg9s6IMDUfcr8uI9CWdl8azsm
         m91PTPT1zZKiD5QiaZ67j2Z7bzPcMqWR5M/EAMd22vpXVhrWD2MkvdAk+SkhGrBJS8nQ
         yevpE7vCbJJRPAB2YPHZ77VIfQ6gI7b1nq/AAWrc2K3kAf8GGHuo8R9VBiozjKYEJ/ZE
         NsCEq6FL2SNxhdkTezHsIb+dNnvxBdSpTsOLQdrQONzdRqpQfLbEpI2DIaFxhWwQK2dZ
         X0ZQ==
X-Gm-Message-State: ABy/qLYCo0tsCukfsmbh/DUwCsLUThNqGPOt/3pR/v0GyZbkNj7ZSmMx
        Ago6y4IplXGy+QGjHS3+htjR5UkZeOpAntg2Ephzxg==
X-Google-Smtp-Source: APBJJlF8l0QV/lX8VvDE6yY9wAXanhWeF+yRLXHSEd2zoXjNKVmTOZy5uQO02NKxg9aQ90R6+AVbNyLvQyxhrGYEcdI=
X-Received: by 2002:a25:f86:0:b0:bfe:c5cf:6e60 with SMTP id
 128-20020a250f86000000b00bfec5cf6e60mr12446560ybp.8.1689093324985; Tue, 11
 Jul 2023 09:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com> <20230711103541.GA190975@unreal>
 <53676850-539f-2813-d55d-a8bc0ec88092@suse.cz> <20230711110141.GN41919@unreal>
 <20230711110945.GO41919@unreal>
In-Reply-To: <20230711110945.GO41919@unreal>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 11 Jul 2023 09:35:13 -0700
Message-ID: <CAJuCfpG-dwzT++ZLY-sT2jn_9AHFVZsTfwJu17MwbB4oYJ4M+g@mail.gmail.com>
Subject: Re: [PATCH v4 00/33] Per-VMA locks
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        paulmck@kernel.org, mingo@redhat.com, will@kernel.org,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
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
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        regressions@leemhuis.info,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        maorg@nvidia.com, gal@nvidia.com, ranro@nvidia.com,
        drort@nvidia.com, idok@nvidia.com, sergeyy@nvidia.com
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

On Tue, Jul 11, 2023 at 4:09=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Jul 11, 2023 at 02:01:41PM +0300, Leon Romanovsky wrote:
> > On Tue, Jul 11, 2023 at 12:39:34PM +0200, Vlastimil Babka wrote:
> > > On 7/11/23 12:35, Leon Romanovsky wrote:
> > > >
> > > > On Mon, Feb 27, 2023 at 09:35:59AM -0800, Suren Baghdasaryan wrote:
> > > >
> > > > <...>
> > > >
> > > >> Laurent Dufour (1):
> > > >>   powerc/mm: try VMA lock-based page fault handling first
> > > >
> > > > Hi,
> > > >
> > > > This series and specifically the commit above broke docker over PPC=
.
> > > > It causes to docker service stuck while trying to activate. Revert =
of
> > > > this commit allows us to use docker again.
> > >
> > > Hi,
> > >
> > > there have been follow-up fixes, that are part of 6.4.3 stable (also
> > > 6.5-rc1) Does that version work for you?
> >
> > I'll recheck it again on clean system, but for the record:
> > 1. We are running 6.5-rc1 kernels.
> > 2. PPC doesn't compile for us on -rc1 without this fix.
> > https://lore.kernel.org/all/20230629124500.1.I55e2f4e7903d686c4484cb23c=
033c6a9e1a9d4c4@changeid/
>
> Ohh, I see it in -rc1, let's recheck.

Hi Leon,
Please let us know how it goes.

>
> > 3. I didn't see anything relevant -rc1 with "git log arch/powerpc/mm/fa=
ult.c".

The fixes Vlastimil was referring to are not in the fault.c, they are
in the main mm and fork code. More specifically, check for these
patches to exist in the branch you are testing:

mm: lock newly mapped VMA with corrected ordering
fork: lock VMAs of the parent process when forking
mm: lock newly mapped VMA which can be modified after it becomes visible
mm: lock a vma before stack expansion

Thanks,
Suren.

> >
> > Do you have in mind anything specific to check?
> >
> > Thanks
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
