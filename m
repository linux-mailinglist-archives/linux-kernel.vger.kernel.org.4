Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708086C483C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCVKwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjCVKvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:51:51 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1D060D7A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:51:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id kq3so6487110plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679482309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCVN8NvFNmahfNwZXQmqIKZYwz3rhCb+WsNZR0GMjac=;
        b=PCYTDgPSwnsVRjO+quqdqsdfxVQK0x8qyy3cQr77EcscrF+ykYvM+ze+t6VQgM8WsH
         1qZXjrtpzEawuOX5621QIvkwAVCNM97MiHTJ0Sfr3WkCgd74lSOYYIBrW3wFJis1nQgS
         diEGdjx/tqxHKQ9KA9EXuxhjLD+MzykrNakq2rjg5rgVAWjMBZoOB3aBsOCEAzq9o9kD
         jbdUQfsgnxARkRrySMzDuCobE9Uw0S+xQD7N8FKBQxCD4gkpf2ZsVNAJUJ2zZOr0Wtp0
         8pBViaMKdMf5K1dA8roSEEBfUE6ZQioZtHnwY8DS1iJyoVSrslMTNbnnQS5dDYBX7UuF
         b9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679482309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCVN8NvFNmahfNwZXQmqIKZYwz3rhCb+WsNZR0GMjac=;
        b=UJ1ltUg4EW6JxecnEbUaDpJ5xl1mDLs1EZ0lZoah9OPiPqQcOfS5TLfZ022r/a+y1a
         qCyg8giwM66OW2rOXaj/ZKef/U3No16dT5e7AZFYrmtTbIfdftqZGrk+Mkj76qoQv09m
         aA5V0DJm1reIP87uvRNhMLfQyXe5/ON3l6AzwOql+/XGTCZw6xPHuGSt67XxrDXY93or
         QdCPz43fNOQ422gAkbYhi6o6EwzsB2mL6DmiftUyhBQFqGVLCs7woE42rfKEfLfH56HT
         I2mowo5GMy0CJzkWxrtD29iYhN9IEmPueF3Sq2uUTUUiml43Pe7RVLW33cv0MXWhiYan
         0Orw==
X-Gm-Message-State: AO0yUKUndGjhTo74hVoxYMadovDO6HPXVPKW87EwuskhqYctpYL50EK+
        YFgPcq63za56q9jsfKfunKLYJUw0aCRDDJhcY9k=
X-Google-Smtp-Source: AK7set8QJ5xyq6hE/gvezPTx09u8amKDTQ9SBywjmf9WAjQMKrY7vGhaGOIjGh9HBjIqfDEkM9SxAz+Kc024W2Lt6HM=
X-Received: by 2002:a17:90a:bf91:b0:23b:517d:beca with SMTP id
 d17-20020a17090abf9100b0023b517dbecamr949601pjs.0.1679482309423; Wed, 22 Mar
 2023 03:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230322061856.2774840-1-suagrfillet@gmail.com> <20230322080345.j4oi7nz2nz4rk6ib@orel>
In-Reply-To: <20230322080345.j4oi7nz2nz4rk6ib@orel>
From:   Song Shuai <suagrfillet@gmail.com>
Date:   Wed, 22 Mar 2023 10:51:38 +0000
Message-ID: <CAAYs2=hg_h=dotuY2XE2ncXYg3FuiDkQmfCJ0NYfOn278HOdbQ@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: export cpu/freq invariant to scheduler
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Jones <ajones@ventanamicro.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8822=
=E6=97=A5=E5=91=A8=E4=B8=89 08:03=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Mar 22, 2023 at 02:18:56PM +0800, Song Shuai wrote:
> > RISC-V now manages CPU topology using arch_topology which provides
> > CPU capacity and frequency related interfaces to access the cpu/freq
> > invariant in possible heterogeneous or DVFS-enabled platforms.
> >
> > Here adds topology.h file to export the arch_topology interfaces for
> > replacing the scheduler's constant-based cpu/freq invariant accounting.
> >
> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > ---
> >  arch/riscv/include/asm/topology.h | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/topology.h
> >
> > diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm=
/topology.h
> > new file mode 100644
> > index 000000000000..14bbd2472af6
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/topology.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __ASM_RISCV_TOPOLOGY_H
> > +#define __ASM_RISCV_TOPOLOGY_H
>
> riscv uses a single leading underscore.
ok.
>
> > +
> > +#include <linux/arch_topology.h>
> > +
> > +/* Replace task scheduler's default frequency-invariant accounting */
> > +#define arch_scale_freq_tick topology_scale_freq_tick
> > +#define arch_set_freq_scale topology_set_freq_scale
> > +#define arch_scale_freq_capacity topology_get_freq_scale
> > +#define arch_scale_freq_invariant topology_scale_freq_invariant
> > +
> > +/* Replace task scheduler's default cpu-invariant accounting */
> > +#define arch_scale_cpu_capacity topology_get_cpu_scale
> > +#define arch_update_cpu_topology topology_update_cpu_topology
> > +
> > +
> > +#include <asm-generic/topology.h>
> > +#endif /* __ASM_RISCV_TOPOLOGY_H */
> > --
> > 2.20.1
> >
>
> This looks reasonable, at least from a "do what arm64 does" type of
> perspective. Why the RFC? Is it not tested?
I only tested it in the qemu sifive_u machine with a customed dtb
not sure if it works in real hardware, so I posted it with RFC.
>
> Also, if you repost, could please neaten it up a bit? Aligning all
> the defines would help and removing the extra blank line. Finally,
> why wasn't the "/* Enable topology flag updates */" comment also
> lifted from arm64 like the others?
I'll add the comment back and tidy it up in the next post.
>
> Thanks,
> drew



--=20
Thanks,
Song
