Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BC66EC4CE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 07:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjDXF0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 01:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjDXF0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:26:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9793AA1;
        Sun, 23 Apr 2023 22:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682313950; x=1713849950;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PECS33xVfxBwPqm/z4++N+BusME5fwvJQpLKcT5CDbc=;
  b=QEbN9oSTdOJT19/xX6WzBk7knH338CPOu2Xwfsm2A3VdXf1UBz7nHrXB
   SugsV/w7llH1O1cqDJxq7091lTFKflQgLJjWiqInRwd/slTzNg/o+xogL
   B3hU6lL+aOZ+JLLoBoDGm9XMC1UNcN3EKNl1YIv1pCs4OLZPH6n6Rw5d/
   CIjuiAScoCmpzsC0JCjjQU7rMGAWdIlBnLt+GruOlJnMkNnTy+uJFQ577
   crLtWSQ1W41b/AZ44xo0jQPYCk/8cF96z+DlWk5RNf1LaWvM7w0w2MnkW
   WuNDDteo5e3xyLZvOVouusY555PSGxuFAPQjOpCied4WNl2Ey6Qz297Lu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="346385492"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="346385492"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 22:25:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="817121868"
X-IronPort-AV: E=Sophos;i="5.99,221,1677571200"; 
   d="scan'208";a="817121868"
Received: from faerberc-mobl2.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.217])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 22:25:43 -0700
Message-ID: <e55f0646-173c-c60c-e119-5ad30cc123a5@intel.com>
Date:   Mon, 24 Apr 2023 08:25:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v5 2/3] perf: add helper map__fprintf_dsoname_dsoff
Content-Language: en-US
To:     Changbin Du <changbin.du@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hw.huiwang@huawei.com>
References: <20230418031825.1262579-1-changbin.du@huawei.com>
 <20230418031825.1262579-3-changbin.du@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230418031825.1262579-3-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

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

