Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B280B6CF2AA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjC2TCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjC2TCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:02:51 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEC74C2C;
        Wed, 29 Mar 2023 12:02:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso4405923pjc.1;
        Wed, 29 Mar 2023 12:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680116570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rysh7R9x0DwpV/wCJCeDcK+KSngeOrcjw+kFGG6R2os=;
        b=U//sM9A7XL/kcpEYXKup4m2J/Sp3DBWPcq+cj4HsJc7+dUi9AsjU02Lwq3JoL1NQmq
         ismSymj4IoQJ4VYIXTTfXj4IhuTC9V8imTeRJJl8wtp+cLMVycZbZpe5adelriSCB34Z
         5JRPjQUp4XUV1p1ZJpj8FcgAadV1Nt3xAimI5KHOUF00ILkLWslBnB0DEXYGfhDpjDhs
         aIvCu/RV/2Kg07dVMVnAXRKweMCcgh7xxmTEuGKD2hPrODR6SjG1EW0qSYoJJ5V2d+iM
         usSHbr1+aiPi29yP82LVwaPfhD1cK7k46uCFb9ZLK21U4JbQEzxGF/pBiIfUsLTD3aFK
         EHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680116570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rysh7R9x0DwpV/wCJCeDcK+KSngeOrcjw+kFGG6R2os=;
        b=xEKQi/JXwz042lnfShalNSPDnl0ITm6qaK7R9b95prUQesvtl1M8O1ue7JZvSllaOx
         lHYGMRPNdh5F4/8e8RNMJqD94OvfFwq+kUylzh/GtuzAqP3+pVkVyyFJWTjyJYzQlUtI
         P0c4lY+ZT1h5/e6vMVTrexOV1nLXwEpRzV1+HiJnoBSUkG2B2IUhnJFOkMc2JugonqIx
         XaKOVpuXd+BckYo5K8oASt/gFwX+EVRUJopfHjjLY68oumG7kYwLUv/iEXwYNJP5IDiW
         VlY7x56mJpPeA8ctMqqJVq5j3XSja/JkrZzh/ZPJBL6z0jMLRUaiN7N8ozwglkEBeHVf
         VlIg==
X-Gm-Message-State: AAQBX9d+Gx9guwGzUYPo1EC137MnR8rFmpAziBPDHA+dNRsbT3UihVfD
        vDv6eJpbX7U/sMaGw7z2gLnzvxYUPIRwIBJsD34=
X-Google-Smtp-Source: AKy350a8ZyVGR+YsV1iqviDdiXUJrnHDdWNYLxQJ15oR6ir8sjH7TDn0yq8OS/FxjL5RmpSszu69Red3FULJ3Z/k/d4=
X-Received: by 2002:a17:902:c213:b0:199:49d7:cead with SMTP id
 19-20020a170902c21300b0019949d7ceadmr7378827pll.11.1680116570333; Wed, 29 Mar
 2023 12:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230328111714.2056-1-zhangqing@loongson.cn>
In-Reply-To: <20230328111714.2056-1-zhangqing@loongson.cn>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 29 Mar 2023 21:02:39 +0200
Message-ID: <CA+fCnZevgYh7CzJ9gOWJ80SwY4Y9w8UO2ZiFAXEnAhQhFgrffA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add kernel address sanitizer support
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index f7ef70661ce2..3b91b941873d 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -54,11 +54,13 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
>  int kasan_populate_early_shadow(const void *shadow_start,
>                                 const void *shadow_end);
>
> +#ifndef __HAVE_ARCH_SHADOW_MAP
>  static inline void *kasan_mem_to_shadow(const void *addr)
>  {
>         return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
>                 + KASAN_SHADOW_OFFSET;
>  }
> +#endif
>
>  int kasan_add_zero_shadow(void *start, unsigned long size);
>  void kasan_remove_zero_shadow(void *start, unsigned long size);
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index e5eef670735e..f86194750df5 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -175,6 +175,11 @@ static __always_inline bool check_region_inline(unsigned long addr,
>         if (unlikely(!addr_has_metadata((void *)addr)))
>                 return !kasan_report(addr, size, write, ret_ip);
>
> +#ifndef __HAVE_ARCH_SHADOW_MAP
> +       if (unlikely(kasan_mem_to_shadow((unsigned long *)addr) == NULL))
> +               return !kasan_report(addr, size, write, ret_ip);
> +#endif

This should have been ifdef, right?

But I don't think you need this check here at all: addr_has_metadata
already checks that shadow exists.

> +
>         if (likely(!memory_is_poisoned(addr, size)))
>                 return true;
>
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index cc64ed6858c6..860061a22ca9 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -166,8 +166,9 @@ static int __ref zero_pud_populate(p4d_t *p4d, unsigned long addr,
>                                 if (!p)
>                                         return -ENOMEM;
>                         } else {
> -                               pud_populate(&init_mm, pud,
> -                                       early_alloc(PAGE_SIZE, NUMA_NO_NODE));
> +                               p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
> +                               pmd_init(p);
> +                               pud_populate(&init_mm, pud, p);
>                         }
>                 }
>                 zero_pmd_populate(pud, addr, next);
> @@ -207,8 +208,9 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
>                                 if (!p)
>                                         return -ENOMEM;
>                         } else {
> -                               p4d_populate(&init_mm, p4d,
> -                                       early_alloc(PAGE_SIZE, NUMA_NO_NODE));
> +                               p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
> +                               pud_init(p);
> +                               p4d_populate(&init_mm, p4d, p);

Please explain why these changes are needed in the patch description.

>                         }
>                 }
>                 zero_pud_populate(p4d, addr, next);
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index a61eeee3095a..033335c13b25 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -291,16 +291,22 @@ struct kasan_stack_ring {
>
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>
> +#ifndef __HAVE_ARCH_SHADOW_MAP
>  static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
>  {
>         return (void *)(((unsigned long)shadow_addr - KASAN_SHADOW_OFFSET)
>                 << KASAN_SHADOW_SCALE_SHIFT);
>  }
> +#endif
>
>  static __always_inline bool addr_has_metadata(const void *addr)
>  {
> +#ifdef __HAVE_ARCH_SHADOW_MAP
> +       return (kasan_mem_to_shadow((void *)addr) != NULL);
> +#else
>         return (kasan_reset_tag(addr) >=
>                 kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
> +#endif
>  }
>
>  /**
> --
> 2.20.1
>
