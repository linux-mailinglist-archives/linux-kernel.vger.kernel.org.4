Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C7F6DA4D7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbjDFVmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjDFVl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:41:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C78E86A6;
        Thu,  6 Apr 2023 14:41:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so24415979wms.1;
        Thu, 06 Apr 2023 14:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680817315; x=1683409315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=12/NsLYM3w+hYEV/hYhYVp4yChlBWZXqD12DXOr1omk=;
        b=kbC+57eAmTDzG16/gFqBedU1gTreFSq5CkaY3rgS9Cw4/qHZNhHrjz1THQ2561HOYo
         dugwUtKFTqH4OOqUEIZHLC7hA6kWNpEcZ1eoR4X4TjqXVoneXUsGOreMcJg3OwbJdGmv
         Ytd2VHmnCeSQeK3Nqb/GRm1au7YdajeLLs3RMPNddVZWQNu2RIkQ4caZ5szpwcCr6ZUW
         HIWDHMuIiEQDxUliFbVPt/un7RM8nlHp1JgjMDU4mTHskK7COJBYAcf7r69j++vyQFbY
         5N7IZJf4/pYGf/2fb+YOKeY5iPlVAmN5SkRcR0ZuC198sy/6EdY93WUQSiVR2QKcy7id
         dCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680817315; x=1683409315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12/NsLYM3w+hYEV/hYhYVp4yChlBWZXqD12DXOr1omk=;
        b=D73D2NsUwMwrs1so2mdrjBXpE+4AUDhcq8BkNICAOTb5O8IIXVOO1MMoJXgkljTfN3
         0ljyaTZmP9IepC+qPz7qvf7YYXT6yEn0cO3mQRr3DPZ5Xw6UM1kiL71DoS0oon2C3ENc
         cYHPRvBy8Ma79b9NtS+Jd1aCRdwsJoPn5ReHTrQWLiqhNIW3PPgGdRQAXgI1PxBg4HCD
         E3MfcQn6veyT+nQXdYwyXttH6138Cur0zD4Pjt+hg+lFEgBMFUzZ4YGvOOz5NsdvjbZQ
         hZcqnv9d508O5QkmBUgzr8fDdCxUQUgBIcvDVEYAlnToI6a1onBmqZTivq2uKyNT0fxo
         pw/Q==
X-Gm-Message-State: AAQBX9dcwbvA8YnQgfCUHeCU7MRJ6nZg+jXTAL9KeWTSMUXurVDNDP88
        GKN6r45WXqd6dEVib9t/L3k=
X-Google-Smtp-Source: AKy350bpssoHLia6IhF7lZ+isx/e3ZRv9rqCbUtWcDAaBodYNs8j07GNWsSOBjPmmAtN+z7KICZdSg==
X-Received: by 2002:a7b:c41a:0:b0:3f0:4428:94fa with SMTP id k26-20020a7bc41a000000b003f0442894famr8069688wmi.26.1680817314874;
        Thu, 06 Apr 2023 14:41:54 -0700 (PDT)
Received: from krava (85-160-61-129.reb.o2.cz. [85.160.61.129])
        by smtp.gmail.com with ESMTPSA id s14-20020a1cf20e000000b003f04785699asm2580386wmc.43.2023.04.06.14.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:41:54 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 6 Apr 2023 22:41:50 +0100
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
Subject: Re: [PATCH v3 1/2] perf pmu: Make parser reentrant
Message-ID: <ZC88niOWJ+b4ka4q@krava>
References: <20230406065224.2553640-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406065224.2553640-1-irogers@google.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 11:52:23PM -0700, Ian Rogers wrote:
> By default bison uses global state for compatibility with yacc. Make
> the parser reentrant so that it may be used in asynchronous and
> multithreaded situations.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/perf/util/pmu.c | 26 ++++++++++++++++++++------
>  tools/perf/util/pmu.h |  2 +-
>  tools/perf/util/pmu.l | 17 ++++++++++++-----
>  tools/perf/util/pmu.y |  5 ++++-
>  4 files changed, 37 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 78a407b42ad1..96ef317bac41 100644
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
> @@ -91,9 +92,22 @@ int perf_pmu__format_parse(int dirfd, struct list_head *head)
>  		if (fd < 0)
>  			break;
>  
> -		perf_pmu_in = fdopen(fd, "r");
> -		ret = perf_pmu_parse(head, name);
> -		fclose(perf_pmu_in);
> +		file = fdopen(fd, "r");
> +		if (!file) {
> +			close(fd);
> +			break;
> +		}
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
