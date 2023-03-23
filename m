Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522306C68E2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjCWMyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjCWMyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:54:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84853C13;
        Thu, 23 Mar 2023 05:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 75B75B820F7;
        Thu, 23 Mar 2023 12:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF456C433D2;
        Thu, 23 Mar 2023 12:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679576045;
        bh=74vUZPMQHOoEjR07bQmZxQ/fDJUK+fLucEjzk1+Z3zM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pvlOJwd1TMVHQC66g2ssOpeFbVXYCWhaVrsxtN7G8VlPcyhi91bPCQ7oiml8xpZoN
         2QNaRENWK7lVVa3zeuAhCJHlMVEvnsoQyDaDTDk8wtMTdYmDJxr7Tki363Fx3P/cDd
         EBNSOSKKQFTH8fFaBKtEkFwQCf4pkTQR0hL2jwfakZ6LURqn+Mupv3DS08eas4/x9E
         JkfCbXxqTElxB9jKSnnXdACGyEHbOQsBmaH2pBy3yPcI7K0LutGNUGFZh9OKr95Idd
         VP4Rt5xheGoORkuAq41AFqTKXSKjX2QhLDvSIQ+5iEItxLcZ176WMJfkeEGLwdk6OG
         IbxRZ4VRc/GEg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 30EB34052D; Thu, 23 Mar 2023 09:54:02 -0300 (-03)
Date:   Thu, 23 Mar 2023 09:54:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf hist: Improve srcfile sort key performance (really)
Message-ID: <ZBxL6nfhW/gwixx8@kernel.org>
References: <20230323025005.191239-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323025005.191239-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 22, 2023 at 07:50:05PM -0700, Namhyung Kim escreveu:
> The earlier commit f0cdde28fecc ("perf hist: Improve srcfile sort key
> performance") updated the srcfile logic but missed to change the ->cmp()
> callback which is called for every sample.  It should use the same logic
> like in the srcline to speed up the processing because it'd return the
> same information repeatedly for the same address.  The real processing
> will be done in sort__srcfile_collapse().

Thanks, applied.

- Arnaldo

 
> Fixes: pf0cdde28fecc ("perf hist: Improve srcfile sort key performance")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/sort.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index e11e68ecf0a2..2b5cc8e4aa6e 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -657,12 +657,7 @@ static char *hist_entry__get_srcfile(struct hist_entry *e)
>  static int64_t
>  sort__srcfile_cmp(struct hist_entry *left, struct hist_entry *right)
>  {
> -	if (!left->srcfile)
> -		left->srcfile = hist_entry__get_srcfile(left);
> -	if (!right->srcfile)
> -		right->srcfile = hist_entry__get_srcfile(right);
> -
> -	return strcmp(right->srcfile, left->srcfile);
> +	return sort__srcline_cmp(left, right);
>  }
>  
>  static int64_t
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 

-- 

- Arnaldo
