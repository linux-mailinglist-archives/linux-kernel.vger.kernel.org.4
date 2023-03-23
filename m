Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B196A6C6B74
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjCWOsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjCWOsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:48:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17401DBE2;
        Thu, 23 Mar 2023 07:48:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3BDF4B3;
        Thu, 23 Mar 2023 07:48:53 -0700 (PDT)
Received: from [10.57.53.151] (unknown [10.57.53.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C80A3F6C4;
        Thu, 23 Mar 2023 07:48:06 -0700 (PDT)
Message-ID: <4cde9235-e86a-73a0-5c6c-ac193328006b@arm.com>
Date:   Thu, 23 Mar 2023 14:48:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v3 04/11] coresight-tpdm: Add reset node to TPDM node
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
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
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org
References: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
 <1679551448-19160-5-git-send-email-quic_taozha@quicinc.com>
 <a7484268-49a5-632b-bfc2-8731de01d82b@arm.com>
In-Reply-To: <a7484268-49a5-632b-bfc2-8731de01d82b@arm.com>
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

On 23/03/2023 14:41, Suzuki K Poulose wrote:
> On 23/03/2023 06:04, Tao Zhang wrote:
>> TPDM device need a node to reset the configurations and status of
>> it. This change provides a node to reset the configurations and
>> disable the TPDM if it has been enabled.

Please justify why this "do everything" magic knob is required
when there are tunables for individual controls in the later
patches.

Suzuki

>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 28 
>> ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index 5e1e2ba..104638d 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -161,6 +161,33 @@ static void tpdm_datasets_setup(struct 
>> tpdm_drvdata *drvdata)
>>       drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);
>>   }
>> +static ssize_t reset_store(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      const char *buf,
>> +                      size_t size)
>> +{
>> +    int ret = 0;
>> +    unsigned long val;
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    ret = kstrtoul(buf, 10, &val);
>> +    if (ret || val != 1)
>> +        return -EINVAL;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    /* Reset all datasets to ZERO, and init the default data*/
>> +    tpdm_init_datasets(drvdata);
> 
> With the suggested rename in the previous patch, you wouldn't need
> a comment here.
> 
>> +
>> +    spin_unlock(&drvdata->spinlock);
>> +
> 
> 
>> +    /* Disable tpdm if enabled */
>> +    if (drvdata->enable)
>> +        coresight_disable(drvdata->csdev);
> 
> Couldn't this be done via disable_source ? Please don't overload
> the sysfs handle.
> 
>> +
>> +    return size;
>> +}
>> +static DEVICE_ATTR_WO(reset);
> 
> Documentation for the sysfs node please ?
> 
> Suzuki
> 

