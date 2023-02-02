Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28D56875A6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 07:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjBBGHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 01:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBBGHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 01:07:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A924DE0C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 22:07:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8ABE61783
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 06:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152E2C433A1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 06:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675318021;
        bh=yiRBHv+l/4auQ24x9qnvybomygiIEXgSlWdHdZ3lxoM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PMDieNdvA/P2JLoNdwh4yqwRP38jvQEYJpamLZkZLixyc5hYQkN5j7rnHZyMPYCJB
         xzM6HPr2rxk+0Wf1QyQNg0dwV8IDXFV4QqVIdJcLzd5M4LFCHSTsH7rOpfY6R0Ijfr
         UjIOuxWlAVc0Mj5np2zcgrk79o0WJ+REswOASMb+3PXBdFabttafCQNP3pYcA5NypC
         aJJBlTdailL8kMNp7HLz2otgwEk5pzlA2943yU95tO0s72CmEKvWSbWccbkw6IkEmM
         Zu5g0NIGbLfP5+p7mO66mNusJxyI8xosfvLUWftUXzgoBcUWDckEDEitQ+LREb8NEy
         L5rclAAZQHp4A==
Received: by mail-ej1-f49.google.com with SMTP id me3so2974214ejb.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 22:07:00 -0800 (PST)
X-Gm-Message-State: AO0yUKXTRqQ55pxJR+B4khHsi8w9KlSYniQFvzfUyZhnNHPFAY7Eed5v
        8TszZoP9KIZ22Tr4+Viz0wL1cTLY8G5KkPYX8Jk=
X-Google-Smtp-Source: AK7set933sMPvVA4x1tga0jepXMF7Xtm4wVnvu+W88FO6CBdjG4X+kDRvXeX9j8pKDBHRVhXilNxTFKqFa/DonGr0LI=
X-Received: by 2002:a17:906:2a51:b0:88c:b87d:b771 with SMTP id
 k17-20020a1709062a5100b0088cb87db771mr1495268eje.195.1675318019271; Wed, 01
 Feb 2023 22:06:59 -0800 (PST)
MIME-Version: 1.0
References: <20230126130509.1418251-1-guoren@kernel.org> <878rhig9zj.fsf@all.your.base.are.belong.to.us>
 <CAJF2gTQHDmT=XWE=j8+5Y5ogKh4qNMpXCwAa+7wXEkBit0ujXw@mail.gmail.com> <87357pravt.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87357pravt.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 2 Feb 2023 14:06:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTn52FWRU9-ZqDLpTUe0BkLgttP3NOyk-PzxJbbX75cPg@mail.gmail.com>
Message-ID: <CAJF2gTTn52FWRU9-ZqDLpTUe0BkLgttP3NOyk-PzxJbbX75cPg@mail.gmail.com>
Subject: Re: [PATCH] riscv: kprobe: Fixup kernel panic when probing an illegal position
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, liaochang <liaochang1@huawei.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 1, 2023 at 5:30 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wro=
te:
>
> Guo Ren <guoren@kernel.org> writes:
>
> >> > +     if (!arch_check_kprobe(p))
> >> > +             return -EILSEQ;
> >> > +
> >> >       /* copy instruction */
> >> >       p->opcode =3D *p->addr;
> >>
> >> Not related to your patch, but this can also trigger a misaligned load=
.
> > After rereading the spec, misaligned load/store is not mandatory
> > supported. (Although my machines and qemu are correct)
>
> Yes. It would be great if it could be turned on by QEMU (you can with
> Spike).
>
> > So I need fixup:
> >
> > diff --git a/arch/riscv/kernel/probes/kprobes.c
> > b/arch/riscv/kernel/probes/kprobes.c
> > index 27f8960c321c..0c016d496746 100644
> > --- a/arch/riscv/kernel/probes/kprobes.c
> > +++ b/arch/riscv/kernel/probes/kprobes.c
> > @@ -58,12 +58,14 @@ static bool __kprobes arch_check_kprobe(struct kpro=
be *p)
> >  {
> >         unsigned long tmp  =3D (unsigned long)p->addr - p->offset;
> >         unsigned long addr =3D (unsigned long)p->addr;
> > +       kprobe_opcode_t opcode;
> >
> >         while (tmp <=3D addr) {
> >                 if (tmp =3D=3D addr)
> >                         return true;
> >
> > -               tmp +=3D GET_INSN_LENGTH(*(kprobe_opcode_t *)tmp);
> > +               memcpy(&opcode, (void *)tmp, sizeof(kprobe_opcode_t));
> > +               tmp +=3D GET_INSN_LENGTH(opcode);
>
> I'd prefer sizeof(opcode).
prefer sizeof(opcode) =3D 4

GET_INSN_LENGTH(opcode) returns 2 or 4;


>
> >         }
> >
> >         return false;
> > @@ -80,7 +82,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
> >                 return -EILSEQ;
> >
> >         /* copy instruction */
> > -       p->opcode =3D *p->addr;
> > +       memcpy(&p->opcode, p->addr, sizeof(kprobe_opcode_t));
>
> Same comment as above, and this would ideally be a separate patch.
Yes

>
>
> Bj=C3=B6rn



--=20
Best Regards
 Guo Ren
