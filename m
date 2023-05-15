Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08187703FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245244AbjEOVeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjEOVeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:34:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26E293E1;
        Mon, 15 May 2023 14:34:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E0D86322E;
        Mon, 15 May 2023 21:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0FFC433D2;
        Mon, 15 May 2023 21:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684186442;
        bh=j/8xMxku5oEjsZdQe0mIkKDuoV2R/gpOLnekK5py0Nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NzNrnnJKM/TLchtal/3FC5Ydr7w86THDebyjbLNlizmbBI31BlbHpqqd2UoeZ6ndU
         flgbBWwQMWPqVPsRaTXzXi0cblx4EpBl2QdeRfT3vph7hFRhWMd6m4kNRaMN/ge/oO
         6DdQjCWAsPSi/277TCzLecfDHgX7puIrz1lapyCqXBV3ygXMR/pPTl15loAhRR3SF9
         uUW8M7fcdDgmOGZA0skhKKbJNSg/JcChBW+JkVIkMVrjhEPrbLWPtoEURfyd52XJQ7
         FD01K7HGdj6uZq8YZ1ewVMf7uUCxfAW1oczXlKl7DlaOe0ZZ1nUF2YxZ/SAE/mFJNU
         AOi2cCbmMtDTQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2B90E403B5; Mon, 15 May 2023 18:34:00 -0300 (-03)
Date:   Mon, 15 May 2023 18:33:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>, namhyung@kernel.org,
        eranian@google.com, mark.rutland@arm.com, jolsa@kernel.org,
        irogers@google.com, bp@alien8.de, kan.liang@linux.intel.com,
        adrian.hunter@intel.com, maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v4 4/4] perf test: Add selftest to test IBS invocation
 via core pmu events
Message-ID: <ZGKlR+IKHcIVzQoZ@kernel.org>
References: <20230504110003.2548-1-ravi.bangoria@amd.com>
 <20230504110003.2548-5-ravi.bangoria@amd.com>
 <20230505091648.GC1770668@hirez.programming.kicks-ass.net>
 <ZGKkpq4ynrdH7ZeE@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGKkpq4ynrdH7ZeE@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 15, 2023 at 06:31:18PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, May 05, 2023 at 11:16:48AM +0200, Peter Zijlstra escreveu:
> > On Thu, May 04, 2023 at 04:30:03PM +0530, Ravi Bangoria wrote:
> > > IBS pmu can be invoked via fixed set of core pmu events with 'precise_ip'
> > > set to 1. Add a simple event open test for all these events.
> > >   AMD IBS via core pmu: Ok
> > > 
> > > Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > > ---
> > >  tools/perf/arch/x86/include/arch-tests.h      |  1 +
> > >  tools/perf/arch/x86/tests/Build               |  1 +
> > >  .../arch/x86/tests/amd-ibs-via-core-pmu.c     | 71 +++++++++++++++++++
> > >  tools/perf/arch/x86/tests/arch-tests.c        |  2 +
> > >  4 files changed, 75 insertions(+)
> > >  create mode 100644 tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
> > 
> > Arnaldo, ok if I merge this along with the other patches or would you
> > rather take it?
> 
> That would be ok, checking if you merged already...

Yeah, its in tip/master, great.

- Arnaldo
