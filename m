Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F8170A04D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjESUKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjESUKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:10:49 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEEE0101;
        Fri, 19 May 2023 13:10:47 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 30FFC92009D; Fri, 19 May 2023 22:10:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 2D5A592009B;
        Fri, 19 May 2023 21:10:47 +0100 (BST)
Date:   Fri, 19 May 2023 21:10:47 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] MIPS: Fix MIPS_O32_FP64_SUPPORT for 64bit CPUs before
 R2
In-Reply-To: <20230519163023.70542-1-jiaxun.yang@flygoat.com>
Message-ID: <alpine.DEB.2.21.2305192033550.50034@angie.orcam.me.uk>
References: <20230519163023.70542-1-jiaxun.yang@flygoat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023, Jiaxun Yang wrote:

> MIPS_O32_FP64_SUPPORT enables possibility of using all 32 FPRs on 32bit
> kernel in case CPU implemented FR1. As FR1 is present on all 64bit CPUs
> following R4000's priviliged spec, there is no reason to limit such support
> to R2+ CPUs.

 I guess one can do it and still run FPXX software, but I fail to see what 
gain it provides.  For FP32 it breaks things as accesses to odd-numbered 
FPRs will no longer get at the high part of a double value and for FP64 
there are no MTHC1/MFHC1 instructions required to access the high part.

 What problem are you trying to solve?  And how did you verify this patch?

> --- a/arch/mips/kernel/fpu-probe.c
> +++ b/arch/mips/kernel/fpu-probe.c
> @@ -289,6 +289,23 @@ void cpu_set_fpu_opts(struct cpuinfo_mips *c)
>  			c->options |= MIPS_CPU_FRE;
>  	}
>  
> +	/* Fix up FIR for FPU earlier than R2 */
> +	if (!cpu_has_mips_r2_r6) {
> +		c->fpu_id |= MIPS_FPIR_S;
> +#ifdef CONFIG_CPU_R4K_FPU
> +		/* All known R4000 class FPU implemented double */
> +		c->fpu_id |= MIPS_FPIR_D;
> +#endif

 Currently all FPUs we support implement double and we require that, so no 
need to make this piece conditional (I would use IS_ENABLED otherwise, so 
as not to clutter the source with #ifdef), but `c->fpu_id' is also exposed 
to the user via ptrace(2), so this has to reflect hardware and not give a 
synthesized value.

  Maciej
