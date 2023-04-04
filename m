Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB67B6D6490
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbjDDOB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbjDDOBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:01:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3C2E46AF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:00:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 612F1D75;
        Tue,  4 Apr 2023 07:00:41 -0700 (PDT)
Received: from [10.57.53.173] (unknown [10.57.53.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C6103F762;
        Tue,  4 Apr 2023 06:59:54 -0700 (PDT)
Message-ID: <2e3c1a26-b4af-9e53-66d1-9553c86ce2bd@arm.com>
Date:   Tue, 4 Apr 2023 14:59:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v3 13/13] coresight: Fix CTI module refcount leak by
 making it a helper device
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        quic_jinlmao@quicinc.com, mike.leach@linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230329115329.2747724-1-james.clark@arm.com>
 <20230329115329.2747724-14-james.clark@arm.com>
 <77d890a9-9927-da8e-1460-54513784683d@arm.com>
 <61bb4e6d-5451-2f01-19b2-76c396854c23@arm.com>
 <2eecee82-2143-0da6-6132-5514336ebc6b@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <2eecee82-2143-0da6-6132-5514336ebc6b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 14:04, James Clark wrote:
> 
> 
> On 04/04/2023 13:55, James Clark wrote:
>>
>>
>> On 04/04/2023 10:21, Suzuki K Poulose wrote:
>>> On 29/03/2023 12:53, James Clark wrote:
>>>> The CTI module has some hard coded refcounting code that has a leak.
>>>> For example running perf and then trying to unload it fails:
>>>>
>>>>     perf record -e cs_etm// -a -- ls
>>>>     rmmod coresight_cti
>>>>
>>>>     rmmod: ERROR: Module coresight_cti is in use
>>>>
>>>> The coresight core already handles references of devices in use, so by
>>>> making CTI a normal helper device, we get working refcounting for free.
>>>>
>>>> Signed-off-by: James Clark <james.clark@arm.com>
>>>> ---
>>>>    drivers/hwtracing/coresight/coresight-core.c  | 99 ++++++-------------
>>>>    .../hwtracing/coresight/coresight-cti-core.c  | 52 +++++-----
>>>>    .../hwtracing/coresight/coresight-cti-sysfs.c |  4 +-
>>>>    drivers/hwtracing/coresight/coresight-cti.h   |  4 +-
>>>>    drivers/hwtracing/coresight/coresight-priv.h  |  4 +-
>>>>    drivers/hwtracing/coresight/coresight-sysfs.c |  4 +
>>>>    include/linux/coresight.h                     | 30 +-----
>>>>    7 files changed, 70 insertions(+), 127 deletions(-)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c
>>>> b/drivers/hwtracing/coresight/coresight-core.c
>>>> index 65f5bd8516d8..458d91b4e23f 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-core.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>>>> @@ -254,60 +254,39 @@ void coresight_disclaim_device(struct
>>>> coresight_device *csdev)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(coresight_disclaim_device);
>>>>    -/* enable or disable an associated CTI device of the supplied CS
>>>> device */
>>>> -static int
>>>> -coresight_control_assoc_ectdev(struct coresight_device *csdev, bool
>>>> enable)
>>>> -{
>>>> -    int ect_ret = 0;
>>>> -    struct coresight_device *ect_csdev = csdev->ect_dev;
>>>> -    struct module *mod;
>>>> -
>>>> -    if (!ect_csdev)
>>>> -        return 0;
>>>> -    if ((!ect_ops(ect_csdev)->enable) || (!ect_ops(ect_csdev)->disable))
>>>> -        return 0;
>>>> -
>>>> -    mod = ect_csdev->dev.parent->driver->owner;
>>>> -    if (enable) {
>>>> -        if (try_module_get(mod)) {
>>>> -            ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
>>>> -            if (ect_ret) {
>>>> -                module_put(mod);
>>>> -            } else {
>>>> -                get_device(ect_csdev->dev.parent);
>>>> -                csdev->ect_enabled = true;
>>>> -            }
>>>> -        } else
>>>> -            ect_ret = -ENODEV;
>>>> -    } else {
>>>> -        if (csdev->ect_enabled) {
>>>> -            ect_ret = ect_ops(ect_csdev)->disable(ect_csdev);
>>>> -            put_device(ect_csdev->dev.parent);
>>>> -            module_put(mod);
>>>> -            csdev->ect_enabled = false;
>>>> -        }
>>>> -    }
>>>> -
>>>> -    /* output warning if ECT enable is preventing trace operation */
>>>> -    if (ect_ret)
>>>> -        dev_info(&csdev->dev, "Associated ECT device (%s) %s failed\n",
>>>> -             dev_name(&ect_csdev->dev),
>>>> -             enable ? "enable" : "disable");
>>>> -    return ect_ret;
>>>> -}
>>>> -
>>>>    /*
>>>> - * Set the associated ect / cti device while holding the coresight_mutex
>>>> + * Add a helper as an output device while holding the coresight_mutex
>>>>     * to avoid a race with coresight_enable that may try to use this
>>>> value.
>>>>     */
>>>> -void coresight_set_assoc_ectdev_mutex(struct coresight_device *csdev,
>>>> -                      struct coresight_device *ect_csdev)
>>>> +void coresight_add_helper_mutex(struct coresight_device *csdev,
>>>> +                struct coresight_device *helper)
>>>
>>> minor nit: It may be a good idea to rename this, in line with the
>>> kernel naming convention :
>>>
>>>      coresight_add_helper_unlocked()
>>>
>>> Or if this is the only variant, it is OK to leave it as :
>>>      coresight_add_helper()
>>> with a big fat comment in the function description to indicate
>>> that it takes the mutex and may be even add a :
>>>
>> There is already a bit of a comment in the description but I can expand
>> on it more.
>>
>>> might_sleep() and lockdep_assert_not_held(&coresight_mutex);
>>>
>>> in the function.
>>>
>>
>> I'm not sure if lockdep_assert_not_held() would be right because
>> sometimes it could be held if another device is being created at the
>> same time? Or something like a session is started at the same time a CTI
>> device is added.
>>
> 
> Oh I see it's not for any task, it's just for the current one. That
> makes sense then I can add it.
> 
> Although it looks like it only warns when lockdep is enabled, but don't
> you get a warning anyway if you try to take the lock twice with lockdep
> enabled?

Thats true, you could ignore the lockdep check.

  So I'm not sure why we would add lockdep_assert_not_held() here
> and not on all the mutex_lock() calls?\

Ah. I double checked this and the coresight_mutex is static and local to
  coresight-core.c. So there is no point in talking about locking for
external users. So I would just leave out any suffixes and simply use
the lockdep check implicit from mutex_lock().

Suzuki

