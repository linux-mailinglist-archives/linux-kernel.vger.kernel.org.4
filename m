Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C143E6F6CFE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 15:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjEDNen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 09:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjEDNel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 09:34:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B9935B8;
        Thu,  4 May 2023 06:34:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8977360F4D;
        Thu,  4 May 2023 13:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CB6C433D2;
        Thu,  4 May 2023 13:34:36 +0000 (UTC)
Date:   Thu, 4 May 2023 09:34:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Leonardo =?UTF-8?B?QnLDoXM=?= <leobras@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: Re: [RFC PATCH 1/1] smp: Add tracepoints for functions called with
 smp_call_function*()
Message-ID: <20230504093434.25f238b2@gandalf.local.home>
In-Reply-To: <xhsmh7ctojoia.mognet@vschneid.remote.csb>
References: <20230406075718.68672-1-leobras@redhat.com>
        <20230406095519.GG386572@hirez.programming.kicks-ass.net>
        <f294a74cd17bf932621a6a746d592f49770d25ec.camel@redhat.com>
        <20230503145900.GC1689514@hirez.programming.kicks-ass.net>
        <xhsmh7ctojoia.mognet@vschneid.remote.csb>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 May 2023 12:59:41 +0100
Valentin Schneider <vschneid@redhat.com> wrote:

> +TRACE_EVENT(csd_queue_cpu,
> +
> +	TP_PROTO(const unsigned int cpu,

Why the "const" ?

-- Steve

> +		 unsigned long callsite,
> +		 smp_call_func_t func,
> +		 call_single_data_t *csd),
> +
> +	TP_ARGS(cpu, callsite, func, csd),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cpu)
> +		__field(void *, callsite)
> +		__field(void *, func)
> +		__field(void *, csd)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +		__entry->callsite = (void *)callsite;
> +		__entry->func = func;
> +		__entry->csd  = csd;
> +	),
> +
> +	TP_printk("cpu=%u callsite=%pS func=%pS csd=%p",
> +		  __entry->cpu, __entry->callsite, __entry->func, __entry->csd)
> +);
> +
