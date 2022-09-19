Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1735F5BCC31
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiISMxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiISMxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:53:02 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FA128E0F;
        Mon, 19 Sep 2022 05:52:59 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 28JCqgNV021551;
        Mon, 19 Sep 2022 21:52:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 28JCqgNV021551
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663591963;
        bh=Z2grjyBWeKgabnQeQrL7UlCtPVRTFcgGK6jEYO6U2c8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iw4zKnM38SQz4AkmLGldqx2Azht+1UAnEbiVzjTQ7Oph8kOCJ/461ksVvIA+tfUrZ
         RPbHXxmQGD8CxbjkwaKZC71+JRqZ21RGpCyAEQDAGuSHBTBU+piOcE3zCr7rgyW8nO
         iHgrQ/RyGQVNjj5PZK1MTpcWKVdrz1eCFP99t8uPqrZ6rVbHPENJOT6o25Zx0EpORL
         J+ZgDiJdna/8qJORpZBw/ENXC7Ggpzj1BkcBlmAeGQVcD1ZXjupaOkJ6OEPXoPcZEq
         XGqDJN35fZVwo3unxH+mhWMmUxxa5JMBhKhPliv6C1UgoOG1k/utLnzoaH3UqbJqz5
         777pPe3MikNMw==
X-Nifty-SrcIP: [209.85.210.43]
Received: by mail-ot1-f43.google.com with SMTP id j17-20020a9d7f11000000b0065a20212349so528459otq.12;
        Mon, 19 Sep 2022 05:52:43 -0700 (PDT)
X-Gm-Message-State: ACrzQf2vL6llQvlKFGrK9LUENz2vtOrGLF+a5rwyV7njGTabKN3mjXaS
        ciSuZLgLaTor37Tb67/YMq8Ehcmndt5SLB6COsI=
X-Google-Smtp-Source: AMsMyM7H7QsU1sKFUo8CbzcwOhPJX8aovt2jjJ0fZ0X1JavuOUUb9kDFfJFOnL3NyE7VseMhx/BMrz6Q4ZVefHlYniI=
X-Received: by 2002:a05:6830:658b:b0:63b:3501:7167 with SMTP id
 cn11-20020a056830658b00b0063b35017167mr7839096otb.343.1663591961737; Mon, 19
 Sep 2022 05:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220919120408.3956424-1-npiggin@gmail.com>
In-Reply-To: <20220919120408.3956424-1-npiggin@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 19 Sep 2022 21:52:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNATBrtCVnG6g05g0eT7jPKSHPct2=JX0SQ8i87dTfm2Vxg@mail.gmail.com>
Message-ID: <CAK7LNATBrtCVnG6g05g0eT7jPKSHPct2=JX0SQ8i87dTfm2Vxg@mail.gmail.com>
Subject: Re: [PATCH] lib: zstd: build common files separately for compress and decompress
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Nick Terrell <terrelln@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 9:04 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> It is possible for compress to be built as a module and decompress to
> be built in, and kernel and module C flags can be different. This can
> cause module built code to be linked into the kernel or vice versa.
>
> Use symbolic links from the common code to compression and decompression
> module directories to avoid this problem.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> I'm not sure if this is the preferred way to fix it. I hadn't
> thought about this problem before but now I notice it in zstd
> it seems like it could be a pitfall in other parts of the kernel
> as well.


I will apply the following instead.

https://lore.kernel.org/all/20220429053329.2278740-1-aik@ozlabs.ru/



> Is there a better way to solve it? Or some way to
> automatically detect the conflict and fail the build rather than
> silently succeed?


There is a way to detect this, but let me check if there are more
instances that do similar things like zstd.
If I remember correctly, there are some more.








> Thanks,
> Nick
>
>  lib/zstd/Makefile                           | 20 ++++++++++----------
>  lib/zstd/compress/common/bitstream.h        |  1 +
>  lib/zstd/compress/common/compiler.h         |  1 +
>  lib/zstd/compress/common/cpu.h              |  1 +
>  lib/zstd/compress/common/debug.c            |  1 +
>  lib/zstd/compress/common/debug.h            |  1 +
>  lib/zstd/compress/common/entropy_common.c   |  1 +
>  lib/zstd/compress/common/error_private.c    |  1 +
>  lib/zstd/compress/common/error_private.h    |  1 +
>  lib/zstd/compress/common/fse.h              |  1 +
>  lib/zstd/compress/common/fse_decompress.c   |  1 +
>  lib/zstd/compress/common/huf.h              |  1 +
>  lib/zstd/compress/common/mem.h              |  1 +
>  lib/zstd/compress/common/zstd_common.c      |  1 +
>  lib/zstd/compress/common/zstd_deps.h        |  1 +
>  lib/zstd/compress/common/zstd_internal.h    |  1 +
>  lib/zstd/decompress/common/bitstream.h      |  1 +
>  lib/zstd/decompress/common/compiler.h       |  1 +
>  lib/zstd/decompress/common/cpu.h            |  1 +
>  lib/zstd/decompress/common/debug.c          |  1 +
>  lib/zstd/decompress/common/debug.h          |  1 +
>  lib/zstd/decompress/common/entropy_common.c |  1 +
>  lib/zstd/decompress/common/error_private.c  |  1 +
>  lib/zstd/decompress/common/error_private.h  |  1 +
>  lib/zstd/decompress/common/fse.h            |  1 +
>  lib/zstd/decompress/common/fse_decompress.c |  1 +
>  lib/zstd/decompress/common/huf.h            |  1 +
>  lib/zstd/decompress/common/mem.h            |  1 +
>  lib/zstd/decompress/common/zstd_common.c    |  1 +
>  lib/zstd/decompress/common/zstd_deps.h      |  1 +
>  lib/zstd/decompress/common/zstd_internal.h  |  1 +
>  31 files changed, 40 insertions(+), 10 deletions(-)
>  create mode 120000 lib/zstd/compress/common/bitstream.h
>  create mode 120000 lib/zstd/compress/common/compiler.h
>  create mode 120000 lib/zstd/compress/common/cpu.h
>  create mode 120000 lib/zstd/compress/common/debug.c
>  create mode 120000 lib/zstd/compress/common/debug.h
>  create mode 120000 lib/zstd/compress/common/entropy_common.c
>  create mode 120000 lib/zstd/compress/common/error_private.c
>  create mode 120000 lib/zstd/compress/common/error_private.h
>  create mode 120000 lib/zstd/compress/common/fse.h
>  create mode 120000 lib/zstd/compress/common/fse_decompress.c
>  create mode 120000 lib/zstd/compress/common/huf.h
>  create mode 120000 lib/zstd/compress/common/mem.h
>  create mode 120000 lib/zstd/compress/common/zstd_common.c
>  create mode 120000 lib/zstd/compress/common/zstd_deps.h
>  create mode 120000 lib/zstd/compress/common/zstd_internal.h
>  create mode 120000 lib/zstd/decompress/common/bitstream.h
>  create mode 120000 lib/zstd/decompress/common/compiler.h
>  create mode 120000 lib/zstd/decompress/common/cpu.h
>  create mode 120000 lib/zstd/decompress/common/debug.c
>  create mode 120000 lib/zstd/decompress/common/debug.h
>  create mode 120000 lib/zstd/decompress/common/entropy_common.c
>  create mode 120000 lib/zstd/decompress/common/error_private.c
>  create mode 120000 lib/zstd/decompress/common/error_private.h
>  create mode 120000 lib/zstd/decompress/common/fse.h
>  create mode 120000 lib/zstd/decompress/common/fse_decompress.c
>  create mode 120000 lib/zstd/decompress/common/huf.h
>  create mode 120000 lib/zstd/decompress/common/mem.h
>  create mode 120000 lib/zstd/decompress/common/zstd_common.c
>  create mode 120000 lib/zstd/decompress/common/zstd_deps.h
>  create mode 120000 lib/zstd/decompress/common/zstd_internal.h
>
> diff --git a/lib/zstd/Makefile b/lib/zstd/Makefile
> index fc45339fc3a3..6d785268f8c3 100644
> --- a/lib/zstd/Makefile
> +++ b/lib/zstd/Makefile
> @@ -13,11 +13,11 @@ obj-$(CONFIG_ZSTD_DECOMPRESS) += zstd_decompress.o
>
>  zstd_compress-y := \
>                 zstd_compress_module.o \
> -               common/debug.o \
> -               common/entropy_common.o \
> -               common/error_private.o \
> -               common/fse_decompress.o \
> -               common/zstd_common.o \
> +               compress/common/debug.o \
> +               compress/common/entropy_common.o \
> +               compress/common/error_private.o \
> +               compress/common/fse_decompress.o \
> +               compress/common/zstd_common.o \
>                 compress/fse_compress.o \
>                 compress/hist.o \
>                 compress/huf_compress.o \
> @@ -33,11 +33,11 @@ zstd_compress-y := \
>
>  zstd_decompress-y := \
>                 zstd_decompress_module.o \
> -               common/debug.o \
> -               common/entropy_common.o \
> -               common/error_private.o \
> -               common/fse_decompress.o \
> -               common/zstd_common.o \
> +               decompress/common/debug.o \
> +               decompress/common/entropy_common.o \
> +               decompress/common/error_private.o \
> +               decompress/common/fse_decompress.o \
> +               decompress/common/zstd_common.o \
>                 decompress/huf_decompress.o \
>                 decompress/zstd_ddict.o \
>                 decompress/zstd_decompress.o \
> diff --git a/lib/zstd/compress/common/bitstream.h b/lib/zstd/compress/common/bitstream.h
> new file mode 120000
> index 000000000000..de97b72f47ce
> --- /dev/null
> +++ b/lib/zstd/compress/common/bitstream.h
> @@ -0,0 +1 @@
> +../../common/bitstream.h
> \ No newline at end of file
> diff --git a/lib/zstd/compress/common/compiler.h b/lib/zstd/compress/common/compiler.h
> new file mode 120000
> index 000000000000..a316286adf05
> --- /dev/null
> +++ b/lib/zstd/compress/common/compiler.h
> @@ -0,0 +1 @@
> +../../common/compiler.h
> \ No newline at end of file
> diff --git a/lib/zstd/compress/common/cpu.h b/lib/zstd/compress/common/cpu.h
> new file mode 120000
> index 000000000000..35282be494a2
> --- /dev/null
> +++ b/lib/zstd/compress/common/cpu.h
> @@ -0,0 +1 @@
> +../../common/cpu.h
> \ No newline at end of file
> diff --git a/lib/zstd/compress/common/debug.c b/lib/zstd/compress/common/debug.c
> new file mode 120000
> index 000000000000..5d7b272026d6
> --- /dev/null
> +++ b/lib/zstd/compress/common/debug.c
> @@ -0,0 +1 @@
> +../../common/debug.c
> \ No newline at end of file
> diff --git a/lib/zstd/compress/common/debug.h b/lib/zstd/compress/common/debug.h
> new file mode 120000
> index 000000000000..15c1e1cd5c95
> --- /dev/null
> +++ b/lib/zstd/compress/common/debug.h
> @@ -0,0 +1 @@
> +../../common/debug.h
> \ No newline at end of file
> diff --git a/lib/zstd/compress/common/entropy_common.c b/lib/zstd/compress/common/entropy_common.c
> new file mode 120000
> index 000000000000..221119c32817
> --- /dev/null
> +++ b/lib/zstd/compress/common/entropy_common.c
> @@ -0,0 +1 @@
> +../../common/entropy_common.c
> \ No newline at end of file
> diff --git a/lib/zstd/compress/common/error_private.c b/lib/zstd/compress/common/error_private.c
> new file mode 120000
> index 000000000000..f87d3cf6851f
> --- /dev/null
> +++ b/lib/zstd/compress/common/error_private.c
> @@ -0,0 +1 @@
> +../../common/error_private.c
> \ No newline at end of file
> diff --git a/lib/zstd/compress/common/error_private.h b/lib/zstd/compress/common/error_private.h
> new file mode 120000
> index 000000000000..30d469222942
> --- /dev/null
> +++ b/lib/zstd/compress/common/error_private.h
> @@ -0,0 +1 @@
> +../../common/error_private.h
> \ No newline at end of file
> diff --git a/lib/zstd/compress/common/fse.h b/lib/zstd/compress/common/fse.h
> new file mode 120000
> index 000000000000..29c44ebdd2da
> --- /dev/null
> +++ b/lib/zstd/compress/common/fse.h
> @@ -0,0 +1 @@
> +../../common/fse.h
> \ No newline at end of file
> diff --git a/lib/zstd/compress/common/fse_decompress.c b/lib/zstd/compress/common/fse_decompress.c
> new file mode 120000
> index 000000000000..658e375541f1
> --- /dev/null
> +++ b/lib/zstd/compress/common/fse_decompress.c
> @@ -0,0 +1 @@
> +../../common/fse_decompress.c
> \ No newline at end of file
> diff --git a/lib/zstd/compress/common/huf.h b/lib/zstd/compress/common/huf.h
> new file mode 120000
> index 000000000000..7c9142232da6
> --- /dev/null
> +++ b/lib/zstd/compress/common/huf.h
> @@ -0,0 +1 @@
> +../../common/huf.h
> \ No newline at end of file
> diff --git a/lib/zstd/compress/common/mem.h b/lib/zstd/compress/common/mem.h
> new file mode 120000
> index 000000000000..0d9921eb1ca4
> --- /dev/null
> +++ b/lib/zstd/compress/common/mem.h
> @@ -0,0 +1 @@
> +../../common/mem.h
> \ No newline at end of file
> diff --git a/lib/zstd/compress/common/zstd_common.c b/lib/zstd/compress/common/zstd_common.c
> new file mode 120000
> index 000000000000..5a7475cd3b87
> --- /dev/null
> +++ b/lib/zstd/compress/common/zstd_common.c
> @@ -0,0 +1 @@
> +../../common/zstd_common.c
> \ No newline at end of file
> diff --git a/lib/zstd/compress/common/zstd_deps.h b/lib/zstd/compress/common/zstd_deps.h
> new file mode 120000
> index 000000000000..21b3a7e967da
> --- /dev/null
> +++ b/lib/zstd/compress/common/zstd_deps.h
> @@ -0,0 +1 @@
> +../../common/zstd_deps.h
> \ No newline at end of file
> diff --git a/lib/zstd/compress/common/zstd_internal.h b/lib/zstd/compress/common/zstd_internal.h
> new file mode 120000
> index 000000000000..3bf2b94e718f
> --- /dev/null
> +++ b/lib/zstd/compress/common/zstd_internal.h
> @@ -0,0 +1 @@
> +../../common/zstd_internal.h
> \ No newline at end of file
> diff --git a/lib/zstd/decompress/common/bitstream.h b/lib/zstd/decompress/common/bitstream.h
> new file mode 120000
> index 000000000000..de97b72f47ce
> --- /dev/null
> +++ b/lib/zstd/decompress/common/bitstream.h
> @@ -0,0 +1 @@
> +../../common/bitstream.h
> \ No newline at end of file
> diff --git a/lib/zstd/decompress/common/compiler.h b/lib/zstd/decompress/common/compiler.h
> new file mode 120000
> index 000000000000..a316286adf05
> --- /dev/null
> +++ b/lib/zstd/decompress/common/compiler.h
> @@ -0,0 +1 @@
> +../../common/compiler.h
> \ No newline at end of file
> diff --git a/lib/zstd/decompress/common/cpu.h b/lib/zstd/decompress/common/cpu.h
> new file mode 120000
> index 000000000000..35282be494a2
> --- /dev/null
> +++ b/lib/zstd/decompress/common/cpu.h
> @@ -0,0 +1 @@
> +../../common/cpu.h
> \ No newline at end of file
> diff --git a/lib/zstd/decompress/common/debug.c b/lib/zstd/decompress/common/debug.c
> new file mode 120000
> index 000000000000..5d7b272026d6
> --- /dev/null
> +++ b/lib/zstd/decompress/common/debug.c
> @@ -0,0 +1 @@
> +../../common/debug.c
> \ No newline at end of file
> diff --git a/lib/zstd/decompress/common/debug.h b/lib/zstd/decompress/common/debug.h
> new file mode 120000
> index 000000000000..15c1e1cd5c95
> --- /dev/null
> +++ b/lib/zstd/decompress/common/debug.h
> @@ -0,0 +1 @@
> +../../common/debug.h
> \ No newline at end of file
> diff --git a/lib/zstd/decompress/common/entropy_common.c b/lib/zstd/decompress/common/entropy_common.c
> new file mode 120000
> index 000000000000..221119c32817
> --- /dev/null
> +++ b/lib/zstd/decompress/common/entropy_common.c
> @@ -0,0 +1 @@
> +../../common/entropy_common.c
> \ No newline at end of file
> diff --git a/lib/zstd/decompress/common/error_private.c b/lib/zstd/decompress/common/error_private.c
> new file mode 120000
> index 000000000000..f87d3cf6851f
> --- /dev/null
> +++ b/lib/zstd/decompress/common/error_private.c
> @@ -0,0 +1 @@
> +../../common/error_private.c
> \ No newline at end of file
> diff --git a/lib/zstd/decompress/common/error_private.h b/lib/zstd/decompress/common/error_private.h
> new file mode 120000
> index 000000000000..30d469222942
> --- /dev/null
> +++ b/lib/zstd/decompress/common/error_private.h
> @@ -0,0 +1 @@
> +../../common/error_private.h
> \ No newline at end of file
> diff --git a/lib/zstd/decompress/common/fse.h b/lib/zstd/decompress/common/fse.h
> new file mode 120000
> index 000000000000..29c44ebdd2da
> --- /dev/null
> +++ b/lib/zstd/decompress/common/fse.h
> @@ -0,0 +1 @@
> +../../common/fse.h
> \ No newline at end of file
> diff --git a/lib/zstd/decompress/common/fse_decompress.c b/lib/zstd/decompress/common/fse_decompress.c
> new file mode 120000
> index 000000000000..658e375541f1
> --- /dev/null
> +++ b/lib/zstd/decompress/common/fse_decompress.c
> @@ -0,0 +1 @@
> +../../common/fse_decompress.c
> \ No newline at end of file
> diff --git a/lib/zstd/decompress/common/huf.h b/lib/zstd/decompress/common/huf.h
> new file mode 120000
> index 000000000000..7c9142232da6
> --- /dev/null
> +++ b/lib/zstd/decompress/common/huf.h
> @@ -0,0 +1 @@
> +../../common/huf.h
> \ No newline at end of file
> diff --git a/lib/zstd/decompress/common/mem.h b/lib/zstd/decompress/common/mem.h
> new file mode 120000
> index 000000000000..0d9921eb1ca4
> --- /dev/null
> +++ b/lib/zstd/decompress/common/mem.h
> @@ -0,0 +1 @@
> +../../common/mem.h
> \ No newline at end of file
> diff --git a/lib/zstd/decompress/common/zstd_common.c b/lib/zstd/decompress/common/zstd_common.c
> new file mode 120000
> index 000000000000..5a7475cd3b87
> --- /dev/null
> +++ b/lib/zstd/decompress/common/zstd_common.c
> @@ -0,0 +1 @@
> +../../common/zstd_common.c
> \ No newline at end of file
> diff --git a/lib/zstd/decompress/common/zstd_deps.h b/lib/zstd/decompress/common/zstd_deps.h
> new file mode 120000
> index 000000000000..21b3a7e967da
> --- /dev/null
> +++ b/lib/zstd/decompress/common/zstd_deps.h
> @@ -0,0 +1 @@
> +../../common/zstd_deps.h
> \ No newline at end of file
> diff --git a/lib/zstd/decompress/common/zstd_internal.h b/lib/zstd/decompress/common/zstd_internal.h
> new file mode 120000
> index 000000000000..3bf2b94e718f
> --- /dev/null
> +++ b/lib/zstd/decompress/common/zstd_internal.h
> @@ -0,0 +1 @@
> +../../common/zstd_internal.h
> \ No newline at end of file
> --
> 2.37.2
>


-- 
Best Regards
Masahiro Yamada
