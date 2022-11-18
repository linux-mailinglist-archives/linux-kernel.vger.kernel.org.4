Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08EA62FB3B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241792AbiKRRKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242457AbiKRRJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:09:57 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9148C7A8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:09:56 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-39115d17f3dso49305097b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 09:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxawSV9BNIQZeeJx9upRwMR/8ffnB4z3mTZ1jlasJ1Y=;
        b=PGKf9/dcXfX1N4sRMaAOg0Y/6kgMFM8YYpQ2Oic/F+fA+0NVI9gcEKJezmxM0UHXcn
         19NJpWDiz6wA4UC0anWP/nZfjP22rWRBAdJyXm3DXkP7+I2y0Wbe47rKxeVz+z7CcyQu
         FxOjjv4aH6Ede5md+SnUa1ozhhbUbZDax8q4FTWQ0fQegKqb+i1TRNHYJPPX9xLYoSIa
         mg4tIa9URx5kxG9Y/aqxar33pAhbXwrOXi2f1zQ0+gJYpOPsa7zYc6Y1sylAHz/xR2Q5
         7ExEqnAJT7GNHjej/u8707uahPQqGa6VJSoah9Xq9A9QP+nr1h4O0BGH+ja36jS+jGQu
         MW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxawSV9BNIQZeeJx9upRwMR/8ffnB4z3mTZ1jlasJ1Y=;
        b=5qkm38xHgPA+60hA1iIh/ay6Og5lzoz6jc1wTuVh68PV4zamL51SpT24dYx7BuafnZ
         Uy0aK3XEonfqNnqy9vKLHsl+IHotpAEk0NQX2o6DwIBVTiQHLFiSBA/VBLnOT9XowLAI
         z3IaLMWmHaoMPsMIKx6r5gMcnbnDRvdxEephnvdHNXgQNFRoaRtFxMP3FpZqlTNVXx05
         a2DKfgfh6Ey5/4LUjPdwHEmtTzMkS5oH6ce4Ruq12ek7d2T/miY1PqZ+2yOkLcTGcyGr
         9PKaCZPqxaV+tfeyLy+hEwgA1Rn9mjkj5HO0Qf/auzRFiqzsPLavfUXZpi8W6yYWFJH0
         +2nA==
X-Gm-Message-State: ANoB5pm2IRtXsZh6m6LKwPQzUsUelqR6hsULA7S4e0t5J9Ou7GW+jmpz
        mTzJF6lCDAsUUFo+cPcL/J3kAwL8QVxxVXHkdjrMYg==
X-Google-Smtp-Source: AA0mqf4FHxUUR1YkxODcprEfAmZBUfUyZIs7c1ZVUFPUr7P1AN28uDhWD0aZn8wNr+5LiUEG0bTKV9kF/+kEiaIXBtg=
X-Received: by 2002:a81:dd05:0:b0:36e:8228:a127 with SMTP id
 e5-20020a81dd05000000b0036e8228a127mr7429659ywn.299.1668791395464; Fri, 18
 Nov 2022 09:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20221118152216.3914899-1-elver@google.com>
In-Reply-To: <20221118152216.3914899-1-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 18 Nov 2022 18:09:19 +0100
Message-ID: <CAG_fn=XGY6npNhVwK76zSZzYC61=7-8ag3Jcey4PXa46E1ee-A@mail.gmail.com>
Subject: Re: [PATCH] kfence: fix stack trace pruning
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Feng Tang <feng.tang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 4:22 PM Marco Elver <elver@google.com> wrote:
>
> Commit b14051352465 ("mm/sl[au]b: generalize kmalloc subsystem")
> refactored large parts of the kmalloc subsystem, resulting in the stack
> trace pruning logic done by KFENCE to no longer work.
>
> While b14051352465 attempted to fix the situation by including
> '__kmem_cache_free' in the list of functions KFENCE should skip through,
> this only works when the compiler actually optimized the tail call from
> kfree() to __kmem_cache_free() into a jump (and thus kfree() _not_
> appearing in the full stack trace to begin with).
>
> In some configurations, the compiler no longer optimizes the tail call
> into a jump, and __kmem_cache_free() appears in the stack trace. This
> means that the pruned stack trace shown by KFENCE would include kfree()
> which is not intended - for example:
>
>  | BUG: KFENCE: invalid free in kfree+0x7c/0x120
>  |
>  | Invalid free of 0xffff8883ed8fefe0 (in kfence-#126):
>  |  kfree+0x7c/0x120
>  |  test_double_free+0x116/0x1a9
>  |  kunit_try_run_case+0x90/0xd0
>  | [...]
>
> Fix it by moving __kmem_cache_free() to the list of functions that may
> be tail called by an allocator entry function, making the pruning logic
> work in both the optimized and unoptimized tail call cases.
>
> Fixes: b14051352465 ("mm/sl[au]b: generalize kmalloc subsystem")
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: Feng Tang <feng.tang@intel.com>
> Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  mm/kfence/report.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> index 7e496856c2eb..46ecea18c4ca 100644
> --- a/mm/kfence/report.c
> +++ b/mm/kfence/report.c
> @@ -75,18 +75,23 @@ static int get_stack_skipnr(const unsigned long stack=
_entries[], int num_entries
>
>                 if (str_has_prefix(buf, ARCH_FUNC_PREFIX "kfence_") ||
>                     str_has_prefix(buf, ARCH_FUNC_PREFIX "__kfence_") ||
> +                   str_has_prefix(buf, ARCH_FUNC_PREFIX "__kmem_cache_fr=
ee") ||
>                     !strncmp(buf, ARCH_FUNC_PREFIX "__slab_free", len)) {
>                         /*
> -                        * In case of tail calls from any of the below
> -                        * to any of the above.
> +                        * In case of tail calls from any of the below to=
 any of
> +                        * the above, optimized by the compiler such that=
 the
> +                        * stack trace would omit the initial entry point=
 below.
>                          */
>                         fallback =3D skipnr + 1;
>                 }
>
> -               /* Also the *_bulk() variants by only checking prefixes. =
*/
> +               /*
> +                * The below list should only include the initial entry p=
oints
> +                * into the slab allocators. Includes the *_bulk() varian=
ts by
> +                * checking prefixes.
> +                */
>                 if (str_has_prefix(buf, ARCH_FUNC_PREFIX "kfree") ||
>                     str_has_prefix(buf, ARCH_FUNC_PREFIX "kmem_cache_free=
") ||
> -                   str_has_prefix(buf, ARCH_FUNC_PREFIX "__kmem_cache_fr=
ee") ||
>                     str_has_prefix(buf, ARCH_FUNC_PREFIX "__kmalloc") ||
>                     str_has_prefix(buf, ARCH_FUNC_PREFIX "kmem_cache_allo=
c"))
>                         goto found;
> --
> 2.38.1.584.g0f3c55d4c2-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
