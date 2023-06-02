Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6857871FBF9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjFBI02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbjFBIZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:25:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3459D1B6;
        Fri,  2 Jun 2023 01:25:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C91F41063;
        Fri,  2 Jun 2023 01:26:14 -0700 (PDT)
Received: from [10.57.22.125] (unknown [10.57.22.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA7D83F67D;
        Fri,  2 Jun 2023 01:25:26 -0700 (PDT)
Message-ID: <222b86c9-2a6f-cb9f-8803-406a724614c7@arm.com>
Date:   Fri, 2 Jun 2023 09:25:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH v4 06/11] coresight-tpdm: Add node to set dsb programming
 mode
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
 <1682586037-25973-7-git-send-email-quic_taozha@quicinc.com>
 <4e413a50-001d-cfbf-99a4-7e612f44ed38@arm.com>
 <053da70b-3d01-a3e5-4703-4e5cf23831ed@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <053da70b-3d01-a3e5-4703-4e5cf23831ed@quicinc.com>
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

On 02/06/2023 03:58, Tao Zhang wrote:
> 
> On 6/1/2023 5:23 PM, Suzuki K Poulose wrote:
>> On 27/04/2023 10:00, Tao Zhang wrote:
>>> Add node to set and show programming mode for TPDM DSB subunit.
>>> Once the DSB programming mode is set, it will be written to the
>>> register DSB_CR.
>>>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>> ---
>>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 15 ++++++
>>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 62 
>>> ++++++++++++++++++++++
>>>   drivers/hwtracing/coresight/coresight-tpdm.h       | 16 ++++++
>>>   3 files changed, 93 insertions(+)
>>>
>>> diff --git 
>>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>> index 77e67f2..348e167 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>> @@ -45,3 +45,18 @@ Description:
>>>           Accepts only one of the 2 values -  0 or 1.
>>>           0 : Set the DSB trigger type to false
>>>           1 : Set the DSB trigger type to true
>>> +
>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_mode
>>> +Date:        March 2023
>>> +KernelVersion    6.3
>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>>> (QUIC) <quic_taozha@quicinc.com>
>>> +Description:
>>> +        (Write) Set the mode of DSB tpdm. Read the mode of DSB
>>> +        tpdm.
>>> +
>>> +        Accepts the value needs to be greater than 0. What data
>>> +        bits do is listed below.
>>> +        Bit[0:1] : Test mode control bit for choosing the inputs.
>>> +        Bit[3] : Set to 0 for low performance mode.
>>> +                 Set to 1 for high performance mode.
>>> +        Bit[4:8] : Select byte lane for high performance mode.
>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>>> index 14f4352..1bacaa5 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>>> @@ -4,6 +4,7 @@
>>>    */
>>>     #include <linux/amba/bus.h>
>>> +#include <linux/bitfield.h>
>>>   #include <linux/bitmap.h>
>>>   #include <linux/coresight.h>
>>>   #include <linux/coresight-pmu.h>
>>> @@ -43,6 +44,32 @@ static void tpdm_reset_datasets(struct 
>>> tpdm_drvdata *drvdata)
>>>       }
>>>   }
>>>   +static void set_dsb_test_mode(struct tpdm_drvdata *drvdata, u32 *val)
>>> +{
>>> +    u32 mode;
>>> +
>>> +    mode = TPDM_DSB_MODE_TEST(drvdata->dsb->mode);
>>> +    *val &= ~TPDM_DSB_TEST_MODE;
>>> +    *val |= FIELD_PREP(TPDM_DSB_TEST_MODE, mode);
>>> +}
>>> +
>>> +static void set_dsb_hpsel_mode(struct tpdm_drvdata *drvdata, u32 *val)
>>> +{
>>> +    u32 mode;
>>> +
>>> +    mode = TPDM_DSB_MODE_HPBYTESEL(drvdata->dsb->mode);
>>> +    *val &= ~TPDM_DSB_HPSEL;
>>> +    *val |= FIELD_PREP(TPDM_DSB_HPSEL, mode);
>>> +}
>>> +
>>> +static void set_dsb_perf_mode(struct tpdm_drvdata *drvdata, u32 *val)
>>> +{
>>> +    if (drvdata->dsb->mode & TPDM_DSB_MODE_PERF)
>>> +        *val |= TPDM_DSB_CR_MODE;
>>> +    else
>>> +        *val &= ~TPDM_DSB_CR_MODE;
>>> +}
>>> +
>>>   static void set_trigger_type(struct tpdm_drvdata *drvdata, u32 *val)
>>>   {
>>>       if (drvdata->dsb->trig_type)
>>> @@ -64,6 +91,12 @@ static void tpdm_enable_dsb(struct tpdm_drvdata 
>>> *drvdata)
>>>       writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
>>>         val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>>> +    /* Set the test accurate mode */
>>> +    set_dsb_test_mode(drvdata, &val);
>>> +    /* Set the byte lane for high-performance mode */
>>> +    set_dsb_hpsel_mode(drvdata, &val);
>>> +    /* Set the performance mode */
>>> +    set_dsb_perf_mode(drvdata, &val);
>>>       /* Set trigger type */
>>>       set_trigger_type(drvdata, &val);
>>>       /* Set the enable bit of DSB control register to 1 */
>>> @@ -252,6 +285,34 @@ static struct attribute_group tpdm_attr_grp = {
>>>       .attrs = tpdm_attrs,
>>>   };
>>>   +static ssize_t dsb_mode_show(struct device *dev,
>>> +                  struct device_attribute *attr,
>>> +                  char *buf)
>>> +{
>>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>> +
>>> +    return sysfs_emit(buf, "%lx\n",
>>> +             (unsigned long)drvdata->dsb->mode);
>>> +}
>>> +
>>> +static ssize_t dsb_mode_store(struct device *dev,
>>> +                   struct device_attribute *attr,
>>> +                   const char *buf,
>>> +                   size_t size)
>>> +{
>>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>> +    unsigned long val;
>>> +
>>> +    if ((kstrtoul(buf, 0, &val)) || val < 0)
>>> +        return -EINVAL;
>>> +
>>> +    spin_lock(&drvdata->spinlock);
>>> +    drvdata->dsb->mode = val & TPDM_MODE_ALL;
>>> +    spin_unlock(&drvdata->spinlock);
>>> +    return size;
>>> +}
>>> +static DEVICE_ATTR_RW(dsb_mode);
>>> +
>>>   static ssize_t dsb_trig_type_show(struct device *dev,
>>>                        struct device_attribute *attr, char *buf)
>>>   {
>>> @@ -323,6 +384,7 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
>>>   static DEVICE_ATTR_RW(dsb_trig_ts);
>>>     static struct attribute *tpdm_dsb_attrs[] = {
>>> +    &dev_attr_dsb_mode.attr,
>>>       &dev_attr_dsb_trig_ts.attr,
>>>       &dev_attr_dsb_trig_type.attr,
>>>       NULL,
>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>>> index 68f33bd..79df07e 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>>> @@ -15,11 +15,25 @@
>>>     /* Enable bit for DSB subunit */
>>>   #define TPDM_DSB_CR_ENA        BIT(0)
>>> +/* Enable bit for DSB subunit perfmance mode */
>>> +#define TPDM_DSB_CR_MODE        BIT(1)
>>>   /* Enable bit for DSB subunit trigger type */
>>>   #define TPDM_DSB_CR_TRIG_TYPE        BIT(12)
>>> +
>>>   /* Enable bit for DSB subunit trigger timestamp */
>>>   #define TPDM_DSB_TIER_XTRIG_TSENAB        BIT(1)
>>>   +/* DSB programming modes */
>>> +/* Test mode control bit*/
>>> +#define TPDM_DSB_MODE_TEST(val)    (val & GENMASK(1, 0))
>>> +/* Perforceman mode */
>>
>> minor nit: typo ^^
> I will update this in the next patch series.
>>
>>> +#define TPDM_DSB_MODE_PERF        BIT(3)
>>> +/* High performance mode */
>>> +#define TPDM_DSB_MODE_HPBYTESEL(val)    (val & GENMASK(8, 4))
>>> +#define TPDM_MODE_ALL            (0xFFFFFFF)
>>
>> GENMASK(27, 0) ?
>>
>> Also, why do we cover bits 27-0 ?
> 
> The TPDM mode is only represented by [0:8]bits.
> 
> Can I replace it with "#define TPDM_DSB_MODE(val)    (VAL & GENMASK(8, 
> 0))"?

#define TPDM_DSB_MODE_MASK		GENMASK(8, 0) ?

Suzuki
