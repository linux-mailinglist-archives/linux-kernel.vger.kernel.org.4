Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955126F125D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345504AbjD1HaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjD1HaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:30:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293372689
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCDB260A0F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 07:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26796C433EF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 07:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682667009;
        bh=EZT+y/OIOW2KXt81ZyXZENqGfhYKcx4a5ivqT4UgSYY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UgK6yNYqLKgHll6zEz8WGxCTGSIg09NP7qXAqkgTslxf+zrobLG6kJA6cmzqOC7pl
         nHyUjLBrz4rYWKwRaSXHZXy67krrwJMFIJY8TmAdOQlNcwKTOBGpTEHaoYyXYTY3w0
         jk518XMuYMmTKLjyPxlhKyYmious7Rj7kR2iMiY2GmvWIVY9jWbLxXsN3fFHzixL/g
         H8R35YkpDKQQr1+lDL/LxqdrDshTcYy/gfqqMQ7eyPg414zd3Wuz1fea0FcWYmfiTM
         10gc6yR15a4L7IwwS5xrlJdgF8+ZJ57fhKLVCDHNOTtBhawzubjylARG2soFlTvoTh
         442R0a39sNQyA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f00c33c3d6so2449842e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 00:30:09 -0700 (PDT)
X-Gm-Message-State: AC+VfDzjoNDMNWt59wuGJFWDjy/u5HsxzKR0cKhjWf5OGTyUFLB9KQnb
        3HgI9UFux57FY7gDwC0oMVi+EVlcd78kTQuyCOw=
X-Google-Smtp-Source: ACHHUZ4yVMpWZawWiFE3JOO57vSHmIy1kBJ9L9nEgK66jIb7+vz05VU0iTnt33gRcvZTZHTSZLUmVtva7q9aWtnEhTw=
X-Received: by 2002:a2e:2c11:0:b0:2a7:7f4a:3035 with SMTP id
 s17-20020a2e2c11000000b002a77f4a3035mr1212433ljs.16.1682667007198; Fri, 28
 Apr 2023 00:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230428050442.180913-1-maskray@google.com>
In-Reply-To: <20230428050442.180913-1-maskray@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Apr 2023 08:29:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGpbKgS8mNxVuAyPvT-vW0LWZOXgqsy5TvKhzJRs_rHkA@mail.gmail.com>
Message-ID: <CAMj1kXGpbKgS8mNxVuAyPvT-vW0LWZOXgqsy5TvKhzJRs_rHkA@mail.gmail.com>
Subject: Re: [PATCH] arm64: lds: move .got section out of .text
To:     Fangrui Song <maskray@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fangrui,

On Fri, 28 Apr 2023 at 06:05, Fangrui Song <maskray@google.com> wrote:
>
> Currently, the .got section is placed within the output section .text.
> However, when .got is non-empty, the SHF_WRITE flag is set when linked
> by lld. GNU ld recognizes .text as a special section and ignores the
> SHF_WRITE flag. By renaming .text, we can also get the SHF_WRITE flag.
>
> Conventionally, the .got section is placed just before .got.plt (which
> should be empty and omitted in the kernel). Therefore, we move the .got
> section to a conventional location (between .text and .data) and remove
> the unneeded `. = ALIGN(16)`.
>
> Signed-off-by: Fangrui Song <maskray@google.com>
> ---
>  arch/arm64/kernel/vmlinux.lds.S | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index b9202c2ee18e..2bcb3b30db41 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -181,18 +181,8 @@ SECTIONS
>                         KPROBES_TEXT
>                         HYPERVISOR_TEXT
>                         *(.gnu.warning)
> -               . = ALIGN(16);
> -               *(.got)                 /* Global offset table          */
>         }
>
> -       /*
> -        * Make sure that the .got.plt is either completely empty or it
> -        * contains only the lazy dispatch entries.
> -        */
> -       .got.plt : { *(.got.plt) }
> -       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
> -              "Unexpected GOT/PLT entries detected!")
> -
>         . = ALIGN(SEGMENT_ALIGN);
>         _etext = .;                     /* End of text section */
>
> @@ -247,6 +237,16 @@ SECTIONS
>
>         . = ALIGN(SEGMENT_ALIGN);
>         __inittext_end = .;
> +
> +       .got : { *(.got) }

This is the .init region, which gets freed and unmapped after boot. If
the GOT is non-empty, it needs to remain mapped, so we cannot place it
here.

We have the same issue with the .rodata section, which incorporates
variables marked as __ro_after_init, which are not const qualified. So
given that .rodata is already emitted as WA, and we cannot do anything
about that, let's move the GOT in there.


> +       /*
> +        * Make sure that the .got.plt is either completely empty or it
> +        * contains only the lazy dispatch entries.
> +        */
> +       .got.plt : { *(.got.plt) }
> +       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
> +              "Unexpected GOT/PLT entries detected!")
> +
>         __initdata_begin = .;
>
>         init_idmap_pg_dir = .;
> --
> 2.40.1.495.gc816e09b53d-goog
>
