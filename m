Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13628661467
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 10:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjAHJwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 04:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjAHJvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 04:51:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C874AF5F;
        Sun,  8 Jan 2023 01:51:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1478EB8074A;
        Sun,  8 Jan 2023 09:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D98C4339B;
        Sun,  8 Jan 2023 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673171490;
        bh=Q5YSCF0HOw1QogyPG5fmzAegVIZNI/ljytPR0K4RgD8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A/QbN0fQh9xBzT8fpG86D/TMpi0X5xj4MB/5cCFUlZScX8pbiw6LvUkzv/IjXJiYq
         gEbUXfqdvY6GK+LM5CQRaB7dqphFIIfbwWe7i54Sv0vp47zPlyGX0IzjoIEzHEuHBU
         zm/8dlmYrFheTxvB+N0WRk1ilbLI0WruKEu/QTf+EE5DKlmALMoNFOyd1yrdtulox2
         7eElsQh7DIdBKzuEA05l0uxgpF2cS8obXmYkTvhb76Li9sYiTzSJAQdYwjbxXhwBO3
         xpodgmhbLkUJAiGA8vCvXALI/89UA3EFo6epY8zCC7q3PtuEoHPCpS5uASnrJp+2g/
         9frhEDT7QBPKQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-15027746720so6025604fac.13;
        Sun, 08 Jan 2023 01:51:30 -0800 (PST)
X-Gm-Message-State: AFqh2krK6XR2+7lfzGWj6kB4cKORI/gK7UbjBbevdLLVLj0fEo3v1+PV
        A5KpimN8gd1kwPJ3439MHEctElX39nTiK8U1f78=
X-Google-Smtp-Source: AMrXdXsVqeb5C4pXQj3Q5AIj1CDSzPJNUijrHZ9GP38qc6SQgyjIRKfOgYA9JUdgWAXQ7iauLBkrjHkLRsOrsbPSzF4=
X-Received: by 2002:a05:6870:cc89:b0:150:39e2:c688 with SMTP id
 ot9-20020a056870cc8900b0015039e2c688mr2847894oab.287.1673171489681; Sun, 08
 Jan 2023 01:51:29 -0800 (PST)
MIME-Version: 1.0
References: <20230107212019.2575770-1-masahiroy@kernel.org>
In-Reply-To: <20230107212019.2575770-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 8 Jan 2023 18:50:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNARcmJUO9hnEngnRkFcTU-OUDduu7AaPfpDd7BFvf85K6g@mail.gmail.com>
Message-ID: <CAK7LNARcmJUO9hnEngnRkFcTU-OUDduu7AaPfpDd7BFvf85K6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: fix nm error message when GNU Make >= 4.4 is used
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <n.schier@avm.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Xin Li <xin3.li@intel.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 8, 2023 at 6:20 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Nathan Chancellor reports an error message from $(NM) if GNU Make 4.4
> is used to build the ARM decompressor.
>
>   $ make-4.4 ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=build defconfig all
>     [snip]
>     LD      vmlinux
>     NM      System.map
>     SORTTAB vmlinux
>     OBJCOPY arch/arm/boot/Image
>     Kernel: arch/arm/boot/Image is ready
>   arm-linux-gnueabi-nm: 'arch/arm/boot/compressed/../../../../vmlinux': No such file
>   /bin/sh: 1: arithmetic expression: expecting primary: " "
>     LDS     arch/arm/boot/compressed/vmlinux.lds
>     AS      arch/arm/boot/compressed/head.o
>     GZIP    arch/arm/boot/compressed/piggy_data
>     AS      arch/arm/boot/compressed/piggy.o
>     CC      arch/arm/boot/compressed/misc.o
>
> This occurs with GNU Make commit 98da874c4303 ("[SV 10593] Export
> variables to $(shell ...) commands"), and the O= option is needed to
> reproduce it. The generated zImage is correct despite the error message.
>
> As the commit description of 98da874c4303 [1] says, exported variables
> are passed down to $(shell ) functions, which means exported recursive
> variables might be expanded earlier than before, in the parse stage.
>
> The following test code demonstrates the change for GNU Make 4.4.
>
> [Test Makefile]
>
>   $(shell echo hello > foo)
>   export foo = $(shell cat bar/../foo)
>   $(shell mkdir bar)
>
>   all:
>           @echo $(foo)
>
> [GNU Make 4.3]
>
>   $ rm -rf bar; make-4.3
>   hello
>
> [GNU Make 4.4]
>
>   $ rm -rf bar; make-4.4
>   cat: bar/../foo: No such file or directory
>   hello
>
> The 'foo' is a resursively expanded (or lazily expanded) variable.
>
> GNU Make 4.3 expands it just before running the recipe '@echo $(foo)',
> at this point, the directory 'bar' exists.
>
> GNU Make 4.4 expands it to evaluate $(shell mkdir bar) because 'foo' is
> exported. At this point, the directory 'bar' does not exit yet. The cat
> command cannot resolve the bar/../foo path, hence the error message.
>
> Let's get back to the kernel Makefile.
>
> 'KBSS_SZ' in arch/arm/boot/compressed/Makefile is a recursive variable,
> which is referenced by 'LDFLAGS_vmlinux', which is also a recursive
> variable.
>
> GNU Make 4.3 expands 'KBSS_SZ' just before running the recipes. Before
> that, $(shell mkdir -p $(obj-dirs)) in scripts/Makefile.build creates
> the output directory, arch/arm/boot/compressed.
>
> GNU Make 4.4 expands 'KBSS_SZ' in the parse stage because LDFLAGS_vmlinux
> was (accidentally) exported by commit 5d4aeffbf709 ("kbuild: rebuild
> .vmlinux.export.o when its prerequisite is updated"). $(NM) cannot
> resolve the path arch/arm/boot/compressed/../../../../vmlinux.
>
> I admit this is a bug caused by 5d4aeffbf709 (I will fix it in the next
> commit), but do not see any good reason in writing the vmlinux path in
> such an indirect way. Just say 'vmlinux'.
>
> [1]: https://git.savannah.gnu.org/cgit/make.git/commit/?id=98da874c43035a490cdca81331724f233a3d0c9a
>
> Link: https://lore.kernel.org/all/Y7i8+EjwdnhHtlrr@dev-arch.thelio-3990X/
> Fixes: 5d4aeffbf709 ("kbuild: rebuild .vmlinux.export.o when its prerequisite is updated")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---



I changed my mind. I will fix 2/2 only for now,
so that backing to stable kernels gets easier.


I will send v2 with updated commit description.




-- 
Best Regards
Masahiro Yamada
