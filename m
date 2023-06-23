Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3924373BC33
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjFWP6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFWP5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:57:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D76210A;
        Fri, 23 Jun 2023 08:57:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FB8261AAF;
        Fri, 23 Jun 2023 15:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927A5C433CB;
        Fri, 23 Jun 2023 15:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687535870;
        bh=ZvtKMCreuF1Bw/8sl4ZAqqcyo/nUFlKwy8MW1+OOcB4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RU1wFpQChxqltgI2/fn0idKJrwTwaKrQ6DJe07WIvQkhY/HLAobnXiibjNGk0L20B
         cyD5JrJtvZNqmuXvWXUPzic0Z66Jqo5aAHGqxvRh86vtVdX5hCh2lTDj0AtM8U2793
         r6rkBLs/fkvS0DoOX5Ph53qdxWAxhaRm7OtH7EMX4C0ohrvWbdJSgX0BVEHdtPfE7m
         STYOrTi+uxPcWl1MR6lAKHJDwbWEjqIHNahhMdvMMxX82/AIJ/kGEMq0VQ8jQfwlIX
         Vz97qsZJVcrnJWSiREaiE2A4RxnIU+0kExQeg5wxzeMJ9aNhLGPvkufK5LE0dEYIrb
         ivjHjJ8yXw8wg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51a2de3385fso902902a12.0;
        Fri, 23 Jun 2023 08:57:50 -0700 (PDT)
X-Gm-Message-State: AC+VfDzUw84IAu2f7B9bBvHC3go8Czg+Hziy1MZmkDUwwbMl9Kmnzyan
        W5fVtag+f1EWpy0C9wu9Z0euXWsMJ/OPVG9tojI=
X-Google-Smtp-Source: ACHHUZ4vLTrY+IQbjpeH3EXz6L1njzyeJ3LKDD7Th7B/S0PKNiDHdkM33OPA8SSOU+8Zm6TrONplCoN9bihldu0f0oc=
X-Received: by 2002:aa7:d498:0:b0:51b:cd07:d0f8 with SMTP id
 b24-20020aa7d498000000b0051bcd07d0f8mr7013316edr.6.1687535868798; Fri, 23 Jun
 2023 08:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230623134351.1898379-1-kernel@xen0n.name> <20230623134351.1898379-7-kernel@xen0n.name>
In-Reply-To: <20230623134351.1898379-7-kernel@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 23 Jun 2023 23:57:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4FGF-WTjUB+-Yxmk_kuXkgjsT6_2g2dCUpfYjggz7NMw@mail.gmail.com>
Message-ID: <CAAhV-H4FGF-WTjUB+-Yxmk_kuXkgjsT6_2g2dCUpfYjggz7NMw@mail.gmail.com>
Subject: Re: [PATCH 6/9] LoongArch: Simplify the invtlb wrappers
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xuerui,

To minimize modifications, and be more convenient to rebase, please
only modify the implementation of these functions, don't remove
functions and parameters. Thank you.

Huacai

On Fri, Jun 23, 2023 at 9:44=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> From: WANG Xuerui <git@xen0n.name>
>
> Of the 3 existing invtlb wrappers, invtlb_info is not used at all,
> so it is removed; invtlb_all and invtlb_addr have their unused
> argument(s) removed from their signatures.
>
> Also, the invtlb instruction has been supported by upstream LoongArch
> toolchains from day one, so ditch the raw opcode trickery and just use
> plain inline asm for it.
>
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> ---
>  arch/loongarch/include/asm/tlb.h | 45 ++++++++++++--------------------
>  arch/loongarch/mm/tlb.c          | 10 +++----
>  2 files changed, 21 insertions(+), 34 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/tlb.h b/arch/loongarch/include/as=
m/tlb.h
> index 0dc9ee2b05d2..5e6ee9a15f0f 100644
> --- a/arch/loongarch/include/asm/tlb.h
> +++ b/arch/loongarch/include/asm/tlb.h
> @@ -88,52 +88,39 @@ enum invtlb_ops {
>         INVTLB_GID_ADDR =3D 0x16,
>  };
>
> -/*
> - * invtlb op info addr
> - * (0x1 << 26) | (0x24 << 20) | (0x13 << 15) |
> - * (addr << 10) | (info << 5) | op
> - */
>  static inline void invtlb(u32 op, u32 info, u64 addr)
>  {
>         __asm__ __volatile__(
> -               "parse_r addr,%0\n\t"
> -               "parse_r info,%1\n\t"
> -               ".word ((0x6498000) | (addr << 10) | (info << 5) | %2)\n\=
t"
> -               :
> -               : "r"(addr), "r"(info), "i"(op)
> -               :
> -               );
> -}
> -
> -static inline void invtlb_addr(u32 op, u32 info, u64 addr)
> -{
> -       __asm__ __volatile__(
> -               "parse_r addr,%0\n\t"
> -               ".word ((0x6498000) | (addr << 10) | (0 << 5) | %1)\n\t"
> -               :
> -               : "r"(addr), "i"(op)
> +               "invtlb %0, %1, %2\n\t"
>                 :
> +               : "i"(op), "r"(info), "r"(addr)
> +               : "memory"
>                 );
>  }
>
> -static inline void invtlb_info(u32 op, u32 info, u64 addr)
> +static inline void invtlb_addr(u32 op, u64 addr)
>  {
> +       /*
> +        * The ISA manual says $zero shall be used in case a particular o=
p
> +        * does not take the respective argument, hence the invtlb helper=
 is
> +        * not re-used to make sure this is the case.
> +        */
>         __asm__ __volatile__(
> -               "parse_r info,%0\n\t"
> -               ".word ((0x6498000) | (0 << 10) | (info << 5) | %1)\n\t"
> -               :
> -               : "r"(info), "i"(op)
> +               "invtlb %0, $zero, %1\n\t"
>                 :
> +               : "i"(op), "r"(addr)
> +               : "memory"
>                 );
>  }
>
> -static inline void invtlb_all(u32 op, u32 info, u64 addr)
> +static inline void invtlb_all(u32 op)
>  {
> +       /* Similar to invtlb_addr, ensure the operands are actually $zero=
. */
>         __asm__ __volatile__(
> -               ".word ((0x6498000) | (0 << 10) | (0 << 5) | %0)\n\t"
> +               "invtlb %0, $zero, $zero\n\t"
>                 :
>                 : "i"(op)
> -               :
> +               : "memory"
>                 );
>  }
>
> diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
> index 00bb563e3c89..de04d2624ef4 100644
> --- a/arch/loongarch/mm/tlb.c
> +++ b/arch/loongarch/mm/tlb.c
> @@ -17,19 +17,19 @@
>
>  void local_flush_tlb_all(void)
>  {
> -       invtlb_all(INVTLB_CURRENT_ALL, 0, 0);
> +       invtlb_all(INVTLB_CURRENT_ALL);
>  }
>  EXPORT_SYMBOL(local_flush_tlb_all);
>
>  void local_flush_tlb_user(void)
>  {
> -       invtlb_all(INVTLB_CURRENT_GFALSE, 0, 0);
> +       invtlb_all(INVTLB_CURRENT_GFALSE);
>  }
>  EXPORT_SYMBOL(local_flush_tlb_user);
>
>  void local_flush_tlb_kernel(void)
>  {
> -       invtlb_all(INVTLB_CURRENT_GTRUE, 0, 0);
> +       invtlb_all(INVTLB_CURRENT_GTRUE);
>  }
>  EXPORT_SYMBOL(local_flush_tlb_kernel);
>
> @@ -100,7 +100,7 @@ void local_flush_tlb_kernel_range(unsigned long start=
, unsigned long end)
>                 end &=3D (PAGE_MASK << 1);
>
>                 while (start < end) {
> -                       invtlb_addr(INVTLB_ADDR_GTRUE_OR_ASID, 0, start);
> +                       invtlb_addr(INVTLB_ADDR_GTRUE_OR_ASID, start);
>                         start +=3D (PAGE_SIZE << 1);
>                 }
>         } else {
> @@ -131,7 +131,7 @@ void local_flush_tlb_page(struct vm_area_struct *vma,=
 unsigned long page)
>  void local_flush_tlb_one(unsigned long page)
>  {
>         page &=3D (PAGE_MASK << 1);
> -       invtlb_addr(INVTLB_ADDR_GTRUE_OR_ASID, 0, page);
> +       invtlb_addr(INVTLB_ADDR_GTRUE_OR_ASID, page);
>  }
>
>  static void __update_hugetlb(struct vm_area_struct *vma, unsigned long a=
ddress, pte_t *ptep)
> --
> 2.40.0
>
>
