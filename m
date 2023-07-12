Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D5674FED6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjGLFoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 01:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjGLFoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:44:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290CD173B;
        Tue, 11 Jul 2023 22:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689140667; x=1720676667;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xkJNOQbIe3Ek/OWTXqgC8D9Wm7aeIy2w4ZWDPqFFbw4=;
  b=EzPBQ98aO4uKmBBLLl81dc4Z12Kkfo4wu7QqOR9Vgdy85J5yQPcOGoPa
   dhk05ixNJk6nFbPDAmfHSTmtkBzdzoobRea0kUVtPurOFqrURXFKUSQVc
   +oVHrenbDjymtjakX1phvG6hllOn5+1f2p40HbUMXNRLPdiLp+8sEx79K
   u6F75fCjjyAcbLkVMNFQNSR8u+X/+6aOhDzVvgCy6y9G9K1r9EN83IXQM
   4r4l7+13hnglvhKK14q7FECDfnnPOPOgZTO4/LFL4XjnveXs1fvqG+TfH
   4rpzoqYs7dYnCxZO7caNO8jG0N+C/mw7c1jbdgXatWvmksxAx8898C/RI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="368342779"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="368342779"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 22:44:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="724745735"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="724745735"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.166])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 22:44:17 -0700
Message-ID: <8256a332-6a9c-c552-ceb5-fc6cc08792cd@intel.com>
Date:   Wed, 12 Jul 2023 08:44:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] perf machine: Include data symbols in the kernel map
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230620201818.1670753-1-namhyung@kernel.org>
 <20230620201818.1670753-3-namhyung@kernel.org>
 <a791e982-ada3-7f26-e105-bc7fa9c7d346@intel.com>
 <CAM9d7cjZA9JD_bxkaRyJxgt4sirCvwdyCARVTGMPOGHsip+MHA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAM9d7cjZA9JD_bxkaRyJxgt4sirCvwdyCARVTGMPOGHsip+MHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/23 20:30, Namhyung Kim wrote:
> Hi Adrian,
> 
> On Tue, Jul 11, 2023 at 8:19 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 20/06/23 23:18, Namhyung Kim wrote:
>>> When perf record -d is used, it needs data mmaps to symbolize global data.
>>> But it missed to collect kernel data maps so it cannot symbolize them.
>>> Instead of having a separate map, just increase the kernel map size to
>>> include the data section.
>>>
>>> Probably we can have a separate kernel map for data, but the current
>>> code assumes a single kernel map.  So it'd require more changes in other
>>> places and looks error-prone.  I decided not to go that way for now.
>>>
>>> Also it seems the kernel module size already includes the data section.
>>>
>>> For example, my system has the following.
>>>
>>>   $ grep -e _stext -e _etext -e _edata /proc/kallsyms
>>>   ffffffff99800000 T _stext
>>>   ffffffff9a601ac8 T _etext
>>>   ffffffff9b446a00 D _edata
>>>
>>> Size of the text section is (0x9a601ac8 - 0x99800000 = 0xe01ac8) and
>>> size of the data section is (0x9b446a00 - 0x99800000 = 0x1c46a00).
>>>
>>> Before:
>>>   $ perf record -d true
>>>
>>>   $ perf report -D | grep MMAP | head -1
>>>   0 0 0x460 [0x60]: PERF_RECORD_MMAP -1/0: [0xffffffff99800000(0xe01ac8) @ 0xffffffff99800000]: x [kernel.kallsyms]_text
>>>                                                                ^^^^^^^^
>>>                                                                  here
>>> After:
>>>   $ perf report -D | grep MMAP | head -1
>>>   0 0 0x460 [0x60]: PERF_RECORD_MMAP -1/0: [0xffffffff99800000(0x1c46a00) @ 0xffffffff99800000]: x [kernel.kallsyms]_text
>>>                                                                ^^^^^^^^^
>>>
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>> ---
>>>  tools/perf/util/machine.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
>>> index ddc0a2130caf..e93a66f6e0b3 100644
>>> --- a/tools/perf/util/machine.c
>>> +++ b/tools/perf/util/machine.c
>>> @@ -1218,7 +1218,10 @@ static int machine__get_running_kernel_start(struct machine *machine,
>>>
>>>       *start = addr;
>>>
>>> -     err = kallsyms__get_function_start(filename, "_etext", &addr);
>>> +     if (machine->has_data_mmap)
>>> +             err = kallsyms__get_symbol_start(filename, "_edata", &addr);
>>> +     else
>>> +             err = kallsyms__get_function_start(filename, "_etext", &addr);
>>
>> What is the downside of just extending it unconditionally?
> 
> I don't know.. maybe some people would argue it needs the
> proper protection bits other than 'x' but this patch also breaks it.
> But as I said, I'm not sure if we really want to change that now.
> 
> That said, we can make it unconditional. :)

Might as well to start with.  Will need a big comment.

Also do we know if all arch's do it like that? Perhaps
need to fallback to _etext if _edata is not found?

> 
> Thanks,
> Namhyung
> 
>>
>>>       if (!err)
>>>               *end = addr;
>>>
>>

