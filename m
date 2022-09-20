Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1AB5BE7D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiITOAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiITOAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:00:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D1413F27;
        Tue, 20 Sep 2022 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663682406; x=1695218406;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RHAlT1tmtQpRmnr86saDeoL2upzLNqG6AJXpqitAz+0=;
  b=WKh4leqb8+mVSOrEdzUHMy6Qcbhm9kBodcUasg1QaO/0SE4TXp5t3g8t
   HY32sI/QV1CLUlkYK66e20T6KvUX3ScBTFvrZGoHLkjXZQRBACzH7AFZa
   SdZVYi73pU+FEtjMBS0qfnCdKRKoeu3CbHgGnmPRBl/kWjc9lD3RoEgrz
   o3wvw8kTc2v69Ei3TFFsF67+EWtGn5y5gkcoaa5dxwtQEPs4ll0RTsjHP
   HoYkNgfFgmGED9E7tSGdnOzJFC5g5s3gbP2oftTqiZle1cGxPGR2NrnVQ
   F8NvQ9zDLVB/gRy9sOIwYMynnt870JqNx/u989tJs6aWhvmhwl6u8oyYe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="298424944"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="298424944"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 07:00:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="744543055"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.32])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 07:00:03 -0700
Message-ID: <571fb9aa-98e7-b42a-aa81-01658e131f11@intel.com>
Date:   Tue, 20 Sep 2022 16:59:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 3/4] perf record: Save DSO build-ID for synthesizing
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
References: <20220916175902.1155177-1-namhyung@kernel.org>
 <20220916175902.1155177-4-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220916175902.1155177-4-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/22 20:59, Namhyung Kim wrote:
> When synthesizing MMAP2 with build-id, it'd read the same file repeatedly as
> it has no idea if it's done already.  Maintain a dsos to check that and skip
> the file access if possible.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/synthetic-events.c | 49 +++++++++++++++++++++++++-----
>  1 file changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 9d4f5dacd154..e6978b2dee8f 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -4,6 +4,7 @@
>  #include "util/data.h"
>  #include "util/debug.h"
>  #include "util/dso.h"
> +#include "util/dsos.h"
>  #include "util/event.h"
>  #include "util/evlist.h"
>  #include "util/machine.h"
> @@ -47,12 +48,25 @@
>  
>  unsigned int proc_map_timeout = DEFAULT_PROC_MAP_PARSE_TIMEOUT;
>  
> +static bool synth_init_done;
> +static struct dsos synth_dsos;
> +
>  void perf_event__synthesize_start(void)
>  {
> +	if (synth_init_done)
> +		return;
> +
> +	dsos__init(&synth_dsos);
> +
> +	synth_init_done = true;
>  }
>  
>  void perf_event__synthesize_stop(void)
>  {
> +	if (!synth_init_done)
> +		return;
> +
> +	dsos__exit(&synth_dsos);
>  }
>  
>  int perf_tool__process_synth_event(struct perf_tool *tool,
> @@ -374,26 +388,47 @@ static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
>  static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
>  					     bool is_kernel)
>  {
> -	struct build_id bid;
> +	struct build_id _bid, *bid = &_bid;
> +	struct dso *dso = NULL;
> +	struct dso_id id;
>  	int rc;
>  
> -	if (is_kernel)
> -		rc = sysfs__read_build_id("/sys/kernel/notes", &bid);
> -	else
> -		rc = filename__read_build_id(event->filename, &bid) > 0 ? 0 : -1;
> +	if (is_kernel) {
> +		rc = sysfs__read_build_id("/sys/kernel/notes", bid);
> +		goto out;
> +	}
> +
> +	id.maj = event->maj;
> +	id.min = event->min;
> +	id.ino = event->ino;
> +	id.ino_generation = event->ino_generation;
>  

There might be some paths missing perf_event__synthesize_start()
e.g. perf trace
So it would probably be safer to use lazy initialization for
synth_dsos.

Also, callers of perf_record_mmap2__read_build_id() have a struct
machine so I wonder about putting synth_dsos in struct machine ?
Or even just using machine->dsos ?

> +	dso = dsos__findnew_id(&synth_dsos, event->filename, &id);
> +	if (dso && dso->has_build_id) {
> +		bid = &dso->bid;
> +		rc = 0;
> +		goto out;
> +	}
> +
> +	rc = filename__read_build_id(event->filename, bid) > 0 ? 0 : -1;
> +
> +out:
>  	if (rc == 0) {
> -		memcpy(event->build_id, bid.data, sizeof(bid.data));
> -		event->build_id_size = (u8) bid.size;
> +		memcpy(event->build_id, bid->data, sizeof(bid->data));
> +		event->build_id_size = (u8) bid->size;
>  		event->header.misc |= PERF_RECORD_MISC_MMAP_BUILD_ID;
>  		event->__reserved_1 = 0;
>  		event->__reserved_2 = 0;
> +
> +		if (dso && !dso->has_build_id)
> +			dso__set_build_id(dso, bid);
>  	} else {
>  		if (event->filename[0] == '/') {
>  			pr_debug2("Failed to read build ID for %s\n",
>  				  event->filename);
>  		}
>  	}
> +	dso__put(dso);
>  }
>  
>  int perf_event__synthesize_mmap_events(struct perf_tool *tool,

