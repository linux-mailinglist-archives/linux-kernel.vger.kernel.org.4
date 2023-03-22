Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE2F6C46B3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjCVJkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjCVJkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:40:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D831989;
        Wed, 22 Mar 2023 02:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NIAHg4If27BetC+4UZobAV0PxBnmTt3z+fWts2bKQWA=; b=rgS/CEWAlsTurPe5ucKBiXaDhr
        ew26BoXauCH9lin/sWfYKxjLJe0WysSt1P4iOSDXV1qfu4JSoUQNAlogwxNIDbcZw5jKIurC6wBP0
        +/+Z8kdUTp/ZyyNP9QPql3dhW8rHV0QqkfTXWuMoE0vryMGgt+T+aOFFPTKbmbiRK5T84YLaG6C4t
        iRHD6M2ZFvI2kES3RCcIFI7D2yWW07o0ZjcKw1qqr5MTJddfTUE9AHHetindb2rqkUVxpV/GEVyQu
        B4Z/fkelloNxIIEvBXXKz9pvL88Uc5JVf1N0nCKJVM3jEC4cK78BNevAeHHN3c0k/dy9sGC9ChrU5
        42+coITw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1peuwq-002t99-FB; Wed, 22 Mar 2023 09:40:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E63F3001F7;
        Wed, 22 Mar 2023 10:39:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 16170205D08C3; Wed, 22 Mar 2023 10:39:56 +0100 (CET)
Date:   Wed, 22 Mar 2023 10:39:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 1/7] trace: Add trace_ipi_send_cpumask()
Message-ID: <20230322093955.GR2017917@hirez.programming.kicks-ass.net>
References: <20230307143558.294354-1-vschneid@redhat.com>
 <20230307143558.294354-2-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307143558.294354-2-vschneid@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 02:35:52PM +0000, Valentin Schneider wrote:
> trace_ipi_raise() is unsuitable for generically tracing IPI sources due to
> its "reason" argument being an uninformative string (on arm64 all you get
> is "Function call interrupts" for SMP calls).
> 
> Add a variant of it that exports a target cpumask, a callsite and a callback.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/trace/events/ipi.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/trace/events/ipi.h b/include/trace/events/ipi.h
> index 0be71dad6ec03..b1125dc27682c 100644
> --- a/include/trace/events/ipi.h
> +++ b/include/trace/events/ipi.h
> @@ -35,6 +35,28 @@ TRACE_EVENT(ipi_raise,
>  	TP_printk("target_mask=%s (%s)", __get_bitmask(target_cpus), __entry->reason)
>  );
>  
> +TRACE_EVENT(ipi_send_cpumask,
> +
> +	TP_PROTO(const struct cpumask *cpumask, unsigned long callsite, void *callback),
> +
> +	TP_ARGS(cpumask, callsite, callback),
> +
> +	TP_STRUCT__entry(
> +		__cpumask(cpumask)
> +		__field(void *, callsite)
> +		__field(void *, callback)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_cpumask(cpumask, cpumask_bits(cpumask));
> +		__entry->callsite = (void *)callsite;
> +		__entry->callback = callback;
> +	),
> +
> +	TP_printk("cpumask=%s callsite=%pS callback=%pS",
> +		  __get_cpumask(cpumask), __entry->callsite, __entry->callback)
> +);

Would it make sense to add a variant like: ipi_send_cpu() that records a
single cpu instead of a cpumask. A lot of sites seems to do:
cpumask_of(cpu) for that first argument, and it seems to me it is quite
daft to have to memcpy a full multi-word cpumask in those cases.

Remember, nr_possible_cpus > 64 is quite common these days.
