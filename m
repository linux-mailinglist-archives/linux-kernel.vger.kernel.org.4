Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A2A6A75C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 22:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCAVA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 16:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCAVA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 16:00:57 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E604DE39
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 13:00:56 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o15so56847258edr.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 13:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677704454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2kasoRjb1+wciE4LnUC2thgmhUmXODjqV4vRSm0GrQ=;
        b=W7barMoQHh4OpBpyETO0/gkI5dClRC/69osO6LGoB7PZbyXAonsXRwPJeNy0OBf5UL
         LXrKyhtV5pnGDcCIi4Piv/DxPPYhzjcQY6T6uNuSed9veKu1yjBJL4X+FkKb5bJYV9Yt
         sE10hdpblg9K3wuqUwCurVvteg0oZ2CQ2bR4f73Gnt83eCIkCgy9LyANkDgWVMDqEBeJ
         YZBj7K+xVkhICy6nS06wRn/bS8ni9axi1Ee9BCCArZ2aJbtEc/4KOm7qBrwJnCf7/X1M
         WUrCsMG7Zvo1Tp+cjmRkFYImZEqA3rnUxBKoAy8NQeC6T/HaG9u5iIbM+jKerspIbLfZ
         3YFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677704454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2kasoRjb1+wciE4LnUC2thgmhUmXODjqV4vRSm0GrQ=;
        b=4EONwLqFo2vCHZUYSespQ31omzua6Bu7yW7S2JMawStGsMH5CQLV3tDiYE5zc9a/yH
         ujU18rnYQcnZJd51IT5RdLf3xEeTizBb2fTkLXLRATmBidVyqh+FCCAgGMVOYJ1Wf9r+
         DTiFA9m6eTSz/LFFu5s0v09gVnv4iiuw99qP1WWdzUn8mFscboXMWHaf26EicfeKru8C
         TR05GmYnDZGBc7AVIRdluMa0TLv7SdQ45yxLI4HWcoHu+xvjyLLac6XxV+8mY03uREjv
         QS0fzMvns9VGfYOgaJvR5HWEM4f6iAaUEXiD2n1Hf44YfmC75xMACplx8yswS6Q8rXJ9
         Cfwg==
X-Gm-Message-State: AO0yUKXSgD1Vuxh9VQb9Fswuc15YSqOwnu14/zq5MxfnHYYLtsYAtxJy
        +fyxHMiMV5fun8LzC08w5xYP1x1B0NX1Ejvua6xBJg==
X-Google-Smtp-Source: AK7set8WhjZ+EUql0MKvPVALpu2QC0TPEikxqjdTRnnfGvepLuO+0VCK9ZPNqpgNDaswQPHgcICbMTezMh2iivOUnu0=
X-Received: by 2002:a17:906:2308:b0:903:967b:42d8 with SMTP id
 l8-20020a170906230800b00903967b42d8mr3815668eja.4.1677704454274; Wed, 01 Mar
 2023 13:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20230301193403.1507484-1-surenb@google.com> <Y/+wlg5L8A1iebya@cmpxchg.org>
 <CAJuCfpHhA4XpoE96u5CPktDcSChUkQG_Ax58NzJOiOoF2K+3qQ@mail.gmail.com>
In-Reply-To: <CAJuCfpHhA4XpoE96u5CPktDcSChUkQG_Ax58NzJOiOoF2K+3qQ@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Wed, 1 Mar 2023 13:00:43 -0800
Message-ID: <CAC_TJvfZu7-3QWF6EyEphZusnk8gjM-w3bw3K26TBnoY221yeQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] psi: remove 500ms min window size limitation for triggers
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, tj@kernel.org,
        lizefan.x@bytedance.com, peterz@infradead.org, johunt@akamai.com,
        mhocko@suse.com, keescook@chromium.org, quic_sudaraja@quicinc.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 12:48=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Mar 1, 2023 at 12:07=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Wed, Mar 01, 2023 at 11:34:03AM -0800, Suren Baghdasaryan wrote:
> > > Current 500ms min window size for psi triggers limits polling interva=
l
> > > to 50ms to prevent polling threads from using too much cpu bandwidth =
by
> > > polling too frequently. However the number of cgroups with triggers i=
s
> > > unlimited, so this protection can be defeated by creating multiple
> > > cgroups with psi triggers (triggers in each cgroup are served by a si=
ngle
> > > "psimon" kernel thread).
> > > Instead of limiting min polling period, which also limits the latency=
 of
> > > psi events, it's better to limit psi trigger creation to authorized u=
sers
> > > only, like we do for system-wide psi triggers (/proc/pressure/* files=
 can
> > > be written only by processes with CAP_SYS_RESOURCE capability). This =
also
> > > makes access rules for cgroup psi files consistent with system-wide o=
nes.
> > > Add a CAP_SYS_RESOURCE capability check for cgroup psi file writers a=
nd
> > > remove the psi window min size limitation.
> > >
> > > Suggested-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> > > Link: https://lore.kernel.org/all/cover.1676067791.git.quic_sudaraja@=
quicinc.com/
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  kernel/cgroup/cgroup.c | 10 ++++++++++
> > >  kernel/sched/psi.c     |  4 +---
> > >  2 files changed, 11 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > > index 935e8121b21e..b600a6baaeca 100644
> > > --- a/kernel/cgroup/cgroup.c
> > > +++ b/kernel/cgroup/cgroup.c
> > > @@ -3867,6 +3867,12 @@ static __poll_t cgroup_pressure_poll(struct ke=
rnfs_open_file *of,
> > >       return psi_trigger_poll(&ctx->psi.trigger, of->file, pt);
> > >  }
> > >
> > > +static int cgroup_pressure_open(struct kernfs_open_file *of)
> > > +{
> > > +     return (of->file->f_mode & FMODE_WRITE && !capable(CAP_SYS_RESO=
URCE)) ?
> > > +             -EPERM : 0;
> > > +}
> >
> > I agree with the change, but it's a bit unfortunate that this check is
> > duplicated between system and cgroup.
> >
> > What do you think about psi_trigger_create() taking the file and
> > checking FMODE_WRITE and CAP_SYS_RESOURCE against file->f_cred?
>
> That's definitely doable and we don't even need to pass file to
> psi_trigger_create() since it's called only when we write to the file.
> However by moving the capability check into psi_trigger_create() we
> also postpone the check until write() instead of failing early in
> open(). I always assumed failing early is preferable but if
> consolidating the code here makes more sense then I can make the
> switch. Please let me know if you still prefer to move the check.
>

I always assumed the convention is to check the credentials on open()
per Linus comment here:

https://lore.kernel.org/r/CAHk-=3DwhDkekE8n2LdPiKHeTdRnV--ys0V0nPZ76oPaE0fn=
-d+g@mail.gmail.com/#t

--Kalesh
