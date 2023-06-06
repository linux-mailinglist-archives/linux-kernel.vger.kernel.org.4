Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94889724452
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237794AbjFFNZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbjFFNYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:24:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A70E78
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pGB2OELV1ZI3aHQVgPnKWDCXY7pLRJeg/VyzarCb7XE=; b=DfcmeHIHYCxYc5LRY3vVsvRZgl
        wexYQWe2itHyp2c0lSJXToCIACgwoJMav90lsgZBpiXv9WeziZsXGIYZ4HR4JMVKEPAL7W+tCWvXc
        Gp2mdzPrIx/5HlLWtlhK2KkZ1c2eK2KbzyUytEioEm3K1aH3Z5VhN7NklxTxWlg3HDQ0lgiSJTUaX
        i9SkbIaVguI9BhxUaegrU0KrY90jG12WE2KLlfQ9RZPiUNpM5jaTseGGVH3euzgr7lWOewmKw8jrA
        j4mDOKTLKcWg0ICDzoYBhVFvNQMPPNOA/qyjz9XY3fldFW/Cq6fZCWtjhJ487vZ9ihOG9j3AMXqwa
        6p3SA+vQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6Wfq-00DBFl-1u; Tue, 06 Jun 2023 13:24:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2BA35300129;
        Tue,  6 Jun 2023 15:24:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D150205EA3E1; Tue,  6 Jun 2023 15:24:33 +0200 (CEST)
Date:   Tue, 6 Jun 2023 15:24:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
Subject: Re: [PATCH V2 1/6] perf/x86/intel: Add Grand Ridge and Sierra Forest
Message-ID: <20230606132432.GD905437@hirez.programming.kicks-ass.net>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
 <2b2e7308-edeb-2977-596a-f638d19174d6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b2e7308-edeb-2977-596a-f638d19174d6@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:42:42AM -0400, Liang, Kan wrote:
> Hi Peter,
> 
> On 2023-05-22 7:30 a.m., kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > The Grand Ridge and Sierra Forest are successors to Snow Ridge. They
> > both have Crestmont core. From the core PMU's perspective, they are
> > similar to the e-core of MTL. The only difference is the LBR event
> > logging feature, which will be implemented in the following patches.
> > 
> > Create a non-hybrid PMU setup for Grand Ridge and Sierra Forest.
> > 
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > ---
> > 
> 
> 
> Gentle ping.
> 
> Do you have any comments for the patch set?
> 
> The patch set based on the perf/core branch which doesn't
> include the latest fix, 90befef5a9e8 ("perf/x86: Fix missing sample size
> update on AMD BRS").
> https://lore.kernel.org/lkml/2f09023a-cccb-35df-da0a-d245ee5238be@linux.intel.com/
> 
> Should I rebase it on the perf/urgent and send the V3?
> 

I can pull urgent into perf/core, but:

> > +	case INTEL_FAM6_GRANDRIDGE:
> > +	case INTEL_FAM6_SIERRAFOREST_X:
                        ^^^^^^^^^^^^^^^

Those are just plain wrong; please fix up the intel-family.h thing like
suggested earlier in this thread.

And Tony, please no more of that platform name nonsense.. we want uarch
names for a reason, so that enums like the above become something
sensible like:

	case INTEL_FAM6_ATOM_CRESTMONT:
	case INTEL_FAM6_ATOM_CRESTMONT_X:

and now it's super obvious why they're grouped.

> > +		pr_cont("Crestmont events, ");
