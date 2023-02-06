Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C68868C13B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjBFPX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFPX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:23:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0B529433
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:23:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5080B811E3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 15:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B742C433D2;
        Mon,  6 Feb 2023 15:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675697002;
        bh=SXUIbkPKg2oCscidIoD2sCliOmiMP6DyAuhQtTYGJEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rrlo+7GXLMuSVzBbtyXgNwx4BtHCCaGaCjLdqkQ69MYVg+0mGSy9WqjezmchE08Xt
         v/Vc/skNKC31ylw83EGAbMLLDxr8PeTBGNoH3CTa1JOHfUvqnMTpKX6DDqflzp82NE
         kHkgd5HA3+Ua5tbpDjX5nmVXViU66tOgwVjgqOvTUEavklE9evJ+ioCiYpm2mNBvBL
         2UkTtjilpqtXrPfB9Ho75T4zDlrNF/TshartEDOsQNgzkEWVKAHQK87Y+V5UbnXz8J
         b4HhoWsfnLxbN5vvRUcrtSraFOARL6hP7N8kKG7VW21p/B/LBCfNNLecy2vMHf11K3
         TFMCOJoN3xtFw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A8F2E405BE; Mon,  6 Feb 2023 12:23:19 -0300 (-03)
Date:   Mon, 6 Feb 2023 12:23:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com, irogers@google.com
Subject: Re: [PATCH V3 3/3] perf test: Support the retire_lat check
Message-ID: <Y+EbZ8FFWj6t60Cb@kernel.org>
References: <20230202192209.1795329-1-kan.liang@linux.intel.com>
 <20230202192209.1795329-3-kan.liang@linux.intel.com>
 <Y+EWWLaBj1OPrkLo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+EWWLaBj1OPrkLo@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 06, 2023 at 12:01:44PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Feb 02, 2023 at 11:22:09AM -0800, kan.liang@linux.intel.com escreveu:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > Add test for the new field for Retire Latency in the X86 specific test.
> 
> Is this passing 'perf test' for you?
> 
> [root@quaco ~]# perf test -v "x86 sample parsing"
>  74: x86 Sample parsing                                              :
> --- start ---
> test child forked, pid 72526
> Samples differ at 'retire_lat'
> parsing failed for sample_type 0x1000000
> test child finished with -1
> ---- end ----
> x86 Sample parsing: FAILED!
> [root@quaco ~]#

In tools/perf/arch/x86/util/event.c  you have:

void arch_perf_parse_sample_weight(struct perf_sample *data,
                                   const __u64 *array, u64 type)
{
        union perf_sample_weight weight;

        weight.full = *array;
        if (type & PERF_SAMPLE_WEIGHT)
                data->weight = weight.full;
        else {
                data->weight = weight.var1_dw;
                data->ins_lat = weight.var2_w;
                data->retire_lat = weight.var3_w;
        }
}

void arch_perf_synthesize_sample_weight(const struct perf_sample *data,
                                        __u64 *array, u64 type)
{
        *array = data->weight;

        if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
                *array &= 0xffffffff;
                *array |= ((u64)data->ins_lat << 32);
        }
}

didn't you forget to encode data->retire_lat at
arch_perf_synthesize_sample_weight()?

- Arnaldo

> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > ---
> > 
> > New patch since V2
> > 
> >  tools/perf/arch/x86/tests/sample-parsing.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/arch/x86/tests/sample-parsing.c b/tools/perf/arch/x86/tests/sample-parsing.c
> > index 690c7c07e90d..a061e8619267 100644
> > --- a/tools/perf/arch/x86/tests/sample-parsing.c
> > +++ b/tools/perf/arch/x86/tests/sample-parsing.c
> > @@ -27,8 +27,10 @@ static bool samples_same(const struct perf_sample *s1,
> >  			 const struct perf_sample *s2,
> >  			 u64 type)
> >  {
> > -	if (type & PERF_SAMPLE_WEIGHT_STRUCT)
> > +	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
> >  		COMP(ins_lat);
> > +		COMP(retire_lat);
> > +	}
> >  
> >  	return true;
> >  }
> > @@ -48,6 +50,7 @@ static int do_test(u64 sample_type)
> >  	struct perf_sample sample = {
> >  		.weight		= 101,
> >  		.ins_lat        = 102,
> > +		.retire_lat     = 103,
> >  	};
> >  	struct perf_sample sample_out;
> >  	size_t i, sz, bufsz;
> > -- 
> > 2.35.1
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
