Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5AD735736
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjFSMsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjFSMsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:48:45 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604FA113;
        Mon, 19 Jun 2023 05:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687178924; x=1718714924;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dBCyE2sw+S1qIRqycQBeE/+cUqHyEnIowfaY4Rl2/B0=;
  b=W8W6wXBpispPfRc95eyOgWsA+yJS225Jh80qFMIFvWk+kmcDgx+mc/XP
   xDdHCBth5F2vvVx7cIYYPdi+tYxQq8o0VF4F+FLXZoLX4SZylYe1LnxxN
   JVSYgEiFgSwt52gKOWZibn5hKRJvGVElbZbdomUdMtPuYwDeKR7J91fsE
   w10KDlTLM0+mWRipDvYwvBd9OXlqyl59wOfXVZOBuj1uugOzYs4eTEyns
   TediK9Co8MZy7VUg2Exzz8DbHiibUGhuacTJeHsR5t7CfiSVvveY/3Moj
   x3Fe5okhQb3FpfHfurReJb7Q7bTs7db2wjVnovGUn3Bqyf5I7OkNvH4LR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="349342761"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="349342761"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 05:48:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="837857967"
X-IronPort-AV: E=Sophos;i="6.00,254,1681196400"; 
   d="scan'208";a="837857967"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.10])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 05:48:39 -0700
Message-ID: <e4d4af5c-8714-aac3-517b-dda1fb5b5b37@intel.com>
Date:   Mon, 19 Jun 2023 15:48:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH] tools: Optimize the variable with 0 as the return value
Content-Language: en-US
To:     Li Dong <lidong@vivo.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230619112047.1966-1-lidong@vivo.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230619112047.1966-1-lidong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/23 14:20, Li Dong wrote:
> The variable ret is not used, replacing ret with 0 as the return value

What kernel does that apply to?

> 
> Signed-off-by: Li Dong <lidong@vivo.com>
> ---
>  tools/perf/util/intel-pt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index dbf0bc71a63b..a40017458185 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -3398,7 +3398,6 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
>  	struct machine *machine = pt->machine;
>  	struct intel_pt_cache_entry *e;
>  	u64 offset;
> -	int ret = 0;
>  
>  	addr_location__init(&al);
>  	if (!event->text_poke.new_len)
> @@ -3439,7 +3438,7 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
>  	}
>  out:
>  	addr_location__exit(&al);
> -	return ret;
> +	return 0;
>  }
>  
>  static int intel_pt_process_event(struct perf_session *session,

