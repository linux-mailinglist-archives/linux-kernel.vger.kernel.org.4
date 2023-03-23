Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDD36C65AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjCWKvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjCWKuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:50:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE06F35262
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:49:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A1964B3;
        Thu, 23 Mar 2023 03:50:17 -0700 (PDT)
Received: from [10.57.55.121] (unknown [10.57.55.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 116003F766;
        Thu, 23 Mar 2023 03:49:31 -0700 (PDT)
Message-ID: <4c7578af-d384-95e6-fa92-7082dfa0df6d@arm.com>
Date:   Thu, 23 Mar 2023 10:49:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 5/9] coresight: Dynamically add connections
To:     Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230310160610.742382-1-james.clark@arm.com>
 <20230310160610.742382-6-james.clark@arm.com>
 <c468a656-036f-df45-0c5e-034a73ed727a@arm.com>
 <CAJ9a7Vg1EebruGT0irGE6sgk-Rs39-ptX_N3U=NkG3OsQeuBFQ@mail.gmail.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CAJ9a7Vg1EebruGT0irGE6sgk-Rs39-ptX_N3U=NkG3OsQeuBFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/03/2023 17:56, Mike Leach wrote:
> Hi James
> 
> On Thu, 16 Mar 2023 at 17:12, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>
>> On 10/03/2023 16:06, James Clark wrote:
>>> Add a function for adding connections dynamically. This also removes
>>> the 1:1 mapping between port number and the index into the connections
>>> array. The only place this mapping was used was in the warning for
>>> duplicate output ports, which has been replaced by a search. Other
>>> uses of the port number already use the port member variable.
>>>
>>> Being able to dynamically add connections will allow other devices like
>>> CTI to re-use the connection mechanism despite not having explicit
>>> connections described in the DT.
>>>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>> ---
>>>   .../hwtracing/coresight/coresight-platform.c  | 77 ++++++++++++++-----
>>>   include/linux/coresight.h                     |  7 +-
>>>   2 files changed, 64 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
>>> index c77238cdf448..16553f7dde12 100644
>>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>>> @@ -27,8 +27,9 @@ static int coresight_alloc_conns(struct device *dev,
>>>                                struct coresight_platform_data *pdata)
>>>   {
>>>       if (pdata->nr_outconns) {
>>> -             pdata->out_conns = devm_kcalloc(dev, pdata->nr_outconns,
>>> -                                         sizeof(*pdata->out_conns), GFP_KERNEL);
>>> +             pdata->out_conns = devm_krealloc_array(
>>> +                     dev, pdata->out_conns, pdata->nr_outconns,
>>
>> super minor nit:
>>                 pdata->out_conns = devm_krealloc_array(dev,
>>
>>
>>> +                     sizeof(*pdata->out_conns), GFP_KERNEL | __GFP_ZERO);
>>>               if (!pdata->out_conns)
>>>                       return -ENOMEM;
>>>       }
>>> @@ -36,6 +37,48 @@ static int coresight_alloc_conns(struct device *dev,
>>>       return 0;
>>>   }
>>>
>>> +/*
>>> + * Add a connection in the first free slot, or realloc
>>> + * if there is no space. @conn's contents is copied into the new slot.
>>> + *
>>> + * If the output port is already assigned on this device, return -EINVAL
>>> + */
>>> +int coresight_add_conn(struct device *dev,
>>> +                    struct coresight_platform_data *pdata,
>>> +                    const struct coresight_connection *conn)
>>> +{
>>> +     int ret;
>>> +     struct coresight_connection *free_conn = NULL;
>>> +     struct coresight_connection *i;
>>> +
>>> +     /*
>>> +      * Search for a free slot, and while looking for one, warn
>>> +      * on any existing duplicate output port.
>>> +      */
>>> +     for (i = pdata->out_conns; i < pdata->out_conns + pdata->nr_outconns;
>>> +          ++i) {
>>
>> minor nit: I see why you have gone against using "i" as index into
>> the array. But I think having that as the index is still better
>> readable.
>>
>>         for (i = 0; i < pdata->nr_outconns; i++) {
>>                 struct coresight_connection *c = &pdata->out_conns[i];
>>
>>> +             if (i->remote_fwnode && conn->port != -1 &&
>>> +                 i->port == conn->port) {
>>> +                     dev_warn(dev, "Duplicate output port %d\n", i->port);
>>> +                     return -EINVAL;
>>> +             }
> 
> This code assumes that slots are filled sequentially and that it is
> not possible to release slots out of order - i.e. if we find a free
> slot, there is not a match in a later slot.
> I can't think how this could happen but a comment to confirm this
> might be needed here.
> 
> When we had 1:1 port / array index then this check was guaranteed
>> Mike

I thought about this but I couldn't see an issue here. The loop always
runs to the end even if a free slot is found so it should find
duplicates in any order. Unless I'm missing some other edge case?

> 
> 
> 
>>> +             if (!i->remote_fwnode && !free_conn)
>>> +                     free_conn = i;
>>> +     }
>>> +
>>> +     if (!free_conn) {
>>
>> and:
>>         /* No free slots */
>>         if (i == pdata->nr_outconns) {
>>
>>> +             pdata->nr_outconns++;
>>> +             ret = coresight_alloc_conns(dev, pdata);
>>> +             if (ret)
>>> +                     return ret;
>>> +             free_conn = &pdata->out_conns[pdata->nr_outconns - 1];
>>> +     }
>>> +
>>
>> and:
>>         pdata->out_conns[i] = *conn;
>>
>>
>> Otherwise looks good to me.
>>
>> Suzuki
>>
>>
> 
> 
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
