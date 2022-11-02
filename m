Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FED8615E0D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiKBIlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiKBIlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:41:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C8B25281
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AEcSOdNEo6t3dgeyiWEOA3kYiOIF8JP031Fu32skkWQ=; b=q/EUJfK1ScYNCbddbch888oOt2
        K3/9N4G7R7QjWsgCqZTfY43fZOJ9lLB1bXb9s+RuxblTejso0ixeudzYK3Ub5EPlYvK7NL10mphaV
        Tvfr7AnHQ2wWeathLaRto2vFcnY+FJhHfWPccKMYuAGTkQg08QjqIgf9/PZkdYoCITsK9gp4aqBUF
        VhMN/9GE+peo7DJp+B4uz2xGQTBGvBUhuuH9Go16CA8rTcFw0rgcZUEB3YvpfE14sHwltyl4GYnUk
        EYlW7J8/xeBi4Df4qpc3Gs+9u2GXF2EOdi1RNrNJW6vUbJxvuCK2Bx4THfuStrNYLNOvNeccXMnx9
        eZdq/VnQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oq9J3-005NX4-6n; Wed, 02 Nov 2022 08:41:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A2DDB30007E;
        Wed,  2 Nov 2022 09:40:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 84638201F22EE; Wed,  2 Nov 2022 09:40:59 +0100 (CET)
Date:   Wed, 2 Nov 2022 09:40:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Benjamin Segall <bsegall@google.com>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
Message-ID: <Y2ItG4BU21Pm0S/u@hirez.programming.kicks-ass.net>
References: <20221026224449.214839-1-joshdon@google.com>
 <Y1/HzzA1FIawYM11@hirez.programming.kicks-ass.net>
 <xm26fsf3wtc2.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26fsf3wtc2.fsf@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 02:56:13PM -0700, Benjamin Segall wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Wed, Oct 26, 2022 at 03:44:49PM -0700, Josh Don wrote:
> >> CFS bandwidth currently distributes new runtime and unthrottles cfs_rq's
> >> inline in an hrtimer callback. Runtime distribution is a per-cpu
> >> operation, and unthrottling is a per-cgroup operation, since a tg walk
> >> is required. On machines with a large number of cpus and large cgroup
> >> hierarchies, this cpus*cgroups work can be too much to do in a single
> >> hrtimer callback: since IRQ are disabled, hard lockups may easily occur.
> >> Specifically, we've found this scalability issue on configurations with
> >> 256 cpus, O(1000) cgroups in the hierarchy being throttled, and high
> >> memory bandwidth usage.
> >> 
> >> To fix this, we can instead unthrottle cfs_rq's asynchronously via a
> >> CSD. Each cpu is responsible for unthrottling itself, thus sharding the
> >> total work more fairly across the system, and avoiding hard lockups.
> >
> > So, TJ has been complaining about us throttling in kernel-space, causing
> > grief when we also happen to hold a mutex or some other resource and has
> > been prodding us to only throttle at the return-to-user boundary.
> >
> > Would this be an opportune moment to do this? That is, what if we
> > replace this CSD with a task_work that's ran on the return-to-user path
> > instead?
> 
> This is unthrottle, not throttle, but it would probably be

Duh..
