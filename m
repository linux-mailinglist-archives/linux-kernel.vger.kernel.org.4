Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D319F64DECE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiLOQkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiLOQkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:40:15 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD06321815
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:40:14 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3bfd998fa53so49419947b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBOt4KcrarpWydqrKFp23ubFDXFtAbXyQ+q3FgCY+PA=;
        b=QKXMNonQ8i0fyU4xehjoDjk2DUuoNMKpJHO8W7X8UkgB6hS4XA9SgQzy3PUCXjdLOU
         UxR6lys7JDFJFnBcm5h299Zab6/oQLArmRYhio0zu0oufng2tHRSYDvqLtZ6OAPL+P1P
         lwOPxlHQGc2/r6jQP8rBVj8uzwRVca+T/IdhMiBt8+k2aqnmylFQKhxdvhjWbHCzbnX4
         2/xQT++/Aso+oK/kVkjsgEH8EOO6SwEY8jMwK8LbI3ttWlPwLFUF9IcZth7j0EexJUsc
         bgD69mm5XDk52QPuoC1QcWs5KQvul1VDejS81MKWJpI46zT7lFMl7RRuquZpx9/m5bWq
         xHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBOt4KcrarpWydqrKFp23ubFDXFtAbXyQ+q3FgCY+PA=;
        b=Il6Ie1MgL0y3hgjHlPEB3hxAlpOgRZ5TJUDSTU/++nCtnU2ktWgzXlVYuCfMm0XF8K
         Ta7GrpSL2TwIxuYXfbjtl/gJe5BP8y0wBeEBlumbfppbp4YPXbTeZa09Hrzn6klmflAc
         OjYWoEtm2sgzmEeDdL7b9xhbtmMVqYwdadnktyejl9Bto9VDgCiy+ThkNuafnruN4+t4
         4Z+3n8bONBlRO8tv2D4UD6nIinDabBQX0f5HcTrPBA5OW38O86e63PMXA8usWmLdkebe
         hjZWFeSh5kF6GNCt3cbgpn753mP6C3YbSS2mU56zHfD1S98PhzIt8NpkW8MMktLSUzgQ
         hOpg==
X-Gm-Message-State: ANoB5plugWyeYsylupkh5sDFAzTip3r4ScuMY0hwsEgfc2vhGfReN/14
        aKvxMgYmDtw8/CSLFL57RFwfUFSE2whdoJoNwoo0CA==
X-Google-Smtp-Source: AA0mqf4qgRWPq5BatTHSD9uguCzYBvjL7BziGgbwJZElcnn5yJ3KD8a/ySs38cRWggvES1WWi1X43mKy+d7ZzwNhm8s=
X-Received: by 2002:a0d:d40e:0:b0:367:23bc:6087 with SMTP id
 w14-20020a0dd40e000000b0036723bc6087mr28375393ywd.428.1671122413726; Thu, 15
 Dec 2022 08:40:13 -0800 (PST)
MIME-Version: 1.0
References: <20221215163046.4079767-1-arnd@kernel.org>
In-Reply-To: <20221215163046.4079767-1-arnd@kernel.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 15 Dec 2022 17:39:37 +0100
Message-ID: <CAG_fn=W6TfkPiv57aFEizsmyA9NLGdPa4_CczrSd8dFsL_xSyQ@mail.gmail.com>
Subject: Re: [PATCH] kmsan: include linux/vmalloc.h
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Thu, Dec 15, 2022 at 5:30 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This is needed for the vmap/vunmap declarations:
>
> mm/kmsan/kmsan_test.c:316:9: error: implicit declaration of function 'vma=
p' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
>         vbuf =3D vmap(pages, npages, VM_MAP, PAGE_KERNEL);
>                ^
> mm/kmsan/kmsan_test.c:316:29: error: use of undeclared identifier 'VM_MAP=
'
>         vbuf =3D vmap(pages, npages, VM_MAP, PAGE_KERNEL);
>                                    ^
> mm/kmsan/kmsan_test.c:322:3: error: implicit declaration of function 'vun=
map' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
>                 vunmap(vbuf);
>                 ^
>
> Fixes: 8ed691b02ade ("kmsan: add tests for KMSAN")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  mm/kmsan/kmsan_test.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
> index eb44ef3c5f29..088e21a48dc4 100644
> --- a/mm/kmsan/kmsan_test.c
> +++ b/mm/kmsan/kmsan_test.c
> @@ -22,6 +22,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/string.h>
>  #include <linux/tracepoint.h>
> +#include <linux/vmalloc.h>
>  #include <trace/events/printk.h>
>
>  static DEFINE_PER_CPU(int, per_cpu_var);
> --
> 2.35.1
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
