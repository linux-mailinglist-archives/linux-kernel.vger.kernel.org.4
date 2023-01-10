Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CB466446E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbjAJPUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbjAJPTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:19:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BDD5BA29
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:19:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34B5AB8172F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28192C433EF;
        Tue, 10 Jan 2023 15:19:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JxC4WsMw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1673363985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iwn0WCkjUlAIOr+p5Logi4EXs7MGXsXKgRZUvjdbDNA=;
        b=JxC4WsMwZlQwRucGpEH1BnzepLEZgqzgNtXpacfKScwTyE7Ych4byzZ02Ab+b3V0j8ucHb
        xHh+6Wkmw4hPfIJMykiBI1EoJ1zytMjuJry9nYt7Up4v2NMYNnxjQqI+LtlvuxqBpvhQbE
        zhZccfvBmDjlIBPQOIEIoZiTLZ0v96M=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id df2b6054 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 10 Jan 2023 15:19:44 +0000 (UTC)
Date:   Tue, 10 Jan 2023 16:19:35 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Disable kernel stack offset randomization for
 !TSC
Message-ID: <Y72CByxvewQv78YH@zx2c4.com>
References: <alpine.DEB.2.21.2301082113350.65308@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2301082113350.65308@angie.orcam.me.uk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2023 at 09:26:11PM +0000, Maciej W. Rozycki wrote:
> For x86 kernel stack offset randomization uses the RDTSC instruction, 
> which causes an invalid opcode exception with hardware that does not 
> implement this instruction:
> 
> process '/sbin/init' started with executable stack
> invalid opcode: 0000 [#1]
> CPU: 0 PID: 1 Comm: init Not tainted 6.1.0-rc4+ #1
> EIP: exit_to_user_mode_prepare+0x90/0xe1
> Code: 30 02 00 75 ad 0f ba e3 16 73 05 e8 a7 a5 fc ff 0f ba e3 0e 73 05 e8 3e af fc ff a1 c4 c6 51 c0 85 c0 7e 13 8b 0d ac 01 53 c0 <0f> 31 0f b6 c0 31 c1 89 0d ac 01 53 c0 83 3d 30 ed 62 c0 00 75 33
> EAX: 00000001 EBX: 00004000 ECX: 00000000 EDX: 000004ff
> ESI: c10253c0 EDI: 00000000 EBP: c1027f98 ESP: c1027f8c
> DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010002
> CR0: 80050033 CR2: bfe8659b CR3: 012e0000 CR4: 00000000
> Call Trace:
>  ? rest_init+0x72/0x72
>  syscall_exit_to_user_mode+0x15/0x27
>  ret_from_fork+0x10/0x30
> EIP: 0xb7f74800
> Code: Unable to access opcode bytes at 0xb7f747d6.
> EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
> ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: bfe864b0
> DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b EFLAGS: 00000200
> ---[ end trace 0000000000000000 ]---
> EIP: exit_to_user_mode_prepare+0x90/0xe1
> Code: 30 02 00 75 ad 0f ba e3 16 73 05 e8 a7 a5 fc ff 0f ba e3 0e 73 05 e8 3e af fc ff a1 c4 c6 51 c0 85 c0 7e 13 8b 0d ac 01 53 c0 <0f> 31 0f b6 c0 31 c1 89 0d ac 01 53 c0 83 3d 30 ed 62 c0 00 75 33
> EAX: 00000001 EBX: 00004000 ECX: 00000000 EDX: 000004ff
> ESI: c10253c0 EDI: 00000000 EBP: c1027f98 ESP: c1027f8c
> DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010002
> CR0: 80050033 CR2: b7f747d6 CR3: 012e0000 CR4: 00000000
> Kernel panic - not syncing: Fatal exception
> 
> Therefore do not use randomization where the CPU does not have the TSC 
> feature.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
> Changes from v1:
> 
> - Disable randomization at run time rather than in configuration.
> ---
>  arch/x86/include/asm/entry-common.h |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> linux-x86-randomize-kstack-offset-tsc.diff
> Index: linux-macro/arch/x86/include/asm/entry-common.h
> ===================================================================
> --- linux-macro.orig/arch/x86/include/asm/entry-common.h
> +++ linux-macro/arch/x86/include/asm/entry-common.h
> @@ -5,6 +5,7 @@
>  #include <linux/randomize_kstack.h>
>  #include <linux/user-return-notifier.h>
>  
> +#include <asm/cpufeature.h>
>  #include <asm/nospec-branch.h>
>  #include <asm/io_bitmap.h>
>  #include <asm/fpu/api.h>
> @@ -85,7 +86,8 @@ static inline void arch_exit_to_user_mod
>  	 * Therefore, final stack offset entropy will be 5 (x86_64) or
>  	 * 6 (ia32) bits.
>  	 */
> -	choose_random_kstack_offset(rdtsc() & 0xFF);
> +	if (cpu_feature_enabled(X86_FEATURE_TSC))
> +		choose_random_kstack_offset(rdtsc() & 0xFF);

What would happen if you just called `get_random_u8()` here?

Jason
