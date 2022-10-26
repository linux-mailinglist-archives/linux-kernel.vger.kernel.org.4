Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E5C60E325
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbiJZOSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbiJZOSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:18:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73AD810F891;
        Wed, 26 Oct 2022 07:18:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E72623A;
        Wed, 26 Oct 2022 07:18:57 -0700 (PDT)
Received: from [10.57.68.77] (unknown [10.57.68.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A84B33F71A;
        Wed, 26 Oct 2022 07:18:48 -0700 (PDT)
Message-ID: <23503d33-2761-50b5-91dd-4138494e54d5@arm.com>
Date:   Wed, 26 Oct 2022 15:18:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH 3/9] coresight-tpdm: Initialize DSB subunit configuration
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org
References: <1662626705-13097-1-git-send-email-quic_taozha@quicinc.com>
 <1662626705-13097-4-git-send-email-quic_taozha@quicinc.com>
 <aa2b93f2-9916-bcf1-4d5f-dc749fe2944e@arm.com>
 <72af1fa4-fa64-7f23-4000-db6d6a9f7f22@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <72af1fa4-fa64-7f23-4000-db6d6a9f7f22@quicinc.com>
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

On 26/10/2022 09:10, Tao Zhang wrote:
> Hi Suzuki,
> 
> 在 10/24/2022 6:02 PM, Suzuki K Poulose 写道:
>> Hi
>>
>> On 08/09/2022 09:44, Tao Zhang wrote:
>>> DSB subunit need to be configured in enablement and disablement.
>>> A struct that specifics associated to dsb dataset is needed. It
>>> saves the configuration and parameters of the dsb datasets. This
>>> change is to add this struct and initialize the configuration of
>>> DSB subunit.
>>>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-tpdm.c | 44 
>>> ++++++++++++++++++++++++++--
>>>   drivers/hwtracing/coresight/coresight-tpdm.h | 17 +++++++++++
>>>   2 files changed, 58 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>>> index 88df3e6..69ea453 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>>> @@ -24,6 +24,22 @@ static void tpdm_enable_dsb(struct tpdm_drvdata 
>>> *drvdata)
>>>   {
>>>       u32 val;
>>>   +    val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>>> +    /* Set trigger timestamp */
>>> +    if (drvdata->dsb->trig_ts)
>>
>> What happens if this instance doesn't have a DSB set ? Have
>> you tested this on a system without the DSB ?
>>
> The function "tpdm_enable_dsb" will only be called when it is checked 
> that the DSB dataset is present.
> 
> And only the TPDM that supports the DSB dataset will have the DSB TIER 
> register.
> 
> If the TPDM doesn't support the DSB dataset, this instance should not be 
> run. Otherwise, it will cause that the incorrect register is accessed.

Thanks, this is what happens when you send something that is not queued
anywhwere. Please provide a reference tree in the future, for ease of
reviewing such things

Suzuki


