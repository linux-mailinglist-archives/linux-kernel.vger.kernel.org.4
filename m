Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E03744970
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 15:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjGANpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 09:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGANpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 09:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A8A3C00;
        Sat,  1 Jul 2023 06:45:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A56BF60B73;
        Sat,  1 Jul 2023 13:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE6FC43395;
        Sat,  1 Jul 2023 13:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688219114;
        bh=9d3MqgbfoEXm4e71z+ezPjR3vvvbKSQpSCaz34l0gmo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GrK12kGDrW4ojIHD5Ds6BzTLxi8rUibopincB3Vi+bjft6prxulfH8bO+BQlmEfiP
         nvfMk5L+tjQujVSrgn+IOjWpMUGGnyxIDFZ/vZf8mGaDXwSc/O7Ww4m1oLgZNu56AX
         StF6uJfC2l6D6VLJz9g0a3efEcrBIhJDbZHA1DXsYMKQROgkFPS1x/u8ZH2EUj22J1
         5H4y9Y6er+zwd6rnSvMlEcbPFpfOw7YYC0vrU4bVOQWNs4cqosrWc1T0tn+1Te0ho8
         pyoqV66iV84f0XEjTDh7AE3rMZr0jPVw32xK8yclVUq4H/RkdHaBg5hePLxBCSUO+z
         v2RCvCd/vQckA==
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so28917155e9.2;
        Sat, 01 Jul 2023 06:45:13 -0700 (PDT)
X-Gm-Message-State: AC+VfDwI3/NylOv4rXcQ8RhZh5aoBTu260TAO7XhZXBxPYZb63aVvnf4
        1kavMPkGX2+bhCgRArHZGtOXuyc+RLBYbhUyS6E=
X-Google-Smtp-Source: ACHHUZ5jZ82bm0qs/ibxPu0bevyKpfVXZ3uXr+bClu/6I2hRHm6zTWY5Kvnn2GemGtWi06F74RvrdWqbX20KWztL/ak=
X-Received: by 2002:a05:600c:20a:b0:3fb:9b7e:c5b1 with SMTP id
 10-20020a05600c020a00b003fb9b7ec5b1mr4265426wmi.19.1688219112057; Sat, 01 Jul
 2023 06:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230701171138.1491206-1-chenjiahao16@huawei.com>
In-Reply-To: <20230701171138.1491206-1-chenjiahao16@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 1 Jul 2023 21:45:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSPaBvB_CsmN5m91AVXwXB37j2qvyCP3VqALxHwNcGeTg@mail.gmail.com>
Message-ID: <CAJF2gTSPaBvB_CsmN5m91AVXwXB37j2qvyCP3VqALxHwNcGeTg@mail.gmail.com>
Subject: Re: [PATCH -next v6 0/2] support allocating crashkernel above 4G
 explicitly on riscv
To:     Chen Jiahao <chenjiahao16@huawei.com>
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

On Sat, Jul 1, 2023 at 5:12=E2=80=AFPM Chen Jiahao <chenjiahao16@huawei.com=
> wrote:
>
> On riscv, the current crash kernel allocation logic is trying to
> allocate within 32bit addressible memory region by default, if
> failed, try to allocate without 4G restriction.
>
> In need of saving DMA zone memory while allocating a relatively large
> crash kernel region, allocating the reserved memory top down in
> high memory, without overlapping the DMA zone, is a mature solution.
> Hence this patchset introduces the parameter option crashkernel=3DX,[high=
,low].
>
> One can reserve the crash kernel from high memory above DMA zone range
> by explicitly passing "crashkernel=3DX,high"; or reserve a memory range
> below 4G with "crashkernel=3DX,low". Besides, there are few rules need
> to take notice:
> 1. "crashkernel=3DX,[high,low]" will be ignored if "crashkernel=3Dsize"
>    is specified.
> 2. "crashkernel=3DX,low" is valid only when "crashkernel=3DX,high" is pas=
sed
>    and there is enough memory to be allocated under 4G.
> 3. When allocating crashkernel above 4G and no "crashkernel=3DX,low" is
>    specified, a 128M low memory will be allocated automatically for
>    swiotlb bounce buffer.
> See Documentation/admin-guide/kernel-parameters.txt for more information.
>
> To verify loading the crashkernel, adapted kexec-tools is attached below:
> https://github.com/chenjh005/kexec-tools/tree/build-test-riscv-v2
>
> Following test cases have been performed as expected:
> 1) crashkernel=3D256M                          //low=3D256M
> 2) crashkernel=3D1G                            //low=3D1G
Have you tried 1GB memory? we found a pud mapping problem on Sv39 of kexec,=
 See:
https://lore.kernel.org/linux-riscv/20230629082032.3481237-1-guoren@kernel.=
org/

> 3) crashkernel=3D4G                            //high=3D4G, low=3D128M(de=
fault)
> 4) crashkernel=3D4G crashkernel=3D256M,high      //high=3D4G, low=3D128M(=
default), high is ignored
> 5) crashkernel=3D4G crashkernel=3D256M,low       //high=3D4G, low=3D128M(=
default), low is ignored
> 6) crashkernel=3D4G,high                       //high=3D4G, low=3D128M(de=
fault)
> 7) crashkernel=3D256M,low                      //low=3D0M, invalid
> 8) crashkernel=3D4G,high crashkernel=3D256M,low  //high=3D4G, low=3D256M
> 9) crashkernel=3D4G,high crashkernel=3D4G,low    //high=3D0M, low=3D0M, i=
nvalid
> 10) crashkernel=3D512M@0xd0000000              //low=3D512M
>
> Changes since [v6]:
> 1. Introduce the "high" flag to mark whether "crashkernel=3DX,high"
>    is passed. Fix the retrying logic between "crashkernel=3DX,high"
>    case and others when the first allocation attempt fails.
>
> Changes since [v5]:
> 1. Update the crashkernel allocation logic when crashkernel=3DX,high
>    is specified. In this case, region above 4G will directly get
>    reserved as crashkernel, rather than trying lower 32bit allocation
>    first.
>
> Changes since [v4]:
> 1. Update some imprecise code comments for cmdline parsing.
>
> Changes since [v3]:
> 1. Update to print warning and return explicitly on failure when
>    crashkernel=3Dsize@offset is specified. Not changing the result
>    in this case but making the logic more straightforward.
> 2. Some minor cleanup.
>
> Changes since [v2]:
> 1. Update the allocation logic to ensure the high crashkernel
>    region is reserved strictly above dma32_phys_limit.
> 2. Clean up some minor format problems.
>
> Chen Jiahao (2):
>   riscv: kdump: Implement crashkernel=3DX,[high,low]
>   docs: kdump: Update the crashkernel description for riscv
>
>  .../admin-guide/kernel-parameters.txt         | 15 ++--
>  arch/riscv/kernel/setup.c                     |  5 ++
>  arch/riscv/mm/init.c                          | 84 +++++++++++++++++--
>  3 files changed, 90 insertions(+), 14 deletions(-)
>
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren
