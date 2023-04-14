Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C8E6E263D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjDNOxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNOxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:53:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B5B65AE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=G5dM9A3Hqy8PzH8SIqAZvG+kVcmeMsWN7hZSTTBIVNo=; b=LnVdWbn/8TteKSKPljrPlUV50U
        w2k+87KGn+avS4uV0uqlqvCawU9fY+KaTk1SZ7MQld3/WwKyUMPAZE6W8cgr5XHKMLb/7EjE8Q6Ox
        EHcG+dZxAnefR5THMb1qStBXCDRO221A8E9rSn30eAo+ykj2NkzRBJQXYyJ3bP6jqDexRbroxAjie
        69asRUG7bLER5KUOZurn1kaWkXKsMlC9gDitaT+sEYUjY3uqlhKOXLFbQkxut9Sj09Ngzc0UkYifI
        PBy43N3aO2saZc/SGPS/Z6r7dD/ApXKM4VeppdCWS+NbzjW+Xm19ig/2novRrkBkGPQ6+78Etm+mj
        pGn0j0nA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnKnm-008puC-24; Fri, 14 Apr 2023 14:53:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A1472300AFB;
        Fri, 14 Apr 2023 16:53:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6902A275FCB94; Fri, 14 Apr 2023 16:53:24 +0200 (CEST)
Date:   Fri, 14 Apr 2023 16:53:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH 2/6] perf: Support branch events logging
Message-ID: <20230414145324.GB761523@hirez.programming.kicks-ass.net>
References: <20230410204352.1098067-1-kan.liang@linux.intel.com>
 <20230410204352.1098067-2-kan.liang@linux.intel.com>
 <20230414103832.GD83892@hirez.programming.kicks-ass.net>
 <1d62b865-5d31-ec36-99e0-785844f79199@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d62b865-5d31-ec36-99e0-785844f79199@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 09:35:37AM -0400, Liang, Kan wrote:
> 
> 
> On 2023-04-14 6:38 a.m., Peter Zijlstra wrote:
> > On Mon, Apr 10, 2023 at 01:43:48PM -0700, kan.liang@linux.intel.com wrote:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> With the cycle time information between branches, stalls can be easily
> >> observed. But it's difficult to explain what causes the long delay.
> >>
> >> Add a new field to collect the occurrences of events since the last
> >> branch entry, which can be used to provide some causality information
> >> for the cycle time values currently recorded in branches.
> >>
> >> Add a new branch sample type to indicate whether include occurrences of
> >> events in branch info.
> >>
> >> Only support up to 4 events with saturating at value 3.
> >> In the current kernel, the events are ordered by either the counter
> >> index or the enabling sequence. But none of the order information is
> >> available to the user space tool.
> >> Add a new PERF_SAMPLE format, PERF_SAMPLE_BRANCH_EVENT_IDS, and generic
> >> support to dump the event IDs of the branch events.
> >> Add a helper function to detect the branch event flag.
> >> These will be used in the following patch.
> > 
> > I'm having trouble reverse engineering this. Can you more coherently
> > explain this feature and how you've implemented it?
> 
> Sorry for that.
> 
> The feature is an enhancement of ARCH LBR. It adds new fields in the
> LBR_INFO MSRs to log the occurrences of events on the first 4 GP
> counters. Worked with the previous timed LBR feature together, the user
> can understand not only the latency between two LBR blocks, but also
> which events causes the stall.
> 
> The spec can be found at the latest Intel® Architecture Instruction Set
> Extensions and Future Features, v048. Chapter 8.4.
> https://cdrdv2.intel.com/v1/dl/getContent/671368

Oh gawd; that's terse. Why can't these people write comprehensible
things :/ It's almost as if they don't want this stuff to be used.

So IA32_LBR_x_INFO is extended:

  [0:15]	CYC_CNT
  [16:31]	undefined
+ [32:33]	PMC0_CNT
+ [34:35]	PMC1_CNT
+ [36:37]	PMC2_CNT
+ [38:39]	PMC3_CNT
+ [40:41]	PMC4_CNT
+ [42:43]	PMC5_CNT
+ [44:45]	PMC6_CNT
+ [46:47]	PMC7_CNT
  [48:55]	undefined
  [56:59]	BR_TYPE
  [60]		CYC_CNT_VALID
  [61]		TSX_ABORT

Where the PMCx_CNT fields are saturating counters for the respective
PMCs. And we'll run out of bits if we get more than 12 PMCs. Is SMT=n
PMC merging still a thing?

And for some reason this counting is enabled in PERFEVTSELx[35] instead
of in LBR_CTL somewhere :/

> To support the feature, there are three main changes in ABIs.
> - A new branch sample type, PERF_SAMPLE_BRANCH_EVENT, is used as a knob
> to enable the feature.

> - Extend the struct perf_branch_entry layout, because we have to save
> and pass the occurrences of events to user space. Since it's only
> available for 4 counters and saturating at value 3, it only occupies 8
> bits. For the current Intel implementation, the order is the order of
> counters.

Only for 4? Where does it say that? If it were to only support 4, then
we're in counter scheduling contraint hell again and we need to somehow
group all these things together with the LBR event.

  @@ -1410,6 +1423,10 @@ union perf_mem_data_src {
  *    cycles: cycles from last branch (or 0 if not supported)
  *      type: branch type
  *      spec: branch speculation info (or 0 if not supported)
  + *      events: occurrences of events since the last branch entry.
  + *              The fields can store up to 4 events with saturating
  + *              at value 3.
  + *              (or 0 if not supported)
  */
  struct perf_branch_entry {
	  __u64   from;
  @@ -1423,7 +1440,8 @@ struct perf_branch_entry {
		  spec:2,     /* branch speculation info */
		  new_type:4, /* additional branch type */
		  priv:3,     /* privilege level */
  -               reserved:31;
  +               events:8,   /* occurrences of events since the last branch entry */
  +               reserved:23;
  };

  union perf_sample_weight {

This seems properly terrible from an interface pov. What if the next
generation of silicon extends this to all 8 PMCs or another architecture
comes along that does this with 3 bits per counter etc...

> - Add a new PERF_SAMPLE format, PERF_SAMPLE_BRANCH_EVENT_IDS, to dump
> the order information. User space tool doesn't understand the order of
> counters. So it cannot map the new fields in struct perf_branch_entry to
> a specific event. We have to dump the order information.

Sorry; I can't parse this.


