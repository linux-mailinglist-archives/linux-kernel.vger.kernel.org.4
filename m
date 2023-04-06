Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3826D9755
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 14:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbjDFMwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 08:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbjDFMwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:52:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BFD7ED3;
        Thu,  6 Apr 2023 05:52:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9C2464787;
        Thu,  6 Apr 2023 12:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88E9C433EF;
        Thu,  6 Apr 2023 12:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680785522;
        bh=ixYWjGc0xtNsYuWm+X2+VXF5qJytiSRZtYoQruwRDTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O1lUQWLjwNExM1vKk/1+ubgwdw0ANhzUyl/Z3ccLCZ4ZvXI8wXKxXC5Cm91B8BM1P
         qDqdiW4Emy62t9f7L21qk3HDnattMb1BJ3CoOeANOPTQlZ6iW7t9WaV8SeLh6ERX+1
         7DfJOYxPPXE3DcFmBk3G8R8uCMAlUZ0SJ6NvqWVoXRoySzeE3XNp8qH8RANhI13ZTE
         pBB3c1N5/C+G5QU9lnhaTdLHOcdOxQxf+XxZ1Hv+4wpvI81k1zke5Pz/6V9D0mNs+K
         jGspEpZFgLJJAwjE/jQS9a2cpsLkjfhS+px5JhZzvPdLLAdAsw8K8RZvTxO2+QGV6n
         gYxK0Y3GVJIaQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4AFCA4052D; Thu,  6 Apr 2023 09:51:58 -0300 (-03)
Date:   Thu, 6 Apr 2023 09:51:58 -0300
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
Message-ID: <ZC7AbtD4E6zWWlUn@kernel.org>
References: <20230320212248.1175731-1-irogers@google.com>
 <CAP-5=fX4=pUmcFpRZ5xFds1awSr7HSo1F9rH4=D7NJXW9OXXVQ@mail.gmail.com>
 <7443d427-783b-44b6-85e6-5e667bb83a94@intel.com>
 <ZCxvYpeoemPHUmJ4@kernel.org>
 <ZCxyZcnd9/4zjbQZ@kernel.org>
 <527b8bcb-d462-5fff-5310-703b55902a61@intel.com>
 <ZC11tTdXuJR/M8o+@kernel.org>
 <2aaba740-35e4-4a68-2676-63d47898378c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aaba740-35e4-4a68-2676-63d47898378c@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 05, 2023 at 07:25:27PM +0300, Adrian Hunter escreveu:
> On 5/04/23 16:20, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Apr 05, 2023 at 11:47:26AM +0300, Adrian Hunter escreveu:
> >> On 4/04/23 21:54, Arnaldo Carvalho de Melo wrote:
> >>> Em Tue, Apr 04, 2023 at 03:41:38PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>>> Em Tue, Apr 04, 2023 at 08:25:41PM +0300, Adrian Hunter escreveu:
> >>>>> I was wondering if the handling of dynamic data like struct map makes
> >>>>> any sense at present.  Perhaps someone can reassure me.

> >>>>> A struct map can be updated when an MMAP event is processed.  So it

> >>>> Yes, it can, and the update is made via a new PERF_RECORD_MMAP, right?

> >>>> So:

> >>>> 	perf_event__process_mmap()
> >>>> 	  machine__process_mmap2_event()
> >>>> 	    map__new() + thread__insert_map(thread, map)
> >>>> 	    	maps__fixup_overlappings()
> >>>> 			maps__insert(thread->maps, map);

> >>>> Ok, from this point on new samples on ] map->start .. map->end ] will
> >>>> grab a refcount to this new map in its hist_entry, right?

> >>>> When we want to sort by dso we will look at hist_entry->map->dso, etc.

> >>> And in 'perf top' we go decaying hist entries, when we delete the
> >>> hist_entry, drop the reference count to things it holds, that will then
> >>> be finally deleted when no more hist_entries point to it.

> >>>>> seems like anything racing with event processing is already broken, and
> >>>>> reference counting / locking cannot help - unless there is also
> >>>>> copy-on-write (which there isn't at present)?
> >  
> >> So I checked, and struct map *is* copy-on-write in
> >> maps__fixup_overlappings(), so that should not be a problem.
> >  
> >>>>> For struct maps, referencing it while simultaneously processing
> >>>>> events seems to make even less sense?
> > 
> >>>> Can you elaborate some more?
> >  
> >> Only that the maps are not necessarily stable e.g. the map that you
> >> need has been replaced in the meantime.
> > 
> > Well, it may be sliced in several or shrunk by new ones overlapping it,
> > but it if completely disappears, say a new map starts before the one
> > disappearing and ends after it, then it remains with reference counts if
> > there are hist_entries (or other data structure) pointing to them,
> > right?

> >> But upon investigation, the only user at the moment is
> >> maps__find_ams().  If we kept the removed maps (we used to),
> >> it might be possible to make maps__find_ams() work correctly
> >> in any case.

> > Humm, I think I see what you mean, maps__find_ams() is called when we
> > are annotating a symbol, not when we're processing a sample, so it may
> > be the case that at the time of annotation the executable that is being
> > found (its parsing the target IP of a 'call' assembly instruction) was
> > replaced, is that the case?
 
> Yes, that is the possibility

Yeah, this one gets a bit more difficult to support, we would have to
keep a sub-bucket for each annotation instruction with the ordered by
timestamp list of maps that were on that location (but then just to
places that had samples, not to all) and then when add some visual cue
to that annotation line to mean that it was patched and show the
original, then the (possibly) various patches and say that samples up to
N units of time were for some original DSO, then to another (overlapping
executable map), then to some patching (that we would catch with
PERF_RECORD_TEXT_POKE for the kernel, right?), etc.

Seems doable, and for most cases would be similar to what we have right
now, as self-modifying code its not so pervasive (famous last words
;-)).

- Arnaldo
