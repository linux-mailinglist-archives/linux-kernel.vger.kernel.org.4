Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCC471FB7A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjFBIBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjFBIBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:01:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FB1A3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:01:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 673216466E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF8FC433A1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685692867;
        bh=g9o7Q3+qu3TNO+oYRpWCOL8HyzqTrELhpP5873uRd3Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fIx6/4LHQG+owHhDhXY9/WQld6+BM6nYUxDsotzvwnXvb3XE+INXK1gU/X6Ur2xWE
         Xj5Yd+L9k5tux8Ie55/Ensh/n0W90+i27Uw+PYsvJdb+zuiES9IKBViof0OVfJtqc8
         uivIy03pbppOwTFfwuiSRz/W2Fo6szMCqqt4wFGR83kFyzWyBiygjRzwx8UcBPgMIC
         V8FM4cR6y0Ag6cfG6FiZigclLKn9JNCGpGjpFHoNTgqr4zVLz7HLCg4DkWpVTGH63P
         p71m3HQ19UrLP4WNof72ZdMttdXGqxFxDoyETLjNhBK62aQP3SG7I0aOjo4byBDbmE
         dweSld3uB+toA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5147dce372eso2669816a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 01:01:07 -0700 (PDT)
X-Gm-Message-State: AC+VfDy48pV8rYb0Oq9lEu3ygfnTgTDr8ni5bqx3nBg5cqU8HG/i5gxT
        9CrOqMl6u8rM2nKe1ttg9sgpfCpRpasOPgGZIeQ=
X-Google-Smtp-Source: ACHHUZ5huCZPcpNVr9McO23JvVRywJTG/caMrkpDTQMHjXfG/M+enxYRpgAmmluiCgnaZywlNYJgyt4PzOr/x/kmQ5s=
X-Received: by 2002:aa7:d281:0:b0:504:9346:11d3 with SMTP id
 w1-20020aa7d281000000b00504934611d3mr1415324edq.29.1685692865422; Fri, 02 Jun
 2023 01:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230602030732.1047696-1-maobibo@loongson.cn> <CAAhV-H58dR4JWtCdqCR553H1-pbppKyi114BMhsrV74Zb_c58Q@mail.gmail.com>
 <17a2ba54-2b85-9cc9-2a43-16eb20d6ce84@loongson.cn> <CAAhV-H4VHoNQdpDdpcPfDXJxnpoWUtDqmJMhb_r4DS4JtnxvhQ@mail.gmail.com>
 <e483b7bb-4184-758d-2840-11d75659975e@loongson.cn>
In-Reply-To: <e483b7bb-4184-758d-2840-11d75659975e@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 2 Jun 2023 16:00:53 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4VH2yZ3sMqQYK_KWrv6FT7fqHykuMMFo_B55WJeRQOwA@mail.gmail.com>
Message-ID: <CAAhV-H4VH2yZ3sMqQYK_KWrv6FT7fqHykuMMFo_B55WJeRQOwA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Align pci memory base address with page size
To:     "bibo, mao" <maobibo@loongson.cn>
Cc:     loongson-kernel@lists.loongnix.cn,
        Bjorn Helgaas <helgaas@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jianmin Lv <lvjianmin@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 3:35=E2=80=AFPM bibo, mao <maobibo@loongson.cn> wrot=
e:
>
>
>
> =E5=9C=A8 2023/6/2 14:55, Huacai Chen =E5=86=99=E9=81=93:
> > On Fri, Jun 2, 2023 at 2:48=E2=80=AFPM bibo, mao <maobibo@loongson.cn> =
wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2023/6/2 12:11, Huacai Chen =E5=86=99=E9=81=93:
> >>> +cc Bjorn
> >>>
> >>> Hi, Bibo,
> >>>
> >>> On Fri, Jun 2, 2023 at 11:07=E2=80=AFAM Bibo Mao <maobibo@loongson.cn=
> wrote:
> >>>>
> >>>> LoongArch linux kernel uses 16K page size by default, some pci devic=
es have
> >>>> only 4K memory size, it is normal in general architectures. However =
memory
> >>>> space of different pci devices will share one physical page address =
space.
> >>>> This is not safe for mmu protection, also UIO and VFIO requires base
> >>>> address of pci memory space page aligned.
> >>>>
> >>>> This patch adds check with function pcibios_align_resource, and set =
base
> >>>> address of resource page aligned.
> >>>>
> >>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> >>>> ---
> >>>>  arch/loongarch/pci/pci.c | 23 +++++++++++++++++++++++
> >>>>  1 file changed, 23 insertions(+)
> >>>>
> >>>> diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
> >>>> index 2726639150bc..1380f3672ba2 100644
> >>>> --- a/arch/loongarch/pci/pci.c
> >>>> +++ b/arch/loongarch/pci/pci.c
> >>>> @@ -83,6 +83,29 @@ int pcibios_alloc_irq(struct pci_dev *dev)
> >>>>         return acpi_pci_irq_enable(dev);
> >>>>  }
> >>>>
> >>>> +/*
> >>>> + * memory space size of some pci cards is 4K, it is separated with
> >>>> + * different pages for generic architectures, so that mmu protectio=
n can
> >>>> + * work with different pci cards. However page size for LoongArch s=
ystem
> >>>> + * is 16K, memory space of different pci cards may share the same p=
age
> >>>> + * on LoongArch, it is not safe here.
> >>>> + * Also uio drivers and vfio drivers sugguests that base address of=
 memory
> >>>> + * space should page aligned. This function aligns base address wit=
h page size
> >>>> + */
> >>>> +resource_size_t pcibios_align_resource(void *data, const struct res=
ource *res,
> >>>> +               resource_size_t size, resource_size_t align)
> >>>> +{
> >>>> +       resource_size_t start =3D res->start;
> >>>> +
> >>>> +       if (res->flags & IORESOURCE_MEM) {
> >>>> +               if (align & (PAGE_SIZE - 1)) {
> >>>> +                       align =3D PAGE_SIZE;
> >>>> +                       start =3D ALIGN(start, align);
> >>> I don't know whether this patch is really needed, but the logic here
> >>> has some problems.
> >>>
> >>> For example, if PAGE_SIZE=3D16KB, align=3D18KB, what should we do? Al=
ign
> >>> to 16KB or align to 32KB? IMO it should align to 32KB, but in your
> >>> patch it will align to 16KB.
> >> In general pci device is aligned by size, and its value is a power of =
2 in value.
> >> I do not see such devices with 18K alignment requirements.
> > If so, you can simply ignore "align" and use  start =3D ALIGN(start, PA=
GE_SIZE);
> >
> >>
> >> By pci local bus spec, there are such lines:
> >>
> >> "Devices are free to consume more address space than required, but dec=
oding down
> >> to a 4 KB space for memory is suggested for devices that need less tha=
n that amount. For
> >> instance, a device that has 64 bytes of registers to be mapped into Me=
mory Space may
> >> consume up to 4 KB of address space in order to minimize the number of=
 bits in the address
> >> decoder."
> >>
> >> I cannot  think whether it is necessary simply from judging whether ot=
her
> >> architectures have similar code. If so, LoongArch system just  always =
follows others.
> >> It is actually one problem since LoongArch uses 16K page size.
> > As I know, both MIPS and ARM64 can use non-4K pages, but when I grep
> > pcibios_align_resource in the arch directory, none of them do
> > PAGE_SIZE alignment.
> Here is piece of  code in drivers/vfio/pci/vfio_pci_core.c
>                 /*
>                  * Here we don't handle the case when the BAR is not page
>                  * aligned because we can't expect the BAR will be
>                  * assigned into the same location in a page in guest
>                  * when we passthrough the BAR. And it's hard to access
>                  * this BAR in userspace because we have no way to get
>                  * the BAR's location in a page.
>                  */
> no_mmap:
>                 vdev->bar_mmap_supported[bar] =3D false;
>
> Do you think it is a issue or not?
May be or may not be, if it should be aligned to PAGE_SIZE, then MIPS
and ARM64 also need this.

>
> You can search function pnv_pci_default_alignment or pcibios_align_resour=
ce about
> alpha architecture.
Alpha's pcibios_align_resource() have nothing to do with PAGE_SIZE,
pnv_pci_default_alignment() seems to be the case. But if alignment is
really needed, I think it is better to provide a
pcibios_default_alignment() as powerpc.

Huacai
>
> Regards
> Bibo, mao
>
> >
> > Huacai
> >
> >>
> >> Regards
> >> Bibo, Mao
> >>>
> >>> Huacai
> >>>> +               }
> >>>> +       }
> >>>> +       return start;
> >>>> +}
> >>>> +
> >>>>  static void pci_fixup_vgadev(struct pci_dev *pdev)
> >>>>  {
> >>>>         struct pci_dev *devp =3D NULL;
> >>>> --
> >>>> 2.27.0
> >>>>
> >>> _______________________________________________
> >>> Loongson-kernel mailing list -- loongson-kernel@lists.loongnix.cn
> >>> To unsubscribe send an email to loongson-kernel-leave@lists.loongnix.=
cn
> >>
> >>
> > _______________________________________________
> > Loongson-kernel mailing list -- loongson-kernel@lists.loongnix.cn
> > To unsubscribe send an email to loongson-kernel-leave@lists.loongnix.cn
>
>
