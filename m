Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9158A713A26
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 16:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjE1Oio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 10:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjE1Oim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 10:38:42 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06E3B8
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 07:38:40 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af2b74d258so24942701fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 07:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685284719; x=1687876719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAfNOgzmGHj2iulpU1MX94nyYnzy1xUiHwn7EpMMh1Q=;
        b=qhTML6pAtTYXfvx2x8gNdM9FJC3dIdin3pnTwScsukhs4W/nadfvLmR+B6+KE4Pmc4
         AyWHpUg8U9/BggjWSg5V7hU/0ywFYmlP9I5xroqJpQwWouCxw6FFMLk3uDtgDXALKOUp
         zRHBNMmulFErq2dOhVxQXo+7QNXRJleJJOc1JmaBG9sbPHHRzqdgFx5t3r+g1/+ygLPV
         65jrqxe6va3j+QX5Rpa47cY6qBkkeEWfUGbQdyKbEmzhoPmlTMlwEjtDVt6tbKFW4Ubh
         KEV19rFR4eAuKbMo//yVb77G1bpKmZpEO1W6FoFnrbn+kyhVxzzmZ+lJ7h7VIzFcFYzt
         2MNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685284719; x=1687876719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAfNOgzmGHj2iulpU1MX94nyYnzy1xUiHwn7EpMMh1Q=;
        b=GsrolvH8cMN6ZOQpiI5Vg2Jo6UI0R8bPqmZqwch3XulDc1wM5q7DowdcHE90ncdrUb
         D0Jvhrfg3huza/m+U0TxDFw8FANzbRQ5Fe0IbEOHbMujWUhtYMbdVeDF5syPhlpyMhIw
         H283ezjgOjn2LcuAAq4uYrXsRqf85wTuIz4bULjzDYp65nJ2PwcoCNagMgwx8cV8m5BL
         WPx97Fxt5jN4f2AxZPo2mVNog2CnEr+xUeAVHdgSnm9MjFSvGN+I4j6/ycC9iV9erIgy
         E7VSnJpvDMTyo84T9M/4bNIvjMwYbC7vdrK5FWI/q/4W2BSznqpSu8EjsMy8kSAaEFl7
         vVvg==
X-Gm-Message-State: AC+VfDxpxsiRbW079eiPvlM5Me+47gqouaRS67K1rz0WfThzaS4CVvMp
        uPLO7LKuq6AtQ6wRcqgCowY7yFwj55+qIHWZ9kM=
X-Google-Smtp-Source: ACHHUZ6L3vKwutaozdePAL2qOIEtCYNsOefvS4/Yc8v+KrPWV5S9wPNnkshnyBGN5B+kG3fTMiASrcNRzNQ5ZiZZCLc=
X-Received: by 2002:a05:651c:1041:b0:2af:20d2:bb7b with SMTP id
 x1-20020a05651c104100b002af20d2bb7bmr3531083ljm.43.1685284718826; Sun, 28 May
 2023 07:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230519105321.333-1-ssawgyw@gmail.com> <20230527103722.GG4967@kernel.org>
In-Reply-To: <20230527103722.GG4967@kernel.org>
From:   Yuwei Guan <ssawgyw@gmail.com>
Date:   Sun, 28 May 2023 22:38:03 +0800
Message-ID: <CALJQGLmn3JkYBZgkJXOc2mMy_2u4HZRUzdfaLm+uF8MQQCWsgg@mail.gmail.com>
Subject: Re: [PATCH v4] memblock: Add flags and nid info in memblock debugfs
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, tsahu@linux.ibm.com,
        anshuman.khandual@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport <rppt@kernel.org> =E4=BA=8E2023=E5=B9=B45=E6=9C=8827=E6=97=A5=
=E5=91=A8=E5=85=AD 18:37=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Yuwei,
>
> On Fri, May 19, 2023 at 06:53:21PM +0800, Yuwei Guan wrote:
> > Currently, the memblock debugfs can display the count of memblock_type =
and
> > the base and end of the reg. However, when memblock_mark_*() or
> > memblock_set_node() is executed on some range, the information in the
> > existing debugfs cannot make it clear why the address is not consecutiv=
e.
> >
> > For example,
> > cat /sys/kernel/debug/memblock/memory
> >    0: 0x0000000080000000..0x00000000901fffff
> >    1: 0x0000000090200000..0x00000000905fffff
> >    2: 0x0000000090600000..0x0000000092ffffff
> >    3: 0x0000000093000000..0x00000000973fffff
> >    4: 0x0000000097400000..0x00000000b71fffff
> >    5: 0x00000000c0000000..0x00000000dfffffff
> >    6: 0x00000000e2500000..0x00000000f87fffff
> >    7: 0x00000000f8800000..0x00000000fa7fffff
> >    8: 0x00000000fa800000..0x00000000fd3effff
> >    9: 0x00000000fd3f0000..0x00000000fd3fefff
> >   10: 0x00000000fd3ff000..0x00000000fd7fffff
> >   11: 0x00000000fd800000..0x00000000fd901fff
> >   12: 0x00000000fd902000..0x00000000fd909fff
> >   13: 0x00000000fd90a000..0x00000000fd90bfff
> >   14: 0x00000000fd90c000..0x00000000ffffffff
> >   15: 0x0000000880000000..0x0000000affffffff
> >
> > So we can add flags and nid to this debugfs.
> >
> > For example,
> > cat /sys/kernel/debug/memblock/memory
> >    0: 0x0000000080000000..0x00000000901fffff    0 NONE
> >    1: 0x0000000090200000..0x00000000905fffff    0 NOMAP
> >    2: 0x0000000090600000..0x0000000092ffffff    0 NONE
> >    3: 0x0000000093000000..0x00000000973fffff    0 NOMAP
> >    4: 0x0000000097400000..0x00000000b71fffff    0 NONE
> >    5: 0x00000000c0000000..0x00000000dfffffff    0 NONE
> >    6: 0x00000000e2500000..0x00000000f87fffff    0 NONE
> >    7: 0x00000000f8800000..0x00000000fa7fffff    0 NOMAP
> >    8: 0x00000000fa800000..0x00000000fd3effff    0 NONE
> >    9: 0x00000000fd3f0000..0x00000000fd3fefff    0 NOMAP
> >   10: 0x00000000fd3ff000..0x00000000fd7fffff    0 NONE
> >   11: 0x00000000fd800000..0x00000000fd901fff    0 NOMAP
> >   12: 0x00000000fd902000..0x00000000fd909fff    0 NONE
> >   13: 0x00000000fd90a000..0x00000000fd90bfff    0 NOMAP
> >   14: 0x00000000fd90c000..0x00000000ffffffff    0 NONE
> >   15: 0x0000000880000000..0x0000000affffffff    0 NONE
> >
> > Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
> > ---
> > v4:
> > - show string value for each memblock flag
> > ---
> >  mm/memblock.c | 24 ++++++++++++++++++++++--
> >  1 file changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 511d4783dcf1..10d0ddbeebc1 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -2136,12 +2136,19 @@ void __init memblock_free_all(void)
> >  }
> >
> >  #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
> > +static const char * const flagname[] =3D {
> > +     [ilog2(MEMBLOCK_HOTPLUG)] =3D "HOTPLUG",
> > +     [ilog2(MEMBLOCK_MIRROR)] =3D "MIRROR",
> > +     [ilog2(MEMBLOCK_NOMAP)] =3D "NOMAP",
> > +     [ilog2(MEMBLOCK_DRIVER_MANAGED)] =3D "DRV_MNG",
> > +};
> >
> >  static int memblock_debug_show(struct seq_file *m, void *private)
> >  {
> >       struct memblock_type *type =3D m->private;
> >       struct memblock_region *reg;
> > -     int i;
> > +     int i, j;
> > +     unsigned int count =3D ARRAY_SIZE(flagname);
> >       phys_addr_t end;
> >
> >       for (i =3D 0; i < type->cnt; i++) {
> > @@ -2149,7 +2156,20 @@ static int memblock_debug_show(struct seq_file *=
m, void *private)
> >               end =3D reg->base + reg->size - 1;
> >
> >               seq_printf(m, "%4d: ", i);
> > -             seq_printf(m, "%pa..%pa\n", &reg->base, &end);
> > +             seq_printf(m, "%pa..%pa ", &reg->base, &end);
> > +             seq_printf(m, "%4d ", memblock_get_region_node(reg));
>
> As Kefeng mentioned, the node id for reserved regions will be wrong, so
> this needs to be updated so that when reg->nid =3D=3D MAX_NUMNODES we'll =
print
> e.g. 'x'.
Hi Mike,

How about print 'x' when reg->nid =3D=3D MAX_NUMNODES, base on this patch,
https://lore.kernel.org/linux-mm/44ce007d-8049-1cc9-7e2e-4ccb51a2867d@huawe=
i.com/T/#m6d214d4ea8912b64f5efc9c3f51ae71aa057d1f1

diff --git a/mm/memblock.c b/mm/memblock.c
index c5c80d9bcea3..3d449aaba052 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2169,17 +2169,21 @@ static int memblock_debug_show(struct seq_file
*m, void *private)
 {
  struct memblock_type *type =3D m->private;
  struct memblock_region *reg;
- int i, j;
+ int i, j, nid;
  unsigned int count =3D ARRAY_SIZE(flagname);
  phys_addr_t end;

  for (i =3D 0; i < type->cnt; i++) {
  reg =3D &type->regions[i];
  end =3D reg->base + reg->size - 1;
+ nid =3D memblock_get_region_node(reg);

  seq_printf(m, "%4d: ", i);
  seq_printf(m, "%pa..%pa ", &reg->base, &end);
- seq_printf(m, "%4d ", memblock_get_region_node(reg));
+ if (nid !=3D MAX_NUMNODES)
+ seq_printf(m, "%4d ", nid);
+ else
+ seq_printf(m, "%4c ", 'x');
  if (reg->flags) {
  for (j =3D 0; j < count; j++) {
  if (reg->flags & (1U << j)) {

>
> > +             if (reg->flags) {
> > +                     for (j =3D 0; j < count; j++) {
> > +                             if (reg->flags & (1U << j)) {
> > +                                     seq_printf(m, "%s\n", flagname[j]=
);
> > +                                     break;
> > +                             }
> > +                     }
> > +                     if (j =3D=3D count)
> > +                             seq_printf(m, "%s\n", "UNKNOWN");
> > +             } else {
> > +                     seq_printf(m, "%s\n", "NONE");
> > +             }
> >       }
> >       return 0;
> >  }
> > --
> > 2.34.1
> >
>
> --
> Sincerely yours,
> Mike.
