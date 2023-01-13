Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0126F66A73C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 00:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjAMXxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 18:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjAMXxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:53:47 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F104F4D4B3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:53:46 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f3so16015477pgc.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0smP+VpD4aihulngzVZk5zbBndFc8mCYPCmEHHwK00=;
        b=njmX2aQyc5TNUOC5G9MJl97flmeCGAZHy1WmbuRq206x+b3dPdI54hTpoD3wTVeAEJ
         CoLEAQK0ma9/C58ukNWKV/QHXT1CmiVRrB5q4jN37HH4zEIa05uvritGPsDbKVtmeNGg
         xM2qffvyB9qL2KopvuDddxQtyn2IDQNdtTnuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0smP+VpD4aihulngzVZk5zbBndFc8mCYPCmEHHwK00=;
        b=O0vSgYOO27a0ZUPXRYlklIp830sTt/XLGDROZr1dLFHEZy8/6UrwdqxwJnGGRBdEgW
         hcJeQ6WnmSOmy5lv4r2rjBGOOpND84weUuus4McBXPr8jJWu+KWzJ3jr2EunegwK5n8O
         UEOLrFy5YQbskmKqjEsf/PWnJzmrOTXORPCGpUfSiWgGcWXDjH+ytSOw1Kj/zh9nnCLF
         7w0IrUI77MaSkIhZdjttikeOpT0v8UEDeCPYDImIsNkrRzv3hQA/wFl4/JvEVSL9Yf0g
         N0dPqoQC9pbgwfN8ENQJ+xLmNaNe0mS9wXdu+XSosqv69VTXNI9pQoefmOuvboS3Le+G
         d1Ww==
X-Gm-Message-State: AFqh2kqs9KRKWeSWXsapop5nTvx+cXrni7mnJKU2STBJ/QDRWfh4mdAZ
        RRkDRmi/rxCNa5pAundGxtaEjw==
X-Google-Smtp-Source: AMrXdXugCqknjUSmWRReAb6xiXkt+IyugfNyICf3FGXnXpKbNvLsyAB7tujJ7q4ucPRCTQrWrE+87Q==
X-Received: by 2002:a05:6a00:26c9:b0:58b:c3b3:d3dd with SMTP id p9-20020a056a0026c900b0058bc3b3d3ddmr1344770pfw.21.1673654026417;
        Fri, 13 Jan 2023 15:53:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y24-20020aa79438000000b00574ebfdc721sm14706802pfo.16.2023.01.13.15.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:53:45 -0800 (PST)
Date:   Fri, 13 Jan 2023 15:53:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Disable kernel stack offset randomization for !TSC
Message-ID: <202301131547.81D41D8@keescook>
References: <alpine.DEB.2.21.2301081919550.65308@angie.orcam.me.uk>
 <Y7sfdxJ5/2DSQK/l@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7sfdxJ5/2DSQK/l@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2023 at 08:55:06PM +0100, Borislav Petkov wrote:
> On Sun, Jan 08, 2023 at 07:42:54PM +0000, Maciej W. Rozycki wrote:
> > For x86 kernel stack offset randomization uses the RDTSC instruction, 
> > which causes an invalid opcode exception with hardware that does not 
> > implement this instruction:
> 
> Out of pure curiosity, what hw is that?
> 
> Also, I guess the fix should be something like this instead:
> 
> ---
> diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
> index 117903881fe4..57b372ca6ce7 100644
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -85,7 +85,8 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>  	 * Therefore, final stack offset entropy will be 5 (x86_64) or
>  	 * 6 (ia32) bits.
>  	 */
> -	choose_random_kstack_offset(rdtsc() & 0xFF);
> +	if (cpu_feature_enabled(X86_FEATURE_TSC))
> +		choose_random_kstack_offset(rdtsc() & 0xFF);
>  }
>  #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare

I think probably the entire feature should just be disabled in early
boot, checking for TSC, and then using:

	if (!cpu_feature_enabled(X86_FEATURE_TSC))
		static_branch_disable(&randomize_kstack_offset);

I'm not sure the best place to put that where it's early but late enough
that static branches are working...

-- 
Kees Cook
