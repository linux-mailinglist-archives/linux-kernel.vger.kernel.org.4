Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A9F70F55E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjEXLec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjEXLeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:34:31 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EE812E;
        Wed, 24 May 2023 04:34:29 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q1ml8-0000gO-RQ; Wed, 24 May 2023 13:34:26 +0200
Message-ID: <175578ec-9dec-7a9c-8d3a-43f24ff86b92@leemhuis.info>
Date:   Wed, 24 May 2023 13:34:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: build error while building arch/x86/purgatory/sha256.o: invalid
 'asm': operand is not a condition code [...]
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1684928069;8444b3c6;
X-HE-SMSGID: 1q1ml8-0000gO-RQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! My linux-next builds for Fedora[1] since yesterday fail with the
following error:

> In file included from <command-line>:
> ./include/crypto/sha256_base.h: In function ‘lib_sha256_base_do_update.constprop.isra’:
> ././include/linux/compiler_types.h:332:20: error: invalid 'asm': operand is not a condition code, invalid operand code 'c'
>   332 | #define asm_inline asm __inline
>       |                    ^~~

See below for the full error message[2]. This happens on Fedora rawhide
and 38 (both use gcc13), but not on Fedora 37 (which uses gcc12).

Is this known already or do I have to bisect this?

Ciao, Thorsten

[1] https://copr.fedorainfracloud.org/coprs/g/kernel-vanilla/next/

[2]
> # CC      arch/x86/purgatory/sha256.o
>  
> gcc -Wp,-MMD,arch/x86/purgatory/.sha256.o.d -nostdinc
> -I./arch/x86/include -I./arch/x86/include/generated  -I./include
> -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi
> -I./include/uapi -I./include/generated/uapi -include
> ./include/linux/compiler-version.h -include ./include/linux/kconfig.h
> -include ./include/linux/compiler_types.h -D__KERNEL__
> -fmacro-prefix-map=./= -Wall -Wundef -Werror=strict-prototypes
> -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE
> -Werror=implicit-function-declaration -Werror=implicit-int
> -Werror=return-type -Wno-format-security -funsigned-char -std=gnu11
> -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -fcf-protection=branch
> -fno-jump-tables -m64 -falign-jumps=1 -falign-loops=1 -mno-80387
> -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup
> -mtune=generic -mno-red-zone -Wno-sign-compare
> -fno-asynchronous-unwind-tables -fno-jump-tables -mharden-sls=all
> -fpatchable-function-entry=16,16 -fno-delete-null-pointer-checks
> -Wno-frame-address -Wno-format-truncation -Wno-format-overflow
> -Wno-address-of-packed-member -O2 -fno-allow-store-data-races
> -Wframe-larger-than=2048 -Wno-main -Wno-unused-but-set-variable
> -Wno-unused-const-variable -Wno-dangling-pointer
> -ftrivial-auto-var-init=zero -fno-stack-clash-protection
> -DCC_USING_FENTRY -falign-functions=16 -Wdeclaration-after-statement
> -Wvla -Wno-pointer-sign -Wcast-function-type -fstrict-flex-arrays=3
> -Wno-stringop-truncation -Wno-stringop-overflow -Wno-restrict
> -Wno-maybe-uninitialized -Wno-array-bounds -Wno-alloc-size-larger-than
> -Wimplicit-fallthrough=5 -fno-strict-overflow -fno-stack-check
> -fconserve-stack -Werror=date-time -Werror=incompatible-pointer-types
> -Werror=designated-init -Wno-packed-not-aligned -g -D__DISABLE_EXPORTS
> -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
> -DDISABLE_BRANCH_PROFILING -fno-stack-protector
> -DKBUILD_MODFILE='"arch/x86/purgatory/sha256"'
> -DKBUILD_BASENAME='"sha256"' -DKBUILD_MODNAME='"sha256"'
> -D__KBUILD_MODNAME=kmod_sha256 -c -o arch/x86/purgatory/sha256.o
> lib/crypto/sha256.c
>
> In file included from <command-line>:
> ./include/crypto/sha256_base.h: In function ‘lib_sha256_base_do_update.constprop.isra’:
> ././include/linux/compiler_types.h:332:20: error: invalid 'asm': operand is not a condition code, invalid operand code 'c'
>   332 | #define asm_inline asm __inline
>       |                    ^~~
> ./arch/x86/include/asm/bug.h:28:9: note: in expansion of macro ‘asm_inline’
>    28 |         asm_inline volatile("1:\t" ins "\n"                             \
>       |         ^~~~~~~~~~
> ./arch/x86/include/asm/bug.h:83:9: note: in expansion of macro ‘_BUG_FLAGS’
>    83 |         _BUG_FLAGS(ASM_UD2, __flags, ASM_REACHABLE);            \
>       |         ^~~~~~~~~~
> ./include/asm-generic/bug.h:107:17: note: in expansion of macro ‘__WARN_FLAGS’
>   107 |                 __WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
>       |                 ^~~~~~~~~~~~
> ./include/asm-generic/bug.h:134:17: note: in expansion of macro ‘__WARN_printf’
>   134 |                 __WARN_printf(TAINT_WARN, format);                      \
>       |                 ^~~~~~~~~~~~~
> ./include/linux/once_lite.h:31:25: note: in expansion of macro ‘WARN’
>    31 |                         func(__VA_ARGS__);                              \
>       |                         ^~~~
> ./include/asm-generic/bug.h:152:9: note: in expansion of macro ‘DO_ONCE_LITE_IF’
>   152 |         DO_ONCE_LITE_IF(condition, WARN, 1, format)
>       |         ^~~~~~~~~~~~~~~
> ./include/linux/fortify-string.h:641:9: note: in expansion of macro ‘WARN_ONCE’
>   641 |         WARN_ONCE(fortify_memcpy_chk(__fortify_size, __p_size,          \
>       |         ^~~~~~~~~
> ./include/linux/fortify-string.h:693:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>   693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> ./include/crypto/sha256_base.h:69:17: note: in expansion of macro ‘memcpy’
>    69 |                 memcpy(sctx->buf + partial, data, len);
>       |                 ^~~~~~
> make[3]: *** [arch/x86/purgatory/Makefile:13: arch/x86/purgatory/sha256.o] Error 1
> make[2]: *** [scripts/Makefile.build:494: arch/x86/purgatory] Error 2
> make[1]: *** [scripts/Makefile.build:494: arch/x86] Error 2
> make: *** [Makefile:2032: .] Error 2
