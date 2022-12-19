Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6BE650A46
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiLSKlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiLSKlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:41:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB98C6;
        Mon, 19 Dec 2022 02:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IFPbzfUdrDLPsI6Yh+be7PnQrtmthWZZnt5l8XeTNK8=; b=WksacInf7Ol45SQs7nMlR4j8Yy
        ePN7+1E4lzz+ySEpmFHlDJU3/HzJQtQVqhDOSs//Ud4ViZ8UTtOv8kw24I2DTRJ/mnuBjH7bPsfl/
        hESqLCr18tpGKf4F4Ovg5vxJRUktTGNqlxRfIz/yvzw+ZV1dRqnRw9MbVuFlj1/2ToT5WA/OCPv4O
        ltyOn8cuvIwHfbspMuS9dUDCRZjL2aXuhxQq9maiz9yyJYgLxyyccA10rlRCfhczSxcBr0uZiAmB2
        Le8I0NMnMRliDR7/Mg8xG1fRT7hHpcy8xCkNCVrv0Cd6zEf5ufuT7KrRoy/LRYYmj1vU027Vm/wux
        H75Z0zHQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7DZQ-000cjH-9m; Mon, 19 Dec 2022 10:40:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A36223001D6;
        Mon, 19 Dec 2022 11:40:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 81968202FE504; Mon, 19 Dec 2022 11:40:19 +0100 (CET)
Date:   Mon, 19 Dec 2022 11:40:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Li <ashimida.1990@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <Y6A/k7/KrCCDuux6@hirez.programming.kicks-ass.net>
References: <20221219061758.23321-1-ashimida.1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219061758.23321-1-ashimida.1990@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 10:17:58PM -0800, Dan Li wrote:

> In the compiler part[4], there are some differences from Sami's
> implementation[3], mainly including:
> 
> 1. When a typeid mismatch is detected, the cfi_check_failed function
>    will be called instead of the brk instruction. This function needs
>    to be implemented by the compiler user.
>    If there are user mode programs or other systems that want to use
>    this feature, it may be more convenient to use a callback (so this
>    compilation option is set to -fsanitize=cfi instead of kcfi).

This is not going to be acceptible for x86_64.

> 2. A reserved typeid (such as 0x0U on the aarch64 platform) is always
>    inserted in front of functions that should not be called indirectly.
>    Functions that can be called indirectly will not use this hash value,
>    which prevents instructions/data before the function from being used
>    as a typeid by an attacker.
> 
> 3. Some bits are ignored in the typeid to avoid conflicts between the
>    typeid and the instruction set of a specific platform, thereby
>    preventing an attacker from bypassing the CFI check by using the
>    instruction as a typeid, such as on the aarch64 platform:
>    * If the following instruction sequence exists:
> 	  400620:       a9be7bfd        stp     x29, x30, [sp, #-32]!
> 	  400624:       910003fd        mov     x29, sp
> 	  400628:       f9000bf3        str     x19, [sp, #16]
>    * If the expected typeid of the indirect call is exactly 0x910003fd,
>      the attacker can jump to the next instruction position of any
>      "mov x29,sp" instruction (such as 0x400628 here).
> 
> 4. Insert a symbol __cfi_<function> before each function's typeid,
>    which may be helpful for fine-grained KASLR implementations (or not?).
> 
> 5. The current implementation of gcc only supports the aarch64 platform.

What, if any, are the plans for x86_64 support?
