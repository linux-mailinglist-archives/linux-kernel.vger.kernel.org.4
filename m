Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74231680B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbjA3K45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbjA3K4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:56:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBBB917CCD;
        Mon, 30 Jan 2023 02:56:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8750016F2;
        Mon, 30 Jan 2023 02:57:35 -0800 (PST)
Received: from [10.57.46.210] (unknown [10.57.46.210])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9AA23F71E;
        Mon, 30 Jan 2023 02:56:50 -0800 (PST)
Message-ID: <43ff6d3d-2047-1b2f-12ab-849a915a6e2f@arm.com>
Date:   Mon, 30 Jan 2023 10:56:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/4] perf intel-pt: Fix the pipe mode (v1)
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Denis Nikitin <denik@chromium.org>,
        Stephane Eranian <eranian@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>
References: <20230127001951.3432374-1-namhyung@kernel.org>
 <bda606c2-2b1b-de9f-1386-8ee2bf925b4b@intel.com>
 <317a91ff-70c5-57a5-8447-7543057e4055@arm.com>
 <CAM9d7chU6kTdG0y65_UaD_hW75GezzNJF1ZwjNWq8BUpACAGTA@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAM9d7chU6kTdG0y65_UaD_hW75GezzNJF1ZwjNWq8BUpACAGTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/01/2023 23:08, Namhyung Kim wrote:
> Hi James,
> 
> On Fri, Jan 27, 2023 at 6:42 AM James Clark <james.clark@arm.com> wrote:
>>
>>
>>
>> On 27/01/2023 07:22, Adrian Hunter wrote:
>>> On 27/01/23 02:19, Namhyung Kim wrote:
>>>> Hello,
>>>>
>>>> I found some problems in Intel-PT and auxtrace in general with pipe.
>>>> In the past it used to work with pipe, but recent code fails.
>>>
>>> Pipe mode is a problem for Intel PT and possibly other auxtrace users.
>>
>> Just some info from my side: For Arm Coresight we ended up deprecating
>> pipe mode, then not supporting it altogether. First was when we added an
>> optional step to peek through all of the data to help with an edge case.
>> Then we added a requirement to receive a HW_ID packet before decoding
>> which necessitated the peek. You can't peek in pipe mode because you
>> need to be able to seek, so it's not supported at all anymore.
>>
>> For Arm SPE I never tested it with piped data. I suppose I could add a
>> test at some point, but I don't really see the usecase.
> 
> Yeah, it'd be great if we can have a test for Arm SPE.
> 

Ok thanks I will put it on the list of things to do.

> Anyway, my work env (Google) requires the pipe mode due to the
> restriction in disk usage.  Without the pipe support, it's not possible
> to run `perf record` in production.
> 

Makes sense. Unfortunately at the moment with Coresight, because of the
lack of appropriate timestamps we're waiting for the end of the file
before starting decoding. So you're not really any better off using
piped mode, unless you have a lot more memory than disk space?

Since this commit [1] and Arm v8.4 we can actually start making use of
the timestamps and do a streaming decode again. So I will also add it to
the list to look into that for Coresight again. Are you using an old
version of Perf or not using Coresight at all? I know Denis at Google is
using Coresight, but only with files rather than pipes.

One other thing, have you used the --switch-output mode to perf record
before? I would have said it would give you some of the benefits of
piped mode, but is more likely to work with Coresight. But last time I
checked it's not working either. Not very helpful I know, but something
to keep in mind.

James

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf/core&id=a7fe9a443b6064c68f86a2ee09bdfa7736660ef3
