Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2842D68C229
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBFPtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjBFPs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:48:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60692BEFE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:48:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B33B2B811E4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 15:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462F8C433D2;
        Mon,  6 Feb 2023 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675697653;
        bh=ouiqjuAu5PppAdsMop/lufIECtbBFr60ZbcXqtDW4RU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mrwcGMXZZYUl6mIJTQy9X6DNxj/zEowAYFFRX1wB++FuFCj6sVB0k1DrnAT4ttFcv
         Kya8cP2rARWqjwtRsYkCtKMCPylyfyL4Xgxlbgb6bNOTorhamgk7Bv/PNB9AzNjP4s
         NvUlVGlRPb8xXQkFo6Z9jxNMTWuZ5q2YDNsmdVLx4ZqXceMg1XS2/gZ+eHwWS+O+H4
         qp4VPSwaQRPxrBMc+CMIN1AQS61uF/iiDEjfurtw/Ec2DetK4O6myaRGW1mG+MiUPN
         uryFK3RpQ7M2lF4qx7sh+xSGBEZmPnoTlDmmqlWKbY6v7RLuVxeryYHu/6QgBWEoJN
         o7mKSTqwEeU8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D4FD5405BE; Mon,  6 Feb 2023 12:34:07 -0300 (-03)
Date:   Mon, 6 Feb 2023 12:34:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com, irogers@google.com
Subject: Re: [PATCH V3 3/3] perf test: Support the retire_lat check
Message-ID: <Y+Ed7823ZSXevwA6@kernel.org>
References: <20230202192209.1795329-1-kan.liang@linux.intel.com>
 <20230202192209.1795329-3-kan.liang@linux.intel.com>
 <Y+EWWLaBj1OPrkLo@kernel.org>
 <8e493d2f-827a-03d9-610b-6246502bf92a@linux.intel.com>
 <Y+EdposucD4mWp6S@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+EdposucD4mWp6S@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 06, 2023 at 12:32:54PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Feb 06, 2023 at 10:17:46AM -0500, Liang, Kan escreveu:
> > 
> > 
> > On 2023-02-06 10:01 a.m., Arnaldo Carvalho de Melo wrote:
> > > Em Thu, Feb 02, 2023 at 11:22:09AM -0800, kan.liang@linux.intel.com escreveu:
> > >> From: Kan Liang <kan.liang@linux.intel.com>
> > >>
> > >> Add test for the new field for Retire Latency in the X86 specific test.
> > > 
> > > Is this passing 'perf test' for you?
> > 
> > Ah, it should be the original V2 missed the below change.
> 
> Can you please send this as a separate patch as I already merged
> torvalds/master and added more csets on top, so to just fix it and
> force push now would be bad.
> 
> Please use what is in my perf/core branch and add a Fixes for that v2
> patch.

BTW, the 3rd patch with the test is already on the tmp.perf/core branch,
that will move to perf/core after the next round of container build
tests.

- Arnaldo
 
> Thanks,
> 
> - Arnaldo
>  
> > @@ -100,5 +101,25 @@ void arch_perf_synthesize_sample_weight(const
> > struct perf_sample *data,
> >  	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
> >  		*array &= 0xffffffff;
> >  		*array |= ((u64)data->ins_lat << 32);
> > +		*array |= ((u64)data->retire_lat << 48);
> >  	}
> >  }
> > 
> > Could you please remove the V2 and re-apply the V3?
>  
> > $ sudo ./perf test -v "x86 sample parsing"
> >  74: x86 Sample parsing                                              :
> > --- start ---
> > test child forked, pid 3316797
> > test child finished with 0
> > ---- end ----
> > x86 Sample parsing: Ok
> > 
> > 
> > Thanks,
> > Kan
> > 
> > > 
> > > [root@quaco ~]# perf test -v "x86 sample parsing"
> > >  74: x86 Sample parsing                                              :
> > > --- start ---
> > > test child forked, pid 72526
> > > Samples differ at 'retire_lat'
> > > parsing failed for sample_type 0x1000000
> > > test child finished with -1
> > > ---- end ----
> > > x86 Sample parsing: FAILED!
> > > [root@quaco ~]#
> > > 
> > > - Arnaldo
> > >  
> > >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > >> ---
> > >>
> > >> New patch since V2
> > >>
> > >>  tools/perf/arch/x86/tests/sample-parsing.c | 5 ++++-
> > >>  1 file changed, 4 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/tools/perf/arch/x86/tests/sample-parsing.c b/tools/perf/arch/x86/tests/sample-parsing.c
> > >> index 690c7c07e90d..a061e8619267 100644
> > >> --- a/tools/perf/arch/x86/tests/sample-parsing.c
> > >> +++ b/tools/perf/arch/x86/tests/sample-parsing.c
> > >> @@ -27,8 +27,10 @@ static bool samples_same(const struct perf_sample *s1,
> > >>  			 const struct perf_sample *s2,
> > >>  			 u64 type)
> > >>  {
> > >> -	if (type & PERF_SAMPLE_WEIGHT_STRUCT)
> > >> +	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
> > >>  		COMP(ins_lat);
> > >> +		COMP(retire_lat);
> > >> +	}
> > >>  
> > >>  	return true;
> > >>  }
> > >> @@ -48,6 +50,7 @@ static int do_test(u64 sample_type)
> > >>  	struct perf_sample sample = {
> > >>  		.weight		= 101,
> > >>  		.ins_lat        = 102,
> > >> +		.retire_lat     = 103,
> > >>  	};
> > >>  	struct perf_sample sample_out;
> > >>  	size_t i, sz, bufsz;
> > >> -- 
> > >> 2.35.1
> > >>
> > > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
