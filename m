Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F979740EF1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjF1Kgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:36:40 -0400
Received: from foss.arm.com ([217.140.110.172]:53442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232430AbjF1Keb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:34:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D4A7C14;
        Wed, 28 Jun 2023 03:35:14 -0700 (PDT)
Received: from [10.57.27.176] (unknown [10.57.27.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84DD03F663;
        Wed, 28 Jun 2023 03:34:28 -0700 (PDT)
Message-ID: <d5618d0b-1441-0c04-4b09-768bfe7b7ee7@arm.com>
Date:   Wed, 28 Jun 2023 11:34:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] perf report: Don't add to histogram when there is no
 thread found
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
References: <20230626161059.324046-1-james.clark@arm.com>
 <20230626161059.324046-3-james.clark@arm.com> <ZJonE3ZZ2cBUq0U8@google.com>
 <CAP-5=fX+FDAkFoMhQY27_+fiRp_UDruP8qWTdjvqU5-uE0SdWA@mail.gmail.com>
 <CAM9d7cj4xr6oTDKvxbNTVUewyZFTBchQS36KC0nN4i4HjCsq5w@mail.gmail.com>
 <CAP-5=fUTzn06DM7o-1qBx7Tauo2Q2ACHmYcvwTmrTOJpzS2=oQ@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fUTzn06DM7o-1qBx7Tauo2Q2ACHmYcvwTmrTOJpzS2=oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/06/2023 18:19, Ian Rogers wrote:
> On Tue, Jun 27, 2023 at 9:58 AM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> On Tue, Jun 27, 2023 at 9:43 AM Ian Rogers <irogers@google.com> wrote:
>>>
>>> On Mon, Jun 26, 2023 at 5:02 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>>>
>>>> On Mon, Jun 26, 2023 at 05:10:58PM +0100, James Clark wrote:
>>>>> thread__find_map() chooses to exit without assigning a thread to the
>>>>> addr_location in some scenarios, for example when there are samples from
>>>>> a guest and perf_guest == false. This results in a segfault when adding
>>>>> to the histogram because it uses unguarded accesses to the thread member
>>>>> of the addr_location.
>>>>
>>>> Looking at the commit 0dd5041c9a0ea ("perf addr_location: Add
>>>> init/exit/copy functions") that introduced the change, I'm not sure if
>>>> it's the intend behavior.
>>>>
>>>> It might change maps and map, but not thread.  Then I think no reason
>>>> to not set the al->thread at the beginning.
>>>>
>>>> How about this?  Ian?
>>>> (I guess we can get rid of the duplicate 'al->map = NULL' part)
>>>
>>> It seemed strange that we were failing to find a map (the function's
>>> purpose) but then populating the address_location. The change below
>>> brings back that somewhat odd behavior. I'm okay with reverting to the
>>> old behavior, clearly there were users relying on it. We should
>>> probably also copy maps and not just thread, as that was the previous
>>> behavior.
>>
>> Probably.  But it used to support samples without maps and I think
>> that's why it ignores the return value of thread__find_map().  So
>> we can expect al.map is NULL and maybe fine to leave it for now.
>>
>> As machine__resolve() returns -1 if it gets no thread, we should set
>> al.thread when it returns 0.
>>
>> Can I get your Acked-by?
> 
> Yep:
> Acked-by: Ian Rogers <irogers@google.com>

Looks good to me too. Should I resend the set with this change instead
of my one?

> 
> Thanks,
> Ian
> 
>> Thanks,
>> Namhyung
