Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55B75ECC16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 20:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiI0SVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 14:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiI0SVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 14:21:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF75F684F;
        Tue, 27 Sep 2022 11:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BmhIzH6QeLzG1HzDb0h4B8ArGPxAu7f6HvFWMpAiIac=; b=ZrYQtozPPf0rsIDRg3RVwcr0ll
        71eRqqMoYlCUX3xiT00XyXMR/rc9PCVjADH/53Eul3iAVuVaoofSYBI+3YfEbf0eghtGn6c4hQaQY
        wQvg4/NfRKvh89e98a+syxNTOVqNL8fbywTrsGGO8b1cyGz9lpAyRnahYJ6IWgvvfGoz8+YkH7mIH
        x7MNei1nhUhDXMKmnpZc8w6zDFw5IUL7xsse6Qp8Xp02DtVQ7c0hB5GemEzpHUi8KTgzAJXL/1qCO
        9tKCDH4nDAbaSitW3B05Me7Q3/9rrJlZ//mlohbOtwdj62ZOyxD5JnbMB3JUgHtyY5+ydqU/QsFPy
        bFJ/aLjA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odFCR-00GMHf-3C; Tue, 27 Sep 2022 18:20:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE8B530007E;
        Tue, 27 Sep 2022 20:20:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 951302BE05B2C; Tue, 27 Sep 2022 20:20:53 +0200 (CEST)
Date:   Tue, 27 Sep 2022 20:20:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] perf: Fix missing SIGTRAPs due to pending_disable abuse
Message-ID: <YzM/BUsBnX18NoOG@hirez.programming.kicks-ass.net>
References: <20220927121322.1236730-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927121322.1236730-1-elver@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:13:22PM +0200, Marco Elver wrote:
> Due to the implementation of how SIGTRAP are delivered if
> perf_event_attr::sigtrap is set, we've noticed 3 issues:
> 
> 	1. Missing SIGTRAP due to a race with event_sched_out() (more
> 	   details below).
> 
> 	2. Hardware PMU events being disabled due to returning 1 from
> 	   perf_event_overflow(). The only way to re-enable the event is
> 	   for user space to first "properly" disable the event and then
> 	   re-enable it.
> 
> 	3. The inability to automatically disable an event after a
> 	   specified number of overflows via PERF_EVENT_IOC_REFRESH.
> 
> The worst of the 3 issues is problem (1), which occurs when a
> pending_disable is "consumed" by a racing event_sched_out(), observed as
> follows:
> 
> 		CPU0			| 	CPU1
> 	--------------------------------+---------------------------
> 	__perf_event_overflow()		|
> 	 perf_event_disable_inatomic()	|
> 	  pending_disable = CPU0	| ...
> 	  				| _perf_event_enable()
> 					|  event_function_call()
> 					|   task_function_call()
> 					|    /* sends IPI to CPU0 */
> 	<IPI>				| ...
> 	 __perf_event_enable()		+---------------------------
> 	  ctx_resched()
> 	   task_ctx_sched_out()
> 	    ctx_sched_out()
> 	     group_sched_out()
> 	      event_sched_out()
> 	       pending_disable = -1
> 	</IPI>
> 	<IRQ-work>
> 	 perf_pending_event()
> 	  perf_pending_event_disable()
> 	   /* Fails to send SIGTRAP because no pending_disable! */
> 	</IRQ-work>
> 
> In the above case, not only is that particular SIGTRAP missed, but also
> all future SIGTRAPs because 'event_limit' is not reset back to 1.
> 
> To fix, rework pending delivery of SIGTRAP via IRQ-work by introduction
> of a separate 'pending_sigtrap', no longer using 'event_limit' and
> 'pending_disable' for its delivery.
> 
> During testing, this also revealed several more possible races between
> reschedules and pending IRQ work; see code comments for details.

Perhaps use task_work_add() for this case? That runs on the
return-to-user path, so then it doesn't matter how many reschedules
happen in between.

The only concern is that task_work_add() uses kasan_record_aux_stack()
which obviously isn't NMI clean, so that would need to get removed or
made conditional.

