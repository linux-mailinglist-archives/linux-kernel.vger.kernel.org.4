Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC00663F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbjAJLLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjAJLIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:08:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B586712AA1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:08:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 849FE4B3;
        Tue, 10 Jan 2023 03:09:35 -0800 (PST)
Received: from [10.57.37.155] (unknown [10.57.37.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 060B83F587;
        Tue, 10 Jan 2023 03:08:51 -0800 (PST)
Message-ID: <6f89794a-ce14-439a-ce10-55ed175a10fe@arm.com>
Date:   Tue, 10 Jan 2023 11:08:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/3] coresight: cti: Add PM runtime call in
 enable_store
Content-Language: en-US
To:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, mike.leach@linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230106152331.1374973-1-james.clark@arm.com>
 <20230106152331.1374973-3-james.clark@arm.com>
 <91bd54ff-f1e3-aa6b-8446-ad73916be6a7@arm.com>
 <487a882b-8c88-095a-b6b2-d76fddcaecc6@quicinc.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <487a882b-8c88-095a-b6b2-d76fddcaecc6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/01/2023 05:56, Jinlong Mao wrote:
> 
> On 1/10/2023 12:47 AM, Suzuki K Poulose wrote:
>> On 06/01/2023 15:23, James Clark wrote:
>>> From: Mao Jinlong <quic_jinlmao@quicinc.com>
>>>
>>> In commit 6746eae4bbad ("coresight: cti: Fix hang in cti_disable_hw()")
>>> PM runtime calls are removed from cti_enable_hw/cti_disable_hw. When
>>> enabling CTI by writing enable sysfs node, clock for accessing CTI
>>> register won't be enabled. Device will crash due to register access
>>> issue. Add PM runtime call in enable_store to fix this issue.
>>>
>>> Fixes: 6746eae4bbad ("coresight: cti: Fix hang in cti_disable_hw()")
>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>> [Change to only call pm_runtime_put if a disable happened]
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-cti-sysfs.c | 13 +++++++++++--
>>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
>>> b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
>>> index 6d59c815ecf5..71e7a8266bb3 100644
>>> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
>>> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
>>> @@ -108,10 +108,19 @@ static ssize_t enable_store(struct device *dev,
>>>       if (ret)
>>>           return ret;
>>>   -    if (val)
>>> +    if (val) {
>>> +        ret = pm_runtime_resume_and_get(dev->parent);
>>> +        if (ret)
>>> +            return ret;
>>>           ret = cti_enable(drvdata->csdev);
>>> -    else
>>> +        if (ret)
>>> +            pm_runtime_put(dev->parent);
>>> +    } else {
>>>           ret = cti_disable(drvdata->csdev);
>>> +        if (!ret)
>>> +            pm_runtime_put(dev->parent);
>>> +    }
>>> +
>>>       if (ret)
>>>           return ret;
>>>       return size;
>>
>> Looks good to me.
>>
>> @Mao Jinolong,
>>
>> Are you able to test the patches 1 & 2 and confirm they solve your
>> issue ?
> 
> Hi Suzuki,
> 
> Tested from my side. Patch 1 & 2 can solve the issue when enable CTI by
> writing 1 to enable sysfs node.

Thanks, I added your tested-by tag on patches 1 + 2.
