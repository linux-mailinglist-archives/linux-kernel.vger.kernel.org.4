Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05DF6A845A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCBOps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCBOpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:45:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F5C3E626;
        Thu,  2 Mar 2023 06:45:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B8CAB8122A;
        Thu,  2 Mar 2023 14:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF57C433D2;
        Thu,  2 Mar 2023 14:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677768342;
        bh=Cdp+fzAk3TXRE5mc3Ioe3GgwQcA8HQfOrkZ9V3g4Kpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mk80df8L8TkuG0GIllo9Olh/po96Ww5tPU5YvaD4EMB1os67PKP6XgAZOpIdUKhAC
         q6Zf1iQr34m1lyVM2LJWoRYtibPKfOsrCt9JbalEksPsggYPB6Cqr7XZZVoHzjbdAt
         5OeW2XjGR6N45ufHWEr6asv3+Z15ceJkMfQzlmIM6qGvBu9REHb8e4AKm1bd+7NcbV
         3nfbDTbeeC9AhSU7yWTAK03CBg9OE/EnWjSDG3SOyjSSxV+zBSElZ1rrTbOE4cNlY5
         wX/csEkDusJ/JyOhbw9tb9DrhLP5xePAcqEjvPzI1f2SFnP4F8Ji9TkrrJI68wexJ1
         vegt4KvdAAcTg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D429A4049F; Thu,  2 Mar 2023 11:45:39 -0300 (-03)
Date:   Thu, 2 Mar 2023 11:45:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Qi Liu <liuqi115@huawei.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 08/10] perf parse-events: Pass ownership of the group
 name
Message-ID: <ZAC2k4I8rEPQWL/o@kernel.org>
References: <20230302041211.852330-1-irogers@google.com>
 <20230302041211.852330-9-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302041211.852330-9-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 01, 2023 at 08:12:09PM -0800, Ian Rogers escreveu:
> Pass ownership of the group name rather than copying and freeing the
> original. This saves a memory allocation and copy.

Looks ok.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 3 ++-
>  tools/perf/util/parse-events.y | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 0336ff27c15f..1be454697d57 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1761,6 +1761,7 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
>  
>  handled:
>  	ret = 1;
> +	free(name);
>  out:
>  	free(leaders);
>  	return ret;
> @@ -1786,7 +1787,7 @@ void parse_events__set_leader(char *name, struct list_head *list,
>  
>  	leader = arch_evlist__leader(list);
>  	__perf_evlist__set_leader(list, &leader->core);
> -	leader->group_name = name ? strdup(name) : NULL;
> +	leader->group_name = name;
>  	list_move(&leader->core.node, list);
>  }
>  
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index be8c51770051..541b8dde2063 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -202,8 +202,8 @@ PE_NAME '{' events '}'
>  	struct list_head *list = $3;
>  
>  	inc_group_count(list, _parse_state);
> +	/* Takes ownership of $1. */
>  	parse_events__set_leader($1, list, _parse_state);
> -	free($1);
>  	$$ = list;
>  }
>  |
> -- 
> 2.39.2.722.g9855ee24e9-goog
> 

-- 

- Arnaldo
