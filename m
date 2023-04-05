Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE1E6D7DC5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238256AbjDENcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbjDENcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:32:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DCE30F3;
        Wed,  5 Apr 2023 06:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4B5263464;
        Wed,  5 Apr 2023 13:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F9BC433D2;
        Wed,  5 Apr 2023 13:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680701541;
        bh=8gpA/Rvh21p/iw/rCJ5Qr5AALGcAkWnFLISmc8zPn94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XQclYq7Too0Qb9D3cPbAgVw/b9smZym7wLH96xvlIeF1KZyKOhLPFLIAGQoFABhng
         qeSkfFZ8Mat2ZechaULNFcmS1r0jrDYzJGm7qrsgQaLX7fC4hQ1LdCS4DNplQReCyY
         ly4M7zPP7Prb6t2uoItH4SF//rhAtiOm3N6it8p3vCystVyM4FFCZiABz+mL0zeJaU
         yBvzJyO0MU4dTeD2C9u3/ZtB/md12t+OF+KyhCGuwOrIToyo1cnjkiKTnphmfPmSZi
         TOyG46p7wS/pygjF0vNmnkTSC9SOnR9oVhLTFsrgEzTBN/SFwMSyCmLqMUWgbO24Uk
         HR5LkuIeCgJOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DE2404052D; Wed,  5 Apr 2023 10:32:17 -0300 (-03)
Date:   Wed, 5 Apr 2023 10:32:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        Adrian Hunter <adrian.hunter@intel.com>,
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
Subject: Re: [PATCH v6 01/12] perf map: Rename map_ip and unmap_ip
Message-ID: <ZC14YdPV+Az3A7/G@kernel.org>
References: <20230404205954.2245628-1-irogers@google.com>
 <20230404205954.2245628-2-irogers@google.com>
 <ZC12sgYsbvF/C28z@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC12sgYsbvF/C28z@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 05, 2023 at 10:25:06AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Apr 04, 2023 at 01:59:43PM -0700, Ian Rogers escreveu:
> > Add dso to match comment. This avoids a naming conflict with later
> > added accessor functions for variables in struct map.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-kmem.c    | 2 +-
> >  tools/perf/builtin-script.c  | 4 ++--
> >  tools/perf/util/machine.c    | 4 ++--
> >  tools/perf/util/map.c        | 8 ++++----
> >  tools/perf/util/map.h        | 4 ++--
> >  tools/perf/util/symbol-elf.c | 4 ++--
> >  6 files changed, 13 insertions(+), 13 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> > index f3029742b800..4d4b770a401c 100644
> > --- a/tools/perf/builtin-kmem.c
> > +++ b/tools/perf/builtin-kmem.c
> > @@ -423,7 +423,7 @@ static u64 find_callsite(struct evsel *evsel, struct perf_sample *sample)
> >  		if (!caller) {
> >  			/* found */
> >  			if (node->ms.map)
> > -				addr = map__unmap_ip(node->ms.map, node->ip);
> > +				addr = map__dso_unmap_ip(node->ms.map, node->ip);
> 
> As we chatted, I think this is a good opportunity to make this more
> clear, perhaps rename map__unmap_ip() to map__addr_offset_to_virt() and
> map__map_ip() to map__addr_virt_to_offset()?

Maybe prefix both with __, i.e. __map__addr_offset_to_virt() and __map__addr_virt_to_offset(), since
then you need to wrap map->unmap_ip() to
map__map__addr_offset_to_virt(), that in some cases will map to
__map__addr_offset_to_virt(), modulo in identity maps, like with the
kernel where we use identify__map_ip().

- Arnaldo
 
> - Arnaldo
> 
> >  			else
> >  				addr = node->ip;
> >  
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 1d078106abc4..af0a69c7f41f 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -1012,11 +1012,11 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
> >  
> >  		if (thread__find_map_fb(thread, sample->cpumode, from, &alf) &&
> >  		    !map__dso(alf.map)->adjust_symbols)
> > -			from = map__map_ip(alf.map, from);
> > +			from = map__dso_map_ip(alf.map, from);
> >  
> >  		if (thread__find_map_fb(thread, sample->cpumode, to, &alt) &&
> >  		    !map__dso(alt.map)->adjust_symbols)
> > -			to = map__map_ip(alt.map, to);
> > +			to = map__dso_map_ip(alt.map, to);
> >  
> >  		printed += fprintf(fp, " 0x%"PRIx64, from);
> >  		if (PRINT_FIELD(DSO)) {
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 7852b97da10a..9d24980a0a93 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -3058,7 +3058,7 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
> >  	if (!symbol_conf.inline_name || !map || !sym)
> >  		return ret;
> >  
> > -	addr = map__map_ip(map, ip);
> > +	addr = map__dso_map_ip(map, ip);
> >  	addr = map__rip_2objdump(map, addr);
> >  	dso = map__dso(map);
> >  
> > @@ -3103,7 +3103,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
> >  	 * its corresponding binary.
> >  	 */
> >  	if (entry->ms.map)
> > -		addr = map__map_ip(entry->ms.map, entry->ip);
> > +		addr = map__dso_map_ip(entry->ms.map, entry->ip);
> >  
> >  	srcline = callchain_srcline(&entry->ms, addr);
> >  	return callchain_cursor_append(cursor, entry->ip, &entry->ms,
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index 416fc449bde8..d97a6d20626f 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -109,8 +109,8 @@ void map__init(struct map *map, u64 start, u64 end, u64 pgoff, struct dso *dso)
> >  	map->pgoff    = pgoff;
> >  	map->reloc    = 0;
> >  	map->dso      = dso__get(dso);
> > -	map->map_ip   = map__map_ip;
> > -	map->unmap_ip = map__unmap_ip;
> > +	map->map_ip   = map__dso_map_ip;
> > +	map->unmap_ip = map__dso_unmap_ip;
> >  	map->erange_warned = false;
> >  	refcount_set(&map->refcnt, 1);
> >  }
> > @@ -590,12 +590,12 @@ struct maps *map__kmaps(struct map *map)
> >  	return kmap->kmaps;
> >  }
> >  
> > -u64 map__map_ip(const struct map *map, u64 ip)
> > +u64 map__dso_map_ip(const struct map *map, u64 ip)
> >  {
> >  	return ip - map__start(map) + map->pgoff;
> >  }
> >  
> > -u64 map__unmap_ip(const struct map *map, u64 ip)
> > +u64 map__dso_unmap_ip(const struct map *map, u64 ip)
> >  {
> >  	return ip + map__start(map) - map->pgoff;
> >  }
> > diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> > index 16646b94fa3a..9b0a84e46e48 100644
> > --- a/tools/perf/util/map.h
> > +++ b/tools/perf/util/map.h
> > @@ -41,9 +41,9 @@ struct kmap *map__kmap(struct map *map);
> >  struct maps *map__kmaps(struct map *map);
> >  
> >  /* ip -> dso rip */
> > -u64 map__map_ip(const struct map *map, u64 ip);
> > +u64 map__dso_map_ip(const struct map *map, u64 ip);
> >  /* dso rip -> ip */
> > -u64 map__unmap_ip(const struct map *map, u64 ip);
> > +u64 map__dso_unmap_ip(const struct map *map, u64 ip);
> >  /* Returns ip */
> >  u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip);
> >  
> > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > index e715869eab8a..c55981116f68 100644
> > --- a/tools/perf/util/symbol-elf.c
> > +++ b/tools/perf/util/symbol-elf.c
> > @@ -1357,8 +1357,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
> >  			map->start = shdr->sh_addr + ref_reloc(kmap);
> >  			map->end = map__start(map) + shdr->sh_size;
> >  			map->pgoff = shdr->sh_offset;
> > -			map->map_ip = map__map_ip;
> > -			map->unmap_ip = map__unmap_ip;
> > +			map->map_ip = map__dso_map_ip;
> > +			map->unmap_ip = map__dso_unmap_ip;
> >  			/* Ensure maps are correctly ordered */
> >  			if (kmaps) {
> >  				int err;
> > -- 
> > 2.40.0.348.gf938b09366-goog
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
