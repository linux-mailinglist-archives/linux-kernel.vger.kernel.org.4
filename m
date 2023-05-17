Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8244705CAD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjEQBw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjEQBw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:52:57 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F753AB5
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:52:54 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f383d6f2f8so294458e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 18:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684288373; x=1686880373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uSn2j+o6brTdiV4KWV9oi4irxZ7aUpc4rDLJUPIBMA=;
        b=ASxqTeKcFDF5iZPV2l5t78E2cmQUxr32DDnTTdNhY9MaBVRejXvuDdeiVO5v7czS8D
         iLov4ndX7KkMM91vMLfVJND3m+77BoIuUm0bGnyCqoO5Jj6hPx3NSvoiTOgphgfZnWDK
         kh/23om5JH7OMpR4bIwO6Y4jxoHrtLUm0MYrvdawQ4BWoO7MAwYGG4Sl5Yigu/Mk5LL6
         eNPkY3EeYV7I+UW1r88oLKbZxSYeLyiDI1lrhNAJPAvI8RdpaqV+SKdNlIA3mINjZkcX
         UM1K6VJw4R1NRgVkHqpStq7t3GAmnsW5Y97JS/ID0SeD2xnpsAndAdOaaUpm1Y+9gGLR
         fAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684288373; x=1686880373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uSn2j+o6brTdiV4KWV9oi4irxZ7aUpc4rDLJUPIBMA=;
        b=K8hm/5H+DOck/W03pDiCKAV/9YeEOZvaCe7R87Ip6BghlsJNqzLyKxGghvuAAAs6fZ
         NgpbAi9YXWmd9Uhi8RRjmoy5IwJkNh5SCQ/p2k8lyVFvbtWjcULDQqcO1QBEdF6yHigs
         Mrv5GYe6C2YBQuVjSaXDHFMi0SjfaZSbZv2gJ1sE2mKjd1GLonoUN7QSBIx10j6YRwOG
         ruWfB9TI0MdRRYk0krEj/BkyhF8Z+wo+tRqeUHUJgAUwbE/8ljD26n/MOeVvu6PvDJTU
         kT3VnmeDhQgfIVd75S91QWIlx9eADuIp5Rz58aBZR8O928MR0bQlaX9gAMU74mYIb5Ep
         co/g==
X-Gm-Message-State: AC+VfDzXrNh73ux5Ix51ykXVGZD46ydtNIK9d9RjP1Cb8H1ROc9Zv0CG
        l7RElou1OY1Miveoo6LiVtN33uAIXIst68yAtqUufbX0pfo=
X-Google-Smtp-Source: ACHHUZ4lybhr+7tAGVcOEEV5mBL51wTt2KO8BKSUBJyE2mkzFoAMOYTclJRYUoDa968h/to/BVVCsF/wT3D6JbVMKmY=
X-Received: by 2002:ac2:5d25:0:b0:4d8:8ad1:a05f with SMTP id
 i5-20020ac25d25000000b004d88ad1a05fmr8108023lfb.48.1684288372384; Tue, 16 May
 2023 18:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230516020645.160-1-ssawgyw@gmail.com> <20230516141033.GA4967@kernel.org>
In-Reply-To: <20230516141033.GA4967@kernel.org>
From:   Yuwei Guan <ssawgyw@gmail.com>
Date:   Wed, 17 May 2023 09:52:17 +0800
Message-ID: <CALJQGLmmgTA17d5FJ3R-EVurWg+rK8y05CXeON4SBRKe3kEmfw@mail.gmail.com>
Subject: Re: [PATCH] memblock: Add flags and nid info in memblock debugfs
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

Mike Rapoport <rppt@kernel.org> =E4=BA=8E2023=E5=B9=B45=E6=9C=8816=E6=97=A5=
=E5=91=A8=E4=BA=8C 22:10=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Tue, May 16, 2023 at 10:06:45AM +0800, Yuwei Guan wrote:
> > Currently, the memblock debugfs can display the count of memblock_type =
and
> > the base and end of the reg. However, when the following scenario occur=
s,
> > the information in the existing debugfs cannot make it clear why the
> > address is not consecutive.
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
> > cnt     flags   base..end
> > 0:      0x0     0x0000000080000000..0x00000000901fffff
> > 1:      0x4     0x0000000090200000..0x00000000905fffff
> > 2:      0x0     0x0000000090600000..0x0000000092ffffff
> > 3:      0x4     0x0000000093000000..0x00000000973fffff
> > 4:      0x0     0x0000000097400000..0x00000000b71fffff
> > 5:      0x0     0x00000000c0000000..0x00000000dfffffff
> > 6:      0x0     0x00000000e2500000..0x00000000f87fffff
> > 7:      0x4     0x00000000f8800000..0x00000000fa7fffff
> > 8:      0x0     0x00000000fa800000..0x00000000fd3effff
> > 9:      0x4     0x00000000fd3f0000..0x00000000fd3fefff
> > 10:     0x0     0x00000000fd3ff000..0x00000000fd7fffff
> > 11:     0x4     0x00000000fd800000..0x00000000fd901fff
> > 12:     0x0     0x00000000fd902000..0x00000000fd909fff
> > 13:     0x4     0x00000000fd90a000..0x00000000fd90bfff
> > 14:     0x0     0x00000000fd90c000..0x00000000ffffffff
> > 15:     0x0     0x0000000880000000..0x0000000affffffff
> >
> > Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
> > ---
> >  mm/memblock.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 45f198750be9..34230b258e21 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -2045,11 +2045,21 @@ static int memblock_debug_show(struct seq_file =
*m, void *private)
> >       int i;
> >       phys_addr_t end;
> >
> > +#ifdef CONFIG_NUMA
> > +     seq_puts(m, "cnt\tflags\tnid\tbase..end\n");
> > +#else
> > +     seq_puts(m, "cnt\tflags\tbase..end\n");
> > +#endif
> > +
> >       for (i =3D 0; i < type->cnt; i++) {
> >               reg =3D &type->regions[i];
> >               end =3D reg->base + reg->size - 1;
> >
> > -             seq_printf(m, "%4d: ", i);
> > +             seq_printf(m, "%d:\t", i);
> > +             seq_printf(m, "0x%x\t", reg->flags);
> > +#ifdef CONFIG_NUMA
> > +             seq_printf(m, "0x%x\t", reg->nid);
> > +#endif
>
> Please add flags and node information after the ranges and print node for
> UMA case as well. I'd prefer to have zeros in debugfs rather than ifdefs
> here. Just use memblock_get_region_node() instead of r->nid.
>

Thanks for the code review. I will update it and send a v2 patch.

> >               seq_printf(m, "%pa..%pa\n", &reg->base, &end);
> >       }
> >       return 0;
> > --
> > 2.34.1
> >
>
> --
> Sincerely yours,
> Mike.
