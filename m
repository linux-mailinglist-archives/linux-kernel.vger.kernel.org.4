Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFB371F607
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 00:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjFAWgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 18:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFAWgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 18:36:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A623133;
        Thu,  1 Jun 2023 15:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 906E364AA7;
        Thu,  1 Jun 2023 22:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED82AC43443;
        Thu,  1 Jun 2023 22:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685658962;
        bh=HByQUJENQcDPWiijaDFhYT8jA4bRcfOqcVglu/ddG6U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=re2I/9LpOnn67cRoh6PMZZOHT8vdfHha/bz6wtCDfOYdb5vZzGUctvTnWl4LYy/9m
         NwPwQViyZ7XqHLQBspSOOwlfhUwQAtJo+yIL5HnTKCCgUiXqtggXTsskTfnNpG7vN9
         VK+9AhJpq2nZ3mf3rthk6G8xSKwWwiHUzWquyx91XgpIn8z8MdRB3+bYCub3NDdJsU
         MBXCxXfkbcJxxlc8t1IXtz79Bkfq9TSzEwYW0lg8eC1Maz9RVf0VpdqrZpUNbjK7/t
         roE+PBwSYAYsytt+Ua6jTizptS+lu0Z7pWJc7cPm4JVKQxLN5o5FZMLtghbCRvoQ8N
         h5KrxNOdHSCXg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f3ba703b67so1883166e87.1;
        Thu, 01 Jun 2023 15:36:01 -0700 (PDT)
X-Gm-Message-State: AC+VfDwCfcoWvJSmhQPKGLk4na5gWDVfbKoT0+70BSdxCghnn0LsO9eE
        mHJX70nFS4hM1gSoxd7YkjITBewiMbLpXXglhsE=
X-Google-Smtp-Source: ACHHUZ5IpAtCBKLINxhk+Z0SWINwbFkPqmi++HI/k6BNegfGNCzvnzTim5Gy3oJJLp9NHmq3+FFn0pl72eGk9Pzb3ws=
X-Received: by 2002:ac2:48ba:0:b0:4ec:8816:f4fc with SMTP id
 u26-20020ac248ba000000b004ec8816f4fcmr792426lfg.6.1685658959623; Thu, 01 Jun
 2023 15:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230601101257.530867-1-rppt@kernel.org> <20230601101257.530867-5-rppt@kernel.org>
In-Reply-To: <20230601101257.530867-5-rppt@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 1 Jun 2023 15:35:47 -0700
X-Gmail-Original-Message-ID: <CAPhsuW70o=8QwcNJPx=qxaKoPkOzwYt8xxzjK38dF2tJB-18jQ@mail.gmail.com>
Message-ID: <CAPhsuW70o=8QwcNJPx=qxaKoPkOzwYt8xxzjK38dF2tJB-18jQ@mail.gmail.com>
Subject: Re: [PATCH 04/13] mm/jitalloc, arch: convert remaining overrides of
 module_alloc to jitalloc
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 3:13=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Extend jitalloc parameters to accommodate more complex overrides of
> module_alloc() by architectures.
>
> This includes specification of a fallback range required by arm, arm64
> and powerpc and support for allocation of KASAN shadow required by
> arm64, s390 and x86.
>
> The core implementation of jit_alloc() takes care of suppressing warnings
> when the initial allocation fails but there is a fallback range defined.
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

[...]

>
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index 5af4975caeb5..ecf1f4030317 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -17,56 +17,49 @@
>  #include <linux/moduleloader.h>
>  #include <linux/scs.h>
>  #include <linux/vmalloc.h>
> +#include <linux/jitalloc.h>
>  #include <asm/alternative.h>
>  #include <asm/insn.h>
>  #include <asm/scs.h>
>  #include <asm/sections.h>
>
> -void *module_alloc(unsigned long size)
> +static struct jit_alloc_params jit_alloc_params =3D {
> +       .alignment      =3D MODULE_ALIGN,
> +       .flags          =3D JIT_ALLOC_KASAN_SHADOW,
> +};
> +
> +struct jit_alloc_params *jit_alloc_arch_params(void)
>  {
>         u64 module_alloc_end =3D module_alloc_base + MODULES_VSIZE;

module_alloc_base() is initialized in kaslr_init(), which is called after
mm_core_init(). We will need some special logic for this.

Thanks,
Song

> -       gfp_t gfp_mask =3D GFP_KERNEL;
> -       void *p;
> -
> -       /* Silence the initial allocation */
> -       if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
> -               gfp_mask |=3D __GFP_NOWARN;
>

[...]
