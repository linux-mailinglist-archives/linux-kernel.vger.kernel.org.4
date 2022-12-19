Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E30E650AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 12:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiLSLrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 06:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiLSLq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 06:46:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7608D1BE;
        Mon, 19 Dec 2022 03:46:58 -0800 (PST)
Date:   Mon, 19 Dec 2022 12:46:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671450416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ws5wq3iitPNqsoUCsp4j6YINoPtE4KBwdrqefiK7bcg=;
        b=QwY1Gmf0mpdzIUeHMY2ec/1u2+Iebqo9VLNhvHXpD20406xrD1EFRCg/qjB3DGhVO1SjZ2
        4kJyxMOAKJz/SdQewOB9xveyYW6qV/puGY4gEHQBtpknRacw0mx196bOVgjrr+dKGwEjiB
        oKRovFxUex1J8fLCaoJN3Po/MojC42ryDQNBcbAqBqX221Kf99aH3dC9bWy1zTJoaxibOW
        VHif3uMWkpk9R+Zb3rtloDewlJ8pv9OmLCMHvY1F8mvW8PjqUKep+v2Rwxm0I9z3gsV2sd
        pY7gWAJHR6OlV/m/qtapmJN8JZJnYx4XqZ3x0W+lXsVWFOeX9BXK7uJi3oPoCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671450416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ws5wq3iitPNqsoUCsp4j6YINoPtE4KBwdrqefiK7bcg=;
        b=RO1SEFNlAtGHjoJ1PFmBE5D424WelWWAUWmLgFcN6tAiniquZ24oy5Ic3TuSvvYv5vrv7A
        g2NqkEgIeFz35JCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC/RFT PATCH 1/2] sched/core: Check and schedule ksoftirq
Message-ID: <Y6BPLoHJNWjjMUv8@linutronix.de>
References: <20221215184300.1592872-1-srinivas.pandruvada@linux.intel.com>
 <20221215184300.1592872-2-srinivas.pandruvada@linux.intel.com>
 <Y5xURk3CkzhIjmmq@hirez.programming.kicks-ass.net>
 <20221216220748.GA1967978@lothringen>
 <Y6BMAp6A731F8ZL4@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6BMAp6A731F8ZL4@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-19 12:33:22 [+0100], Peter Zijlstra wrote:
> ksoftirq is typically a CFS task while idle injection is required to be
> a FIFO (typically FIFO-1) task -- so that would require lifting
> ksoftirqd to FIFO and that has other problems.
> 
> I'm guessing the problem case is where idle injection comes in while
> ksoftirq is running (and preempted), because in that case you cannot run
> the softirq stuff in-place.
> 
> The 'right' thing to do would be to PI boost ksoftirqd in that case I
> suppose. Perhaps something like so, it would boost ksoftirq when it's
> running, and otherwise runs the ksoftirqd thing in-situ.
> 
> I've not really throught hard about this though, so perhaps I completely
> wrecked things.

I don't know why you intend to run ksoftirqd but in general it breaks RT
left and right and we attempt to avoid running ksoftirqd as much as
possible. If it runs and you go and boost it then it probably gets even
worse from RT point of view.

ksoftirqd runs softirqs from hardirq context. Everything else is handled
in is handled within local-bh-disable+enable loop. We already have have
the boost-ksoftird hammer which is the per-CPU BLK called
local_bh_disable(). In general everything should be moved out of it.
For timers we have the ktimerd thread which needs clean up. 

Sebastian
