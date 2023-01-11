Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711A86659ED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjAKLVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjAKLUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:20:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1EFFCC7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7y4EmNEiB7ucd21p81UzRMuWcGhP/yt/VrhwL2DWDCA=; b=osDX42GXI2c4zukGXf2B5XGfPH
        z1o0lu/SaLv+XVVg284I7ea4pyFWcT5w135ZtVK14FWediB+MueeCbWaKx4uOo94SmEB9YP/jJJoJ
        poWVodQOYdW8K8NJVNJnMHDiqR4MCd1XdZ3FQCIegYsjeYOwNCIuy9QUNJX4nRXHESSd6QddmjkbK
        CmXdiPWzE2QGO+veqy9gpiJUIfyTmtmY9igH+FhW2GAIB2qOP1L9IiXgQLHH1wUt/mjk/T61j0UKu
        bK1TlD/HXs/0sNmZp/EWhPROtYK4Jh30cY8DMuUcUcxCpYoJ0lR5qda9tFGeDCvo4iZFKB1JgULm/
        QOSDN/kA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFZ9h-00455s-IA; Wed, 11 Jan 2023 11:20:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B97BF3001F7;
        Wed, 11 Jan 2023 12:20:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 82AF3201ABB7D; Wed, 11 Jan 2023 12:20:14 +0100 (CET)
Date:   Wed, 11 Jan 2023 12:20:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joan Bruguera <joanbrugueram@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Wake-up from suspend to RAM broken under `retbleed=stuff`
Message-ID: <Y76bbtJn+jIV3pOz@hirez.programming.kicks-ass.net>
References: <20230108030748.158120-1-joanbrugueram@gmail.com>
 <20230109040531.7888-1-joanbrugueram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109040531.7888-1-joanbrugueram@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 04:05:31AM +0000, Joan Bruguera wrote:
> This fixes wakeup for me on both QEMU and real HW
> (just a proof of concept, don't merge)
> 
> diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
> index ffea98f9064b..8704bcc0ce32 100644
> --- a/arch/x86/kernel/callthunks.c
> +++ b/arch/x86/kernel/callthunks.c
> @@ -7,6 +7,7 @@
>  #include <linux/memory.h>
>  #include <linux/moduleloader.h>
>  #include <linux/static_call.h>
> +#include <linux/suspend.h>
>  
>  #include <asm/alternative.h>
>  #include <asm/asm-offsets.h>
> @@ -150,6 +151,10 @@ static bool skip_addr(void *dest)
>  	if (dest >= (void *)hypercall_page &&
>  	    dest < (void*)hypercall_page + PAGE_SIZE)
>  		return true;
> +#endif
> +#ifdef CONFIG_PM_SLEEP
> +	if (dest == restore_processor_state)
> +		return true;
>  #endif
>  	return false;
>  }
> diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
> index 236447ee9beb..e667894936f7 100644
> --- a/arch/x86/power/cpu.c
> +++ b/arch/x86/power/cpu.c
> @@ -281,6 +281,9 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
>  /* Needed by apm.c */
>  void notrace restore_processor_state(void)
>  {
> +	/* Restore GS before calling anything to avoid crash on call depth accounting */
> +	native_wrmsrl(MSR_GS_BASE, saved_context.kernelmode_gs_base);
> +
>  	__restore_processor_state(&saved_context);
>  }

Yeah, I can see why, but I'm not really comfortable with this. TBH, I
don't see how the whole resume code is correct to begin with. At the
very least it needs a heavy dose of noinstr.

Rafael, what cr3 is active when we call restore_processor_state()?

Specifically, the problem is that I don't feel comfortable doing any
sort of weird code until all the CR and segment registers have been
restored, however, write_cr*() are paravirt functions that result in
CALL, which then gives us a bit of a checken and egg problem.

I'm also wondering how well retbleed=stuff works on Xen, if at all. If
we can ignore Xen, things are a little earier perhaps.
