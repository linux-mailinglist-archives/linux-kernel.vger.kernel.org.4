Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F4469DACB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 07:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjBUGw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 01:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjBUGw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 01:52:26 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CA723117
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 22:52:22 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id v78so3815942ybe.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 22:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3usF6y0jP8WdRmsHw7idRFJkuoGf3L15ygmJMO39Keg=;
        b=Dxb4ANKUF876yt1r6rpWTEgOJzOrrCeT53AkedVhi1afGBbnTzly2/ntvJH0Wiy+Hs
         A8OQ5p5sjhbAtVUpqM7cmdzqL5bAXHfW5c8tZcugAObcsO9l64l4BtXlkzQF9gXoO+e8
         mXEErXvCDp3J+4kVqQxrCSgbr8SzEUNW2yq2PewEKlYBmdqY/Ec1iA0pLqpzXf+GdMYd
         ex+6nV9pa+PGOgK3EJMTg0HTKEpG8mNdIyvFdBT12H/4m8b7fDXcGislJqneW+VG9SmR
         KpRgA/xYhhbEecBbfZ8ywK/2eK1pkN7NSYzIWQn2BvvbBDuyFQOiNE/7ggzOGWbVypFx
         CVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3usF6y0jP8WdRmsHw7idRFJkuoGf3L15ygmJMO39Keg=;
        b=KweqOSESw+eAYdf202cSZb6OVjNWBjYZpVb3kuWsOqH3q7xNO45/Jhuhi5IPkWxdpP
         gLii6KKZP/1Ig8+6gCUx7fRDr1waAMoN0NalngxsfhZjtdJ/1VXncm0Q2ZndijLxQJwl
         fM82GbfSpX8/ZOAw9pfUeTToY0IEAKRBGHLm8Nx55axqs7ZQiODM5ak82h4dg2pMZZ6k
         O/7c5o934w8NFF50TENjn3scfaeD17NUtXwPa7imt5mX2n92M0xQldW+qFJCj+pfnAcP
         iiKlCDsiTN3shPBHrGb9SjhKgi07USgm1Zc8BUs25+rGsuxTSLB7aqaTZ9iZ/uIoZX26
         pnyA==
X-Gm-Message-State: AO0yUKUk7TuwBFmjTXP8acqkC+Npx0LniNukTVmYRsp0cTjziFId8IwR
        2K6DGU1rrBaQLjj7g7h1240+2ga612XoASehMs92vA==
X-Google-Smtp-Source: AK7set/KssXsBw+UV6ZW5jaXWXgEk7m9tk+TPyEqax5PBIK816L+TDG+tB7u5x98cSyQtCNn8gMxbS2O6rpsFDVFbTk=
X-Received: by 2002:a5b:691:0:b0:902:535c:8399 with SMTP id
 j17-20020a5b0691000000b00902535c8399mr34958ybq.461.1676962341842; Mon, 20 Feb
 2023 22:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20230220230624.lkobqeagycx7bi7p@google.com> <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
In-Reply-To: <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 20 Feb 2023 22:52:10 -0800
Message-ID: <CALvZod55K5zbbVYptq8ud=nKVyU1xceGVf6UcambBZ3BA2TZqA@mail.gmail.com>
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Yue Zhao <findns94@gmail.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        muchun.song@linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Feb 20, 2023 at 9:17 PM Roman Gushchin <roman.gushchin@linux.dev> w=
rote:
>
> > On Feb 20, 2023, at 3:06 PM, Shakeel Butt <shakeelb@google.com> wrote:
> >
> > =EF=BB=BFOn Mon, Feb 20, 2023 at 01:09:44PM -0800, Roman Gushchin wrote=
:
> >>> On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
> >>> The knob for cgroup v2 memory controller: memory.oom.group
> >>> will be read and written simultaneously by user space
> >>> programs, thus we'd better change memcg->oom_group access
> >>> with atomic operations to avoid concurrency problems.
> >>>
> >>> Signed-off-by: Yue Zhao <findns94@gmail.com>
> >>
> >> Hi Yue!
> >>
> >> I'm curious, have any seen any real issues which your patch is solving=
?
> >> Can you, please, provide a bit more details.
> >>
> >
> > IMHO such details are not needed. oom_group is being accessed
> > concurrently and one of them can be a write access. At least
> > READ_ONCE/WRITE_ONCE is needed here.
>
> Needed for what?

For this particular case, documenting such an access. Though I don't
think there are any architectures which may tear a one byte read/write
and merging/refetching is not an issue for this.

>
> I mean it=E2=80=99s obviously not a big deal to put READ_ONCE()/WRITE_ONC=
E() here, but I struggle to imagine a scenario when it will make any differ=
ence. IMHO it=E2=80=99s easier to justify a proper atomic operation here, e=
ven if it=E2=80=99s most likely an overkill.
>
> My question is very simple: the commit log mentions =E2=80=9C=E2=80=A6 to=
 avoid concurrency problems=E2=80=9D, so I wonder what problems are these.
>
> Also there are other similar cgroup interfaces without READ_ONCE()/WRITE_=
ONCE()

Yeah and those are v1 interfaces e.g. oom_kill_disable, swappiness,
soft_limit. These definitely need [READ|WRITE]_ONCE primitive.

Yue, can you update your patch and convert all accesses to these
fields through [READ|WRITE]_ONCE ?
