Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0095724D2B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbjFFThc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjFFTh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:37:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2686910EC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7nPJmt1YbxBA+uRPcnfzZcZB2IcwnMd+BwGKXN9vfFA=; b=JDFFvir3u8hLolqk/Shj3RX09j
        gns0AVX3Md+BBDncVsQEy274Y3go7x84VlS7bD6LNF4md8kQDaXHrKnb36JJWGcZbdG45BW8wvjpq
        GmKzQnQ9lLjHKYF7F2QC8TE2yn6aathsREQU3ke5E+r4tp8SlE8+5ADHzZPDWSuNGVm+wNMVtcozh
        o9B6ToIT3yvTpjE1EkrqPo/jADL57lRBTJvWdS9WB5xM6s5//RAUtVwtrfD519fkjV6wnDBj7UGag
        Sh1hqVAhbdA79fzxfTj12ghmIQV4M7yddJU/AXZdtcGhY5kEt7XQkHP2jj31S9L1EnvgNgPtj8QWH
        XaeZMHuQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6cUT-00DSwb-KM; Tue, 06 Jun 2023 19:37:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 584EE30026A;
        Tue,  6 Jun 2023 21:37:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12EE52C9CD1D8; Tue,  6 Jun 2023 21:37:12 +0200 (CEST)
Date:   Tue, 6 Jun 2023 21:37:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
Subject: Re: [PATCH V2 1/6] perf/x86/intel: Add Grand Ridge and Sierra Forest
Message-ID: <20230606193712.GY83892@hirez.programming.kicks-ass.net>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
 <2b2e7308-edeb-2977-596a-f638d19174d6@linux.intel.com>
 <20230606132432.GD905437@hirez.programming.kicks-ass.net>
 <3c187521-0686-1204-7b3e-e8f183c50938@linux.intel.com>
 <20230606181757.GB942082@hirez.programming.kicks-ass.net>
 <ea1c56f9-fc93-ff1e-2102-757e7e9c0dd7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea1c56f9-fc93-ff1e-2102-757e7e9c0dd7@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 02:34:47PM -0400, Liang, Kan wrote:
> 
> 
> On 2023-06-06 2:17 p.m., Peter Zijlstra wrote:
> > On Tue, Jun 06, 2023 at 12:16:29PM -0400, Liang, Kan wrote:
> > 
> >>> names for a reason, so that enums like the above become something
> >>> sensible like:
> >>>
> >>> 	case INTEL_FAM6_ATOM_CRESTMONT:
> >>> 	case INTEL_FAM6_ATOM_CRESTMONT_X:
> >>>
> >>> and now it's super obvious why they're grouped.
> >>>
> >>>>> +		pr_cont("Crestmont events, ");
> >>
> >> The Sierra Forest should not be a platform name. I think it's the code
> >> name of the processor.
> >>
> >> The problem is that the uarch name doesn't work for the hybrid, since it
> >> has different uarchs in the same processors. To make the naming rules
> >> consistent among big core, atom, and hybrid, maybe we should use the
> >> code name of the processor in intel-family.h.
> > 
> > I obviously disagree; these are not hybrid and calling them both
> > CRESTMONT makes *far* more sense than the random gibberish they're
> > called now.
> > 
> > Yes, hybrid made a complete mess of things (in many ways), but we should
> > then not do the obvious correct thing for when we can.
> 
> Besides hybrid, it seems there is a bigger problem for the big core.
> 
> The big core uses the processor code name since Ice Lake. In the perf
> code, we also uses the processor code name for the big core.
> 	pr_cont("Icelake events, ");

Yeah, it's a mess :/ Ideally that would print "Sunny Cove", but I think
there's userspace looking at that string :-(

> Is it OK to leave the big core as is (using processor code name), but
> only change the name for Grand Ridge and Sierra Forest?

Arguably we should also rename ALDERLAKE_N to ATOM_GRACEMONT


We should also do something about that whole hybrid init thing, the
meteorlake stuff is quite a mess as well. Perhaps we can add hybrid_pmu
next to intel_pmu to have a better start in life for x86_pmu.

Anyway, we should really try not to make a bigger mess and try and clean
up where we can.
