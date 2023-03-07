Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3376AE10E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjCGNrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjCGNrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:47:13 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F6F457D7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/ZUL4SqqmaOxKlf1ru+8s6qC7jG5qUR0NgbBL+e+eaM=; b=OJ6ynBw58SSxOFbjwnKa6PJBpr
        54frsiromkwstPjpRCQqwQlEedari2c/32rae3qdQ9KQCZm93VD9P5lAmXcSVCl2qss8/6s0J1LBm
        2MLJahU7GNH+8GbhRNQJ3kLbgvqsbx4/NpueTL9Fx4XSiHuGWiLNl21vKEpNUMwAM3Mdvv0kjwEXo
        dNnsbCsvHVkAhxsE1g31vjxF+A/LAEFDYK6JcsvniawM3f3x7R8/TNq/FbWPdOyeP2AKOR/KWr5tQ
        PL4RV5BDuJckiVcgk22Ea+XxOlfH1zW2/dfy3lgCIXiRGOHxqG7Zgjl03UwYyDX5x3xi34Q5MDAXb
        xSJwKlYA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pZX2x-00H31f-31;
        Tue, 07 Mar 2023 13:08:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A8DA130030B;
        Tue,  7 Mar 2023 14:08:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8FD0021F8E080; Tue,  7 Mar 2023 14:08:00 +0100 (CET)
Date:   Tue, 7 Mar 2023 14:08:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Subject: Re: [PATCH 00/10] sched: EEVDF using latency-nice
Message-ID: <20230307130800.GD2017917@hirez.programming.kicks-ass.net>
References: <20230306132521.968182689@infradead.org>
 <CAKfTPtA9DYJ5=VYGpS_XBzzmvgJeYcmmG261A1cby_sT7kHdYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA9DYJ5=VYGpS_XBzzmvgJeYcmmG261A1cby_sT7kHdYg@mail.gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED,URI_DOTEDU autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 11:27:37AM +0100, Vincent Guittot wrote:
> On Mon, 6 Mar 2023 at 15:17, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Hi!
> >
> > Ever since looking at the latency-nice patches, I've wondered if EEVDF would
> > not make more sense, and I did point Vincent at some older patches I had for
> > that (which is here his augmented rbtree thing comes from).
> >
> > Also, since I really dislike the dual tree, I also figured we could dynamically
> > switch between an augmented tree and not (and while I have code for that,
> > that's not included in this posting because with the current results I don't
> > think we actually need this).
> >
> > Anyway, since I'm somewhat under the weather, I spend last week desperately
> > trying to connect a small cluster of neurons in defiance of the snot overlord
> > and bring back the EEVDF patches from the dark crypts where they'd been
> > gathering cobwebs for the past 13 odd years.
> 
> I haven't studied your patchset in detail yet but at a 1st glance this
> seems to be a major rework on the cfs task placement and the latency
> is just an add-on on top of moving to the EEVDF scheduling.

It completely reworks the base scheduler, placement, preemption, picking
-- everything. The only thing they have in common is that they're both a
virtual time based scheduler.

The big advantage I see is that EEVDF is fairly well known and studied,
and a much better defined scheduler than WFQ. Specifically, where WFQ is
only well defined in how much time is given to any task (bandwidth), but
says nothing about how that is distributed in time. That is, there is no
native preemption condition/constraint etc. -- all that code we have is
random heuristics mostly.

The WF2Q/EEVDF class of schedulers otoh *do* define all that. There is a
lot less wiggle room as a result. The avg_vruntime / placement stuff I
did is fundamental to how it controls bandwidth distribution and
guarantees the WFQ subset. Specifically, by limiting the pick to that
subset of tasks that has positive lag (owed time), it guarantees this
fairness -- but that means we need a working measure of lag.

Similarly, since the whole 'when' thing is well defined in order to
provide the additional latency goals of these schedulers, placement is
crucial. Things like sleeper bonus is fundamentally incompatible with
latency guarantees -- both affect the 'when'.


Initial EEVDF paper is here:

https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=805acf7726282721504c8f00575d91ebfd750564

It contains a few 'mistakes' and oversights, but those should not
matter.

Anyway, I'm still struggling to make complete sense of what you did --
will continue to stare at that.


