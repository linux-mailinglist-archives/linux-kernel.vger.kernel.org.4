Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4675E6E18A2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDNAKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDNAKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:10:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD4830DA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 17:10:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PyGzZ1vVRz4xFL;
        Fri, 14 Apr 2023 10:10:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1681431004;
        bh=Q7KsgvqsLrWieFE7M07Ww7Bl5ImVflY8xEb93QACjIM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cOakumuv2DjMHDtWx/3C7Bm8wh4VSwSsx3518og5iYSSg0pD9S3WJFg7I+mgCDrFu
         wZwi4kVFHfCq94qKXCqycy8qQXmrxMkDiblK2Ckw1BzF5ewdHJyhfx++hCNzaDcu0e
         7lAN8OwhnL7WBqzzbBPCf/RcQ+PrJHBGiNKdSEMy5dYNhyLT4Rh/nDxciblhzGJc7v
         d8JvTZTLQsad1SCrBuXuj2ZcHXLnynbCLIBIoP4+05mcYjf+FHPYGvkRV3YXF4X+Mh
         eE7nMbDGAOv3TlCO1VKQJML9x10idZmDNRTYe9joFzNXSKh6u3CXXR0T52LP1MN8w/
         ISD8y/0082nOg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     ndesaulniers@google.com, "Borislav Petkov (AMD)" <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 1/2] start_kernel: add no_stack_protector fn attr
In-Reply-To: <20230412-no_stackp-v1-1-46a69b507a4b@google.com>
References: <20230412-no_stackp-v1-0-46a69b507a4b@google.com>
 <20230412-no_stackp-v1-1-46a69b507a4b@google.com>
Date:   Fri, 14 Apr 2023 10:09:58 +1000
Message-ID: <87r0sn9ve1.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ndesaulniers@google.com writes:
> Back during the discussion of
> commit a9a3ed1eff36 ("x86: Fix early boot crash on gcc-10, third try")
> we discussed the need for a function attribute to control the omission
> of stack protectors on a per-function basis; at the time Clang had
> support for no_stack_protector but GCC did not. This was fixed in
> gcc-11. Now that the function attribute is available, let's start using
> it.
>
> Callers of boot_init_stack_canary need to use this function attribute
> unless they're compiled with -fno-stack-protector, otherwise the canary
> stored in the stack slot of the caller will differ upon the call to
> boot_init_stack_canary. This will lead to a call to __stack_chk_fail
> then panic.
>
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94722
> Link: https://lore.kernel.org/all/20200316130414.GC12561@hirez.programming.kicks-ass.net/
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/powerpc/kernel/smp.c           |  1 +
>  include/linux/compiler_attributes.h | 12 ++++++++++++
>  init/main.c                         |  3 ++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 6b90f10a6c81..7d4c12b1abb7 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1603,6 +1603,7 @@ static void add_cpu_to_masks(int cpu)
>  }
>  
>  /* Activate a secondary processor. */
> +__no_stack_protector
>  void start_secondary(void *unused)
>  {
>  	unsigned int cpu = raw_smp_processor_id();

start_secondary() doesn't return, so it won't actually crash, but it
obviously makes sense for it to be marked with __no_stack_protector.

There's quite a few other places we could add __no_stack_protector
annotations in powerpc code, and then make the changes to CFLAGS to
disable stack protector conditional on GCC < 11.

So I guess this patch is fine, but there's more that could be done.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
