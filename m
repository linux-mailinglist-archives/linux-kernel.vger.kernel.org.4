Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4E062D5F3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbiKQJI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239719AbiKQJIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:08:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377142126A;
        Thu, 17 Nov 2022 01:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aQk2rEVdOyLC8MBnXpxdsdOtZKvioHnImfV1oOS2Xtg=; b=I3xClU65IacOMLf2bWeSauP7FF
        FV50Hi48EBk2WK6Yehcm6XtdcO6hf4dsN2DMpSf1Q8J+ZcUcJOT8oIO1945EQRsvfdc4JvICopd0l
        Ui4r6qLsEQxO7P9sxXUeh9gS9sZqkCJSKZK2ctS17TuNst0NjO4G5IjBK7pt6TA2UoyWMLe7JrlZ4
        3rVanZNI9MF1KBvk8SzTNZKx8hjhh1qDV56hj7OC6Wv8JNJ6ypUqg8KZLLfwkKn7jGczcYvLbevRx
        fdi5hL+kowpdqhlUAfa1HbfNoACRcwrRe8SG0NXXobWd3RkjDM5DSjIiSED2Yxip/fi/HuoFKOMRj
        0mZtwn6g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovasi-000qMs-De; Thu, 17 Nov 2022 09:08:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7E6F30002E;
        Thu, 17 Nov 2022 10:08:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C282320B670CB; Thu, 17 Nov 2022 10:08:15 +0100 (CET)
Date:   Thu, 17 Nov 2022 10:08:15 +0100
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
        x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Subject: Re: [RFC PATCH v2 4/8] smp: Trace IPIs sent via
 arch_send_call_function_ipi_mask()
Message-ID: <Y3X5/65o8127DgZl@hirez.programming.kicks-ass.net>
References: <20221102182949.3119584-1-vschneid@redhat.com>
 <20221102183336.3120536-3-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102183336.3120536-3-vschneid@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 06:33:32PM +0000, Valentin Schneider wrote:
> This simply wraps around the arch function and prepends it with a
> tracepoint, similar to send_call_function_single_ipi().
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/smp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index e2ca1e2f31274..c4d561cf50d45 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -160,6 +160,13 @@ void __init call_function_init(void)
>  	smpcfd_prepare_cpu(smp_processor_id());
>  }
>  
> +static inline void

Given the use of _RET_IP_, I would strongly recommend you use
__always_inline.

> +send_call_function_ipi_mask(const struct cpumask *mask)
> +{
> +	trace_ipi_send_cpumask(mask, _RET_IP_, func);

What's func?

> +	arch_send_call_function_ipi_mask(mask);
> +}
