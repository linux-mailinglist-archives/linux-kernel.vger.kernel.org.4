Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3641687C1F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjBBLYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBBLYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:24:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95D4E89FA5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 03:24:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C3F7C14;
        Thu,  2 Feb 2023 03:24:51 -0800 (PST)
Received: from [10.1.31.33] (FVFF763DQ05P.cambridge.arm.com [10.1.31.33])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E8803F64C;
        Thu,  2 Feb 2023 03:24:08 -0800 (PST)
Message-ID: <aacdd394-3008-a7fa-66a8-1db2a8fc1065@arm.com>
Date:   Thu, 2 Feb 2023 11:24:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] coresight: tmc: Don't enable TMC when it's not ready.
To:     Mike Leach <mike.leach@linaro.org>, Yabin Cui <yabinc@google.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <417c4e3a-6fa8-5210-dd27-669a5d9e255c@arm.com>
 <20230127231001.1920947-1-yabinc@google.com>
 <CAJ9a7VjZs_sHz=p-HQfE0gvqWx65776W8Y-gR3ATx-_k+vr7LQ@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAJ9a7VjZs_sHz=p-HQfE0gvqWx65776W8Y-gR3ATx-_k+vr7LQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Thanks for the comments, please note that I have queued this patch for next.

On 01/02/2023 20:43, Mike Leach wrote:
> Hi,
> 
> On Fri, 27 Jan 2023 at 23:10, Yabin Cui <yabinc@google.com> wrote:
>>
>> If TMC ETR is enabled without being ready, in later use we may
>> see AXI bus errors caused by accessing invalid addresses.
>>
>> Signed-off-by: Yabin Cui <yabinc@google.com>
>> ---
>> V1 -> V2: Make change to all TMCs instead of just ETR
>>
>>   .../hwtracing/coresight/coresight-tmc-core.c  |  4 +-
>>   .../hwtracing/coresight/coresight-tmc-etf.c   | 43 +++++++++++++++----
>>   .../hwtracing/coresight/coresight-tmc-etr.c   | 18 ++++++--
>>   drivers/hwtracing/coresight/coresight-tmc.h   |  2 +-
>>   4 files changed, 53 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> index 07abf28ad725..c106d142e632 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> @@ -31,7 +31,7 @@ DEFINE_CORESIGHT_DEVLIST(etb_devs, "tmc_etb");
>>   DEFINE_CORESIGHT_DEVLIST(etf_devs, "tmc_etf");
>>   DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
>>
>> -void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>> +int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>>   {
>>          struct coresight_device *csdev = drvdata->csdev;
>>          struct csdev_access *csa = &csdev->access;
>> @@ -40,7 +40,9 @@ void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>>          if (coresight_timeout(csa, TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
>>                  dev_err(&csdev->dev,
>>                          "timeout while waiting for TMC to be Ready\n");
>> +               return -EBUSY;
>>          }
>> +       return 0;
>>   }
>>
>>   void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> index 4c4cbd1f7258..2840227e9135 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> @@ -16,12 +16,19 @@
>>   static int tmc_set_etf_buffer(struct coresight_device *csdev,
>>                                struct perf_output_handle *handle);
>>
>> -static void __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>> +static int __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>>   {
>> +       int rc = 0;
>> +
>>          CS_UNLOCK(drvdata->base);
>>
>>          /* Wait for TMCSReady bit to be set */
>> -       tmc_wait_for_tmcready(drvdata);
>> +       rc = tmc_wait_for_tmcready(drvdata);
>> +       if (rc) {
>> +               dev_err(&drvdata->csdev->dev, "fails to enable not ready TMC\n");
>> +               CS_LOCK(drvdata->base);
>> +               return rc;
>> +       }
>>
>>          writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
>>          writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
>> @@ -33,6 +40,7 @@ static void __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>>          tmc_enable_hw(drvdata);
>>
>>          CS_LOCK(drvdata->base);
>> +       return rc;
>>   }
>>
>>   static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>> @@ -42,8 +50,10 @@ static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>>          if (rc)
>>                  return rc;
>>
>> -       __tmc_etb_enable_hw(drvdata);
>> -       return 0;
>> +       rc = __tmc_etb_enable_hw(drvdata);
>> +       if (rc)
>> +               coresight_disclaim_device(drvdata->csdev);
>> +       return rc;
>>   }
>>
>>   static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
>> @@ -91,12 +101,19 @@ static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>>          coresight_disclaim_device(drvdata->csdev);
>>   }
>>
>> -static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
>> +static int __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
>>   {
>> +       int rc = 0;
>> +
>>          CS_UNLOCK(drvdata->base);
>>
>>          /* Wait for TMCSReady bit to be set */
>> -       tmc_wait_for_tmcready(drvdata);
>> +       rc = tmc_wait_for_tmcready(drvdata);
>> +       if (rc) {
>> +               dev_err(&drvdata->csdev->dev, "fails to enable not ready TMC\n");
>> +               CS_LOCK(drvdata->base);
>> +               return rc;
>> +       }
>>
>>          writel_relaxed(TMC_MODE_HARDWARE_FIFO, drvdata->base + TMC_MODE);
>>          writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI,
>> @@ -105,6 +122,7 @@ static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
>>          tmc_enable_hw(drvdata);
>>
>>          CS_LOCK(drvdata->base);
>> +       return rc;
>>   }
>>
>>   static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
>> @@ -114,8 +132,10 @@ static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
>>          if (rc)
>>                  return rc;
>>
>> -       __tmc_etf_enable_hw(drvdata);
>> -       return 0;
>> +       rc = __tmc_etf_enable_hw(drvdata);
>> +       if (rc)
>> +               coresight_disclaim_device(drvdata->csdev);
>> +       return rc;
>>   }
>>
>>   static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
>> @@ -639,6 +659,7 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
>>          char *buf = NULL;
>>          enum tmc_mode mode;
>>          unsigned long flags;
>> +       int rc = 0;
>>
>>          /* config types are set a boot time and never change */
>>          if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETB &&
>> @@ -664,7 +685,11 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
>>                   * can't be NULL.
>>                   */
>>                  memset(drvdata->buf, 0, drvdata->size);
>> -               __tmc_etb_enable_hw(drvdata);
>> +               rc = __tmc_etb_enable_hw(drvdata);
>> +               if (rc) {
>> +                       spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +                       return rc;
>> +               }
> 
> There is a similar unprepare function in ETR - this should have similar updates.
> 
> 
>>          } else {
>>                  /*
>>                   * The ETB/ETF is not tracing and the buffer was just read.
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index 867ad8bb9b0c..0811cb44588b 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -983,15 +983,21 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
>>          etr_buf->ops->sync(etr_buf, rrp, rwp);
>>   }
>>
>> -static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>> +static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>>   {
>>          u32 axictl, sts;
>>          struct etr_buf *etr_buf = drvdata->etr_buf;
>> +       int rc = 0;
>>
>>          CS_UNLOCK(drvdata->base);
>>
>>          /* Wait for TMCSReady bit to be set */
>> -       tmc_wait_for_tmcready(drvdata);
>> +       rc = tmc_wait_for_tmcready(drvdata);
>> +       if (rc) {
>> +               dev_err(&drvdata->csdev->dev, "fails to enable not ready TMC\n");
>> +               CS_LOCK(drvdata->base);
>> +               return rc;
>> +       }
>>
>>          writel_relaxed(etr_buf->size / 4, drvdata->base + TMC_RSZ);
>>          writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
>> @@ -1032,6 +1038,7 @@ static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>>          tmc_enable_hw(drvdata);
>>
>>          CS_LOCK(drvdata->base);
>> +       return rc;
>>   }
>>
>>   static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
>> @@ -1060,7 +1067,12 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
>>          rc = coresight_claim_device(drvdata->csdev);
>>          if (!rc) {
>>                  drvdata->etr_buf = etr_buf;
>> -               __tmc_etr_enable_hw(drvdata);
>> +               rc = __tmc_etr_enable_hw(drvdata);
>> +               if (rc) {
>> +                       drvdata->etr_buf = NULL;
>> +                       coresight_disclaim_device(drvdata->csdev);
>> +                       tmc_etr_disable_catu(drvdata);
>> +               }
>>          }
>>
>>          return rc;
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
>> index 66959557cf39..01c0382a29c0 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>> @@ -255,7 +255,7 @@ struct tmc_sg_table {
>>   };
>>
>>   /* Generic functions */
>> -void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
>> +int tmc_wait_for_tmcready(struct tmc_drvdata *drvdata);
>>   void tmc_flush_and_stop(struct tmc_drvdata *drvdata);
>>   void tmc_enable_hw(struct tmc_drvdata *drvdata);
>>   void tmc_disable_hw(struct tmc_drvdata *drvdata);
>> --
>> 2.39.1.456.gfc5497dd1b-goog
>>
> 
> The tmc_flush_and_stop() function also calls tmc_wait_for_tmcready().

I think this already an error message there, when it fails to complete
the flush.I thought of adding a WARN_ON, but thought it is not worth much.

> 
> The etb/etf_prepare_read operations disable the etb  /etf before a
> read commences. For consistency  if this fails due to TMC not being
> ready do we also need to fail the read prepare operations?

I think that should be OK, as we can read what the TMC has already
flushed/written to the memory.  A following session may not be able
to use the ETR, which is fine.

Cheers
Suzuki

> 
> Regards
> 
> Mike
> 
> 

