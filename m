Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521836E9B59
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjDTSM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjDTSM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:12:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF1E3A90;
        Thu, 20 Apr 2023 11:12:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D9C264B1A;
        Thu, 20 Apr 2023 18:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E57C433EF;
        Thu, 20 Apr 2023 18:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682014376;
        bh=kSvkn/SMAUuZevGgkbpWRmpLNf69JWrO4HhG5l/4Agk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iahBDf7ycPKPY4r29MIYUpHmLKJ1iqx/zYUO/mIDTMbXuScnzk5Z6b4aFpzUA662a
         +mDeAIIx2q3lcV0EDdZybGO0Shy83bIu98ETLr0BZBSs96A5vgrfvpqXgxVfiy7tBU
         WxqTsvmXj/psTjENshC0xfrIhC+O6OnRMOCNvDwAK0EeRnztYs0Wjp7C3o6LsTpeu8
         /1gSRmRbJ1382oXGbxbeANDMzZhFgn4wvfmgQmJkadgH42iS6fP5ofccByaLBscELx
         mVEjhXfsLNrr1cNgOndb+7WealwP85YQjQkuqBuYNl1daC4p2VytwScD5FRj9F9doC
         o9kwsM8ahdT6g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1378D403B5; Thu, 20 Apr 2023 15:12:53 -0300 (-03)
Date:   Thu, 20 Apr 2023 15:12:52 -0300
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
Subject: Re: [PATCH v1] libperf rc_check: Enable implicitly with sanitizers
Message-ID: <ZEGApFbdz44z9GeX@kernel.org>
References: <20230420171812.561603-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420171812.561603-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 20, 2023 at 10:18:12AM -0700, Ian Rogers escreveu:
> If using leak sanitizer then implicitly enable reference count
> checking.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/include/internal/rc_check.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/lib/perf/include/internal/rc_check.h b/tools/lib/perf/include/internal/rc_check.h
> index c0626d8beb59..d5d771ccdc7b 100644
> --- a/tools/lib/perf/include/internal/rc_check.h
> +++ b/tools/lib/perf/include/internal/rc_check.h
> @@ -5,6 +5,14 @@
>  #include <stdlib.h>
>  #include <linux/zalloc.h>
>  
> +/*
> + * Enable reference count checking implicitly with leak checking, which is
> + * integrated into address sanitizer.
> + */
> +#if defined(LEAK_SANITIZER) || defined(ADDRESS_SANITIZER)
> +#define REFCNT_CHECKING 1
> +#endif
> +
>  /*
>   * Shared reference count checking macros.
>   *
> -- 
> 2.40.0.634.g4ca3ef3211-goog
> 

-- 

- Arnaldo
