Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0725F0C03
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiI3MuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiI3Mty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:49:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA27E8B;
        Fri, 30 Sep 2022 05:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664542174; x=1696078174;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/aK6BQ/hPmqczfQ274kpmEkepXFpjJXqXRUUoKpI7QE=;
  b=EbquELD1+GTJ6JA1s2xDad3jiNPxYTJgCKCFQX0X1wbm6vneHRe4zST6
   EVnE/N2bLk9ecgD9HB35dZp3HK1cncej5OOKOQcGAiaijZOXDEBM2USWI
   c07TP6eS2/pageUxeuk+YcT0YZXVuKgENHUTeITkBzB1d8W3JXW6q8Cjl
   J9j8XGSANHpxKqTKKvtnmE+fYQS0BpHitJLvv8ACK4wIqQVhNhabCHIQT
   2xba1LzfpENwsckApwoXaXAkNub4oBwAyC1MXHZ0G9y5dwlBu0yQJKpSB
   sTY4HR2DEFoJVaRsfBzgUP/b68savJqZSdc9N3rGNyuIkBK9rM2oIygco
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285317510"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="285317510"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 05:49:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="573853117"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="573853117"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.46])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 05:49:30 -0700
Message-ID: <37452f10-365d-f496-3cb2-b80481f5f079@intel.com>
Date:   Fri, 30 Sep 2022 15:49:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] libperf: Propagate maps only if necessary
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
References: <20220924165737.956428-1-namhyung@kernel.org>
 <20220924165737.956428-3-namhyung@kernel.org>
 <d901f8c8-0dda-8f34-f963-09cf56d4924e@intel.com>
 <CAM9d7ciGFqSRO=J6FZmz=enML7eCyvRMQB+bm=nZ07GmozJwbw@mail.gmail.com>
 <ae609590-7d85-ee4b-3525-8eaa46ed240c@intel.com>
 <CAM9d7ciaOMOuJay5MzOYtg5paK_YmQskX1yqg=Oni1EzipPMwA@mail.gmail.com>
 <CAP-5=fX-as0WNCXMyzOwY=ek0gR9yNXbonXHAu1hsd5wOuX-Vg@mail.gmail.com>
 <CAM9d7ciDvCOsFE68NG6jRb02DdDEOmRf_h7XizdDLGBz0RX95Q@mail.gmail.com>
 <63905e96-55d5-1aa2-5dbe-167b9aecad8c@intel.com>
 <CAM9d7ciXESTPXZobir4KirSnh1NXHwENc4WpZTudgawUZOL71Q@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7ciXESTPXZobir4KirSnh1NXHwENc4WpZTudgawUZOL71Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/22 23:42, Namhyung Kim wrote:
> On Wed, Sep 28, 2022 at 10:19 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 29/09/22 08:09, Namhyung Kim wrote:
>>> On Wed, Sep 28, 2022 at 7:08 PM Ian Rogers <irogers@google.com> wrote:
>>>>
>>>> On Wed, Sep 28, 2022 at 4:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>>>>
>>>>> On Wed, Sep 28, 2022 at 12:54 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>
>>>>>> On 27/09/22 20:28, Namhyung Kim wrote:
>>>>>>> Hi Adrian,
>>>>>>>
>>>>>>> On Tue, Sep 27, 2022 at 12:06 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>>>
>>>>>>>> On 24/09/22 19:57, Namhyung Kim wrote:
>>>>>>>>> The current code propagate evsel's cpu map settings to evlist when it's
>>>>>>>>> added to an evlist.  But the evlist->all_cpus and each evsel's cpus will
>>>>>>>>> be updated in perf_evlist__set_maps() later.  No need to do it before
>>>>>>>>> evlist's cpus are set actually.
>>>>>>>>>
>>>>>>>>> Actually we discarded this intermediate all_cpus maps at the beginning
>>>>>>>>> of perf_evlist__set_maps().  Let's not do this.  It's only needed when
>>>>>>>>> an evsel is added after the evlist cpu maps are set.
>>>>>>>>
>>>>>>>> That might not be true.  Consider evlist__fix_hybrid_cpus() which fiddles
>>>>>>>> with evsel->core.cpus and evsel->core.own_cpus after the evsel has been
>>>>>>>> added to the evlist.  It can also remove an evsel from the evlist.
>>>>>>>
>>>>>>> Thanks for your review.  I think it's fine to change evsel cpus or to remove
>>>>>>> an evsel from evlist before calling evlist__create_maps().  The function
>>>>>>> will take care of setting evlist's all_cpus from the evsels in the evlist.
>>>>>>> So previous changes in evsel/cpus wouldn't be any special.
>>>>>>>
>>>>>>> After this point, adding a new evsel needs to update evlist all cpus by
>>>>>>> propagating cpu maps.  So I think hybrid cpus should be fine.
>>>>>>> Did I miss something?
>>>>>>
>>>>>> I wondered how it might play out if evlist__fix_hybrid_cpus() reduced the
>>>>>> cpus from the target->cpu_list (using perf record -C) , since after this
>>>>>> patch all_cpus always starts with the target->cpu_list instead of an empty
>>>>>> list.  But then, in the hybrid case, it puts a dummy event that uses the
>>>>>> target cpu list anyway, so the result is the same.
>>>>>>
>>>>>> I don't know if there are any cases where all_cpus would actually need to
>>>>>> exclude some of the cpus from target->cpu_list.
>>>>>
>>>>> I'm not aware of other cases to reduce cpu list.  I think it'd be fine
>>>>> if it has a cpu in the evlist->all_cpus even if it's not used.  The evsel
>>>>> should have a correct list anyway and we mostly use the evsel cpus
>>>>> to do the real work.
>>>>>
>>>>> Thanks,
>>>>> Namhyung
>>>>
>>>> The affinity changes made it so that we use all_cpus probably more
>>>> often than the evsel CPU maps for real work. The reason being we want
>>>> to avoid IPIs so we do all the work on 1 CPU and then move to the next
>>>> CPU in evlist all_cpus. evsel CPU maps are used to make sure the
>>>> indices are kept accurate - for example, if an uncore event is
>>>> measured with a CPU event:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evlist.h?h=perf/core#n366
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evlist.c?h=perf/core#n404
>>>
>>> Right, I meant it'd check the evsel cpus eventually even if it iterates
>>> on the evlist all_cpus.  The evlist_cpu_iterator__next() will skip a
>>> CPU if it's not in the evsel cpus.
>>>
>>> Thanks,
>>> Namhyung
>>
>> Perhaps an alternative is to be explicit about deferring map
>> propagation e.g.
> 
> Thanks for your patch.  Yeah, we can use this.
> 
> But I still think it'd be better doing it unconditionally
> since any propagation before perf_evlist__set_maps
> will be discarded anyway.  With this change, other
> than perf record will collect all cpus before _set_maps
> and then discard it.  It seems like a waste, no?
> 
> Or else, we can have allow_map_propagation initialized
> to false and set it to true in perf_evlist__set_maps().
> 

That sounds fine.
