Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E706D590B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjDDG6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjDDG5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:57:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEA22705;
        Mon,  3 Apr 2023 23:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680591474; x=1712127474;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ycJSe4PfEiKGfDpA/+hLk/UqjGNkUuXPvwkslTScM9M=;
  b=nBadR7mJa+zqog6WSwqrXrIEoGD0kisIEt9DHiXunIlZrBfoK0BHKgja
   STENvujWkTl3nE9X91J0kmKNtJesWxE4yca/lolhJIPUqtpctICiruLWg
   zJcWHoMwMPBv05S3DGT3sdIHMTiBlPaIFSJNk66HCYTtFK/JI6VFgAF3e
   hkoa5CMGPkn059pdLc45tzpmMox2cJ/AkptX4PPX2WuN9/TMmQKtMYAYR
   WkxpvjRw2h+7Pjk4zCfld1HA9MMbT2EZvO0urrm/PUiaOrbkqicxnDuZu
   WuwxVKo9J4fEZ7KFudgMK9Llh/CEP5u8t/O3KlGT9/ERTRgSWUoCj4k4y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="343807344"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="343807344"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 23:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="636413403"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="636413403"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.33.86])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 23:57:49 -0700
Message-ID: <54129783-2960-84e1-05e9-97ac70ffb432@intel.com>
Date:   Tue, 4 Apr 2023 09:57:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH 0/1] perf report: append inlines to non-dwarf callchains
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Artem Savkov <asavkov@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <20230316133557.868731-1-asavkov@redhat.com>
 <CAM9d7ciT7Wtmxt0_2ZVv4nbAb1KoeX_itTSAhz8B9T41-NeZYQ@mail.gmail.com>
 <ZBQZoyJc7mhUrL8n@samus.usersys.redhat.com>
 <CAM9d7ch9NjnaB5dB6fO7WKdwPd8M9DmNpdu4-V-8R+96ssxMvA@mail.gmail.com>
 <ZBtalEw0qKQFlVWR@kernel.org>
 <8f7077e8-bcce-a13f-48d3-92a3cb80b02a@intel.com>
 <20230331085224.GA688995@samus.usersys.redhat.com>
 <ZCs3WX4klUpe+aso@kernel.org>
 <CAM9d7cgOA97n10FPz0Bwjtmfon1En+CN2K7CYL3fQ6nrjBqF9Q@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7cgOA97n10FPz0Bwjtmfon1En+CN2K7CYL3fQ6nrjBqF9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/04/23 08:47, Namhyung Kim wrote:
> On Mon, Apr 3, 2023 at 1:30 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>
>> Em Fri, Mar 31, 2023 at 10:52:24AM +0200, Artem Savkov escreveu:
>>> On Thu, Mar 30, 2023 at 08:06:20AM +0300, Adrian Hunter wrote:
>>>> On 22/03/23 21:44, Arnaldo Carvalho de Melo wrote:
>>>>> Em Wed, Mar 22, 2023 at 11:18:49AM -0700, Namhyung Kim escreveu:
>>>>>> On Fri, Mar 17, 2023 at 12:41 AM Artem Savkov <asavkov@redhat.com> wrote:
>>>>>>>
>>>>>>> On Thu, Mar 16, 2023 at 02:26:18PM -0700, Namhyung Kim wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> On Thu, Mar 16, 2023 at 6:36 AM Artem Savkov <asavkov@redhat.com> wrote:
>>>>>>>>>
>>>>>>>>> In an email to Arnaldo Andrii Nakryiko suggested that perf can get
>>>>>>>>> information about inlined functions from dwarf when available and then
>>>>>>>>> add it to userspace stacktraces even in framepointer or lbr mode.
>>>>>>>>> Looking closer at perf it turned out all required bits and pieces are
>>>>>>>>> already there and inline information can be easily added to both
>>>>>>>>> framepointer and lbr callchains by adding an append_inlines() call to
>>>>>>>>> add_callchain_ip().
>>>>>>>>
>>>>>>>> Looks great!  Have you checked it with perf report -g callee ?
>>>>>>>> I'm not sure the ordering of inlined functions is maintained
>>>>>>>> properly.  Maybe you can use --no-children too to simplify
>>>>>>>> the output.
>>>>>>>
>>>>>>> Thanks for the suggestion. I actually have another test program with
>>>>>>> functions being numbered rather than (creatively) named, so it might be
>>>>>>> easier to use it to figure out ordering. Here's the code:
>>>>>>
>>>>>> Yep, looks good.
>>>>>>
>>>>>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>>>>>
>>>>> So, I'll apply this shorter patch instead, ok?
>>>>>
>>>>> - Arnaldo
>>>>>
>>>>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
>>>>> index 803c9d1803dd26ef..abf6167f28217fe6 100644
>>>>> --- a/tools/perf/util/machine.c
>>>>> +++ b/tools/perf/util/machine.c
>>>>> @@ -44,6 +44,7 @@
>>>>>  #include <linux/zalloc.h>
>>>>>
>>>>>  static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock);
>>>>> +static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms, u64 ip);
>>>>>
>>>>>  static struct dso *machine__kernel_dso(struct machine *machine)
>>>>>  {
>>>>> @@ -2322,6 +2323,10 @@ static int add_callchain_ip(struct thread *thread,
>>>>>   ms.maps = al.maps;
>>>>>   ms.map = al.map;
>>>>>   ms.sym = al.sym;
>>>>> +
>>>>> + if (append_inlines(cursor, &ms, ip) == 0)
>>>>> +         return 0;
>>>>> +
>>>>>   srcline = callchain_srcline(&ms, al.addr);
>>>>>   return callchain_cursor_append(cursor, ip, &ms,
>>>>>                                  branch, flags, nr_loop_iter,
>>>>
>>>> This seems to be breaking --branch-history.  I am not sure
>>>> append_inlines() makes sense for branches.  Maybe this should be:
>>>>
>>>>     if (!branch && !append_inlines(cursor, &ms, ip))
>>>>             return 0;
>>>>
>>>
>>> Right. So when cllchain_cursor is appended through append_inlines it
>>> always discards branch information, even for the non-inlined function.
>>> So adding !branch makes sense to me. Does anyone else see any problems
>>> with that?
>>
>> I'm no expert in this specific area, so for now till we get to a
>> conclusion on this, I'll follow Andi's suggestion and revert this patch.
> 
> I think we can simply apply Adrian's patch above.

Yes.  The thing is, inserting inline functions into a branch
stack doesn't work very well.  For example, there can be multiple
branches in the same inline function, so adding the inlines on
every branch makes a mess.  Then there is how to handle branching
out of, and then back into, the same inline function - or is it
a second instance of the inline function...  All too hard, so just
don't try.  At least for now.

