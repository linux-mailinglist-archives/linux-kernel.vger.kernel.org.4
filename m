Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CFA6C5352
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjCVSJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjCVSJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:09:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8216C64B38
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE03062214
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA23EC433EF;
        Wed, 22 Mar 2023 18:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679508565;
        bh=rKyFWBTQcPTAVIuUKruObSLtclAXQDlxYQfje95ORrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TyVFQc7wqlWQGlRcU0TuT1nvKcoMi/ban0h9rLhxT3EKvCQ1mhz1X5YUznVkPmJUw
         KLLiNmsFC0Jh52oNMVAVrUYpHH0wMP/lDF03hN0Zts6HKnD4hUZOnXjhWzuSUKBK7U
         //8xvM3ovlHH2+E7B/TX/ZJXjfwv5CqXJKrYAyiKVFd71wxXN6zB3SxEMCY/WvWxMD
         BXjKp4/WVybJiWfSydGfCuzkgjjKVD/oCgRqi0mH2heL8Nzpjxd5lB6kNCEtloJM1E
         wtdwUSERRJ+oSpEbk8luVT/bNNTCsTOVhakgGmCT4/uVG5YNj3bIOsLlybiiLc5apq
         9bLTI8wRLSzeA==
Date:   Wed, 22 Mar 2023 11:09:22 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/11] arm64/static_call: Fix static call CFI
 violations
Message-ID: <20230322180922.htvb2zau2w7oichy@treble>
References: <cover.1679456900.git.jpoimboe@kernel.org>
 <3d8c9e67a7e29f3bed4e44429d953e1ac9c6d5be.1679456900.git.jpoimboe@kernel.org>
 <ZBry75KS3F+a0VM0@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZBry75KS3F+a0VM0@FVFF77S0Q05N>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 12:22:07PM +0000, Mark Rutland wrote:
> > The problem is that the __perf_guest_state() static call does an
> > indirect branch to __static_call_return0(), which isn't CFI-compliant.
> 
> IIUC that'd be broken even with the old CFI mechanism, since commit:
> 
>   87b940a0675e2526 ("perf/core: Use static_call to optimize perf_guest_info_callbacks")
> 
> If so, we probably want a Fixes tag?

Yeah, it should definitely get a Fixes tag.  I wasn't quite sure if this
bug started with the above commit or with the CFI_CLANG switch to kcfi.
And then I forgot to investigate.

> > +/* Generate a CFI-compliant static call NOP function */
> > +#define __ARCH_DEFINE_STATIC_CALL_CFI(name, insns)			\
> > +	asm(".align 4						\n"	\
> > +	    ".word __kcfi_typeid_" name "			\n"	\
> > +	    ".globl " name "					\n"	\
> > +	    name ":						\n"	\
> > +	    "bti c						\n"	\
> > +	    insns "						\n"	\
> > +	    "ret						\n"	\
> > +	    ".type " name ", @function				\n"	\
> > +	    ".size " name ", . - " name "			\n")
> > +
> > +#define __ARCH_DEFINE_STATIC_CALL_RET0_CFI(name)			\
> > +	GEN_CFI_SYM(STATIC_CALL_RET0_CFI(name));			\
> > +	__ARCH_DEFINE_STATIC_CALL_CFI(STATIC_CALL_RET0_CFI_STR(name), "mov x0, xzr")
> 
> This looks correct, but given we're generating a regular functions it's
> unfortunate we can't have the compiler generate the actual code with something
> like:
> 
> #define __ARCH_DEFINE_STATIC_CALL_RET0_CFI(rettype, name, args...)	\
> rettype name(args)							\
> {									\
> 	return (rettype)0;						\
> }
> 
> ... but I guess passing the rettype and args around is painful.

Hm, I hadn't considered that.  I'll play around with it.

> Regardless, I gave this a spin atop v6.3-rc3 using LLVM 16.0.0 and CFI_CLANG,
> and it does seem to work, so:
> 
> Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks!

-- 
Josh
