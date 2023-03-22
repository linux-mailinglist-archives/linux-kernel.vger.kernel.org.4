Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C886C5239
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjCVRTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCVRT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:19:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 577CF67016
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:19:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C5704B3;
        Wed, 22 Mar 2023 10:19:35 -0700 (PDT)
Received: from [10.57.19.91] (unknown [10.57.19.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E93163F67D;
        Wed, 22 Mar 2023 10:18:49 -0700 (PDT)
Message-ID: <4ee527d7-8f7b-36ec-61e3-f5e29de197ce@arm.com>
Date:   Wed, 22 Mar 2023 17:18:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/9] coresight: Fix CTI module refcount leak by making
 it a helper device
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230310160610.742382-1-james.clark@arm.com>
 <CAJ9a7VhA0b_o_aYJisfey0XK7FadNfxkUapTQc3nE611RiyVRg@mail.gmail.com>
 <341d4a64-6c99-a487-4a7d-7d895b952935@arm.com>
 <CAJ9a7VgbehyFVF1PUZSSGVzhdSY083AvN0bC2xKH=JEUp8oVbw@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAJ9a7VgbehyFVF1PUZSSGVzhdSY083AvN0bC2xKH=JEUp8oVbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/03/2023 16:22, Mike Leach wrote:
> Hi
> 
> On Wed, 22 Mar 2023 at 09:26, James Clark <james.clark@arm.com> wrote:
> 
>>
>>
>> On 21/03/2023 15:12, Mike Leach wrote:
>>> Hi James
>>>
>>> On Fri, 10 Mar 2023 at 16:06, James Clark <james.clark@arm.com> wrote:
>>>>
>>>> Changes since v1:
>>>>
>>>>  * Don't dereference handle in tmc_etr_get_buffer() when not in perf
>> mode.
>>>>  * Fix some W=1 warnings
>>>>  * Add a commit to rename child/output in terms of local/remote
>>>>
>>>> -------------------
>>>>
>>>> Currently there is a refcount leak in CTI when using system wide mode
>>>> or tracing multithreaded applications. See the last commit for a
>>>> reproducer. This prevents the module from being unloaded.
>>>>
>>>> Historically there have been a few issues and fixes attempted around
>>>> here which have resulted in some extra logic and a member to keep
>>>> track of CTI being enabled 'struct coresight_device->ect_enabled'.
>>>> The fix in commit 665c157e0204 ("coresight: cti: Fix hang in
>>>> cti_disable_hw()") was also related to CTI having its own
>>>> enable/disable path which came later than other devices.
>>>>
>>>> If we make CTI a helper device and enable helper devices adjacent to
>>>> the path we get very similar enable/disable behavior to now, but with
>>>> more reuse of the existing reference counting logic in the coresight
>>>> core code. This also affects CATU which can have a little bit of
>>>> its hard coded enable/disable code removed.
>>>>
>>>> Enabling CATU on the generic path does require that input connections
>>>> are tracked so that it can get its associated ETR buffer.
>>>>
>>>> Applies to coresight/next (669c4614236a7) but also requires the
>>>> realloc_array patch here [1].
>>>>
>>>> Also available in full here [2].
>>>>
>>>> [1]:
>> https://lore.kernel.org/linux-arm-kernel/20230306152723.3090195-1-james.clark@arm.com/
>>>> [2]:
>> https://gitlab.arm.com/linux-arm/linux-jc/-/tree/james-cs-cti-module-refcount-fix-v2
>>>>
>>>> James Clark (9):
>>>>   coresight: Use enum type for cs_mode wherever possible
>>>>   coresight: Change name of pdata->conns
>>>>   coresight: Rename nr_outports to nr_outconns
>>>>   coresight: Rename connection members to allow for input connections
>>>>   coresight: Dynamically add connections
>>>>   coresight: Store in-connections as well as out-connections
>>>>   coresight: Refactor out buffer allocation function for ETR
>>>>   coresight: Enable and disable helper devices adjacent to the path
>>>>   coresight: Fix CTI module refcount leak by making it a helper device
>>>>
>>>>  drivers/hwtracing/coresight/coresight-catu.c  |  34 +-
>>>>  drivers/hwtracing/coresight/coresight-core.c  | 312 +++++++++++-------
>>>>  .../hwtracing/coresight/coresight-cti-core.c  |  56 ++--
>>>>  .../hwtracing/coresight/coresight-cti-sysfs.c |   4 +-
>>>>  drivers/hwtracing/coresight/coresight-cti.h   |   4 +-
>>>>  drivers/hwtracing/coresight/coresight-etb10.c |   3 +-
>>>>  .../coresight/coresight-etm3x-core.c          |   6 +-
>>>>  .../coresight/coresight-etm4x-core.c          |   6 +-
>>>>  .../hwtracing/coresight/coresight-platform.c  | 178 +++++++---
>>>>  drivers/hwtracing/coresight/coresight-priv.h  |   9 +-
>>>>  drivers/hwtracing/coresight/coresight-stm.c   |   6 +-
>>>>  drivers/hwtracing/coresight/coresight-sysfs.c |   9 +-
>>>>  .../hwtracing/coresight/coresight-tmc-etf.c   |   2 +-
>>>>  .../hwtracing/coresight/coresight-tmc-etr.c   |  89 ++---
>>>>  drivers/hwtracing/coresight/coresight-tmc.h   |   2 +
>>>>  drivers/hwtracing/coresight/coresight-tpdm.c  |   4 +-
>>>>  drivers/hwtracing/coresight/coresight-tpiu.c  |   3 +-
>>>>  drivers/hwtracing/coresight/coresight-trbe.c  |   3 +-
>>>>  drivers/hwtracing/coresight/ultrasoc-smb.c    |   3 +-
>>>>  drivers/hwtracing/coresight/ultrasoc-smb.h    |   2 +-
>>>>  include/linux/coresight.h                     | 109 +++---
>>>>  21 files changed, 530 insertions(+), 314 deletions(-)
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>>
>>> Looking at this overall - given that the only use of the in_conn is to
>>> reference the connecting device from the helper,
>>>
>>> i.e. coresight-catu.c:405:           tmp =
>> csdev->pdata->in_conns[i].remote_dev;
>>>
>>> would it not be simpler to :
>>>
>>> a)
>>> in coresight_connection add a field:
>>>
>>>   struct coresight_device *origin_dev;
>>>
>>> which mimics the origin / target model we already have in
>> coresight_sysfs_link
>>> then
>>>
>>> b) the in_conns could simply be references to out_conn object from
>>> origin_dev, rather than a complete coresight_connection  with reversed
>>> values, thus simplifying the in_conns handling code, and removing the
>>> unused reversed feilds in the current in_conn object.
>>>
>>> e.g. tmp = csdev->pdata->in_conns[i]->origin_dev
>>>
>>> The remainder of the code would remain much the same, just adjusted
>>> for in_conns as refs rather than independent conn objects
>>
>> This was actually my first implementation because I also thought it
>> would be simpler. Unfortunately it didn't work because the realloc means
>> that storing references to the connections is impossible as they are
>> moved if the array needs to grow.
>>
> 
> Alternatively the out_conns could be references as well, creating a single
> connection object, avoiding the proliferation of additional objects that
> are just used to point back at the output element.

That would work, as long as there wouldn't be any objections based on
locality of elements in an array for performance?

IMO it's fine because starting and stopping a session are pretty
computationally expensive anyway. But it would require one extra change
to the output connections so it's a bit more churn.

> 
> Mike
> 
> 
> 
> 
>> Based on Suzuki's and Jinlongs comments about missing some of the input
>> connections some of the time, now I've made a single place for fixing up
>> output connections (currently there are two) and put the new input code
>> there. So V3 will be a bit simpler in that any time a connection is made
>> the input is made at the same time so it's not conceptually any more
>> complicated than the current code.
> 
> 
>>
>>>
>>> Regards
>>>
>>>
>>> Mike
>>>
>>> --
>>> Mike Leach
>>> Principal Engineer, ARM Ltd.
>>> Manchester Design Centre. UK
>>
