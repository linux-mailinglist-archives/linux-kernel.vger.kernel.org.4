Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E2867AFAB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbjAYK17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbjAYK15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:27:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E27893EA
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:27:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB4BC4B3;
        Wed, 25 Jan 2023 02:28:34 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4A4F3F71E;
        Wed, 25 Jan 2023 02:27:51 -0800 (PST)
Message-ID: <417c4e3a-6fa8-5210-dd27-669a5d9e255c@arm.com>
Date:   Wed, 25 Jan 2023 10:27:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] coresight: tmc-etr: Don't enable ETR when it's not ready
Content-Language: en-US
To:     Yabin Cui <yabinc@google.com>
Cc:     Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
References: <20230109234312.2870846-1-yabinc@google.com>
 <a7edcb0a-5f12-f6ab-8897-479fefe54c2f@arm.com>
 <CAJ9a7Vj=e6rSbD9ONKDY1vyuxms161f-vp0Y4mxkQgpm1oz6uA@mail.gmail.com>
 <3eae7596-2ad8-1574-22d1-696184a3fa30@arm.com>
 <CALJ9ZPMaAQu4Pug-m-h6KM40pOofhpE1EkddBKz37WyBQGzEEA@mail.gmail.com>
 <CALJ9ZPNa41rO3iG1WhWAF5fBTUGF1ULUG62_zMTA0EwzGnw=8w@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CALJ9ZPNa41rO3iG1WhWAF5fBTUGF1ULUG62_zMTA0EwzGnw=8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,


On 24/01/2023 20:09, Yabin Cui wrote:
> Ping for review. And I still can't reproduce it, even if I reduced the
> timeout to 2us and tried different workloads. Any suggestions for how
> to reproduce it?
> 

I think we should go ahead and fix this in the driver to handle flaky
hardware cases. But I would like this to be addressed for all the TMC
types, not just ETRs, as Mike pointed out.

Thanks
Suzuki

> Thanks,
> Yabin
> 
> On Tue, Jan 10, 2023 at 1:06 PM Yabin Cui <yabinc@google.com> wrote:
>>
>>> Do you have a reproducer for this or some more info?
>>> For example is it a regression or has it always been there? And on which
>>> platform.
>>
>> It happens on Pixel 6 and 7. We collect ETM data periodically from some
>> internal dogfood devices. The problem has happened several times on
>> dogfood devices. But I am still trying to reproduce it locally.
>>
>> We use the scatter-gather mode of ETR, and allocate a 4M buffer. In userspace,
>> we use simpleperf in Android to collect system wide ETM data. What is special
>> is, simpleperf disables and reenables perf events every 100ms to flush ETM
>> data to perf aux buffer.
>>
>> Pixel 6 and 7 have hardware monitoring AXI traffic. The hardware finds ETR is
>> trying to read from or write to a low invalid address (like 0x2E0000). The
>> problem always happens right after the "tmc_etr: timeout while waiting for TMC
>> to be Ready" message. And in almost all cases, I can find a "timeout while
>> waiting for completion of Manual Flush" message from the previous session.
>>
>> One log history is below:
>> [11484.610008][    C0] coresight tmc_etr0: timeout while waiting for
>> completion of Manual Flush
>> [11484.610177][    C0] coresight tmc_etr0: timeout while waiting for
>> TMC to be Ready
>> [11484.615367][    C0] coresight tmc_etr0: timeout while waiting for
>> completion of Manual Flush
>> [11484.615534][    C0] coresight tmc_etr0: timeout while waiting for
>> TMC to be Ready
>> [12089.486044][    C0] coresight tmc_etr0: timeout while waiting for
>> TMC to be Ready
>> AXI error report reading from invalid address
>>
>> Another log history is below:
>> [76709.382650][    C5] coresight tmc_etf1: timeout while waiting for
>> TMC to be Ready
>> [76709.382852][    C7] coresight tmc_etr0: timeout while waiting for
>> completion of Manual Flush
>> [76709.382995][    C7] coresight tmc_etr0: timeout while waiting for
>> TMC to be Ready
>> [76709.384510][    C7] coresight tmc_etr0: timeout while waiting for
>> completion of Manual Flush
>> [76709.384649][    C7] coresight tmc_etr0: timeout while waiting for
>> TMC to be Ready
>> [76709.384838][    C0] coresight tmc_etr0: timeout while waiting for
>> TMC to be Ready
>> AIX error report writing to invalid address
>>
>> It seems if the previous manual flush doesn't finish gracefully, ETR may not be
>> ready for the next enable (even after 10min as in the first log). And if we
>> continue to enable ETR, an invalid AXI IO may happen.
>>
>> Thanks,
>> Yabin
>>
>> On Tue, Jan 10, 2023 at 10:04 AM Suzuki K Poulose
>> <suzuki.poulose@arm.com> wrote:
>>>
>>> On 10/01/2023 17:48, Mike Leach wrote:
>>>> Hi,
>>>>
>>>> On Tue, 10 Jan 2023 at 09:30, James Clark <james.clark@arm.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 09/01/2023 23:43, Yabin Cui wrote:
>>>>>> Otherwise, it may cause error in AXI bus and result in a kernel panic.
>>>>>
>>>>> Hi Yabin,
>>>>>
>>>>> Thanks for the fix. Do you have a reproducer for this or some more info?
>>>>> For example is it a regression or has it always been there? And on which
>>>>> platform.
>>>>>
>>>>> Thanks
>>>>> James
>>>>>
>>>>>>
>>>>>> Signed-off-by: Yabin Cui <yabinc@google.com>
>>>>>> ---
>>>>>>    .../hwtracing/coresight/coresight-tmc-core.c   |  4 +++-
>>>>>>    .../hwtracing/coresight/coresight-tmc-etr.c    | 18 +++++++++++++++---
>>>>>>    drivers/hwtracing/coresight/coresight-tmc.h    |  2 +-
>>>>>>    3 files changed, 19 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>>>>>> index 07abf28ad725..c106d142e632 100644
>>>>>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>>>>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>>>>>> @@ -31,7 +31,7 @@ DEFINE_CORESIGHT_DEVLIST(etb_devs, "tmc_etb");
>>>>>>    DEFINE_CORESIGHT_DEVLIST(etf_devs, "tmc_etf");
>>>>>>    DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
>>>>>>
>>>>>> -void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>>>>>> +int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>>>>>>    {
>>>>>>         struct coresight_device *csdev = drvdata->csdev;
>>>>>>         struct csdev_access *csa = &csdev->access;
>>>>>> @@ -40,7 +40,9 @@ void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>>>>>>         if (coresight_timeout(csa, TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
>>>>>>                 dev_err(&csdev->dev,
>>>>>>                         "timeout while waiting for TMC to be Ready\n");
>>>>>> +             return -EBUSY;
>>>>>>         }
>>>>>> +     return 0;
>>>>>>    }
>>>>>>
>>>>>>    void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>>>>> index 867ad8bb9b0c..2da99dd41ed6 100644
>>>>>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>>>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>>>>> @@ -983,15 +983,21 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
>>>>>>         etr_buf->ops->sync(etr_buf, rrp, rwp);
>>>>>>    }
>>>>>>
>>>>>> -static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>>>>>> +static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>>>>>>    {
>>>>>>         u32 axictl, sts;
>>>>>>         struct etr_buf *etr_buf = drvdata->etr_buf;
>>>>>> +     int rc = 0;
>>>>>>
>>>>>>         CS_UNLOCK(drvdata->base);
>>>>>>
>>>>>>         /* Wait for TMCSReady bit to be set */
>>>>>> -     tmc_wait_for_tmcready(drvdata);
>>>>>> +     rc = tmc_wait_for_tmcready(drvdata);
>>>>>> +     if (rc) {
>>>>>> +             dev_err(&drvdata->csdev->dev, "not ready ETR isn't enabled\n");
>>>>>> +             CS_LOCK(drvdata->base);
>>>>>> +             return rc;
>>>>>> +     }
>>>>>>
>>>>>>         writel_relaxed(etr_buf->size / 4, drvdata->base + TMC_RSZ);
>>>>>>         writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
>>>>>> @@ -1032,6 +1038,7 @@ static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>>>>>>         tmc_enable_hw(drvdata);
>>>>>>
>>>>>>         CS_LOCK(drvdata->base);
>>>>>> +     return rc;
>>>>>>    }
>>>>>>
>>>>>>    static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
>>>>>> @@ -1060,7 +1067,12 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
>>>>>>         rc = coresight_claim_device(drvdata->csdev);
>>>>>>         if (!rc) {
>>>>>>                 drvdata->etr_buf = etr_buf;
>>>>>> -             __tmc_etr_enable_hw(drvdata);
>>>>>> +             rc = __tmc_etr_enable_hw(drvdata);
>>>>>> +             if (rc) {
>>>>>> +                     drvdata->etr_buf = NULL;
>>>>>> +                     coresight_disclaim_device(drvdata->csdev);
>>>>>> +                     tmc_etr_disable_catu(drvdata);
>>>>>> +             }
>>>>>>         }
>>>>>>
>>>>>>         return rc;
>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
>>>>>> index 66959557cf39..01c0382a29c0 100644
>>>>>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>>>>>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>>>>>> @@ -255,7 +255,7 @@ struct tmc_sg_table {
>>>>>>    };
>>>>>>
>>>>>>    /* Generic functions */
>>>>>> -void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
>>>>>> +int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
>>>>>>    void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
>>>>>>    void tmc_enable_hw(struct tmc_drvdata *drvdata);
>>>>>>    void tmc_disable_hw(struct tmc_drvdata *drvdata);
>>>>
>>>> There is no point in waiting for a timeout, and then carrying on even
>>>> when it is exceeded. As such this patch seems reasonable.
>>>> We should also apply the same principle to the ETF and ETB devices
>>>> which use the same tmc_wait_for_tmcready() function.
>>>
>>> +1
>>>
>>> I am fine with pushing this change, as it is doing the right thing.
>>>
>>>>
>>>> However - the concern is that this appears to be happening on starting
>>>> the ETR - there should be no outstanding AXI operations that cause the
>>>> system to not be ready - as we will either be using this the first
>>>> time after reset, or we should have successfully stopped and flushed
>>>> the ETR from the previous operation. This warrants further
>>>> investigation - should we be extending the timeout - which is already
>>>> at a rather generous 100uS, and do we also need to check the MemErr
>>>> bit in the status register?
>>>
>>> It would be good to dump the value of TMC_STATUS to see what is going
>>> on.
>>>
>>>>
>>>> As James says, we need details of when and how the problem occurs  -
>>>> as far as I know it has not been seen on any systems we currently use
>>>> (though could have been missed given the current code)
>>>
>>> +1
>>>
>>> Kind regards
>>> Suzuki
>>>
>>>
>>>>
>>>> Regards
>>>>
>>>> Mike
>>>>
>>>>
>>>> --
>>>> Mike Leach
>>>> Principal Engineer, ARM Ltd.
>>>> Manchester Design Centre. UK
>>>

