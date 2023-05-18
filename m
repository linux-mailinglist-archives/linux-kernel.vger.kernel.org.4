Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3595708387
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjEROFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjEROFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:05:51 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BFD1B5
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:05:49 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ac78bb48eeso21752441fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684418748; x=1687010748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7TdkTgtpE/I5dsPVP8TWDXytE/RrW+PwM2s8w+gwFY=;
        b=GS7wjn4PcfDHmmm7bCvTMJ6/VxFscD+K7r2sSRTWA92AzvdGAW+mLHSZ6LQgt3becE
         YCm/Gb1vZgOxcrPf0wjX2kToPXXJz9yKj6RJ0ONCwahGiZN279j/WDxfhzh7eSWWn8Cu
         LAabtXv4OEQ1iG8SuhAseIrvATG+9WGVS+JoP7UoRa0Di7NVc81cPV/Yc4Cnz96rTBoi
         j3uUmYaAGUvTcnPI55igt+XDtOZtuzZHbtYBTCd6MNDF/oG1cGxMZofUiqtBYjGcWjUX
         xotMhzyRhMsY2Wu5+aXROPe4A8D77YP2lOfomGxpZqjqvycqK4GGoDUm2ESKMtrpTsqG
         58FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684418748; x=1687010748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7TdkTgtpE/I5dsPVP8TWDXytE/RrW+PwM2s8w+gwFY=;
        b=JihK6Whs4qM4Yb+f0Cehb/t6y7PRA+zc6m+//jev8pC4OhF0WxxOURu0mVZGmExSVx
         jDs1YPxHbNKlnow0nZRxzo0FAYkkby+PBKHCmcmjrgLvHG9DNJv4gyiEpJ1RSbqrvVFI
         BrtbxOji34nWg1zky310/+eJP600d9ErEb7m21ph/Ko5LjDjSZCyoUd1zJETt2wpG/Ie
         sUS6zuxW+FbIgHH+Jk+juJ053MigEinEiPT8m4azSR0aDFtnQ9eLwVNYAuQ/j/zp64Bj
         hyoF8OB4nBk39OLeM+eTPnD3wDW0JhudE5VrU60zreCJKKASgDuc/v1P+lZ+V3bYiNOC
         pINw==
X-Gm-Message-State: AC+VfDw4S8MFW6FXpd25Sk/yfaN5jQ3th352zOV+/CIOl4JW3eGpxMw0
        DNAgz39NVVSZyWVNlJyF8nLZyYNaC+So3tv0zgU=
X-Google-Smtp-Source: ACHHUZ6gAkeIlFb6/m30ztG2GkuG0Lv/Dt9j4d62CUz8C9sY+cA7/bnkyPTgGNRJcf5LpsMTOTseuRZu1v5Bqx9s4E0=
X-Received: by 2002:a2e:3517:0:b0:2a7:a5f7:9651 with SMTP id
 z23-20020a2e3517000000b002a7a5f79651mr10655475ljz.23.1684418747549; Thu, 18
 May 2023 07:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230518091431.299-1-ssawgyw@gmail.com> <ab37a497-3caa-1313-90a8-328cfe99c8d3@arm.com>
In-Reply-To: <ab37a497-3caa-1313-90a8-328cfe99c8d3@arm.com>
From:   Yuwei Guan <ssawgyw@gmail.com>
Date:   Thu, 18 May 2023 22:05:11 +0800
Message-ID: <CALJQGLkLBrgtiz1f=_NHZG5jtwn2TfzqB4yCgfxxmQWXbfN7dQ@mail.gmail.com>
Subject: Re: [PATCH v3] memblock: Add flags and nid info in memblock debugfs
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     rppt@kernel.org, akpm@linux-foundation.org, tsahu@linux.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

Anshuman Khandual <anshuman.khandual@arm.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=
=8818=E6=97=A5=E5=91=A8=E5=9B=9B 18:12=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 5/18/23 14:44, Yuwei Guan wrote:
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
> >    0: 0x0000000080000000..0x00000000901fffff     NONE    0
> >    1: 0x0000000090200000..0x00000000905fffff    NOMAP    0
> >    2: 0x0000000090600000..0x0000000092ffffff     NONE    0
> >    3: 0x0000000093000000..0x00000000973fffff    NOMAP    0
> >    4: 0x0000000097400000..0x00000000b71fffff     NONE    0
> >    5: 0x00000000c0000000..0x00000000dfffffff     NONE    0
> >    6: 0x00000000e2500000..0x00000000f87fffff     NONE    0
> >    7: 0x00000000f8800000..0x00000000fa7fffff    NOMAP    0
> >    8: 0x00000000fa800000..0x00000000fd3effff     NONE    0
> >    9: 0x00000000fd3f0000..0x00000000fd3fefff    NOMAP    0
> >   10: 0x00000000fd3ff000..0x00000000fd7fffff     NONE    0
> >   11: 0x00000000fd800000..0x00000000fd901fff    NOMAP    0
> >   12: 0x00000000fd902000..0x00000000fd909fff     NONE    0
> >   13: 0x00000000fd90a000..0x00000000fd90bfff    NOMAP    0
> >   14: 0x00000000fd90c000..0x00000000ffffffff     NONE    0
> >   15: 0x0000000880000000..0x0000000affffffff     NONE    0
>
> Although, Mike had suggested to keep these flags print last, above
> format looks good as well.
>
> >
> > Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
> > ---
> > v3:
> > - show string value for each memblock flag
> > ---
> >  mm/memblock.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 511d4783dcf1..5fba53f98b2d 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -2143,13 +2143,23 @@ static int memblock_debug_show(struct seq_file =
*m, void *private)
> >       struct memblock_region *reg;
> >       int i;
> >       phys_addr_t end;
> > +     static const char flagname[BITS_PER_LONG][8] =3D {
> > +             [0 ... (BITS_PER_LONG-1)] =3D "?",
>
> Minor nit -
>
> Although checkpatch does not complain, should there be spaces between
> the operator and operands e.g (BITS_PER_LONG - 1).
>
> > +
> > +             [ilog2(MEMBLOCK_HOTPLUG)] =3D "HOTPLUG",
> > +             [ilog2(MEMBLOCK_MIRROR)] =3D "MIRROR",
> > +             [ilog2(MEMBLOCK_NOMAP)] =3D "NOMAP",
> > +             [ilog2(MEMBLOCK_DRIVER_MANAGED)] =3D "DRV_MNG",
> > +     };
>
> Also, BITS_PER_LONG sized array is really required here ? as there are
> just four available memblock flags.
>
Hi Anshuman,
The main reason to use BITS_PER_LONG is to reserve.
If the flagname buffer is (ilog2(MEMBLOCK_DRIVER_MANAGED) + 1),
memblock_flags adds a new attribute and does not add its name in debugfs,
it will cause an overflow.
But BITS_PER_LONG is too wasteful, so I implement a new solution.
Please help to check it.

        struct memblock_type *type =3D m->private;
        struct memblock_region *reg;
-       int i;
+       int i, j;
        phys_addr_t end;
+       static const char *flagname[] =3D {
+               [ilog2(MEMBLOCK_HOTPLUG)] =3D "HOTPLUG",
+               [ilog2(MEMBLOCK_MIRROR)] =3D "MIRROR",
+               [ilog2(MEMBLOCK_NOMAP)] =3D "NOMAP",
+               [ilog2(MEMBLOCK_DRIVER_MANAGED)] =3D "DRV_MNG",
+       };

        for (i =3D 0; i < type->cnt; i++) {
                reg =3D &type->regions[i];
                end =3D reg->base + reg->size - 1;

                seq_printf(m, "%4d: ", i);
-               seq_printf(m, "%pa..%pa\n", &reg->base, &end);
+               seq_printf(m, "%pa..%pa ", &reg->base, &end);
+               seq_printf(m, "%4d ", memblock_get_region_node(reg));
+               if (reg->flags) {
+                       for (j =3D 0; j < ARRAY_SIZE(flagname); j++) {
+                               if (reg->flags & (1U << j)) {
+                                       seq_printf(m, "%s\n", flagname[j]);
+                                       break;
+                               }
+                       }
+                       if (j =3D=3D ARRAY_SIZE(flagname))
+                               seq_printf(m, "%s\n", "UNKNOWN");
+               } else {
+                       seq_printf(m, "%s\n", "NONE");
+               }
        }
> >
> >       for (i =3D 0; i < type->cnt; i++) {
> >               reg =3D &type->regions[i];
> >               end =3D reg->base + reg->size - 1;
> >
> >               seq_printf(m, "%4d: ", i);
> > -             seq_printf(m, "%pa..%pa\n", &reg->base, &end);
> > +             seq_printf(m, "%pa..%pa ", &reg->base, &end);
> > +             seq_printf(m, "%8s ", reg->flags ? flagname[ilog2(reg->fl=
ags)] : "NONE");
> > +             seq_printf(m, "%4d\n", memblock_get_region_node(reg));
> >       }
> >       return 0;
> >  }
