Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E7D613CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJaR6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJaR6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:58:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC3925D2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:58:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BC2161358
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 17:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42533C433D6;
        Mon, 31 Oct 2022 17:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667239124;
        bh=6k2VQy1WA5DlnNEe5C6X3CH+VCbSwygDOtxVDwcHUxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TG3DxQsxTlcQfXVv7G4OFe4KJMjGMhM0EI8q77eUAjnNDZPO3drtH5yiToccym/Ba
         MGUyKb0gPaJC5nmCymcOKRi4vmVrZsr9fvhxwV+HQptia9Jq3DToqW5xW2FXxxi+ma
         Jlt/XrBdfjs3zzz+4OFy3ZRqnbNzMjYLP5d9z7Lx1jwwzVMzClc0h5KTkg58RjnIQj
         dJO/i8/n6Mz8rQZqdMwS04c65w/rv83/xpRmtX/xDEsGeahktfvGEwO/4iICiUGaru
         0fXQwHH67hG4RWHhMspJxFALhErCWudYh2GKeOoQ70SYboE1TPhVyz/Qb5TTa21gNM
         ZsWLHtcqSAccA==
Date:   Tue, 1 Nov 2022 01:49:01 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Samuel Holland <samuel@sholland.org>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v2] riscv: jump_label: mark arguments as const to satisfy
 asm constraints
Message-ID: <Y2AKjYEcIpvwxe7h@xhacker>
References: <20221008145437.491-1-jszhang@kernel.org>
 <Y0bA8HUL9eC3Dp8C@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0bA8HUL9eC3Dp8C@wendy>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 02:28:16PM +0100, Conor Dooley wrote:
> Hey Jisheng,

Hi Conor,

> LKP reported an error that seems to only have gone to myself & Samuel,
> but the branch it's complaining about is your v1:
> https://lore.kernel.org/lkml/202210122123.Cc4FPShJ-lkp@intel.com/
> 
> Any idea what the story is here?

I tried the config in the link, I can reproduce the build error w/
and w/o the my patch. So I think the root cause of the build error
is a different story. I have a fix in local repo, will send it out
soon.

Thanks

> 
> Thanks,
> Conor.
> 
> On Sat, Oct 08, 2022 at 10:54:37PM +0800, Jisheng Zhang wrote:
> > Samuel reported that the static branch usage in cpu_relax() breaks
> > building with CONFIG_CC_OPTIMIZE_FOR_SIZE:
> > 
> > In file included from <command-line>:
> > ./arch/riscv/include/asm/jump_label.h: In function 'cpu_relax':
> > ././include/linux/compiler_types.h:285:33: warning: 'asm' operand 0
> > probably does not match constraints
> >   285 | #define asm_volatile_goto(x...) asm goto(x)
> >       |                                 ^~~
> > ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro
> > 'asm_volatile_goto'
> >    41 |         asm_volatile_goto(
> >       |         ^~~~~~~~~~~~~~~~~
> > ././include/linux/compiler_types.h:285:33: error: impossible constraint
> > in 'asm'
> >   285 | #define asm_volatile_goto(x...) asm goto(x)
> >       |                                 ^~~
> > ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro
> > 'asm_volatile_goto'
> >    41 |         asm_volatile_goto(
> >       |         ^~~~~~~~~~~~~~~~~
> > make[1]: *** [scripts/Makefile.build:249:
> > arch/riscv/kernel/vdso/vgettimeofday.o] Error 1
> > make: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2
> > 
> > Maybe "-Os" prevents GCC from detecting that the key/branch arguments
> > can be treated as constants and used as immediate operands. Inspired
> > by x86's commit 864b435514b2("x86/jump_label: Mark arguments as const to
> > satisfy asm constraints"), and as pointed out by Steven: "The "i"
> > constraint needs to be a constant.", let's do similar modifications to
> > riscv.
> > 
> > Tested by CC_OPTIMIZE_FOR_SIZE + gcc and CC_OPTIMIZE_FOR_SIZE + clang.
> > 
> > Link: https://lore.kernel.org/linux-riscv/20220922060958.44203-1-samuel@sholland.org/
> > Link: https://lore.kernel.org/all/20210212094059.5f8d05e8@gandalf.local.home/
> > Fixes: 8eb060e10185 ("arch/riscv: add Zihintpause support")
> > Reported-by: Samuel Holland <samuel@sholland.org>
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> > 
> > since v1:
> >  - add Reported-by, Reviewed-by, Fixes and Link tag
> > 
> >  arch/riscv/include/asm/jump_label.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/jump_label.h b/arch/riscv/include/asm/jump_label.h
> > index 38af2ec7b9bf..6d58bbb5da46 100644
> > --- a/arch/riscv/include/asm/jump_label.h
> > +++ b/arch/riscv/include/asm/jump_label.h
> > @@ -14,8 +14,8 @@
> >  
> >  #define JUMP_LABEL_NOP_SIZE 4
> >  
> > -static __always_inline bool arch_static_branch(struct static_key *key,
> > -					       bool branch)
> > +static __always_inline bool arch_static_branch(struct static_key * const key,
> > +					       const bool branch)
> >  {
> >  	asm_volatile_goto(
> >  		"	.option push				\n\t"
> > @@ -35,8 +35,8 @@ static __always_inline bool arch_static_branch(struct static_key *key,
> >  	return true;
> >  }
> >  
> > -static __always_inline bool arch_static_branch_jump(struct static_key *key,
> > -						    bool branch)
> > +static __always_inline bool arch_static_branch_jump(struct static_key * const key,
> > +						    const bool branch)
> >  {
> >  	asm_volatile_goto(
> >  		"	.option push				\n\t"
> > -- 
> > 2.37.2
> > 
