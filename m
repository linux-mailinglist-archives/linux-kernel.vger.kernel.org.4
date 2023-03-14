Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA4D6B91F2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjCNLn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjCNLnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:43:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9059D1ADFE;
        Tue, 14 Mar 2023 04:43:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07F76B818EC;
        Tue, 14 Mar 2023 11:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51721C433EF;
        Tue, 14 Mar 2023 11:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678794206;
        bh=fh4T9o17yqeNyzBSU5vNYD7dkqNGit6AZtuJtTEr5zA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TzC8us9Tml4/R5yfSNJTKi4HR9zq7muh0abBYlnRd7Jxblw6iDxrUv6/fNFsCZMsq
         rFXUw3RwdkXnOt2QUuw89aWNMX6bW9o4q4bzUkVe3uzrIz3kG+qFBl9b6xJQAfXiEP
         IIjND2Znsgyf6BNSQoYpV8yDP846A0wmJH23tb+JPdow+g9wC7hmA9fYpXVMi8bpsN
         KlOkphKGygqjWO2mzK2K1v1iGnPty1nbfvXc4+Z2V1ZICGmFVhzgZMQQLv+tX3M/l9
         ROIxYymKto3Z7de7x4vDFtNedJpGtjaHyIFWb553wW8RLG67YzTmKlnrKI+r3vijR2
         ewM56q3znmZsQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2FB344049F; Tue, 14 Mar 2023 08:43:24 -0300 (-03)
Date:   Tue, 14 Mar 2023 08:43:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.g.garry@oracle.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test: Fix "PMU event table sanity" for
 NO_JEVENTS=1
Message-ID: <ZBBd3GI26KCCwEOM@kernel.org>
References: <20230308002714.1755698-1-irogers@google.com>
 <eae0bd08-b18b-a9e2-ebc6-04c94534dfc3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eae0bd08-b18b-a9e2-ebc6-04c94534dfc3@oracle.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 08, 2023 at 09:58:16AM +0000, John Garry escreveu:
> On 08/03/2023 00:27, Ian Rogers wrote:
> > A table was renamed and needed to be renamed in the empty case.
> > 
> > Fixes: 62774db2a05d ("perf jevents: Generate metrics and events as separate tables")
> 
> This looks ok, so:
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Thanks, applied.

- Arnaldo

 
> But a comment, below.
> 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/pmu-events/empty-pmu-events.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
> > index a938b74cf487..e74defb5284f 100644
> > --- a/tools/perf/pmu-events/empty-pmu-events.c
> > +++ b/tools/perf/pmu-events/empty-pmu-events.c
> > @@ -227,7 +227,7 @@ static const struct pmu_events_map pmu_events_map[] = {
> >   	},
> >   };
> > -static const struct pmu_event pme_test_soc_sys[] = {
> > +static const struct pmu_event pmu_events__test_soc_sys[] = {
> 
> Would it make sense or even possible to put these table names in macros in a
> common header?
> 
> Thanks,
> John
> 
> >   	{
> >   		.name = "sys_ddr_pmu.write_cycles",
> >   		.event = "event=0x2b",
> > @@ -258,8 +258,8 @@ struct pmu_sys_events {
> >   static const struct pmu_sys_events pmu_sys_event_tables[] = {
> >   	{
> > -		.table = { pme_test_soc_sys },
> > -		.name = "pme_test_soc_sys",
> > +		.table = { pmu_events__test_soc_sys },
> > +		.name = "pmu_events__test_soc_sys",
> >   	},
> >   	{
> >   		.table = { 0 }
> 

-- 

- Arnaldo
