Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4A6674F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjATIZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjATIZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:25:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192B66C13D;
        Fri, 20 Jan 2023 00:25:04 -0800 (PST)
Date:   Fri, 20 Jan 2023 09:25:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674203102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EW8WxfGlo7Z0hlPrNiMcuJpvKn5fURLAgb76eM76chc=;
        b=sDge4ZGvVNczEo0IxcwLsPGOET45jvufaYgyg4o5w+SHHhLnYcI9Oa+Kjnc1JVsGdbw4ER
        nn+zXTc1xSrg38OMnT/XGGbchGmzrDCICkmJ2YXOIZEHmM0wASB34vbRUzKtxWXSQ/RXSq
        PsuDDVdqZG1TnIxU7GWKpGFPAgOrELpMvc0qF3jmIQ4btHVSOzBDOnTk8ksqq6tMkVhDOJ
        XCY+clsk2q0ffOfDa8XcohUrxcklIEM/Isi3+XQjhLEkTH5lwBJdQyHo//77SzcKDErgFC
        pHKn1h4dlKXLBcyUnt2a1RKLEzpn3iwcVFXbb/frjdRc6MUg0fjNTTG8uGWH4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674203102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EW8WxfGlo7Z0hlPrNiMcuJpvKn5fURLAgb76eM76chc=;
        b=g2RQ2E2lMR1HQFsq4hO6g8uUApU4XwFvlm/AJ7D8mYBpPQOgK8AMFuT7VO05YF+kSjosP/
        wi5XPN5COMSuRBCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <Y8pP3CD1PQ4KWhXF@linutronix.de>
References: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
 <Y8avJm1FQI9vB9cv@linutronix.de>
 <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
 <Y8gPhTGkfCbGwoUu@linutronix.de>
 <20230118173130.4n2b3cs4pxiqnqd3@techsingularity.net>
 <Y8j+lENBWNWgt4mf@linutronix.de>
 <20230119110220.kphftcehehhi5l5u@techsingularity.net>
 <Y8lvwKHmmnikVDgk@linutronix.de>
 <20230119174101.rddtxk5xlamlnquh@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230119174101.rddtxk5xlamlnquh@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-19 17:41:01 [+0000], Mel Gorman wrote:
> 
> Yes, it makes your concern much clearer but I'm not sure it actually matters
> in terms of preventing write starvation or in terms of correctness. At
> worst, a writer is blocked that could have acquired the lock during a tiny
> race but that's a timing issue rather than a correctness issue.

Correct. My concern is that one reader may need to wait 4ms+ for the
lock while a following reader (that one that sees the timeout) does not.
This can lead to confusion later on.

> Lets say the race hits
> 
> 									reader sees waiter_timeout == 0
> 	writer acquires wait_lock
> 	__rwbase_write_trylock fails
> 	update waiter_timeout
> 	rwbase_schedule
> 
> Each reader that hits the race goes ahead at a point in time but anything
> readers after that observe the timeout and eventually the writer goes ahead.
> 
> If the waiter_timeout was updated before atomic_sub(READER_BIAS),
> it doesn't close the race as atomic_sub is unordered so barriers would
> also be needed and clearing of waiter_timeout moves to out_unlock in case
> __rwbase_write_trylock succeeds. That's possible but the need for barriers
> makes it more complicated than is necessary.

yes...

> The race could be closed by moving wait_lock acquisition before the
> atomic_sub in rwbase_write_lock() but it expands the scope of the wait_lock
> and I'm not sure that's necessary for either correctness or preventing
> writer starvation. It's a more straight-forward fix but expanding the
> scope of a lock unnecessarily has been unpopular in the past.
> 
> I think we can close the race that concerns you but I'm not convinced we
> need to and changing the scope of wait_lock would need a big comment and
> probably deserves a separate patch.

would it work to check the timeout vs 0 before and only apply the
timeout check if it is != zero? The writer would need to unconditionally
or the lowest bit. That should close gaps at a low price. The timeout
variable is always read within the lock so there shouldn't be need for
any additional barriers.

> Sorry if I'm still missing something stupid and thanks for your patience
> reviewing this.
thank that it is patience and not pain in the ass ;)

Sebastian
