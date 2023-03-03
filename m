Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B22C6A9DCA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjCCRg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCCRgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:36:55 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CE7B44E;
        Fri,  3 Mar 2023 09:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677865014; x=1709401014;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=53YO1WGPLlrAsnqfxbpbcOnEwzAeo87kJqM4uTjUf4I=;
  b=da9jO8Na9B+se/hVMROVZOQxeb2QABxdOZDR9b2xbyfVEMm7/tIrvsTo
   AuJidCIJ4wFFfRZdUx7q39Im21Uyw3YHT0hvS8wuWqWodgkt2mPpujDVy
   JC2uytZ3UkRl8ilJE4SCIP6JVzsAazKQna22ijuHQEYDgvXQk22P8g76/
   sv3CuFnAsSVAEVQ95uDvbLtPJxkcbM/wTvJ5HZhCIXwE2lLltYbe/NQrP
   3RBhm9ZOAIqzgX38+/aV7z36yqHt8JRKKxTZ09HsaWO3h9aGO7I9joYHy
   JFiPMD307Ww/MlrppohoQadLZaHmDCpPlrpP82Pn+HUzJKX3WEdwiDrK1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="399914315"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="399914315"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 09:36:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="739576152"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="739576152"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 03 Mar 2023 09:36:52 -0800
Received: from [10.212.168.11] (kliang2-mobl1.ccr.corp.intel.com [10.212.168.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E13A3580689;
        Fri,  3 Mar 2023 09:36:49 -0800 (PST)
Message-ID: <08b6d2c9-b6f9-fdbd-e871-b81437cca218@linux.intel.com>
Date:   Fri, 3 Mar 2023 12:36:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 02/10] perf stat: Don't remove all grouped events when
 CPU maps disagree
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
References: <20230302212531.1043318-1-irogers@google.com>
 <20230302212531.1043318-3-irogers@google.com>
 <962de75d-8e27-9b47-662e-e324b3ba5812@linux.intel.com>
 <CAP-5=fXiRtKF661e=-4dX30ooV7uKQbidjaaDhjckVRdjw7CzA@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fXiRtKF661e=-4dX30ooV7uKQbidjaaDhjckVRdjw7CzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-03 11:44 a.m., Ian Rogers wrote:
> On Fri, Mar 3, 2023 at 7:50 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2023-03-02 4:25 p.m., Ian Rogers wrote:
>>> If the events in an evlist's CPU map differ then the entire group is
>>> removed. For example:
>>>
>>> ```
>>> $ perf stat -e '{imc_free_running/data_read/,imc_free_running/data_write/,cs}' -a sleep 1
>>> WARNING: grouped events cpus do not match, disabling group:
>>>   anon group { imc_free_running/data_read/, imc_free_running/data_write/, cs }
>>> ```
>>>
>>> Change the behavior so that just the events not matching the leader
>>> are removed. So in the example above, just 'cs' will be removed.
>>>
>>> Modify the warning so that it is produced once for each group, rather
>>> than once for the entire evlist. Shrink the scope and size of the
>>> warning text buffer.
>>
>> For the uncore, we usually have to create a group for each uncore PMU.
>> The number of groups may be big. For example, on ICX, we have 40 CHA
>> PMUs. For SPR, there should be more CHAs. If we have something like
>> {cycles,uncore_cha/event=0x1/}, is the warning shown 40 times on ICX?
>> If so, it should be very annoying.
>>
>> Maybe it's better to keep the current behavior which only print a
>> warning once and notify the users that perf will re-group the events.
>> For the details, they can get it from the -v option.
> 
> Thanks Kan, I could imagine that but I was also worried about cases
> where there are multiple groups like:
> 
> ```
> $ perf stat -e '{imc_free_running/data_read/,cs},{uncore_clock/clockticks/,cs}'
> -a sleep 1
> WARNING: grouped events cpus do not match.
> Events with CPUs not matching the leader will be removed from the group.
>  anon group { imc_free_running/data_read/, cs }
> WARNING: grouped events cpus do not match.
> Events with CPUs not matching the leader will be removed from the group.
>  anon group { uncore_clock/clockticks/, cs }
> 
> Performance counter stats for 'system wide':
> 
>          1,255.75 MiB  imc_free_running/data_read/
>             7,571      cs
>     1,327,285,527      uncore_clock/clockticks/
>             7,571      cs
> 
>       1.002772882 seconds time elapsed
> ```
> 
> Knowing that both groups were broken there feels like a value add.
> Given that this is a warning, and it can be fixed by moving the event
> out of the group or forcing the CPUs, I lean toward being
> informative/spammy as the spam is somewhat straightforwardly fixed on
> the command line.


I did some tests with the patch. The issue I was worried about didn't
occur. The change looks good to me.

But I found another issue. If I specify a CPU set, the group removal
fails. It's not an issue of this patch. It looks like the current perf
compares the user defined CPU set, rather than the PMU's cpumask.

./perf stat -e '{cycles,uncore_cha/event=0x1/}' -C0 sleep 1

 Performance counter stats for 'CPU(s) 0':

     <not counted>      cycles
   <not supported>      uncore_cha/event=0x1/

       1.001783936 seconds time elapsed

Some events weren't counted. Try disabling the NMI watchdog:
        echo 0 > /proc/sys/kernel/nmi_watchdog
        perf stat ...
        echo 1 > /proc/sys/kernel/nmi_watchdog
The events in group usually have to be from the same PMU. Try
reorganizing the group.

Thanks,
Kan

> 
> Thanks,
> Ian
> 
>> Thanks,
>> Kan
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/builtin-stat.c | 24 +++++++++++++++---------
>>>  1 file changed, 15 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>>> index d70b1ec88594..5c12ae5efce5 100644
>>> --- a/tools/perf/builtin-stat.c
>>> +++ b/tools/perf/builtin-stat.c
>>> @@ -181,14 +181,13 @@ static bool cpus_map_matched(struct evsel *a, struct evsel *b)
>>>
>>>  static void evlist__check_cpu_maps(struct evlist *evlist)
>>>  {
>>> -     struct evsel *evsel, *pos, *leader;
>>> -     char buf[1024];
>>> +     struct evsel *evsel, *warned_leader = NULL;
>>>
>>>       if (evlist__has_hybrid(evlist))
>>>               evlist__warn_hybrid_group(evlist);
>>>
>>>       evlist__for_each_entry(evlist, evsel) {
>>> -             leader = evsel__leader(evsel);
>>> +             struct evsel *leader = evsel__leader(evsel);
>>>
>>>               /* Check that leader matches cpus with each member. */
>>>               if (leader == evsel)
>>> @@ -197,19 +196,26 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
>>>                       continue;
>>>
>>>               /* If there's mismatch disable the group and warn user. */
>>> -             WARN_ONCE(1, "WARNING: grouped events cpus do not match, disabling group:\n");
>>> -             evsel__group_desc(leader, buf, sizeof(buf));
>>> -             pr_warning("  %s\n", buf);
>>> -
>>> +             if (warned_leader != leader) {
>>> +                     char buf[200];
>>> +
>>> +                     pr_warning("WARNING: grouped events cpus do not match.\n"
>>> +                             "Events with CPUs not matching the leader will "
>>> +                             "be removed from the group.\n");
>>> +                     evsel__group_desc(leader, buf, sizeof(buf));
>>> +                     pr_warning("  %s\n", buf);
>>> +                     warned_leader = leader;
>>> +             }
>>>               if (verbose > 0) {
>>> +                     char buf[200];
>>> +
>>>                       cpu_map__snprint(leader->core.cpus, buf, sizeof(buf));
>>>                       pr_warning("     %s: %s\n", leader->name, buf);
>>>                       cpu_map__snprint(evsel->core.cpus, buf, sizeof(buf));
>>>                       pr_warning("     %s: %s\n", evsel->name, buf);
>>>               }
>>>
>>> -             for_each_group_evsel(pos, leader)
>>> -                     evsel__remove_from_group(pos, leader);
>>> +             evsel__remove_from_group(evsel, leader);
>>>       }
>>>  }
>>>
