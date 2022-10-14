Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F11B5FEC0B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJNJrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJNJrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:47:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AFDF1C8411;
        Fri, 14 Oct 2022 02:47:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A04FE13D5;
        Fri, 14 Oct 2022 02:47:43 -0700 (PDT)
Received: from [10.57.4.130] (unknown [10.57.4.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E03E63F67D;
        Fri, 14 Oct 2022 02:47:35 -0700 (PDT)
Message-ID: <912a4d0a-51b3-591b-8c8f-f078216d5b35@arm.com>
Date:   Fri, 14 Oct 2022 10:47:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] perf: Fix "Track with sched_switch" test by not printing
 warnings in quiet mode
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20221012111025.30609-1-james.clark@arm.com>
 <62f485df-4f5e-64a2-1294-6e162de25556@arm.com>
 <CAM9d7cgNrZ6iwRQsGHWGLWCd7cJm+L6UOU9BiGGgTVPdJ0_GJQ@mail.gmail.com>
 <e0b47b51-87f0-42db-4a76-b240bf07cd41@arm.com>
 <CAM9d7cg+tTw5vTOycqRciQx8He-WLG0TSdcWa0tyzeu49DmgxA@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAM9d7cg+tTw5vTOycqRciQx8He-WLG0TSdcWa0tyzeu49DmgxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/10/2022 17:57, Namhyung Kim wrote:
> On Wed, Oct 12, 2022 at 10:12 AM James Clark <james.clark@arm.com> wrote:
>>
>>
>>
>> On 12/10/2022 17:50, Namhyung Kim wrote:
>>> On Wed, Oct 12, 2022 at 4:13 AM James Clark <james.clark@arm.com> wrote:
>>>>> The test already supplies -q to run in quiet mode, so extend quiet mode
>>>>> to perf_stdio__warning() and also ui__warning() for consistency.
>>>
>>> I'm not sure if suppressing the warnings with -q is a good thing.
>>> Maybe we need to separate warning/debug messages from the output.
>>
>> I don't see the issue with warnings being suppressed in quiet mode as
>> long as errors are still printed. In other cases warnings have already
>> been suppressed by quiet mode and this site is the odd one out.
>>
>> What use case are you thinking of where someone explicitly adds -q but
>> wants to see non fatal warnings?
> 
> I don't have any specific use case.  If it's already suppressed in other
> cases, I'm fine with it.
> 

Actually I may have been mistaken. Seems like quiet is only used for
"extra info" type messages rather than warnings. Although the commit
message does say:

  The -q/--quiet option is to suppress any message. Sometimes users just
  want to see the numbers and it can be used for that case.

With 'any' that I would take to include warnings as well. I could move
warnings to stderr, but this has a much greater chance of breaking
anyone's workflows that might be looking for warnings on stdout than
removing warnings when -q is provided.

Also if warnings are moved to stderr and quiet isn't used, there would
be no way to suppress warnings in the TUI which might actually be a
useful feature.

So I'm still leaning towards the original change, if you are ok with
that even though it's not done elsewhere?

> Thanks,
> Namhyung
