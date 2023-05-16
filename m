Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA7B7054CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjEPROS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjEPROH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:14:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D1A7DAA;
        Tue, 16 May 2023 10:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684257244; x=1715793244;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=T5LZQA1qVyBa93gE+28Rv7aQYtz8a1zbnDhXJFdc+yE=;
  b=dnCDqNUAothaMVjVMI86p7JNXLAZArmbha24MuvtyV/jTIIV+Y7I2RsM
   XQej9hZhDtJ/pJSEPwajsgCRlgk3xI9YJouzKVqs3pSl4DOCC4z+KO+f7
   3E3tzAOuh9DRCovTPRCv0OJrO+Ija+Q5R8h3qTuzqrSsBJ+wHslDgBNsd
   +QZjAkqubNETQtkAi91RE5HcQUB3fFAaVxn0xgX57wEywS48JSChtH0mg
   i6/Qc2ACk9z5xOWNhPs5p4KWqZpTUQsjZjnRU1zaoSSv1XOt2rSF82FJ8
   Cra6sDXQ9gooPChqq8l3Fcdj/0oFS83nKdzgEhmurSvdNHOcuEcf5q/5+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="379723500"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="379723500"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 10:14:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="845745072"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="845745072"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 16 May 2023 10:14:03 -0700
Received: from [10.212.175.225] (kliang2-mobl1.ccr.corp.intel.com [10.212.175.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 59F40580D24;
        Tue, 16 May 2023 10:14:02 -0700 (PDT)
Message-ID: <3688fd0f-4e59-44d4-5fdf-c92bc6b0916d@linux.intel.com>
Date:   Tue, 16 May 2023 13:14:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v1] perf metrics: Avoid segv with --topdown
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230515224530.671331-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230515224530.671331-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-15 6:45 p.m., Ian Rogers wrote:
> Some metrics may not have a metric_group which can result in segvs
> with "perf stat --topdown". Add a condition for the no metric_group
> case.
> 
> Fixes: 1647cd5b8802 ("perf stat: Implement --topdown using json metrics")
> Reported-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  tools/perf/util/metricgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 4e7d41d285b4..5e9c657dd3f7 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1672,7 +1672,7 @@ static int metricgroup__topdown_max_level_callback(const struct pmu_metric *pm,
>  {
>  	unsigned int *max_level = data;
>  	unsigned int level;
> -	const char *p = strstr(pm->metric_group, "TopdownL");
> +	const char *p = strstr(pm->metric_group ?: "", "TopdownL");
>  
>  	if (!p || p[8] == '\0')
>  		return 0;
