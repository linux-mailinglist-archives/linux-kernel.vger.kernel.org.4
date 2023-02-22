Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F93C69F1E8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjBVJhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjBVJgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:36:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04E5739BB7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:34:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91E9C1650;
        Wed, 22 Feb 2023 01:33:48 -0800 (PST)
Received: from [10.57.90.101] (unknown [10.57.90.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FDC03F703;
        Wed, 22 Feb 2023 01:33:04 -0800 (PST)
Message-ID: <7ad38cc7-d2f7-b282-ac37-25e56e0d6c47@arm.com>
Date:   Wed, 22 Feb 2023 09:33:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] coresight: tmc-etr: Handle enable failure in
 tmc_read_unprepare_etr
To:     Yabin Cui <yabinc@google.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <77bd4509-bd8b-3bcc-e94a-7593505e27c0@arm.com>
 <20230210234311.1661312-1-yabinc@google.com>
 <CALJ9ZPM_78fNKcyUn=NvrqYLxcSCNsKp2HNUXU+DwZoC1MhFvA@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CALJ9ZPM_78fNKcyUn=NvrqYLxcSCNsKp2HNUXU+DwZoC1MhFvA@mail.gmail.com>
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

On 21/02/2023 18:38, Yabin Cui wrote:
> Ping for review?
> 
> On Fri, Feb 10, 2023 at 11:43 PM Yabin Cui <yabinc@google.com> wrote:
>>
>> It's similar to what we did in tmc_read_unprepare_etb.
>>
>> Signed-off-by: Yabin Cui <yabinc@google.com>
>> ---

Thanks Yabin for the patch, will queue this at rc1

Suzuki

>>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index 918d461fcf4a..b04f12079efd 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -1763,6 +1763,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
>>   {
>>          unsigned long flags;
>>          struct etr_buf *sysfs_buf = NULL;
>> +       int rc = 0;
>>
>>          /* config types are set a boot time and never change */
>>          if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETR))
>> @@ -1777,7 +1778,11 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
>>                   * buffer. Since the tracer is still enabled drvdata::buf can't
>>                   * be NULL.
>>                   */
>> -               __tmc_etr_enable_hw(drvdata);
>> +               rc = __tmc_etr_enable_hw(drvdata);
>> +               if (rc) {
>> +                       spin_unlock_irqrestore(&drvdata->spinlock, flags);
>> +                       return rc;
>> +               }
>>          } else {
>>                  /*
>>                   * The ETR is not tracing and the buffer was just read.
>> --
>> 2.39.1.581.gbfd45094c4-goog
>>

