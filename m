Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F2D733AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjFPUTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjFPUTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:19:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6278230DD;
        Fri, 16 Jun 2023 13:19:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB39063EBA;
        Fri, 16 Jun 2023 20:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552E8C433B6;
        Fri, 16 Jun 2023 20:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686946742;
        bh=2gFsvIXhZCi6KoizK2mVR8ubH1d6zKHpuStaPaewE2c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UDI57R+Ac8F87HdvmrIejvjCHM49LTC4REb6jwcTgaWly1GGKsFbDi3ghmDp0sH5F
         dyADcSB+eIU3pbcZs4WY9WOy0Qfue9ZKueQFrHo6+fN0pFBb6x0I9BFxnKIQnZ0f6m
         zoeRxS58zso8o8K5cKrj75Ci+DjJ2i0NK5f/ruazAus2+TOpX2RWJhZX7p+ZAwMaoZ
         7/IjfjgHld/4MT6CtRzHW+8wrzT/BS827SmRNHxio26g9lEtfuPfj6kxYVksHyp6iy
         q4wBjLvMwutEo9bQbQ0iSwXG+SX0mZCYXiK84cI+EMmphh55ZOB3JRt4P0s1ApMmst
         2YeyFD5vvx/Xg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f62b512fe2so1603315e87.1;
        Fri, 16 Jun 2023 13:19:02 -0700 (PDT)
X-Gm-Message-State: AC+VfDwBdN/5i5ZPe7QP/+fyvRdbdtsFzl81Kxf4bSrAiARQjtb56+Rd
        epZMkrKKx0dOwMLjE6cG32JZ4QsNYyOPw+Rrti0=
X-Google-Smtp-Source: ACHHUZ4xCjWLdj6bUZgrYEqyfT0+mWbIpLp7dl+h+OA2H/SetbsgMpyruMyrfqh6ldv/ey70g6BKmUQ4Jmh+AiNCLf0=
X-Received: by 2002:a19:5e02:0:b0:4f7:69b9:fa07 with SMTP id
 s2-20020a195e02000000b004f769b9fa07mr2191315lfb.45.1686946740318; Fri, 16 Jun
 2023 13:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230616085038.4121892-1-rppt@kernel.org> <20230616085038.4121892-12-rppt@kernel.org>
In-Reply-To: <20230616085038.4121892-12-rppt@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 16 Jun 2023 13:18:48 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5N3RuBijpyXrzVk_mpAyUQ5TeTuS2jic6Y-ybFVJpBjg@mail.gmail.com>
Message-ID: <CAPhsuW5N3RuBijpyXrzVk_mpAyUQ5TeTuS2jic6Y-ybFVJpBjg@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] x86/ftrace: enable dynamic ftrace without CONFIG_MODULES
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
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nadav Amit <nadav.amit@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 1:52=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Dynamic ftrace must allocate memory for code and this was impossible
> without CONFIG_MODULES.
>
> With execmem separated from the modules code, execmem_text_alloc() is
> available regardless of CONFIG_MODULES.
>
> Remove dependency of dynamic ftrace on CONFIG_MODULES and make
> CONFIG_DYNAMIC_FTRACE select CONFIG_EXECMEM in Kconfig.
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Acked-by: Song Liu <song@kernel.org>

> ---
>  arch/x86/Kconfig         |  1 +
>  arch/x86/kernel/ftrace.c | 10 ----------
>  2 files changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 53bab123a8ee..ab64bbef9e50 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -35,6 +35,7 @@ config X86_64
>         select SWIOTLB
>         select ARCH_HAS_ELFCORE_COMPAT
>         select ZONE_DMA32
> +       select EXECMEM if DYNAMIC_FTRACE
>
>  config FORCE_DYNAMIC_FTRACE
>         def_bool y
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index f77c63bb3203..a824a5d3b129 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -261,8 +261,6 @@ void arch_ftrace_update_code(int command)
>  /* Currently only x86_64 supports dynamic trampolines */
>  #ifdef CONFIG_X86_64
>
> -#ifdef CONFIG_MODULES
> -/* Module allocation simplifies allocating memory for code */
>  static inline void *alloc_tramp(unsigned long size)
>  {
>         return execmem_text_alloc(size);
> @@ -271,14 +269,6 @@ static inline void tramp_free(void *tramp)
>  {
>         execmem_free(tramp);
>  }
> -#else
> -/* Trampolines can only be created if modules are supported */
> -static inline void *alloc_tramp(unsigned long size)
> -{
> -       return NULL;
> -}
> -static inline void tramp_free(void *tramp) { }
> -#endif
>
>  /* Defined as markers to the end of the ftrace default trampolines */
>  extern void ftrace_regs_caller_end(void);
> --
> 2.35.1
>
