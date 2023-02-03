Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ADF68A388
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 21:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjBCU2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 15:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjBCU2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 15:28:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8844F125BD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 12:28:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67B58B82B8E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 20:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1449C433D2;
        Fri,  3 Feb 2023 20:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675456092;
        bh=jH0mfNTLonbjusZsctWSDRNA+5PQjyYsFOLOO66NM4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GrYDQGhoyuCAxe1nU06K7mIpFqXbfg+cgNFfTM/14TlTyi+BNUTpKLD1Vqu6dE3rb
         Wb95E8IR7nHYMQ687g50iwH6XeGskEepxkbZqaT67EL+yO35/di2t4iFNnx4PRu/JJ
         DK1y3BXYeOKtwFp1KIvvgAT6na08GJkDGT8IlXoXyX9NoflGRDkrULK/B5kNcyxT/e
         1epqLbdTzv++cHAiwKKElyZLbfrrqXi6tS7FHlIrFv9LU2OA8D6ijiGFiaphmGj3Ym
         zISU/sG8ZyVNwPYmPFe3PYW8x5GT9cNlpTeUJtzLDTIpYbJs1zG1nZwbyRvAvd3EKg
         r7hTIRe+U42DA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 436D6405BE; Fri,  3 Feb 2023 17:28:10 -0300 (-03)
Date:   Fri, 3 Feb 2023 17:28:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com, irogers@google.com
Subject: Re: [PATCH V2 7/9] perf/x86/msr: Add Meteor Lake support
Message-ID: <Y91uWj6PiGQqI48J@kernel.org>
References: <20230104201349.1451191-1-kan.liang@linux.intel.com>
 <20230104201349.1451191-7-kan.liang@linux.intel.com>
 <Y9sWImm4v5I/MZId@kernel.org>
 <79807730-73ac-c8c2-fc9d-b7cd00f9336e@linux.intel.com>
 <Y91su757r43jgdle@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y91su757r43jgdle@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 03, 2023 at 05:21:15PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Feb 02, 2023 at 09:34:02AM -0500, Liang, Kan escreveu:
> > Hi Arnaldo,
> > 
> > On 2023-02-01 8:47 p.m., Arnaldo Carvalho de Melo wrote:
> > > Em Wed, Jan 04, 2023 at 12:13:47PM -0800, kan.liang@linux.intel.com escreveu:
> > >> From: Kan Liang <kan.liang@linux.intel.com>
> > >>
> > >> Meteor Lake is Intel's successor to Raptor lake. PPERF and SMI_COUNT MSRs
> > >> are also supported.
> > >>
> > >> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > >> ---
> > > 
> > > Did the kernel bits land upstream?
> > Yes, the kernel part has been merged into the tip.git perf/core branch.
> > 
> > Thanks for checking the status. There are two perf tool patches in this
> > series, which hasn't been merged. Should I resend them?
> 
> Lemme try cherry-picking just the tooling bits from this series.

There was a clash with:

commit 3fd7a168bf51497909dbfb7347af28b5c57e74a6
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Thu Jan 26 13:36:10 2023 -0800

    perf script: Add 'cgroup' field for output

And a minor fuzz on the first patch, I applied manually and resolved the
conflict,

Thanks,

- Arnaldo
  
> > Thanks,
> > Kan
> > > 
> > > - Arnaldo
> > >  
> > >> No change since V1
> > >>
> > >>  arch/x86/events/msr.c | 2 ++
> > >>  1 file changed, 2 insertions(+)
> > >>
> > >> diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
> > >> index ecced3a52668..074150d28fa8 100644
> > >> --- a/arch/x86/events/msr.c
> > >> +++ b/arch/x86/events/msr.c
> > >> @@ -107,6 +107,8 @@ static bool test_intel(int idx, void *data)
> > >>  	case INTEL_FAM6_RAPTORLAKE:
> > >>  	case INTEL_FAM6_RAPTORLAKE_P:
> > >>  	case INTEL_FAM6_RAPTORLAKE_S:
> > >> +	case INTEL_FAM6_METEORLAKE:
> > >> +	case INTEL_FAM6_METEORLAKE_L:
> > >>  		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
> > >>  			return true;
> > >>  		break;
> > >> -- 
> > >> 2.35.1
> > > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
