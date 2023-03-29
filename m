Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CB16CD905
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjC2MCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjC2MCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:02:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE03BC0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:02:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA80A1FB;
        Wed, 29 Mar 2023 05:03:18 -0700 (PDT)
Received: from [10.57.20.1] (unknown [10.57.20.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5514B3F6C4;
        Wed, 29 Mar 2023 05:02:33 -0700 (PDT)
Message-ID: <d55db287-52ca-1e25-6275-73c5bbee6e54@arm.com>
Date:   Wed, 29 Mar 2023 13:02:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   James Clark <james.clark@arm.com>
Subject: Re: [PATCH v2 5/9] coresight: Dynamically add connections
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230310160610.742382-1-james.clark@arm.com>
 <20230310160610.742382-6-james.clark@arm.com>
 <c468a656-036f-df45-0c5e-034a73ed727a@arm.com>
Content-Language: en-US
In-Reply-To: <c468a656-036f-df45-0c5e-034a73ed727a@arm.com>
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



On 16/03/2023 17:12, Suzuki K Poulose wrote:
> On 10/03/2023 16:06, James Clark wrote:
>> Add a function for adding connections dynamically. This also removes
>> the 1:1 mapping between port number and the index into the connections
>> array. The only place this mapping was used was in the warning for
>> duplicate output ports, which has been replaced by a search. Other
>> uses of the port number already use the port member variable.
>>
>> Being able to dynamically add connections will allow other devices like
>> CTI to re-use the connection mechanism despite not having explicit
>> connections described in the DT.
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   .../hwtracing/coresight/coresight-platform.c  | 77 ++++++++++++++-----
>>   include/linux/coresight.h                     |  7 +-
>>   2 files changed, 64 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-platform.c
>> b/drivers/hwtracing/coresight/coresight-platform.c
>> index c77238cdf448..16553f7dde12 100644
>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>> @@ -27,8 +27,9 @@ static int coresight_alloc_conns(struct device *dev,
>>                    struct coresight_platform_data *pdata)
>>   {
>>       if (pdata->nr_outconns) {
>> -        pdata->out_conns = devm_kcalloc(dev, pdata->nr_outconns,
>> -                        sizeof(*pdata->out_conns), GFP_KERNEL);
>> +        pdata->out_conns = devm_krealloc_array(
>> +            dev, pdata->out_conns, pdata->nr_outconns,
> 
> super minor nit:
>         pdata->out_conns = devm_krealloc_array(dev,
> 

This is actually clang-format's doing when using the kernel rules in the
root of the repo. I started using it because of some other style
comments I got before. Not sure if this time it's just done something
bad or it's technically ok.

I formatted everything in V3 with it so it should at least all be
consistent.

>        
>> +            sizeof(*pdata->out_conns), GFP_KERNEL | __GFP_ZERO);
>>           if (!pdata->out_conns)
>>               return -ENOMEM;
>>       }
>> @@ -36,6 +37,48 @@ static int coresight_alloc_conns(struct device *dev,
>>       return 0;
>>   }
>>   +/*
>> + * Add a connection in the first free slot, or realloc
>> + * if there is no space. @conn's contents is copied into the new slot.
>> + *
>> + * If the output port is already assigned on this device, return -EINVAL
>> + */
>> +int coresight_add_conn(struct device *dev,
>> +               struct coresight_platform_data *pdata,
>> +               const struct coresight_connection *conn)
>> +{
>> +    int ret;
>> +    struct coresight_connection *free_conn = NULL;
>> +    struct coresight_connection *i;
>> +
>> +    /*
>> +     * Search for a free slot, and while looking for one, warn
>> +     * on any existing duplicate output port.
>> +     */
>> +    for (i = pdata->out_conns; i < pdata->out_conns +
>> pdata->nr_outconns;
>> +         ++i) {
> 
> minor nit: I see why you have gone against using "i" as index into
> the array. But I think having that as the index is still better
> readable.
>     for (i = 0; i < pdata->nr_outconns; i++) {
>         struct coresight_connection *c = &pdata->out_conns[i];
> >> +        if (i->remote_fwnode && conn->port != -1 &&
>> +            i->port == conn->port) {
>> +            dev_warn(dev, "Duplicate output port %d\n", i->port);
>> +            return -EINVAL;
>> +        }
>> +        if (!i->remote_fwnode && !free_conn)
>> +            free_conn = i;
>> +    }
>> +
>> +    if (!free_conn) {
> 
> and:
>     /* No free slots */
>     if (i == pdata->nr_outconns) {
> 
>> +        pdata->nr_outconns++;
>> +        ret = coresight_alloc_conns(dev, pdata);
>> +        if (ret)
>> +            return ret;
>> +        free_conn = &pdata->out_conns[pdata->nr_outconns - 1];
>> +    }
>> +
> 
> and:
>     pdata->out_conns[i] = *conn;
> 
> > Otherwise looks good to me.
> 
> Suzuki
> 
> 
