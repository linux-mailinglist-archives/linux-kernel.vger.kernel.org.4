Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5607F71F923
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 06:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjFBEL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 00:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjFBELW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 00:11:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C66F1A8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 21:11:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A9C264BF2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BB0C433D2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685679076;
        bh=3KKLfYltpP6AwUyqbOu8VcjvJJYpCcqO2cG0S3xy7yY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SlgfWgAV56JNVTapto/Na8Mc+XcKejx1vSpANP4iPldr0tkLvxf4I2sw++NHqWQA0
         1RcAIcaWGhlQ7doPh7cKjFTf2JSn3t8l0guMOIMzFDBTca19+EskTkljcnU52ufIFS
         DOuRIRo4hLOkQNkK9T75avolm+MAHsdtTXhvJShIndPniFwFg0AhhhNu9M2YVKzkRp
         oiiTLdcGEAz7JrwpBmposMoJRoNwqIGj9JAr02SH3GeP9+ayfYS2LgKvcAGJACl/fD
         TBp1sGWWiM18mp01d1He2EhbgqpUspTUzSI8Wbbfi00EWzR62kpXkQ09pZVZB4n2XR
         MyAGZK7XLYXPQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5147a478c38so2365058a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 21:11:16 -0700 (PDT)
X-Gm-Message-State: AC+VfDyqBrDqNxNz3n08d1Zicf3skJzmimxwQ66MBh4HHVDecg4IF0lF
        o6seC9m+N2aOdinse7Dsm4p4JPDhYdath2HGXdw=
X-Google-Smtp-Source: ACHHUZ7wzUjaEOG8TGfvCZPI1uTO6uVQKWRMfgbYjNvATi5pmMOSmaY7k+ICTvTurUJBNlapQ4gKt607Nzt+ytsCSJ4=
X-Received: by 2002:a17:907:94cb:b0:96f:f451:187f with SMTP id
 dn11-20020a17090794cb00b0096ff451187fmr8505251ejc.7.1685679075072; Thu, 01
 Jun 2023 21:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230602030732.1047696-1-maobibo@loongson.cn>
In-Reply-To: <20230602030732.1047696-1-maobibo@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 2 Jun 2023 12:11:02 +0800
X-Gmail-Original-Message-ID: <CAAhV-H58dR4JWtCdqCR553H1-pbppKyi114BMhsrV74Zb_c58Q@mail.gmail.com>
Message-ID: <CAAhV-H58dR4JWtCdqCR553H1-pbppKyi114BMhsrV74Zb_c58Q@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Align pci memory base address with page size
To:     Bibo Mao <maobibo@loongson.cn>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jianmin Lv <lvjianmin@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc Bjorn

Hi, Bibo,

On Fri, Jun 2, 2023 at 11:07=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> LoongArch linux kernel uses 16K page size by default, some pci devices ha=
ve
> only 4K memory size, it is normal in general architectures. However memor=
y
> space of different pci devices will share one physical page address space=
.
> This is not safe for mmu protection, also UIO and VFIO requires base
> address of pci memory space page aligned.
>
> This patch adds check with function pcibios_align_resource, and set base
> address of resource page aligned.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/pci/pci.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/loongarch/pci/pci.c b/arch/loongarch/pci/pci.c
> index 2726639150bc..1380f3672ba2 100644
> --- a/arch/loongarch/pci/pci.c
> +++ b/arch/loongarch/pci/pci.c
> @@ -83,6 +83,29 @@ int pcibios_alloc_irq(struct pci_dev *dev)
>         return acpi_pci_irq_enable(dev);
>  }
>
> +/*
> + * memory space size of some pci cards is 4K, it is separated with
> + * different pages for generic architectures, so that mmu protection can
> + * work with different pci cards. However page size for LoongArch system
> + * is 16K, memory space of different pci cards may share the same page
> + * on LoongArch, it is not safe here.
> + * Also uio drivers and vfio drivers sugguests that base address of memo=
ry
> + * space should page aligned. This function aligns base address with pag=
e size
> + */
> +resource_size_t pcibios_align_resource(void *data, const struct resource=
 *res,
> +               resource_size_t size, resource_size_t align)
> +{
> +       resource_size_t start =3D res->start;
> +
> +       if (res->flags & IORESOURCE_MEM) {
> +               if (align & (PAGE_SIZE - 1)) {
> +                       align =3D PAGE_SIZE;
> +                       start =3D ALIGN(start, align);
I don't know whether this patch is really needed, but the logic here
has some problems.

For example, if PAGE_SIZE=3D16KB, align=3D18KB, what should we do? Align
to 16KB or align to 32KB? IMO it should align to 32KB, but in your
patch it will align to 16KB.

Huacai
> +               }
> +       }
> +       return start;
> +}
> +
>  static void pci_fixup_vgadev(struct pci_dev *pdev)
>  {
>         struct pci_dev *devp =3D NULL;
> --
> 2.27.0
>
