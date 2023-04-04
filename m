Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC0A6D59CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjDDHim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbjDDHii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:38:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67CCE4B;
        Tue,  4 Apr 2023 00:38:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m8so7487892wmq.5;
        Tue, 04 Apr 2023 00:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680593915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7OPjciRLwMHzrpkP/JLZ5TGhptBRPIPredzioRJHX4w=;
        b=LjG87Qf/LusnAHBQcLt5iMm6daTkauyUVhbkTevUU2bCOCGeF6Cy0OjbfKgxdZxRUO
         RCSG4vzFOYTb2nueOxQQxahtcXkvG3gBNqMk/rOFWxGMhtUUPX9Xmin9n6AHg25ktzOf
         8Tvc1QMdjwslm8a69pTd0JI7l2zIP+HPBoEKtjCa5xWhf5O7tOMW/HIfWVBhkTwOR0Qk
         FlSVYoOde7vPhhlfKsorcGjPGrEXrVSehb66hePZIsft0DcG1/zWc8C9xerBdqBOv3+C
         z9RrB+FWaOsEXT8IODgtD5PjwxPSzQxDWzT5HXR5f2WEBV9NKhBVp/ujeIbz4d9CllgS
         EeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680593915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OPjciRLwMHzrpkP/JLZ5TGhptBRPIPredzioRJHX4w=;
        b=efpib6afSQuxDHJdAteiyCEM/p5X4c+YE7JVqtcFX9cEDwL/T0p7u4gLzClwSu7rEh
         zjc3Sm0gN1okewst9lSuR48Oejc46azsiKfZxXbK3m5+Cfb+w3XQC3xeihdpoLbM6sQA
         win3U4Wh4mblvPPi41Hwx7z9OUuohTHm8h/EU8LNATdoS5DLZiSXxN99QiQC3LTlyFHN
         tzRwU3Ri/QYPuaU+2wfQzAxicnMqD8K0wuWJkSI6mhJTRwr/pWwjrf1f/DSQDyjdJMzN
         wiBqDuaop67Pg3fjCE0vFxqhSVZZMno0bkRG/lCk6QUGWuUCFEU4b6zF4OINYpvwO83k
         YaTQ==
X-Gm-Message-State: AAQBX9cZBw/XFgtT9n0KGczsUb2IC/HxS/00Dto/dw8HL28ADiWSr9uD
        0D72faQMZgf4fKCf18eIUuM=
X-Google-Smtp-Source: AKy350ZCV2nvTnoQCtczvrkw2U3Z7onC+yh+07G2gg9mYBNEeEPGmnKtZ+BTSVktI7Jsmk9vk3O2cQ==
X-Received: by 2002:a05:600c:2285:b0:3ed:29db:cb80 with SMTP id 5-20020a05600c228500b003ed29dbcb80mr1458974wmf.18.1680593915096;
        Tue, 04 Apr 2023 00:38:35 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id g19-20020a05600c311300b003ee74c25f12sm21534994wmo.35.2023.04.04.00.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 00:38:34 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 4 Apr 2023 09:38:32 +0200
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
Subject: Re: [PATCH v1] perf pmu: Make parser reentrant
Message-ID: <ZCvT+OvZKQqsw8mh@krava>
References: <20230403172031.1759781-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403172031.1759781-1-irogers@google.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 10:20:31AM -0700, Ian Rogers wrote:
> By default bison uses global state for compatibility with yacc. Make
> the parser reentrant so that it may be used in asynchronous and
> multithreaded situations.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/perf/util/pmu.c | 17 ++++++++++++-----
>  tools/perf/util/pmu.h |  2 +-
>  tools/perf/util/pmu.l | 17 ++++++++++++-----
>  tools/perf/util/pmu.y |  5 ++++-
>  4 files changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index e3aae731bd6f..8ef2532428a4 100644
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
>  /*
> @@ -79,6 +78,7 @@ int perf_pmu__format_parse(char *dir, struct list_head *head)
>  	while (!ret && (evt_ent = readdir(format_dir))) {
>  		char path[PATH_MAX];
>  		char *name = evt_ent->d_name;
> +		void *scanner;
>  		FILE *file;
>  
>  		if (!strcmp(name, ".") || !strcmp(name, ".."))
> @@ -91,8 +91,15 @@ int perf_pmu__format_parse(char *dir, struct list_head *head)
>  		if (!file)
>  			break;
>  
> -		perf_pmu_in = file;
> -		ret = perf_pmu_parse(head, name);
> +		ret = perf_pmu_lex_init(&scanner);
> +		if (ret) {
> +			fclose(file);
> +			break;
> +		}
> +
> +		perf_pmu_set_in(file, scanner);
> +		ret = perf_pmu_parse(head, name, scanner);
> +		perf_pmu_lex_destroy(scanner);
>  		fclose(file);
>  	}
>  
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 24cf69ab32cd..52c37081c880 100644
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
