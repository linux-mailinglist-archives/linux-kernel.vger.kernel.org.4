Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6BC663F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbjAJLgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbjAJLf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:35:58 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745F5DF64
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:35:56 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l26so8545500wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ED6k4JMWZP+JYHhb7ScjuYbNhfGq5URyyjoXmYShkJU=;
        b=KUzDn3S7lnFnuDGV2nlVhXXJuEqbzOIlo+cSfFXZ9wFCaKyxr7v1Vv6LIuH9Sze4Kt
         tQteoiXPBLKXS4ERzNS72hNZSSlZgiPjj6f+/n49mA/FKumuNlXZGHujQ9a/uONP3plp
         pat4GJ9EWEpSd11+2g1OsJ0XVFYldmCRv2XOBMRbedDoCLOE3HsmBZDV3PTg5SXp/EUT
         lj0ig9p87VX68LmEpr8exVe38cY55sb/kOpUT21bB9xMpXzEqU9xw4sjbGRczfh9gpOL
         p7WfKuY8VSBKEGmCvKNfVC79QHgw0IomIP9pUGYJwayy3B6U4gaoCzkngkjhmVmrAqeH
         BIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ED6k4JMWZP+JYHhb7ScjuYbNhfGq5URyyjoXmYShkJU=;
        b=VTykclzeU9JRYVKdbYbkRQ4gOo65+oV3tSkPXfILDRWoLYj3Xa8sxNbdTHIpQnwO0B
         gHXcxTj7UDp6EKKTPf7/7bN4ztw8Ir5InDQjGWmcylCQOLeQncRbOW0ooUd+ZPQUEgSc
         BQeLOVYqfCUczqdF/CjzjDhfVIux8jSH04+DELRrnw8V8AKigljYjLGIM0Jy5GF5UtwG
         h04NyRxoOeDlEnM/O3UFHJUcAMGjx8cs5ZBlniIVLIcUxbt/Lw3SL6H6I1YhIr85j3Qp
         45OfOzm6VwF7DLMJUsyr1HhWrsM47VGEly4X3V/yipLBO3ekCMPHKZUh0zJRAFZgOB3B
         WD6Q==
X-Gm-Message-State: AFqh2kr/pmEy9wLd+WYIZw2+k8b0oo8x2PxuLHd1r8ZC7IF9D3iVf8eE
        RMojjRijqFrNB6qLq9JQm9I=
X-Google-Smtp-Source: AMrXdXtA/GUM0qJrNULkhQnQ23rk25GMU+H7HHMVMJEpLBI63FicwNiWgNqTJLla20mTGIGMlnfTRA==
X-Received: by 2002:a05:600c:3c93:b0:3d9:ed30:79d with SMTP id bg19-20020a05600c3c9300b003d9ed30079dmr6364540wmb.18.1673350555074;
        Tue, 10 Jan 2023 03:35:55 -0800 (PST)
Received: from gmail.com (1F2EF2EB.nat.pool.telekom.hu. [31.46.242.235])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b003d9d23ab449sm15081256wms.29.2023.01.10.03.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 03:35:52 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 10 Jan 2023 12:35:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: x86/boot: Avoid using Intel mnemonics in AT&T syntax asm
Message-ID: <Y71NllA2NjlNiZpX@gmail.com>
References: <Y71I3Ex2pvIxMpsP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y71I3Ex2pvIxMpsP@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

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
> 
> Fixes: 7a734e7dd93b ("x86, setup: "glove box" BIOS calls -- infrastructure")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/boot/bioscall.S |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/boot/bioscall.S
> +++ b/arch/x86/boot/bioscall.S
> @@ -32,7 +32,7 @@
>  	movw	%dx, %si
>  	movw	%sp, %di
>  	movw	$11, %cx
> -	rep; movsd
> +	rep; movsl
>  
>  	/* Pop full state from the stack */
>  	popal
> @@ -67,7 +67,7 @@
>  	jz	4f
>  	movw	%sp, %si
>  	movw	$11, %cx
> -	rep; movsd
> +	rep; movsl
>  4:	addw	$44, %sp

So I think the GAS change to introduce this warning was probably 
unnecessary - these instructions weren't really causing any trouble and the 
syntax was basically a legacy thing that shouldn't be touched - but I guess 
that argument is water down the bridge now:

   Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
