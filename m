Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FA76D5BDD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbjDDJZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjDDJZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:25:56 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EB01981
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:25:55 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id z83so37891474ybb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 02:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680600354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zj3a2MYNbkCFssTfjIF9gvNI8FfTYBgR4BuPPz6nhXc=;
        b=Ha74+lmMeivYh1u52QynjkWeG4fZIvyvw5HbjOIl67pwttzzwsJRqoDCmgvBST0gSd
         t4xqbw/tOMXsDwNloimeFslTRB23JNDJBtfWisNxDkyEP89qW+oSLRsr85GoQZtR4O8c
         q/uiXk0IkCZNR6pRJGaP+c1VdbBqUlUNY1WueQTEQNxedWErjfokrxUpyowfwo1zorEJ
         dUz7cIBeevTrkBs1ry0oFrc3zTGoGKtN4RDuiDR8QWguHCTA0rK2Pb+pP+mHgSOoRIJa
         /EIsXmc34JWIO/CyUzV1+Dy78Svopna5l8JFjcMlvUMPszjQkck4DtS6hT+0PnKNa9TG
         wmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680600354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zj3a2MYNbkCFssTfjIF9gvNI8FfTYBgR4BuPPz6nhXc=;
        b=qXoBLPl1tsRuIZYrBMuKOR6/CLGoIrq9CQD58Cbvc3gVqzlqF+teokmTanseuaHyZQ
         HgK26LRR3bJMWklNdD3N3AMyow143NdQYLEmWYYcOeh4KHoGSANyiQn0bnER5u5iFT3X
         xnSX9pv3wNwt0Yf5qCE/E9ocDb+NsacrlSK/QPe0CSHoQ3XkLYu05FskueEM4auv8tp/
         jld/OJUmvnhTVLrMPqx+K04vPGHYjaTdMg14sngiYc3u8i8Z6/P32wEQNw+9WZ26AXVA
         NKkpoeh2BsrONKVSlO/74pvXIDDKQa7lkH+fBQu+1LI9SN8yEe4XEsEArlOVZ9Rx3PK+
         2cKw==
X-Gm-Message-State: AAQBX9e37JVyAdcZLTEhaN4plcYcTS0csJizKBLUa4RFY6R+ov4231Tn
        hjxOxgLk+AlT6dsVsf2esypIZXhkkKTZpQbp5VNWEw==
X-Google-Smtp-Source: AKy350bUM9iWWLmPvON6nK7eho1YZvuR/HHQO7bShb1xj8yL6HbUpBmDvFZoTxGfH3EhHB31k2ylPOisedybJpfhqlM=
X-Received: by 2002:a25:2605:0:b0:b87:8580:ee37 with SMTP id
 m5-20020a252605000000b00b878580ee37mr2158593ybm.60.1680600354405; Tue, 04 Apr
 2023 02:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230403122738.6006-1-zhangpeng.00@bytedance.com>
In-Reply-To: <20230403122738.6006-1-zhangpeng.00@bytedance.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 4 Apr 2023 11:25:17 +0200
Message-ID: <CAG_fn=UEah3DLYm2yKxBKg=L=Qc_PSnrKhZ2==snbw05XAtVZQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: kfence: Improve the performance of
 __kfence_alloc() and __kfence_free()
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     elver@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

> +static inline void check_canary(const struct kfence_metadata *meta)
> +{
> +       const unsigned long pageaddr =3D ALIGN_DOWN(meta->addr, PAGE_SIZE=
);
> +       unsigned long addr =3D pageaddr;
>
>         /*
> -        * We'll iterate over each canary byte per-side until fn() return=
s
> -        * false. However, we'll still iterate over the canary bytes to t=
he
> +        * We'll iterate over each canary byte per-side until a corrupted=
 byte
> +        * is found. However, we'll still iterate over the canary bytes t=
o the
>          * right of the object even if there was an error in the canary b=
ytes to
>          * the left of the object. Specifically, if check_canary_byte()
>          * generates an error, showing both sides might give more clues a=
s to
> @@ -339,16 +348,35 @@ static __always_inline void for_each_canary(const s=
truct kfence_metadata *meta,
>          */
>
>         /* Apply to left of object. */
> -       for (addr =3D pageaddr; addr < meta->addr; addr++) {
> -               if (!fn((u8 *)addr))
> +       for (; meta->addr - addr >=3D sizeof(u64); addr +=3D sizeof(u64))=
 {
> +               if (unlikely(*((u64 *)addr) !=3D KFENCE_CANARY_PATTERN_U6=
4))
>                         break;
>         }
I am confused. Right now this loop either runs from pageaddr to
meta_addr if there's no corruption, or breaks at the first corrupted
byte.
Regardless of that, we are applying check_canary_byte() to every byte
of that range in the following loop.
Shouldn't the two be nested, like in the case of the canary bytes to
the right of the object?


>
> -       /* Apply to right of object. */
> -       for (addr =3D meta->addr + meta->size; addr < pageaddr + PAGE_SIZ=
E; addr++) {
> -               if (!fn((u8 *)addr))
> +       /*
> +        * If the canary is corrupted in a certain 64 bytes, or the canar=
y
> +        * memory cannot be completely covered by multiple consecutive 64=
 bytes,
> +        * it needs to be checked one by one.
> +        */
> +       for (; addr < meta->addr; addr++) {
> +               if (unlikely(!check_canary_byte((u8 *)addr)))
>                         break;
>         }
> +
> +       /* Apply to right of object. */
> +       for (addr =3D meta->addr + meta->size; addr % sizeof(u64) !=3D 0;=
 addr++) {
> +               if (unlikely(!check_canary_byte((u8 *)addr)))
> +                       return;
> +       }
> +       for (; addr - pageaddr < PAGE_SIZE; addr +=3D sizeof(u64)) {
> +               if (unlikely(*((u64 *)addr) !=3D KFENCE_CANARY_PATTERN_U6=
4)) {
> +
> +                       for (; addr - pageaddr < PAGE_SIZE; addr++) {
> +                               if (!check_canary_byte((u8 *)addr))
> +                                       return;
> +                       }
> +               }
> +       }
>  }
>
>  static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size,=
 gfp_t gfp,
> @@ -434,7 +462,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *=
cache, size_t size, gfp_t g
>  #endif
>
>         /* Memory initialization. */
> -       for_each_canary(meta, set_canary_byte);
> +       set_canary(meta);
>
>         /*
>          * We check slab_want_init_on_alloc() ourselves, rather than lett=
ing
> @@ -495,7 +523,7 @@ static void kfence_guarded_free(void *addr, struct kf=
ence_metadata *meta, bool z
>         alloc_covered_add(meta->alloc_stack_hash, -1);
>
>         /* Check canary bytes for memory corruption. */
> -       for_each_canary(meta, check_canary_byte);
> +       check_canary(meta);
>
>         /*
>          * Clear memory if init-on-free is set. While we protect the page=
, the
> @@ -751,7 +779,7 @@ static void kfence_check_all_canary(void)
>                 struct kfence_metadata *meta =3D &kfence_metadata[i];
>
>                 if (meta->state =3D=3D KFENCE_OBJECT_ALLOCATED)
> -                       for_each_canary(meta, check_canary_byte);
> +                       check_canary(meta);
>         }
>  }
>
> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> index 600f2e2431d6..2aafc46a4aaf 100644
> --- a/mm/kfence/kfence.h
> +++ b/mm/kfence/kfence.h
> @@ -21,7 +21,15 @@
>   * lower 3 bits of the address, to detect memory corruptions with higher
>   * probability, where similar constants are used.
>   */
> -#define KFENCE_CANARY_PATTERN(addr) ((u8)0xaa ^ (u8)((unsigned long)(add=
r) & 0x7))
> +#define KFENCE_CANARY_PATTERN_U8(addr) ((u8)0xaa ^ (u8)((unsigned long)(=
addr) & 0x7))
> +
> +/*
> + * Define a continuous 8-byte canary starting from a multiple of 8. The =
canary
> + * of each byte is only related to the lowest three bits of its address,=
 so the
> + * canary of every 8 bytes is the same. 64-bit memory can be filled and =
checked
> + * at a time instead of byte by byte to improve performance.
> + */
> +#define KFENCE_CANARY_PATTERN_U64 ((u64)0xaaaaaaaaaaaaaaaa ^ (u64)(0x070=
6050403020100))
>
>  /* Maximum stack depth for reports. */
>  #define KFENCE_STACK_DEPTH 64
> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> index 60205f1257ef..197430a5be4a 100644
> --- a/mm/kfence/report.c
> +++ b/mm/kfence/report.c
> @@ -168,7 +168,7 @@ static void print_diff_canary(unsigned long address, =
size_t bytes_to_show,
>
>         pr_cont("[");
>         for (cur =3D (const u8 *)address; cur < end; cur++) {
> -               if (*cur =3D=3D KFENCE_CANARY_PATTERN(cur))
> +               if (*cur =3D=3D KFENCE_CANARY_PATTERN_U8(cur))
>                         pr_cont(" .");
>                 else if (no_hash_pointers)
>                         pr_cont(" 0x%02x", *cur);
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kasan-dev/20230403122738.6006-1-zhangpeng.00%40bytedance.com.



--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
