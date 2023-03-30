Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8886CF955
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 04:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjC3C4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 22:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjC3C4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 22:56:18 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81475B92;
        Wed, 29 Mar 2023 19:56:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o11so16839932ple.1;
        Wed, 29 Mar 2023 19:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680144968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcIEVyxOQ9ThEvdTZ3QimlrlYxsMccblwZq0nJEQf8Q=;
        b=Zec5lJk4rXTCbA+qbB6XLLMkQsH0baL9XmFKOIVsa6DGOJodAy/QjlUIPA+YuJnisG
         BLviy5bd66/mXjAw691bc1vI4BTemWYukYKjCZ1+jPr0XjLytUY1NT/zNqXehvPbHQ60
         u//4jHceldp9UErdH8WTE+kZplg5WaFpToTSV3UlAnqAe5F6GUY6hMTMdwhuQqDTtOD2
         u3vm2zcCg1Kk0SMP5H8FbNCOoU5dUs/LXyL76kqX2uLO96d7wuz5Ri66atDLcCfotByZ
         DA0qxNlVVaf2BFurz3bXwPR7biZ4WJlZrmKAdrpggFJhgH5bTzqvysSpK1iQKoTWivaM
         qsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680144968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcIEVyxOQ9ThEvdTZ3QimlrlYxsMccblwZq0nJEQf8Q=;
        b=tr4QwdFFNZ7nHi4Sm7fWTmgC1N5kzBuGW+fVbTF9xBImrdqj8NRC/7WoGaR494I0y4
         TWuVjMBuDmFiKl0Xf1WjUWDyfvOqNw9cYO32vlNHC5p8G3thMGcvAYG0Or6KqW3OgWdb
         O6TgkqBEsPh22Wvhxln47/whqkEeyJ13RLUC9xw0yh4C+rQ5r+VLDAu0kINjM4hciMP2
         5qoFpZ7Z6vd+AGFQjLxJFklOFn7e9CZZ1sUeKeRS2fnT4FsF6rX+2+WWwVQDDanWXw10
         ifJ8031KC9+l/BxKgB/5m6fpLFIDnwB/zjWIYgsmcXzsmwGSIFg1Km4z9V/gjoPE9aAr
         lLxg==
X-Gm-Message-State: AAQBX9cRtKI8jKuhBtokaugSlidtpitpTqq6E8CdIj2w4glF5pSNyhI3
        aPFUyxbAnIuiuL9+mLI4SFRxINjOvp9SPv7QEgQ=
X-Google-Smtp-Source: AKy350aaSitWK+oMnPBGI/HdGFv4oj337IShewGHsQKImjbS99hwBRaF/179UbwYduEu4LT8WrbvDdBJHlGFglrepNY=
X-Received: by 2002:a17:902:ecc2:b0:1a0:7630:8ef1 with SMTP id
 a2-20020a170902ecc200b001a076308ef1mr8673024plh.11.1680144968218; Wed, 29 Mar
 2023 19:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230328111714.2056-1-zhangqing@loongson.cn> <CA+fCnZevgYh7CzJ9gOWJ80SwY4Y9w8UO2ZiFAXEnAhQhFgrffA@mail.gmail.com>
 <dccfbff3-7bad-de33-4d96-248bdff44a8b@loongson.cn>
In-Reply-To: <dccfbff3-7bad-de33-4d96-248bdff44a8b@loongson.cn>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 30 Mar 2023 04:55:57 +0200
Message-ID: <CA+fCnZddt50+10SZ+hZRKBudsmMF0W9XpsDG6=58p1ot62LjXQ@mail.gmail.com>
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

On Thu, Mar 30, 2023 at 4:06=E2=80=AFAM Qing Zhang <zhangqing@loongson.cn> =
wrote:
>
> > But I don't think you need this check here at all: addr_has_metadata
> > already checks that shadow exists.
> >
> On LongArch, there's a lot of holes between different segments, so kasan
> shadow area is some different type of memory that we concatenate, we
> can't use if (unlikely((void *)addr <
> kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) to determine the
> validity, and in arch/loongarch/include/asm/kasan.h I construct invalid
> NULL.

I get that, but you already added a special case for
__HAVE_ARCH_SHADOW_MAP to addr_has_metadata, so you can just call it?

> This is because in pagetable_init on loongarch/mips, we populate pmd/pud
> with invalid_pmd_table/invalid_pud_table,

I see. Please add this into the patch description for v2.

> So pmd_init/pud_init(p) is required, perhaps we define them as __weak in
> mm/kasan/init.c, like mm/sparse-vmemmap.c.

Yes, this makes sense to do, so that KASAN doesn't depend on
definitions from sparse-vmemmap.c.

Thank you!
