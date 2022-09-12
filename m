Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C35A5B5882
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiILKf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiILKfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:35:54 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0AF18376
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:35:53 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id jm11so8127943plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=6eHwNjOIgvLhjqI08GKzb/rPoiG/+8/CYOn+JLITrVQ=;
        b=pOowoFqQ0zd8xn7CzUP3PEAOJzDGR9dKdgdiySP1VNYQVNAObgqiRsvNoKWuQt96a/
         /D4jqyDOkmjiO2ATsrvuzsfAQajWCSZb0AQZg24eLWEk/yRYVapE6zKGdapc15F8OMcZ
         VxyCRuQv3fZe3WbEwTW8hqehDzpyhN1NLBrX5kz3CKIKHpf5ga3tUEaYJCjpfVg7DopW
         OBIFRGVgOrjZTvH6JLz7iRPHRWQPpMcyfHowXpORfTPytCaIh5cjyIlzVjSLmHIj8bpt
         RtZJ6PgcyzLjyYan/SIMHrz7GgmcjVrEd0jAG6NevqGqS6ZabN2EUWgWL+pkb7i3naGq
         OZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=6eHwNjOIgvLhjqI08GKzb/rPoiG/+8/CYOn+JLITrVQ=;
        b=5m+MDwU4nk+YFz1QmsmebSdASbgaMS16J4u3Jj+1woIf2cJQ/LeFSTcm6G7zeKpFZo
         MjFAQ+1lddPzImpqDWdLk5Flj5PbmjWIzsd4pizHi84pGkKpGS6LQ2ppm+Aygt6swWLu
         n/k83+mt4exV2sNlobgl9hazrlU9ZCHt4lMiSeGQuvaZPQr/wiKEnVUWcOK5hWA/EyfV
         n2nE7KM5G8wTFXjtB/Ns1wn5Obnzx6LZ/Y2kTb2iX8X4DB4fa0nNtJ5zu295JP3Q6uiK
         WqC1oOTgYXDZUyrRDibWFH1h34j6NVeZAWzyzzRP4w9yf/V3kqHpXYqURA+DUIoAQfom
         36MA==
X-Gm-Message-State: ACgBeo0FHoegmwtpjswvofqsXm4aaf2hSRjJk26eDPisxTUImvVU+h7i
        K+E32ZtdfZxQdGKal7WdtrF0KA==
X-Google-Smtp-Source: AA6agR7bvnRgllIbKjN4GpLcscwI3NENOU/ycuyUvE9vDawGIqSuMosQmLqYS7MkE96e7f5EcWyAqw==
X-Received: by 2002:a17:90a:a097:b0:1fb:5bc:7778 with SMTP id r23-20020a17090aa09700b001fb05bc7778mr23312176pjp.209.1662978952600;
        Mon, 12 Sep 2022 03:35:52 -0700 (PDT)
Received: from leoy-huanghe.lan (173.242.123.178.16clouds.com. [173.242.123.178])
        by smtp.gmail.com with ESMTPSA id jc20-20020a17090325d400b00177eb4371c7sm5636070plb.36.2022.09.12.03.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 03:35:52 -0700 (PDT)
Date:   Mon, 12 Sep 2022 18:35:46 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf: Skip and warn on unknown format 'configN' attrs
Message-ID: <Yx8LgqUtDh5TwWmV@leoy-huanghe.lan>
References: <20220909204509.2169512-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909204509.2169512-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Sep 09, 2022 at 03:45:09PM -0500, Rob Herring wrote:
> If the kernel exposes a new perf_event_attr field in a format attr, perf
> will return an error stating the specified PMU can't be found. For
> example, a format attr with 'config3:0-63' causes an error as config3 is
> unknown to perf. This causes a compatibility issue between a newer
> kernel with older perf tool.
> 
> Before this change with a kernel adding 'config3' I get:
> 
> $ perf record -e arm_spe// -- true
> event syntax error: 'arm_spe//'
>                      \___ Cannot find PMU `arm_spe'. Missing kernel support?
> Run 'perf list' for a list of valid events
> 
>  Usage: perf record [<options>] [<command>]
>     or: perf record [<options>] -- <command> [<options>]
> 
>     -e, --event <event>   event selector. use 'perf list' to list
> available events
> 
> After this change, I get:
> 
> $ perf record -e arm_spe// -- true
> WARNING: format 'inv_event_filter' requires 'config3' which is not supported by this version of perf!
> [ perf record: Woken up 2 times to write data ]
> [ perf record: Captured and wrote 0.091 MB perf.data ]
> 
> To support unknown configN formats, rework the YACC implementation to
> pass any config[0-9]+ format to perf_pmu__new_format() to handle with a
> warning.
> 
> Note that the user will get the warning if *any* PMU has an unsupported
> format attr even if that PMU isn't used. This is because perf tool scans
> all the PMUs.

I think essentially you want to provide a bug fixing and the fixing can
be back ported on long term supported kernels? If this is the case,
it's good to add a fixes tag like below?

Fixes: cd82a32e9924 ("perf tools: Add perf pmu object to access pmu format definition")

> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Rework YACC code to handle configN formats in C code
>  - Add a warning when an unknown configN attr is found
> 
> v1: https://lore.kernel.org/all/20220901184709.2179309-1-robh@kernel.org/
> ---
>  tools/perf/util/pmu.c |  6 ++++++
>  tools/perf/util/pmu.l |  2 --
>  tools/perf/util/pmu.y | 15 ++++-----------
>  3 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 89655d53117a..6757db7d559c 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1475,6 +1475,12 @@ int perf_pmu__new_format(struct list_head *list, char *name,
>  {
>  	struct perf_pmu_format *format;
>  
> +	if (config > PERF_PMU_FORMAT_VALUE_CONFIG2) {

It's good to add a new macro PERF_PMU_FORMAT_VALUE_CONFIG_END in
util/pmu.h. Then at here we can check the condition:

       if (config >= PERF_PMU_FORMAT_VALUE_CONFIG_END) {

> +		pr_warning("WARNING: format '%s' requires 'config%d' which is not supported by this version of perf!\n",
> +			   name, config);

... so at here we can print log like:

       pr_warning("WARNING: format '%s' requires 'config%d' which is not "
                  "supported by this version of perf (maximum config%d)!\n",
       	          name, config, PERF_PMU_FORMAT_VALUE_CONFIG_END - 1);


The rest of this patch is fine for me.

As a side topic, I know you want to support the SPEv1.2 feature with
config3, seems to me a complete patch set series should include the
changes for supporting config3 as well.  This can give more clear view
for how to fix incompatibility issue between old and new kernels, and
how to support config3 in the latest kernel, but it's fine for me if
you want to split into two patch sets.

Thanks,
Leo

> +		return 0;
> +	}
> +
>  	format = zalloc(sizeof(*format));
>  	if (!format)
>  		return -ENOMEM;
> diff --git a/tools/perf/util/pmu.l b/tools/perf/util/pmu.l
> index a15d9fbd7c0e..58b4926cfaca 100644
> --- a/tools/perf/util/pmu.l
> +++ b/tools/perf/util/pmu.l
> @@ -27,8 +27,6 @@ num_dec         [0-9]+
>  
>  {num_dec}	{ return value(10); }
>  config		{ return PP_CONFIG; }
> -config1		{ return PP_CONFIG1; }
> -config2		{ return PP_CONFIG2; }
>  -		{ return '-'; }
>  :		{ return ':'; }
>  ,		{ return ','; }
> diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
> index bfd7e8509869..283efe059819 100644
> --- a/tools/perf/util/pmu.y
> +++ b/tools/perf/util/pmu.y
> @@ -20,7 +20,7 @@ do { \
>  
>  %}
>  
> -%token PP_CONFIG PP_CONFIG1 PP_CONFIG2
> +%token PP_CONFIG
>  %token PP_VALUE PP_ERROR
>  %type <num> PP_VALUE
>  %type <bits> bit_term
> @@ -47,18 +47,11 @@ PP_CONFIG ':' bits
>  				      $3));
>  }
>  |
> -PP_CONFIG1 ':' bits
> +PP_CONFIG PP_VALUE ':' bits
>  {
>  	ABORT_ON(perf_pmu__new_format(format, name,
> -				      PERF_PMU_FORMAT_VALUE_CONFIG1,
> -				      $3));
> -}
> -|
> -PP_CONFIG2 ':' bits
> -{
> -	ABORT_ON(perf_pmu__new_format(format, name,
> -				      PERF_PMU_FORMAT_VALUE_CONFIG2,
> -				      $3));
> +				      $2,
> +				      $4));
>  }
>  
>  bits:
> -- 
> 2.34.1
> 
