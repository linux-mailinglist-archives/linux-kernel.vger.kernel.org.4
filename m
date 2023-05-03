Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942C76F5A85
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjECO7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjECO7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:59:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BE449F9;
        Wed,  3 May 2023 07:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=JAgcGCa0iriRDIyulwuKYkDgWlBOM5XWRjlSwXqyJII=; b=G1Zex2TAl4dZV3a31P0gQgnMta
        x8hsYyMh0VoT+gBaPejSZ/jDxzfuM62caV//+sXBaIRCRjwKI6t4QXzvsHZWj8YN9xSTOHhWdikk9
        cvE4AdB9nfURRccj93tKNbu5lH2bEplLU1ZnOP6/6/ADFeKM+J8CvWfwNk3BCR5EH8ovb8wr6ZOia
        0hSiMiE7akTrxstEGLRa5cE6F+mu0BNG0mH2H7erYfQAP3fUd/yn6QRyFE/WqWQzlcRLIpgQYNMyV
        6Y8SjvWYKrb/bNpSRRC+xcn5Q+ZqmGxawMzCF1jeCtPkJy8bJz5eVY9PtQ6c5Ur9cPjmRBqQbmxq8
        Nh8BCCUg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1puDwe-009eL7-RX; Wed, 03 May 2023 14:59:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D1AFC30339B;
        Wed,  3 May 2023 16:59:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2CCE241DA2D7; Wed,  3 May 2023 16:59:00 +0200 (CEST)
Date:   Wed, 3 May 2023 16:59:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>, vschneid@redhat.com
Subject: Re: [RFC PATCH 1/1] smp: Add tracepoints for functions called with
 smp_call_function*()
Message-ID: <20230503145900.GC1689514@hirez.programming.kicks-ass.net>
References: <20230406075718.68672-1-leobras@redhat.com>
 <20230406095519.GG386572@hirez.programming.kicks-ass.net>
 <f294a74cd17bf932621a6a746d592f49770d25ec.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f294a74cd17bf932621a6a746d592f49770d25ec.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 12:45:08AM -0300, Leonardo Brás wrote:
> On Thu, 2023-04-06 at 11:55 +0200, Peter Zijlstra wrote:
> > On Thu, Apr 06, 2023 at 04:57:18AM -0300, Leonardo Bras wrote:
> > > When running RT workloads in isolated CPUs, many cases of deadline misses
> > > are caused by remote CPU requests such as smp_call_function*().
> > > 
> > > For those cases, having the names of those functions running around the
> > > deadline miss moment could help finding a target for the next improvements.
> > > 
> > > Add tracepoints for acquiring the funtion name & argument before entry and
> > > after exitting the called function.
> > > 
> > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > 
> > How are the patches queued there not sufficient?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=smp/core
> > 
> 
> IIUC the last commits add tracepoints that are collected in the
> requesting CPU, at the moment of scheduling the IPI, which are also useful in
> some scenarios.
> 
> On my scenario, it could help a little, since it makes possible to filter what
> all other cpus are scheduling on the requested cpu. OTOH it could be also be
> misleading, as the requested cpu could be running something that was scheduled
> way before.
> 
> The change I propose does exactly what my scenario need: track exactly which
> function was running at given time in the requested CPU. With this info, we can
> check which (if any) remotely requested function was running on given time
> window.

I was thinking you could simply (graph)-trace
__flush_smp_call_function_queue() with a max_graph_depth or so (Steve
says that ought to work).

But even that might be too specific, your use case sounds more like what
we have the irq-off latency tracer for, and that thing will immediately
tell you what functions were being ran.

> (An unrelated thing I just thought: We could even use the commits you pointed
> together with my proposed change in order to measure how long does it take for a
> requested function to run / complete in the requested cpu)

I don't think you could actually do that; the send tracepoints Valentin
added don't log the csd address, this means you cannot distinguish
two CSDs with the same function send from different CPUs.

To do this you'd need to add the csd address to the the ipi_send
tracepoints and your own (possibly replacing info -- because I don't
think that's too useful).

Valentin -- is any of this something you'd also find useful?
