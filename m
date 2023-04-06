Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2605E6DA4DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbjDFVmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjDFVmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:42:35 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155C49029;
        Thu,  6 Apr 2023 14:42:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m2so40834484wrh.6;
        Thu, 06 Apr 2023 14:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680817350; x=1683409350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YmAu+Uynfyl2HTmX/Q8qoyobCvJeFzfJPZN+FX4esik=;
        b=cOh4P+3XioEFEwZ/Sv4XHjBuLYa1omvgmcyQzgKGX9rmW5is55JtGospHy46sFbY/f
         J8lyrHgIt7x5ioFB5Zll1skobtaprqIVfmBXFmNe3iRApbX0Az43ymew24b+xlJ+8qV3
         Uz4InzSVVuw7BxK9URqtN3FFwsKCnHOX3ziVGU0jWEtODqzOyi5LDQD5R60R0kWzIiZo
         26DRfSQeqQLiR3q1JMtDWQGgtlEsh42fNTj68eWDSzknH2T3aW4oz7lPlT0fKXK9zvLH
         +V8zFu9UfIayWgVmnEBH788J/4nZi1/3mz3bAiT0zCdXOGRCTTeF/k8k4xtOsGxeWTU+
         DsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680817350; x=1683409350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmAu+Uynfyl2HTmX/Q8qoyobCvJeFzfJPZN+FX4esik=;
        b=CzMY7nU0SE3zizf2Tp9ZUojnkweuvMLaW/2E3mer/bC0J1YEcFgWuj/zTcIv//VmXS
         E+0pO2QQEPHeSAJSEaMoJpVlYaBGQ771ujW0IEq/EEtbA/ZRoEUbOjm8xWs6TsGo5JTZ
         5tB3o47T1zxWpy7W2VqB84umpR53XOZBaFVpYo0zysbFrOIjqu6Q5c+D3ZG1hu6BPjlZ
         5KO/Q1LoLCtduDDGqjUgY2HSPGwvTObiI1EW9lwxF9T6VnaVzE2+PIOmRTvqYyugIvje
         954/bN3biRSSQcXpCohRPf1A/R2l3LMU4Y1BWkZCOHZ5A6kxcK8qR+SjN4j1Ieeh26b5
         C7VA==
X-Gm-Message-State: AAQBX9eEAzWRkRab8YIbhyD5D+GTEXMJk58cEYlxYpsnOuEmYpiy270A
        OqKJkr0TbmIvVKzn2ywdGA0=
X-Google-Smtp-Source: AKy350bTEv1JH6qN02QBBTBoEpTWXajbX6DL7tR2g6TVkpb2r8EoK5A5ePR1alwE5gKTJG7VrPlyYg==
X-Received: by 2002:a5d:6809:0:b0:2d2:22eb:824a with SMTP id w9-20020a5d6809000000b002d222eb824amr8252943wru.34.1680817350321;
        Thu, 06 Apr 2023 14:42:30 -0700 (PDT)
Received: from krava (85-160-61-129.reb.o2.cz. [85.160.61.129])
        by smtp.gmail.com with ESMTPSA id u16-20020adff890000000b002ef72575473sm1251064wrp.117.2023.04.06.14.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:42:30 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 6 Apr 2023 22:42:25 +0100
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] perf pmu: Fix a few potential fd leaks
Message-ID: <ZC88waWWdSDKIuyI@krava>
References: <20230406065224.2553640-1-irogers@google.com>
 <20230406065224.2553640-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406065224.2553640-2-irogers@google.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 11:52:24PM -0700, Ian Rogers wrote:
> Ensure fd is closed on error paths.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

nice catch

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/pmu.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 96ef317bac41..9eedbfc9e863 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -494,9 +494,13 @@ static int pmu_aliases_parse(int dirfd, struct list_head *head)
>  			continue;
>  
>  		fd = openat(dirfd, name, O_RDONLY);
> +		if (fd == -1) {
> +			pr_debug("Cannot open %s\n", name);
> +			continue;
> +		}
>  		file = fdopen(fd, "r");
>  		if (!file) {
> -			pr_debug("Cannot open %s\n", name);
> +			close(fd);
>  			continue;
>  		}
>  
> @@ -1882,9 +1886,13 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>  			continue;
>  
>  		fd = openat(caps_fd, name, O_RDONLY);
> +		if (fd == -1)
> +			continue;
>  		file = fdopen(fd, "r");
> -		if (!file)
> +		if (!file) {
> +			close(fd);
>  			continue;
> +		}
>  
>  		if (!fgets(value, sizeof(value), file) ||
>  		    (perf_pmu__new_caps(&pmu->caps, name, value) < 0)) {
> -- 
> 2.40.0.348.gf938b09366-goog
> 
