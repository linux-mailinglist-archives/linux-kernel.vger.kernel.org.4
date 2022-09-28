Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB325ED6E0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiI1Hyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiI1HyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:54:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2255A205F6;
        Wed, 28 Sep 2022 00:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664351638; x=1695887638;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6/r0fEdXYo7Wp0TYVKLQb7eKXTHsEoV4NAAQ4RlX2ww=;
  b=LftScvklC9DZ8b09SgsEMPGeNgcmr53rYHVlyRCfnZYE5PLtizVwsGq7
   MAnrPwg8cwyVvKWKqDGPNSS+LUhV25brU6KbJsPaOLaPuY0sRVU79Ue5c
   w4L11G+D6qjN+T/+HAl33/ydmJf0Z8yuYpvWnQY3vG48ZNHJ+M5J9KOtG
   EAoKHki61SuS8abb7YaVT1n15gcJhj4oACAt4w526wfr1pMNno0H40QB3
   NO1nkVTqwqpwnMgZ6ZeSNyTw+/dX1XYpo7M2iOFUMkBQQ28ZcqWpRWH3x
   b9VDNz91hT5DtO5iOElY5qPkeaCSqOnxAWuTSDqXANAox/dMtIovJRRPQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="303019094"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="303019094"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 00:53:57 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="950603445"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="950603445"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.24])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 00:53:54 -0700
Message-ID: <ae609590-7d85-ee4b-3525-8eaa46ed240c@intel.com>
Date:   Wed, 28 Sep 2022 10:53:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] libperf: Propagate maps only if necessary
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
References: <20220924165737.956428-1-namhyung@kernel.org>
 <20220924165737.956428-3-namhyung@kernel.org>
 <d901f8c8-0dda-8f34-f963-09cf56d4924e@intel.com>
 <CAM9d7ciGFqSRO=J6FZmz=enML7eCyvRMQB+bm=nZ07GmozJwbw@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7ciGFqSRO=J6FZmz=enML7eCyvRMQB+bm=nZ07GmozJwbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/22 20:28, Namhyung Kim wrote:
> Hi Adrian,
> 
> On Tue, Sep 27, 2022 at 12:06 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 24/09/22 19:57, Namhyung Kim wrote:
>>> The current code propagate evsel's cpu map settings to evlist when it's
>>> added to an evlist.  But the evlist->all_cpus and each evsel's cpus will
>>> be updated in perf_evlist__set_maps() later.  No need to do it before
>>> evlist's cpus are set actually.
>>>
>>> Actually we discarded this intermediate all_cpus maps at the beginning
>>> of perf_evlist__set_maps().  Let's not do this.  It's only needed when
>>> an evsel is added after the evlist cpu maps are set.
>>
>> That might not be true.  Consider evlist__fix_hybrid_cpus() which fiddles
>> with evsel->core.cpus and evsel->core.own_cpus after the evsel has been
>> added to the evlist.  It can also remove an evsel from the evlist.
> 
> Thanks for your review.  I think it's fine to change evsel cpus or to remove
> an evsel from evlist before calling evlist__create_maps().  The function
> will take care of setting evlist's all_cpus from the evsels in the evlist.
> So previous changes in evsel/cpus wouldn't be any special.
> 
> After this point, adding a new evsel needs to update evlist all cpus by
> propagating cpu maps.  So I think hybrid cpus should be fine.
> Did I miss something?

I wondered how it might play out if evlist__fix_hybrid_cpus() reduced the
cpus from the target->cpu_list (using perf record -C) , since after this
patch all_cpus always starts with the target->cpu_list instead of an empty
list.  But then, in the hybrid case, it puts a dummy event that uses the
target cpu list anyway, so the result is the same.

I don't know if there are any cases where all_cpus would actually need to
exclude some of the cpus from target->cpu_list.

> 
>>
>> There might be other cases like that, but that was just one that stuck
>> out.
> 
> Thanks for sharing your concern.  Please let me know if you could
> come up with another.
> 
> Namhyung

