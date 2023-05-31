Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51FA71804B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbjEaMtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235973AbjEaMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:49:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD75E46
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=43PZ7APiLSZw4p8V3oESMbNYg24McF+5B7Oexe48Sr0=; b=YzzuCGuuyWwEyLi5LKjKjEuwBk
        vWljkFJM0uR0sKmb9XcV78lQSS2/v5GNjiNEqJLpAMoOeCL7ksS2EqldWz0S8HPm2TI2Owc9NFF3h
        rqpr8FzYhu4mUeS6gy3gRUBmYu+ZhLw9rJFdw1TiYhF6WIKCfnhk/Ty9poWp/nmPWf9TnCtDridc7
        hUQAMTMsXj0JfIc8d7J8wODqN5MTY85B9JdPdvteeYXSjHU+Fa7W9YRWGPZ28y2oXOsLbaNGYBOQW
        ARTnYRrcZR9j8FcDA0ptyaAvu0scqsMuAKimy1t7Ewxlr9E9bTWFUlGGsqVr2GViuDMD5XqzhpEkM
        Zlw6WA5w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4LEp-007GRX-0i; Wed, 31 May 2023 12:47:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 058CD3002A9;
        Wed, 31 May 2023 14:47:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D3FEE20FF5F85; Wed, 31 May 2023 14:47:33 +0200 (CEST)
Message-ID: <20230531115839.089944915@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 31 May 2023 13:58:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: [PATCH 00/15] sched: EEVDF and latency-nice and/or slice-attr
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Latest version of the EEVDF [1] patches.

The only real change since last time is the fix for tick-preemption [2], and a 
simple safe-guard for the mixed slice heuristic.

Other than that, I've re-arranged the patches to make EEVDF come first and have
the latency-nice or slice-attribute patches on top.

Results should not be different from last time around, lots of people ran them
and found no major performance issues; what was found was better latency and
smaller variance (probably due to the more stable latency).

I'm hoping we can start queueing this part.

The big question is what additional interface to expose; some people have
voiced objections to the latency-nice interface, the 'obvious' alternative
is to directly expose the slice length as a request/hint.

The very last patch implements this alternative using sched_attr::sched_runtime
but is untested.

Diffstat for the base patches [1-11]:

 include/linux/rbtree_augmented.h |   26 +
 include/linux/sched.h            |    7 +-
 kernel/sched/core.c              |    2 +
 kernel/sched/debug.c             |   48 +-
 kernel/sched/fair.c              | 1105 ++++++++++++++++++--------------------
 kernel/sched/features.h          |   24 +-
 kernel/sched/sched.h             |   16 +-
 7 files changed, 587 insertions(+), 641 deletions(-)


[1] https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=805acf7726282721504c8f00575d91ebfd750564

[2] https://lkml.kernel.org/r/20230420150537.GC4253%40hirez.programming.kicks-ass.net

