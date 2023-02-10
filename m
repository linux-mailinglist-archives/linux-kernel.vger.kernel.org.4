Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E61B6923B2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjBJQxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjBJQx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:53:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BC03D08B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5N8u3zp9JP7/GZvcqq1Y75dqon3aYejvtXyCnTSCHrw=; b=hiMbvg2evcfj0kEFtdL5vQuznp
        6xgeaiU5SvVLJfk4Qq2fEXUgYh2RcPFbFYAWfBTbDi+kN6fzDueUZfucJUJRRnaZ1A3dWkg7grZYh
        Y9cIQk7POoakQWpudpktuaQeRhPDSVaqFpCqkxvI1d14NgcAzIIxnjLRZwkEudlBLud32U6/lb5xM
        OCWzVUjUA7aLxIINJR5eBIYMrFRDk/GuaxyyoL0jcbrTK+49cC/sADhGk0S7D1LxdlYWBop1eT3Jq
        nYcr7bZ7cgI1y+KAaNzbcbFyLDhc2Dp0dR2atH9cQTQvGoj05wEzeuBi3x6VDrXn2Dum66CH58Aud
        3dhWlamQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQWe0-003HDc-Sb; Fri, 10 Feb 2023 16:53:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB2BB3001CE;
        Fri, 10 Feb 2023 17:53:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B73A42042B9C1; Fri, 10 Feb 2023 17:53:03 +0100 (CET)
Date:   Fri, 10 Feb 2023 17:53:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
Message-ID: <Y+Z2b/OtZDk9cT53@hirez.programming.kicks-ass.net>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
 <Y+YXrk5NRuWaSOGR@hirez.programming.kicks-ass.net>
 <xhsmhmt5lr2nz.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhmt5lr2nz.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 02:54:56PM +0000, Valentin Schneider wrote:

> So something like have SD_PREFER_SIBLING affect the SD it's on (and not
> its parent), but remove it from the lowest non-degenerated topology level?

So I was rather confused about the whole moving it between levels things
this morning -- conceptually, prefer siblings says you want to try
sibling domains before filling up your current domain. Now, balancing
between siblings happens one level up, hence looking at child->flags
makes perfect sense.

But looking at the current domain and still calling it prefer sibling
makes absolutely no sense what so ever.

In that confusion I think I also got the polarity wrong, I thought you
wanted to kill prefer_sibling for the assymetric SMT cases, instead you
want to force enable it as long as there is one SMT child around.

Whichever way around it we do it, I'm thinking perhaps some renaming
might be in order to clarify things.

How about adding a flag SD_SPREAD_TASKS, which is the effective toggle
of the behaviour, but have it be set by children with SD_PREFER_SIBLING
or something.

OTOH, there's also

  if (busiest->group_weight == 1 || sds->prefer_sibling) {

which explicitly also takes the group-of-one (the !child case) into
account, but that's not consistently done.

	sds->prefer_sibling = !child || child->flags & SD_PREFER_SIBLING;

seems an interesting option, except perhaps ASYM_CPUCAPACITY -- I
forget, can CPUs of different capacity be in the same leaf domain? With
big.LITTLE I think not, they had their own cache domains and so you get
at least MC domains per capacity, but DynamiQ might have totally wrecked
that party.

> (+ add it to the first NUMA level to keep things as they are, even if TBF I
> find relying on it for NUMA balancing a bit odd).

Arguably it ought to perhaps be one of those node_reclaim_distance
things. The thing is that NUMA-1 is often fairly quick, esp. these days
where it's basically on die numa.

