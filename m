Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37106B6601
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 13:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCLMl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 08:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCLMlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 08:41:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26143B649
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 05:41:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B76AB80B18
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 12:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0368CC433D2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 12:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678624874;
        bh=BGavBv7KDuvgH4Q16a/CSuHp7Sto9Kb1YGzbv8hwxaU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WWFHslPCqG9jZ1rbr+HyDQkbZijpoS1rBfmyj1i6MBKWvllh8Gsjj0B7hxuvr7/Rm
         XnqW4NmoltNEZ6Gk6rwblJq5zcwRG7nlPPtXvcsaq+1qAKUmIGwDG9v5XgSxbG1KjD
         VCW70CGDfD9ReY0Tvg1kzxPI3PIvIFs2bdQh2J442jIKB4qrgz+zAhCIk7lATzEiUK
         v7Xqk5mQU5P4PFqNsC/2J2aWafs7VijczbWv7SF7C2XCDcT/+FCAZfOkyjOlR5wnpQ
         S8VP7Eya7bkQYwS297mTh6ljJ9PbkkzcqLeM7zi+IA7A653wuDtr3fPWwFGxoTZdfF
         RTDUFrtJ8HP+Q==
Received: by mail-ed1-f53.google.com with SMTP id j11so38331072edq.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 05:41:12 -0700 (PDT)
X-Gm-Message-State: AO0yUKUuqb4PIlT1inMF7Xkxgp0sN9A5UKZ1yZWrC6unn6thRQ66+9pq
        U0XXJswecFF/P1eqGkzpPG7yZys1oPvldt3Qk+w=
X-Google-Smtp-Source: AK7set+xyo5/ylaMa6xZYzFt/j7uAwPz1MMxIRKlMS7m0bazR/E948SkWRrmQix7GuVrBs9C99cJl/XsekdoEKKUV0I=
X-Received: by 2002:a17:906:eb10:b0:922:d565:3f9d with SMTP id
 mb16-20020a170906eb1000b00922d5653f9dmr1351529ejb.8.1678624871295; Sun, 12
 Mar 2023 05:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230310103144.396214-1-dylan@andestech.com>
In-Reply-To: <20230310103144.396214-1-dylan@andestech.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 12 Mar 2023 20:40:59 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTwEJNmee7TcbdbcmLQKTTWpokrUST4xanyreUJHxETqg@mail.gmail.com>
Message-ID: <CAJF2gTTwEJNmee7TcbdbcmLQKTTWpokrUST4xanyreUJHxETqg@mail.gmail.com>
Subject: Re: [PATCH] riscv: mm: Fix incorrect ASID argument when flushing TLB
To:     Dylan Jhong <dylan@andestech.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        sergey.matyukevich@syntacore.com, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com, x5710999x@gmail.com,
        tim609@andestech.com, peterlin@andestech.com, ycliang@andestech.com
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

On Fri, Mar 10, 2023 at 6:32=E2=80=AFPM Dylan Jhong <dylan@andestech.com> w=
rote:
>
> Currently, we pass the CONTEXTID instead of the ASID to the TLB flush
> function. We should only take the ASID field to prevent from touching
> the reserved bit field.
>
> Fixes: 3f1e782998cd ("riscv: add ASID-based tlbflushing methods")
> Signed-off-by: Dylan Jhong <dylan@andestech.com>
> ---
>  arch/riscv/include/asm/tlbflush.h | 2 ++
>  arch/riscv/mm/context.c           | 3 ++-
>  arch/riscv/mm/tlbflush.c          | 2 +-
>  3 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/t=
lbflush.h
> index 907b9efd39a8..597d6d8aec28 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -12,6 +12,8 @@
>  #include <asm/errata_list.h>
>
>  #ifdef CONFIG_MMU
> +extern unsigned long asid_mask;
> +
>  static inline void local_flush_tlb_all(void)
>  {
>         __asm__ __volatile__ ("sfence.vma" : : : "memory");
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 80ce9caba8d2..a6b76b33e377 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -22,7 +22,8 @@ DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
>
>  static unsigned long asid_bits;
>  static unsigned long num_asids;
> -static unsigned long asid_mask;
> +unsigned long asid_mask;
> +EXPORT_SYMBOL(asid_mask);
Why EXPORT_SYMBOL? (No module would use it by your patch.)

>
>  static atomic_long_t current_version;
>
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index ce7dfc81bb3f..ba4c27187c95 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -27,7 +27,7 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm,=
 unsigned long start,
>         /* check if the tlbflush needs to be sent to other CPUs */
>         broadcast =3D cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
>         if (static_branch_unlikely(&use_asid_allocator)) {
> -               unsigned long asid =3D atomic_long_read(&mm->context.id);
> +               unsigned long asid =3D atomic_long_read(&mm->context.id) =
& asid_mask;
>
>                 /*
>                  * TLB will be immediately flushed on harts concurrently
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren
