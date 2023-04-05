Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1994D6D7711
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbjDEIga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbjDEIgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:36:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C7D4ED7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tuc7Tw7Iz8O2ng1TY5WWW4Og8yXZPJKe3/KO5Hh4bng=; b=kzDdQllYU4MHR2+xJdhlNID6UO
        ixmZ9W2cY/kFcFp2YipCVtTMbraZ+lAFgdpkcF6+ijMqQLvESLq1Q6pPjV/fDPRVvjLYU/jWDePex
        g4PTvbs5Y6Xnp1/2Ryw7aA6OPMUXlNrvf4pFR80QvXWH1Fel5Z8COGIlZFEyB3D7VXlyir6pnYaTb
        JIcTUJmn6nt8j3zhLHwCJap0iHgsdbWuoj8P7EhimqAUMosa0c3RiHLy5/xCqMm5MvEtrNOWiOPBY
        L9lja1W+eQHKEAZyAFMH/8/Y50i/VWURlyIQqpNAaLAndECEnwkh4rOE7su8u3yizKEkVxjR7xF35
        /ZNy67iw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjycL-00GCRj-LO; Wed, 05 Apr 2023 08:35:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CAE8F300202;
        Wed,  5 Apr 2023 10:35:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A6D2226C567C0; Wed,  5 Apr 2023 10:35:43 +0200 (CEST)
Date:   Wed, 5 Apr 2023 10:35:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, efault@gmx.de
Subject: Re: [PATCH 14/17] sched/eevdf: Better handle mixed slice length
Message-ID: <20230405083543.GZ4253@hirez.programming.kicks-ass.net>
References: <20230328092622.062917921@infradead.org>
 <20230328110354.562078801@infradead.org>
 <CAKfTPtAkFBw5zt0+WK7dWBUE9OrbOOExG8ueUE6ogdCEQZhpXQ@mail.gmail.com>
 <20230404092936.GD284733@hirez.programming.kicks-ass.net>
 <20230404135050.GA471948@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404135050.GA471948@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 01:50:50PM +0000, Joel Fernandes wrote:
> On Tue, Apr 04, 2023 at 11:29:36AM +0200, Peter Zijlstra wrote:

> > Heh, this is actually the correct behaviour. If you have a u=1 and a
> > u=.5 task, you should distribute time on a 2:1 basis, eg. 67% vs 33%.
> 
> Splitting like that sounds like starvation of the sleeper to me. If something
> sleeps a lot, it will get even less CPU time on an average than it would if
> there was no contention from the u=1 task.

No, sleeping, per definition, means you're not contending for CPU. What
CFS does, giving them a little boost, is strictly yuck and messes with
latency -- because suddenly you have a task that said it wasn't
competing appear as if it were, but you didn't run it (how could you, it
wasn't there to run) -- but it still needs to catch up.

The reason it does that, is mostly because at the time we didn't want to
do the whole lag thing -- it's somewhat heavy on the u64 mults and 32bit
computing was still a thing :/ So hacks happened.

That said; I'm starting to regret not pushing the EEVDF thing harder
back in 2010 when I first wrote it :/

> And also CGroups will be even more weird than it already is in such a world,
> 2 different containers will not get CPU time distributed properly- say if
> tasks in one container sleep a lot and tasks in another container are CPU
> bound.

Cgroups are an abomination anyway :-) /me runs like hell. But no, I
don't actually expect too much trouble there.

Or rather, as per the above, time distribution is now more proper than
it was :-)
