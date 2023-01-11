Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059B9665C43
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjAKNQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjAKNQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:16:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879CA60EE;
        Wed, 11 Jan 2023 05:16:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AE25B81BE6;
        Wed, 11 Jan 2023 13:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CE7C433EF;
        Wed, 11 Jan 2023 13:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673443001;
        bh=xHtzKMNO2jMg6JzWjhGA9a6by3sdnOw4VBI0pKdU8G4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Llgr4Hj/Pxyak6ZPTgMGr0SXsUu6sI07GwbRGOlBrwJIDt6558hUGvA4a9gRRecZS
         QSOUZdWEXAuX4NWx+uHSktAOtTSCl4H2/tn4BME9/dpOnOZDOnX8Ud5btNjv2C8PiA
         ZtMf0gzqtNXD6dOP/gSyrMwijSIOJmfYpLmwU7SmMQ1cr6PSvHQfQvdhO3rPvzEPNI
         xsPlcmyABOQ7MzGGA+uVc3kndK6BuRiDVxG/FG88J1yAIXHTKQW1fGNZ1Fdakg77/V
         8sB3W77lWdDlmNNuhBFjsByt1Z4C56MIr3jKXGIXsG7zrWzvxmyAlkgj1m4YVkJ/Yr
         LxtA/ghwSeFGw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4B53E40468; Wed, 11 Jan 2023 10:16:39 -0300 (-03)
Date:   Wed, 11 Jan 2023 10:16:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Dmitry Dolgov <9erthalion6@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf auxtrace: Fix address filter duplicate symbol
 selection
Message-ID: <Y762t7QWEKPYRFC4@kernel.org>
References: <20230110185659.15979-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110185659.15979-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 10, 2023 at 08:56:59PM +0200, Adrian Hunter escreveu:
>   After:
> 
>     $ perf record -e intel_pt//u --filter 'filter func #2 @ ./test' -- ./test
>     First func
>     Second func
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.016 MB perf.data ]
>     $ perf script --itrace=b -Ftime,flags,ip,sym,addr --ns
>     1231062.526977619:   tr strt                               0 [unknown] =>     558495708179 func
>     1231062.526977619:   tr end  call               558495708188 func =>     558495708050 _init
>     1231062.526979286:   tr strt                               0 [unknown] =>     55849570818d func
>     1231062.526979286:   tr end  return             55849570818f func =>     55849570819d other
> 
> Reported-by: Dmitry Dolgov <9erthalion6@gmail.com>
> Fixes: 1b36c03e3569 ("perf record: Add support for using symbols in address filters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

Dmitry, can I have your Tested-by? Checking the original thread...

- Arnaldo

> ---
>  tools/perf/util/auxtrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 265d20cc126b..c2e323cd7d49 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -2611,7 +2611,7 @@ static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
>  				*size = sym->start - *start;
>  			if (idx > 0) {
>  				if (*size)
> -					return 1;
> +					return 0;
>  			} else if (dso_sym_match(sym, sym_name, &cnt, idx)) {
>  				print_duplicate_syms(dso, sym_name);
>  				return -EINVAL;
> -- 
> 2.34.1
