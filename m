Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846136E1019
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjDMOgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjDMOgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:36:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F91974C;
        Thu, 13 Apr 2023 07:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681396564; x=1712932564;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T/ZUvz7oMcvV2CPYNInpUDKAXpWDuzC83GegLLXLcxQ=;
  b=Ye59tWXGPvFHaeaxqzxc81S1ZdyiceEzPDy6t/eE3V4YhskNaNacj64W
   vz9xw4DIOOrN1i2Nm5V8OhuIOaMj0mbIHrculL4gnqkMf8EImHcpkRBkV
   Pf1en6jVqRxU9/g83Ct+DM9z6qOhFmE/oH83dgECU7XDaf+mwbqxvBd45
   oPY+155/Gt6u+ZswYg4lcQk29B3G3xCaWNsZ6nNUmZvecMKslPVPGWvLM
   5SQkOYfB/cVU5tHz32VO9zI0OD/EjXhF2rhxfZhtl2v/bSVjY4R6e32nK
   qPldPeFK8F/8OJ/8ksqoyZvx+ONcBcisFH+ux710e7b5OzEBV70Jl2UGM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="324552677"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="324552677"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 07:36:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="666803538"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="666803538"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 13 Apr 2023 07:36:03 -0700
Received: from [10.209.83.224] (kliang2-mobl1.ccr.corp.intel.com [10.209.83.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 178DA580BEE;
        Thu, 13 Apr 2023 07:36:01 -0700 (PDT)
Message-ID: <7959b7f8-8985-54bb-8161-7c5799d8ac72@linux.intel.com>
Date:   Thu, 13 Apr 2023 10:36:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1] perf stat: Introduce skippable evsels
Content-Language: en-US
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
References: <20230411205622.3266490-1-irogers@google.com>
 <aaa41580-e30a-5a3a-7917-042ddaffe9cf@linux.intel.com>
 <CAP-5=fUnqi3KCEzu8qC8qG+g__qTmCVzc9skNb5yFzz=Fa02QQ@mail.gmail.com>
 <87eb928a-9c66-f821-0f20-22d21c96b7a5@linux.intel.com>
 <CAP-5=fUELu6nT8sGjkPvzKOX2qxH-w9q5mJgsjLBoYwAQ5bP6Q@mail.gmail.com>
 <2a6f6cf3-3de1-33e4-3b51-8c702c270bda@linux.intel.com>
 <CAP-5=fV_6Tjrc3PgEzHbXMvXJNerBOfTnrqb5eyZtjA4dRB0HQ@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fV_6Tjrc3PgEzHbXMvXJNerBOfTnrqb5eyZtjA4dRB0HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-13 9:52 a.m., Ian Rogers wrote:
> On Thu, Apr 13, 2023 at 6:36 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2023-04-12 2:01 p.m., Ian Rogers wrote:
>>>> - We shouldn't only rely on the event list file. We need to do runtime
>>>> check on the availability of events. Either perf_event_open() or
>>>> /sys/devices/cpu/events/ is fine (althourh personally I prefer sys way,
>>>> since I think it's easier).
>>> Using perf_event_open is the status quo and the sysfs approach is
>>> impractical imo. I think the only thing that is needed in v2 is for
>>> <not counted> to be displayed for skippable evsels.
>>
>> Using perf_event_open is good to check features. If the feature is not
>> supported by the kernel, it will be explicitly rejected.
>> But I'm not sure about the availability of events. The kernel doesn't
>> check every events. For example, on ICL and later platform, we have
>> event=0x00,umask=0x8X for all the topdown metrics events. If we open
>> them on SKL, the perf_event_open will also success, but return 0 value.
> 
> Thanks Kan,
> 
> The behavior change in perf-tools-next is to use the TopdownL1 metric
> group rather than programming the events and then having hard coded
> metrics if we spot the events enabled. On SKL the TopdownL1 metric
> group will give SKL top down metrics which don't use topdown events
> because, as you point out, they don't exist. The only way to program
> event=0x00,umask=0x8X on SKL would be through a raw event, so I don't
> think there is any issue here.

On ICL/SPR, even if the perf metrics feature isn't available (e.g., in
VM), the current kernel doesn't reject the event=0x00,umask=0x8X, which
the TopdownL1 will eventually use.
But maybe the best way is to change the kernel to not only hide the
topdown metrics event but also explicitly reject them, if the feature is
not available.

Thanks,
Kan
