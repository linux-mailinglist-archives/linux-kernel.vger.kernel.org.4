Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D086CBF6E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjC1Mm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjC1MmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:42:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2C0BA5C1;
        Tue, 28 Mar 2023 05:41:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45B75C14;
        Tue, 28 Mar 2023 05:34:09 -0700 (PDT)
Received: from [10.57.54.240] (unknown [10.57.54.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 986B73F6C4;
        Tue, 28 Mar 2023 05:33:21 -0700 (PDT)
Message-ID: <c3f5af31-b6ef-dc45-25f0-4e52d93fcaa7@arm.com>
Date:   Tue, 28 Mar 2023 13:33:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v3 02/11] coresight-tpda: Add DSB dataset support
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        James Clark <james.clark@arm.com>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
References: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
 <1679551448-19160-3-git-send-email-quic_taozha@quicinc.com>
 <e578790c-4794-5609-16e8-15d63082760e@arm.com>
 <51ad3cb3-bd83-51c9-52bc-f700cd17103c@quicinc.com>
 <48f31b84-573f-fe1d-bcd7-e55ec7f47831@arm.com>
 <595568c3-d2bc-e37e-83b3-2adfd3fa4193@quicinc.com>
 <6f8b087d-77a7-512e-6504-e4841447eda9@arm.com>
 <edbd1f10-70e5-1fd4-44de-da59b387e9dd@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <edbd1f10-70e5-1fd4-44de-da59b387e9dd@quicinc.com>
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

On 28/03/2023 12:31, Tao Zhang wrote:
> Hi Suzuki,
> 
> On 3/27/2023 5:43 PM, Suzuki K Poulose wrote:
>> On 27/03/2023 04:31, Tao Zhang wrote:
>>>
>>> On 3/26/2023 3:31 AM, Suzuki K Poulose wrote:
>>>> On 24/03/2023 14:58, Tao Zhang wrote:
>>>>> Hi Suzuki,
>>>>>
>>>>> 在 3/23/2023 7:51 PM, Suzuki K Poulose 写道:
>>>>>> On 23/03/2023 06:03, Tao Zhang wrote:
>>>>>>> Read the DSB element size from the device tree. Set the register
>>>>>>> bit that controls the DSB element size of the corresponding port.
>>>>>>>
>>>>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>>>>> ---
>>>>>>>   drivers/hwtracing/coresight/coresight-tpda.c | 58 
>>>>>>> ++++++++++++++++++++++++++++
>>>>>>>   drivers/hwtracing/coresight/coresight-tpda.h |  4 ++
>>>>>>>   2 files changed, 62 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c 
>>>>>>> b/drivers/hwtracing/coresight/coresight-tpda.c
>>>>>>> index f712e11..8dcfc4a 100644
>>>>>>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>>>>>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>>>>>>> @@ -21,6 +21,47 @@
>>>>>>>     DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
>>>>>>>   +/* Search and read element data size from the TPDM node in
>>>>>>> + * the devicetree. Each input port of TPDA is connected to
>>>>>>> + * a TPDM. Different TPDM supports different types of dataset,
>>>>>>> + * and some may support more than one type of dataset.
>>>>>>> + * Parameter "inport" is used to pass in the input port number
>>>>>>> + * of TPDA, and it is set to 0 in the recursize call.
>>>>>>> + * Parameter "parent" is used to pass in the original call.
>>>>>>> + */
>>>>>>
>>>>>> I am still not clear why we need to do this recursively ?
>>>>>
>>>>> Some TPDMs are not directly output connected to the TPDAs. So here I
>>>>>
>>>>> use a recursive method to check from the TPDA input port until I find
>>>>>
>>>>> the connected TPDM.
>>>>>
>>>>> Do you have a better suggestion besides a recursive method?
>>>>>
>>>>>>
>>>>>>> +static int tpda_set_element_size(struct tpda_drvdata *drvdata,
>>>>>>> +               struct coresight_device *csdev, int inport, bool 
>>>>>>> parent)
>>>>>>
>>>>>> Please could we renamse csdev => tpda_dev
>>>>>
>>>>> Since this is a recursively called function, this Coresight device 
>>>>> is not
>>>>>
>>>>> necessarily TPDA, it can be other Coresight device.
>>>>>
>>>>>>
>>>>>>> +{
>>>>>>> +    static int nr_inport;
>>>>>>> +    int i;
>>>>>>> +    struct coresight_device *in_csdev;
>>>>>>
>>>>>> similarly tpdm_dev ?
>>>>> Same as above, this variable may not necessarily be a TPDM.
>>>>>>
>>>>>> Could we not add a check here to see if the dsb_esize[inport] is 
>>>>>> already
>>>>>> set and then bail out, reading this over and over ?
>>>>>>
>>>>> I will update this in the next patch series.
>>>>>>> +
>>>>>>> +    if (inport > (TPDA_MAX_INPORTS - 1))
>>>>>>> +        return -EINVAL;
>>>>>>> +
>>>>>>> +    if (parent)
>>>>>>> +        nr_inport = inport;
>>>>>>> +
>>>>>>> +    for (i = 0; i < csdev->pdata->nr_inconns; i++) {
>>>>>>> +        in_csdev = csdev->pdata->in_conns[i].remote_dev;
>>>>>>
>>>>>> Please note, the names of the structure field might change in the
>>>>>> next version of James' series
>>>>> Got it. I will keep an eye out for the James' patch series.
>>>>>>
>>>>>>> +        if (!in_csdev)
>>>>>>> +            break;
>>>>>>> +
>>>>>>> +        if (parent)
>>>>>>> +            if (csdev->pdata->in_conns[i].port != inport)
>>>>>>> +                continue;
>>>>>>> +
>>>>>>> +        if (in_csdev && strstr(dev_name(&in_csdev->dev), "tpdm")) {
>>>>>>
>>>>>> Isn't there a better way to distinguish a device to be TPDM ? May 
>>>>>> be we
>>>>>> could even add a source_sub_type - SOURCE_TPDM instead of using
>>>>>> SOURCE_OTHERS ? Do you expect other sources to be connected to TPDA?
>>>>>> e.g., STMs ?
>>>>>
>>>>> I can add "SOURCE_TPDM" as a source_sub_type, but SOURCE_OTHERS needs
>>>>>
>>>>> to be kept since the other Coresight component we will upstream 
>>>>> later may
>>>>>
>>>>> need it.
>>>>>
>>>>>>
>>>>>>> + of_property_read_u32(in_csdev->dev.parent->of_node,
>>>>>>> +                    "qcom,dsb-element-size", 
>>>>>>> &drvdata->dsb_esize[nr_inport]);
>>>>>>> +            break;
>>>>>>> +        }
>>>>>>> +        tpda_set_element_size(drvdata, in_csdev, 0, false);
>>>>>>
>>>>>> What is the point of this ? Is this for covering the a TPDA 
>>>>>> connected to
>>>>>> another TPDA ?
>>>>>>
>>>>>> e.g., { TPDM0, TPDM1 } -> TPDA0 -> TPDA1 ?
>>>>>
>>>>> A TPDM may not connect to the TPDA directly, for example,
>>>>>
>>>>> TPDM0 ->FUNNEL0->FUNNEL1->TPDA0
>>>>>
>>>>> And many TPDMs can connect to one TPDA, one input port on TPDA only 
>>>>> has
>>>>>
>>>>> one TPDM connected. Therefore, we use a recursive method to find 
>>>>> the TPDM
>>>>>
>>>>> corresponding to the input port of TPDA.
>>>>
>>>> How do you find out decide what to choose, if there are multiple TPDMs
>>>> connected to FUNNEL0 or even FUNNEL1 ?
>>>>
>>>> e.g
>>>>
>>>> TPDM0->FUNNEL0->FUNNEL1->TPDA0
>>>>                 /
>>>>           TPDM1
>>>
>>> We can find out the corresponding TPDM by the input port number of TPDA.
>>>
>>> Each input port is connected to a TPDM. So we have an input port 
>>> number in
>>>
>>> the input parameter of the recursive lookup function 
>>> "tpda_set_element_size".
>>
>> I don't understand, how you would figure out, in the above situation.
>> i.e., FUNNEL1 is connected to TPDA0, but there are two TPDMs that could
>> be pumping the trace. They both arrive via FUNNEL1. So, how does that
>> solve your problem ?
> 
> In our HW design, the input ports of TPDA and TPDM are one-one-one 
> corresponding.  Only one
> 
> TPDM can be found connected from one TPDA's input port. The path to a 
> TPDA input port doesn't
> 
> connect more than one TPDM. It's by HW design.

Your current designs may be like that. But as far as the driver is
concerned, I would like to add in extra measures to ensure that it
encounters a variation from the above on a future platform. So, please
could you add a check to detect this case and add a WARNING ?

Suzuki


> 
> 
> Tao
> 
>>
>> Suzuki
>>
>>
>>>
>>>> Suzuki
>>>>
>>>>
>>

