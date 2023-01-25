Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D79F67AAE8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbjAYH3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbjAYH3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:29:40 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2EC10255;
        Tue, 24 Jan 2023 23:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674631779; x=1706167779;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HBu4iRgqpdbwgyjjFi/7Wz2ssi58Gb2OMwn5vk9+tw4=;
  b=LENRZriYEWMQZC+BSUGbu6efAeRY34neyFb4iGmCsEppXAhzBprK37rE
   MMnJQ7cmPB/JEC/L1NqGW/On1PJfnqTGf2sEAth6p/SFwDfPzqZ9Ncvqv
   s9Ca0u/I2GHGwiwGb4AQ/AI+NomFM71RgX4Yoyy4Zec1+QIASdE3bXXIW
   R2Evs32aaSYvccWYIYF4O1tSc6MJTGjtvKbanthXyGlgpNyqqnQU4GEZ4
   sqlBQuhY5qt78laG6dG7I4PqKzdSI2CK8JfRU/j8gWMG7OhpJD0NIk7S5
   X6X6J+i+RuVJLtfOIdxhKAP9Nws68F2PDXXjzSkEnkuEB+qmPG0Bk4uwy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="328585405"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="328585405"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 23:29:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="786346960"
X-IronPort-AV: E=Sophos;i="5.97,244,1669104000"; 
   d="scan'208";a="786346960"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.193])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 23:29:35 -0800
Message-ID: <65cb75e0-4c0b-9384-1f6b-77a0053d8109@intel.com>
Date:   Wed, 25 Jan 2023 09:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH] perf/util: Symbol lookup can fail if multiple segmets
 match stext
Content-Language: en-US
To:     Krister Johansen <kjlx@templeofstupid.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>,
        David Reaver <me@davidreaver.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230124223531.GB1962@templeofstupid.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230124223531.GB1962@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/23 00:35, Krister Johansen wrote:
> This problem was encountered on an arm64 system with a lot of memory.
> Without kernel debug symbols installed, and with both kcore and kallsyms
> available, perf managed to get confused and returned "unknown" for all
> of the kernel symbols that it tried to look up.
> 
> On this system, stext fell within the vmalloc segment.  The kcore symbol
> matching code tries to find the first segment that contains stext and
> uses that to replace the segment generated from just the kallsyms
> information.  In this case, however, there were two: a very large
> vmalloc segment, and the text segment.  This caused perf to get confused
> because multiple overlapping segments were inserted into the RB tree
> that holds the discovered segments.  However, that alone wasn't
> sufficient to cause the problem. Even when we could find the segment,
> the offsets were adjusted in such a way that the newly generated symbols
> didn't line up with the instruction addresses in the trace.  The most
> obvious solution would be to consult which segment type is text from
> kcore, but this information is not exposed to users.
> 
> Instead, select the smallest matching segment that contains stext
> instead of the first matching segment.  This allows us to match the text
> segment instead of vmalloc, if one is contained within the other.
> 
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> ---
>  tools/perf/util/symbol.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index a3a165ae933a..14ac4189eaff 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1368,10 +1368,16 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>  
>  	/* Find the kernel map using the '_stext' symbol */
>  	if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &stext)) {
> +		u64 replacement_size = 0;

We'd usually put a blank line here

>  		list_for_each_entry(new_map, &md.maps, node) {
> -			if (stext >= new_map->start && stext < new_map->end) {
> +			u64 new_size = new_map->end - new_map->start;
> +
> +			if (!(stext >= new_map->start && stext < new_map->end))
> +				continue;
> +

Really needs a comment, and please be specific e.g.

 ARM64 vmalloc segment overlaps the kernel text segment, so
 choosing the smaller segment will get the kernel text.



> +			if (!replacement_map || new_size < replacement_size) {
>  				replacement_map = new_map;
> -				break;
> +				replacement_size = new_size;
>  			}
>  		}
>  	}

