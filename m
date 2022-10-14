Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CEF5FEEEE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJNNsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJNNsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:48:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437EEEF595;
        Fri, 14 Oct 2022 06:48:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2272B82344;
        Fri, 14 Oct 2022 13:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845B0C433C1;
        Fri, 14 Oct 2022 13:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665755284;
        bh=YYPGXz+kZpqM731XLG6uYx/TCI9VSrSu6+9Z/EJkJGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=McY7EfHPgxKnbYegMD3R8tvHdi0R+2GUFTbfwQiBFtLdF6Z9R3lnwsujTCUFuSFzP
         p4YE02yBV8dBGtOJ8YQte+xElZkyrwv/rS/q658wLWUD2cD0btAJaIGgUsNbwQWHRu
         q9wmJzpw1ab2M+PM7jufA/6lQ5V+LKBHIlVXTRdiJsPgbSltA33nPgbYYigEAPOSoC
         kLvNO/UbSdnkoodYNTtrB4XaVA//Uti1nmVOQCXRq4RWxHgAphlbgBkW5+olBBuuSU
         NOCZ4ivF85lyr0hJ+O/EPv1L8jCHK5qm3hIOK4UWOZNl45mKy0t8kcylqG5usT/3iJ
         lSDi8dx7GpQBw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 736694062C; Fri, 14 Oct 2022 10:48:02 -0300 (-03)
Date:   Fri, 14 Oct 2022 10:48:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Kevin Nomura <nomurak@google.com>
Subject: Re: [PATCH] perf annotate: Add missing condition flags for arm64
Message-ID: <Y0lokt9TTbWHLWmT@kernel.org>
References: <20221006222232.266416-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006222232.266416-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 06, 2022 at 03:22:32PM -0700, Namhyung Kim escreveu:
> According to the document [1], it can also have 'hs', 'lo', 'vc', 'vs' as a
> condition code.  Let's add them too.
> 
> [1] https://community.arm.com/arm-community-blogs/b/architectures-and-processors-blog/posts/condition-codes-1-condition-flags-and-codes

Thanks, applied.

- Arnaldo

 
> Reported-by: Kevin Nomura <nomurak@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/arch/arm64/annotate/instructions.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
> index 037e292ecd8e..4af0c3a0f86e 100644
> --- a/tools/perf/arch/arm64/annotate/instructions.c
> +++ b/tools/perf/arch/arm64/annotate/instructions.c
> @@ -102,7 +102,7 @@ static int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
>  	if (err)
>  		goto out_free_arm;
>  	/* b, b.cond, br, cbz/cbnz, tbz/tbnz */
> -	err = regcomp(&arm->jump_insn, "^[ct]?br?\\.?(cc|cs|eq|ge|gt|hi|le|ls|lt|mi|ne|pl)?n?z?$",
> +	err = regcomp(&arm->jump_insn, "^[ct]?br?\\.?(cc|cs|eq|ge|gt|hi|hs|le|lo|ls|lt|mi|ne|pl|vc|vs)?n?z?$",
>  		      REG_EXTENDED);
>  	if (err)
>  		goto out_free_call;
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog

-- 

- Arnaldo
