Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FE76EA346
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 07:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjDUFkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 01:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjDUFkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 01:40:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2F47292;
        Thu, 20 Apr 2023 22:40:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4628B64DCD;
        Fri, 21 Apr 2023 05:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7446C4339C;
        Fri, 21 Apr 2023 05:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682055635;
        bh=M5M/84wJ102EZzlCNXdeHtj/B8Nov0EqFzrTbhj2LpI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l9KXnGz9I2FBW1pPeHghs9UlH+ZRqkPbYvxbBac4bt6GC/cm+h/xM+d4E6/dFyWpx
         0iXdlcjnm3kFSak3PmA/N2elIQrhWZSfmRCo1sKgrnjrY1m64LHaxEkPD8oEWG/7vB
         aC7sRETA2dh/l6Okqy7CeZeViBadjHS4p+HhxC3T3XqffLlMRdEHV0OZhBimOzXmpP
         8Vil/R0jjBmIHl7W3z5B1BxL4Xlh6LQ0RXsTbZmktj938ywvZTurARMnuBLRysgRw2
         xkm61JfnU3L2UPAQXq4XRjpze6dB2gYnvCHWev6c3T8wTCdSCx5zg9rWOzit9Jq/Tc
         alUXSTFhaqGWA==
Date:   Fri, 21 Apr 2023 14:40:31 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     arnaldo.melo@gmail.com
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf probe: Add missing 0x prefix for addresses
 printed in hexadecimal
Message-Id: <20230421144031.e79742e0907a39f86175d13f@kernel.org>
In-Reply-To: <ZEBCyFu2GjTw6qOi@kernel.org>
References: <ZEBCyFu2GjTw6qOi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023 16:36:40 -0300
arnaldo.melo@gmail.com wrote:

> Hi Masami,
> 
> 	I'm carrying this one in my tree, FYI.

Thanks! this looks good to me!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> - Arnaldo
> 
> ---
> 
> To fix this confusing warning:
> 
>   # perf probe -l
>   Failed to find debug information for address 798240
>     probe_main:prometheus_new_counter__return (on github.com/prometheus/client_golang/prometheus.NewCounter%return in /home/acme/git/prometheus-uprobes/main with counter)
>   #
> 
> As that 798240 is printed with PRIx64 but has no letters, better print
> the 0x prefix to disambiguate.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/probe-finder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 54b49ce85c9f2214..f171360b0ef4db06 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -1729,7 +1729,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
>  		addr += baseaddr;
>  	/* Find cu die */
>  	if (!dwarf_addrdie(dbg->dbg, (Dwarf_Addr)addr, &cudie)) {
> -		pr_warning("Failed to find debug information for address %" PRIx64 "\n",
> +		pr_warning("Failed to find debug information for address %#" PRIx64 "\n",
>  			   addr);
>  		ret = -EINVAL;
>  		goto end;
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
