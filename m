Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9091A6E2C37
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 00:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjDNWB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 18:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjDNWB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 18:01:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654AE210B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B62sKJRwTrdOBzA6nH7glkMxYADRXw6l7Dz/KzkrV2w=; b=M87TG0hPZhnJi3gc46epT3LVyO
        cvD+OaKxnaAmsdJtvrCUjvIJtkcoxL+ikxenKQcBMNyHYySvRZRR6VrhVVY4v15pKgQP6JhmHppgo
        zcVe3yGSFIVofj2e3FiM/FByH7pQnMZ5eu1pVaK9z4y4w7lt/6w2iPf0SAcnSTYoX7ocVOJGEbrh7
        kYmBOG2YdjIvXclw+vCgWqqVa0pq/o4kqUsT2P5HLd/gzvAlLqaAvVTbQCBh11YK1vZx0QKfPMdit
        ERtsCimFXYizhUyT5wTFhoggugD9/23V0wJAZGSJ+hwICLtvR7ir5b30mSJJT/oqq+kRZiKp4f8gi
        aQ63loPg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnRTg-0097WK-Lo; Fri, 14 Apr 2023 22:01:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D68F63002A6;
        Sat, 15 Apr 2023 00:01:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 78222241FB92E; Sat, 15 Apr 2023 00:01:06 +0200 (CEST)
Date:   Sat, 15 Apr 2023 00:01:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        eranian@google.com
Subject: Re: [PATCH 2/6] perf: Support branch events logging
Message-ID: <20230414220106.GC778423@hirez.programming.kicks-ass.net>
References: <20230410204352.1098067-1-kan.liang@linux.intel.com>
 <20230410204352.1098067-2-kan.liang@linux.intel.com>
 <20230414103832.GD83892@hirez.programming.kicks-ass.net>
 <1d62b865-5d31-ec36-99e0-785844f79199@linux.intel.com>
 <20230414145324.GB761523@hirez.programming.kicks-ass.net>
 <803927bb-6f74-5c09-3c18-2fd5f423287b@linux.intel.com>
 <20230414160945.GC761523@hirez.programming.kicks-ass.net>
 <085fa11e-ea07-c148-1b32-8a09007ee12b@linux.intel.com>
 <20230414192407.GA778423@hirez.programming.kicks-ass.net>
 <2428e6a2-9578-1e1d-bdef-ffcc87301503@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2428e6a2-9578-1e1d-bdef-ffcc87301503@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 04:34:45PM -0400, Liang, Kan wrote:

> > I never understood the whole order thing. What was it trying to do?
> 
> Let's say we have three events with the LBR event logging feature as below.
>     perf record -e branches,branches,instructions:ppp -j any,event
> 
> The counter 0 will be assigned to instructions:ppp, since the PDist is
> only supported on GP 0 & 1.
> The count 1 & 2 will be assigned to the other two branches.
> 
> If branches occurs 1 time and instructions occurs 3 times in a LBR
> block, the LBR_INFO will have 0b010111 (counter order).
> 
> But as you can see from the perf command, the first event is actually
> branches. Without the event IDs information, perf tool will interpret
> that branches 3 branches 1 and instructions:ppp 1. That's wrong.
> 
> If there are multiple users, the situation becomes even worse.

But this makes no sense what so ever; in this case you have no control
over what events you'll actually get in your LBR. Could be none of the
events you're interested in end up in 0-3 but instead land on 4-7.

> >> But if we have two groups with LBR event, the order information is still
> >> required. Why we still want to group things?
> > 
> > Why would you need that; what is that whole order nonsense about?
> > 
> > {e1, e2, e3, e4}, {e5, e6, e7, e8} with e1 and e5 both having LBR on
> > just works no?
> > 
> > Since they have LBR and that extra sample flag they all get a 0-3
> > constraint.
> > 
> > Since both e1 and e5 use LBR, they're mutually exclusive, either e1 or
> > e5 group runs.
> 
> It's possible that someone pins an event using LBR, and set more than 4
> events for logging, e0:D,{e1, e2},{e3, e4},{e5, e6}. If so, those events
> could do multiplexing. Without the event IDs information, perf tool has
> no idea how to interpret the information.

Yeah, don't do this. There is no guarantee what so ever you'll get any
of those events in the 0-3 range.

You really *must* make then a group such that perf knows what events to
associated with the LBR event and constain them to the 0-3 range of
PMCs.

If you want multiplexing, simply create multiple groups with an LBR
event in them.
