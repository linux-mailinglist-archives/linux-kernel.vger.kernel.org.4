Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C43A5FC40A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 12:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJLK4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 06:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJLK4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 06:56:03 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487EEBEAD3;
        Wed, 12 Oct 2022 03:55:58 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so987319wmb.0;
        Wed, 12 Oct 2022 03:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7tTCNA04jkTPpBzaEM9T0+Q3Qtd8fXX6m2NgpshmT3I=;
        b=KGfas7HNyZY+6AtMzZFzNBzf0blxhZ2YFPh95rhttaO8DbJS5HzTlzkBFM7W++Bbp0
         KmM1do3FnF2OniLsXLE9SI5LUCxMdIHTfJ3Hf4wztfysO4oa6+i4O0yiDJ3KxsBLDuwa
         PMmxcWY3bYDy5VvwmGXdcCJwLmPAwvwcm5qaYW8PI7nJHf1v438kA/X2FZ5ZOOCeR/QQ
         Ci6W3NN9r2Cxa6CfsOpkg0ontOmBaEWX+/ILSi5X3eYhu7ugRoMGw3E7ki1/odTT7n4/
         fUqPb0XTjj0JeYqIuWelpjdpG1vZe32sRERlE1cBzpv8NwXhTuN1Z0ZQarxymneAsT7a
         cbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tTCNA04jkTPpBzaEM9T0+Q3Qtd8fXX6m2NgpshmT3I=;
        b=Sjo4jlJKQrA9utJ6n5otDolMTPXgMG49A3dip2bbCoQuTE2WL8jztga0IQAv+kF0Sw
         v6kUERZnK7HiyPpnPVMU6UHSk74ge3FIyov3nyYFe8/1xTCZQJZMjBCzvxxMB/CYejl4
         3Od4UeZ1BCIKNLUUtT8jE7d5pn3clxja5PXf9BoDRQWY5OvBNGeFHPJvRqCsQtjEwLvO
         yCH91iBqQxGecaSWrcFDgbxPQ40CvmPoKXOf0m8ty8NHsSFFi5Pju8yZTDRhK7yc6BMs
         nQ6N/zyujRKCdIOFBp4xoOm15c7Nkso5FN22k5EyemaDP8SmyTQjF1CA3xNeC2Ee5h7L
         ZGJQ==
X-Gm-Message-State: ACrzQf1wwgqAE6WiYwsSTzlQFiUZXmtIxBMCAgI1UYxyx6SwxxIIyRmF
        gJUNAYz3Pge4vkUbheFJ+Qo=
X-Google-Smtp-Source: AMsMyM4GDELPBEm5am+OmoyaGVAXakx029UGzjerQFNN+Tw1zg0RKTBj6QcM5SjnFSMC8Ew8IacLlw==
X-Received: by 2002:a7b:ca53:0:b0:3b4:90c4:e07 with SMTP id m19-20020a7bca53000000b003b490c40e07mr2418950wml.150.1665572156188;
        Wed, 12 Oct 2022 03:55:56 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b0022add371ed2sm13243894wro.55.2022.10.12.03.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 03:55:55 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 12 Oct 2022 12:55:53 +0200
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH 04/19] perf stat: Add aggr id for global mode
Message-ID: <Y0adOTUulE/HnLU3@krava>
References: <20221010053600.272854-1-namhyung@kernel.org>
 <20221010053600.272854-5-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010053600.272854-5-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 10:35:45PM -0700, Namhyung Kim wrote:
> To make the code simpler, I'd like to use the same aggregation code for
> the global mode.  We can simply add an id function to return cpu 0 and
> use print_aggr().
> 
> No functional change intended.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c      | 39 ++++++++++++++++++++++++++++++++--
>  tools/perf/util/cpumap.c       | 10 +++++++++
>  tools/perf/util/cpumap.h       |  6 +++++-
>  tools/perf/util/stat-display.c |  9 ++------
>  4 files changed, 54 insertions(+), 10 deletions(-)
> 

SNIP

> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 4113aa86772f..1d8e585df4ad 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1477,13 +1477,8 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
>  		if (config->iostat_run)
>  			iostat_print_counters(evlist, config, ts, prefix = buf,
>  					      print_counter_aggr);
> -		else {
> -			evlist__for_each_entry(evlist, counter) {
> -				print_counter_aggr(config, counter, prefix);
> -			}
> -			if (metric_only)
> -				fputc('\n', config->output);
> -		}
> +		else
> +			print_aggr(config, evlist, prefix);

this seems to break output for:

before:
	# ./perf stat -M ipc -I 1000 --metric-only
	#           time                  IPC 
	     1.000674320                 0.61 
	     2.001700284                 0.66 
	     3.003677500                 0.67 
	     4.005583140                 0.64 

after:
	# ./perf stat -M ipc -I 1000 --metric-only
	#           time                  IPC 
	     1.001004048                 0.94 

	     2.003120471                 0.69 

	     3.005030405                 0.65 

	     4.006788766                 0.64 

	     5.008004052                 0.68 


also should this hunk be in separate patch?

jirka

>  		break;
>  	case AGGR_NONE:
>  		if (metric_only)
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
