Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBBE694735
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjBMNkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjBMNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:40:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A8A1ADDF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676295559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=26QBmCO7JapN+9Hm24DRjK9ATcNbpPkqVmUfotAg9yE=;
        b=JqcBGL8J29ZtuFUAsmhb/Y0V9uWVy0uiz9tYpzmcTP0rvdob9AfIy6UOaoLHHbUXhahLt6
        71S7r6V1KaOWGZfB1Meq6QtM6atizpQS8FOa9v16txv9pBLp+xLaOwBbyMZiG7+J/Yx4Oz
        kohSjZyqwDyM/OJJEcYBC/sJZeCuKeg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-KzqFPniJOc-eYJsseSUVtg-1; Mon, 13 Feb 2023 08:39:17 -0500
X-MC-Unique: KzqFPniJOc-eYJsseSUVtg-1
Received: by mail-qk1-f197.google.com with SMTP id a198-20020ae9e8cf000000b007259083a3c8so7447601qkg.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:39:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26QBmCO7JapN+9Hm24DRjK9ATcNbpPkqVmUfotAg9yE=;
        b=MG8qDWR5cfDEOYLVzFbweekBlKRFbt41kI/ghrvBAkiHeNcVxvnLjVXhlN2Mjf60p2
         6LYEP8SZnVme2pAmo4qx7iCmWtMirGsM5Bn3olO+COE3B5MZ9rMPlYj9E+56Q5INGAq7
         u9Xrk6audip+ugGDrMa6+74s/pikgNZNWRjHYN23R2Nc3N2civrzi+v7L5cnF6qCZ0O2
         e6BRY082rkEVxbZB3okeB1X/SnHXsafFo5BlCRpv21S0yQFUQBYDpp8xly2hXgFOOHJ8
         bGcBmDyq6/E1tLvr8Gt8cRCaVJYvDADDZt+PVTF4t7/nujVwfoIhQQHHlgxKXePHpOhL
         jA/g==
X-Gm-Message-State: AO0yUKVKnsmfB3U3NcpEJyUoFibWi0XIj+hWyVTDsxaKBIfYkS+7LMPi
        escBYCwH8zMxLa12kwakHkdX0/0c1Wa+zlI/cPuB77NvEyP2TuOyazZ9JEYLyyGwXuvRim4mIzM
        sX3+2Wpj+/+HRi0Q9TnkEV/Xi
X-Received: by 2002:a05:6214:1c0e:b0:56e:ab08:670b with SMTP id u14-20020a0562141c0e00b0056eab08670bmr9083067qvc.34.1676295557291;
        Mon, 13 Feb 2023 05:39:17 -0800 (PST)
X-Google-Smtp-Source: AK7set+aYgyPAO6oJPYmirUIUqwbk0ipS9F4i7VAffHt2sNjhvvbFR21wc0SrlU8WjDcc+LWhbBgdg==
X-Received: by 2002:a05:6214:1c0e:b0:56e:ab08:670b with SMTP id u14-20020a0562141c0e00b0056eab08670bmr9083030qvc.34.1676295556979;
        Mon, 13 Feb 2023 05:39:16 -0800 (PST)
Received: from [192.168.1.86] (pool-173-76-169-128.bstnma.fios.verizon.net. [173.76.169.128])
        by smtp.gmail.com with ESMTPSA id 9-20020a05620a048900b006fec1c0754csm9727357qkr.87.2023.02.13.05.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 05:39:16 -0800 (PST)
Message-ID: <649f813d-2500-3015-57dc-b2e1fe290388@redhat.com>
Date:   Mon, 13 Feb 2023 08:39:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] perf c2c: Add report option to show false sharing in
 adjacent cachelines
To:     Feng Tang <feng.tang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
References: <20230213031733.236485-1-feng.tang@intel.com>
Content-Language: en-US
From:   Joe Mario <jmario@redhat.com>
In-Reply-To: <20230213031733.236485-1-feng.tang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/23 10:17 PM, Feng Tang wrote:
> Many platforms have feature of adjacent cachelines prefetch, when it
> is enabled, for data in RAM of 2 cachelines (2N and 2N+1) granularity,
> if one is fetched to cache, the other one could likely be fetched too,
> which sort of extends the cacheline size to double, thus the false
> sharing could happens in adjacent cachelines.
> 
> 0Day has captured performance changed related with this [1], and some
> commercial software explicitly makes its hot global variables 128 bytes
> aligned (2 cache lines) to avoid this kind of extended false sharing.
> 
> So add an option "-a" or "--double-cl" for c2c report to show false
> sharing in double cache line granularity, which acts just like the
> cacheline size is doubled. There is no change to c2c record. The
> hardware HITM events are still per cacheline. The option just changes
> the granularity of how events are grouped and displayed.
> 
> In the c2c report below (will-it-scale's pagefault2 case on old kernel):
> 
>   ----------------------------------------------------------------------
>      26       31        2        0        0        0  0xffff888103ec6000
>   ----------------------------------------------------------------------
>    35.48%   50.00%    0.00%    0.00%    0.00%   0x10     0       1  0xffffffff8133148b      1153        66       971     3748        74  [k] get_mem_cgroup_from_mm
>     6.45%    0.00%    0.00%    0.00%    0.00%   0x10     0       1  0xffffffff813396e4       570         0      1531      879        75  [k] mem_cgroup_charge
>    25.81%   50.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff81331472       949        70       593     3359        74  [k] get_mem_cgroup_from_mm
>    19.35%    0.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff81339686      1352         0      1073     1022        74  [k] mem_cgroup_charge
>     9.68%    0.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff813396d6      1401         0       863      768        74  [k] mem_cgroup_charge
>     3.23%    0.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff81333106       618         0       804       11         9  [k] uncharge_batch
> 
> The offset 0x10 and 0x54 used to displayed in 2 groups, and now they
> are listed together to give users a hint.
> 
> [1]. https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-c2c.txt |  6 ++++++
>  tools/perf/builtin-c2c.c              | 22 +++++++++++++---------
>  tools/perf/util/cacheline.h           | 25 ++++++++++++++++++++-----
>  tools/perf/util/sort.c                | 13 ++++++++++---
>  tools/perf/util/sort.h                |  1 +
>  5 files changed, 50 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
> index 5c5eb2def83e..a8e1e40d270e 100644
> --- a/tools/perf/Documentation/perf-c2c.txt
> +++ b/tools/perf/Documentation/perf-c2c.txt
> @@ -126,6 +126,12 @@ REPORT OPTIONS
>  	The known limitations include exception handing such as
>  	setjmp/longjmp will have calls/returns not match.
>  
> +-a::
> +--double-cl::
> +	Group HITM events in double cacheline granularity. Some architecture
> +	has Adjacent Cacheline Prefetch feature, which behaves like the
> +	cachline size is doubled.
> +

Hi Feng:
One or two of the recent C2C patches changed the Intel-specifc "HITM" wording to something more generic, mostly because other arches do not have HITM events.

How about changing the above description to something like:
+-a::
+--double-cl::
+       Group the detection of shared cacheline events into double cacheline granularity.
+       Some architectures have an Adjacent Cacheline Prefetch feature, which causes
+       cacheline sharing to behave like the cachline size is doubled.

By the way, this patch is awesome.  
It's not often that Adjacent Cacheline Prefetching causes performance problems, but when it does, it's a pain to track down.
This will really help.  Thank you for doing it.

Joe

>  C2C RECORD
>  ----------
>  The perf c2c record command setup options related to HITM cacheline analysis
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 52d94c7dd836..7d495db7e5a2 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -524,7 +524,7 @@ static int dcacheline_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>  	char buf[20];
>  
>  	if (he->mem_info)
> -		addr = cl_address(he->mem_info->daddr.addr);
> +		addr = cl_address(he->mem_info->daddr.addr, chk_double_cl);
>  
>  	return scnprintf(hpp->buf, hpp->size, "%*s", width, HEX_STR(buf, addr));
>  }
> @@ -562,7 +562,7 @@ static int offset_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>  	char buf[20];
>  
>  	if (he->mem_info)
> -		addr = cl_offset(he->mem_info->daddr.al_addr);
> +		addr = cl_offset(he->mem_info->daddr.al_addr, chk_double_cl);
>  
>  	return scnprintf(hpp->buf, hpp->size, "%*s", width, HEX_STR(buf, addr));
>  }
> @@ -574,9 +574,10 @@ offset_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
>  	uint64_t l = 0, r = 0;
>  
>  	if (left->mem_info)
> -		l = cl_offset(left->mem_info->daddr.addr);
> +		l = cl_offset(left->mem_info->daddr.addr, chk_double_cl);
> +
>  	if (right->mem_info)
> -		r = cl_offset(right->mem_info->daddr.addr);
> +		r = cl_offset(right->mem_info->daddr.addr, chk_double_cl);
>  
>  	return (int64_t)(r - l);
>  }
> @@ -2590,7 +2591,7 @@ perf_c2c_cacheline_browser__title(struct hist_browser *browser,
>  	he = cl_browser->he;
>  
>  	if (he->mem_info)
> -		addr = cl_address(he->mem_info->daddr.addr);
> +		addr = cl_address(he->mem_info->daddr.addr, chk_double_cl);
>  
>  	scnprintf(bf, size, "Cacheline 0x%lx", addr);
>  	return 0;
> @@ -2788,15 +2789,16 @@ static int ui_quirks(void)
>  	if (!c2c.use_stdio) {
>  		dim_offset.width  = 5;
>  		dim_offset.header = header_offset_tui;
> -		nodestr = "CL";
> +		nodestr = chk_double_cl ? "Double-CL" : "CL";
>  	}
>  
>  	dim_percent_costly_snoop.header = percent_costly_snoop_header[c2c.display];
>  
>  	/* Fix the zero line for dcacheline column. */
> -	buf = fill_line("Cacheline", dim_dcacheline.width +
> -				     dim_dcacheline_node.width +
> -				     dim_dcacheline_count.width + 4);
> +	buf = fill_line(chk_double_cl ? "Double-Cacheline" : "Cacheline",
> +				dim_dcacheline.width +
> +				dim_dcacheline_node.width +
> +				dim_dcacheline_count.width + 4);
>  	if (!buf)
>  		return -ENOMEM;
>  
> @@ -3037,6 +3039,8 @@ static int perf_c2c__report(int argc, const char **argv)
>  	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
>  	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
>  		    "Enable LBR callgraph stitching approach"),
> +	OPT_BOOLEAN('a', "double-cl", &chk_double_cl,
> +		    "Check adjacent cachline false sharing"),
>  	OPT_PARENT(c2c_options),
>  	OPT_END()
>  	};
> diff --git a/tools/perf/util/cacheline.h b/tools/perf/util/cacheline.h
> index dec8c0fb1f4a..630d16731b4f 100644
> --- a/tools/perf/util/cacheline.h
> +++ b/tools/perf/util/cacheline.h
> @@ -6,16 +6,31 @@
>  
>  int __pure cacheline_size(void);
>  
> -static inline u64 cl_address(u64 address)
> +
> +/*
> + * Some architecture has 'Adjacent Cacheline Prefetch' feature,
> + * which performs like the cacheline size being doubled.
> + */
> +static inline u64 cl_address(u64 address, bool double_cl)
>  {
> +	u64 size = cacheline_size();
> +
> +	if (double_cl)
> +		size *= 2;
> +
>  	/* return the cacheline of the address */
> -	return (address & ~(cacheline_size() - 1));
> +	return (address & ~(size - 1));
>  }
>  
> -static inline u64 cl_offset(u64 address)
> +static inline u64 cl_offset(u64 address, bool double_cl)
>  {
> -	/* return the cacheline of the address */
> -	return (address & (cacheline_size() - 1));
> +	u64 size = cacheline_size();
> +
> +	if (double_cl)
> +		size *= 2;
> +
> +	/* return the offset inside cachline */
> +	return (address & (size - 1));
>  }
>  
>  #endif // PERF_CACHELINE_H
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index e188f74698dd..148b28f0a7e2 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -52,6 +52,13 @@ enum sort_mode	sort__mode = SORT_MODE__NORMAL;
>  static const char *const dynamic_headers[] = {"local_ins_lat", "ins_lat", "local_p_stage_cyc", "p_stage_cyc"};
>  static const char *const arch_specific_sort_keys[] = {"local_p_stage_cyc", "p_stage_cyc"};
>  
> +/*
> + * Some architecture has Adjacent Cacheline Prefetch feature, which behaves
> + * like the cachline size is doubled. Enable this flag to check things in
> + * double cacheline granularity.
> + */
> +bool chk_double_cl;
> +
>  /*
>   * Replaces all occurrences of a char used with the:
>   *
> @@ -1499,8 +1506,8 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
>  
>  addr:
>  	/* al_addr does all the right addr - start + offset calculations */
> -	l = cl_address(left->mem_info->daddr.al_addr);
> -	r = cl_address(right->mem_info->daddr.al_addr);
> +	l = cl_address(left->mem_info->daddr.al_addr, chk_double_cl);
> +	r = cl_address(right->mem_info->daddr.al_addr, chk_double_cl);
>  
>  	if (l > r) return -1;
>  	if (l < r) return 1;
> @@ -1519,7 +1526,7 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
>  	if (he->mem_info) {
>  		struct map *map = he->mem_info->daddr.ms.map;
>  
> -		addr = cl_address(he->mem_info->daddr.al_addr);
> +		addr = cl_address(he->mem_info->daddr.al_addr, chk_double_cl);
>  		ms = &he->mem_info->daddr.ms;
>  
>  		/* print [s] for shared data mmaps */
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index 921715e6aec4..04f0a6dc7381 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -35,6 +35,7 @@ extern struct sort_entry sort_sym_from;
>  extern struct sort_entry sort_sym_to;
>  extern struct sort_entry sort_srcline;
>  extern const char default_mem_sort_order[];
> +extern bool chk_double_cl;
>  
>  struct res_sample {
>  	u64 time;

