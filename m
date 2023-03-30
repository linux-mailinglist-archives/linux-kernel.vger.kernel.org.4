Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738DF6CFE01
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjC3IS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC3ISD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:18:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81C8019B3;
        Thu, 30 Mar 2023 01:17:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37F841FB;
        Thu, 30 Mar 2023 01:18:40 -0700 (PDT)
Received: from [10.57.18.220] (unknown [10.57.18.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0318C3F73F;
        Thu, 30 Mar 2023 01:17:53 -0700 (PDT)
Message-ID: <c2244382-8696-a27b-e817-32a7b146fc13@arm.com>
Date:   Thu, 30 Mar 2023 09:17:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [BUG] perf: No samples found when using kcore + coresight
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        LAK <linux-arm-kernel@lists.infradead.org>,
        coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mathieu.poirier@linaro.org, adrian.hunter@intel.com,
        Jiri Olsa <jolsa@kernel.org>, acme@redhat.com,
        mike.leach@linaro.org, Will Deacon <will@kernel.org>,
        suzuki.poulose@arm.com, yang@os.amperecomputing.com
References: <CAHbLzkrJQTrYBtPkf=jf3OpQ-yBcJe7XkvQstX9j2frz4WF-SQ@mail.gmail.com>
 <8ca2b07e-674e-afb6-ff12-87504f51f252@arm.com>
 <CAHbLzkpf4RUZugKdn-uXC5m3RpAQH5aDmRXdsxPZi0Cbf-yiyw@mail.gmail.com>
 <CAHbLzkq_7aXcys1cpgGFsfMDDDKMsT3e7zdNW=0jAkw7kBtJ0Q@mail.gmail.com>
 <20230309113851.GF19253@leoy-yangtze.lan>
 <CAHbLzkpvLHnyL5J5kB_ke3CWVq2=MOEdEQsGex56+Esfgqh1=g@mail.gmail.com>
 <20230313121420.GB2426758@leoy-yangtze.lan>
 <CAHbLzkpZjrd401DEKnnCNMdra0f6kGRe1Nh_rTovNTmyD8aBpg@mail.gmail.com>
 <20230314003610.GD2426758@leoy-yangtze.lan>
 <64db6d95-8aca-48cc-80e1-e68211922071@arm.com>
 <CAHbLzkoFkxpLuaW93nPrxxvtuHiRmObOnZfRY9YPXcGumzv33A@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAHbLzkoFkxpLuaW93nPrxxvtuHiRmObOnZfRY9YPXcGumzv33A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/03/2023 00:25, Yang Shi wrote:
> On Wed, Mar 29, 2023 at 9:08 AM James Clark <james.clark@arm.com> wrote:
>>
>>
>>
>> On 14/03/2023 00:36, Leo Yan wrote:
>>> On Mon, Mar 13, 2023 at 11:15:44AM -0700, Yang Shi wrote:
>>>
>>> [...]
>>>
>>>>> Just a quick summary, here we have two issues:
>>>>>
>>>>> - With command:
>>>>>   perf record -e cs_etm/@tmc_etf63/k --kcore --per-thread \
>>>>>   -- taskset --cpu-list 1 uname",
>>>>>
>>>>>   perf doesn't enable "text poke" attribution.
>>>>
>>>> No, it enables "text poke" and perf fails to decode coresight trace
>>>> data too. It doesn't matter whether "--kcore" is after or before "-e
>>>> cs/etm/@tmc_etf63/k".
>>>
>>> Understand now.  Thanks for correction, if so we can ignore this one.
>>>
>>> Leo
>>
>> To me it looks like it's only --per-thread and --kcore together that
>> cause the issue. I can't see if that was mentioned previously in this
>> thread.
> 
> If "--pre-thread" is not passed in, perf record failed with "failed to
> mmap with 12 (Cannot allocate memory)". Sorry for not mentioning this
> in the first place. I was quite focused on --kcore and didn't realize
> they may be related.

That's unrelated. That's because you have specified a sink and without
--per-thread it tries to open the event on all cores. If the sink can't
be reached from all cores it will fail to open. You can make it work
without --per-thread if you limit it to a valid core like this, although
I don't know which ones exactly would be valid for your system:


  perf record -e cs_etm/@tmc_etf63/k --kcore -C 0 \
     -- taskset --cpu-list 1 uname

> 
>>
>> If it is --per-thread that's causing the issue then I think I have an
>> idea why it might be. There are some assumptions and different paths
>> taken in decoding in that mode that aren't correct. It causes some other
>> issues to do with ordering and timestamps as well and I wanted to fix it
>> previously. I wouldn't say that the text-poke change has caused a
>> regression, as decoding in this mode was always a bit buggy.
>>
>> Maybe this is another reason to fix it properly.
