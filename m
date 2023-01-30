Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB81680EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbjA3NaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjA3NaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:30:11 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A978F12065;
        Mon, 30 Jan 2023 05:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675085410; x=1706621410;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D8qB1QFXEHT142JKdp5bZBH2VTLcpAaYZPx8rFj2xf0=;
  b=hQjNJhGoVFMVUN2p9Dzz9w6aD5m0MatbcTTNJMicRGTcelbDDWK7yqji
   uA4IzHr061+wzYr2FSZk8SCNPF6wWyHJCmb0o++IWgjBde35nUp4M2Cnq
   Q8ndEeuZf401dFxFFpHnKzSxgJEG3wwJFeDiOJ8supXadeugtbq05ERpM
   a0WH9PBPoQ21xRjIl0yt8hIQambMbNN9h1VHM5b5pBcKzV0QEf1BWiPPT
   ptAU11ieTl7may4ci4doK1INrYYEAvf+UKw2f39Nsu3ql9V6WtjMoZQ1h
   btGpOVpYsBcXv8WaD3ODy+w8Ohn26ihbvuW78s77NjhMGe8KaGkbbc7hz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="328831210"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="328831210"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 05:30:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="772504414"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="772504414"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.33.106])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 05:29:58 -0800
Message-ID: <7b5f872a-f52e-7129-e956-90e97ec7d911@intel.com>
Date:   Mon, 30 Jan 2023 15:29:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH v2] perf/util: Symbol lookup with kcore can fail if
 multiple segments match stext
Content-Language: en-US
To:     Krister Johansen <kjlx@templeofstupid.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>,
        David Reaver <me@davidreaver.com>
References: <20230124223531.GB1962@templeofstupid.com>
 <20230125183418.GD1963@templeofstupid.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230125183418.GD1963@templeofstupid.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/23 20:34, Krister Johansen wrote:
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

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v2:
>   - Correct whitespace, add comments, and fix-up subject. (Feedback from Adrian
>     Hunter)
> ---
>  tools/perf/util/symbol.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index a3a165ae933a..98014f937568 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1368,10 +1368,23 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
>  
>  	/* Find the kernel map using the '_stext' symbol */
>  	if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &stext)) {
> +		u64 replacement_size = 0;
> +
>  		list_for_each_entry(new_map, &md.maps, node) {
> -			if (stext >= new_map->start && stext < new_map->end) {
> +			u64 new_size = new_map->end - new_map->start;
> +
> +			if (!(stext >= new_map->start && stext < new_map->end))
> +				continue;
> +
> +			/*
> +			 * On some architectures, ARM64 for example, the kernel
> +			 * text can get allocated inside of the vmalloc segment.
> +			 * Select the smallest matching segment, in case stext
> +			 * falls within more than one in the list.
> +			 */
> +			if (!replacement_map || new_size < replacement_size) {
>  				replacement_map = new_map;
> -				break;
> +				replacement_size = new_size;
>  			}
>  		}
>  	}

