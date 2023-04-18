Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB356E680A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjDRP0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjDRP0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2611F13F83;
        Tue, 18 Apr 2023 08:26:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B610A635D0;
        Tue, 18 Apr 2023 15:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09D4C433EF;
        Tue, 18 Apr 2023 15:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681831568;
        bh=3D8Pa3erTkp9cKyukAUmfiAfX+D6cPFyYo1IyB4VYsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vobw8tftxLbNaE+3MzVTaI1eiuNb5OeSX2m8iSPINoQGSVG7xhf+jL7v0ukpNT6Gp
         IPVVPjmSp8zkzg/Vk7JX5QTypT0xzoH4qGE96LuFRHQfmsVXATGmmyGDkwBghPpctk
         cMXlnpI2uGEytU6NxiBl1fy6vhZljsvksM9wXidScyHUJL3z7uEU2uvclAj1eTAXh2
         iUJF+xcFgD4JuUp/URvZbSMmym6mbMSZfS3bFOGUMP6/YWZovVla+aWeb6pCBUrdOA
         ZFILn+CCFLGqLLi6qezml25EdGvsiufoJHqjh39fg9VwKhjnsq/OetEHBp4kRFzCM5
         hGcvF4z1IF99Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EFA67403B5; Tue, 18 Apr 2023 12:26:04 -0300 (-03)
Date:   Tue, 18 Apr 2023 12:26:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: cs-etm: Fix segfault in dso lookup
Message-ID: <ZD62jJiGaKmqcWom@kernel.org>
References: <20230418141203.673465-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418141203.673465-1-james.clark@arm.com>
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

Em Tue, Apr 18, 2023 at 03:12:03PM +0100, James Clark escreveu:
> map__dso() is called before thread__find_map() which always results in a
> null pointer dereference. Fix it by finding first, then checking if it
> exists.
> 
> Fixes: 63df0e4bc368 ("perf map: Add accessor for dso")

Thanks, applied, checking if another such pattern slipped by in that
cset.

- Arnaldo

> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 103865968700..8dd81ddd9e4e 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -885,9 +885,11 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
>  		thread = etmq->etm->unknown_thread;
>  	}
>  
> -	dso = map__dso(al.map);
> +	if (!thread__find_map(thread, cpumode, address, &al))
> +		return 0;
>  
> -	if (!thread__find_map(thread, cpumode, address, &al) || !dso)
> +	dso = map__dso(al.map);
> +	if (!dso)
>  		return 0;
>  
>  	if (dso->data.status == DSO_DATA_STATUS_ERROR &&
> -- 
> 2.34.1
> 

-- 

- Arnaldo
