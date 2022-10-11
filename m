Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572605FADA0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 09:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJKHjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 03:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJKHjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 03:39:40 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B361B0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 00:39:35 -0700 (PDT)
Received: from p5b127dea.dip0.t-ipconnect.de ([91.18.125.234] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oi9r9-0007Gg-5z; Tue, 11 Oct 2022 09:39:15 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-riscv@lists.infradead.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Samuel Holland <samuel@sholland.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v2] riscv: jump_label: mark arguments as const to satisfy asm constraints
Date:   Tue, 11 Oct 2022 09:39:14 +0200
Message-ID: <2905332.q0ZmV6gNhb@phil>
In-Reply-To: <20221008145437.491-1-jszhang@kernel.org>
References: <20221008145437.491-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 8. Oktober 2022, 16:54:37 CEST schrieb Jisheng Zhang:
> Samuel reported that the static branch usage in cpu_relax() breaks
> building with CONFIG_CC_OPTIMIZE_FOR_SIZE:
> 
> In file included from <command-line>:
> ./arch/riscv/include/asm/jump_label.h: In function 'cpu_relax':
> ././include/linux/compiler_types.h:285:33: warning: 'asm' operand 0
> probably does not match constraints
>   285 | #define asm_volatile_goto(x...) asm goto(x)
>       |                                 ^~~
> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro
> 'asm_volatile_goto'
>    41 |         asm_volatile_goto(
>       |         ^~~~~~~~~~~~~~~~~
> ././include/linux/compiler_types.h:285:33: error: impossible constraint
> in 'asm'
>   285 | #define asm_volatile_goto(x...) asm goto(x)
>       |                                 ^~~
> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro
> 'asm_volatile_goto'
>    41 |         asm_volatile_goto(
>       |         ^~~~~~~~~~~~~~~~~
> make[1]: *** [scripts/Makefile.build:249:
> arch/riscv/kernel/vdso/vgettimeofday.o] Error 1
> make: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2
> 
> Maybe "-Os" prevents GCC from detecting that the key/branch arguments
> can be treated as constants and used as immediate operands. Inspired
> by x86's commit 864b435514b2("x86/jump_label: Mark arguments as const to
> satisfy asm constraints"), and as pointed out by Steven: "The "i"
> constraint needs to be a constant.", let's do similar modifications to
> riscv.
> 
> Tested by CC_OPTIMIZE_FOR_SIZE + gcc and CC_OPTIMIZE_FOR_SIZE + clang.
> 
> Link: https://lore.kernel.org/linux-riscv/20220922060958.44203-1-samuel@sholland.org/
> Link: https://lore.kernel.org/all/20210212094059.5f8d05e8@gandalf.local.home/
> Fixes: 8eb060e10185 ("arch/riscv: add Zihintpause support")
> Reported-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

I ran into the same build-issue when enabling CC_OPTIMIZE_FOR_SIZE
and this patch fixes it, so

Tested-by: Heiko Stuebner <heiko@sntech.de>




