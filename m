Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453666D74BF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 08:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbjDEGwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 02:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjDEGwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:52:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE4C3A8E;
        Tue,  4 Apr 2023 23:52:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA0F0622C7;
        Wed,  5 Apr 2023 06:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCC7C433B0;
        Wed,  5 Apr 2023 06:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680677557;
        bh=XUuQ7Bb4fmNGW4BDO3pXmRn2zVkwWZkSaUU2boHvL/M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lkT4mgj2agKQd29h+FxK0YhPn8c6UtfOswmOyb6crEefOooUhJPp0ZN6HKwz7n0Rc
         Xi4Sq8YwJOWswjT0ihPhVUEaAKhw/lvD4AZgZyduhRzIdvrbgZo20pcFr6z/zfli6A
         LejdkVLtw+4Kwp8zZJQSPnsIXcXD31u03m6zZooDEdVO4KIU1obmny/HMw8przOfmH
         o986LodMYnqZGJDK8/UhoIphMjw1poxwqr4HbzaoGu75cB8uAoWUmNrPiuUV/hwkfb
         GdMKKJtaJK1OcSRpbB6iZv2+TO3Bb9aGYs18l2bHa/hVkA1FxBtcNuZaLxO1kBux2J
         fodldYHrBFbCg==
Received: by mail-lj1-f176.google.com with SMTP id by14so17109769ljb.12;
        Tue, 04 Apr 2023 23:52:37 -0700 (PDT)
X-Gm-Message-State: AAQBX9fWyBKDawOBEZ48qHe/af/h1CQvzQuLYwBxJ0y9ZGVVakhdnMlK
        /pEJSJKIB64+tJ26SExGBIITpDMrawnFkUREDN4=
X-Google-Smtp-Source: AKy350aa78EAvutnWbkk9TEc9gO1+JVmLRwUFOt3Os/WhAUHxKCINpMoAa+2knzygX+VpzhYgUBDyPuAB4qZd3UbvI0=
X-Received: by 2002:a2e:824a:0:b0:299:b5e6:4c45 with SMTP id
 j10-20020a2e824a000000b00299b5e64c45mr1866847ljh.5.1680677554868; Tue, 04 Apr
 2023 23:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230405022702.753323-1-mcgrof@kernel.org> <20230405022702.753323-2-mcgrof@kernel.org>
In-Reply-To: <20230405022702.753323-2-mcgrof@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 4 Apr 2023 23:52:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7o=JaQQRtyEo=sicxpifc2s8oFXrV7metER=eiETv8nQ@mail.gmail.com>
Message-ID: <CAPhsuW7o=JaQQRtyEo=sicxpifc2s8oFXrV7metER=eiETv8nQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] module: fix kmemleak annotations for non init ELF sections
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, rppt@kernel.org, dave@stgolabs.net,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, colin.i.king@gmail.com,
        jim.cromie@gmail.com, catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 7:27=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> Commit ac3b43283923 ("module: replace module_layout with module_memory")
> reworked the way to handle memory allocations to make it clearer. But it
> lost in translation how we handled kmemleak_ignore() or kmemleak_not_leak=
()
> for different ELF sections.
>
> Fix this and clarify the comments a bit more.
>
> Fixes: ac3b43283923 ("module: replace module_layout with module_memory")
> Reported-by: Jim Cromie <jim.cromie@gmail.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Song Liu <song@kernel.org>

Thanks for the fix!

> ---
>  kernel/module/main.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 5cc21083af04..d8bb23fa6989 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2233,11 +2233,23 @@ static int move_module(struct module *mod, struct=
 load_info *info)
>                 ptr =3D module_memory_alloc(mod->mem[type].size, type);
>
>                 /*
> -                * The pointer to this block is stored in the module stru=
cture
> -                * which is inside the block. Just mark it as not being a
> -                * leak.
> +                * The pointer to these blocks of memory are stored on th=
e module
> +                * structure and we keep that around so long as the modul=
e is
> +                * around. We only free that memory when we unload the mo=
dule.
> +                * Just mark them as not being a leak then. The .init* EL=
F
> +                * sections *do* get freed after boot so we treat them sl=
ightly
> +                * differently and only grey them out -- they work as typ=
ical
> +                * memory allocations which *do* eventually get freed.
>                  */
> -               kmemleak_ignore(ptr);
> +               switch (type) {
> +               case MOD_INIT_TEXT: /* fallthrough */
> +               case MOD_INIT_DATA: /* fallthrough */
> +               case MOD_INIT_RODATA: /* fallthrough */
> +                       kmemleak_ignore(ptr);
> +                       break;
> +               default:
> +                       kmemleak_not_leak(ptr);
> +               }
>                 if (!ptr) {
>                         t =3D type;
>                         goto out_enomem;
> --
> 2.39.2
>
