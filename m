Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009C168A380
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 21:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjBCUVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 15:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjBCUVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 15:21:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C896CC87
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 12:21:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA4FA61FD7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 20:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A583C433EF;
        Fri,  3 Feb 2023 20:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675455678;
        bh=N9Xbn9PzD7cYT5fDs4orjGGYk+en+jZzPYenjfDaMV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HxgUEObvm1koEPhYIJoSJAxyqhVRTdZGxn4Ezmqfr4Z+TcqmTkPKxsCaXrRNzegui
         333AA2/Bquct5o2VYiXkK+kzgd5K6cQth/nnOBlIKFK48oXiQ+gDwunFVcx9PlftET
         nW/KFaphv8I0jrLAaQg74nnnklpJsfo1PX1XDtDj9bl2RDMCVs2Ii2UJD9EYpm5KgE
         f//lrb6nJdJGhgSbRrPNzCvI4OGsbCp54EflqrrwONrF/RmNH3XQXFnE+uJ2PjYP9t
         rBHVmrAIs+fy6r90NHiQzLw/Qh4K5FzEWASZraByX5L7UypJodcXoQjiLZbim0gJCU
         K/y7C+F7HHK5A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0FB6E405BE; Fri,  3 Feb 2023 17:21:15 -0300 (-03)
Date:   Fri, 3 Feb 2023 17:21:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com, irogers@google.com
Subject: Re: [PATCH V2 7/9] perf/x86/msr: Add Meteor Lake support
Message-ID: <Y91su757r43jgdle@kernel.org>
References: <20230104201349.1451191-1-kan.liang@linux.intel.com>
 <20230104201349.1451191-7-kan.liang@linux.intel.com>
 <Y9sWImm4v5I/MZId@kernel.org>
 <79807730-73ac-c8c2-fc9d-b7cd00f9336e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79807730-73ac-c8c2-fc9d-b7cd00f9336e@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 02, 2023 at 09:34:02AM -0500, Liang, Kan escreveu:
> Hi Arnaldo,
> 
> On 2023-02-01 8:47 p.m., Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jan 04, 2023 at 12:13:47PM -0800, kan.liang@linux.intel.com escreveu:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> Meteor Lake is Intel's successor to Raptor lake. PPERF and SMI_COUNT MSRs
> >> are also supported.
> >>
> >> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> ---
> > 
> > Did the kernel bits land upstream?
> Yes, the kernel part has been merged into the tip.git perf/core branch.
> 
> Thanks for checking the status. There are two perf tool patches in this
> series, which hasn't been merged. Should I resend them?

Lemme try cherry-picking just the tooling bits from this series.
 
> Thanks,
> Kan
> > 
> > - Arnaldo
> >  
> >> No change since V1
> >>
> >>  arch/x86/events/msr.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
> >> index ecced3a52668..074150d28fa8 100644
> >> --- a/arch/x86/events/msr.c
> >> +++ b/arch/x86/events/msr.c
> >> @@ -107,6 +107,8 @@ static bool test_intel(int idx, void *data)
> >>  	case INTEL_FAM6_RAPTORLAKE:
> >>  	case INTEL_FAM6_RAPTORLAKE_P:
> >>  	case INTEL_FAM6_RAPTORLAKE_S:
> >> +	case INTEL_FAM6_METEORLAKE:
> >> +	case INTEL_FAM6_METEORLAKE_L:
> >>  		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
> >>  			return true;
> >>  		break;
> >> -- 
> >> 2.35.1
> > 

-- 

- Arnaldo
