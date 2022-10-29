Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949E96121A6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 10:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJ2I7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 04:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2I7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 04:59:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588288680C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 01:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fSO3SPd0y/0Iw4V5qCxwWKWaNnU3HHauboB7ePJnKa8=; b=NCf8PES773iXGn0d+XatRgpjRH
        moZ50plI1n3Mj8x3UGSPpI5y6fshaHNS3nGeMbC+9liBiT1t9fDiB4ODhVZOPd7wXZaJfvvFmSdKQ
        piIGrumptqpWViG66e6Jp3UQuifd7LLQ+/BZGkBA5+UTzka5Q3E4+ZtzXAybK4EFm+nc3PrRp0LPO
        cvxz7B1BWS6Gozj3ehC+uIHG0mB9bMgflVbqQpJM8xm4W3I60NGqltrui4mspdwniCz3beWuygaUB
        c1MLYHw07vlOsrkznzUA3qw4Oj71D+l5szX40V0FvgwHIT9N5A/p1xI1NsuhGUZ+T7ZD21ybKF5Xf
        PT7RmwEg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oohfj-007JNo-7m; Sat, 29 Oct 2022 08:58:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2497D30008D;
        Sat, 29 Oct 2022 10:58:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 02B892B56B636; Sat, 29 Oct 2022 10:58:28 +0200 (CEST)
Date:   Sat, 29 Oct 2022 10:58:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rohit.k.jain@oracle.com,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Regression on vcpu_is_preempted()
Message-ID: <Y1zrNKEUPRem/UUI@hirez.programming.kicks-ass.net>
References: <89856431-e68b-ebe9-90cb-e46ed8065659@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89856431-e68b-ebe9-90cb-e46ed8065659@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 04:48:21PM +0800, Miaohe Lin wrote:
>   When scheduler tries to select a CPU to run the gc thread,
>   available_idle_cpu() will check whether vcpu_is_preempted().  It
>   will choose other vcpu to run gc threads when the current vcpu is
>   preempted. But the preempted vcpu has no other work to do except
>   continuing to do gc. In our guest, there are more vcpus than java gc
>   threads. So there could always be some available vcpus when
>   scheduler tries to select a idle vcpu (runing on host). This leads
>   to lots of cpu migrations and results in regression.
> 
>   I'm not really familiar with this mechanism. Is this a problem that
>   needs to be fixed or improved? Or is this just expected behavior?
>   Any response would be really appreciated!

This is pretty much expected behaviour. When a vCPU is preempted the
guest cannot know it's state or latency. Typically in the overcomitted
case another vCPU will be running on the CPU and getting our vCPU thread
back will take a considerable amount of time.

If you know you're not over-committed, perhaps you should configure your
VM differently.
