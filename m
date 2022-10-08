Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7775F871E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 21:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJHTfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 15:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiJHTfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 15:35:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF32F27FDA;
        Sat,  8 Oct 2022 12:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77830B80BD9;
        Sat,  8 Oct 2022 19:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0348FC433C1;
        Sat,  8 Oct 2022 19:34:46 +0000 (UTC)
Date:   Sat, 8 Oct 2022 15:34:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
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
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [RFC PATCH 4/5] irq_work: Trace calls to arch_irq_work_raise()
Message-ID: <20221008153442.159b2f2d@rorschach.local.home>
In-Reply-To: <20221007154533.1878285-4-vschneid@redhat.com>
References: <20221007154145.1877054-1-vschneid@redhat.com>
        <20221007154533.1878285-4-vschneid@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Oct 2022 16:45:32 +0100
Valentin Schneider <vschneid@redhat.com> wrote:
>  }
>  
> +static inline void irq_work_raise(void)
> +{
> +	if (arch_irq_work_has_interrupt())
> +		trace_ipi_send_cpu(_RET_IP_, smp_processor_id());

To save on the branch, let's make the above:

	if (trace_ipi_send_cpu_enabled() && arch_irq_work_has_interrupt())

As the "trace_*_enabled()" is a static branch that will make it a nop
when the tracepoint is not enabled.

-- Steve


> +
> +	arch_irq_work_raise();
> +}
> +
>  /* Enqueue on current CPU, work must already be claimed and preempt disabled */
