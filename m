Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84116FA1E8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjEHIGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjEHIG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:06:28 -0400
Received: from out0-220.mail.aliyun.com (out0-220.mail.aliyun.com [140.205.0.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7663F2
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 01:06:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047199;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---.SbQKevv_1683533179;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.SbQKevv_1683533179)
          by smtp.aliyun-inc.com;
          Mon, 08 May 2023 16:06:20 +0800
Date:   Mon, 08 May 2023 16:06:19 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Fangrui Song <maskray@google.com>
Subject: Re: [PATCH RFC 16/43] x86-64: Use per-cpu stack canary if supported
 by compiler
Message-ID: <20230508080619.GA27247@k08j02272.eu95sqa>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
 <7cee0c83225ffd8cf8fd0065bea9348f6db3b12a.1682673543.git.houwenlong.hwl@antgroup.com>
 <CAKwvOd=zgjWdg2+_bg3QByh_2hve8yoKzCfEBZ5md+k8ytkqcQ@mail.gmail.com>
 <20230505061420.GB103506@k08j02272.eu95sqa>
 <CAKwvOdkWt8FpqegyaGRNdF067dwwFEGze-nqR+yF=TA1FnTozg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdkWt8FpqegyaGRNdF067dwwFEGze-nqR+yF=TA1FnTozg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2023 at 02:02:25AM +0800, Nick Desaulniers wrote:
> On Thu, May 4, 2023 at 11:14 PM Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> >
> > On Tue, May 02, 2023 at 01:27:53AM +0800, Nick Desaulniers wrote:
> > > On Fri, Apr 28, 2023 at 2:52 AM Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
> > > >
> > > > +config CC_HAS_CUSTOMIZED_STACKPROTECTOR
> > > > +       bool
> > > > +       # Although clang supports -mstack-protector-guard-reg option, it
> > > > +       # would generate GOT reference for __stack_chk_guard even with
> > > > +       # -fno-PIE flag.
> > > > +       default y if (!CC_IS_CLANG && $(cc-option,-mstack-protector-guard-reg=gs))
> > >
> > > Hi Hou,
> > > I've filed this bug against LLVM and will work with LLVM folks at
> > > Intel to resolve:
> > > https://github.com/llvm/llvm-project/issues/62481
> > > Can you please review that report and let me know here or there if I
> > > missed anything? Would you also mind including a link to that in the
> > > comments in the next version of this patch?
> > >
> > Hi Nick,
> >
> > Thanks for your help, I'll include the link in the next version.
> > Actually, I had post an issue on github too when I test the patch on
> > LLVM. But no replies. :(.
> 
> Ah, sorry about that.  The issue tracker is pretty high volume and
> stuff gets missed.  With many users comes many bug reports.  We could
> be better about triage though.  If it's specific to the Linux kernel,
> https://github.com/ClangBuiltLinux/linux/issues is a better issue
> tracker to use; we can move bug reports upstream to
> https://github.com/llvm/llvm-project/issues/ when necessary. It's
> linked off of clangbuiltlinux.github.io if you lose it.
> 
> > https://github.com/llvm/llvm-project/issues/60116
> >
> > There is another problem I met for this patch, some unexpected code
> > are generated:
> >
> > do_one_initcall: (init/main.o)
> > ......
> > movq    __stack_chk_guard(%rip), %rax
> > movq    %rax,0x2b0(%rsp)
> >
> > The complier generates wrong instruction, no GOT reference and gs
> > register. I only see it in init/main.c file. I have tried to move the
> > function into another file and compiled it with same cflags. It could
> > generate right instruction for the function in another file.
> 
> The wrong instruction or the wrong operand?  This is loading the
> canary into the stack slot in the fn prolog.  Perhaps the expected
> cflag is not getting set (or being removed) from init/main.c? You
> should be able to do:
> 
> $ make LLVM=1 init/main.o V=1
> 
> to see how clang was invoked to see if the expected flag was there, or not.
>
Hi Nick,
The ouput is:
  clang -Wp,-MMD,init/.main.o.d  -nostdinc -I./arch/x86/include
-I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi
-I./arch/x86/include/generated/uapi -I./include/uapi
-I./include/generated/uapi -include ./include/linux/compiler-version.h
-include ./include/linux/kconfig.h -include
./include/linux/compiler_types.h -D__KERNEL__ -Werror
-fmacro-prefix-map=./= -Wall -Wundef -Werror=strict-prototypes
-Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE
-Werror=implicit-function-declaration -Werror=implicit-int
-Werror=return-type -Wno-format-security -funsigned-char -std=gnu11
--target=x86_64-linux-gnu -fintegrated-as -Werror=unknown-warning-option
-Werror=ignored-optimization-argument -Werror=option-ignored
-Werror=unused-command-line-argument -mno-sse -mno-mmx -mno-sse2
-mno-3dnow -mno-avx -fcf-protection=branch -fno-jump-tables -m64
-falign-loops=1 -mno-80387 -mno-fp-ret-in-387 -mstack-alignment=8
-mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel
-mstack-protector-guard-reg=gs
-mstack-protector-guard-symbol=__stack_chk_guard -Wno-sign-compare
-fno-asynchronous-unwind-tables -mretpoline-external-thunk
-mfunction-return=thunk-extern -fpatchable-function-entry=16,16
-fno-delete-null-pointer-checks -Wno-frame-address
-Wno-address-of-packed-member -O2 -Wframe-larger-than=2048
-fstack-protector-strong -Wno-gnu -Wno-unused-but-set-variable
-Wno-unused-const-variable -fomit-frame-pointer
-ftrivial-auto-var-init=zero
-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
-fno-stack-clash-protection -falign-functions=16
-Wdeclaration-after-statement -Wvla -Wno-pointer-sign
-Wcast-function-type -Wimplicit-fallthrough -fno-strict-overflow
-fno-stack-check -Werror=date-time -Werror=incompatible-pointer-types
-Wno-initializer-overrides -Wno-format -Wformat-extra-args
-Wformat-invalid-specifier -Wformat-zero-length -Wnonnull
-Wformat-insufficient-args -Wno-sign-compare -Wno-pointer-to-enum-cast
-Wno-tautological-constant-out-of-range-compare -Wno-unaligned-access
-fno-function-sections -fno-data-sections
-DKBUILD_MODFILE='"init/main"' -DKBUILD_BASENAME='"main"'
-DKBUILD_MODNAME='"main"' -D__KBUILD_MODNAME=kmod_main -c -o init/main.o
init/main.c

I see the expected flags in the ouput. But the generated code is wrong:
00000000000006e0 <do_one_initcall>: (init/main.o)
     .......
     6ff: 48 8b 05 00 00 00 00          movq    (%rip), %rax # 0x706 <do_one_initcall+0x26>
                0000000000000702:  R_X86_64_PC32 __stack_chk_guard-0x4
     706: 48 89 84 24 e0 02 00 00       movq    %rax, 736(%rsp)

The expected generated code should be:
0000000000000010 <name_to_dev_t>: (init/do_mounts.o)
      ......
      2c: 4c 8b 25 00 00 00 00          movq    (%rip), %r12 # 0x33 <name_to_dev_t+0x23>
                000000000000002f:  R_X86_64_REX_GOTPCRELX __stack_chk_guard-0x4
      33: 65 49 8b 04 24                movq    %gs:(%r12), %rax
      38: 48 89 44 24 30                movq    %rax, 48(%rsp)

Actually, this is the main reason why I disable per-cpu stack canary on
LLVM. This patch could be picked separately, if you have time to help me
find out the reason.

Thanks.
> >
> > The LLVM chain toolsare built by myself:
> > clang version 15.0.7 (https://github.com/llvm/llvm-project.git
> > 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> 
> Perhaps worth rebuilding with top of tree, which is clang 17.
> 
> >
> > > Less relevant issues I filed looking at some related codegen:
> > > https://github.com/llvm/llvm-project/issues/62482
> > > https://github.com/llvm/llvm-project/issues/62480
> > >
> > > And we should probably look into:
> > > https://github.com/llvm/llvm-project/issues/22476
> > >
> > >
> >
> > Except for per-cpu stack canary patch, there is another issue I post on
> > github: https://github.com/llvm/llvm-project/issues/60096
> 
> Thanks, I'll bring that up with Intel, too.
> 
> >
> > The related patch is:
> > https://lore.kernel.org/lkml/175116f75c38c15d8d73a03301eab805fea13a0a.1682673543.git.houwenlong.hwl@antgroup.com/
> >
> > I couldn't find the related documentation about that, hope you can help
> > me too.
> >
> > One more problem that I didn't post is:
> > https://lore.kernel.org/lkml/8d6bbaf66b90cf1a8fd2c5da98f5e094b9ffcb27.1682673543.git.houwenlong.hwl@antgroup.com/
> 
> Mind filing another bug for this in llvm's issue tracker? We can
> discuss there if LLD needs to be doing something different.
> 
> Thanks for uncovering these and helping us get them fixed up!
> -- 
> Thanks,
> ~Nick Desaulniers
