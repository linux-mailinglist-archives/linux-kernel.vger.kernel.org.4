Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BBD7467A4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 04:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjGDCjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 22:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGDCjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 22:39:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39C3196;
        Mon,  3 Jul 2023 19:39:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8933161121;
        Tue,  4 Jul 2023 02:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC85EC433C8;
        Tue,  4 Jul 2023 02:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688438380;
        bh=tXZp+ReqzLA3RemNoEBo2LjLWj/e/XELTtoc5i/BBic=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R2EeYhz6t0R+bVU1qrbDTq/R3OYi5EPzXEM/loAnBrwmzojywsmNdLCZvvR9TlQ/e
         GUaxFkqwhLTMr4sTJ9BcwP0Vfo2z/JnghXvpheQf4upJMJVEqJNUEd16FKaghhoxK2
         ccVQEtzcm2C9S9hNPV7lNeXbJJGQoLKNX+pM2TDw32b8gTKgMEwB6u1oYcYj6lUDd6
         EbMWoz+xQmoz5IkMRMwgfP6PuarxSIhvsym7c2XnD3lXy2T0/dyWAcSTW1f5BgHPYt
         Kt5EB6nO3maJTOD9NSVCQY5hmpZfDykpFNcZ9/HK48r8Ve4KssIPubgSNOz/5uuIQR
         +xPMoZJ0WZPAg==
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso43712175e9.0;
        Mon, 03 Jul 2023 19:39:39 -0700 (PDT)
X-Gm-Message-State: AC+VfDzCFU9nhfz9JYa48p0VfInhJ2UO6Y0r7ObLticmnFWxsipY7JVK
        lheN6PIspzuubPB7mqhF1yoPnCDtgPPNztDVt28=
X-Google-Smtp-Source: ACHHUZ7Sgf2kFqoO4n7yD8cxYDyMwazc0GyX/ssIDgmJNp6qshBxWDrkQ8kh6xbzdlEVHkpMho95UtHTksFMkene+rk=
X-Received: by 2002:a05:600c:ad4:b0:3fb:a506:5626 with SMTP id
 c20-20020a05600c0ad400b003fba5065626mr10492684wmr.1.1688438378265; Mon, 03
 Jul 2023 19:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230701171138.1491206-1-chenjiahao16@huawei.com>
 <CAJF2gTSPaBvB_CsmN5m91AVXwXB37j2qvyCP3VqALxHwNcGeTg@mail.gmail.com> <b338a366-2cc3-870e-aee6-d55999ab14b5@huawei.com>
In-Reply-To: <b338a366-2cc3-870e-aee6-d55999ab14b5@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 4 Jul 2023 10:39:26 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRu8EQR-E1C4_gAj9JFDh2hd3WpprzVssGf+KzTZc5qOw@mail.gmail.com>
Message-ID: <CAJF2gTRu8EQR-E1C4_gAj9JFDh2hd3WpprzVssGf+KzTZc5qOw@mail.gmail.com>
Subject: Re: [PATCH -next v6 0/2] support allocating crashkernel above 4G
 explicitly on riscv
To:     "chenjiahao (C)" <chenjiahao16@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, bjorn@rivosinc.com,
        alex@ghiti.fr, akpm@linux-foundation.org, atishp@rivosinc.com,
        bhe@redhat.com, thunder.leizhen@huawei.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 9:07=E2=80=AFPM chenjiahao (C) <chenjiahao16@huawei.=
com> wrote:
>
>
> On 2023/7/1 21:45, Guo Ren wrote:
> > On Sat, Jul 1, 2023 at 5:12=E2=80=AFPM Chen Jiahao <chenjiahao16@huawei=
.com> wrote:
> >> On riscv, the current crash kernel allocation logic is trying to
> >> allocate within 32bit addressible memory region by default, if
> >> failed, try to allocate without 4G restriction.
> >>
> >> In need of saving DMA zone memory while allocating a relatively large
> >> crash kernel region, allocating the reserved memory top down in
> >> high memory, without overlapping the DMA zone, is a mature solution.
> >> Hence this patchset introduces the parameter option crashkernel=3DX,[h=
igh,low].
> >>
> >> One can reserve the crash kernel from high memory above DMA zone range
> >> by explicitly passing "crashkernel=3DX,high"; or reserve a memory rang=
e
> >> below 4G with "crashkernel=3DX,low". Besides, there are few rules need
> >> to take notice:
> >> 1. "crashkernel=3DX,[high,low]" will be ignored if "crashkernel=3Dsize=
"
> >>     is specified.
> >> 2. "crashkernel=3DX,low" is valid only when "crashkernel=3DX,high" is =
passed
> >>     and there is enough memory to be allocated under 4G.
> >> 3. When allocating crashkernel above 4G and no "crashkernel=3DX,low" i=
s
> >>     specified, a 128M low memory will be allocated automatically for
> >>     swiotlb bounce buffer.
> >> See Documentation/admin-guide/kernel-parameters.txt for more informati=
on.
> >>
> >> To verify loading the crashkernel, adapted kexec-tools is attached bel=
ow:
> >> https://github.com/chenjh005/kexec-tools/tree/build-test-riscv-v2
> >>
> >> Following test cases have been performed as expected:
> >> 1) crashkernel=3D256M                          //low=3D256M
> >> 2) crashkernel=3D1G                            //low=3D1G
> > Have you tried 1GB memory? we found a pud mapping problem on Sv39 of ke=
xec, See:
> > https://lore.kernel.org/linux-riscv/20230629082032.3481237-1-guoren@ker=
nel.org/
>
> I have tested on QEMU with sv57 mmu, so it seems the synchronization prob=
lem
> was not reproduce when reserving 1G memory and loading the capture kernel=
.
Yes, the pud of sv57 is not the pgd entries, so you didn't get problem.

>
>
> Thanks,
> Jiahao
>
> >
> >> 3) crashkernel=3D4G                            //high=3D4G, low=3D128M=
(default)
> >> 4) crashkernel=3D4G crashkernel=3D256M,high      //high=3D4G, low=3D12=
8M(default), high is ignored
> >> 5) crashkernel=3D4G crashkernel=3D256M,low       //high=3D4G, low=3D12=
8M(default), low is ignored
> >> 6) crashkernel=3D4G,high                       //high=3D4G, low=3D128M=
(default)
> >> 7) crashkernel=3D256M,low                      //low=3D0M, invalid
> >> 8) crashkernel=3D4G,high crashkernel=3D256M,low  //high=3D4G, low=3D25=
6M
> >> 9) crashkernel=3D4G,high crashkernel=3D4G,low    //high=3D0M, low=3D0M=
, invalid
> >> 10) crashkernel=3D512M@0xd0000000              //low=3D512M
> >>
> >> Changes since [v6]:
> >> 1. Introduce the "high" flag to mark whether "crashkernel=3DX,high"
> >>     is passed. Fix the retrying logic between "crashkernel=3DX,high"
> >>     case and others when the first allocation attempt fails.
> >>
> >> Changes since [v5]:
> >> 1. Update the crashkernel allocation logic when crashkernel=3DX,high
> >>     is specified. In this case, region above 4G will directly get
> >>     reserved as crashkernel, rather than trying lower 32bit allocation
> >>     first.
> >>
> >> Changes since [v4]:
> >> 1. Update some imprecise code comments for cmdline parsing.
> >>
> >> Changes since [v3]:
> >> 1. Update to print warning and return explicitly on failure when
> >>     crashkernel=3Dsize@offset is specified. Not changing the result
> >>     in this case but making the logic more straightforward.
> >> 2. Some minor cleanup.
> >>
> >> Changes since [v2]:
> >> 1. Update the allocation logic to ensure the high crashkernel
> >>     region is reserved strictly above dma32_phys_limit.
> >> 2. Clean up some minor format problems.
> >>
> >> Chen Jiahao (2):
> >>    riscv: kdump: Implement crashkernel=3DX,[high,low]
> >>    docs: kdump: Update the crashkernel description for riscv
> >>
> >>   .../admin-guide/kernel-parameters.txt         | 15 ++--
> >>   arch/riscv/kernel/setup.c                     |  5 ++
> >>   arch/riscv/mm/init.c                          | 84 +++++++++++++++++=
--
> >>   3 files changed, 90 insertions(+), 14 deletions(-)
> >>
> >> --
> >> 2.34.1
> >>
> >



--=20
Best Regards
 Guo Ren
