Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9B36FD7FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbjEJHOf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 May 2023 03:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbjEJHO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:14:26 -0400
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACC240EB;
        Wed, 10 May 2023 00:14:24 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-44fc0b53a8aso4356461e0c.0;
        Wed, 10 May 2023 00:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683702863; x=1686294863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvYmUAzo0cwOybz0hjxV39+5gh/FQ5/NU0n3aFKpLiE=;
        b=Xk8jO34Hm7UQ0bioDM/IACHOs6jnBoIM/S6IW1QFpG+Jgug1rDItKgpWRy2YiVG+y5
         cctnO6ZdInRr+C3aC3BMG4XLQq5eLZMiq6LE4dHhN71Ff8Lb7C2Ac1mxxSdTsAO93HIh
         f4II7oyySHXHCr/roUDaZ2cBXdVKtcU576BiqT49ciYRxqX84zaAZ6ReMmN2onWcFn2d
         yW6S9GyYDK2P1vYmrh+HtC3bQfVQoQGiuhGl/RjPqmLgniokFq1zxPJ1sOq7kHdEKDEu
         moS1ifJHLtf0Agr8UteIhcpXHuAmhN1KpsQeURE/XgTLwe49aYFjm3KRWrrIJK4MZZAU
         5sQA==
X-Gm-Message-State: AC+VfDzF/uStQqhdP7m4bwTFdJyxsf2/++bc5x9vMo1gUwsZQEyy1dUh
        b841MSC+3tAmibdzMopdubGxzHJkizOCug==
X-Google-Smtp-Source: ACHHUZ76i3iJ2yQvmDOGVbIUJ6R5ob8AqV0wkJ+3LtkcTzktoEx836K/ncP1SMIT90Qre5P7gG52Qg==
X-Received: by 2002:a1f:bfc4:0:b0:440:7261:c77e with SMTP id p187-20020a1fbfc4000000b004407261c77emr5260479vkf.1.1683702863444;
        Wed, 10 May 2023 00:14:23 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id b137-20020a1fb28f000000b00443bcc4131dsm1898612vkf.13.2023.05.10.00.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 00:14:23 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-44ffef66dabso3763567e0c.2;
        Wed, 10 May 2023 00:14:22 -0700 (PDT)
X-Received: by 2002:a05:6902:1147:b0:b99:4ac6:3c75 with SMTP id
 p7-20020a056902114700b00b994ac63c75mr18672301ybu.10.1683702842290; Wed, 10
 May 2023 00:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com> <237c8410-ce61-94c-4260-7318ad6a4f3@google.com>
In-Reply-To: <237c8410-ce61-94c-4260-7318ad6a4f3@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 May 2023 09:13:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWb0SrEs=cDzKW1Ai2UywnnpZip4pk9mOkiVGivPpj8sg@mail.gmail.com>
Message-ID: <CAMuHMdWb0SrEs=cDzKW1Ai2UywnnpZip4pk9mOkiVGivPpj8sg@mail.gmail.com>
Subject: Re: [PATCH 05/23] m68k: allow pte_offset_map[_lock]() to fail
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

Thanks for your patch!

On Wed, May 10, 2023 at 6:48 AM Hugh Dickins <hughd@google.com> wrote:
> In rare transient cases, not yet made possible, pte_offset_map() and
> pte_offset_map_lock() may not find a page table: handle appropriately.
>
> Restructure cf_tlb_miss() with a pte_unmap() (previously omitted)
> at label out, followed by one local_irq_restore() for all.

That's a bug fix, which should be a separate patch?

>
> Signed-off-by: Hugh Dickins <hughd@google.com>


> --- a/arch/m68k/include/asm/mmu_context.h
> +++ b/arch/m68k/include/asm/mmu_context.h
> @@ -99,7 +99,7 @@ static inline void load_ksp_mmu(struct task_struct *task)
>         p4d_t *p4d;
>         pud_t *pud;
>         pmd_t *pmd;
> -       pte_t *pte;
> +       pte_t *pte = NULL;
>         unsigned long mmuar;
>
>         local_irq_save(flags);
> @@ -139,7 +139,7 @@ static inline void load_ksp_mmu(struct task_struct *task)
>
>         pte = (mmuar >= PAGE_OFFSET) ? pte_offset_kernel(pmd, mmuar)
>                                      : pte_offset_map(pmd, mmuar);
> -       if (pte_none(*pte) || !pte_present(*pte))
> +       if (!pte || pte_none(*pte) || !pte_present(*pte))
>                 goto bug;

If the absence of a pte is to become a non-abnormal case, it should
probably jump to "end" instead, to avoid spamming the kernel log.

>
>         set_pte(pte, pte_mkyoung(*pte));
> @@ -161,6 +161,8 @@ static inline void load_ksp_mmu(struct task_struct *task)
>  bug:
>         pr_info("ksp load failed: mm=0x%p ksp=0x08%lx\n", mm, mmuar);
>  end:
> +       if (pte && mmuar < PAGE_OFFSET)
> +               pte_unmap(pte);

Is this also a bugfix, not mentioned in the patch description?

>         local_irq_restore(flags);
>  }
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
