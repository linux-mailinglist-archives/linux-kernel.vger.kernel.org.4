Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEF268FA4E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 23:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjBHWg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 17:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjBHWgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 17:36:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52FB76BE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 14:36:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 589A9617EB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 22:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72CAC433D2;
        Wed,  8 Feb 2023 22:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675895811;
        bh=kEidWQMWqf0uZA9KGuB36zUTXV7NSr0yKEb0HLUwNN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YqNI5SEXZC6Ho3CyCJa3yOiaQ/K+YMwGerP9K5RyBMtxoyXXS9rULREAuQvd+krcX
         nSJcFA0qWFKlIGw21Rje3kcDXFs0zJKS8U9E8CKIzEIUrWSXhlN9WDgLNTNLahVQ43
         wNRb7CL4KlZPu13Mfc/zAP2RxBdJ40qvnJJwkE8tn2W3OxgTi+Ct3xres+B6iWXToo
         rFXaWqoWLUD/kfFUMSrJnaR7fqh8gon65cBiTuBam5BHK/zsD1JwrdxhY/LAFvKQ2R
         ywpz3mfJEuWZgoOQH84n43ViyYXRJUUQyImMsh+wJ1JmMnuVYh/MpdWPBQCJHk9d0L
         EzH2rRZetEdoA==
Date:   Wed, 8 Feb 2023 15:36:49 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, jpoimboe@kernel.org,
        jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
        linux-kernel@vger.kernel.org, erhard_f@mailbox.org,
        ndesaulniers@google.com, mhiramat@kernel.org, sandipan.das@amd.com,
        llvm@lists.linux.dev
Subject: Re: [PATCH 0/3] static_call/x86: Handle clang's conditional tail
 calls
Message-ID: <Y+QkAXfhWfGevWz7@dev-arch.thelio-3990X>
References: <20230123205915.751729592@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123205915.751729592@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Ingo,

On Mon, Jan 23, 2023 at 09:59:15PM +0100, Peter Zijlstra wrote:
> Erhard reported boot fails on this AMD machine when using clang and bisected it
> to a commit introducing a few static_call()s. Turns out that when using clang
> with -Os it it very likely to generate conditional tail calls like:
> 
>   0000000000000350 <amd_pmu_add_event>:
>   350:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1) 351: R_X86_64_NONE      __fentry__-0x4
>   355:       48 83 bf 20 01 00 00 00         cmpq   $0x0,0x120(%rdi)
>   35d:       0f 85 00 00 00 00       jne    363 <amd_pmu_add_event+0x13>     35f: R_X86_64_PLT32     __SCT__amd_pmu_branch_add-0x4
>   363:       e9 00 00 00 00          jmp    368 <amd_pmu_add_event+0x18>     364: R_X86_64_PLT32     __x86_return_thunk-0x4
> 
> And our inline static_call() patching code can't deal with those and BUG
> happens -- really early.
> 
> These patches borrow the kprobe Jcc emulation to implement text_poke_bp() Jcc
> support, which is then used to teach inline static_call() about this form.
> 
> ---
>  arch/x86/include/asm/text-patching.h | 31 ++++++++++++++++++
>  arch/x86/kernel/alternative.c        | 62 +++++++++++++++++++++++++++---------
>  arch/x86/kernel/kprobes/core.c       | 38 +++++-----------------
>  arch/x86/kernel/static_call.c        | 50 +++++++++++++++++++++++++++--
>  4 files changed, 133 insertions(+), 48 deletions(-)

I noticed this series was applied to x86/alternatives versus
x86/urgent, even though this appears to be a regression since 6.1, as
Erhard hit this issue in that tree.

Additionally, a new change in LLVM main [1] causes conditional tail
calls to be emitted even at -O2, so this breakage will become more
noticeable over time. Is it possible to expedite this to mainline so
that it can be backported to 6.1? If not, no worries, but I figured I
would ask :)

I have a backport of this series to 6.1 prepared already [2], where it
appears to work for me but I will get wider testing before sending it
after this is in Linus' tree (regardless of when that is). I figured it
would not hurt to have other eyes on it ahead of time though.

[1]: https://github.com/llvm/llvm-project/commit/ee5585ed09aff2e54cb540fad4c33f0c93626b1b
[2]: https://git.kernel.org/nathan/l/cbl-1800-1774-6.1

Cheers,
Nathan
