Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFFF6F3E67
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 09:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjEBHbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 03:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBHbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 03:31:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB9D273A
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 00:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1932961B09
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 07:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8ADC433D2
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683012708;
        bh=SCcISGzqjznr/fAixNNQBNpYk2QD40v7io7ccSJe5ck=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HRThcAQUp8APx9O/rmQNTud64ub/95lvDrTHWwbcxo4zADRBpZTj/EYgNlGH8Z3Vc
         ikOMSDGgx7jELTcwsjzCk8NynJbpX08LSSCpgDaZ1/DmU0fSnaCYyrltrpH7Nh1ytx
         GswDSt+HCtkziqm2IZ6yIxHypAzaFPAqMaFUj7aVahZakyXc4MU3fFlvLy6G+oPqTB
         shvOf7cAwd9D3QfL5EoJ8TKlJCVzlCkKJz82uEcXBVXdBKmdq4FGK9Tsbmc+UNC9Ly
         xeqf4Rg3Aek+B4RkjFID/5GGXeYkgQ/zsXTxeTzNryCCV0oJ748PIWipwd+KaIlHVw
         X6Y7bCug0d5Ig==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2a7b02615f1so33741531fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 00:31:48 -0700 (PDT)
X-Gm-Message-State: AC+VfDzJNlw/exP/xb10TXpRTNSs2HOOm1+Y1VDFTaz5eKrNEYLQ+NMI
        UcZLH7Qrs9d7utCG6ZxblRf2/Qf3C1CKQe5M3dA=
X-Google-Smtp-Source: ACHHUZ7WTDd4R0vSpQizgtxVmzWmqSviYr6JCtDOpRsKz1W6jrFcdlDYDkXcbEOU0CgKYUyIMvRfRZxOq3k72H05ZIM=
X-Received: by 2002:a19:ae0b:0:b0:4e9:5f90:748 with SMTP id
 f11-20020a19ae0b000000b004e95f900748mr4037635lfc.9.1683012706521; Tue, 02 May
 2023 00:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230501222551.1254686-1-maskray@google.com>
In-Reply-To: <20230501222551.1254686-1-maskray@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 2 May 2023 09:31:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFWQdK-81K_04BLaTDvYvQS+kc=5q90960BkJX6uYFExg@mail.gmail.com>
Message-ID: <CAMj1kXFWQdK-81K_04BLaTDvYvQS+kc=5q90960BkJX6uYFExg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: lds: move .got section out of .text
To:     Fangrui Song <maskray@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2023 at 00:25, Fangrui Song <maskray@google.com> wrote:
>
> Currently, the .got section is placed within the output section .text.
> However, when .got is non-empty, the SHF_WRITE flag is set for .text
> when linked by lld. GNU ld recognizes .text as a special section and
> ignores the SHF_WRITE flag. By renaming .text, we can also get the
> SHF_WRITE flag.
>
> The kernel has performed R_AARCH64_RELATIVE resolving very early, and can
> then assume that .got is read-only. Let's move .got to the vmlinux_rodata
> pseudo-segment. The change avoids a section with both executable and
> writable permissions.
>

Maybe add

"This matters to consumers of the vmlinux ELF representation of the
kernel image, such as syzkaller, which disregards writable PT_LOAD
segments when resolving code symbols. The kernel itself does not care
about this distinction, but given that the GOT contains data and not
code, it does not require executable permissions, and therefore does
not belong in .text to begin with."


> Signed-off-by: Fangrui Song <maskray@google.com>
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> --
> Changes from v1 (https://lore.kernel.org/lkml/20230428050442.180913-1-maskray@google.com/)
> * move .got to the vmlinux_rodata pseudo-segment as suggested by Ard Biesheuvel
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index b9202c2ee18e..3cd7e76cc562 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -181,10 +181,17 @@ SECTIONS
>                         KPROBES_TEXT
>                         HYPERVISOR_TEXT
>                         *(.gnu.warning)
> -               . = ALIGN(16);
> -               *(.got)                 /* Global offset table          */
>         }
>
> +       . = ALIGN(SEGMENT_ALIGN);
> +       _etext = .;                     /* End of text section */
> +
> +       /* everything from this point to __init_begin will be marked RO NX */
> +       RO_DATA(PAGE_SIZE)
> +
> +       HYPERVISOR_DATA_SECTIONS
> +
> +       .got : { *(.got) }
>         /*
>          * Make sure that the .got.plt is either completely empty or it
>          * contains only the lazy dispatch entries.
> @@ -193,14 +200,6 @@ SECTIONS
>         ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
>                "Unexpected GOT/PLT entries detected!")
>
> -       . = ALIGN(SEGMENT_ALIGN);
> -       _etext = .;                     /* End of text section */
> -
> -       /* everything from this point to __init_begin will be marked RO NX */
> -       RO_DATA(PAGE_SIZE)
> -
> -       HYPERVISOR_DATA_SECTIONS
> -
>         /* code sections that are never executed via the kernel mapping */
>         .rodata.text : {
>                 TRAMP_TEXT
> --
> 2.40.1.495.gc816e09b53d-goog
>
