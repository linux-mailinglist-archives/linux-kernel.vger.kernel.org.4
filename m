Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73546B9128
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjCNLKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjCNLJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:09:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27B569209
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:09:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2E0AB811F5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856A3C43444
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678792136;
        bh=OA6KR2crzzzR9Ukx7n2CH23lqKjV+m4N692TlNZxihc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lpcFJONiPnzvetcJup+PpheaviAfR+fwRf2AXvXeg9m1IJmIreSsT6M3tDiONV7uI
         bxOo4y0bNpqN6H56oPrWAiLIS07cnLFwIKNMCQ65e3qi38S7qEGfH+S2f+gswXG9zo
         GDxL3sdve00xCVwMuC5e1+A3t+yQaKgwTOApHESKvNXSr9+0nKGXlXaLdeDo/ZjbN4
         JCOQj8jk+iJA8iI4m6qLXAIQ3o0FF4RC+IIhxqb6e2k3Jaq6SUY5hCxusBsalyNqQG
         Rcz420vhDSSBReQPOoaOKvKnSoKYMwYbR2eSierwXa4oVPmVtOnuNHAAuZa39mBhc4
         Z2Uoe0CE++CWg==
Received: by mail-ed1-f54.google.com with SMTP id h8so16582550ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:08:56 -0700 (PDT)
X-Gm-Message-State: AO0yUKUFF5IZv0FDc9U4zCLMAX/1LpU/+EO+VyqLT3eklofEh2IVRoH3
        ZUGS7+b8QJPMabAexJzcRKL0mHl9wET9gm5WAGI=
X-Google-Smtp-Source: AK7set+2Yx/9604mwX187ROYtJW0as0er0LBAbwEa+eOI1tHp2PW1Kup/ysGLIb+GaaHOQaCAfjJKThiHyLqI6OHUi8=
X-Received: by 2002:a50:99d6:0:b0:4fc:f0b8:7da0 with SMTP id
 n22-20020a5099d6000000b004fcf0b87da0mr2969704edb.1.1678792134759; Tue, 14 Mar
 2023 04:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230314085433.4078119-1-chenhuacai@loongson.cn>
 <21f5aba50b7732b48d2610a5015186adf6bdfb38.camel@xry111.site>
 <CAAhV-H4TpQuq9sE2H=zbO8cvwn3Aer_pu1a-DU9L9OSR1bQX=g@mail.gmail.com> <939c8d17-6166-0c9b-6c58-6d49fd89841f@xen0n.name>
In-Reply-To: <939c8d17-6166-0c9b-6c58-6d49fd89841f@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 14 Mar 2023 19:08:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H67z6QJO6L=Z6O=2Ywmt01iWSSa66E3xNKCAa3UPRxs9g@mail.gmail.com>
Message-ID: <CAAhV-H67z6QJO6L=Z6O=2Ywmt01iWSSa66E3xNKCAa3UPRxs9g@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Make WriteCombine configurable for ioremap()
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@loongson.cn>,
        loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
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

On Tue, Mar 14, 2023 at 6:12=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> On 2023/3/14 18:02, Huacai Chen wrote:
> > Hi, Ruoyao,
> >
> > On Tue, Mar 14, 2023 at 5:41=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> =
wrote:
> >>
> >> On Tue, 2023-03-14 at 16:54 +0800, Huacai Chen wrote:
> >>> LoongArch maintains cache coherency in hardware, but when works with
> >>> LS7A chipsets the WUC attribute (Weak-ordered UnCached, which is simi=
lar
> >>> to WriteCombine) is out of the scope of cache coherency machanism for
> >>> PCIe devices (this is a PCIe protocol violation, may be fixed in newe=
r
> >>> chipsets).
> >>
> >> IIUC all launched LS7A models (7A1000 and 7A2000) suffers this issue?
> > Yes, very unfortunately, but this issue is only observed in the amdgpu
> > driver now.
>
> It's PCIe protocol violation after all, and we can never be sure about
> the vast amount of hardware untested on loongarch after all. Miserable
> as the performance hit may get, we don't really have another choice,
> unfortunately. Someone needs to lecture the LS7A team real hard!
>
> >>
> >>> This means WUC can only used for write-only memory regions now, so th=
is
> >>> option is disabled by default (means WUC falls back to SUC for iorema=
p).
> >>> You can enable this option if the kernel is ensured to run on bug-fre=
e
> >>> hardwares.
> >>
> >> Hmm, is it possible to make a PCI quirk so SUC/WUC will be decided
> >> automatically from the vendor:device ID of the PCI root controller?
> >> Then we don't need to rely on the user or distro maintainer to select =
an
> >> option.  I see there is already many architecture-dependant #if
> >> directives in drivers/pci/quirks.c so I guess such a quirk is acceptab=
le
> >> in PCI tree...
> > Not a good idea, pci quirks need too long a time to review, and we
> > don't know when this issue can be fixed in hardware.
> >
> >>
> >> If a PCI quirk is not possible, then is it possible to make a kernel
> >> command line option, leaving this CONFIG as the default value of the
> >> option?  I guess in the future many LoongArch users will just install =
a
> >> binary distro, then it would be much easier to edit grub.cfg than
> >> rebuilding the kernel when they finally buy a compliant PCIe controlle=
r.
> > If we use command line parameter, we can remove this Kconfig option.
>
> An option is still useful as specifying the compile-time default for
> such a kernel parameter, IMO.
I will update commit messages and add a kernel parameter, thanks.

Huacai
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
>
