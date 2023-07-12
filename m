Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD643750BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjGLPCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjGLPCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:02:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DEF1BC6;
        Wed, 12 Jul 2023 08:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689174162; x=1720710162;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=yF9gaEmvDtrTxDQulClxWo4RdpgKb3P5EfYxgOrvCd0=;
  b=QUfHcOHz6aObY8+PtzAPB8yVnquUH0W07VJ2cU9r9MFc9ugdmk1dHT8j
   1BqbpL3yW0IX5n7KfBClbTjlz2a32P9x5IJbsHc8GN69F5Par4gJavVDe
   gU8HFnHxcLLTB4P2Hf2qvSCXxDRQWk9ACFvugEQa1sPfgmKg8/5rlzhF2
   fqIhl5aDphJ1beeaUoiJNCd4gYI2iP3ktfPxHTyR85H850CD1dRmeXsSo
   2VsF/D/Nbll3MWnCAADEIWSwwQGtgpqjBVQyOQP5ngOk8tNIE9hM+0AZo
   IH0ifrpGBIdDUYEfVUzObmTi1Pssu5B/5Pzu8lAGsAeHOo+HksXg4Ll9S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="431047435"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="431047435"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:01:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="845696045"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="845696045"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.166])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 08:01:46 -0700
Message-ID: <248ed5e4-19d5-e8ca-a217-55becd50813a@intel.com>
Date:   Wed, 12 Jul 2023 18:01:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 1/5] perf evlist: Export perf_evlist__propagate_maps()
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20230704074217.240939-1-yangjihong1@huawei.com>
 <20230704074217.240939-2-yangjihong1@huawei.com>
 <180925f8-57f3-c97a-15c4-db2c73abe4a2@intel.com>
 <a7480404-c6ad-8892-b9d2-d2458c2e686b@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <a7480404-c6ad-8892-b9d2-d2458c2e686b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/23 17:30, Yang Jihong wrote:
> Hello,
> 
> On 2023/7/11 21:12, Adrian Hunter wrote:
>> On 4/07/23 10:42, Yang Jihong wrote:
>>> For dummy events that keep tracking, we may need to modify its cpu_maps.
>>> For example, change the cpu_maps to track side-band events for all CPUS.
>>> Export perf_evlist__propagate_maps () to support this scenario.
>>
>> __perf_evlist__propagate_maps() is quite low-level so it would be better
>> to avoid exporting it.
>>
>>
> Or can we export it via internal/evlist.h?
> Because as mentioned in patch 2:
> 
> void perf_evsel__go_system_wide(struct perf_evlist *evlist, struct perf_evsel *evsel)
> {
> if (!evsel->system_wide) {
> evsel->system_wide = true;
> if (evlist->needs_map_propagation)
> __perf_evlist__propagate_maps(evlist, evsel);
> }
> }
> This interface needs to invoke __perf_evlist__propagate_maps.

Yes - put it with __perf_evlist__propagate_maps() and export it instead

> 
> Thanks,
> Yang

