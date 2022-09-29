Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203FE5EFC96
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbiI2SCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbiI2SB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:01:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451F9F8C33;
        Thu, 29 Sep 2022 11:01:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D378CB82644;
        Thu, 29 Sep 2022 18:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6624EC433D6;
        Thu, 29 Sep 2022 18:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664474511;
        bh=sdtrTb4RtLjSduzWuAdVTUs/H25+pxGgOlmAJHkDoM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TAy7kJ082HwZTvUn/N28V0K1ldD9o9liP9UxcMjw9D7YQS/I4tBCowKl8vQlOwtsv
         Zg6afldKKP3wOkPbSRZq1qcqeoNwEniZ0GMuUDsAcNQSQLJze5edvmD65G/rgHnpE0
         hmgSooelnjBraArLGFEya8Z4CMQxinfLdpcgk5x1k6UQNlJOl2iMYJD9u7FXsLo1yZ
         V5XqlaQtOcRarcXudvqBKhrdM+3+qvxAnpXlAkr+BhakPTUmhuLNB6kYcUUN5wKT7F
         V3mjmeKjN1SbydT2Y6vjlDfBJdouodp9SEDFmBhJUV1ZSpUC51epB7l6w/2d5F1HbH
         toBmurd261QRw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D1459405F0; Thu, 29 Sep 2022 15:01:48 -0300 (-03)
Date:   Thu, 29 Sep 2022 15:01:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf tools: Fix bison object compilation with clang
 15
Message-ID: <YzXdjNNh+jbYDnYz@kernel.org>
References: <20220929140514.226807-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929140514.226807-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 29, 2022 at 04:05:13PM +0200, Jiri Olsa escreveu:
> Arnaldo reported compilation fail with clang 15:
> 
>     CC      util/parse-events-bison.o
>   util/parse-events-bison.c:1401:9: error: variable 'parse_events_nerrs'
>   set but not used [-Werror,-Wunused-but-set-variable]
>       int yynerrs = 0;
>         ^
>   util/parse-events-bison.c:72:25: note: expanded from macro 'yynerrs'
>   #define yynerrs         parse_events_nerrs
>                         ^
>   1 error generated.
> 
> Disabling -Wunused-but-set-variable check for bison object compilation.

So we have to disable something else:

  37    44.92 fedora:32                     : FAIL clang version 10.0.1 (Fedora 10.0.1-3.fc32)
    error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
    make[3]: *** [/git/perf-6.0.0-rc7/tools/build/Makefile.build:139: util] Error 2
  38    61.77 fedora:33                     : FAIL clang version 11.0.0 (Fedora 11.0.0-3.fc33)
    error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
    make[3]: *** [/git/perf-6.0.0-rc7/tools/build/Makefile.build:139: util] Error 2
  39    66.59 fedora:34                     : FAIL clang version 12.0.1 (Fedora 12.0.1-1.fc34)
    error: unknown warning option '-Wno-unused-but-set-variable'; did you mean '-Wno-unused-const-variable'? [-Werror,-Wunknown-warning-option]
    make[3]: *** [/git/perf-6.0.0-rc7/tools/build/Makefile.build:139: util] Error 2


I'll try yours + -Wno-unknown-warning-option

;-)

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/Build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 8fd6dc8de521..d559c80559e3 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -270,7 +270,7 @@ CFLAGS_expr-flex.o          += $(flex_flags)
>  bison_flags := -DYYENABLE_NLS=0
>  BISON_GE_35 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 35)
>  ifeq ($(BISON_GE_35),1)
> -  bison_flags += -Wno-unused-parameter -Wno-nested-externs -Wno-implicit-function-declaration -Wno-switch-enum
> +  bison_flags += -Wno-unused-parameter -Wno-nested-externs -Wno-implicit-function-declaration -Wno-switch-enum -Wno-unused-but-set-variable
>  else
>    bison_flags += -w
>  endif
> -- 
> 2.37.3

-- 

- Arnaldo
