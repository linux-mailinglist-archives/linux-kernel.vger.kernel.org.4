Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573DA712CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbjEZTDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242443AbjEZTDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:03:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34570194
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:03:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8657652B8
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 19:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0567EC433EF;
        Fri, 26 May 2023 19:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685127792;
        bh=ZjvhPKQtUcTX4Xt9wF63i/QsPv/6OBrkIE4KUZ6R8yI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tnzUp+ZW3g1hkfAPJWNn86Lnl+kz0PQAyFUbCionkP+Ig+yiZjxUPx64p+CF6KvR1
         SFZzs/4l3QInegkeSovNyu4egjcmnlrMKklUhBkPhiOXFcoJNKa33z6B7ml8NIcw4G
         T2pzTf4ajvzfALgGomC11V4c4/xhWstb6fg5ow3aPAmriy1eH4Zgb9/KzGAj28J0vQ
         92L7v8CgBhNpr8h+H0m4237qNnzLkSmohwhzg0MzcSd7s38T8/cWmF+T+66cUMTIW0
         himLTwb/VZbcPidxeLEnrki+UW72uNksRlUwlOnIHuSXb1O6ci7K3h6qB82NMM169t
         lCWOOQj5UgPtA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 34B19403B5; Fri, 26 May 2023 16:03:09 -0300 (-03)
Date:   Fri, 26 May 2023 16:03:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@kernel.org,
        kernel-team@meta.com, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf: separate bpf_counter_list and bpf_filters
Message-ID: <ZHECbcoVx6kK2tWQ@kernel.org>
References: <20230519235757.3613719-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519235757.3613719-1-song@kernel.org>
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

Em Fri, May 19, 2023 at 04:57:57PM -0700, Song Liu escreveu:
> evsel uses a union for the two lists. This turned out to be error prone.
> For example:
> 
> [root@quaco ~]# perf stat --bpf-prog 5246
> Error: cpu-clock event does not have sample flags 66c660
> failed to set filter "(null)" on event cpu-clock with 2 (No such file or
> directory)
> 
> Fix this issue by separating the two lists.


Thanks, applied.

- Arnaldo

 
> Fixes: 56ec9457a4a2 ("perf bpf filter: Implement event sample filtering")
> Signed-off-by: Song Liu <song@kernel.org>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/evsel.c | 1 +
>  tools/perf/util/evsel.h | 6 ++----
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 2f5910b31fa9..c2dbb5647e75 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -282,6 +282,7 @@ void evsel__init(struct evsel *evsel,
>  	evsel->bpf_fd	   = -1;
>  	INIT_LIST_HEAD(&evsel->config_terms);
>  	INIT_LIST_HEAD(&evsel->bpf_counter_list);
> +	INIT_LIST_HEAD(&evsel->bpf_filters);
>  	perf_evsel__object.init(evsel);
>  	evsel->sample_size = __evsel__sample_size(attr->sample_type);
>  	evsel__calc_id_pos(evsel);
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index df8928745fc6..0f54f28a69c2 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -151,10 +151,8 @@ struct evsel {
>  	 */
>  	struct bpf_counter_ops	*bpf_counter_ops;
>  
> -	union {
> -		struct list_head	bpf_counter_list; /* for perf-stat -b */
> -		struct list_head	bpf_filters; /* for perf-record --filter */
> -	};
> +	struct list_head	bpf_counter_list; /* for perf-stat -b */
> +	struct list_head	bpf_filters; /* for perf-record --filter */
>  
>  	/* for perf-stat --use-bpf */
>  	int			bperf_leader_prog_fd;
> -- 
> 2.34.1
> 

-- 

- Arnaldo
