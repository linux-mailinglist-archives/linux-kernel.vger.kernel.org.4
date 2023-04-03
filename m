Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507236D5487
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 00:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjDCWHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 18:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbjDCWHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:07:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA703E5B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 15:07:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680559651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vAvtMfEQqqct4AWZHCiEowGKxwaBoH/2w4q0y2AQHjE=;
        b=0xfgb68oTrIMfQ+CVG2z3/7V2K9K8a+MUmGW6RuRBoj4J5PIhRg8T7mcNHVjEg2Qst6TaA
        4uW8/+AbrEagGfu+DxzBeqSl9bQ5yqNftjufOC0+UzUv7edyUZIGEMDHU/sCqBwqAL3bAo
        0/uf/5IWDXiFu39Zt13qiK5Wj8osrAhRnHiS9co40BYB73qL3+npyh8Tf7YZrKa3DKEDZ0
        TIgdTSEvT3cdNRFjbgatNTRVJQovb5NbLWp4BhtRZFYLiv2KaJoK4IKFglCikzFybYuD8x
        JpNx5Fz42EnHREKOqqlLAGw1x3UfpoYJ5PMbF1ZP5KZ1AClp9iG2HeWQs86N0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680559651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vAvtMfEQqqct4AWZHCiEowGKxwaBoH/2w4q0y2AQHjE=;
        b=nDbHfK4Ete28h4npijXgkjZ/0jFIH9+CNpGGW0vR0I4qXRjJrv6CwBgK1/ojhisLtw72l7
        MdoXpwFKdRvIj2Bw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] perf: Optimize perf_pmu_migrate_context()
In-Reply-To: <20230403090858.GT4253@hirez.programming.kicks-ass.net>
References: <20230403090858.GT4253@hirez.programming.kicks-ass.net>
Date:   Tue, 04 Apr 2023 00:07:30 +0200
Message-ID: <87sfdgr55p.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03 2023 at 11:08, Peter Zijlstra wrote:
> Thomas reported that offlining CPUs spends a lot of time in
> synchronize_rcu() as called from perf_pmu_migrate_context() even though
> he's not actually using uncore events.

That happens when offlining CPUs from a socket > 0 in the same order how
those CPUs have been brought up. On socket 0 this is not observable
unless the bogus CPU0 offlining hack is enabled.

If the offlining happens in the reverse order then all is shiny.

The reason is that the first online CPU on a socket gets the uncore
events assigned and when it is offlined then those are moved to the next
online CPU in the same socket.

On a SKL-X with 56 threads per sockets this results in a whopping _1_
second delay per thread (except for the last one which shuts down the
per socket uncore events with no delay because there are no users) due
to 62 times of pointless synchronize_rcu() invocations where each takes
~16ms on a HZ=250 kernel.

Which in turn is interesting because that machine is completely idle
other than running the offline muck...

> Turns out, the thing is unconditionally waiting for RCU, even if there's
> no actual events to migrate.
>
> Fixes: 0cda4c023132 ("perf: Introduce perf_pmu_migrate_context()")
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
