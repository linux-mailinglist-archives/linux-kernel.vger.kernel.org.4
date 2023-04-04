Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE126D6FEB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 00:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbjDDWJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 18:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbjDDWJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:09:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046BB2D4B;
        Tue,  4 Apr 2023 15:09:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so35410082pjz.1;
        Tue, 04 Apr 2023 15:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680646170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypW3uCkatd85laSwJoEHyhvz6A6Q9ytym+XuTNT93dU=;
        b=JoPIXnG83ROdZ1kq4xk1n+ZIq8MPvMAtV87d4GO9cK1Ht5tNTGA78J92/9fyfQ8qOz
         zOkXvSQyi0fCdcUqwDCF1aySQtYSj47zHGZnMA6yXhwZv9AQyrF4VswADo/gInOgv8cV
         EDAQSv8DIu5lKaQgYKo3yqqGWLmwn21LgwsYD2Hyci1hzAh6UsJvZJCr+689gc8dKlqn
         eS1k5e6m5h04Bp+/UQ/F13SBvUKzlkK5oXRvgxzxk3Kk5KyPaC5gueNPmztxsO+0cjDR
         KyU54efHq5YIukhd5Dzmoy4gKq97Wol87Sn4yfXNtziL0Ij6a9VFiH9OrZ1WyDfc4cc6
         lwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680646170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypW3uCkatd85laSwJoEHyhvz6A6Q9ytym+XuTNT93dU=;
        b=hI+WXQpcrNmGUXSy6/l80cLBs2s8yvweemGmdIbpblnGLkS5dPInQpkF7LR5+QWtzk
         C3SscGx5peHymdT02Mah7xeilIFQlbtuqGyZpJUrG/fYnXsOTTNgZ3VKAQm/Ks4w9Xyi
         +Dk5yj68GgaNDNPT8UJ5Cfa3ZxXRxv5zACLQp8fqt0b/IsX9qzaVVL5a0BDD2iH8dfhH
         m39s5llClKnW5Y407C/sJM4j66i6mwRJ48nYjI51ZYyHLa98coKzXyfFQu9dCzqj2oVW
         WvJseYoNIOfjy+eOqiIxKHAxqpXjkaXhvEEb5b/gU+U6v/gLGyQ1lLfvFlxzsW+Sy3RF
         waOA==
X-Gm-Message-State: AAQBX9fTDw/lqE/9LymvHGi0QRAlUo1YNZc+U7eGKDyoO4K0nD1I/EON
        7cPgTzGKCu/trLXwZAfwG5p8AkkkigfLAcmBbsw=
X-Google-Smtp-Source: AKy350auMB5aAW5vcPRu5Z3zk0kCG0J70wFTxHDdx38zTGhfy79hnQwCL23EHjo5fAbzVlHyZYpeRiAzV27aaZOYeGI=
X-Received: by 2002:a17:902:8604:b0:1a0:48ff:539c with SMTP id
 f4-20020a170902860400b001a048ff539cmr1636900plo.11.1680646170341; Tue, 04 Apr
 2023 15:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230404084308.813-1-zhangqing@loongson.cn> <20230404084308.813-2-zhangqing@loongson.cn>
In-Reply-To: <20230404084308.813-2-zhangqing@loongson.cn>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 5 Apr 2023 00:09:19 +0200
Message-ID: <CA+fCnZf-segLxa3QxStd6v15ZCge=3=3rOL-9Q_eMc-y2j1nhg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] kasan: Add (pmd|pud)_init for LoongArch
 zero_(pud|p4d)_populate process
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 10:43=E2=80=AFAM Qing Zhang <zhangqing@loongson.cn> =
wrote:
>
> Loongarch populate pmd/pud with invalid_pmd_table/invalid_pud_table in
> pagetable_init, So pmd_init/pud_init(p) is required, define them as __wea=
k
> in mm/kasan/init.c, like mm/sparse-vmemmap.c.
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  mm/kasan/init.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index cc64ed6858c6..a7fa223b96e4 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -139,6 +139,10 @@ static int __ref zero_pmd_populate(pud_t *pud, unsig=
ned long addr,
>         return 0;
>  }
>
> +void __weak __meminit pmd_init(void *addr)
> +{
> +}
> +
>  static int __ref zero_pud_populate(p4d_t *p4d, unsigned long addr,
>                                 unsigned long end)
>  {
> @@ -166,8 +170,9 @@ static int __ref zero_pud_populate(p4d_t *p4d, unsign=
ed long addr,
>                                 if (!p)
>                                         return -ENOMEM;
>                         } else {
> -                               pud_populate(&init_mm, pud,
> -                                       early_alloc(PAGE_SIZE, NUMA_NO_NO=
DE));
> +                               p =3D early_alloc(PAGE_SIZE, NUMA_NO_NODE=
);
> +                               pmd_init(p);
> +                               pud_populate(&init_mm, pud, p);
>                         }
>                 }
>                 zero_pmd_populate(pud, addr, next);
> @@ -176,6 +181,10 @@ static int __ref zero_pud_populate(p4d_t *p4d, unsig=
ned long addr,
>         return 0;
>  }
>
> +void __weak __meminit pud_init(void *addr)
> +{
> +}
> +
>  static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
>                                 unsigned long end)
>  {
> @@ -207,8 +216,9 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsign=
ed long addr,
>                                 if (!p)
>                                         return -ENOMEM;
>                         } else {
> -                               p4d_populate(&init_mm, p4d,
> -                                       early_alloc(PAGE_SIZE, NUMA_NO_NO=
DE));
> +                               p =3D early_alloc(PAGE_SIZE, NUMA_NO_NODE=
);
> +                               pud_init(p);
> +                               p4d_populate(&init_mm, p4d, p);
>                         }
>                 }
>                 zero_pud_populate(p4d, addr, next);
> --
> 2.20.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
