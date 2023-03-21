Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AE46C322C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjCUNBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjCUNBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:01:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AF54AD33;
        Tue, 21 Mar 2023 06:01:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34BFBB81689;
        Tue, 21 Mar 2023 13:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7992C433AA;
        Tue, 21 Mar 2023 13:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679403658;
        bh=rw0p931Rpe2Ny/jb9uFi/QH0tIAjRolc9p08WyG9TIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7+ts8Nr78LLj2M4xcfKeFepUeYmMZaMwBoN00rSJX887yHsfz0jcWBv/3eLwMy6L
         1PkFE2BtNsDcGxnnWoQn1M5feyrrHoxUXW+cWDkkhSrKCE8exNC9YRj/F3Wx7Qlv7Y
         jiQ8EwSfSEQ5cuwh9l8UL0Ww5KafAib6Q+qQMylWLNbJAunikHYUU9tJ5zy3hmIpki
         j1ML8Vc+gB8uzHZdRzyTqdt3gXD5FnFcGWr3ytwhgzVsic4Jcj6GdvlXmGn6XFHfoA
         Chm7pwlc8nQpnm71tTuQR4tRlzQzVyUe15VsrdigcNhc2ndSeSXgLjJ185fqwffq3f
         aqgFGctDTrF6w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0D69F4052D; Tue, 21 Mar 2023 10:00:56 -0300 (-03)
Date:   Tue, 21 Mar 2023 10:00:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf kvm: Support refcnt in structure kvm_info
Message-ID: <ZBmqiKC1FSGI0/iE@kernel.org>
References: <20230320061619.29520-1-leo.yan@linaro.org>
 <20230320061619.29520-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320061619.29520-2-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 20, 2023 at 02:16:18PM +0800, Leo Yan escreveu:
> hists__add_entry_ops() doesn't allocate a new histograms entry if it has
> an existed entry for a KVM event, in this case, find_create_kvm_event()
> allocates structure kvm_info but it's not used by any histograms and
> never freed.
> 
> To fix the memory leak, this patch firstly introduces refcnt and a set
> of functions for refcnt operations in the structure kvm_info.  When the
> data structure is not used anymore, it invokes kvm_info__zput() to
> decrease reference count and release the structure.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-kvm.c   |  3 +--
>  tools/perf/util/hist.c     |  5 +++++
>  tools/perf/util/kvm-stat.h | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 4c205df5106f..1e1cb5a9d0a2 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -768,7 +768,6 @@ static void kvm_he_free(void *he)
>  {
>  	struct kvm_event *kvm_ev;
>  
> -	free(((struct hist_entry *)he)->kvm_info);
>  	kvm_ev = container_of(he, struct kvm_event, he);
>  	free(kvm_ev);
>  }
> @@ -788,7 +787,7 @@ static struct kvm_event *find_create_kvm_event(struct perf_kvm_stat *kvm,
>  
>  	BUG_ON(key->key == INVALID_KEY);
>  
> -	ki = zalloc(sizeof(*ki));
> +	ki = kvm_info__new();
>  	if (!ki) {
>  		pr_err("Failed to allocate kvm info\n");
>  		return NULL;
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 3670136a0074..b296f572f881 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -628,6 +628,8 @@ static struct hist_entry *hists__findnew_entry(struct hists *hists,
>  
>  			block_info__zput(entry->block_info);
>  
> +			kvm_info__zput(entry->kvm_info);
> +
>  			/* If the map of an existing hist_entry has
>  			 * become out-of-date due to an exec() or
>  			 * similar, update it.  Otherwise we will
> @@ -1323,6 +1325,9 @@ void hist_entry__delete(struct hist_entry *he)
>  	if (he->block_info)
>  		block_info__zput(he->block_info);
>  
> +	if (he->kvm_info)
> +		kvm_info__zput(he->kvm_info);
> +
>  	zfree(&he->res_samples);
>  	zfree(&he->stat_acc);
>  	free_srcline(he->srcline);
> diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
> index bc6c8e38ef50..9bf34c0e0056 100644
> --- a/tools/perf/util/kvm-stat.h
> +++ b/tools/perf/util/kvm-stat.h
> @@ -10,6 +10,9 @@
>  #include "symbol.h"
>  #include "record.h"
>  
> +#include <stdlib.h>
> +#include <linux/zalloc.h>
> +
>  #define KVM_EVENT_NAME_LEN	40
>  
>  struct evsel;
> @@ -25,6 +28,7 @@ struct event_key {
>  
>  struct kvm_info {
>  	char name[KVM_EVENT_NAME_LEN];
> +	refcount_t refcnt;
>  };
>  
>  struct kvm_event_stats {
> @@ -145,6 +149,39 @@ extern const char *vcpu_id_str;
>  extern const char *kvm_exit_reason;
>  extern const char *kvm_entry_trace;
>  extern const char *kvm_exit_trace;
> +
> +static inline struct kvm_info *kvm_info__get(struct kvm_info *ki)
> +{
> +	if (ki)
> +		refcount_inc(&ki->refcnt);
> +	return ki;
> +}
> +
> +static inline void kvm_info__put(struct kvm_info *ki)
> +{
> +	if (ki && refcount_dec_and_test(&ki->refcnt))
> +		free(ki);
> +}
> +
> +static inline void __kvm_info__zput(struct kvm_info **ki)
> +{
> +	kvm_info__put(*ki);
> +	*ki = NULL;
> +}
> +
> +#define kvm_info__zput(ki) __kvm_info__zput(&ki)
> +
> +static inline struct kvm_info *kvm_info__new(void)
> +{
> +	struct kvm_info *ki;
> +
> +	ki = zalloc(sizeof(*ki));
> +	if (ki)
> +		refcount_set(&ki->refcnt, 1);
> +
> +	return ki;
> +}
> +
>  #endif /* HAVE_KVM_STAT_SUPPORT */
>  
>  extern int kvm_add_default_arch_event(int *argc, const char **argv);

I had to add this:

Provide a nop version of kvm_info__zput() to be used when
HAVE_KVM_STAT_SUPPORT isn't defined as it is used unconditionally in
hists__findnew_entry() and hist_entry__delete().

- Arnaldo

diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 9bf34c0e0056e390..90b854390c89708d 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -182,6 +182,9 @@ static inline struct kvm_info *kvm_info__new(void)
 	return ki;
 }
 
+#else /* HAVE_KVM_STAT_SUPPORT */
+// We use this unconditionally in hists__findnew_entry() and hist_entry__delete()
+#define kvm_info__zput(ki)
 #endif /* HAVE_KVM_STAT_SUPPORT */
 
 extern int kvm_add_default_arch_event(int *argc, const char **argv);
