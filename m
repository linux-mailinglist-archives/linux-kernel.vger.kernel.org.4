Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CE6613726
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiJaM5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiJaM5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:57:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCA3F5B5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9aBywTwEBQKb2gzcgaRgyZsi2EZSM4ZEWUFJjjtFqMs=; b=gdz2pKtgNOiMLJL3AfPt64lx87
        3ZiKv0c9OvAxLl/oxXAgGaVQS/KOfxjApfZTdRvZ5X6uqY0B/PvmUeFykRRKN6/4hZiLT87fhli1k
        IGOu7BhNs+uI3aUSNn6aKK+t81baGEP53Tx6bC6dtqJLg47u5Wn4uaB0A/KvlQMte1jUSZAUHDhcv
        fv3qNJjENZBvXTeKHsQ/Oue5zvp3/aWFtRwuT9GauKCuU+B/oSvdeO/+1pLVvUV885aisrLqBVvHZ
        gQJ5TndC0sU6wWK6Qz5fgeYdZuge0er/x3guh9zXEmsAfSe3yznTT0dE46NUUZSoBlUFoLCUk7Ksv
        2Ff4eNuA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opUM8-007sDe-RH; Mon, 31 Oct 2022 12:57:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28CA130029C;
        Mon, 31 Oct 2022 13:57:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4DAF2C74B23D; Mon, 31 Oct 2022 13:57:31 +0100 (CET)
Date:   Mon, 31 Oct 2022 13:57:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrei Vagin <avagin@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched: consider WF_SYNC to find idle siblings
Message-ID: <Y1/GO1eWt+oTNA24@hirez.programming.kicks-ass.net>
References: <20221027202603.670616-1-avagin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027202603.670616-1-avagin@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 01:26:03PM -0700, Andrei Vagin wrote:
> From: Andrei Vagin <avagin@gmail.com>
> 
> WF_SYNC means that the waker goes to sleep after wakeup, so the current
> cpu can be considered idle if the waker is the only process that is
> running on it.
> 
> The perf pipe benchmark shows that this change reduces the average time
> per operation from 8.8 usecs/op to 3.7 usecs/op.
> 
> Before:
>  $ ./tools/perf/perf bench sched pipe
>  # Running 'sched/pipe' benchmark:
>  # Executed 1000000 pipe operations between two processes
> 
>      Total time: 8.813 [sec]
> 
>        8.813985 usecs/op
>          113456 ops/sec
> 
> After:
>  $ ./tools/perf/perf bench sched pipe
>  # Running 'sched/pipe' benchmark:
>  # Executed 1000000 pipe operations between two processes
> 
>      Total time: 3.743 [sec]
> 
>        3.743971 usecs/op
>          267096 ops/sec

But what; if anything, does it do for the myrad of other benchmarks we
run?
