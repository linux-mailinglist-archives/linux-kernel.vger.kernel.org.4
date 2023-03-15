Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DB16BBD87
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjCOTpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjCOTos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:44:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1742B7C965;
        Wed, 15 Mar 2023 12:44:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EDEB61E58;
        Wed, 15 Mar 2023 19:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D89C433EF;
        Wed, 15 Mar 2023 19:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678909478;
        bh=ObcCFqCfiMrpq2QWm65GyyVNOjbLViYdoZZDXlKz4Lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SfAyqiOY64jz84a/DcLzXtVJhAkjBLGIZVk6CM3oWF1D2ti839YWH8MgjJswWvFL4
         Ziy2q4R8q/oDCWbnlePr1mrUGIzAiPlzicByCQUYISXdxOhKgJnb/f6Lg7VN3rlsoi
         jrNxp0T7DcdTYsh4Yq7uM6UaGFkEH/+5jPqRKtBqWFAhbrpmCZdf9QlVuRBWQHrXiR
         uQRPcyPMop7GQotmZJih26RZL1grpQi80SSYa33Yir9KBvZnOhvXVPHYfOtBpmd9Z4
         k14E0txwlflAHpYTT1zIHt9SbbJTFR5493Kd0nALv+YsqusWQ52F5Ohf3zEn640qTb
         fzFdk/cLEVg7A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 24DA14049F; Wed, 15 Mar 2023 16:44:35 -0300 (-03)
Date:   Wed, 15 Mar 2023 16:44:35 -0300
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
Subject: Re: [PATCH v5 03/16] perf kvm: Move up metrics helpers
Message-ID: <ZBIgI1+s6Zf4Va+i@kernel.org>
References: <20230315145112.186603-1-leo.yan@linaro.org>
 <20230315145112.186603-4-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315145112.186603-4-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 15, 2023 at 10:50:59PM +0800, Leo Yan escreveu:
> This patch moves up the helper functions of event's metrics for later
> adding code to call them.
> 
> No any functionality changes, but has a function renaming from
> compare_kvm_event_{metric}() to cmp_event_{metric}().

    Those helper functions are only used if this is true:
    
      if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
    
    So keep them enclosed with that.

Did it here


diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 62c097a37da9b9fe..c11f5454f35c544a 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -49,6 +49,7 @@
 #include <math.h>
 #include <perf/mmap.h>
 
+#if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
 #define GET_EVENT_KEY(func, field)					\
 static u64 get_event_ ##func(struct kvm_event *event, int vcpu)		\
 {									\
@@ -84,6 +85,7 @@ static struct kvm_event_key keys[] = {
 	DEF_SORT_NAME_KEY(time, mean),
 	{ NULL, NULL }
 };
+#endif // defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
 
 static const char *get_filename_for_perf_kvm(void)
 {
 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/builtin-kvm.c | 72 ++++++++++++++++++++--------------------
>  1 file changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 3d2560ec6b37..62c097a37da9 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -49,6 +49,42 @@
>  #include <math.h>
>  #include <perf/mmap.h>
>  
> +#define GET_EVENT_KEY(func, field)					\
> +static u64 get_event_ ##func(struct kvm_event *event, int vcpu)		\
> +{									\
> +	if (vcpu == -1)							\
> +		return event->total.field;				\
> +									\
> +	if (vcpu >= event->max_vcpu)					\
> +		return 0;						\
> +									\
> +	return event->vcpu[vcpu].field;					\
> +}
> +
> +#define COMPARE_EVENT_KEY(func, field)					\
> +GET_EVENT_KEY(func, field)						\
> +static int cmp_event_ ## func(struct kvm_event *one,			\
> +			      struct kvm_event *two, int vcpu)		\
> +{									\
> +	return get_event_ ##func(one, vcpu) >				\
> +	       get_event_ ##func(two, vcpu);				\
> +}
> +
> +GET_EVENT_KEY(time, time);
> +GET_EVENT_KEY(max, stats.max);
> +GET_EVENT_KEY(min, stats.min);
> +COMPARE_EVENT_KEY(count, stats.n);
> +COMPARE_EVENT_KEY(mean, stats.mean);
> +
> +#define DEF_SORT_NAME_KEY(name, compare_key)				\
> +	{ #name, cmp_event_ ## compare_key }
> +
> +static struct kvm_event_key keys[] = {
> +	DEF_SORT_NAME_KEY(sample, count),
> +	DEF_SORT_NAME_KEY(time, mean),
> +	{ NULL, NULL }
> +};
> +
>  static const char *get_filename_for_perf_kvm(void)
>  {
>  	const char *filename;
> @@ -461,42 +497,6 @@ static bool handle_kvm_event(struct perf_kvm_stat *kvm,
>  	return true;
>  }
>  
> -#define GET_EVENT_KEY(func, field)					\
> -static u64 get_event_ ##func(struct kvm_event *event, int vcpu)		\
> -{									\
> -	if (vcpu == -1)							\
> -		return event->total.field;				\
> -									\
> -	if (vcpu >= event->max_vcpu)					\
> -		return 0;						\
> -									\
> -	return event->vcpu[vcpu].field;					\
> -}
> -
> -#define COMPARE_EVENT_KEY(func, field)					\
> -GET_EVENT_KEY(func, field)						\
> -static int compare_kvm_event_ ## func(struct kvm_event *one,		\
> -					struct kvm_event *two, int vcpu)\
> -{									\
> -	return get_event_ ##func(one, vcpu) >				\
> -				get_event_ ##func(two, vcpu);		\
> -}
> -
> -GET_EVENT_KEY(time, time);
> -COMPARE_EVENT_KEY(count, stats.n);
> -COMPARE_EVENT_KEY(mean, stats.mean);
> -GET_EVENT_KEY(max, stats.max);
> -GET_EVENT_KEY(min, stats.min);
> -
> -#define DEF_SORT_NAME_KEY(name, compare_key)				\
> -	{ #name, compare_kvm_event_ ## compare_key }
> -
> -static struct kvm_event_key keys[] = {
> -	DEF_SORT_NAME_KEY(sample, count),
> -	DEF_SORT_NAME_KEY(time, mean),
> -	{ NULL, NULL }
> -};
> -
>  static bool select_key(struct perf_kvm_stat *kvm)
>  {
>  	int i;
> -- 
> 2.34.1
> 

-- 

- Arnaldo
