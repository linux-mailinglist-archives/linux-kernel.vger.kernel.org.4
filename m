Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8AE663F53
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjAJLgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbjAJLgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:36:37 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF4C5131F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:36:34 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 75F851EC01B7;
        Tue, 10 Jan 2023 12:36:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673350592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FydzkbUqhNLO3+ARGz/dT0rUfRDNk8dNGvb0boW3dFU=;
        b=nkp/JZRPSfmTBMc8q7QgHCsa3PxwacM5F15SXtSnJrRHxp6Owdc415aKgnXPp3t3Snzwb3
        X5osQHdWvi2S0DrCk6Nnl1rIFarMBD55Bs7xFPvt+1yn+wLqMCU5J/DjxttCEtd1lkOmGu
        Yy1dnXGjY3zP9uaDKxo3SopLMvNMl4A=
Date:   Tue, 10 Jan 2023 12:36:32 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: x86/boot: Avoid using Intel mnemonics in AT&T syntax asm
Message-ID: <Y71NwKcbVZIZyP8p@zn.tnic>
References: <Y71I3Ex2pvIxMpsP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y71I3Ex2pvIxMpsP@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 12:15:40PM +0100, Peter Zijlstra wrote:
> 
> With 'GNU assembler (GNU Binutils for Debian) 2.39.90.20221231' the
> build now reports:
> 
>   arch/x86/realmode/rm/../../boot/bioscall.S: Assembler messages:
>   arch/x86/realmode/rm/../../boot/bioscall.S:35: Warning: found `movsd'; assuming `movsl' was meant
>   arch/x86/realmode/rm/../../boot/bioscall.S:70: Warning: found `movsd'; assuming `movsl' was meant
> 
>   arch/x86/boot/bioscall.S: Assembler messages:
>   arch/x86/boot/bioscall.S:35: Warning: found `movsd'; assuming `movsl' was meant
>   arch/x86/boot/bioscall.S:70: Warning: found `movsd'; assuming `movsl' was meant
> 
> Which is due to:
> 
>   PR gas/29525
> 
>   Note that with the dropped CMPSD and MOVSD Intel Syntax string insn
>   templates taking operands, mixed IsString/non-IsString template groups
>   (with memory operands) cannot occur anymore. With that
>   maybe_adjust_templates() becomes unnecessary (and is hence being
>   removed).
> 
> More details: https://sourceware.org/bugzilla/show_bug.cgi?id=29525

Right, I'm being told the particular problem here is is that the 'd' suffix is
"conflicting" in the sense that you can have SSE mnemonics like movsD %xmm...
and the same thing also for string ops (which is the case here) so apparently
the agreement in binutils land is to use the always accepted suffixes 'l' or 'q'
and phase out 'd' slowly...

Which is basically what the PR text says above but more understanable. :-)

Might wanna add that to the commit message.

> Fixes: 7a734e7dd93b ("x86, setup: "glove box" BIOS calls -- infrastructure")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/boot/bioscall.S |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

In any case

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
