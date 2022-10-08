Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930BF5F8586
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 16:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJHOEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 10:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJHOEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 10:04:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4A1BE0E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 07:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F829B80AEE
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 14:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E921C433D6;
        Sat,  8 Oct 2022 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665237885;
        bh=GOGHwqAqL5S8D2cBZguxt8zHGahgZPhATTi6qcess1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pTTSZv1OF1epBnqirqFQfeU9NrnMEBbu7bvRWQpc6mLkbEnOl7AErepvl2sxZPpF8
         Sl+MYeiLKnYntW1woVs0BnVZrDI/NMx4+qmaGjM0b/rV6xZsTKJ/VzWDCyn97qGyqh
         cNpEeNIEVYbLmQ5ChCZaZOLnLn1XiE1QmjKNS70rXkDw82VXX0veD9gsjc8dw1ofws
         6y3jsHRy0izLxlwAL0wNNx7AiNjvMUal40NdXIQROD4fjtNXSemF/tvJzPP2VKqX0F
         17dJwDWzayPMDlkwIiCa4+BmrhmDozjVoCkXcueLbMdeL1Z3eNryrTEhnCjeyD+QUg
         LW4hlt3ZM4pYA==
Date:   Sat, 8 Oct 2022 21:55:07 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
        rostedt@goodmis.org, ajones@ventanamicro.com, ardb@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, samuel@sholland.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] riscv: jump_label: mark arguments as const to satisfy
 asm constraints
Message-ID: <Y0GBO77e2Lu/khkI@xhacker>
References: <20221006064028.548-1-jszhang@kernel.org>
 <20221006124144.abaz74g7nxrb5hxj@kamzik>
 <4c8fa16a-8463-ee32-7307-0383fa94403c@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c8fa16a-8463-ee32-7307-0383fa94403c@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 12:44:32PM +0000, Conor.Dooley@microchip.com wrote:
> On 06/10/2022 13:41, Andrew Jones wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Thu, Oct 06, 2022 at 02:40:28PM +0800, Jisheng Zhang wrote:
> >> Samuel reported that the static branch usage in cpu_relax() breaks
> >> building with CONFIG_CC_OPTIMIZE_FOR_SIZE[1]:
> >>
> >> In file included from <command-line>:
> >> ./arch/riscv/include/asm/jump_label.h: In function 'cpu_relax':
> >> ././include/linux/compiler_types.h:285:33: warning: 'asm' operand 0
> >> probably does not match constraints
> >>    285 | #define asm_volatile_goto(x...) asm goto(x)
> >>        |                                 ^~~
> >> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro
> >> 'asm_volatile_goto'
> >>     41 |         asm_volatile_goto(
> >>        |         ^~~~~~~~~~~~~~~~~
> >> ././include/linux/compiler_types.h:285:33: error: impossible constraint
> >> in 'asm'
> >>    285 | #define asm_volatile_goto(x...) asm goto(x)
> >>        |                                 ^~~
> >> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro
> >> 'asm_volatile_goto'
> >>     41 |         asm_volatile_goto(
> >>        |         ^~~~~~~~~~~~~~~~~
> >> make[1]: *** [scripts/Makefile.build:249:
> >> arch/riscv/kernel/vdso/vgettimeofday.o] Error 1
> >> make: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2
> >>
> >> Maybe "-Os" prevents GCC from detecting that the key/branch arguments
> >> can be treated as constants and used as immediate operands. Inspired
> >> by x86's commit 864b435514b2("x86/jump_label: Mark arguments as const to
> >> satisfy asm constraints"), and as pointed out by Steven in [2] "The "i"
> >> constraint needs to be a constant.", let's do similar modifications to
> >> riscv.
> >>
> >> Tested by CC_OPTIMIZE_FOR_SIZE + gcc and CC_OPTIMIZE_FOR_SIZE + clang.
> >>
> >> [1]https://lore.kernel.org/linux-riscv/20220922060958.44203-1-samuel@sholland.org/
> >> [2]https://lore.kernel.org/all/20210212094059.5f8d05e8@gandalf.local.home/
> 
> Hey Jisheng,

Hi,

> 
> Could you please make these normal link tags.?

How to make these link tags? I just used the permalink in
lore.kernel.org

> Also could you please add the reported-by from samuel & a fixes tag?

I will add Reported-by tag, but I'm not sure whether fixes tag
is suitable, and which commit I could use? commit 8eb060e1018
("arch/riscv: add Zihintpause support")?
> 
> Thanks,
> Conor.
> 
> >> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> >> ---
> >>   arch/riscv/include/asm/jump_label.h | 8 ++++----
> >>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/riscv/include/asm/jump_label.h b/arch/riscv/include/asm/jump_label.h
> >> index 38af2ec7b9bf..6d58bbb5da46 100644
> >> --- a/arch/riscv/include/asm/jump_label.h
> >> +++ b/arch/riscv/include/asm/jump_label.h
> >> @@ -14,8 +14,8 @@
> >>
> >>   #define JUMP_LABEL_NOP_SIZE 4
> >>
> >> -static __always_inline bool arch_static_branch(struct static_key *key,
> >> -                                            bool branch)
> >> +static __always_inline bool arch_static_branch(struct static_key * const key,
> >> +                                            const bool branch)
> >>   {
> >>        asm_volatile_goto(
> >>                "       .option push                            \n\t"
> >> @@ -35,8 +35,8 @@ static __always_inline bool arch_static_branch(struct static_key *key,
> >>        return true;
> >>   }
> >>
> >> -static __always_inline bool arch_static_branch_jump(struct static_key *key,
> >> -                                                 bool branch)
> >> +static __always_inline bool arch_static_branch_jump(struct static_key * const key,
> >> +                                                 const bool branch)
> >>   {
> >>        asm_volatile_goto(
> >>                "       .option push                            \n\t"
> >> --
> >> 2.37.2
> >>
> > 
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
