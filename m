Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7310719C32
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjFAMdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjFAMdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:33:46 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E220119
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 05:33:45 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2af1c884b08so10847141fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 05:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685622823; x=1688214823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xuNmGeBoyY3s0zhZ1IhpRi/BmN94XemwcFLXSRRERc=;
        b=DPqEoaFF3XiLH9C+h0qL0dQtK8UKZuSE1tFFiHuim3y0mMeeCyjvFwvOuRsz40c3GA
         Md5BGJYW0XYSS0Zrf2u1/qw1uRMGzwouBvHhwVUxXkpyXR7/Ylq9F4TsS3BeLwnXUVp7
         6Btd8Vq3x77Eb6Gh2M71PxjEkzHrVyo8dYZGjQoFVs2p0VnnHR1z06Ax9MJuQrNJfTN2
         MSRgtaFeqmfzIlaRBjCUH9La/jbJbbuKVLyAYlDKPMVUlQvVvyFEorJ1GPjvQZFIDUlm
         Dw7ohEQ7WQ+wSOFtfyvMOJXzSeBPibiw8R4U/vdZzOtKEdJ5u8XM6Jriiu+GfunV8IMF
         sCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685622823; x=1688214823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xuNmGeBoyY3s0zhZ1IhpRi/BmN94XemwcFLXSRRERc=;
        b=kRM050NH+Cxhrhus4PMIq/DkPytpJPZgHv+F4HOjgTx90FsFgGG9K4+bdtax7HuSN1
         oleJH+JQVfeqXWZ9YCb329xqXndgAyJwV2CiCysIPdL3DwqlKV0iLW/5YGgrT8DJ1iH9
         zgaBJqHvm23/6q4w3hBP6/23KXWxFejUvg/T+Sy4py2/dNMH2+znElVdQsNP1xCZvkmt
         /p3XY5Qp07hens033lJLq3X49M+Gs6woCBV6z/5+Lm9MA/svfc+ZW1MR0NRf+WxJXwQS
         qStbVReDNjv93fZoxRIFbQ9pvyCLLQTtq4cPhzd39ZeXijOQa8dI7GrztvOVH3TlmROL
         n10w==
X-Gm-Message-State: AC+VfDxgPmTMEMVHx6D/8y9KZqqDO5bQiu8gecNyAOOm829SVeT6t+a2
        Ur+/uJwP40fiRP0CPVVCfXxf+qw0Bq7Xp09hvbA=
X-Google-Smtp-Source: ACHHUZ70q/oxQHBLQ4cueOlIjRp0pnWKmhx+R6fMI79Eo09E6RkQv5/5VFd/EqLvc6WxV3zxLNeKny+Xj16QpYzyHWg=
X-Received: by 2002:a2e:6e17:0:b0:2b0:8632:238d with SMTP id
 j23-20020a2e6e17000000b002b08632238dmr622345ljc.15.1685622823204; Thu, 01 Jun
 2023 05:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230529062002.157-1-ssawgyw@gmail.com> <20230601052116.GC395338@kernel.org>
In-Reply-To: <20230601052116.GC395338@kernel.org>
From:   Yuwei Guan <ssawgyw@gmail.com>
Date:   Thu, 1 Jun 2023 20:33:06 +0800
Message-ID: <CALJQGLn7b9n8BMn6fQuUgz08oHiMPeguWr5EAPSubQkQe4V0dw@mail.gmail.com>
Subject: Re: [PATCH] memblock: Update nid info in memblock debugfs
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        anshuman.khandual@arm.com, linux-mm@kvack.org,
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

Mike Rapoport <rppt@kernel.org> =E4=BA=8E2023=E5=B9=B46=E6=9C=881=E6=97=A5=
=E5=91=A8=E5=9B=9B 13:21=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, May 29, 2023 at 02:20:02PM +0800, Yuwei Guan wrote:
> > The node id for memblock reserved regions will be wrong,
> > so let's show 'x' for reg->nid =3D=3D MAX_NUMNODES in debugfs to keep i=
t align.
> >
> > Suggested-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
>
> I believe this could use Co-developed-by tags.
> Please take a look at Documentation/process/submitting-patches.rst
>
Hi Mike,

Thanks, I will look into it, and resend this patch soon.
> > ---
> >  mm/memblock.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index c5c80d9bcea3..3d449aaba052 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -2169,17 +2169,21 @@ static int memblock_debug_show(struct seq_file =
*m, void *private)
> >  {
> >       struct memblock_type *type =3D m->private;
> >       struct memblock_region *reg;
> > -     int i, j;
> > +     int i, j, nid;
> >       unsigned int count =3D ARRAY_SIZE(flagname);
> >       phys_addr_t end;
> >
> >       for (i =3D 0; i < type->cnt; i++) {
> >               reg =3D &type->regions[i];
> >               end =3D reg->base + reg->size - 1;
> > +             nid =3D memblock_get_region_node(reg);
> >
> >               seq_printf(m, "%4d: ", i);
> >               seq_printf(m, "%pa..%pa ", &reg->base, &end);
> > -             seq_printf(m, "%4d ", memblock_get_region_node(reg));
> > +             if (nid !=3D MAX_NUMNODES)
> > +                     seq_printf(m, "%4d ", nid);
> > +             else
> > +                     seq_printf(m, "%4c ", 'x');
> >               if (reg->flags) {
> >                       for (j =3D 0; j < count; j++) {
> >                               if (reg->flags & (1U << j)) {
> > --
> > 2.34.1
> >
>
> --
> Sincerely yours,
> Mike.
