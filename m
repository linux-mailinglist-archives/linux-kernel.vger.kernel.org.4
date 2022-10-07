Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC105F74E9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJGHyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiJGHyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:54:15 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E9E868B4
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:54:14 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 187so3052878iov.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 00:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z3HmofIkLHyjFSNfg+w/HLXXCvk+x88+K8Xha7iHo70=;
        b=JL219CpZ9HN4n6xe7FrmK4uQLg0GErBZ7UVSeT5/WCimWUoE3YLNjTYivFn66DOg+G
         FGGXNwa5LHpIZJLNWVOteU7c1YfOwgcy8zMkvjz0r1WU4Eoc3nesjE7x05eHoQmqqidO
         wmAmsFIdn4xbCTa1AsoShro+6NA+9gy3TyKU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3HmofIkLHyjFSNfg+w/HLXXCvk+x88+K8Xha7iHo70=;
        b=UJONgHirqkr+kJxFpwACe6e/oAq10bTNpSdAmSK0ZgJSwxAtwhzgfJe/faPj6dq/vD
         8Wg/zzvrgkYkTv2CobweU2+Ix7r/jPNc820ntdNGzczc9fDV6HF68Ssa0uu7CrGTgi9+
         DL9D+JKDXGIhEIfLz7RikXfPyF0e3re8GZnzTiWF7p4Aacb0IrIvaokyCSvqv114boyW
         Zl8D8l8+a3CrR2gYi9kL2BQLHont+FnAsR5W+ciP+yC/Wqnu09DIw4qCWGn4cpNB6UFL
         MEq7JXW1IxXThLiejAFbrptQkO6jYDN/PxhWmV7km2RucitjnVQGkm9io2qaHPf1bRmx
         oM1Q==
X-Gm-Message-State: ACrzQf3fmvhGDbrQPwhKqMPT8Ut/nBcOITZuYUA28AlDVt+/HLYC1OkO
        82JwRly/4AVEaxAwboAjr1okCqR6RI2Cfiy5CcP4
X-Google-Smtp-Source: AMsMyM4hnwa9n8R0VVhVDUnbeMfGz0pzn/C/7xHfZ+SA71TLfQPovLp8Ftbin4tvHH8KvVKmU30gq1dajprNTdvFF3o=
X-Received: by 2002:a05:6602:15c7:b0:6a1:c3fc:98fd with SMTP id
 f7-20020a05660215c700b006a1c3fc98fdmr1666538iow.151.1665129253372; Fri, 07
 Oct 2022 00:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221006230051.185850-1-atishp@rivosinc.com> <20221006230051.185850-3-atishp@rivosinc.com>
 <b1306db2-74c5-c207-7c6d-beba0f1593f4@canonical.com> <CAMj1kXENi6rGK5tuU5ny5gAXMGLErx3o8ci3stazq0HJO5QArg@mail.gmail.com>
 <4ef86adf-a7c7-5ffc-6acc-9d269ea089ba@canonical.com>
In-Reply-To: <4ef86adf-a7c7-5ffc-6acc-9d269ea089ba@canonical.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 7 Oct 2022 00:54:02 -0700
Message-ID: <CAOnJCULKVMMMtxdWgeLb=3Au+yXUmoD9eK8Lowin8WdDGvhiew@mail.gmail.com>
Subject: Re: [v4 PATCH 2/3] RISC-V: Update image header
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Fu Wei <tekkamanninja@gmail.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>,
        Nikita Ermakov <arei@altlinux.org>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 7, 2022 at 12:50 AM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> On 10/7/22 09:20, Ard Biesheuvel wrote:
> > On Fri, 7 Oct 2022 at 01:51, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >>
> >>
> >> On 10/7/22 01:00, Atish Patra wrote:
> >>> Update the RISC-V Linux kernel image headers as per the current header.
> >>>
> >>> Reference:
> >>> <Linux kernel source>/Documentation/riscv/boot-image-header.rst
> >>>
> >>> 474efecb65dc: ("riscv: modify the Image header to improve compatibility with the ARM64 header")
> >>>
> >>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> >>> ---
> >>>    include/grub/riscv32/linux.h | 15 ++++++++-------
> >>>    include/grub/riscv64/linux.h | 21 +++++++++++++--------
> >>>    2 files changed, 21 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/include/grub/riscv32/linux.h b/include/grub/riscv32/linux.h
> >>> index 512b777c8a41..de0dbdcd1be5 100644
> >>> --- a/include/grub/riscv32/linux.h
> >>> +++ b/include/grub/riscv32/linux.h
> >>> @@ -19,20 +19,21 @@
> >>>    #ifndef GRUB_RISCV32_LINUX_HEADER
> >>>    #define GRUB_RISCV32_LINUX_HEADER 1
> >>>
> >>> -#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x52534356 /* 'RSCV' */
> >>> +#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x05435352 /* 'RSC\0x5' */
> >>
> >> Thanks for following up on this series.
> >>
> >> Considering 69edb312056 ("loader/arm64/linux: Remove magic number header
> >> field check") why should this constant exist in GRUB at all?
> >>

Yes. Those are not required. I will remove those.

> >> In a follow up patch we could remove it together with
> >> GRUB_LINUX_ARM_MAGIC_SIGNATURE, GRUB_LINUX_ARMXX_MAGIC_SIGNATURE, and
> >> GRUB_LINUX_ARMXX_MAGIC_SIGNATURE.
> >>
> >
GRUB_LINUX_ARM_MAGIC_SIGNATURE is still being used in ARM32 loaders.
The other one can be removed.

> > Indeed.
> >
> > But by the same reasoning, why do we need per-arch kernel header
> > typedefs at all?  The only fields we access are generic PE/COFF header
> > fields.
>
> That said I would suggest to put the series in without any further
> iterations and clean up afterwards.
>
> Acked-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> >
> >>>
> >>> -/* From linux/Documentation/riscv/booting.txt */
> >>> +/* From linux/Documentation/riscv/boot-image-header.rst */
> >>>    struct linux_riscv_kernel_header
> >>>    {
> >>>      grub_uint32_t code0;              /* Executable code */
> >>>      grub_uint32_t code1;              /* Executable code */
> >>> -  grub_uint64_t text_offset; /* Image load offset */
> >>> -  grub_uint64_t res0;                /* reserved */
> >>> -  grub_uint64_t res1;                /* reserved */
> >>> +  grub_uint64_t text_offset; /* Image load offset, little endian */
> >>> +  grub_uint64_t image_size;  /* Effective Image size, little endian */
> >>> +  grub_uint64_t flags;               /* kernel flags, little endian */
> >>> +  grub_uint32_t version;     /* Version of this header */
> >>> +  grub_uint32_t res1;                /* reserved */
> >>>      grub_uint64_t res2;               /* reserved */
> >>>      grub_uint64_t res3;               /* reserved */
> >>
> >> According to tag next-20221006 of
> >> Documentation/riscv/boot-image-header.rst and of
> >> arch/riscv/include/asm/image.h this field is called 'magic' and filled
> >> it with the string 'RISCV\0\0\0'.
> >>
> >>> -  grub_uint64_t res4;                /* reserved */
> >>> -  grub_uint32_t magic;               /* Magic number, little endian, "RSCV" */
> >>> +  grub_uint32_t magic;               /* Magic number, little endian, "RSC\x05" */
> >>
> >> The Linux kernel documentation calls this field magic2.
> >>

Yes. I forgot to update this one for rv32. RV64 header file has the
correct fields.

> >> Of course this is functionally irrelevant as we don't care about the
> >> content of both fields.
> >>
> >>>      grub_uint32_t hdr_offset; /* Offset of PE/COFF header */
> >>>    };
> >>>
> >>> diff --git a/include/grub/riscv64/linux.h b/include/grub/riscv64/linux.h
> >>> index 3630c30fbf1a..ea77f8718222 100644
> >>> --- a/include/grub/riscv64/linux.h
> >>> +++ b/include/grub/riscv64/linux.h
> >>> @@ -19,23 +19,28 @@
> >>>    #ifndef GRUB_RISCV64_LINUX_HEADER
> >>>    #define GRUB_RISCV64_LINUX_HEADER 1
> >>>
> >>> -#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x52534356 /* 'RSCV' */
> >>> +#include <grub/efi/pe32.h>
> >>> +
> >>> +#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x05435352 /* 'RSC\0x5' */
> >>

Done.

> >> to be removed in future
> >>
> >> Best regards
> >>
> >> Heinrich
> >>
> >>>
> >>>    #define GRUB_EFI_PE_MAGIC   0x5A4D
> >>>
> >>> -/* From linux/Documentation/riscv/booting.txt */
> >>> +/* From linux/Documentation/riscv/boot-image-header.rst */
> >>>    struct linux_riscv_kernel_header
> >>>    {
> >>>      grub_uint32_t code0;              /* Executable code */
> >>>      grub_uint32_t code1;              /* Executable code */
> >>> -  grub_uint64_t text_offset; /* Image load offset */
> >>> -  grub_uint64_t res0;                /* reserved */
> >>> -  grub_uint64_t res1;                /* reserved */
> >>> +  grub_uint64_t text_offset; /* Image load offset, little endian */
> >>> +  grub_uint64_t image_size;  /* Effective Image size, little endian */
> >>> +  grub_uint64_t flags;               /* kernel flags, little endian */
> >>> +  grub_uint32_t version;     /* Version of this header */
> >>> +  grub_uint32_t res1;                /* reserved */
> >>>      grub_uint64_t res2;               /* reserved */
> >>> -  grub_uint64_t res3;                /* reserved */
> >>> -  grub_uint64_t res4;                /* reserved */
> >>> -  grub_uint32_t magic;               /* Magic number, little endian, "RSCV" */
> >>> +  grub_uint64_t magic;               /* magic (RISC-V specifc, deprecated)*/
> >>> +  grub_uint32_t magic2;              /* Magic number 2 (to match the ARM64 'magic' field pos) */
> >>>      grub_uint32_t hdr_offset; /* Offset of PE/COFF header */
> >>> +
> >>> +  struct grub_coff_image_header coff_image_header;
> >>>    };
> >>>
> >>>    #define linux_arch_kernel_header linux_riscv_kernel_header



-- 
Regards,
Atish
