Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6318F6E8194
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjDSS6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDSS6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:58:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A427198C;
        Wed, 19 Apr 2023 11:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681930699; x=1713466699;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3ZqGIl7c/zKj5hrgYe0gizYtFw4+kaPJ5R/WqpbhwhI=;
  b=OSFgEuZFgiEoyfB5u51Z/+QtQXNf3FRrRxY+QpNpsOo6ywAt7ubYBS1U
   MFWnWd+hHaAjqz1JVGsg6LAsBeSzywX03rScPVziKw4awUrEQ08ezWWLB
   zkwMpemybf5T6CwVxQSflzfKIYHk8lpBW5s+vPCUbNPW7l9pabnoCIvA4
   S4UkrF1sKssGxDOg/mt74q0Sb8y7ka81flqKQVQwgR7JllWtBRh1Crne/
   YYZhqK3hGT5IJMBOLafprANsMDUeUdlEPd3V5FaYYrDS206O7KqfFuggi
   X2oajh90WnBozMAGEv4hPQK+yZ/8g+GxTIo/j9ncaQ5w/pAZx+ryTdjUi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="343015843"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="343015843"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 11:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="780940105"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="780940105"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.238])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 11:58:15 -0700
Message-ID: <3001bde2-b010-3c00-17de-1c78ef4b589b@intel.com>
Date:   Wed, 19 Apr 2023 21:58:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v5 2/3] perf: add helper map__fprintf_dsoname_dsoff
To:     Changbin Du <changbin.du@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hw.huiwang@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20230418031825.1262579-1-changbin.du@huawei.com>
 <20230418031825.1262579-3-changbin.du@huawei.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230418031825.1262579-3-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/23 06:18, Changbin Du wrote:
> This adds a helper function map__fprintf_dsoname_dsoff() to print dsoname
> with optional dso offset.
> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  tools/perf/util/map.c | 13 +++++++++++++
>  tools/perf/util/map.h |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index d81b6ca18ee9..7da96b41100f 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -445,6 +445,19 @@ size_t map__fprintf_dsoname(struct map *map, FILE *fp)
>  	return fprintf(fp, "%s", dsoname);
>  }
>  
> +size_t map__fprintf_dsoname_dsoff(struct map *map, bool print_off, u64 addr, FILE *fp)
> +{
> +	int printed = 0;
> +
> +	printed += fprintf(fp, " (");
> +	printed += map__fprintf_dsoname(map, fp);
> +	if (print_off && map && map__dso(map) && !map__dso(map)->kernel)

That will also block vmlinux offsets not just [kernel.kallsyms]
Is that what was intended?

> +		printed += fprintf(fp, "+0x%" PRIx64, addr);
> +	printed += fprintf(fp, ")");
> +
> +	return printed;
> +}
> +
>  char *map__srcline(struct map *map, u64 addr, struct symbol *sym)
>  {
>  	if (map == NULL)
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index f89ab7c2d327..4cca211b6e66 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -175,6 +175,7 @@ static inline void __map__zput(struct map **map)
>  
>  size_t map__fprintf(struct map *map, FILE *fp);
>  size_t map__fprintf_dsoname(struct map *map, FILE *fp);
> +size_t map__fprintf_dsoname_dsoff(struct map *map, bool print_off, u64 addr, FILE *fp);
>  char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
>  int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
>  			 FILE *fp);

