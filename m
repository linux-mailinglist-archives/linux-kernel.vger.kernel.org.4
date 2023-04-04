Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478586D5FD3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbjDDMBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjDDMBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:01:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416DA40C3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9PdME6AIjx8zNUOdkx4hnCnYTKU8T7/wn+VsuZbpvX4=; b=AsYaGUNwtgs7Mb8yT8mTBmSz08
        Q7zquCj15LyPeR8kg4E9xbftPYNFYRD9WKZDnmEEGGDicZ+t5guiV1zKfPFGs86fWp6cdEetpNDZi
        QAzFOHjQ2CNjEZe9WJINFELQzObgU9U9xGrlx6KwsTsWNzHzYmAYycvTML2KdjkQLAwVDxCE/J2jW
        l+RSUiU33ae6PCQp1m7XdElK7UfRebookUgSv++hIi6t79r4t+S6BJpKjERy6xPj2MaRKX0ECoI/f
        Y/Y0CvT2sf1GFPyxpC9SF4HdBgCB5Z0TL6MRbWwxgQIXQ2e8lbigmyc1eiAUE8h79fJSACXqvQG4t
        9fN+NnPg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pjfLN-00FKho-Fp; Tue, 04 Apr 2023 12:00:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3BC9A300194;
        Tue,  4 Apr 2023 14:00:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18E482C41B779; Tue,  4 Apr 2023 14:00:54 +0200 (CEST)
Date:   Tue, 4 Apr 2023 14:00:54 +0200
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
        joel@joelfernandes.org, efault@gmx.de
Subject: Re: [PATCH 08/17] sched/fair: Implement an EEVDF like policy
Message-ID: <20230404120054.GV4253@hirez.programming.kicks-ass.net>
References: <20230328092622.062917921@infradead.org>
 <20230328110354.141543852@infradead.org>
 <CAKfTPtDDBVD_N6NgBYi_5iArDXd4iL0-ddQZDKGzzLAD-2AUXg@mail.gmail.com>
 <20230330080145.GA117836@hirez.programming.kicks-ass.net>
 <CAKfTPtD+EiB4mnRD0z4wYg6PDn1vLKxu4fxrgfiqsm2G3+RrEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtD+EiB4mnRD0z4wYg6PDn1vLKxu4fxrgfiqsm2G3+RrEQ@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 07:05:17PM +0200, Vincent Guittot wrote:
> On Thu, 30 Mar 2023 at 10:04, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Mar 29, 2023 at 04:35:25PM +0200, Vincent Guittot wrote:
> >
> > > IIUC how it works, Vd = ve + r / wi
> > >
> > > So for a same weight, the vd will be earlier but it's no more alway
> > > true for different weight
> >
> > Correct; but for a heavier task the time also goes slower and since it
> > needs more time, you want it to go first. But yes, this is weird at
> > first glance.
> 
> Yeah, I understand that this is needed for bounding the lag to a
> quantum max but that makes the latency prioritization less obvious and
> not always aligned with what we want

That very much depends on what we want I suppose :-) So far there's not
been strong definitions of what we want, other than that we consider a
negative latency nice task to get it's slice a little earlier where
possible.

(also, I rather like that vagueness -- just like nice is rather vague,
it gives us room for interpretation when implementing things)

> let say that you have 2 tasks A and B waking up simultaneously with
> the same vruntime; A has a negative latency nice to reflect some
> latency constraint and B the default value.  A will run 1st if they
> both have the same prio which is aligned with their  latency nice
> values but B could run 1st if it increase its nice prio to reflect the
> need for a larger cpu bandwidth so you can defeat the purpose of the
> latency nice although there is no unfairness
> 
> A cares of its latency and set a negative latency nice to reduce its
> request slice

This is true; but is it really a problem? It's all relative anyway :-)

Specifically, if you latency-nice harder than nice it, you win again,
also, nice is privilidged, while latency-nice is not (should it?)

The thing I like about EEVDF is that it actually makes the whole thing
simpler, it takes away a whole bunch of magic, and yes the latency thing
is perhaps more relative than absolute, but isn't that good enough?


That said; IIRC there's a few papers (which I can no longer find because
aparently google can now only give me my own patches and the opinion of
the internet on them when I search EEVDF :/) that muck with the {w,r}
set to build 'realtime' schedulers on top of EEVDF. So there's certainly
room to play around a bit.
