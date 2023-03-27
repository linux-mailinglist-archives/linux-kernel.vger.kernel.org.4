Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1336CA857
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjC0O5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjC0O5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:57:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 425271718;
        Mon, 27 Mar 2023 07:57:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 247F2C14;
        Mon, 27 Mar 2023 07:58:14 -0700 (PDT)
Received: from [10.57.54.246] (unknown [10.57.54.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 006013F6C4;
        Mon, 27 Mar 2023 07:57:26 -0700 (PDT)
Message-ID: <8a2dc999-2bed-0f32-4210-bc3d8f223581@arm.com>
Date:   Mon, 27 Mar 2023 15:57:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] coresight: cti: Check if the CPU activated for the CPU
 CTI
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1679910560-23469-1-git-send-email-quic_taozha@quicinc.com>
 <9c7f6414-ac5c-bee2-7068-04a7ee7d94f9@arm.com>
 <81a39cd8-745d-334d-840d-66aed47c3470@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <81a39cd8-745d-334d-840d-66aed47c3470@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 15:28, Tao Zhang wrote:
> Hi Suzuki,
> 
> On 3/27/2023 5:52 PM, Suzuki K Poulose wrote:
>> On 27/03/2023 10:49, Tao Zhang wrote:
>>> Check whether the CPU corresponding to the CPU CTI is activated.
>>> If it is not activated, the CPU CTI node should not exist, and
>>> an error will be returned in the initialization function.
>>>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-cti-core.c | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c 
>>> b/drivers/hwtracing/coresight/coresight-cti-core.c
>>> index 277c890..aaa83ae 100644
>>> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
>>> @@ -899,10 +899,12 @@ static int cti_probe(struct amba_device *adev, 
>>> const struct amba_id *id)
>>>       drvdata->config.hw_powered = true;
>>>         /* set up device name - will depend if cpu bound or otherwise */
>>> -    if (drvdata->ctidev.cpu >= 0)
>>> +    if (drvdata->ctidev.cpu >= 0) {
>>> +        if (!cpu_active(drvdata->ctidev.cpu))
>>> +            return -ENXIO;
>>>           cti_desc.name = devm_kasprintf(dev, GFP_KERNEL, "cti_cpu%d",
>>>                              drvdata->ctidev.cpu);
>>
>> But why ? As long as we do not enable or touch any CPU specific bits 
>> in the probe, why do we need to fail this ? What are you trying to fix ?
>>
>> Please could you share the log if you are hitting something ? This looks
>> like masking a problem.
>>
>> Suzuki
> 
> We found that when the CPU core is disabled, for example, CPU3 is 
> disabled, but
> 
> CPU3 CTI node corresponding to CPU3 still exists. In fact, in this case, 
> CPU3 CTI
> 
> has been unable to trigger CPU3 properly since CPU3 is in an inactive 
> state. This change
> 
> is to avoid configuring the CPU CTI of the CPU that has been disabled in 
> this case.

Who is configuring the trigger ? Shouldn't we skip "enabling" the CTI
when the associated CPU is inactive instead ? Disabling the probe with
an error doesn't solve the problem. What if the CPU becomes active later 
? What makes sure that the CTI is probed then ?

Suzuki


> 
> Tao
> 
>>
>>
>>> -    else
>>> +    } else
>>>           cti_desc.name = coresight_alloc_device_name(&cti_sys_devs, 
>>> dev);
>>>       if (!cti_desc.name)
>>>           return -ENOMEM;
>>

