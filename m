Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318A86DEAEE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDLFV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDLFVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E204489
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 22:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681276863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JqxqUicjNetRTQQMEz2T27cplxcUTPiDbzMlGWnvaLw=;
        b=HK9ORqu8nPON/xVk2RiyaQY1Y2E8FeMnMLmgb3RDBaMgc4Kqtci83S0EhFHpl5jJovyDqL
        lnEeDx2MOA58SZ8T9X0uIVBVxieQyPjDWJHu24d98X2eZSOQK66h5BmN2ughJBxUISkmcS
        3m8GQEmSsbbKDHb37NLDB05myzVx1RA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-phVysobBM2aX0ib18pyitw-1; Wed, 12 Apr 2023 01:21:02 -0400
X-MC-Unique: phVysobBM2aX0ib18pyitw-1
Received: by mail-ej1-f72.google.com with SMTP id z20-20020a17090674d400b0094a6ea48185so3170868ejl.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 22:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681276860; x=1683868860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqxqUicjNetRTQQMEz2T27cplxcUTPiDbzMlGWnvaLw=;
        b=qJv9A3b9yWgpJhx3yKq5yEFVRi+0F74jeTutfxkOK6nqqJILEKbdoPmT3cwuuWdoGF
         623jxZNdQNu2/to+HipYRlabLC1Y4YCl+ujscPPENjldS2kPhjcLQoeYlZcKtmP2w6B+
         D0f/ynEUNpAcp5dYzjUVBcH1XqsxeB/1k++krXPLnkRs/3ozcLj4FFZugKDajpNzh9ZM
         1ajLbaZtuFbVO9LMsmqWfbb5S2kbkGXlmPuqZvcS4E1bB3HA7D8sWeBnHq//yU0A64ej
         wGICLN7V5kbXWEpSnfZshqpphJIPEyy89CQTk3Ii8iLwsLglyNeqcSO2VDX0nbaHDt3S
         RMYA==
X-Gm-Message-State: AAQBX9dmCnyZLz9bdwdKB0uFLZitZD5CA1c0ofM60hMaD3M3IBtX/j/O
        XRKQSQuGVtn3vfmNrnGTdj7FrqvJieW7dZ9NYHhOOm0prPO00rjx697bo0wTu/e6iVXVlA8eTdh
        +HGrnx5UFzWaI7EnBuCuv0uOovpcj8jD/ilhT16AzZoKrAjTrZSE=
X-Received: by 2002:a17:906:7f97:b0:94a:5691:b12b with SMTP id f23-20020a1709067f9700b0094a5691b12bmr5715087ejr.11.1681276860317;
        Tue, 11 Apr 2023 22:21:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZICmgEqGJkx48se3yBQ6rYH4gDzJv11aUZUml5J+lPHZHU3waRoOPqBX/Zk6KRdfT5kBlK8PC0jqrvMTBKvzM=
X-Received: by 2002:a17:906:7f97:b0:94a:5691:b12b with SMTP id
 f23-20020a1709067f9700b0094a5691b12bmr5715080ejr.11.1681276859949; Tue, 11
 Apr 2023 22:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230410160727.3748239-1-ryasuoka@redhat.com> <20230410163029.GC360889@frogsfrogsfrogs>
 <20230410175946.GD360889@frogsfrogsfrogs>
In-Reply-To: <20230410175946.GD360889@frogsfrogsfrogs>
From:   Ryosuke Yasuoka <ryasuoka@redhat.com>
Date:   Wed, 12 Apr 2023 14:20:48 +0900
Message-ID: <CAHpthZp+h-4nEGhNhBvSXxv6LGFUX=H646U6tHEF5_kwM3ij6Q@mail.gmail.com>
Subject: Re: [PATCH v2] xfs: Use for_each_perag_from() to iterate all
 available AGs
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, david@fromorbit.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Darrick

Thank you for reviewing.

On Tue, Apr 11, 2023 at 1:30=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Apr 11, 2023 at 01:07:27AM +0900, Ryosuke Yasuoka wrote:
> > xfs_filestream_pick_ag() iterates all the available AGs when no
> > unassociated AGs are available by using for_each_perag_wrap().
> > To iterate all the available AGs, just use for_each_perag_from() instea=
d.
> >
> >
> > This patch cleans up a code where xfs_filestream_pick_ag() iterates
> > all the available AGs when no unassociated AGs are available.
> > Current implementation is using a for_each_perag_wrap() macro which
> > iterates all AGs from start_agno through wrap_agno, wraps to
> > restart_agno, and then iterates again toward to (start_agno - 1).
> > In this case, xfs_filestream_pick_ag() start to iterate from 0 and
> > does't need to wrap. Although passing 0 as start_agno to
> > for_each_perag_wrap()
> > is not problematic, we have already a for_each_perag() macro family
> > which just iterates all AGs from 0 and doesn't wrap. Hense, I propose
> > to use for_each_perag() family simply.
> >
> >
> > Changes since v1 [1]:
> > Use for_each_perag_from() instead of for_each_perag() to clarify
> > where we are iterating from.
> >
> > [1]:
> > https://lore.kernel.org/linux-xfs/CAHpthZrvhqh8O1HO7U_jVnaq9R9Ur=3DYq2e=
WzjWfNx3ryDbnGPA@mail.gmail.com/T/#m5704d0409bec1ce5273be0d3860e8ad60e9886f=
d
> >
> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > ---
> >  fs/xfs/xfs_filestream.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/xfs/xfs_filestream.c b/fs/xfs/xfs_filestream.c
> > index 22c13933c8f8..29acd9f7d422 100644
> > --- a/fs/xfs/xfs_filestream.c
> > +++ b/fs/xfs/xfs_filestream.c
> > @@ -151,7 +151,8 @@ xfs_filestream_pick_ag(
> >                * grab.
> >                */
> >               if (!max_pag) {
> > -                     for_each_perag_wrap(args->mp, 0, start_agno, args=
->pag)
> > +                     start_agno =3D 0;
> > +                     for_each_perag_from(args->mp, start_agno, args->p=
ag)
>
> IDGI.  for_each_perag initializes the loop variable and calls
> for_each_perag_from, so this is open-coding an existing macro.
>
> If people are confused by the reuse of the function call parameter
> variable for the second loop, then either declare a new variable and let
> the compiler notice that we never use start_agno ever again and reuse
> a cpu register:
>
>         if (!max_pag) {
>                 xfs_agnumber_t  agno;
>
>                 for_each_perag(args->mp, agno, args->pag)
>                         break;
>                 ...
>         }
>
> Or reuse it explicitly and leave a comment:
>
>         if (!max_pag) {
>                 /*
>                  * Use any AG that we can grab.  start_agno is no longer
>                  * pertinent here so we can reuse the variable.
>                  */
>                 for_each_perag(args->mp, start_agno, args->pag)
>                         break;
>                 ...
>         }
>
> As a third alternative, I suppose you could encapsulate all of that into
> a dorky helper since I bet this isn't the first or the last time we're
> going to need something like this:
>
> static inline struct xfs_perag *
> xfs_perag_get_first_avail(
>         struct xfs_mount        *mp)
> {
>         struct xfs_perag        *pag;
>         xfs_agnumber_t          agno;
>
>         for_each_perag(mp, agno, pag)
>                 return pag;
>
>         ASSERT(0);
>         return NULL;
> }
>
>         if (!max_pag) {
>                 args->pag =3D xfs_perag_get_first_avail(mp);
>                 ...
>         }

OK. I update my patch with your third alternative. I'll add
xfs_perag_get_first_avail() in xfs_filestream.h.

It is a great idea because it can detect with ASSERT(0) if
for_each_perag() gets no pag structure.

The following syzbot bug [2] is an indeed pattern of this.

[2]: https://syzkaller.appspot.com/bug?id=3Df7682cf37b02ddf3c87d88b80f74024=
cf330017b

On Tue, Apr 11, 2023 at 2:59=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> Oh, also -- I ran the whole codebase through smatch this morning.
> Could you please set @err to zero in its declaration above?  If the
> first for_each_perag_wrap never manages to get any perag structures
> (currently impossible with the codebase) then err will be undefined and
> probably nonzero.
>
>   CHECK  fs/xfs/xfs_filestream.c
> fs/xfs/xfs_filestream.c:120
> xfs_filestream_pick_ag() error: uninitialized symbol 'err'.
>
> --D

OK. I will also update it like this. Is my understanding correct?

@@ -67,7 +67,7 @@ xfs_filestream_pick_ag(
xfs_extlen_t free =3D 0, minfree, maxfree =3D 0;
xfs_agnumber_t agno;
bool first_pass =3D true;
- int err;
+ int err =3D 0;

Best regards,
Ryosuke

