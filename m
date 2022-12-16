Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342BC64E7AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 08:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLPHZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 02:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPHZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 02:25:06 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075E7396F3;
        Thu, 15 Dec 2022 23:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671175506; x=1702711506;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qJKEVCrkmgPQdj73CRwhmmOaI06yiO5kmCj09cE2S2o=;
  b=Az2z9lzeiGVFjgUfFjzYnwCyvr5Er83sc9vbEFN+b/Xuom/L7rEvvlfx
   Rt5kAOEwucvEJ/YMSqIn6mP4w4dSDgl4FYX+9OrGLuVR0xfTkEDLUHvhZ
   T8fZKz8hESCoFvDVy5A6YN8CfZf4WQq3J1xg6LHHL4s3ncbB3vBeHwr43
   hW1nlLxYvAmrqI5n/VKRk3eURibLkyudKSIw55fgvqys2kiETNwm7yJSk
   nva6V9GZSu04oAabE75lBA0coxRshMbqwgA+vs12jQ5YTL0yzRhpch4AG
   Byt0xxZ12RoKlGH9Qnw+Rlgl9Imm4NXOc28JlJQbwAg1a4U09cKTRenog
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="405166237"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="405166237"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 23:25:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="627487148"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="627487148"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.249.39.80]) ([10.249.39.80])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 23:25:01 -0800
Message-ID: <18594a2a-553a-c2b8-2c4f-6f7563ae3727@linux.intel.com>
Date:   Fri, 16 Dec 2022 09:24:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/9] perf report: Ignore SIGPIPE for srcline
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Leo Yan <leo.yan@linaro.org>
References: <20221215192817.2734573-1-namhyung@kernel.org>
 <20221215192817.2734573-3-namhyung@kernel.org>
Content-Language: en-US
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20221215192817.2734573-3-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/15/2022 9:28 PM, Namhyung Kim wrote:
> It can get SIGPIPE when it uses an external addr2line process and the
> process was terminated unexpectedly.  Let's ignore the signal and move
> on to the next sample.  The sample will get the default srcline value
> anyway.


That's a bit dangerous -- if perf report output is piped to something 
else you really want to stop on SIGPIPE.

You would need to find a way to distinguish those cases.

-Andi

