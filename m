Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9830D5BFC8B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiIUKnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiIUKns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:43:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93D8915E0;
        Wed, 21 Sep 2022 03:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663757027; x=1695293027;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=6dl3gtcacoQl6ANvxmfNKeoatSMTHZtouqyF21KWxHQ=;
  b=FBVN7oxaKvBOXSdz5HTtBCsLBPRW8PRGyOeAih5sAbUZXr+e7srWw4hR
   i5XwGX8Q103DQZaN/n2ucSgXwLlP1J8EdcotCCWejuTcMTqxGGhCXD/rv
   pvnkUnchn1pkdHryPpPZeqacJ1v366SJJsZP5uWkeoRE8cj92O3qkwlEa
   q7ZXn3Cuq6DHPYYnEMZ+oUpg79HxTvjC6aN/PaEUeoDQ3co+R1mkMiSIl
   SoRZiLTU4at83q1/gLSQORRQzXl+EiheTEllfm5S+YrbQWZO4pzKDkWME
   vaEdTtx9vrG94cf/qX0h/nVCp9tRYP3CBtD0rCZ8MP/ILpcnLfnYuc4xR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="299953065"
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="299953065"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 03:43:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,333,1654585200"; 
   d="scan'208";a="708395857"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.33.27])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 03:43:45 -0700
Message-ID: <7e0b9116-7e1f-fc4c-5528-ce5a3e565fa3@intel.com>
Date:   Wed, 21 Sep 2022 13:11:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 3/4] perf record: Save DSO build-ID for synthesizing
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
References: <20220916175902.1155177-1-namhyung@kernel.org>
 <20220916175902.1155177-4-namhyung@kernel.org>
 <571fb9aa-98e7-b42a-aa81-01658e131f11@intel.com>
 <CAM9d7ch4Rb6GxGc2NrHFVz=S5__XdCNCRy2=5Fj=XCYn2b6d3A@mail.gmail.com>
 <c288baa5-abb1-c34c-713c-b9d11873d34a@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <c288baa5-abb1-c34c-713c-b9d11873d34a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/22 10:26, Adrian Hunter wrote:
> On 20/09/22 21:30, Namhyung Kim wrote:
>> On Tue, Sep 20, 2022 at 7:00 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>
>>> On 16/09/22 20:59, Namhyung Kim wrote:
>>>> When synthesizing MMAP2 with build-id, it'd read the same file repeatedly as
>>>> it has no idea if it's done already.  Maintain a dsos to check that and skip
>>>> the file access if possible.
>>>>
>>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>>> ---
>>>>  tools/perf/util/synthetic-events.c | 49 +++++++++++++++++++++++++-----
>>>>  1 file changed, 42 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
>>>> index 9d4f5dacd154..e6978b2dee8f 100644
>>>> --- a/tools/perf/util/synthetic-events.c
>>>> +++ b/tools/perf/util/synthetic-events.c
>>>> @@ -4,6 +4,7 @@
>>>>  #include "util/data.h"
>>>>  #include "util/debug.h"
>>>>  #include "util/dso.h"
>>>> +#include "util/dsos.h"
>>>>  #include "util/event.h"
>>>>  #include "util/evlist.h"
>>>>  #include "util/machine.h"
>>>> @@ -47,12 +48,25 @@
>>>>
>>>>  unsigned int proc_map_timeout = DEFAULT_PROC_MAP_PARSE_TIMEOUT;
>>>>
>>>> +static bool synth_init_done;
>>>> +static struct dsos synth_dsos;
>>>> +
>>>>  void perf_event__synthesize_start(void)
>>>>  {
>>>> +     if (synth_init_done)
>>>> +             return;
>>>> +
>>>> +     dsos__init(&synth_dsos);
>>>> +
>>>> +     synth_init_done = true;
>>>>  }
>>>>
>>>>  void perf_event__synthesize_stop(void)
>>>>  {
>>>> +     if (!synth_init_done)
>>>> +             return;
>>>> +
>>>> +     dsos__exit(&synth_dsos);
>>>>  }
>>>>
>>>>  int perf_tool__process_synth_event(struct perf_tool *tool,
>>>> @@ -374,26 +388,47 @@ static bool read_proc_maps_line(struct io *io, __u64 *start, __u64 *end,
>>>>  static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
>>>>                                            bool is_kernel)
>>>>  {
>>>> -     struct build_id bid;
>>>> +     struct build_id _bid, *bid = &_bid;
>>>> +     struct dso *dso = NULL;
>>>> +     struct dso_id id;
>>>>       int rc;
>>>>
>>>> -     if (is_kernel)
>>>> -             rc = sysfs__read_build_id("/sys/kernel/notes", &bid);
>>>> -     else
>>>> -             rc = filename__read_build_id(event->filename, &bid) > 0 ? 0 : -1;
>>>> +     if (is_kernel) {
>>>> +             rc = sysfs__read_build_id("/sys/kernel/notes", bid);
>>>> +             goto out;
>>>> +     }
>>>> +
>>>> +     id.maj = event->maj;
>>>> +     id.min = event->min;
>>>> +     id.ino = event->ino;
>>>> +     id.ino_generation = event->ino_generation;
>>>>
>>>
>>> There might be some paths missing perf_event__synthesize_start()
>>> e.g. perf trace
>>> So it would probably be safer to use lazy initialization for
>>> synth_dsos.
>>
>> I thought about that too, but it'd need a cleanup routine at the end
>> anyway.  So I ended up having a pair of start/stop routines.
>>
>>>
>>> Also, callers of perf_record_mmap2__read_build_id() have a struct
>>> machine so I wonder about putting synth_dsos in struct machine ?
>>> Or even just using machine->dsos ?
>>
>> My intention was to use minimal info from struct dso - name, id and
>> build-id.  But as it already uses dsos/dso routines, it's not much
>> different from using the existing machine->dsos.
>>
>> So yeah, I think it's good to reuse the existing one as it'd benefit
>> the build-id processing at the end.  Will change.
>>
>> Thanks,
>> Namhyung
>>
>>
>>>
>>>> +     dso = dsos__findnew_id(&synth_dsos, event->filename, &id);
>>>> +     if (dso && dso->has_build_id) {
>>>> +             bid = &dso->bid;
>>>> +             rc = 0;
>>>> +             goto out;
>>>> +     }
> 
> Also I guess the dsos optimization could be a separate patch ?

Disregard that - I thought there were other changes too.
