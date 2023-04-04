Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECA86D6FEF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 00:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbjDDWJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 18:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236581AbjDDWJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:09:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42963421F;
        Tue,  4 Apr 2023 15:09:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j13so32066920pjd.1;
        Tue, 04 Apr 2023 15:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680646190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhW41Lz+Mez52y9+7Sqb35hmOmVdAZ3fg2uw11nAPAE=;
        b=gUnEta5Yb6BtuCcTbAobNapAGPwc0djL/m8TaRV6zg1dmzIbN9ViSxcJdaPoUxzS4b
         lqAg8chb72IJSS+FDlhtOK8Q6TNt1dX6HhF5uUTVwsIiKbA7yXZaggFVpSNKPB/kpfG5
         UGE6OA1h2UEWP7hBlWDMJIm6VAA88W4h5iUein/TQ4pBlGSVHPr+4gtWEGZz1NccX+1O
         pzrByG745s8cPaG1Bv9BjxgAeCG+TOnfx7Zf8ZthRcuoQ7uY/PzreoHfTKIwH39L6NMf
         +ihHktT0J0n+iD3LRnqvnglDvtpJ0jraXnTyclvvFj3bOpjrIKalZFNddiclc0ueDpSP
         hxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680646190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhW41Lz+Mez52y9+7Sqb35hmOmVdAZ3fg2uw11nAPAE=;
        b=CrGrfHtBlvOjjTF4xStir0n6IHEnpwk3c3p5eO2cvlgiQBpqqsEyjqfDBMM3joe5qG
         wRZopbF0XAfy0CnoEAghgb+GkQ3ZRkk2bor9fCvOCYfhdAWAso+xFNX1nU29fbt9IA5+
         nKxWq5kCGr6inhS1j9pJrybfQwtwYqOO0LucM2SkCTFEg/Mnedk0YoXhQtR62FmH/D4f
         U+89JyTOkp1mdXLBAxMKPP8x2AInWn3BANFPxu7g00JJV0fRiAZtwR6kvzNELpQqdifj
         v5sOZ0obEfKV62ewg+7YvBUw/1fdQ74J8jtksoeCmu5I81OHtmtdwmbxF2I4p1mGfZ4L
         jC1Q==
X-Gm-Message-State: AAQBX9dY5SJI6FRkol+3Rv5sY3RsdJDF7XBcvF9TqKOr51m220K4M4XH
        aEJOX7WDa8AhcjNP8G5me1EKYZ9diAyeVLtwZrY=
X-Google-Smtp-Source: AKy350bBMyaLkYHcsUf3JTXKneddX4ZVx0+3AX9RSmsTAdcXvoVPs11LPU8Ekd9MaEE01X2e0f3RDUQs/sOmoWXiTBE=
X-Received: by 2002:a17:90b:e09:b0:240:228:95bd with SMTP id
 ge9-20020a17090b0e0900b00240022895bdmr1533929pjb.5.1680646189645; Tue, 04 Apr
 2023 15:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230404084308.813-1-zhangqing@loongson.cn>
In-Reply-To: <20230404084308.813-1-zhangqing@loongson.cn>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 5 Apr 2023 00:09:38 +0200
Message-ID: <CA+fCnZentBDXuyyrZFzPLpt8Vdfo7YyAyxbgb506LFrR+v-D9Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] kasan: Add __HAVE_ARCH_SHADOW_MAP to support arch
 specific mapping
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
> Like the LoongArch, which has many holes between different segments
> and valid address space(256T available) is insufficient to map all
> these segments to kasan shadow memory with the common formula provided
> by kasan core, We need architecture specific mapping formula,different
> segments are mapped individually, and only limited length of space of
> that specific segment is mapped to shadow.
>
> Therefore, when the incoming address is converted to a shadow, we need
> to add a condition to determine whether it is valid.
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  include/linux/kasan.h | 2 ++
>  mm/kasan/kasan.h      | 6 ++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index f7ef70661ce2..3b91b941873d 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -54,11 +54,13 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D]=
;
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
>         return (void *)(((unsigned long)shadow_addr - KASAN_SHADOW_OFFSET=
)
>                 << KASAN_SHADOW_SCALE_SHIFT);
>  }
> +#endif
>
>  static __always_inline bool addr_has_metadata(const void *addr)
>  {
> +#ifdef __HAVE_ARCH_SHADOW_MAP
> +       return (kasan_mem_to_shadow((void *)addr) !=3D NULL);
> +#else
>         return (kasan_reset_tag(addr) >=3D
>                 kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
> +#endif
>  }
>
>  /**
> --
> 2.20.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
