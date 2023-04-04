Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31536D6CAD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbjDDSyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbjDDSye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:54:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFD3170F;
        Tue,  4 Apr 2023 11:54:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1441363845;
        Tue,  4 Apr 2023 18:54:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B78BC433EF;
        Tue,  4 Apr 2023 18:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680634472;
        bh=2JKZvifvZo0iG/71MaLcykWMpX1Lo94xFJ1Wx7m52is=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LaGRNGMwDPas+wlQ1CR8kS2KjdEfpD/cSbkPlqyDEr4PjyVriLIwZM/Iz/mF4/ah4
         Jb5jl+oeSFEtJDUI692YwC7tBXkiqYPWjsrVdAwq/PuuxOKXFNW/EJEylL1b2slpoX
         p2mnLUyc9+2ulXNrbnptcFdCY7/VZ0m31JPuBqOcFumHO/KDpA12mvXKmrWdzwozz4
         jjS2iIrD5Nk935172fOZYNbK/YpOFpvr52XL7jsHXaQljPSwKNMZnWCMBcgiMtnsrj
         omdESzIq2PciJ3Rd/RF77zhaK2A60Dm2OqndTrNtIbA+OM7B+sNWj8n7sxyIGRT+Nv
         0jO1s2R7W2kRw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EFAD84052D; Tue,  4 Apr 2023 15:54:29 -0300 (-03)
Date:   Tue, 4 Apr 2023 15:54:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v5 00/17] Reference count checker and related fixes
Message-ID: <ZCxyZcnd9/4zjbQZ@kernel.org>
References: <20230320212248.1175731-1-irogers@google.com>
 <CAP-5=fX4=pUmcFpRZ5xFds1awSr7HSo1F9rH4=D7NJXW9OXXVQ@mail.gmail.com>
 <7443d427-783b-44b6-85e6-5e667bb83a94@intel.com>
 <ZCxvYpeoemPHUmJ4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCxvYpeoemPHUmJ4@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 04, 2023 at 03:41:38PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Apr 04, 2023 at 08:25:41PM +0300, Adrian Hunter escreveu:
> > On 4/04/23 18:58, Ian Rogers wrote:
> > > Ping. It would be nice to have this landed or at least the first 10
> > > patches that refactor the map API and are the bulk of the
> > > lines-of-code changed. Having those landed would make it easier to
> > > rebase in the future, but I also think the whole series is ready to
> > > go.
> > 
> > I was wondering if the handling of dynamic data like struct map makes
> > any sense at present.  Perhaps someone can reassure me.
> > 
> > A struct map can be updated when an MMAP event is processed.  So it
> 
> Yes, it can, and the update is made via a new PERF_RECORD_MMAP, right?
> 
> So:
> 
> 	perf_event__process_mmap()
> 	  machine__process_mmap2_event()
> 	    map__new() + thread__insert_map(thread, map)
> 	    	maps__fixup_overlappings()
> 			maps__insert(thread->maps, map);
> 
> Ok, from this point on new samples on ] map->start .. map->end ] will
> grab a refcount to this new map in its hist_entry, right?
> 
> When we want to sort by dso we will look at hist_entry->map->dso, etc.

And in 'perf top' we go decaying hist entries, when we delete the
hist_entry, drop the reference count to things it holds, that will then
be finally deleted when no more hist_entries point to it.

> > seems like anything racing with event processing is already broken, and
> > reference counting / locking cannot help - unless there is also
> > copy-on-write (which there isn't at present)?
> 
> > For struct maps, referencing it while simultaneously processing
> > events seems to make even less sense?
> 
> Can you elaborate some more?

- Arnaldo
