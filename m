Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1D26FE354
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbjEJRjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjEJRjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:39:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956683C1B;
        Wed, 10 May 2023 10:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683740343; x=1715276343;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8Ls1QbnU0cHLj+UwwGv4G3zWqz6T76HHYT3uPfOXwWI=;
  b=MU6hOuOcx4otcJMreZEz6qEtXZgL9eBy5PkhrabQyrPRFe4NVQeWwFgs
   x8cChNSd8xy0RKSd9BnXPRv+ilMX3byfiEaAhW1Ct1vF3GWEWV30m4cFp
   7hxJ5x0cZvIo9aGbVcgtu75esJD54TEQg66XeK/a/K3O1aEX7kSrx8E2k
   XGlbyQB3fev+z/EIcwUqpEqGq1+QRpFSbhoTs+17R0Ll/Kh+sOvP2nZVm
   wYfE8l9/O07oKuCZ4l5gIHOEZ7/VLGGmBzC7V3DI7Hu6cV/vs+F3SugA1
   X9D1Sto+WAkurb44fuV6bDZUDm/95pSbuO+jLOnAEACCTR2qBgIXk6kpx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="330637053"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="330637053"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 10:39:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="764392862"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="764392862"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.254])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 10:39:01 -0700
Message-ID: <13640a9e-a186-2480-2649-ee19869228bb@intel.com>
Date:   Wed, 10 May 2023 20:38:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V2 0/2] perf parse-events: Do not break up AUX event group
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230508093952.27482-1-adrian.hunter@intel.com>
 <ZFvQpZsvyEaHUjSq@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZFvQpZsvyEaHUjSq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/23 20:13, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 08, 2023 at 12:39:50PM +0300, Adrian Hunter escreveu:
>> Hi
>>
>> Here is a fix needed in v6.4, but dependent on Ian's patch
>> "perf evsel: Modify group pmu name for software events", refer:
>>
>> https://lore.kernel.org/lkml/20230502223851.2234828-20-irogers@google.com/
>>
>> There is also a test amendment to test the AUX event group fix for
>> Intel PT.
> 
> Ok, so I think I can add your Tested-by for that "perf evsel: Modify
> group pmu name for software events" patch, ok?

Yes, thank you!

> 
> - Arnaldo
>  
>>
>> Changes in V2:
>>
>>    Add an Intel PT test amendment for the AUX event group fix
>>    Change AUX event group fix as suggested by Ian
>>
>>
>> Adrian Hunter (2):
>>       perf test: test_intel_pt.sh: Test sample mode with named PMU
>>       perf parse-events: Do not break up AUX event group
>>
>>  tools/perf/tests/shell/test_intel_pt.sh | 7 +++++++
>>  tools/perf/util/evsel.c                 | 9 +++------
>>  2 files changed, 10 insertions(+), 6 deletions(-)

