Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720925FA946
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 02:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJKAZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 20:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJKAZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 20:25:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EFC1EAC5;
        Mon, 10 Oct 2022 17:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665447926; x=1696983926;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hi/39ZWjxqkQ6aMFAuB2tPrMoMeUZtt47pv6m/lcuTc=;
  b=EZYLV5DLC9HGFBldfehzuS6RixO4N7wfpg1RBo86LR+FW/FL0jdEyEig
   RzhNsBEG9vCKeZ3uEm2odNlmae4vvlqtZ1riwr5OxVxM9EBthXBkISIZd
   RK8rcMbQ5jfifSPn3UZTd9EyT7xCx51yCa+uKx35wEI4pE9KrZVpXiWo6
   yyEJnZvgkudscRfcumF6lNELDPeKJNWO0FNnS8r8tOoN9QB1eIsoxGcIK
   0DqI3pTILzkurENmGRfUiySnyv5RNJyS7uk0rz3pphHlwR7tYyRi4iRqn
   WjxNxHT9fGlfX7KxJJC07KTpd1f01sWdS2xr5njWTUy6axE/EBF0hv9tl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="303106782"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="303106782"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 17:25:26 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="689010780"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="689010780"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.62.34]) ([10.212.62.34])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 17:25:21 -0700
Message-ID: <ebc8e57e-1584-5f47-48d8-3bc38497799b@linux.intel.com>
Date:   Mon, 10 Oct 2022 20:25:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [RFC/PATCHSET 00/19] perf stat: Cleanup counter aggregation (v1)
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
References: <20221010053600.272854-1-namhyung@kernel.org>
Content-Language: en-US
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20221010053600.272854-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/10/2022 10:35 PM, Namhyung Kim wrote:
> Hello,
>
> Current perf stat code is somewhat hard to follow since it handles
> many combinations of PMUs/events for given display and aggregation
> options.  This is my attempt to clean it up a little. ;-)


My main concern would be subtle regressions since there are so many 
different combinations and way to travel through the code, and a lot of 
things are not covered by unit tests. When I worked on the code it was 
difficult to keep it all working. I assume you have some way to 
enumerate them all and tested that the output is identical?

-Andi

