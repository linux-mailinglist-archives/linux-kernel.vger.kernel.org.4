Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929606DAA9B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjDGJGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjDGJGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:06:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A7D93F7;
        Fri,  7 Apr 2023 02:06:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26CEA64C43;
        Fri,  7 Apr 2023 09:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DE4C433A1;
        Fri,  7 Apr 2023 09:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680858397;
        bh=GjoE8pLLqpFNvPjjEJFxDwYnG+mHd4Kao3OLgsaszZ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pe8fduDAGwtUb48emhH2LknvX9rwm5w/ZvDWc4Angw8fPrY+b8SYEIn/Ay8npOsf3
         FhJhISx2Ge2kGRHIJJGHJ33+yF5kxwzhfXyoFdi/Dc5vAKRsbj1zTOBcPPoNHMiby1
         v0l3aonjlPi+BVhdClH2uo83ZYrH4IT+3NjQzUdCqm4U3rGF73u3rDHSyZ7lgnQhgA
         WRi4lsNP4a5E9hi8gwkaCzj1pFlpCcdHnVFJJofa9W8wDslRt2eiw4fmjbwE+FO5lW
         Z9W0r1L0mc+Xr8BGviZVR32Hwe3VHpkL7YmO4+Gr4Z0O4fY+CnNLpaLner1dDE/HPW
         OxEUsjzhG3S8w==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-949062abf62so210251566b.2;
        Fri, 07 Apr 2023 02:06:37 -0700 (PDT)
X-Gm-Message-State: AAQBX9fDKW183sdZUmt4LD7r3JU1mrsfWT8F7Y2BpLIUPQsij4tc12e7
        S6pkchV9mFY7a6N6ydeQtxjV+vTByES10ccqiLo=
X-Google-Smtp-Source: AKy350bC7P5dv/YCBCZVMCl54lx/K33Opg2CWjsPDhXq393aZeTC0CD/PitAaV4RIPLrrmj2H6B7XFFVTnteDzemW6E=
X-Received: by 2002:aa7:d856:0:b0:4fd:2533:f56 with SMTP id
 f22-20020aa7d856000000b004fd25330f56mr1759132eds.39.1680858395702; Fri, 07
 Apr 2023 02:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230406220206.3067006-1-chenjiahao16@huawei.com> <20230406220206.3067006-2-chenjiahao16@huawei.com>
In-Reply-To: <20230406220206.3067006-2-chenjiahao16@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 7 Apr 2023 17:06:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRtj=-XONv3cMZFd+qCtqUQqYZo5Lv7cgQbkGKTB0j7yg@mail.gmail.com>
Message-ID: <CAJF2gTRtj=-XONv3cMZFd+qCtqUQqYZo5Lv7cgQbkGKTB0j7yg@mail.gmail.com>
Subject: Re: [PATCH -next v3 1/2] riscv: kdump: Implement crashkernel=X,[high,low]
To:     Chen Jiahao <chenjiahao16@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, bjorn@rivosinc.com,
        alex@ghiti.fr, akpm@linux-foundation.org, atishp@rivosinc.com,
        bhe@redhat.com, thunder.leizhen@huawei.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 10:06=E2=80=AFPM Chen Jiahao <chenjiahao16@huawei.co=
m> wrote:
>
> On riscv, the current crash kernel allocation logic is trying to
> allocate within 32bit addressible memory region by default, if
> failed, try to allocate without 4G restriction.
>
> In need of saving DMA zone memory while allocating a relatively large
> crash kernel region, allocating the reserved memory top down in
> high memory, without overlapping the DMA zone, is a mature solution.
> Here introduce the parameter option crashkernel=3DX,[high,low].
>
> One can reserve the crash kernel from high memory above DMA zone range
> by explicitly passing "crashkernel=3DX,high"; or reserve a memory range
> below 4G with "crashkernel=3DX,low".
Asked-by: Guo Ren <guoren@kernel.org>

>
> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
> ---
>  arch/riscv/kernel/setup.c |  5 +++
>  arch/riscv/mm/init.c      | 74 ++++++++++++++++++++++++++++++++++++---
>  2 files changed, 74 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 5d3184cbf518..ea84e5047c23 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -176,6 +176,11 @@ static void __init init_resources(void)
>                 if (ret < 0)
>                         goto error;
>         }
> +       if (crashk_low_res.start !=3D crashk_low_res.end) {
> +               ret =3D add_resource(&iomem_resource, &crashk_low_res);
> +               if (ret < 0)
> +                       goto error;
> +       }
>  #endif
>
>  #ifdef CONFIG_CRASH_DUMP
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 478d6763a01a..b5b457193423 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1152,6 +1152,28 @@ static inline void setup_vm_final(void)
>  }
>  #endif /* CONFIG_MMU */
>
> +/* Reserve 128M low memory by default for swiotlb buffer */
> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE  (128UL << 20)
> +
> +static int __init reserve_crashkernel_low(unsigned long long low_size)
> +{
> +       unsigned long long low_base;
> +
> +       low_base =3D memblock_phys_alloc_range(low_size, PMD_SIZE, 0, dma=
32_phys_limit);
> +       if (!low_base) {
> +               pr_err("cannot allocate crashkernel low memory (size:0x%l=
lx).\n", low_size);
> +               return -ENOMEM;
> +       }
> +
> +       pr_info("crashkernel low memory reserved: 0x%016llx - 0x%016llx (=
%lld MB)\n",
> +               low_base, low_base + low_size, low_size >> 20);
> +
> +       crashk_low_res.start =3D low_base;
> +       crashk_low_res.end =3D low_base + low_size - 1;
> +
> +       return 0;
> +}
> +
>  /*
>   * reserve_crashkernel() - reserves memory for crash kernel
>   *
> @@ -1163,8 +1185,12 @@ static void __init reserve_crashkernel(void)
>  {
>         unsigned long long crash_base =3D 0;
>         unsigned long long crash_size =3D 0;
> +       unsigned long long crash_low_size =3D 0;
>         unsigned long search_start =3D memblock_start_of_DRAM();
>         unsigned long search_end =3D memblock_end_of_DRAM();
> +       unsigned long search_low_max =3D (unsigned long)dma32_phys_limit;
> +       char *cmdline =3D boot_command_line;
> +       bool fixed_base =3D false;
>
>         int ret =3D 0;
>
> @@ -1180,14 +1206,37 @@ static void __init reserve_crashkernel(void)
>                 return;
>         }
>
> -       ret =3D parse_crashkernel(boot_command_line, memblock_phys_mem_si=
ze(),
> +       ret =3D parse_crashkernel(cmdline, memblock_phys_mem_size(),
>                                 &crash_size, &crash_base);
> -       if (ret || !crash_size)
> +       if (ret =3D=3D -ENOENT) {
> +               /*
> +                * crashkernel=3DX,[high,low] can be specified or not, bu=
t
> +                * invalid value is not allowed.
> +                */
> +               ret =3D parse_crashkernel_high(cmdline, 0, &crash_size, &=
crash_base);
> +               if (ret || !crash_size)
> +                       return;
> +
> +               /*
> +                * crashkernel=3DY,low is valid only when crashkernel=3DX=
,high
> +                * is passed and high memory is reserved successful.
> +                */
> +               ret =3D parse_crashkernel_low(cmdline, 0, &crash_low_size=
, &crash_base);
> +               if (ret =3D=3D -ENOENT)
> +                       crash_low_size =3D DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +               else if (ret)
> +                       return;
> +
> +               search_start =3D search_low_max;
> +       } else if (ret || !crash_size) {
> +               /* Invalid argument value specified */
>                 return;
> +       }
>
>         crash_size =3D PAGE_ALIGN(crash_size);
>
>         if (crash_base) {
> +               fixed_base =3D true;
>                 search_start =3D crash_base;
>                 search_end =3D crash_base + crash_size;
>         }
> @@ -1201,16 +1250,31 @@ static void __init reserve_crashkernel(void)
>          */
>         crash_base =3D memblock_phys_alloc_range(crash_size, PMD_SIZE,
>                                                search_start,
> -                                              min(search_end, (unsigned =
long) SZ_4G));
> +                                              min(search_end, search_low=
_max));
>         if (crash_base =3D=3D 0) {
> -               /* Try again without restricting region to 32bit addressi=
ble memory */
> +               if (fixed_base) {
> +                       pr_warn("crashkernel: allocating failed with give=
n size@offset\n");
> +                       return;
> +               }
> +
> +               /* Try again above the region of 32bit addressible memory=
 */
>                 crash_base =3D memblock_phys_alloc_range(crash_size, PMD_=
SIZE,
> -                                               search_start, search_end)=
;
> +                                                      max(search_start, =
search_low_max),
> +                                                      search_end);
>                 if (crash_base =3D=3D 0) {
>                         pr_warn("crashkernel: couldn't allocate %lldKB\n"=
,
>                                 crash_size >> 10);
>                         return;
>                 }
> +
> +               if (!crash_low_size)
> +                       crash_low_size =3D DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +       }
> +
> +       if ((crash_base > dma32_phys_limit - crash_low_size) &&
> +           crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> +               memblock_phys_free(crash_base, crash_size);
> +               return;
>         }
>
>         pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld MB)\n"=
,
> --
> 2.31.1
>


--=20
Best Regards
 Guo Ren
