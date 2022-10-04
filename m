Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB345F484B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJDRWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJDRWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:22:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3537F25E4;
        Tue,  4 Oct 2022 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bh6vzn8U2ZsRPHfJfbA7bhjBG4wiyjRnctJShcuE7JE=; b=JRMyjcoKG+yIJiGewfyyQAtrjO
        +3HGkg6/t4G8yG1oqVaDcCpbW5UJyAcbjxl+3s0Jme4pbspT+Vn1xcYm97DBMXPqkiVR9Raca/wMy
        JIJVmnq1SWOmevqTgoZPEQs7QDRhPbXwJsZwMoY9nouvE02fR8Xc8rMBIfQ3UF+6mjQBWlwAUkpov
        hPhw94mut02zlHzjTflobIrVPfq86AXnXQ2bJ/twHRNixh3mgadiuZcrLTX9WUDDQWArcqLeGhOUQ
        K14xm/hbXF5z0nXYxwJaP8V2teTXrUyQqzJA2ZCTi4Wsewll87G1FFVp1SQKzCYXi2a8nuWGw3XOV
        nuTG1mDg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oflc3-000lRQ-4T; Tue, 04 Oct 2022 17:21:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9E23C3002EC;
        Tue,  4 Oct 2022 19:21:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8264920C3AB5A; Tue,  4 Oct 2022 19:21:45 +0200 (CEST)
Date:   Tue, 4 Oct 2022 19:21:45 +0200
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
Message-ID: <YzxrqUFBNy/kR6PZ@hirez.programming.kicks-ass.net>
References: <20220927121322.1236730-1-elver@google.com>
 <YzM/BUsBnX18NoOG@hirez.programming.kicks-ass.net>
 <YzNu5bgASbuVi0S3@elver.google.com>
 <YzQcqe9p9C5ZbjZ1@elver.google.com>
 <YzRgcnMXWuUZ4rlt@elver.google.com>
 <Yzxou9HB/1XjMXWI@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yzxou9HB/1XjMXWI@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 07:09:15PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 28, 2022 at 04:55:46PM +0200, Marco Elver wrote:
> > On Wed, Sep 28, 2022 at 12:06PM +0200, Marco Elver wrote:
> > 
> > > My second idea about introducing something like irq_work_raw_sync().
> > > Maybe it's not that crazy if it is actually safe. I expect this case
> > > where we need the irq_work_raw_sync() to be very very rare.
> > 
> > The previous irq_work_raw_sync() forgot about irq_work_queue_on(). Alas,
> > I might still be missing something obvious, because "it's never that
> > easy". ;-)
> > 
> > And for completeness, the full perf patch of what it would look like
> > together with irq_work_raw_sync() (consider it v1.5). It's already
> > survived some shorter stress tests and fuzzing.
> 
> So.... I don't like it. But I cooked up the below, which _almost_ works :-/
> 
> For some raisin it sometimes fails with 14999 out of 15000 events
> delivered and I've not yet figured out where it goes sideways. I'm
> currently thinking it's that sigtrap clear on OFF.

Oh Urgh, this is ofcourse the case where an IPI races with a migration
and we loose the race with return to use. Effectively giving the signal
skid vs the hardware event.

Bah.. I really hate having one CPU wait for another... Let me see if I
can find another way to close that hole.
