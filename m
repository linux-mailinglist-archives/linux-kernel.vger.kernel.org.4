Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A35F6AC309
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjCFOVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjCFOUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:20:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB768A61
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Xz7dL2tcnPT6ww6dXBhPnkI2dUM8QaQFf+4VBLsgKss=; b=WbbkGE3kA9CEMDoY7iWLv8LRxj
        8VLWzwhdYPKhqDA2EeHvBBgyKGhtaeqRnQr+yZ8E6ILGKV950+Jh81aPZm7ATs20i7+hQHCyhHWLU
        IL45M6i0+82G35n+5LT0/ZVIw7rWAMNSurUpRpuwpCmebPZQOkfqL8u2TXk+HDfeoZOutFPh0jil3
        6Ax+40Ffr05BlpJmlMEgn9j+J6/QgyXLVL1tbFNstaZUmzWJhtusDEnx78r1FigM68tMldvAaBu/7
        NQFvxTZqCMEupJgAK33qmR6q7AJ/FWoRHYtEekIo4/UDg/hSaGBurYrX8TL93ildpK87KsgiIgGz7
        6ftM4S3w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZBe5-005P2M-Iu; Mon, 06 Mar 2023 14:16:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 08881300137;
        Mon,  6 Mar 2023 15:16:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E55AB2130D7A2; Mon,  6 Mar 2023 15:16:54 +0100 (CET)
Message-ID: <20230306132521.968182689@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 06 Mar 2023 14:25:21 +0100
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
        joel@joelfernandes.org
Subject: [PATCH 00/10] sched: EEVDF using latency-nice
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Ever since looking at the latency-nice patches, I've wondered if EEVDF would
not make more sense, and I did point Vincent at some older patches I had for
that (which is here his augmented rbtree thing comes from).

Also, since I really dislike the dual tree, I also figured we could dynamically
switch between an augmented tree and not (and while I have code for that,
that's not included in this posting because with the current results I don't
think we actually need this).

Anyway, since I'm somewhat under the weather, I spend last week desperately
trying to connect a small cluster of neurons in defiance of the snot overlord
and bring back the EEVDF patches from the dark crypts where they'd been
gathering cobwebs for the past 13 odd years.

By friday they worked well enough, and this morning (because obviously I forgot
the weekend is ideal to run benchmarks) I ran a bunch of hackbenck, netperf,
tbench and sysbench -- there's a bunch of wins and losses, but nothing that
indicates a total fail.

( in fact, some of the schbench results seem to indicate EEVDF schedules a lot
  more consistent than CFS and has a bunch of latency wins )

( hackbench also doesn't show the augmented tree and generally more expensive
  pick to be a loss, in fact it shows a slight win here )


  hackbech load + cyclictest --policy other results:


			EEVDF			 CFS

		# Min Latencies: 00053
  LNICE(19)	# Avg Latencies: 04350
		# Max Latencies: 76019

		# Min Latencies: 00052		00053
  LNICE(0)	# Avg Latencies: 00690		00687
		# Max Latencies: 14145		13913

		# Min Latencies: 00019
  LNICE(-19)	# Avg Latencies: 00261
		# Max Latencies: 05642


The nice -19 numbers aren't as pretty as Vincent's, but at the end I was going
cross-eyed from staring at tree prints and I just couldn't figure out where it
was going side-ways.

There's definitely more benchmarking/tweaking to be done (0-day already
reported a stress-ng loss), but if we can pull this off we can delete a whole
much of icky heuristics code. EEVDF is a much better defined policy than what
we currently have.


