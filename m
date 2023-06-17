Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BBE734325
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346466AbjFQSpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjFQSpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:45:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36B11BDB;
        Sat, 17 Jun 2023 11:45:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-987f7045f9aso84647666b.1;
        Sat, 17 Jun 2023 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687027513; x=1689619513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rBIHidYzagcBorCRFxDokfJI4XA6sU8pkIH1nUUMU0Y=;
        b=HUf39rwR50ou925XInqr0u3J252Q3ZY02hS1ZL0MRgfJquyMteUqsJX19qpd7I9jcX
         smKoRW/DeKoWQKlnYekz2Trwbvg3Gh2nd8bBmdiaPtBDHc53hwHHMuOB6I/HNFxbZ32w
         +ev20cs8sItxvLjvF/dVzb5Jyem91Hf1DxVUz7PRk3wmwlCOVHhHzKC8ge+YmxPAQ6K/
         A8ZzbmJhAKNN930XD4NdfK4QTa0nEHZDulFi0Ixja1c+WQL1tYDrAeNEUhGzC0IUUdPt
         F/MbU54UIpR/MsGyhw3tycreZSIPtd86/G5GRvxOciCPwTwZn0Ca/Q6T2UznRb6CEgTQ
         FwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687027513; x=1689619513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBIHidYzagcBorCRFxDokfJI4XA6sU8pkIH1nUUMU0Y=;
        b=GJwl4fMf1iD4CikayhGJVOjlD5speEN4j6Y6gpVccTU8tREsv5282LVIjwmlJPNbKP
         oxogceMRXyxGHURGP/CLATgB7taPFN0vyCckduDFIhv2SyV424qw5XsiIjC9u1hWz0YL
         YWTHraBDqDrCmSrxwbf7PatpjhSD0q3wQHWkTvk/R3rCLUJRNrF5FMv4n4vP29PtDRXw
         M+0XjkqciFhyAdiawbKI7m2E+iTq5/BanqSkbceHs9sLEesHY5YecKlEs+gWU6tw6F3X
         FOjjHRKD87hwqNwe3ZKAW3x6+ytEbrdq35EA1ZabOiWSglqx3u8J+bneQ4Qiokt2ExV/
         rRSg==
X-Gm-Message-State: AC+VfDzkjn3HnUvrZSgStd1g6VM6mkSi8+1OjESv3gGAGSj4Kxulyd4T
        ZlN4hwWxLubGzMy+rNrsoHo=
X-Google-Smtp-Source: ACHHUZ7ufP10Rl2kPsTUXuu1X53t6gywyhazJr7lslV6KFmfKz8uS4tz+Y6IyBSEKogHK22WJHteNA==
X-Received: by 2002:a17:907:6d23:b0:988:6491:98e3 with SMTP id sa35-20020a1709076d2300b00988649198e3mr331554ejc.68.1687027512953;
        Sat, 17 Jun 2023 11:45:12 -0700 (PDT)
Received: from krava ([83.240.63.131])
        by smtp.gmail.com with ESMTPSA id f25-20020a1709062c5900b0098866a94f14sm116441ejh.125.2023.06.17.11.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 11:45:12 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sat, 17 Jun 2023 20:45:10 +0200
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/2] perf stat: Reset aggr stats for each run
Message-ID: <ZI3/Nmch0ufFJ7Dp@krava>
References: <20230616073211.1057936-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616073211.1057936-1-namhyung@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 12:32:10AM -0700, Namhyung Kim wrote:
> When it runs multiple times with -r option, it missed to reset the
> aggregation counters and the values were added up.  The aggregation
> count has the values to be printed in the end.  It should reset the
> counters at the beginning of each run.  But the current code does that
> only when -I/--interval-print option is given.
> 
> Fixes: 91f85f98da7a ("perf stat: Display event stats using aggr counts")
> Reported-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index c87c6897edc9..e549862f90f0 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -725,6 +725,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  			all_counters_use_bpf = false;
>  	}
>  
> +	evlist__reset_aggr_stats(evsel_list);
> +

would it be better to call this below before read_counters call,
together with the other counts setup calls?

jirka

>  	evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
>  		counter = evlist_cpu_itr.evsel;
>  
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 
