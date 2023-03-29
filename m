Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AE16CD91D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjC2MHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjC2MHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:07:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56EE54ED3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:06:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 594AE1FB;
        Wed, 29 Mar 2023 05:07:38 -0700 (PDT)
Received: from [10.57.20.1] (unknown [10.57.20.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1205B3F6C4;
        Wed, 29 Mar 2023 05:06:52 -0700 (PDT)
Message-ID: <eab64b08-34fb-996c-e57a-8f179c132de5@arm.com>
Date:   Wed, 29 Mar 2023 13:06:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 6/9] coresight: Store in-connections as well as
 out-connections
Content-Language: en-US
To:     Jinlong Mao <quic_jinlmao@quicinc.com>, coresight@lists.linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230310160610.742382-1-james.clark@arm.com>
 <20230310160610.742382-7-james.clark@arm.com>
 <b0cf2f22-1824-bb06-1648-3570fd6540a4@quicinc.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <b0cf2f22-1824-bb06-1648-3570fd6540a4@quicinc.com>
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



On 14/03/2023 05:35, Jinlong Mao wrote:
> 
> On 3/11/2023 12:06 AM, James Clark wrote:
>> This will allow CATU to get its associated ETR in a generic way where
>> currently the enable path has some hard coded searches which avoid
>> the need to store input connections.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c  | 56 +++++++++++++++--
>>   .../hwtracing/coresight/coresight-platform.c  | 61 ++++++++++++++++---
>>   drivers/hwtracing/coresight/coresight-sysfs.c |  1 -
>>   include/linux/coresight.h                     | 25 ++++++++
>>   4 files changed, 130 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c
>> b/drivers/hwtracing/coresight/coresight-core.c
>> index f457914e445e..a8ba7493c09a 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -59,6 +59,7 @@ const u32 coresight_barrier_pkt[4] = {0x7fffffff,
>> 0x7fffffff, 0x7fffffff, 0x7fff
>>   EXPORT_SYMBOL_GPL(coresight_barrier_pkt);
>>     static const struct cti_assoc_op *cti_assoc_ops;
>> +static int coresight_fixup_inputs(struct coresight_device *csdev);
>>     ssize_t coresight_simple_show_pair(struct device *_dev,
>>                     struct device_attribute *attr, char *buf)
>> @@ -1369,6 +1370,35 @@ static int coresight_fixup_orphan_conns(struct
>> coresight_device *csdev)
>>                csdev, coresight_orphan_match);
>>   }
>>   +/*
>> + * Device connections are discovered before one/both devices have
>> been created,
>> + * so inputs must be added later.
>> + */
>> +static int coresight_fixup_inputs(struct coresight_device *csdev)
>> +{
>> +    int i, ret = 0;
>> +    struct coresight_connection *out_conn;
>> +    struct coresight_connection in_conn;
>> +
>> +    for (i = 0; i < csdev->pdata->nr_outconns; i++) {
>> +        out_conn = &csdev->pdata->out_conns[i];
>> +        if (!out_conn->remote_dev || !out_conn->remote_dev->pdata)
>> +            continue;
> 
> Hi James,
> 
> If out_conn->remote_dev is null here,  the in_conn of
> out_conn->remote_dev->pdata will never be set.
> For example, device A is connected to in_port 0 of device B. If device A
> is probed first, the in_conn of device
> B will not be set.
> Do we need to add Defer probe return here ? I tested with defer probe
> return, it works.
> 
>         for (i = 0; i < csdev->pdata->nr_outconns; i++) {
>                 out_conn = &csdev->pdata->out_conns[i];
>                 if (!out_conn->remote_dev || !out_conn->remote_dev->pdata)
> -                       continue;
> +                        return -EPROBE_DEFER;
> 
> Thanks
> Jinlong Mao

I think you are right but I thought that EPROBE_DEFER was too big of a
change and that it might break something in some unexpected way.

In V3 I used the orphan mechanism for inputs in the same way as outputs
so the problem should be gone now but without having to defer loading.

