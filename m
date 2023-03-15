Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4446BBD8A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjCOTrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjCOTrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:47:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0030E94775;
        Wed, 15 Mar 2023 12:46:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9BA061E4A;
        Wed, 15 Mar 2023 19:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3920C433D2;
        Wed, 15 Mar 2023 19:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678909556;
        bh=LSJOMlcnJ19oNf9iRYay/FZoaeNsalq4lnfuSfcm2LA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=asVGCKb4y+4LZhwBNHWB4tgXjlSbFC93WfXlPgefWO35EWMOyIlwymM12RucAVWMe
         l97lKH2CQv26f2uOkDIfHJaZUZNzOBJnQLoN85npw7UJPumqKEG4WqxB4q4jGq/u0A
         E2GyoyYYbstgupYGVH63dgf4LRtsiExe4NvvIT5MhFW9tbjVgMYWGpvT5QQNopYvSO
         iZxIQ2JKk1QWUPx6yzX8lKxbPCTfg+OmfrsiCG6oAbeOsA7VmIQKbi0mI4F2/uNbNo
         mhV2YiaBuNw/FuqvBnn2W260IE0IWLvrRtAlWtiHhs0naMbeqluBHfbBxoV6vetpXP
         wQAFTZjLo9dNw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9E23E4049F; Wed, 15 Mar 2023 16:45:53 -0300 (-03)
Date:   Wed, 15 Mar 2023 16:45:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 06/16] perf kvm: Introduce histograms data structures
Message-ID: <ZBIgcX0TmC0tyFR0@kernel.org>
References: <20230315145112.186603-1-leo.yan@linaro.org>
 <20230315145112.186603-7-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315145112.186603-7-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 15, 2023 at 10:51:02PM +0800, Leo Yan escreveu:
> This is a preparation to support histograms in perf kvm tool.  As first
> step, this patch defines histograms data structures and initialize them.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/builtin-kvm.c   | 18 ++++++++++++++++++
>  tools/perf/util/kvm-stat.h |  1 +
>  2 files changed, 19 insertions(+)
> 
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index d400434aa137..384992c8a01a 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -85,6 +85,20 @@ static struct kvm_event_key keys[] = {
>  	{ NULL, NULL }
>  };
>  
> +struct kvm_hists {
> +	struct hists		hists;
> +	struct perf_hpp_list	list;
> +};
> +
> +static struct kvm_hists kvm_hists;
> +
> +static int kvm_hists__init(void)
> +{
> +	__hists__init(&kvm_hists.hists, &kvm_hists.list);
> +	perf_hpp_list__init(&kvm_hists.list);
> +	return 0;
> +}
> +

Had to add:


diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index c4cb34df155fec67..b06c11d306a11cab 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -85,7 +85,6 @@ static struct kvm_event_key keys[] = {
 	DEF_SORT_NAME_KEY(time, mean),
 	{ NULL, NULL }
 };
-#endif // defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
 
 struct kvm_hists {
 	struct hists		hists;
@@ -100,6 +99,7 @@ static int kvm_hists__init(void)
 	perf_hpp_list__init(&kvm_hists.list);
 	return 0;
 }
+#endif // defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
 
 static const char *get_filename_for_perf_kvm(void)
 {

>  static const char *get_filename_for_perf_kvm(void)
>  {
>  	const char *filename;
> @@ -957,6 +971,8 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
>  	set_term_quiet_input(&save);
>  	init_kvm_event_record(kvm);
>  
> +	kvm_hists__init();
> +
>  	signal(SIGINT, sig_handler);
>  	signal(SIGTERM, sig_handler);
>  
> @@ -1152,6 +1168,8 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
>  	init_kvm_event_record(kvm);
>  	setup_pager();
>  
> +	kvm_hists__init();
> +
>  	ret = read_events(kvm);
>  	if (ret)
>  		goto exit;
> diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
> index 841b3174c211..e2c17662bac7 100644
> --- a/tools/perf/util/kvm-stat.h
> +++ b/tools/perf/util/kvm-stat.h
> @@ -5,6 +5,7 @@
>  #ifdef HAVE_KVM_STAT_SUPPORT
>  
>  #include "tool.h"
> +#include "sort.h"
>  #include "stat.h"
>  #include "record.h"
>  
> -- 
> 2.34.1
> 

-- 

- Arnaldo
