Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0999F7497C0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjGFIyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjGFIyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:54:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBED1BC2;
        Thu,  6 Jul 2023 01:54:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05C38618DB;
        Thu,  6 Jul 2023 08:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3B1C43391;
        Thu,  6 Jul 2023 08:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688633641;
        bh=BPOKAtKEZsLQYqxQEn58ctnADIlq6pN2eFukwAbEnx8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=beK9deYduBKqS6YLBFt6ppsVe0yRoy/MxMQzFsFYHino2LJojmD4O3AJ+B4Yl1RJF
         dGnh4V4Li31VNs2Y+7nQDfDpk4PKlJ45B/KlZBcAIEbvxynjot5ZboGePcVNC3Lv40
         vwGChjUciBKXxb2/pu0O03gJHrVskzYXp63FM4OkTSjnDrveESvJ5Eeg56aT2PxM91
         wOfX5CmosO+5xSay9JkfVR2wD8g8pyMpGofqcf28kCTlluWqsgYvy3pyNB7gQxlWuc
         pWeBK8yvPd1gJfEfkT86DPTi+kgxGFI9V339Z3FdwzoVwsFuyrViC8VKupLbMgk7Tk
         BDNw7C5cGMNqQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b6c5ede714so20427091fa.1;
        Thu, 06 Jul 2023 01:54:01 -0700 (PDT)
X-Gm-Message-State: ABy/qLakTVrCb2SU3UfV6YMmmadsLYesUzKTZL+TbUet/ukcnqhhAZGj
        zyVos7hfJB4egkspuFp/yL7Uow/yZFXioUQJnnY=
X-Google-Smtp-Source: APBJJlG9hlQ+baCj1Ocfd/bosbNpQBdbn4u1x8CKtqovKY5A5awNf90avWLlllSXL8AumOkcJPtGKWz5NpOAyzGZjfc=
X-Received: by 2002:a2e:95d4:0:b0:2b6:da61:d5b9 with SMTP id
 y20-20020a2e95d4000000b002b6da61d5b9mr543533ljh.14.1688633639271; Thu, 06 Jul
 2023 01:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230705114251.661-1-cuiyunhui@bytedance.com> <mhng-48837062-b9f6-4968-be9e-9d3b352be117@palmer-ri-x1c9>
 <CAEEQ3wmRZGHNMB+CyfmAAGmapvFeQMVsgtQJh5nE01KG_3UBiw@mail.gmail.com>
In-Reply-To: <CAEEQ3wmRZGHNMB+CyfmAAGmapvFeQMVsgtQJh5nE01KG_3UBiw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 6 Jul 2023 10:53:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC5B2N=i3SAWHygkTQ@mail.gmail.com>
Message-ID: <CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC5B2N=i3SAWHygkTQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from FFI
To:     =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Emil Renner Berthing <kernel@esmil.dk>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>, sunilvl@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        lpieralisi@kernel.org, rafael@kernel.org, lenb@kernel.org,
        jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
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

On Thu, 6 Jul 2023 at 04:04, =E8=BF=90=E8=BE=89=E5=B4=94 <cuiyunhui@bytedan=
ce.com> wrote:
>
> Hi Palmer,
>
> On Wed, Jul 5, 2023 at 10:17=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.co=
m> wrote:
> >
> > On Wed, 05 Jul 2023 04:42:47 PDT (-0700), cuiyunhui@bytedance.com wrote=
:
> > > Here's version 3 of patch series.
> > >
> > > V1: The FFI (FDT FIRMWARE INTERFACE) scheme has reached a
> > > consensus with the Maintainers.
> > > Please refer to:
> > > https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16=
-1-cuiyunhui@bytedance.com/
> >
> > From looking at that thread it seems that the consensus is this is a ba=
d
> > idea?  Sorry if I'm just missing something...
> >
>
> First of all, Coreboot does not support EFI, Ron has expressed, as follow=
s:
> "I am wondering if we can focus on risc-v here, and not drag in ARM,
> b/c the ARM ACPI+UEFI ship has sailed. I had that discussion in 2013
> ;-) and it's clear we don't want to redo it.
> In general, in my world, because of the many problems that come with
> UEFI (security, code quality, performance), we'd like to avoid
> requiring a dependency on UEFI just to get ACPI on RISC-V. It also
> seems, from other discussions I'm having, that there is some belief
> that ACPI will be wanted on RISC-V. It would be nice to separate those
> pieces on RISC-V; certainly they were separate for a very long time in
> the x86 world (we had ACPI+SMM on coreboot laptops without UEFI for
> example)."
>

There appears to be a bit of cargo cult going on here.

I agree that the traditional BIOS vendors did a terrible job pivoting
to (U)EFI when it became a requirement for booting Windows on x86 PCs,
and coreboot did an excellent job providing a retrofit alternative
that was more secure and robust.

However, it makes sense to distinguish between
a) the UEFI specification
b) the UEFI reference implementation (edk2)
c) commercial implementations created by BIOS vendors for x86 PC OEMs
that do not perform any testing beyond booting Windows.

coreboot decided not to implement EFI at all, which on x86 means
booting in a mode that is similar to BIOS boot. Given how the ACPI and
DMTF (for SMBIOS) specifications were already under development when
UEFI was being rolled out on x86, those specs contain provisions
defining how to obtain the ACPI and SMBIOS tables by scanning regions
of memory and looking for magic strings. But this is only defined for
x86, and only works on x86 because all x86 machines are essentially
PCs with a highly uniform system topology.

The ARM case is very different, and while I am no expect on RISC-V,
the following probably applies to it as well:
- there is no need to work around buggy proprietary firmware that can
boot Windows but not Linux
- there is no 'prior art' when it comes to pre-EFI boot interfaces
except for embedded style bare metal boot where all initialization is
done by the kernel (e.g., PCI enumeration and resource assignment
etc), and this is fundamentally arch specific
- ACPI is a rich firmware interface, and the ACPI specification layers
it on top of UEFI so the OS can make certain assumptions about the
extent to which the platform has been initialized by the time it hands
over.

This is why the maintainers of the arm64 and RISC-V ports appear to
agree that ACPI will only be supported when booting from firmware that
implements the EFI specification. Note that this does not impose any
requirement at all regarding which EFI implementation is going to be
used: suggestions have been made on the thread to use a) a coreboot
specific minimal EFI shim that describes the firmware tables and the
EFI memory map, b) the UPL payload for coreboot, and c) U-Boot's EFI
implementation.

I will also note that booting according to the EFI spec is not
fundamentally  more secure or faster: I have done some experiments on
arm64 comparing bare metal boot with EFI boot using a minimal
implementation in Rust, for booting virtual machines under KVM. Due to
cache maintenance overhead and execution with the MMU disabled, bare
metal boot is actually slightly slower. And due to the fact that the
minimal EFI firmware enables the MMU and caches straight out of reset,
it is also arguably more secure, given that all memory permission
based protections and other page table based hardening measures (e.g.,
BTI) are always enabled.

In summary, I think it may be time to stop extrapolating from bad
experiences with buggy proprietary x86 PC firmware created by
traditional BIOS vendors for booting Windows (and nothing else) 15+
years ago. The situation is very different for non-x86 Linux
architectures, where we are trying hard to beat some sense into the
fragmented embedded ecosystem, where every SoC vendor used to have its
own fork of u-boot that booted in a slightly different manner,
requiring a lot of effort on the part of the distros to track all
those moving targets.


> Then, a consensus was reached with Ard, that FFI can be applied to RISC-V=
.
>

For the record, I would not characterize this as consensus. What I said was
- SMBIOS has very little significance to the kernel itself or impact
on its internal operation, and so it can be exposed via DT in a
generic manner;
- ACPI without UEFI on non-x86 is a) a bad idea, and b) fundamentally
broken on arm64. So b) is out of the question, but it is not up to me
to decide whether or not the RISC-V maintainers should entertain bad
ideas.
