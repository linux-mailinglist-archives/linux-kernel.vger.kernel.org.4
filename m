Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F1771084E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbjEYJIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjEYJIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:08:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41F7E19D;
        Thu, 25 May 2023 02:08:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0382F1FB;
        Thu, 25 May 2023 02:09:05 -0700 (PDT)
Received: from [10.57.70.156] (unknown [10.57.70.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DBA83F67D;
        Thu, 25 May 2023 02:08:17 -0700 (PDT)
Message-ID: <9f414290-0219-302f-ca8b-231217e68efb@arm.com>
Date:   Thu, 25 May 2023 10:08:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v4 02/11] coresight-tpda: Add DSB dataset support
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
References: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
 <1682586037-25973-3-git-send-email-quic_taozha@quicinc.com>
 <444bc278-a3e3-7d99-6020-7c3337371f66@arm.com>
 <9c4c4ea0-b5dd-d18a-fadf-cd3a65c2cf5a@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <9c4c4ea0-b5dd-d18a-fadf-cd3a65c2cf5a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2023 08:16, Tao Zhang wrote:
> 
> On 5/23/2023 6:07 PM, Suzuki K Poulose wrote:
>> On 27/04/2023 10:00, Tao Zhang wrote:
>>> Read the DSB element size from the device tree. Set the register
>>> bit that controls the DSB element size of the corresponding port.
>>>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-core.c |  1 +
>>>   drivers/hwtracing/coresight/coresight-tpda.c | 92 
>>> +++++++++++++++++++++++++---
>>>   drivers/hwtracing/coresight/coresight-tpda.h |  4 ++
>>>   drivers/hwtracing/coresight/coresight-tpdm.c |  2 +-
>>>   include/linux/coresight.h                    |  1 +
>>>   5 files changed, 90 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c 
>>> b/drivers/hwtracing/coresight/coresight-core.c
>>> index 2af416b..f1eacbb 100644
>>> --- a/drivers/hwtracing/coresight/coresight-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>>> @@ -1092,6 +1092,7 @@ static int coresight_validate_source(struct 
>>> coresight_device *csdev,
>>>         if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
>>>           subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
>>> +        subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM &&
>>>           subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS) {
>>>           dev_err(&csdev->dev, "wrong device subtype in %s\n", 
>>> function);
>>>           return -EINVAL;
>>
>> Please see the comment at the bottom.
>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c 
>>> b/drivers/hwtracing/coresight/coresight-tpda.c
>>> index 8d2b9d2..af9c72f 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>>> @@ -21,6 +21,56 @@
>>>     DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
>>>   +/* Search and read element data size from the TPDM node in
>>> + * the devicetree. Each input port of TPDA is connected to
>>> + * a TPDM. Different TPDM supports different types of dataset,
>>> + * and some may support more than one type of dataset.
>>> + * Parameter "inport" is used to pass in the input port number
>>> + * of TPDA, and it is set to 0 in the recursize call.
>>> + * Parameter "parent" is used to pass in the original call.
>>> + */
>>> +static int tpda_set_element_size(struct tpda_drvdata *drvdata,
>>> +               struct coresight_device *csdev, int inport, bool parent)
>>> +{
>>> +    static int nr_inport;
>>> +    int i;
>>> +    static bool tpdm_found;
>>> +    struct coresight_device *in_csdev;
>>> +
>>> +    if (inport > (TPDA_MAX_INPORTS - 1))
>>> +        return -EINVAL;
>>> +
>>> +    if (parent) {
>>> +        nr_inport = inport;
>>> +        tpdm_found = false;
>>> +    }
>>> +
>>> +    for (i = 0; i < csdev->pdata->nr_inconns; i++) {
>>> +        in_csdev = csdev->pdata->in_conns[i]->src_dev;
>>> +        if (!in_csdev)
>>> +            break;
>>> +
>>> +        if (parent)
>>> +            if (csdev->pdata->in_conns[i]->dest_port != inport)
>>> +                continue;
>>> +
>>> +        if (in_csdev->subtype.source_subtype
>>
>> We must match the in_csdev->type to be SOURCE && the subtype.
> Sure, I will update it in the next patch series.
>>
>>> +                   == CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM) {
>>> + of_property_read_u8(in_csdev->dev.parent->of_node,
>>> +                    "qcom,dsb-element-size", 
>>> &drvdata->dsb_esize[nr_inport]);
>>> +            if (!tpdm_found)
>>> +                tpdm_found = true;
>>> +            else
>>> +                dev_warn(drvdata->dev,
>>> +                    "More than one TPDM is mapped to the TPDA input 
>>> port %d.\n",
>>> +                    nr_inport);
>>
>> When we know, we have found a source device, we don't need to recurse
>> down and could simply 'continue' to the next one in the list and skip
>> the call below.
> 
> Actually, one input port on TPDA only can connect to one TPDM. In the 
> current design, it will
> 
> find out all the TPDMs on one input port and warn the users all the 
> TPDMs it found. If we
> 
> replace 'recurse down' as 'continue' here, it may not find some TPDMs 
> that might be connected
> 
> incorrectly.


What do you mean ? When you enter the if () above, the in_csdev is a
source and it is TPDM. There must be no input connections TPDM, i.e.
in_csdev, so no need to go further up the connection chain looking at
the in_csdev. The loop will continue to analyse this device (where we
found one TPDM already) and detect any further duplicate TPDMs
connected.

Suzuki


