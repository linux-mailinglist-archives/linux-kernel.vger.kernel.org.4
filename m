Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7256A5EE97B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiI1WhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiI1Wgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:36:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F235FF64;
        Wed, 28 Sep 2022 15:36:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEA4FB82146;
        Wed, 28 Sep 2022 22:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F51C433C1;
        Wed, 28 Sep 2022 22:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664404565;
        bh=3ZkYJjVGuAToHzBzl/eiZQGP9nl9Lz8aoqrcQ6zQ2uM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtKvpq/MUwe5t3E4qnfpcWmZ+pcS4X4n2SsF/DqlSmrRrDWMnk/FLftXgyTKLbd3m
         vf5onz4ySjHSRPWg90lJAptiotaelTd1i/CYikPGvR6S3fjnLg44rhwRDmZhL8vWft
         8fgBaB/JZ0fJBXAIQAphj/RKrXXvh8tAme/Te94gYrUrSm+2/10sIdAi1sGA/GoFb+
         w+E0XnEn4LevLs1JvLEaqDFEflvwhWNXQTRpQn++dtp5R3F4x8n3l6DyEkl79MWEOr
         fcM/sZ3XXaO2EUoP/Kkt8FDn9nNMAUDD7J0uENSVy0/jAtD0M4sYt0aC3VwCNTKLHB
         y8OuB2Bu+VdNw==
Date:   Wed, 28 Sep 2022 15:36:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Matt Redfearn <matt.redfearn@mips.com>,
        Petr =?utf-8?B?VmFuxJtr?= <arkamar@atlas.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Justin Stitt <jstitt007@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "open list:CLANG/LLVM BUILD SUPPORT" <llvm@lists.linux.dev>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>, mmayer@broadcom.com,
        Khem Raj <raj.khem@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] include/uapi/linux/swab: Fix potentially missing
 __always_inline
Message-ID: <YzTMUpd6HbHmZu8f@dev-arch.thelio-3990X>
References: <20220927215256.528619-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220927215256.528619-1-f.fainelli@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Tue, Sep 27, 2022 at 02:52:56PM -0700, Florian Fainelli wrote:
> From: Matt Redfearn <matt.redfearn@mips.com>
> 
> Commit bc27fb68aaad ("include/uapi/linux/byteorder, swab: force inlining
> of some byteswap operations") added __always_inline to swab functions
> and commit 283d75737837 ("uapi/linux/stddef.h: Provide __always_inline to
> userspace headers") added a definition of __always_inline for use in
> exported headers when the kernel's compiler.h is not available.
> 
> However, since swab.h does not include stddef.h, if the header soup does
> not indirectly include it, the definition of __always_inline is missing,
> resulting in a compilation failure, which was observed compiling the
> perf tool using exported headers containing this commit:
> 
> In file included from /usr/include/linux/byteorder/little_endian.h:12:0,
>                  from /usr/include/asm/byteorder.h:14,
>                  from tools/include/uapi/linux/perf_event.h:20,
>                  from perf.h:8,
>                  from builtin-bench.c:18:
> /usr/include/linux/swab.h:160:8: error: unknown type name `__always_inline'
>  static __always_inline __u16 __swab16p(const __u16 *p)
> 
> Fix this by replacing the inclusion of linux/compiler.h with
> linux/stddef.h to ensure that we pick up that definition if required,
> without relying on it's indirect inclusion. compiler.h is then included
> indirectly, via stddef.h.
> 
> Fixes: 283d75737837 ("uapi/linux/stddef.h: Provide __always_inline to userspace headers")
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> Reviewed-by: Petr Vaněk <arkamar@atlas.cz>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

I took this through my kernel build matrix and did not see any new
issues.

Tested-by: Nathan Chancellor <nathan@kernel.org>

Cheers,
Nathan

> ---
> Apologies for the insanely long CC list. I encountered this problem
> again while attempting to build perf with a LLVM 13 toolchain using
> musl-libc. Not sure why it did not get picked up last time?
> 
> Khem did submit an alternative patch a few years ago, too which also did
> not get picked up:
> 
> https://lore.kernel.org/lkml/20180913005654.39976-1-raj.khem@gmail.com/
> 
>  include/uapi/linux/swab.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
> index 0723a9cce747..01717181339e 100644
> --- a/include/uapi/linux/swab.h
> +++ b/include/uapi/linux/swab.h
> @@ -3,7 +3,7 @@
>  #define _UAPI_LINUX_SWAB_H
>  
>  #include <linux/types.h>
> -#include <linux/compiler.h>
> +#include <linux/stddef.h>
>  #include <asm/bitsperlong.h>
>  #include <asm/swab.h>
>  
> -- 
> 2.25.1
> 
> 
