Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10E9662B08
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjAIQUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjAIQUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:20:13 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F61192B9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j+Gen2eU0jf9G0iqx+BIbLnHGKCdcFm/8cL1m3LwQjY=; b=j59SI0kNy2I8DmsJs6em3tvKcX
        IpwD5QTuYugoFRnG4sd6ob+yPyBeJ07//2wTRA8PTlktw8DTcoPAn2MZZtTB2qBaaRDZkrCy1eZ/4
        WrhqyrSecJdAZLLysNtj+834ibt9mX0hJFZB23+hh/KRsZ6Ad8U8vaI0DiySGrSRgsgWPdiI6Oucw
        EoJz+qLRl37m5UVXZqMEiUQruF2HDZeHojZaOcGRvuRQgJFPK+KxgFNyHq2QhYDqjPuaEC/Y186M5
        nNxOkp/yp70xZ7lTWP7dMm0y0Tc+OiE9hnpY4ZNKaNRS+/0ZmNJ2PnwSBHJaiIfl8i79beyfHr5vD
        EGGY44Zw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pEusL-002mH6-34;
        Mon, 09 Jan 2023 16:19:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5DE00300293;
        Mon,  9 Jan 2023 17:19:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 31BE620086EAB; Mon,  9 Jan 2023 17:19:59 +0100 (CET)
Date:   Mon, 9 Jan 2023 17:19:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH x86/nmi 1/2] x86/nmi: Accumulate NMI-progress evidence in
 exc_nmi()
Message-ID: <Y7w+r3Nbubin8sNN@hirez.programming.kicks-ass.net>
References: <20230105011537.1774941-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105011537.1774941-1-paulmck@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 05:15:36PM -0800, Paul E. McKenney wrote:

> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index cec0bfa3bc04f..4f1651dc65b3a 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -69,6 +69,15 @@ struct nmi_stats {
>  	unsigned int unknown;
>  	unsigned int external;
>  	unsigned int swallow;
> +	unsigned long recv_jiffies;
> +	unsigned long idt_seq;
> +	unsigned long idt_nmi_seq;
> +	unsigned long idt_ignored;
> +	atomic_long_t idt_calls;
> +	unsigned long idt_seq_snap;
> +	unsigned long idt_nmi_seq_snap;
> +	unsigned long idt_ignored_snap;
> +	long idt_calls_snap;
>  };

Urgh, this is more than a whole cacheline of extra data :/ Can't we make
this #ifdef CONFIG_NMI_CHECK_CPU ?

> @@ -509,8 +526,15 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
>  
>  	inc_irq_stat(__nmi_count);
>  
> -	if (!ignore_nmis)
> +	if (IS_ENABLED(CONFIG_NMI_CHECK_CPU) && ignore_nmis) {
> +		WRITE_ONCE(nsp->idt_ignored, nsp->idt_ignored + 1);
> +	} else if (!ignore_nmis) {
> +		WRITE_ONCE(nsp->idt_nmi_seq, nsp->idt_nmi_seq + 1);
> +		WARN_ON_ONCE(!(nsp->idt_nmi_seq & 0x1));
>  		default_do_nmi(regs);
> +		WRITE_ONCE(nsp->idt_nmi_seq, nsp->idt_nmi_seq + 1);
> +		WARN_ON_ONCE(nsp->idt_nmi_seq & 0x1);
> +	}
>  
>  	irqentry_nmi_exit(regs, irq_state);

That is not a NO-OP when !CONFIG_NMI_CHECK_CPU :/
