Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201556D6C79
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjDDSlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjDDSln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:41:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2695C1A5;
        Tue,  4 Apr 2023 11:41:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 942BC637BE;
        Tue,  4 Apr 2023 18:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BD1C433D2;
        Tue,  4 Apr 2023 18:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680633701;
        bh=7luwlHtlnPj1uap2yRPChFSIZj7fVyDCho++E+4oG/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FJbade/wyfQPHX7+dG09Nr7o4cK+NNKZTwXF0rGdPJnNiiDj+hnhJN/6Zio11mcIF
         euzqd8Z6WnfVOA57HVz4q8Avii+2uRIdGFrFNM10Qx0BCcdpu4bm0DwEfru8fa8RW5
         LfLjRjgXwzcR4QCB00YQupUgmg/dL0H2ONlz+dsPJJ+h9tLG/S4VnfnBysEe9Dtzq8
         wcqPJa4fJBVsu3GlQ8VXULP8PMtMVLZnKqFFtvmdxG2OWiHGYNNNOExNj821J2dt9C
         y7JEZtHdgGW7CXhC0bNcGi7d0o+yCWQHGG+M+ea58dBmzRXEvp8YKJ+kS9FoEQDR8r
         TWMAjG3LlQjJw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5333A4052D; Tue,  4 Apr 2023 15:41:38 -0300 (-03)
Date:   Tue, 4 Apr 2023 15:41:38 -0300
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
Message-ID: <ZCxvYpeoemPHUmJ4@kernel.org>
References: <20230320212248.1175731-1-irogers@google.com>
 <CAP-5=fX4=pUmcFpRZ5xFds1awSr7HSo1F9rH4=D7NJXW9OXXVQ@mail.gmail.com>
 <7443d427-783b-44b6-85e6-5e667bb83a94@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7443d427-783b-44b6-85e6-5e667bb83a94@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 04, 2023 at 08:25:41PM +0300, Adrian Hunter escreveu:
> On 4/04/23 18:58, Ian Rogers wrote:
> > Ping. It would be nice to have this landed or at least the first 10
> > patches that refactor the map API and are the bulk of the
> > lines-of-code changed. Having those landed would make it easier to
> > rebase in the future, but I also think the whole series is ready to
> > go.
> 
> I was wondering if the handling of dynamic data like struct map makes
> any sense at present.  Perhaps someone can reassure me.
> 
> A struct map can be updated when an MMAP event is processed.  So it

Yes, it can, and the update is made via a new PERF_RECORD_MMAP, right?

So:

	perf_event__process_mmap()
	  machine__process_mmap2_event()
	    map__new() + thread__insert_map(thread, map)
	    	maps__fixup_overlappings()
			maps__insert(thread->maps, map);

Ok, from this point on new samples on ] map->start .. map->end ] will
grab a refcount to this new map in its hist_entry, right?

When we want to sort by dso we will look at hist_entry->map->dso, etc.

> seems like anything racing with event processing is already broken, and
> reference counting / locking cannot help - unless there is also
> copy-on-write (which there isn't at present)?

> For struct maps, referencing it while simultaneously processing
> events seems to make even less sense?

Can you elaborate some more?

- Arnaldo
