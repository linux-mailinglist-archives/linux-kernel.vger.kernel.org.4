Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635B570780B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjERCZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjERCZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:25:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBABA3C01
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 19:25:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49A62638BE
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD157C433D2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684376729;
        bh=BJ+zBtzidStymX1Xdsl4tnDX+vPeQYRYOTB0T2LRp38=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WCHPlaknHiGRj9rCq7F41vWTl8o2TVPqZvzvbk5putWNtJGCX/vmNJXK2lW5EO8ZZ
         9kJo1ZQSpY14g+6QnNC2+k2SClB04WQo8ful1DGFfkXR9pdJ1RVanKpfBfVGpG7+Yh
         RXuhdSKCHVXyg0LWChtiwxtHnwHyvA4SnUqB2eiRYxGpFB/K6KLpGtG/a9VIvvpp6l
         dAJ/DtABSenooroFbzCf5jBkWzuFBueeGc1TQ1UOMNX0M2//GKvYCNPEVOJZDd460w
         zKBpzltZSi9KIa7CP4Osi6uWQ4Ut8/9TnzUAGmwJ0/Kc3wboUdMqVSkcORbi4ckS+Y
         V7BL8HMeZG6rw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-510b4e488e4so2674510a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 19:25:29 -0700 (PDT)
X-Gm-Message-State: AC+VfDz9BxQURIDHTDIFkZV4GjyLj7LdSD7MP+MHQPmoCzz/G0dcQfBk
        M31Mb/YxYX55i1KnYHUa3JdGPKllCd8ck0K+fVI=
X-Google-Smtp-Source: ACHHUZ5drE9lWsneoeKrXat+THfTJNpI734MDx9OZr8skaG5GNqzYL2Tdyq+myp5Z5grM9LWYhtFo+Kn2wep9HM61Ls=
X-Received: by 2002:a17:907:2d90:b0:966:40ad:3aec with SMTP id
 gt16-20020a1709072d9000b0096640ad3aecmr36796716ejc.6.1684376727891; Wed, 17
 May 2023 19:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <1684292580-2455-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1684292580-2455-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 18 May 2023 10:25:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6wtsFX+EUqzgseNmEW7FJk4b7b_PmcxKBiYu0qdHGwJQ@mail.gmail.com>
Message-ID: <CAAhV-H6wtsFX+EUqzgseNmEW7FJk4b7b_PmcxKBiYu0qdHGwJQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Add support to clone a time namespace
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
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

Hi, Tiezhu,

The layout of vdso data (loongarch_vdso_data):

       struct vdso_pcpu_data pdata[NR_CPUS];
       struct vdso_data data[CS_BASES];

VDSO_DATA_SIZE is the page aligned size of loongarch_vdso_data, and in
memory, vdso code is above vdso data.

Then, get_vdso_base() returns the start of vdso code, and
get_vdso_data() returns the start of vdso data.

In your patch, __arch_get_timens_vdso_data() returns get_vdso_data() +
PAGE_SIZE, but you don't increase the size of loongarch_vdso_data. The
result is it returns an address in vdso code.

Now, do you know what the problem is? Or still insist that "I have tested"?

Huacai

On Wed, May 17, 2023 at 11:03=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
> When execute the following command to test clone3 on LoongArch:
>
>   # cd tools/testing/selftests/clone3 && make && ./clone3
>
> we can see the following error info:
>
>   # [5719] Trying clone3() with flags 0x80 (size 0)
>   # Invalid argument - Failed to create new process
>   # [5719] clone3() with flags says: -22 expected 0
>   not ok 18 [5719] Result (-22) is different than expected (0)
>
> This is because if CONFIG_TIME_NS is not set, but the flag
> CLONE_NEWTIME (0x80) is used to clone a time namespace, it
> will return -EINVAL in copy_time_ns().
>
> Here is the related code in include/linux/time_namespace.h:
>
>   #ifdef CONFIG_TIME_NS
>   ...
>   struct time_namespace *copy_time_ns(unsigned long flags,
>                                       struct user_namespace *user_ns,
>                                       struct time_namespace *old_ns);
>   ...
>   #else
>   ...
>   static inline
>   struct time_namespace *copy_time_ns(unsigned long flags,
>                                       struct user_namespace *user_ns,
>                                       struct time_namespace *old_ns)
>   {
>           if (flags & CLONE_NEWTIME)
>                   return ERR_PTR(-EINVAL);
>
>           return old_ns;
>   }
>   ...
>   #endif
>
> Here is the complete call stack:
>
>   clone3()
>     kernel_clone()
>       copy_process()
>         copy_namespaces()
>           create_new_namespaces()
>             copy_time_ns()
>               clone_time_ns()
>
> Because CONFIG_TIME_NS depends on GENERIC_VDSO_TIME_NS, select
> GENERIC_VDSO_TIME_NS to enable CONFIG_TIME_NS to build the real
> implementation of copy_time_ns() in kernel/time/namespace.c.
>
> Additionally, it needs to define some arch dependent functions
> such as __arch_get_timens_vdso_data(), arch_get_vdso_data() and
> vdso_join_timens(), then the failed test can be fixed.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
> This is based on 6.4-rc2
>
>  arch/loongarch/Kconfig                         |  1 +
>  arch/loongarch/include/asm/vdso/gettimeofday.h |  7 ++++++
>  arch/loongarch/kernel/vdso.c                   | 32 ++++++++++++++++++++=
++++++
>  3 files changed, 40 insertions(+)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index d38b066..93b167f 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -80,6 +80,7 @@ config LOONGARCH
>         select GENERIC_SCHED_CLOCK
>         select GENERIC_SMP_IDLE_THREAD
>         select GENERIC_TIME_VSYSCALL
> +       select GENERIC_VDSO_TIME_NS
>         select GPIOLIB
>         select HAS_IOPORT
>         select HAVE_ARCH_AUDITSYSCALL
> diff --git a/arch/loongarch/include/asm/vdso/gettimeofday.h b/arch/loonga=
rch/include/asm/vdso/gettimeofday.h
> index 7b2cd37..1af88ac 100644
> --- a/arch/loongarch/include/asm/vdso/gettimeofday.h
> +++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
> @@ -94,6 +94,13 @@ static __always_inline const struct vdso_data *__arch_=
get_vdso_data(void)
>         return get_vdso_data();
>  }
>
> +#ifdef CONFIG_TIME_NS
> +static __always_inline
> +const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_da=
ta *vd)
> +{
> +       return get_vdso_data() + PAGE_SIZE;
> +}
> +#endif
>  #endif /* !__ASSEMBLY__ */
>
>  #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
> diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
> index eaebd2e..cf62103 100644
> --- a/arch/loongarch/kernel/vdso.c
> +++ b/arch/loongarch/kernel/vdso.c
> @@ -14,6 +14,7 @@
>  #include <linux/random.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> +#include <linux/time_namespace.h>
>  #include <linux/timekeeper_internal.h>
>
>  #include <asm/page.h>
> @@ -73,6 +74,37 @@ static int __init init_vdso(void)
>  }
>  subsys_initcall(init_vdso);
>
> +#ifdef CONFIG_TIME_NS
> +struct vdso_data *arch_get_vdso_data(void *vvar_page)
> +{
> +       return (struct vdso_data *)(vvar_page);
> +}
> +
> +/*
> + * The vvar mapping contains data for a specific time namespace, so when=
 a
> + * task changes namespace we must unmap its vvar data for the old namesp=
ace.
> + * Subsequent faults will map in data for the new namespace.
> + *
> + * For more details see timens_setup_vdso_data().
> + */
> +int vdso_join_timens(struct task_struct *task, struct time_namespace *ns=
)
> +{
> +       struct mm_struct *mm =3D task->mm;
> +       struct vm_area_struct *vma;
> +
> +       VMA_ITERATOR(vmi, mm, 0);
> +
> +       mmap_read_lock(mm);
> +       for_each_vma(vmi, vma) {
> +               if (vma_is_special_mapping(vma, &vdso_info.data_mapping))
> +                       zap_vma_pages(vma);
> +       }
> +       mmap_read_unlock(mm);
> +
> +       return 0;
> +}
> +#endif
> +
>  static unsigned long vdso_base(void)
>  {
>         unsigned long base =3D STACK_TOP;
> --
> 2.1.0
>
