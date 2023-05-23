Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B10070DF4E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbjEWOdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbjEWOdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:33:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE94CFA;
        Tue, 23 May 2023 07:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684852416; x=1716388416;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=TPVQ0VVbPTaQQmNO3A8vqVnzAiMmj/ojDjpM5LF4vM0=;
  b=lH60THX/ycnFWvW2dze4HvFfK8PFlqU9k9NIYAHQkeW0iJZiTZ+QVlxh
   7OhHGJmt/PfSV+XoByjT9mR+RDYNWYPbnEnrKKlOZFyhh6vXEs/hm/rGS
   lYuwnceYBi0f8eiYfXQliNaw5HzMnwUuv9aDoFsPrB69+aT/e9B4Q5IVw
   xYiXfpn2WlNB1TPzsi9ufO6cq6myeeSiozwcX+jniRsZTl3CwZGIx8A9y
   DRFP4Io0My57VkBnohfyXhjJhA0dWVrDx3TnAOCUk2bHy/9+LdWswMNsW
   xDX7ztlzTUGbV/Cer3Ls0iN4vNUBEXFJUF15/woc2zKhMIkiYhCbz+l42
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="350763382"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="350763382"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 07:32:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="654397638"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="654397638"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.39.37])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 07:31:56 -0700
Message-ID: <0a325fc8-2945-862a-e6bd-eb7b0ac46fe5@intel.com>
Date:   Tue, 23 May 2023 17:31:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v1 2/2] perf evsel: for_each_group fixes
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Changbin Du <changbin.du@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230523044446.1020769-1-irogers@google.com>
 <20230523044446.1020769-2-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230523044446.1020769-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/23 07:44, Ian Rogers wrote:
> Address/memory sanitizer was reporting issues in evsel__group_pmu_name
> because the for_each_group_evsel loop didn't terminate when the head
> was reached, the head would then be cast and accessed as an evsel
> leading to invalid memory accesses. Fix for_each_group_member and
> for_each_group_evsel to terminate at the list head. Note,
> evsel__group_pmu_name no longer iterates the group, but the problem is
> present regardless.
> 
> Fixes: 717e263fc354 ("perf report: Show group description when event group is enabled")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.h         | 24 ++++++++++++++++--------
>  tools/perf/util/evsel_fprintf.c |  1 +
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 820771a649b2..6a64543c7612 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -462,16 +462,24 @@ static inline int evsel__group_idx(struct evsel *evsel)
>  }
>  
>  /* Iterates group WITHOUT the leader. */
> -#define for_each_group_member(_evsel, _leader) 					\
> -for ((_evsel) = list_entry((_leader)->core.node.next, struct evsel, core.node); \
> -     (_evsel) && (_evsel)->core.leader == (&_leader->core);					\
> -     (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
> +#define for_each_group_member_head(_evsel, _leader, _head)				\
> +for ((_evsel) = list_entry((_leader)->core.node.next, struct evsel, core.node);		\
> +	(_evsel) && (&(_evsel)->core.node != (_head)) &&				\

Extra parentheses perhaps not needed e.g. just

	&(_evsel)->core.node != (_head)

> +	(_evsel)->core.leader == (&_leader->core);					\

Parentheses look odd, maybe should be:

	&(_leader)->core

> +	(_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
> +
> +#define for_each_group_member(_evsel, _leader)				\
> +	for_each_group_member_head(_evsel, _leader, &(_leader)->evlist->core.entries)

Did you consider using (_leader)->core.nr_members so that it is not
necessary to assume the evlist back pointer is populated.

>  
>  /* Iterates group WITH the leader. */
> -#define for_each_group_evsel(_evsel, _leader) 					\
> -for ((_evsel) = _leader; 							\
> -     (_evsel) && (_evsel)->core.leader == (&_leader->core);					\
> -     (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
> +#define for_each_group_evsel_head(_evsel, _leader, _head)				\
> +for ((_evsel) = _leader;								\
> +	(_evsel) && (&(_evsel)->core.node != (_head)) &&				\
> +	(_evsel)->core.leader == (&_leader->core);					\
> +	(_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
> +
> +#define for_each_group_evsel(_evsel, _leader)				\
> +	for_each_group_evsel_head(_evsel, _leader, &(_leader)->evlist->core.entries)
>  
>  static inline bool evsel__has_branch_callstack(const struct evsel *evsel)
>  {
> diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> index cc80ec554c0a..036a2171dc1c 100644
> --- a/tools/perf/util/evsel_fprintf.c
> +++ b/tools/perf/util/evsel_fprintf.c
> @@ -2,6 +2,7 @@
>  #include <inttypes.h>
>  #include <stdio.h>
>  #include <stdbool.h>
> +#include "util/evlist.h"
>  #include "evsel.h"
>  #include "util/evsel_fprintf.h"
>  #include "util/event.h"

