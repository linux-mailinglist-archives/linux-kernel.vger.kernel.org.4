Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC5C6428EB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiLENDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiLENDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:03:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B2717076;
        Mon,  5 Dec 2022 05:03:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD508B80F79;
        Mon,  5 Dec 2022 13:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C79DC433D6;
        Mon,  5 Dec 2022 13:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670245416;
        bh=Quf8sZ9+qKyYMVb9fzP+lHM/3KdkQrgRIaq463QOEqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mnPeEla3sDLBZSYO61/ydsUn2P/Tr91kbJ+GSZTiOUrs9nA6IwjkQj1QrIUqDwxgr
         E36EfikIxwS3d2OsMWeoY43FguQ+Akvy0RlH3MeXKqqruOoAknH5jljzhr30OKjy02
         PZzq50RMCu0KLCA6472I9kX66T0kDlUSVXG5ylKzdlcTGOiLSRunSNjCjqhdsGpJhY
         iy+BGA7ZfouBBIQGjozOiBCRGfPcbpSu+5OJstmCK7bY/FDpKlpL3t6EYa+wm2jHGc
         V450oEKFy7w78OSDdr3obgQLmM6CSbwTaABz2Y4pDTEse7NR68OCMH9fZ7BbMP4gwE
         puqaRHd3bRSrA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4B26940404; Mon,  5 Dec 2022 10:03:34 -0300 (-03)
Date:   Mon, 5 Dec 2022 10:03:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Wang, Weilin" <weilin.wang@intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf stat: Fix multi-line metric output in JSON
Message-ID: <Y43sJkk79WMbg8Eq@kernel.org>
References: <20221202190447.1588680-1-namhyung@kernel.org>
 <CO6PR11MB5635C3BB62A1B9FA532DF57BEE179@CO6PR11MB5635.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO6PR11MB5635C3BB62A1B9FA532DF57BEE179@CO6PR11MB5635.namprd11.prod.outlook.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 02, 2022 at 07:31:59PM +0000, Wang, Weilin escreveu:
> Namhyung, it works. Thanks!

Thanks, applied and added a Tested-by: Weilin, ok?

- Arnaldo
 
> -----Original Message-----
> From: Namhyung Kim <namhyung@gmail.com> On Behalf Of Namhyung Kim
> Sent: Friday, December 2, 2022 11:05 AM
> To: Arnaldo Carvalho de Melo <acme@kernel.org>; Jiri Olsa <jolsa@kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>; Peter Zijlstra <peterz@infradead.org>; LKML <linux-kernel@vger.kernel.org>; Ian Rogers <irogers@google.com>; Hunter, Adrian <adrian.hunter@intel.com>; linux-perf-users@vger.kernel.org; Kan Liang <kan.liang@linux.intel.com>; Zhengjun Xing <zhengjun.xing@linux.intel.com>; James Clark <james.clark@arm.com>; Athira Jajeev <atrajeev@linux.vnet.ibm.com>; Wang, Weilin <weilin.wang@intel.com>
> Subject: [PATCH] perf stat: Fix multi-line metric output in JSON
> 
> When a metric produces more than one values, it missed to print the opening bracket.
> 
> Fixes: ab6baaae2735 ("perf stat: Fix JSON output in metric-only mode")
> Reported-by: "Wang, Weilin" <weilin.wang@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> Weilin, could you please verify it fixes your problem?
> 
>  tools/perf/util/stat-display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c index f1ee4b052198..8d0bdd57163d 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -440,7 +440,7 @@ static void new_line_json(struct perf_stat_config *config, void *ctx)  {
>  	struct outstate *os = ctx;
>  
> -	fputc('\n', os->fh);
> +	fputs("\n{", os->fh);
>  	if (os->prefix)
>  		fprintf(os->fh, "%s", os->prefix);
>  	aggr_printout(config, os->evsel, os->id, os->nr);
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog

-- 

- Arnaldo
