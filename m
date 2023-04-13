Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C076E0706
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 08:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjDMGfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 02:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMGfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 02:35:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BFF7DB3;
        Wed, 12 Apr 2023 23:35:20 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33D6Aok5011867;
        Thu, 13 Apr 2023 06:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kHljZwQNcB0AQdTvYs4LRPjVSW98AdrwT5glQ9gXvDA=;
 b=BaqSj02S+QtfnmOptZ+th+QjzS0IH6GeC8f+ho0fepvP0pl8mYI/n9TJ1aeywv7I6yke
 pCMSla217sHSdbglVvNdEwuXT8X9AaiHl8AtIclqQbtspcWrQDohwBPQI9qPRC+g4N4g
 llonhVxjIXHZHxGmUdRlSoEAIGhUtATZVWjVjyOJkPsb2uqRGy3gYODaJv+zPAcruf3B
 n/WqrbbO0n9RZYzOEuJRkCpCnLWIpX2LmoOXXPSEhrxymjACMXk5jZhDuXNG7gP3R/cI
 Wt9RwuzdPSY/mY7tAHN47ttauR1WXca3hcIB1Y0aKfYyh50EATRK94PXP8NA0yWVl66X pA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwsx6a8g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 06:35:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33D6Z1qL009310
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 06:35:01 GMT
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 12 Apr
 2023 23:34:58 -0700
Message-ID: <2a491e07-9a02-b077-07a6-9bed30a9175a@quicinc.com>
Date:   Thu, 13 Apr 2023 14:34:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] coresight: Add support of setting trace id
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-msm@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20230410133930.30519-1-quic_jinlmao@quicinc.com>
 <CAJ9a7VjgpkfYFUQtB3drZdgjaSk9PzWbJfvgZfuFf5y5WR0eQQ@mail.gmail.com>
 <375d6c20-3264-8892-7365-a012bf6b0346@quicinc.com>
 <CAJ9a7Vis-Vsi=J9i1XHF0PTkLs1OzD9-xjedGAT447KiDdY-NA@mail.gmail.com>
 <8875164b-f0f4-f444-dfec-673fc115ab8f@quicinc.com>
 <CAJ9a7Vg6mYuWDgQ0-bTh_wA-DQpTHKr0x6dDtZK1HQ-_-LtUNg@mail.gmail.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <CAJ9a7Vg6mYuWDgQ0-bTh_wA-DQpTHKr0x6dDtZK1HQ-_-LtUNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yi6njQmlHzxTM46O6LDJWFiXx129pE5Y
X-Proofpoint-ORIG-GUID: yi6njQmlHzxTM46O6LDJWFiXx129pE5Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_03,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304130059
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 4/12/2023 5:50 PM, Mike Leach wrote:
> Hi,
>
> On Wed, 12 Apr 2023 at 10:30, Jinlong Mao <quic_jinlmao@quicinc.com> wrote:
>> Hi Mike,
>>
>> On 4/12/2023 4:45 PM, Mike Leach wrote:
>>> Hi
>>>
>>> On Wed, 12 Apr 2023 at 03:53, Jinlong Mao <quic_jinlmao@quicinc.com> wrote:
>>>> Hi Mike,
>>>>
>>>> On 4/11/2023 10:09 PM, Mike Leach wrote:
>>>>> Hi,
>>>>>
>>>>> On Mon, 10 Apr 2023 at 14:40, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>>>>>> With a growing number of trace sources, the number of source could
>>>>>> be greater than 127 in future. There will be lack of ids. There could
>>>>>> be also trace id reserved for some trace HW. With this change,
>>>>>> trace id will be only configured when enable the source. Trace id
>>>>>> will be dynamically allocated when traceid of driver data is not
>>>>>> set when enable source. Once traceid of driver data is set when
>>>>>> enable source, the traceid will be set as the specific value.
>>>>>>
>>>>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>>> This change is to add trace id support for the following two cases:
>>>> 1. There are more than 127 sources like there are 200 sources which need
>>>> the trace id.
>>>> then 127 is not enough to allocate the ids for all the trace sources.
>>> Agreed - and that is precisely why we introduced the dynamic
>>> allocation patch set.
>>>
>>> (The actual number is slightly less than 127 as IDs 0x0 and 0x70 to
>>> 0x7F are reserved.)
>>>
>>> However, there is no need for your changes in this case. The dynamic
>>> allocator will allocate up to the maximum IDs, then will return an
>>> error. The design is such that the allocator controls the available
>>> IDs and the requestor must always use the assigned ID. Devices should
>>> never be setting their own ID (other than the case of trace Id
>>> hardwired into a device below).
>>>
>>> IDs are returned to the pool either:-
>>>
>>> a) in the perf case, once the perf session is complete. We must
>>> maintain a CPU / Trace ID relationship throughout the perf session to
>>> correctly associate trace data in the perf file to the relevant CPU
>>> for decode. perf can cause multiple enable / disable events per CPU
>>> during a single trace session.
>>>
>>> b) in the sysfs case, once the sysfs device is reset. (in the ETM4
>>> case for example when the sysfs reset file is written). The reason for
>>> this is that the user can enable the ETM via sysfs, which will then
>>> allocate an ID. This may be read by the user who will assume it is
>>> constant throughout the lifetime of a trace session (which again may
>>> be multiple enable / disable events). This maintains the original
>>> functionality of the previous static allocation mechanism. The only
>>> change with the dynamic mechanism is that the ID is released on reset.
>>>
>>> Your change merely replicates the functionality of the allocator that
>>> assigns an ID to the CPU, and always maintains the ID for that CPU
>>> throughout the trace session. You are calling the read/allocate call,
>>> then setting the same ID each time we enable - this is precisely the
>>> exisiting functionality - with the added race condition that you may
>>> be setting an ID already in use if you have previously released it.
>>> This is not desireable.
>>>
>>> Moreover, this potentially breaks the perf case which requries that
>>> the IDs remain constant for a given CPU for the duration of the perf
>>> sessions, which may result in many enable/disable cycles for a
>>> CPU/ETM. Any allocation system must work for both the perf and sysfs
>>> cases.
>>>
>>> So any trace session that has sources in access of the number of
>>> available IDs, must choose carefully the sources to be involved in the
>>> trace session. This is an unavoidable limitation of trace where
>>> multiple sources trace into a single trace buffer. This problem is
>>> significantly reduced in v9 / ETE cases where each ETE / cpu
>>> combination has its own TRBE buffer and does not need a trace ID.
>>>
>>>> 2. HW component that has a specific trace id hard-coded into the HW that
>>>> cannot be changed.
>>>>
>>> Then this must be managed with by allocating an ID at the device probe
>>> time, and release once the driver is unloaded. Otherwise there could
>>> be a potential clash if the hard coded value is taken by another
>>> device while the hard coded device is not in use, or is enabled before
>>> the hard coded device.
>>>
>>> If this is actually needed on your system, then the preferred method
>>> would be a coresight_reserve_id(id) API function, to ensure that the
>>> hardcoded ID is removed from the pool of IDs as soon as possible., and
>>> unreserved on device unload.
>>>
>>> It is not advisable to have many hard coded devices in a system as
>>> this will deplete the pool of available trace IDs.
>>>
>>>
>>>> To support cases above, I think we need to make following changes:
>>>> Each driver can call trace id set funnction
>>>> (coresight_trace_id_set_system_id/coresight_trace_id_set_cpu_id)
>>>> to set the id.
>>>> Set the id when enable the source and release the id when disable the
>>>> source.
>>>>
>>> See my explanation above - IDs are only released when the trace
>>> session is complete, as some sessions can result in multiple
>>> enable/disable cycles where the ID/ CPU is maintained as constant.
>>>
>>> Best Regards
>>>
>>> Mike
>> Thanks for your clarification.
>>
>> We also have case that decode tool can set the trace id of source by
>> sysfs node so that tool
>> can control the source's traceid.
>>
> Unfortunately this is not compatible with the allocator mechanisms
> detailed above - due to potential races introduced by any API to allow
> the devices to set their own Trace IDs.
>
> Your tool needs to read the IDs allocated  to devices via sysfs.
>
> Regards
>
> Mike

It is possible that user loses the trace id info during a long time test 
with lots of enbaling/disabling source
and device reboot.  We can use a boot up service to configure the trace 
id of some special source for test.
Then the trace id of the source will be static during enabling/disable 
and reboot.

Allocating the id dynamically in code and assigning the trace id by 
sysfs node can be coexisting.

Best Regards
Jinlong Mao

>
>> Best Regards
>> Jinlong Mao
>>
>>>> Please help to provide your comments.
>>>>
>>>> Thanks
>>>> Jinlong Mao
>>>>
>>>>>> ---
>>>>>>     .../coresight/coresight-etm4x-core.c          |  35 +++---
>>>>>>     .../coresight/coresight-etm4x-sysfs.c         |  30 +++++
>>>>>>     drivers/hwtracing/coresight/coresight-stm.c   |  67 ++++++++---
>>>>>>     drivers/hwtracing/coresight/coresight-tpda.c  | 107 ++++++++++++++----
>>>>>>     drivers/hwtracing/coresight/coresight-tpda.h  |   4 +-
>>>>>>     .../hwtracing/coresight/coresight-trace-id.c  |  56 +++++++++
>>>>>>     .../hwtracing/coresight/coresight-trace-id.h  |  24 ++++
>>>>>>     7 files changed, 274 insertions(+), 49 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>>>> index 1ea8f173cca0..8f2e4d2b0fc2 100644
>>>>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>>>> @@ -233,25 +233,32 @@ static int etm4_cpu_id(struct coresight_device *csdev)
>>>>>>
>>>>>>     int etm4_read_alloc_trace_id(struct etmv4_drvdata *drvdata)
>>>>>>     {
>>>>>> -       int trace_id;
>>>>>> +       int trace_id, ret = 0;
>>>>>>
>>>>>> -       /*
>>>>>> -        * This will allocate a trace ID to the cpu,
>>>>>> -        * or return the one currently allocated.
>>>>>> -        * The trace id function has its own lock
>>>>>> -        */
>>>>>> -       trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
>>>>>> -       if (IS_VALID_CS_TRACE_ID(trace_id))
>>>>>> -               drvdata->trcid = (u8)trace_id;
>>>>>> -       else
>>>>>> -               dev_err(&drvdata->csdev->dev,
>>>>>> -                       "Failed to allocate trace ID for %s on CPU%d\n",
>>>>>> -                       dev_name(&drvdata->csdev->dev), drvdata->cpu);
>>>>>> -       return trace_id;
>>>>>> +       if (!drvdata->trcid) {
>>>>>> +               /*
>>>>>> +                * This will allocate a trace ID to the cpu,
>>>>>> +                * or return the one currently allocated.
>>>>>> +                * The trace id function has its own lock
>>>>>> +                */
>>>>>> +               trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
>>>>>> +               if (IS_VALID_CS_TRACE_ID(trace_id))
>>>>>> +                       drvdata->trcid = (u8)trace_id;
>>>>>> +               else {
>>>>>> +                       ret = -EINVAL;
>>>>>> +                       dev_err(&drvdata->csdev->dev,
>>>>>> +                               "Failed to allocate trace ID for %s on CPU%d\n",
>>>>>> +                               dev_name(&drvdata->csdev->dev), drvdata->cpu);
>>>>>> +               }
>>>>>> +       } else
>>>>>> +               ret = coresight_trace_id_set_cpu_id(drvdata->cpu, drvdata->trcid);
>>>>>> +
>>>>>> +       return ret;
>>>>>>     }
>>>>> This change is redundant. coresight_trace_id_get_cpu_id() will
>>>>> allocate a trace id to the cpu if none is currently mapped, otherwise
>>>>> it will return the currently mapped trace id.
>>>>> There is no need to remap the id to the cpu every time.
>>>>>
>>>>>>     void etm4_release_trace_id(struct etmv4_drvdata *drvdata)
>>>>>>     {
>>>>>> +       drvdata->trcid = 0;
>>>>>>            coresight_trace_id_put_cpu_id(drvdata->cpu);
>>>>>>     }
>>>>>>
>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
>>>>>> index 5e62aa40ecd0..bd342e63868c 100644
>>>>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
>>>>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
>>>>>> @@ -2335,6 +2335,35 @@ static ssize_t ts_source_show(struct device *dev,
>>>>>>     }
>>>>>>     static DEVICE_ATTR_RO(ts_source);
>>>>>>
>>>>>> +static ssize_t traceid_show(struct device *dev,
>>>>>> +                           struct device_attribute *attr, char *buf)
>>>>>> +{
>>>>>> +       int val;
>>>>>> +       struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>>>> +
>>>>>> +       val = drvdata->trcid;
>>>>>> +       return sysfs_emit(buf, "0x%x\n", val);
>>>>>> +}
>>>>>> +
>>>>> This is also redundant. It replicates the trctraceid_show function
>>>>>
>>>>>> +static ssize_t traceid_store(struct device *dev,
>>>>>> +                           struct device_attribute *attr,
>>>>>> +                           const char *buf, size_t size)
>>>>>> +{
>>>>>> +       int ret;
>>>>>> +       unsigned long val;
>>>>>> +       struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>>>> +
>>>>>> +       ret = kstrtoul(buf, 16, &val);
>>>>>> +       if (ret)
>>>>>> +               return ret;
>>>>>> +
>>>>>> +       if (!drvdata->csdev->enable)
>>>>>> +               drvdata->trcid = val;
>>>>>> +
>>>>>> +       return size;
>>>>>> +}
>>>>>> +static DEVICE_ATTR_RW(traceid);
>>>>>> +
>>>>> Users are not permitted to set trace id values manually in this way.
>>>>> This will potentially set an ID that is already used for another
>>>>> device.
>>>>>
>>>>>
>>>>>>     static struct attribute *coresight_etmv4_attrs[] = {
>>>>>>            &dev_attr_nr_pe_cmp.attr,
>>>>>>            &dev_attr_nr_addr_cmp.attr,
>>>>>> @@ -2390,6 +2419,7 @@ static struct attribute *coresight_etmv4_attrs[] = {
>>>>>>            &dev_attr_vmid_masks.attr,
>>>>>>            &dev_attr_cpu.attr,
>>>>>>            &dev_attr_ts_source.attr,
>>>>>> +       &dev_attr_traceid.attr,
>>>>>>            NULL,
>>>>>>     };
>>>>>>
>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
>>>>>> index 66a614c5492c..1291f5f39ab1 100644
>>>>>> --- a/drivers/hwtracing/coresight/coresight-stm.c
>>>>>> +++ b/drivers/hwtracing/coresight/coresight-stm.c
>>>>>> @@ -192,10 +192,29 @@ static void stm_enable_hw(struct stm_drvdata *drvdata)
>>>>>>            CS_LOCK(drvdata->base);
>>>>>>     }
>>>>>>
>>>>>> +static int stm_configure_trace_id(struct stm_drvdata *drvdata)
>>>>>> +{
>>>>>> +       int traceid, ret = 0;
>>>>>> +
>>>>>> +       if (!drvdata->traceid) {
>>>>>> +               traceid = coresight_trace_id_get_system_id();
>>>>>> +               if (traceid < 0)
>>>>>> +                       return traceid;
>>>>>> +
>>>>>> +               drvdata->traceid = traceid;
>>>>>> +       } else
>>>>>> +               ret = coresight_trace_id_set_system_id(drvdata->traceid);
>>>>>> +
>>>>>> +       return ret;
>>>>>> +
>>>>>> +}
>>>>>> +
>>>>> again the mapping function remain with the id reserved till the put id
>>>>> is called, so no need to set the id every time once allocated.
>>>>>
>>>>>>     static int stm_enable(struct coresight_device *csdev,
>>>>>>                          struct perf_event *event, u32 mode)
>>>>>>     {
>>>>>>            u32 val;
>>>>>> +       int ret;
>>>>>> +
>>>>>>            struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>>>>>
>>>>>>            if (mode != CS_MODE_SYSFS)
>>>>>> @@ -207,6 +226,10 @@ static int stm_enable(struct coresight_device *csdev,
>>>>>>            if (val)
>>>>>>                    return -EBUSY;
>>>>>>
>>>>>> +       ret = stm_configure_trace_id(drvdata);
>>>>>> +       if (ret)
>>>>>> +               return ret;
>>>>>> +
>>>>>>            pm_runtime_get_sync(csdev->dev.parent);
>>>>>>
>>>>>>            spin_lock(&drvdata->spinlock);
>>>>>> @@ -261,6 +284,8 @@ static void stm_disable(struct coresight_device *csdev,
>>>>>>            struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>>>>>            struct csdev_access *csa = &csdev->access;
>>>>>>
>>>>>> +
>>>>>> +       coresight_trace_id_put_system_id(drvdata->traceid);
>>>>> Enabling and releasing trace Ids in this way is potentially
>>>>> problematical if the device is enabled and disabled multiple times
>>>>> during a single trace recording session. Differnt IDs could be used.
>>>>>
>>>>> We enable this ID at probe time as we expect there to be only a single
>>>>> STM on any system - so allocating an ID for the lifetime of the driver
>>>>> is reasonable.
>>>>> If this change is required, then the sysfs model of allovate on read
>>>>> or enable, release on sysfs reset should be followed.
>>>>>
>>>>>>            /*
>>>>>>             * For as long as the tracer isn't disabled another entity can't
>>>>>>             * change its status.  As such we can read the status here without
>>>>>> @@ -268,6 +293,7 @@ static void stm_disable(struct coresight_device *csdev,
>>>>>>             */
>>>>>>            if (local_read(&drvdata->mode) == CS_MODE_SYSFS) {
>>>>>>                    spin_lock(&drvdata->spinlock);
>>>>>> +               drvdata->traceid = 0;
>>>>>>                    stm_disable_hw(drvdata);
>>>>>>                    spin_unlock(&drvdata->spinlock);
>>>>>>
>>>>>> @@ -608,7 +634,33 @@ static ssize_t traceid_show(struct device *dev,
>>>>>>            val = drvdata->traceid;
>>>>>>            return sprintf(buf, "%#lx\n", val);
>>>>>>     }
>>>>>> -static DEVICE_ATTR_RO(traceid);
>>>>>> +
>>>>>> +static ssize_t traceid_store(struct device *dev,
>>>>>> +                            struct device_attribute *attr,
>>>>>> +                            const char *buf, size_t size)
>>>>>> +{
>>>>>> +       int ret;
>>>>>> +       unsigned long val;
>>>>>> +       struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>>>> +
>>>>>> +       ret = kstrtoul(buf, 16, &val);
>>>>>> +       if (ret)
>>>>>> +               return ret;
>>>>>> +
>>>>>> +       if (!IS_VALID_CS_TRACE_ID(val)) {
>>>>>> +               dev_err(&drvdata->csdev->dev, "Invalid trace id\n");
>>>>>> +               return -EINVAL;
>>>>>> +       }
>>>>>> +
>>>>>> +       if (!drvdata->csdev->enable)
>>>>>> +               drvdata->traceid = val;
>>>>>> +       else
>>>>>> +               dev_err(&drvdata->csdev->dev, "Device must be enabled! %s\n",
>>>>>> +                               __func__);
>>>>>> +
>>>>>> +       return size;
>>>>>> +}
>>>>>> +static DEVICE_ATTR_RW(traceid);
>>>>>>
>>>>> Again do not do this - you are overriding the trace id mapping. Users
>>>>> are not permitted to set arbitrary trace id values in this way
>>>>>
>>>>>>     static struct attribute *coresight_stm_attrs[] = {
>>>>>>            &dev_attr_hwevent_enable.attr,
>>>>>> @@ -806,7 +858,7 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata,
>>>>>>
>>>>>>     static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>>>>>>     {
>>>>>> -       int ret, trace_id;
>>>>>> +       int ret;
>>>>>>            void __iomem *base;
>>>>>>            struct device *dev = &adev->dev;
>>>>>>            struct coresight_platform_data *pdata = NULL;
>>>>>> @@ -890,22 +942,12 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
>>>>>>                    goto stm_unregister;
>>>>>>            }
>>>>>>
>>>>>> -       trace_id = coresight_trace_id_get_system_id();
>>>>>> -       if (trace_id < 0) {
>>>>>> -               ret = trace_id;
>>>>>> -               goto cs_unregister;
>>>>>> -       }
>>>>>> -       drvdata->traceid = (u8)trace_id;
>>>>>> -
>>>>>>            pm_runtime_put(&adev->dev);
>>>>>>
>>>>>>            dev_info(&drvdata->csdev->dev, "%s initialized\n",
>>>>>>                     (char *)coresight_get_uci_data(id));
>>>>>>            return 0;
>>>>>>
>>>>>> -cs_unregister:
>>>>>> -       coresight_unregister(drvdata->csdev);
>>>>>> -
>>>>>>     stm_unregister:
>>>>>>            stm_unregister_device(&drvdata->stm);
>>>>>>            return ret;
>>>>>> @@ -915,7 +957,6 @@ static void stm_remove(struct amba_device *adev)
>>>>>>     {
>>>>>>            struct stm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>>>>>>
>>>>>> -       coresight_trace_id_put_system_id(drvdata->traceid);
>>>>>>            coresight_unregister(drvdata->csdev);
>>>>>>
>>>>>>            stm_unregister_device(&drvdata->stm);
>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
>>>>>> index f712e112ecff..41f83a5de3f2 100644
>>>>>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>>>>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>>>>>> @@ -21,6 +21,28 @@
>>>>>>
>>>>>>     DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
>>>>>>
>>>>>> +static int tpda_configure_trace_id(struct tpda_drvdata *drvdata)
>>>>>> +{
>>>>>> +       int traceid, ret;
>>>>>> +       /*
>>>>>> +        * TPDA must has a unique atid. This atid can uniquely
>>>>>> +        * identify the TPDM trace source connected to the TPDA.
>>>>>> +        * The TPDMs which are connected to same TPDA share the
>>>>>> +        * same trace-id. When TPDA does packetization, different
>>>>>> +        * port will have unique channel number for decoding.
>>>>>> +        */
>>>>>> +       if (!drvdata->traceid) {
>>>>>> +               traceid = coresight_trace_id_get_system_id();
>>>>>> +               if (traceid < 0)
>>>>>> +                       return traceid;
>>>>>> +
>>>>>> +               drvdata->traceid = traceid;
>>>>>> +       } else
>>>>>> +               ret = coresight_trace_id_set_system_id(drvdata->traceid);
>>>>>> +
>>>>> redundant call - system ids are reserved till put system id is called.
>>>>>
>>>>>> +       return ret;
>>>>>> +}
>>>>>> +
>>>>> See above comments get_system_id is sufficient. If you choose to do
>>>>> this on enable, then simply do not call the put till the trace session
>>>>> is finished.
>>>>>
>>>>> You have a potential race here between devices using the system id
>>>>> calls trying to re-claim an id previously released.
>>>>>
>>>>>>     /* Settings pre enabling port control register */
>>>>>>     static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
>>>>>>     {
>>>>>> @@ -28,8 +50,9 @@ static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
>>>>>>
>>>>>>            val = readl_relaxed(drvdata->base + TPDA_CR);
>>>>>>            val &= ~TPDA_CR_ATID;
>>>>>> -       val |= FIELD_PREP(TPDA_CR_ATID, drvdata->atid);
>>>>>> +       val |= FIELD_PREP(TPDA_CR_ATID, drvdata->traceid);
>>>>>>            writel_relaxed(val, drvdata->base + TPDA_CR);
>>>>>> +
>>>>>>     }
>>>>>>
>>>>>>     static void tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>>>>>> @@ -52,11 +75,17 @@ static void __tpda_enable(struct tpda_drvdata *drvdata, int port)
>>>>>>            tpda_enable_port(drvdata, port);
>>>>>>
>>>>>>            CS_LOCK(drvdata->base);
>>>>>> +
>>>>>>     }
>>>>>>
>>>>>>     static int tpda_enable(struct coresight_device *csdev, int inport, int outport)
>>>>>>     {
>>>>>>            struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>>>>> +       int ret;
>>>>>> +
>>>>>> +       ret = tpda_configure_trace_id(drvdata);
>>>>>> +       if (ret)
>>>>>> +               return ret;
>>>>>>
>>>>>>            spin_lock(&drvdata->spinlock);
>>>>>>            if (atomic_read(&csdev->refcnt[inport]) == 0)
>>>>>> @@ -87,7 +116,11 @@ static void tpda_disable(struct coresight_device *csdev, int inport,
>>>>>>     {
>>>>>>            struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>>>>>
>>>>>> +       coresight_trace_id_put_system_id(drvdata->traceid);
>>>>>>            spin_lock(&drvdata->spinlock);
>>>>>> +
>>>>>> +       drvdata->traceid = 0;
>>>>>> +
>>>>>>            if (atomic_dec_return(&csdev->refcnt[inport]) == 0)
>>>>>>                    __tpda_disable(drvdata, inport);
>>>>>>
>>>>>> @@ -105,27 +138,63 @@ static const struct coresight_ops tpda_cs_ops = {
>>>>>>            .link_ops       = &tpda_link_ops,
>>>>>>     };
>>>>>>
>>>>>> -static int tpda_init_default_data(struct tpda_drvdata *drvdata)
>>>>>> +static ssize_t traceid_show(struct device *dev,
>>>>>> +                           struct device_attribute *attr, char *buf)
>>>>>>     {
>>>>>> -       int atid;
>>>>>> -       /*
>>>>>> -        * TPDA must has a unique atid. This atid can uniquely
>>>>>> -        * identify the TPDM trace source connected to the TPDA.
>>>>>> -        * The TPDMs which are connected to same TPDA share the
>>>>>> -        * same trace-id. When TPDA does packetization, different
>>>>>> -        * port will have unique channel number for decoding.
>>>>>> -        */
>>>>>> -       atid = coresight_trace_id_get_system_id();
>>>>>> -       if (atid < 0)
>>>>>> -               return atid;
>>>>>> +       int val;
>>>>>> +       struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>>>>
>>>>>> -       drvdata->atid = atid;
>>>>>> -       return 0;
>>>>>> +       val = drvdata->traceid;
>>>>>> +       return sysfs_emit(buf, "0x%x\n", val);
>>>>>>     }
>>>>>>
>>>>>> -static int tpda_probe(struct amba_device *adev, const struct amba_id *id)
>>>>>> +static ssize_t traceid_store(struct device *dev,
>>>>>> +                                           struct device_attribute *attr,
>>>>>> +                                           const char *buf, size_t size)
>>>>>>     {
>>>>>>            int ret;
>>>>>> +       unsigned long val;
>>>>>> +       struct tpda_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>>>> +
>>>>>> +       ret = kstrtoul(buf, 16, &val);
>>>>>> +       if (ret)
>>>>>> +               return ret;
>>>>>> +
>>>>>> +       if (!IS_VALID_CS_TRACE_ID(val)) {
>>>>>> +               dev_err(drvdata->dev, "Invalid trace id\n");
>>>>>> +               return -EINVAL;
>>>>>> +       }
>>>>>> +
>>>>>> +       if (!drvdata->csdev->enable)
>>>>>> +               drvdata->traceid = val;
>>>>>> +       else
>>>>>> +               dev_err(drvdata->dev, "Device must be enabled! %s\n", __func__);
>>>>>> +
>>>>>> +       return size;
>>>>>> +}
>>>>>> +static DEVICE_ATTR_RW(traceid);
>>>>> This may override the mapping from the trace id API - there is no
>>>>> guarantee that the value here will be available.
>>>>> In general setting trace IDs via sysfs is prohibited.
>>>>>
>>>>> The CPU / ETM4 sysfs will allocate on traceid read, or enable, and
>>>>> then release the ID on sysfs reset on the device. This ensures that
>>>>> teh user can read a sysfs id value that will be retained over the
>>>>> trace session and viewable before or after the session is complete
>>>>>
>>>>>> +
>>>>>> +static struct attribute *coresight_tpda_attrs[] = {
>>>>>> +       &dev_attr_traceid.attr,
>>>>>> +       NULL,
>>>>>> +};
>>>>>> +
>>>>>> +static const struct attribute_group coresight_tpda_group = {
>>>>>> +       .attrs = coresight_tpda_attrs,
>>>>>> +};
>>>>>> +
>>>>>> +static const struct attribute_group *coresight_tpda_groups[] = {
>>>>>> +       &coresight_tpda_group,
>>>>>> +       NULL,
>>>>>> +};
>>>>>> +
>>>>>> +static void tpda_init_default_data(struct tpda_drvdata *drvdata)
>>>>>> +{
>>>>>> +       drvdata->traceid = 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int tpda_probe(struct amba_device *adev, const struct amba_id *id)
>>>>>> +{
>>>>>>            struct device *dev = &adev->dev;
>>>>>>            struct coresight_platform_data *pdata;
>>>>>>            struct tpda_drvdata *drvdata;
>>>>>> @@ -151,9 +220,7 @@ static int tpda_probe(struct amba_device *adev, const struct amba_id *id)
>>>>>>
>>>>>>            spin_lock_init(&drvdata->spinlock);
>>>>>>
>>>>>> -       ret = tpda_init_default_data(drvdata);
>>>>>> -       if (ret)
>>>>>> -               return ret;
>>>>>> +       tpda_init_default_data(drvdata);
>>>>>>
>>>>>>            desc.name = coresight_alloc_device_name(&tpda_devs, dev);
>>>>>>            if (!desc.name)
>>>>>> @@ -164,6 +231,7 @@ static int tpda_probe(struct amba_device *adev, const struct amba_id *id)
>>>>>>            desc.pdata = adev->dev.platform_data;
>>>>>>            desc.dev = &adev->dev;
>>>>>>            desc.access = CSDEV_ACCESS_IOMEM(base);
>>>>>> +       desc.groups = coresight_tpda_groups;
>>>>>>            drvdata->csdev = coresight_register(&desc);
>>>>>>            if (IS_ERR(drvdata->csdev))
>>>>>>                    return PTR_ERR(drvdata->csdev);
>>>>>> @@ -178,7 +246,6 @@ static void tpda_remove(struct amba_device *adev)
>>>>>>     {
>>>>>>            struct tpda_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>>>>>>
>>>>>> -       coresight_trace_id_put_system_id(drvdata->atid);
>>>>>>            coresight_unregister(drvdata->csdev);
>>>>>>     }
>>>>>>
>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
>>>>>> index 0399678df312..5de6dc92f450 100644
>>>>>> --- a/drivers/hwtracing/coresight/coresight-tpda.h
>>>>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
>>>>>> @@ -22,14 +22,14 @@
>>>>>>      * @dev:        The device entity associated to this component.
>>>>>>      * @csdev:      component vitals needed by the framework.
>>>>>>      * @spinlock:   lock for the drvdata value.
>>>>>> - * @enable:     enable status of the component.
>>>>>> + * @traceid:    the atid value of TPDA.
>>>>>>      */
>>>>>>     struct tpda_drvdata {
>>>>>>            void __iomem            *base;
>>>>>>            struct device           *dev;
>>>>>>            struct coresight_device *csdev;
>>>>>>            spinlock_t              spinlock;
>>>>>> -       u8                      atid;
>>>>>> +       u8                      traceid;
>>>>>>     };
>>>>>>
>>>>>>     #endif  /* _CORESIGHT_CORESIGHT_TPDA_H */
>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
>>>>>> index af5b4ef59cea..192626efcb01 100644
>>>>>> --- a/drivers/hwtracing/coresight/coresight-trace-id.c
>>>>>> +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
>>>>>> @@ -110,6 +110,19 @@ static int coresight_trace_id_alloc_new_id(struct coresight_trace_id_map *id_map
>>>>>>            return id;
>>>>>>     }
>>>>>>
>>>>>> +static int coresight_trace_id_set(int id, struct coresight_trace_id_map *id_map)
>>>>>> +{
>>>>>> +       if (WARN(!IS_VALID_CS_TRACE_ID(id), "Invalid Trace ID %d\n", id))
>>>>>> +               return -EINVAL;
>>>>>> +       if (WARN(test_bit(id, id_map->used_ids), "ID is already used: %d\n", id))
>>>>>> +               return -EINVAL;
>>>>>> +       set_bit(id, id_map->used_ids);
>>>>>> +
>>>>>> +       DUMP_ID_MAP(id_map);
>>>>>> +
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>>>     static void coresight_trace_id_free(int id, struct coresight_trace_id_map *id_map)
>>>>>>     {
>>>>>>            if (WARN(!IS_VALID_CS_TRACE_ID(id), "Invalid Trace ID %d\n", id))
>>>>>> @@ -195,6 +208,37 @@ static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_
>>>>>>            return id;
>>>>>>     }
>>>>>>
>>>>>> +static int coresight_trace_id_map_set_cpu_id(int cpu, int id, struct coresight_trace_id_map *id_map)
>>>>>> +{
>>>>>> +       unsigned long flags;
>>>>>> +
>>>>>> +       spin_lock_irqsave(&id_map_lock, flags);
>>>>>> +
>>>>>> +       if (WARN(!IS_VALID_CS_TRACE_ID(id), "Invalid Trace ID %d\n", id)) {
>>>>>> +               spin_unlock_irqrestore(&id_map_lock, flags);
>>>>>> +               return -EINVAL;
>>>>>> +       }
>>>>>> +
>>>>>> +       if (WARN(test_bit(id, id_map->used_ids), "ID is already used: %d\n", id)) {
>>>>>> +               spin_unlock_irqrestore(&id_map_lock, flags);
>>>>>> +               return -EINVAL;
>>>>>> +       }
>>>>>> +
>>>>>> +       set_bit(id, id_map->used_ids);
>>>>>> +
>>>>>> +       /* allocate the new id to the cpu */
>>>>>> +       atomic_set(&per_cpu(cpu_id, cpu), id);
>>>>>> +
>>>>>> +       cpumask_clear_cpu(cpu, &cpu_id_release_pending);
>>>>>> +       clear_bit(id, id_map->pend_rel_ids);
>>>>>> +
>>>>>> +       spin_unlock_irqrestore(&id_map_lock, flags);
>>>>>> +       DUMP_ID_CPU(cpu, id);
>>>>>> +       DUMP_ID_MAP(id_map);
>>>>>> +
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>> This is redundant and simply replicates the existing code. cpu mapped
>>>>> IDs are retained for the full trace session, across multiple
>>>>> enable/disable operations.
>>>>> For perf, the IDs will be retained for the entire perf trace session,
>>>>> during which the etm can be enabled and disabled multiple times.
>>>>> For sysfs, the ids will be allocated on enable and retained till the
>>>>> user writes to the sysfs reset function in the ETM4X.
>>>>>
>>>>>
>>>>>>     static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
>>>>>>     {
>>>>>>            unsigned long flags;
>>>>>> @@ -251,6 +295,12 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
>>>>>>
>>>>>>     /* API functions */
>>>>>>
>>>>>> +int coresight_trace_id_set_cpu_id(int cpu, int id)
>>>>>> +{
>>>>>> +       return coresight_trace_id_map_set_cpu_id(cpu, id, &id_map_default);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(coresight_trace_id_set_cpu_id);
>>>>>> +
>>>>> Redundant API, Ids are allocated and persistent as described above.
>>>>>
>>>>>>     int coresight_trace_id_get_cpu_id(int cpu)
>>>>>>     {
>>>>>>            return coresight_trace_id_map_get_cpu_id(cpu, &id_map_default);
>>>>>> @@ -269,6 +319,12 @@ int coresight_trace_id_read_cpu_id(int cpu)
>>>>>>     }
>>>>>>     EXPORT_SYMBOL_GPL(coresight_trace_id_read_cpu_id);
>>>>>>
>>>>>> +int coresight_trace_id_set_system_id(int id)
>>>>>> +{
>>>>>> +       return coresight_trace_id_set(id, &id_map_default);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(coresight_trace_id_set_system_id);
>>>>>> +
>>>>> This is unnecessary unless you have a device that has a specific trace
>>>>> id hardcoded into the device that cannot be changed.
>>>>>
>>>>> If there is such a case then we will have to implement a reservation
>>>>> mechanism that reserves an ID to that specific device. To prevent race
>>>>> conditions this would have to occur at device probe time and be
>>>>> retained throughout the lifetime of the device driver.
>>>>>
>>>>> If you need to retain system Ids across multiple enable / disable
>>>>> cycles for sysfs then follow the model in the ETM4x driver.
>>>>>
>>>>> Regards
>>>>>
>>>>> Mike
>>>>>
>>>>>
>>>>>>     int coresight_trace_id_get_system_id(void)
>>>>>>     {
>>>>>>            return coresight_trace_id_map_get_system_id(&id_map_default);
>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
>>>>>> index 3797777d367e..5dab9a473266 100644
>>>>>> --- a/drivers/hwtracing/coresight/coresight-trace-id.h
>>>>>> +++ b/drivers/hwtracing/coresight/coresight-trace-id.h
>>>>>> @@ -61,8 +61,21 @@ struct coresight_trace_id_map {
>>>>>>            DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
>>>>>>     };
>>>>>>
>>>>>> +
>>>>>>     /* Allocate and release IDs for a single default trace ID map */
>>>>>>
>>>>>> +/**
>>>>>> + * Set the CoreSight Trace Id for the CPU.
>>>>>> + *
>>>>>> + * Set CoreSight Trace Id associated with the CPU.
>>>>>> + *
>>>>>> + * @cpu: The CPU index for the id.
>>>>>> + * @id: Coresight Trace ID value.
>>>>>> + *
>>>>>> + * return: 0 if set successfully or -EINVAL if fail to set.
>>>>>> + */
>>>>>> +int coresight_trace_id_set_cpu_id(int cpu, int id);
>>>>>> +
>>>>>>     /**
>>>>>>      * Read and optionally allocate a CoreSight trace ID and associate with a CPU.
>>>>>>      *
>>>>>> @@ -111,6 +124,17 @@ void coresight_trace_id_put_cpu_id(int cpu);
>>>>>>      */
>>>>>>     int coresight_trace_id_read_cpu_id(int cpu);
>>>>>>
>>>>>> +/**
>>>>>> + * Set trace id for a system component.
>>>>>> + *
>>>>>> + * Set the trace id if system component needs a static id for the trace.
>>>>>> + *
>>>>>> + * @id: value of trace ID.
>>>>>> + *
>>>>>> + * return: 0 if set successfully or -EINVAL if fail to set.
>>>>>> + */
>>>>>> +int coresight_trace_id_set_system_id(int id);
>>>>>> +
>>>>>>     /**
>>>>>>      * Allocate a CoreSight trace ID for a system component.
>>>>>>      *
>>>>>> --
>>>>>> 2.39.0
>>>>>>
>>>
>
>
