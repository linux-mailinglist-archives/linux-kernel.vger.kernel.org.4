Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF7C6F3949
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 22:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjEAUfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 16:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEAUfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 16:35:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44AA1FFD;
        Mon,  1 May 2023 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682973303; x=1714509303;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=sYaSD/ryPZr3RLcb96zrSQgTL8k0+r9pT+FyKVjanp4=;
  b=JnGe6iPfH3nXeKtb8EW35oCg7woP9nPWN54OjUCojH6ddc6OfdbTIiZm
   iA9ou2TDp6hGoL6ybVvAJRN4Ga7QJP5IxN5vLerQWKcqxJY+XJQuNJ7PS
   BkAlhiwg1Q09VhC1RPkgQIdIkQqlQcWhTwkPYonqf3sWV/iiV7oQVspA2
   Wjzfqnt9mlsSpNO/eEtTg67/KLE25zIQ4gQIdfznzURC9u1I34XZIASGC
   SzFpJs2OL4r9z3o19lwDHAMkJhS9T44ZEszyp528e5bW8DbQgbl+fb4aU
   dfIM38G1rlCkqrArmg1ZuoBs/9FLB14JYBw+UBGQRAE1zs+X6TgprC385
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="345709560"
X-IronPort-AV: E=Sophos;i="5.99,242,1677571200"; 
   d="scan'208";a="345709560"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2023 13:35:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10697"; a="760811063"
X-IronPort-AV: E=Sophos;i="5.99,242,1677571200"; 
   d="scan'208";a="760811063"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 01 May 2023 13:34:42 -0700
Received: from [10.209.15.48] (kliang2-mobl1.ccr.corp.intel.com [10.209.15.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8040158088B;
        Mon,  1 May 2023 13:34:38 -0700 (PDT)
Message-ID: <1859d2ae-0f9c-1b59-210f-44e9adace4ed@linux.intel.com>
Date:   Mon, 1 May 2023 16:34:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 00/46] Fix perf on Intel hybrid CPUs
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230429053506.1962559-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230429053506.1962559-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-29 1:34 a.m., Ian Rogers wrote:
> Sample output is contained in the v1 patch set:
> https://lore.kernel.org/lkml/bff481ba-e60a-763f-0aa0-3ee53302c480@linux.intel.com/
> 
> Tested on Tigerlake, Skylake and Alderlake CPUs.

The metrics and metricgroups tests are failed on a hybrid machine.
Seems we need the no group trick for more metrics?

./perf test "perf all metricgroups test"
102: perf all metricgroups test                                      :
FAILED!


Testing DataSharing
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (cpu_core/topdown-fe-bound/).
/bin/dmesg | grep -i perf may provide additional information.

test child finished with -1
---- end ----
perf all metricgroups test: FAILED!




./perf test "perf all metrics test"
103: perf all metrics test                                           :
FAILED!

Testing tma_info_branctest child finished with -1
---- end ----
perf all metrics test: FAILED!

Testing tma_contested_accesses
Metric 'tma_contested_accesses' not printed in:
Error:
Invalid event (cpu_core/topdown-fe-bound/) in per-thread mode, enable
system wide with '-a'.

Metric 'tma_dram_bound' not printed in:
Error:
Invalid event (cpu_core/topdown-mem-bound/) in per-thread mode, enable
system wide with '-a'.


Metric 'tma_data_sharing' not printed in:
Error:
Invalid event (cpu_core/topdown-fe-bound/) in per-thread mode, enable
system wide with '-a'.


Thanks,
Kan
