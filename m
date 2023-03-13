Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555856B7252
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCMJQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjCMJQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:16:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD757B746;
        Mon, 13 Mar 2023 02:16:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 252892F4;
        Mon, 13 Mar 2023 02:17:38 -0700 (PDT)
Received: from [10.57.91.187] (unknown [10.57.91.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 735143F71A;
        Mon, 13 Mar 2023 02:16:52 -0700 (PDT)
Message-ID: <619818ad-71cb-6c07-bcae-ea9398f08878@arm.com>
Date:   Mon, 13 Mar 2023 09:16:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] coresight: core: Add coresight name support
To:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rob Herring <robh@kernel.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20230208110716.18321-1-quic_jinlmao@quicinc.com>
 <3c105c79-f523-653e-5154-7ba641e51a96@arm.com>
 <180a66b1-6996-c705-5d8a-0a69ce0353d7@quicinc.com>
 <b7abee2a-99ca-26d6-5850-60ee19d9c0e9@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <b7abee2a-99ca-26d6-5850-60ee19d9c0e9@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Rob

On 01/03/2023 15:11, Jinlong Mao wrote:
> Hi Suzuki,
> 
> On 2/9/2023 10:16 AM, Jinlong Mao wrote:
>>
>> On 2/8/2023 10:26 PM, Suzuki K Poulose wrote:
>>> On 08/02/2023 11:07, Mao Jinlong wrote:
>>>> Apart from STM and ETM sources, there will be more sources added to
>>>> coresight components. For example, there are over 10 TPDM sources.
>>>> Add coresight name support for custom names which will be
>>>> easy to identify the source.
>>>>
>>>
>>> As we have previously discussed, please don't make this a generic
>>> code change. If your device has a "specifici" name, use that for
>>> allocating in the driver and leave the core code alone.
>>>
>>> Suzuki
>>>
>> Hi Suzuki,
>>
>> Not only for TPDMs. There could be dozens of CTI devices.
>> It is hard for user to know which CTI device it is with current names.
>>
>> Thanks
>> Jinlong Mao
> 
> The coresight name support is applicable to CTI and TPDM devices.
> This is a generic change for the source which has dozens of devices.

I took a look at the CTI situation and I agree that the situation
is a bit tricky. The CTI could be connected to multiple devices,
some of them may not be even CoreSight devices. Given there could
be numerous of them, we need some way to make the "devices" naming
a bit more intuitive.

Before we go ahead and add something specific to coresight, I would
like to see if there is a generic property. Ideally, the "labels"
in the DTS sources would have been an ideal choice, but can't
see how that is available in the FDT.

Suzuki


> 
> Thanks
> Jinlong Mao
> 
>>>
>>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>>> ---
>>>>   drivers/hwtracing/coresight/coresight-core.c | 34 
>>>> +++++++++++---------
>>>>   1 file changed, 19 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c 
>>>> b/drivers/hwtracing/coresight/coresight-core.c
>>>> index d3bf82c0de1d..5e95d9c7f256 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-core.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>>>> @@ -1733,28 +1733,32 @@ char *coresight_alloc_device_name(struct 
>>>> coresight_dev_list *dict,
>>>>   {
>>>>       int idx;
>>>>       char *name = NULL;
>>>> +    const char *coresight_name = NULL;
>>>>       struct fwnode_handle **list;
>>>> +    struct device_node *node = dev->of_node;
>>>>         mutex_lock(&coresight_mutex);
>>>>   -    idx = coresight_search_device_idx(dict, dev_fwnode(dev));
>>>> -    if (idx < 0) {
>>>> -        /* Make space for the new entry */
>>>> -        idx = dict->nr_idx;
>>>> -        list = krealloc_array(dict->fwnode_list,
>>>> -                      idx + 1, sizeof(*dict->fwnode_list),
>>>> -                      GFP_KERNEL);
>>>> -        if (ZERO_OR_NULL_PTR(list)) {
>>>> -            idx = -ENOMEM;
>>>> -            goto done;
>>>> +    if (!of_property_read_string(node, "coresight-name", 
>>>> &coresight_name))
>>>> +        name = devm_kasprintf(dev, GFP_KERNEL, "%s", coresight_name);
>>>> +    else {
>>>> +        idx = coresight_search_device_idx(dict, dev_fwnode(dev));
>>>> +        if (idx < 0) {
>>>> +            /* Make space for the new entry */
>>>> +            idx = dict->nr_idx;
>>>> +            list = krealloc_array(dict->fwnode_list,
>>>> +                          idx + 1, sizeof(*dict->fwnode_list),
>>>> +                          GFP_KERNEL);
>>>> +            if (ZERO_OR_NULL_PTR(list))
>>>> +                goto done;
>>>> +
>>>> +            list[idx] = dev_fwnode(dev);
>>>> +            dict->fwnode_list = list;
>>>> +            dict->nr_idx = idx + 1;
>>>>           }
>>>>   -        list[idx] = dev_fwnode(dev);
>>>> -        dict->fwnode_list = list;
>>>> -        dict->nr_idx = idx + 1;
>>>> +        name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", dict->pfx, 
>>>> idx);
>>>>       }
>>>> -
>>>> -    name = devm_kasprintf(dev, GFP_KERNEL, "%s%d", dict->pfx, idx);
>>>>   done:
>>>>       mutex_unlock(&coresight_mutex);
>>>>       return name;
>>>
>> _______________________________________________
>> CoreSight mailing list -- coresight@lists.linaro.org
>> To unsubscribe send an email to coresight-leave@lists.linaro.org

