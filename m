Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B6B6D898A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbjDEVYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbjDEVXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:23:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760837EFE;
        Wed,  5 Apr 2023 14:23:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j24so37588626wrd.0;
        Wed, 05 Apr 2023 14:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680729811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ldn880u6qacFUyrH9vmOjtrznPDxvGg0ZyTK235BksU=;
        b=W235fclSvS/0lEyk+yvGsGy2s0xbgXtV1Kk3jXuoY7fS5vTlHlZRL16gXQ1rmR3n3H
         8AUqtZa8KiVUeFdcI/3fewNSNxUL14cj0ns2P4rpuXRYuw6yHbZi6QnvzMHUkz4cG0tv
         hX6uzSFB0aeyRvHtL+uRW79q7GGxSwV1ffIoo9YbqnH17gzLePLPVFkIrRh62+XVJsff
         Bk0ZWSae8s0Df2qecU2NVgVB/0iATqRk+SlX4cGfHN1fRFP1nkVmlZVp5FmdbZ8UY7we
         T6DBOOP5r3rp8a6BnyKBxtekqPHcfuqA3UDHHignaSIYQ/qVhmaZ4t20ziFc8LKUmt9s
         NfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680729811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ldn880u6qacFUyrH9vmOjtrznPDxvGg0ZyTK235BksU=;
        b=N9iE5OdlWi3Up12zJVP6sCbQZ9rPtYMwrGttah79fsEk+rCI2JHflWehGm+jFwHiRr
         ETvynBL9CUtgbSed8sHZgLj3GwxNq1wRY3f4eaLW4wwiTOp/vPrVRpiwdrLg6uYrbo4U
         SQmq85IySsrry1esnSeGoTnw+RbJlJwLeP6IGOoK0z718aNAu7XSWKaYUTJvGYNupD53
         JIg43v+KnTN6S4Lu9UPNifM2eiYv16HtWvLIVv/ZuWyRtxhzUghZ3hOJlPnf1RsroJS3
         mLoUz/ub+TNfxdF2ZCHVJuPOGWNIUcZY4IZCZZxIj1IpANixD9w/qsNH+GWkr13vZKJi
         OLPQ==
X-Gm-Message-State: AAQBX9fTAfgwRwzrKBTT9Qw5C/9K1ofm5XM6KzkUcoruNCyGMN6vRYgR
        IhNvcnl3XvlIl249aNFQNYw=
X-Google-Smtp-Source: AKy350ZJkxFhehZkOyazmIbRRXZWte1By/QrJOYhBrgfgsqaXZl2n9N99pObva7sa7srcfFu7dYVSQ==
X-Received: by 2002:adf:e90a:0:b0:2ce:a828:b248 with SMTP id f10-20020adfe90a000000b002cea828b248mr4768664wrm.71.1680729810681;
        Wed, 05 Apr 2023 14:23:30 -0700 (PDT)
Received: from krava (cpc137424-wilm3-2-0-cust276.1-4.cable.virginm.net. [82.23.5.21])
        by smtp.gmail.com with ESMTPSA id v8-20020a5d4a48000000b002c557f82e27sm15838577wrs.99.2023.04.05.14.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:23:30 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 5 Apr 2023 23:23:27 +0200
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
Subject: Re: [PATCH v2] perf pmu: Make parser reentrant
Message-ID: <ZC3mz+Ge9WGG8/t5@krava>
References: <20230404133630.1985739-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404133630.1985739-1-irogers@google.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 06:36:30AM -0700, Ian Rogers wrote:
> By default bison uses global state for compatibility with yacc. Make
> the parser reentrant so that it may be used in asynchronous and
> multithreaded situations.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.c | 24 ++++++++++++++++++------
>  tools/perf/util/pmu.h |  2 +-
>  tools/perf/util/pmu.l | 17 ++++++++++++-----
>  tools/perf/util/pmu.y |  5 ++++-
>  4 files changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 78a407b42ad1..f603cdabf797 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -24,6 +24,8 @@
>  #include "evsel.h"
>  #include "pmu.h"
>  #include "pmus.h"
> +#include "pmu-bison.h"
> +#include "pmu-flex.h"
>  #include "parse-events.h"
>  #include "print-events.h"
>  #include "header.h"
> @@ -57,9 +59,6 @@ struct perf_pmu_format {
>  	struct list_head list;
>  };
>  
> -int perf_pmu_parse(struct list_head *list, char *name);
> -extern FILE *perf_pmu_in;
> -
>  static bool hybrid_scanned;
>  
>  static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name);
> @@ -81,6 +80,8 @@ int perf_pmu__format_parse(int dirfd, struct list_head *head)
>  	while (!ret && (evt_ent = readdir(format_dir))) {
>  		char *name = evt_ent->d_name;
>  		int fd;
> +		void *scanner;
> +		FILE *file;
>  
>  		if (!strcmp(name, ".") || !strcmp(name, ".."))
>  			continue;
> @@ -91,9 +92,20 @@ int perf_pmu__format_parse(int dirfd, struct list_head *head)
>  		if (fd < 0)
>  			break;
>  
> -		perf_pmu_in = fdopen(fd, "r");
> -		ret = perf_pmu_parse(head, name);
> -		fclose(perf_pmu_in);
> +		file = fdopen(fd, "r");
> +		if (!file)
> +			break;

hum, do we potentially leak fd in here?

jirka

> +
> +		ret = perf_pmu_lex_init(&scanner);
> +		if (ret) {
> +			fclose(file);
> +			break;
> +		}
> +
> +		perf_pmu_set_in(file, scanner);
> +		ret = perf_pmu_parse(head, name, scanner);
> +		perf_pmu_lex_destroy(scanner);
> +		fclose(file);
>  	}
>  
>  	closedir(format_dir);
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 32c3a75bca0e..d53618c65c92 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -206,7 +206,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
>  			  struct perf_pmu_info *info);
>  struct list_head *perf_pmu__alias(struct perf_pmu *pmu,
>  				  struct list_head *head_terms);
> -void perf_pmu_error(struct list_head *list, char *name, char const *msg);
> +void perf_pmu_error(struct list_head *list, char *name, void *scanner, char const *msg);
>  
>  int perf_pmu__new_format(struct list_head *list, char *name,
>  			 int config, unsigned long *bits);
> diff --git a/tools/perf/util/pmu.l b/tools/perf/util/pmu.l
> index 58b4926cfaca..67b247be693b 100644
> --- a/tools/perf/util/pmu.l
> +++ b/tools/perf/util/pmu.l
> @@ -1,4 +1,6 @@
>  %option prefix="perf_pmu_"
> +%option reentrant
> +%option bison-bridge
>  
>  %{
>  #include <stdlib.h>
> @@ -6,16 +8,21 @@
>  #include "pmu.h"
>  #include "pmu-bison.h"
>  
> -static int value(int base)
> +char *perf_pmu_get_text(yyscan_t yyscanner);
> +YYSTYPE *perf_pmu_get_lval(yyscan_t yyscanner);
> +
> +static int value(yyscan_t scanner, int base)
>  {
> +	YYSTYPE *yylval = perf_pmu_get_lval(scanner);
> +	char *text = perf_pmu_get_text(scanner);
>  	long num;
>  
>  	errno = 0;
> -	num = strtoul(perf_pmu_text, NULL, base);
> +	num = strtoul(text, NULL, base);
>  	if (errno)
>  		return PP_ERROR;
>  
> -	perf_pmu_lval.num = num;
> +	yylval->num = num;
>  	return PP_VALUE;
>  }
>  
> @@ -25,7 +32,7 @@ num_dec         [0-9]+
>  
>  %%
>  
> -{num_dec}	{ return value(10); }
> +{num_dec}	{ return value(yyscanner, 10); }
>  config		{ return PP_CONFIG; }
>  -		{ return '-'; }
>  :		{ return ':'; }
> @@ -35,7 +42,7 @@ config		{ return PP_CONFIG; }
>  
>  %%
>  
> -int perf_pmu_wrap(void)
> +int perf_pmu_wrap(void *scanner __maybe_unused)
>  {
>  	return 1;
>  }
> diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
> index e675d79a0274..dff4e892ac4d 100644
> --- a/tools/perf/util/pmu.y
> +++ b/tools/perf/util/pmu.y
> @@ -1,6 +1,8 @@
> -
> +%define api.pure full
>  %parse-param {struct list_head *format}
>  %parse-param {char *name}
> +%parse-param {void *scanner}
> +%lex-param {void* scanner}
>  
>  %{
>  
> @@ -78,6 +80,7 @@ PP_VALUE
>  
>  void perf_pmu_error(struct list_head *list __maybe_unused,
>  		    char *name __maybe_unused,
> +		    void *scanner __maybe_unused,
>  		    char const *msg __maybe_unused)
>  {
>  }
> -- 
> 2.40.0.348.gf938b09366-goog
> 
