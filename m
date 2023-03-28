Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1CF6CB9F8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjC1I7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjC1I72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:59:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F2E6210E;
        Tue, 28 Mar 2023 01:59:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 799DCC14;
        Tue, 28 Mar 2023 02:00:11 -0700 (PDT)
Received: from [10.57.20.101] (unknown [10.57.20.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B89E3F73F;
        Tue, 28 Mar 2023 01:59:25 -0700 (PDT)
Message-ID: <5a120a90-0b95-cfd0-beff-e9228a9d394b@arm.com>
Date:   Tue, 28 Mar 2023 09:59:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [BUG] perf: No samples found when using kcore + coresight
To:     Yang Shi <shy828301@gmail.com>, Leo Yan <leo.yan@linaro.org>
Cc:     linux-perf-users@vger.kernel.org,
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
 <CAHbLzkqMZMB7sGLbJk82CpE9cssEU+WZYaXhVTVC-B40bY52jw@mail.gmail.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAHbLzkqMZMB7sGLbJk82CpE9cssEU+WZYaXhVTVC-B40bY52jw@mail.gmail.com>
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



On 28/03/2023 01:53, Yang Shi wrote:
> Hi Leo,
> 
> Just follow up on this one. Any update?
> 
Hi Yang,

Sorry no update on this yet from me. I was just finishing off
"coresight: Fix CTI module refcount leak by making it a helper device"
which I hope to post in the next day or two and then I will start on this.

James

> Thanks,
> Yang
> 
> On Mon, Mar 13, 2023 at 5:36 PM Leo Yan <leo.yan@linaro.org> wrote:
>>
>> On Mon, Mar 13, 2023 at 11:15:44AM -0700, Yang Shi wrote:
>>
>> [...]
>>
>>>> Just a quick summary, here we have two issues:
>>>>
>>>> - With command:
>>>>   perf record -e cs_etm/@tmc_etf63/k --kcore --per-thread \
>>>>   -- taskset --cpu-list 1 uname",
>>>>
>>>>   perf doesn't enable "text poke" attribution.
>>>
>>> No, it enables "text poke" and perf fails to decode coresight trace
>>> data too. It doesn't matter whether "--kcore" is after or before "-e
>>> cs/etm/@tmc_etf63/k".
>>
>> Understand now.  Thanks for correction, if so we can ignore this one.
>>
>> Leo
