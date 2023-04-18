Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3B06E6EAC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjDRVwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjDRVv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:51:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78068C179;
        Tue, 18 Apr 2023 14:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681854713; x=1713390713;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ldu3EeKCZkSHQXEnza4qHwd8boG8UhISb/bAXJ0OwHI=;
  b=ZUe2VFNbKKHPQW8hcrtiYAOtMGfoI0BOSCBUTBbxUH86dA6AcsIjz+i8
   DbEYuhtlpSejVM13om9dLXfKjOvokJsLEDIUg62DEQ9FmTLGcveFBR//R
   RS2uZpoLbGNO2Uofd3GXVlb3Gfv/tc5uvT8TPSHip2sjoe8Nv5fAEHobX
   geNYaqu3ykBraqD27Dt//z7YoDq/rJzUe6rJ9M+48KQRdvlVDnOkvHe64
   8rZNJojbBBn+Q4eqTXUbTfF409II0GbV5u5ya72gtJBxPz3B3DpKCrZ7G
   Nq/balztlWOlGxvHde/ewAFFc6BLF4W1nUMrsjEsbQy21aVNx39GZLNOR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="344045789"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="344045789"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 14:51:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="802683003"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="802683003"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 18 Apr 2023 14:51:52 -0700
Received: from [10.212.233.128] (kliang2-mobl1.ccr.corp.intel.com [10.212.233.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 2CA9C580C9A;
        Tue, 18 Apr 2023 14:51:51 -0700 (PDT)
Message-ID: <ea899096-0599-f2a0-04a3-d90a3aa7d45d@linux.intel.com>
Date:   Tue, 18 Apr 2023 17:51:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] perf stat: Introduce skippable evsels
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230414051922.3625666-1-irogers@google.com>
 <56ac61a0-ccf0-210e-e429-11062a07b8bf@linux.intel.com>
 <CAP-5=fXz1vw48A2tWgcNDSZsnvnOO7_jA+py3p_Khi_igz0hJw@mail.gmail.com>
 <5031f492-9734-be75-3283-5961771d87c8@linux.intel.com>
 <CAP-5=fW2aAijt8tqydszQHQFmsfeQO2S0hb7Z27RtXxG4Zmm-w@mail.gmail.com>
 <ce92dd1b-23f6-ea52-a47d-fccc24fa20ea@linux.intel.com>
 <CAP-5=fWRy4NEqhB6-b98+m7SV5=oyBOMVuOHwmvKZCJuXcsQEg@mail.gmail.com>
 <d1fe801a-22d0-1f9b-b127-227b21635bd5@linux.intel.com>
 <CAP-5=fXCmKAUn24r0YYHaO63mabZCXae-hAT2WCtk+YYmvS9xg@mail.gmail.com>
 <99150cb1-fe50-97cf-ad80-cceb9194eb9a@linux.intel.com>
 <CAP-5=fXZSACj=kGM5t3pBHkQ-W1i0eJayAQ77_ToEp4zXWzJnw@mail.gmail.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fXZSACj=kGM5t3pBHkQ-W1i0eJayAQ77_ToEp4zXWzJnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-18 4:08 p.m., Ian Rogers wrote:
> On Tue, Apr 18, 2023 at 11:19 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2023-04-18 11:43 a.m., Ian Rogers wrote:
>>> On Tue, Apr 18, 2023 at 6:03 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2023-04-17 2:13 p.m., Ian Rogers wrote:
>>>>> The json TopdownL1 is enabled if present unconditionally for perf stat
>>>>> default. Enabling it on Skylake has multiplexing as TopdownL1 on
>>>>> Skylake has multiplexing unrelated to this change - at least on the
>>>>> machine I was testing on. We can remove the metric group TopdownL1 on
>>>>> Skylake so that we don't enable it by default, there is still the
>>>>> group TmaL1. To me, disabling TopdownL1 seems less desirable than
>>>>> running with multiplexing - previously to get into topdown analysis
>>>>> there has to be knowledge that "perf stat -M TopdownL1" is the way to
>>>>> do this.
>>>>
>>>> To be honest, I don't think it's a good idea to remove the TopdownL1. We
>>>> cannot remove it just because the new way cannot handle it. The perf
>>>> stat default works well until 6.3-rc7. It's a regression issue of the
>>>> current perf-tools-next.
>>>
>>> I'm not so clear it is a regression to consistently add TopdownL1 for
>>> all architectures supporting it.
>>
>>
>> Breaking the perf stat default is a regression.
> 
> Breaking is overstating the use of multiplexing. The impact is less
> accuracy in the IPC and branch misses default metrics,

Inaccuracy is a breakage for the default.

> if multiplexing
> is necessary on your Intel architecture. I believe TopdownL1 is more
> useful than either of these metrics and so having TopdownL1 be a
> default is an improvement. We can add a patch, as I keep repeating
> this is off-topic for this patch, to make it so that TopdownL1 isn't
> enabled on Intel CPUs pre-Icelake, but I would discourage this.


We need the TopdownL1. We just don't need TopdownL1 in the perf stat
default when perf metrics feature is not available.


> 
>> The reason we once added the TopdownL1 for ICL and later platform is
>> that it doesn't break the original design (a *clean* output).
> 
> Right, and in 6.3-rc7 the aggregation of counts was broken because of
> duplicated counts and hard coded metrics (I did a last minute partial
> fix). In perf-tools-next aggregation was fixed and we switched to the
> json metrics, that are accurate and up-to-date with the latest TMA
> metrics, so that we wouldn't need to maintain a duplicate code path.
> What keys enabling TopdownL1 in 6.3 is the presence of topdown events
> whilst in perf-tools-next it is the presence of TopdownL1 metric
> group, as this is a more consistent approach and had first been
> proposed by ARM.

A consistent approach is good only when it can benefits all parties
rather than sacrifices any of them.

Apparently, the approach in the perf-tools-next brings all kinds of
issues, multiplexing/inaccuracy in the perf stat default on Intel
platforms. Why cannot we fix it properly before applying the approach?

I think Andi also mentioned the similar request when ARM introduced the
TopdownL1 metrics.
https://lore.kernel.org/linux-perf-users/12e0deef-08db-445f-4958-bcd5c3e10367@linux.intel.com/

Thanks,
Kan
