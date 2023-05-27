Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217E67134BE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 14:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjE0Mfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 08:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjE0Mf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 08:35:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6F513A;
        Sat, 27 May 2023 05:35:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 440B660DBE;
        Sat, 27 May 2023 12:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65450C433D2;
        Sat, 27 May 2023 12:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685190927;
        bh=js6LGopjUheshK4auos228wokZdaK4GmKyfreeHm0qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JqWGZPUx6lrzf9XR7f/e5VD2cX2lmHKBBEizcfgYWYEaEt827ZOA/s4mB7WpLPIce
         Umc6C62viFRGoSsmn+y4hLX3r+PolUnx+GU5Z6Ls24nBaUfirYE3edi4fh8Xcsjr6M
         nYnHTThO/yQXVfjiqvzIpVKH6lTmQEa9nkOHRGQIE+QKJu5fwwAb530Yk3TxOzdHaQ
         AjZ94Xz3Hs8Wu7jXbDtIZ3SURWd7Waqs2P+x9pOemOh9NClz+1tgIAeb5N0olruQ88
         dNzlwYOnbrdMu/5Wu8DJz7skRKo2bmbegxqc1r63r6hoKIJUw9g+7gX531qH/xcScl
         R7WcqI6B6jWIA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9BA02403B5; Sat, 27 May 2023 09:35:24 -0300 (-03)
Date:   Sat, 27 May 2023 09:35:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test python: Put perf python at start of sys.path
Message-ID: <ZHH5DKnjYGCo/LRJ@kernel.org>
References: <20230527055517.2711487-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527055517.2711487-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 26, 2023 at 10:55:17PM -0700, Ian Rogers escreveu:
> This avoids picking up a system installed version of the perf python module.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/python-use.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.c
> index 6b990ee38575..0ebc22ac8d5b 100644
> --- a/tools/perf/tests/python-use.c
> +++ b/tools/perf/tests/python-use.c
> @@ -14,7 +14,7 @@ static int test__python_use(struct test_suite *test __maybe_unused, int subtest
>  	char *cmd;
>  	int ret;
>  
> -	if (asprintf(&cmd, "echo \"import sys ; sys.path.append('%s'); import perf\" | %s %s",
> +	if (asprintf(&cmd, "echo \"import sys ; sys.path.insert(0, '%s'); import perf\" | %s %s",
>  		     PYTHONPATH, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
>  		return -1;
>  
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog
> 

-- 

- Arnaldo
