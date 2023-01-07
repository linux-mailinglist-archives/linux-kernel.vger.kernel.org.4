Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D5E661000
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 16:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjAGPh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 10:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGPhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 10:37:24 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EB343D82;
        Sat,  7 Jan 2023 07:37:23 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9so4809205pll.9;
        Sat, 07 Jan 2023 07:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDmGZxyb74ofTslZ4RiBsZsZcQbDnfGdhk5APp6eMRs=;
        b=FXtAlMhf9oxk2BS3hRJnGA+Z35M1zHAepCr/pNYQhR4hvq3jIwCsnFWZBKLESIbi86
         mAE1BUitRV+Dyy9qGv7XJ/W9qZ6//X0RbZnf9YpNEJqD8c/s8JFL2YfqM4jNMLQEDNeu
         A0SJDsjitCduhGbS/cNZqjnF4/cYjgRwi/twkee2ZkZkbj28mdphTXi8258Dy53yVwO3
         Vp0vxY9lcs7Li/rkvLqtYVqnqOHkDQAKsVV9ep7Wf9CEu6Lo4wn8FD2la7ku4UpPr2qJ
         u40OTEafTGWLRIBk1kHshAxzzplyWyOOSER238Q8fPJ10bclR9LOAa6Kb24Ug9hscb7c
         vw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDmGZxyb74ofTslZ4RiBsZsZcQbDnfGdhk5APp6eMRs=;
        b=WYqXVhVbFArKLkb8obnEW9D0Ii65OAshAW7MTr7PZLH/DqvXsagp2/CBxMU6d6v5Za
         DnfvoIy73YS4dlrLDEvS/TTrpYa8gqv+uuh1oGgcBbO13W1ukMeOxwvLuR6Xwvpxr+oa
         zpK9US4MUAc4VLIUbDsXhhKpKYZ/iY+6QNOqZZPx/6gD0R+AbKO14fbE4c8hpm4X1m33
         n8YglEzm3VKgWc1/PGhYp982wp+ilaXCXQOMuM3xeNNv1fLxU4IqpGOujU0eY7xnMxQq
         ZTOzsu1WyV95Z40EXuEgv+1R3t4Eybc19z2FGCqK0RxgE3fYwSuNIibL8cH/0eRaum+X
         Jr7Q==
X-Gm-Message-State: AFqh2koxOQ2ivQcj+xYJuK8c6VuTJbMbbsrzid7PBBlafqw9fg+yTrsz
        NjaAzDO37H9COOijPrurEFY=
X-Google-Smtp-Source: AMrXdXt6+BA6TF0dfWsIgapu+pu1tyw89wv3yhd2Ckc8NeP9Pz2cJcf6EzanqlPqCmYvAHQ94Zma9A==
X-Received: by 2002:a17:90a:64c9:b0:226:2f1c:f167 with SMTP id i9-20020a17090a64c900b002262f1cf167mr34292797pjm.15.1673105843435;
        Sat, 07 Jan 2023 07:37:23 -0800 (PST)
Received: from localhost ([124.248.219.206])
        by smtp.gmail.com with ESMTPSA id s90-20020a17090a69e300b0022630ba1c80sm2566397pjj.42.2023.01.07.07.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jan 2023 07:37:23 -0800 (PST)
Date:   Sat, 7 Jan 2023 07:37:19 -0800
From:   Dan Li <ashimida.1990@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Marco Elver <elver@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [RFC/RFT] CFI: Add support for gcc CFI in aarch64
Message-ID: <20230107153719.cpuq5yrc7v67f2uy@ubuntu>
References: <20221219061758.23321-1-ashimida.1990@gmail.com>
 <Y7Ps+R4Oqx3xiaVH@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7Ps+R4Oqx3xiaVH@FVFF77S0Q05N>
User-Agent: NeoMutt/20171215
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Sorry for the late reply.

On 01/03, Mark Rutland wrote:
> On Sun, Dec 18, 2022 at 10:17:58PM -0800, Dan Li wrote:
> >    If there are user mode programs or other systems that want to use
> >    this feature, it may be more convenient to use a callback (so this
> >    compilation option is set to -fsanitize=cfi instead of kcfi).
> 
> I appreciate that may be nicer for userspace, but it would be far nicer for the
> kernel if we could have a kcfi mode that behaves the same as LLVM, using a BRK.
> That's going to be simpler for the kernel to deal with, and should result in
> nicer code / smaller binary size (for the reasons given above).
> 
> Can we please have an LLVM-compatible KCFI mode, and have the -fsanitize=cfi be
> a separate option from -fsanitize=kcfi?

Ok, in the next version I will change to the same option as clang :)

> 
> > 2. A reserved typeid (such as 0x0U on the aarch64 platform) is always
> >    inserted in front of functions that should not be called indirectly.
> >    Functions that can be called indirectly will not use this hash value,
> >    which prevents instructions/data before the function from being used
> >    as a typeid by an attacker.
> 
> That sounds sensible, though it meanse we'll need to go audit all the assembly
> without type annotations.
> 
> I presume that "functions that should not be called indirectly" only includes
> those which are not directly visible outside the compilation unit AND whose
> address is never taken / escaped from the compilation unit. Is that the case?

Yes.

> 
> > 3. Some bits are ignored in the typeid to avoid conflicts between the
> >    typeid and the instruction set of a specific platform, thereby
> >    preventing an attacker from bypassing the CFI check by using the
> >    instruction as a typeid, such as on the aarch64 platform:
> >    * If the following instruction sequence exists:
> > 	  400620:       a9be7bfd        stp     x29, x30, [sp, #-32]!
> > 	  400624:       910003fd        mov     x29, sp
> > 	  400628:       f9000bf3        str     x19, [sp, #16]
> >    * If the expected typeid of the indirect call is exactly 0x910003fd,
> >      the attacker can jump to the next instruction position of any
> >      "mov x29,sp" instruction (such as 0x400628 here).
> 
> Which bits exactly are ignored on arm64?
> 
> e.g. are these encoded into UDF immediates?

In aarch64, I currently ignore bit [28:27]. IUCC, according to the manual[1],
it is a UDF instruction only when the upper 16 bits are all 0.
But due to this has too much impact on the entropy of typeid, so I (not
rigorously) only ignore 2 bits here, and most of the instruction codes covered
by it belong to 'Reserved' or 'UNALLOCATED' (probably not a good idea).

But as Kees said, if clang doesn't handle it here, in order to be consistent,
I think it's better for gcc to not handle it when implementing kernel cfi.

[1] https://developer.arm.com/documentation/ddi0602/2022-06/Index-by-Encoding?lang=en

> 
> As a general thing, how does this work with -fpatchable-function-entry=M,N,
> where N is non-zero?
> 
> We still need to fix that for LLVM, and it would be good to align on the same behaviour.
>

Yeah, it makes sense.

Currently, it is consistent with llvm. Taking -fpatchable-function-entry=2,1
as an example, the currently generated code is as follows:

__cfi_main:
        .4byte 0x439d3502
        .global main
        .section        __patchable_function_entries
        .align  3
        .8byte  .LPFE3
        .text
.LPFE3:
        nop
        .type   main, %function
main:
        nop
.LFB2:
        .cfi_startproc
        stp     x29, x30, [sp, -32]!

Finally, do we want to generate code like this?
        nop
        .4byte 0x439d3502
main:
        nop
        ...

Thanks,
Dan.

> >  
> > -- 
> > 2.17.1
> > 
