Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B955E6CBC93
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjC1Kdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjC1Kdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:33:39 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1D76E9B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:33:37 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id e65so14340417ybh.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679999617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDR+svhMJqmi1JNTt9QQspjwqS4wpTbac+Zzy4tDFxI=;
        b=q6BWSq3V1F6Rm0Eo4lGZIghczqg4WrLQmzkgqoeTIie1EmepHBt+OGKT/YC9Sd/nbR
         G1096B3bRLGA/WTZ4Ecjlqx0xzZZxnmnfHCP8QENg8WQyMipQJC2ReJmm0NBcvW1/7Ua
         1cqVCArEkX9PJ/ZqW03tKV/8gPtwlNztlXeCQmCv4i73gXMIrxqRaVI3nSxIg/zA/ag6
         ZcmzlpkS6Z6FJmSaiYsFT3qr4IdX3g4UhuvM+6nrYFcKGQwgQ7Np4wEelT4ftwKcL/yl
         qGiOZfbOTEEMioisfApxceMOPvut1f7vLjczyXXBHm/dKW7FAP0kk3bjEH9MgBxO0zLC
         Y0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679999617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDR+svhMJqmi1JNTt9QQspjwqS4wpTbac+Zzy4tDFxI=;
        b=lLkqd+BSIzr5LbphutOGgAdHR24sotLfEzSQMG6xba02VeFSJep4SZhaDaFp04DowP
         8YtOdzefKTDFY30g7MmZ+/0vlruZbISlLegq5SjhDHgnC51Wi4a9cMD/QGAJUQcd3+wo
         J4gvuTQa6hSEdhRmFqYcHVlauGteXIEaDUaKNMjZ2kQzWwxkm+q3tIxwyN4gZSmgIbRy
         EKJNv8TESfUPjxTEqwAyDY2gEiEGOfb30asXkdS5cbh46/l0b8z+BK6iqSPXBHqJLjQS
         ecZHGcFtZcTB40at/f/vo85zZtOQ+aToVwYi4lYz89Xx5HAE3ZSHLbKWBqDvo0zg9QMx
         qEHg==
X-Gm-Message-State: AAQBX9csougT1mbkNe1Edf5wjzQSL9oYiVl8AA3QT5IM7enIqxBhR4Dd
        XauzNT9m0HYwucQzNpsmiBYlD3lML89yzivjWxemJ4hq7cYczWuRtxjTOA==
X-Google-Smtp-Source: AKy350YZZt4/ks3j8DNXjnapUa3ZNTgqyy7bbzy1kfqGqIfQn0BYtMYGjz/iUjziVkMI4qqHKqweRe0dTSyARO819Fs=
X-Received: by 2002:a25:2d20:0:b0:b75:afb9:a257 with SMTP id
 t32-20020a252d20000000b00b75afb9a257mr14063323ybt.65.1679999616628; Tue, 28
 Mar 2023 03:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230328095807.7014-1-songmuchun@bytedance.com> <20230328095807.7014-4-songmuchun@bytedance.com>
In-Reply-To: <20230328095807.7014-4-songmuchun@bytedance.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Mar 2023 12:32:59 +0200
Message-ID: <CANpmjNNry_OxZJFAKSFf9Cpb2SCWM-__AF25BpGwOXpa+DJBUQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] mm: kfence: make kfence_protect_page() void
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        jannh@google.com, sjpark@amazon.de, muchun.song@linux.dev,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 at 11:58, Muchun Song <songmuchun@bytedance.com> wrote:
>
> The arch_kfence_init_pool() make sure kfence pool is mapped with base page
> size (e.g. 4KB), so the following PTE lookup in kfence_protect_page() will
> always succeed. Then there is no way to stop kfence_protect_page() always
> returning true, so make it void to simplify the code.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/arm/include/asm/kfence.h     |   4 +-
>  arch/arm64/include/asm/kfence.h   |   4 +-
>  arch/parisc/include/asm/kfence.h  |   7 +-
>  arch/powerpc/include/asm/kfence.h |   8 +--
>  arch/riscv/include/asm/kfence.h   |   4 +-
>  arch/s390/include/asm/kfence.h    |   3 +-
>  arch/x86/include/asm/kfence.h     |   9 +--
>  mm/kfence/core.c                  | 142 +++++++++++++++++---------------------
>  8 files changed, 73 insertions(+), 108 deletions(-)
>
> diff --git a/arch/arm/include/asm/kfence.h b/arch/arm/include/asm/kfence.h
> index 7980d0f2271f..c30a5f8125e8 100644
> --- a/arch/arm/include/asm/kfence.h
> +++ b/arch/arm/include/asm/kfence.h
> @@ -43,11 +43,9 @@ static inline bool arch_kfence_init_pool(void)
>         return true;
>  }
>
> -static inline bool kfence_protect_page(unsigned long addr, bool protect)
> +static inline void kfence_protect_page(unsigned long addr, bool protect)
>  {
>         set_memory_valid(addr, 1, !protect);
> -
> -       return true;
>  }
>
>  #endif /* __ASM_ARM_KFENCE_H */
> diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfence.h
> index a81937fae9f6..7717c6d98b6f 100644
> --- a/arch/arm64/include/asm/kfence.h
> +++ b/arch/arm64/include/asm/kfence.h
> @@ -12,11 +12,9 @@
>
>  static inline bool arch_kfence_init_pool(void) { return true; }
>
> -static inline bool kfence_protect_page(unsigned long addr, bool protect)
> +static inline void kfence_protect_page(unsigned long addr, bool protect)
>  {
>         set_memory_valid(addr, 1, !protect);
> -
> -       return true;
>  }
>
>  #ifdef CONFIG_KFENCE
> diff --git a/arch/parisc/include/asm/kfence.h b/arch/parisc/include/asm/kfence.h
> index 6259e5ac1fea..290792009315 100644
> --- a/arch/parisc/include/asm/kfence.h
> +++ b/arch/parisc/include/asm/kfence.h
> @@ -19,13 +19,10 @@ static inline bool arch_kfence_init_pool(void)
>  }
>
>  /* Protect the given page and flush TLB. */
> -static inline bool kfence_protect_page(unsigned long addr, bool protect)
> +static inline void kfence_protect_page(unsigned long addr, bool protect)
>  {
>         pte_t *pte = virt_to_kpte(addr);
>
> -       if (WARN_ON(!pte))
> -               return false;
> -
>         /*
>          * We need to avoid IPIs, as we may get KFENCE allocations or faults
>          * with interrupts disabled.
> @@ -37,8 +34,6 @@ static inline bool kfence_protect_page(unsigned long addr, bool protect)
>                 set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
>
>         flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> -
> -       return true;
>  }
>
>  #endif /* _ASM_PARISC_KFENCE_H */
> diff --git a/arch/powerpc/include/asm/kfence.h b/arch/powerpc/include/asm/kfence.h
> index 6fd2b4d486c5..9d8502a7d0a4 100644
> --- a/arch/powerpc/include/asm/kfence.h
> +++ b/arch/powerpc/include/asm/kfence.h
> @@ -21,16 +21,14 @@ static inline bool arch_kfence_init_pool(void)
>  }
>
>  #ifdef CONFIG_PPC64
> -static inline bool kfence_protect_page(unsigned long addr, bool protect)
> +static inline void kfence_protect_page(unsigned long addr, bool protect)
>  {
>         struct page *page = virt_to_page(addr);
>
>         __kernel_map_pages(page, 1, !protect);
> -
> -       return true;
>  }
>  #else
> -static inline bool kfence_protect_page(unsigned long addr, bool protect)
> +static inline void kfence_protect_page(unsigned long addr, bool protect)
>  {
>         pte_t *kpte = virt_to_kpte(addr);
>
> @@ -40,8 +38,6 @@ static inline bool kfence_protect_page(unsigned long addr, bool protect)
>         } else {
>                 pte_update(&init_mm, addr, kpte, 0, _PAGE_PRESENT, 0);
>         }
> -
> -       return true;
>  }
>  #endif
>
> diff --git a/arch/riscv/include/asm/kfence.h b/arch/riscv/include/asm/kfence.h
> index d887a54042aa..1299f47170b5 100644
> --- a/arch/riscv/include/asm/kfence.h
> +++ b/arch/riscv/include/asm/kfence.h
> @@ -46,7 +46,7 @@ static inline bool arch_kfence_init_pool(void)
>         return true;
>  }
>
> -static inline bool kfence_protect_page(unsigned long addr, bool protect)
> +static inline void kfence_protect_page(unsigned long addr, bool protect)
>  {
>         pte_t *pte = virt_to_kpte(addr);
>
> @@ -56,8 +56,6 @@ static inline bool kfence_protect_page(unsigned long addr, bool protect)
>                 set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
>
>         flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> -
> -       return true;
>  }
>
>  #endif /* _ASM_RISCV_KFENCE_H */
> diff --git a/arch/s390/include/asm/kfence.h b/arch/s390/include/asm/kfence.h
> index d55ba878378b..6d7b3632d79c 100644
> --- a/arch/s390/include/asm/kfence.h
> +++ b/arch/s390/include/asm/kfence.h
> @@ -33,10 +33,9 @@ static __always_inline void kfence_split_mapping(void)
>  #endif
>  }
>
> -static inline bool kfence_protect_page(unsigned long addr, bool protect)
> +static inline void kfence_protect_page(unsigned long addr, bool protect)
>  {
>         __kernel_map_pages(virt_to_page(addr), 1, !protect);
> -       return true;
>  }
>
>  #endif /* _ASM_S390_KFENCE_H */
> diff --git a/arch/x86/include/asm/kfence.h b/arch/x86/include/asm/kfence.h
> index ff5c7134a37a..6ffd4a078a71 100644
> --- a/arch/x86/include/asm/kfence.h
> +++ b/arch/x86/include/asm/kfence.h
> @@ -38,13 +38,9 @@ static inline bool arch_kfence_init_pool(void)
>  }
>
>  /* Protect the given page and flush TLB. */
> -static inline bool kfence_protect_page(unsigned long addr, bool protect)
> +static inline void kfence_protect_page(unsigned long addr, bool protect)
>  {
> -       unsigned int level;
> -       pte_t *pte = lookup_address(addr, &level);
> -
> -       if (WARN_ON(!pte || level != PG_LEVEL_4K))
> -               return false;
> +       pte_t *pte = virt_to_kpte(addr);

This WARN and bailing here has helped us catch an issue early before
[1] - and because KFENCE ought to be enabled as a debugging tool, the
philosophy is to be failure tolerant and not crash the system here,
hence the "return false".

[1] https://lore.kernel.org/lkml/Y3bCV6VckVUEF7Pq@elver.google.com/

We're relying on the architecture doing the "right thing", but it's
not entirely unlikely that the arch ends up doing the wrong thing due
to some bug like above (i.e. arch_kfence_init_pool() is faulty).

Nack.
