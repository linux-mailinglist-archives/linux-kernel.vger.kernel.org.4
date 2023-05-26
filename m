Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9552F712C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjEZSTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjEZSTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:19:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B82B12A;
        Fri, 26 May 2023 11:19:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11CF365227;
        Fri, 26 May 2023 18:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D606C433EF;
        Fri, 26 May 2023 18:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685125178;
        bh=b2wS80YPkzQW4CpsgVgq7KlFFeGgYaSeAXgGy9lqXqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g638a1nPAVGC0LYAG40S+1aLo38wyF3a8ds9brIOTpXc8qO+WXLs7flH+oKsNANoE
         mZf7GDhdpRjWOdQvgbznH4JjkdljbIBfb4tkjrgxW4w5q+dss5Z0O06DuEzlMkeIxe
         q/Woe4elReF/TZd1MKYSXrKD/IdBR809uTT0eytHX1EVHJRR87TBg6p0RC7bvrMnH9
         p9ZPJM+HOuoWisEA16VIqmPUTLbD6ktELjeU1hnb1bJQ2xJEf8+csHcG5mSYY0xbJ2
         Ago3H4hNcZMxaMce0InWjXp8G2fpHChLkJ+XKXGS37gg86BHWbUzSDQuwDrXq1f39e
         k28lU4O+fCkDA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B9454403B5; Fri, 26 May 2023 15:19:35 -0300 (-03)
Date:   Fri, 26 May 2023 15:19:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Changbin Du <changbin.du@huawei.com>
Subject: Re: [PATCH] perf ftrace latency: Remove unnecessary "--" from
 --use-nsec option
Message-ID: <ZHD4N91c0evhwfMf@kernel.org>
References: <20230525212038.3535851-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525212038.3535851-1-namhyung@kernel.org>
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

Em Thu, May 25, 2023 at 02:20:38PM -0700, Namhyung Kim escreveu:
> The option name should not have the dashes.  Current version shows four
> dashes for the option.
> 
>   $ perf ftrace latency -h
> 
>    Usage: perf ftrace [<options>] [<command>]
>       or: perf ftrace [<options>] -- [<command>] [<options>]
>       or: perf ftrace {trace|latency} [<options>] [<command>]
>       or: perf ftrace {trace|latency} [<options>] -- [<command>] [<options>]
> 
>       -b, --use-bpf         Use BPF to measure function latency
>       -n, ----use-nsec      Use nano-second histogram
>       -T, --trace-funcs <func>
>                             Show latency of given function

Thanks, applied.

- Arnaldo

 
> Fixes: 84005bb61486 ("perf ftrace latency: Add -n/--use-nsec option")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index ad2a9ae041f6..ac2e6c75f912 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -1177,7 +1177,7 @@ int cmd_ftrace(int argc, const char **argv)
>  	OPT_BOOLEAN('b', "use-bpf", &ftrace.target.use_bpf,
>  		    "Use BPF to measure function latency"),
>  #endif
> -	OPT_BOOLEAN('n', "--use-nsec", &ftrace.use_nsec,
> +	OPT_BOOLEAN('n', "use-nsec", &ftrace.use_nsec,
>  		    "Use nano-second histogram"),
>  	OPT_PARENT(common_options),
>  	};
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog
> 

-- 

- Arnaldo
