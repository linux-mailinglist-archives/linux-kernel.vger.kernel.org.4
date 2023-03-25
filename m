Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0104D6C8D16
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 11:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjCYKWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 06:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCYKWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 06:22:04 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071E486AA;
        Sat, 25 Mar 2023 03:22:01 -0700 (PDT)
Received: from dggpeml500019.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PkFVQ576QzKncx;
        Sat, 25 Mar 2023 18:21:34 +0800 (CST)
Received: from [10.67.101.98] (10.67.101.98) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Sat, 25 Mar
 2023 18:21:59 +0800
Message-ID: <cf1f8c1f-90cb-9319-91e0-a8f4339547e6@hisilicon.com>
Date:   Sat, 25 Mar 2023 18:21:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [RFC PATCH v1 2/4] drivers/perf: hisi: Add driver support for
 HiSilicon PMCU
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <john.g.garry@oracle.com>, <james.clark@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <corbet@lwn.net>, <zhangshaokun@hisilicon.com>,
        <shenyang39@huawei.com>, <hejunhao3@huawei.com>,
        <yangyicong@hisilicon.com>, <prime.zeng@huawei.com>,
        <suntao25@huawei.com>, <jiazhao4@hisilicon.com>,
        <linuxarm@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
References: <20230206065146.645505-1-zhanjie9@hisilicon.com>
 <20230206065146.645505-3-zhanjie9@hisilicon.com>
 <20230317145232.00001c38@Huawei.com>
From:   Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20230317145232.00001c38@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.98]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/03/2023 22:52, Jonathan Cameron wrote:
> On Mon, 6 Feb 2023 14:51:44 +0800
> Jie Zhan <zhanjie9@hisilicon.com> wrote:
>
>> HiSilicon Performance Monitor Control Unit (PMCU) is a device that offloads
>> PMU accesses from CPUs, handling the configuration, event switching, and
>> counter reading of core PMUs on Kunpeng SoC. It facilitates fine-grained
>> and multi-PMU-event CPU profiling, in which scenario the current 'perf'
>> scheme may lose events or drop sampling frequency. With PMCU, users can
>> reliably obtain the data of up to 240 PMU events with the sample interval
>> of events down to 1ms, while the software overhead of accessing PMUs, as
>> well as its impact on target workloads, is reduced.
>>
>> This driver enables the usage of PMCU through the perf_event framework.
>> PMCU is registered as a PMU device and utilises the AUX buffer to dump data
>> directly. Users can start PMCU sampling through 'perf-record'. Event
>> numbers are passed by a sysfs interface.
>>
>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> Hi Jie,
>
> A few minor comments inline.
> Whilst I looked at this internally, that was a while back so I've
> found a few new things to point out in what I think is a pretty good/clean driver.
> The main thing here is the RFC questions you've raised in the cover letter
> of course - particularly the one around mediating who has the counters between
> this and the normal PMU driver.
>
> Thanks,
>
> Jonathan
Hi Jonathan,

Many thanks for the review again.

Happy to accept all the comments. I have updated the driver based on them.

One reply below.

Jie


...
>> +static const struct attribute_group hisi_pmcu_format_attr_group = {
>> +	.name = "format",
>> +	.attrs = hisi_pmcu_format_attrs,
>> +};
>> +
>> +static ssize_t monitored_cpus_show(struct device *dev,
>> +				   struct device_attribute *attr, char *buf)
>> +{
>> +	struct hisi_pmcu *hisi_pmcu = to_hisi_pmcu(dev_get_drvdata(dev));
>> +
>> +	return sysfs_emit(buf, "%d-%d\n",
>> +			  cpumask_first(&hisi_pmcu->cpus),
>> +			  cpumask_last(&hisi_pmcu->cpus));
> What does this do about offline CPUs?
> Should it include them or not?
PMCU takes care of offline CPUs as well, and the event counts from 
offline CPUs
should show as zeroes in the output.

hisi_pmcu->cpus contains only the online CPUs monitored by the PMCU,
so something should be improved with the "monitored_cpus" interface here.

"monitored_cpus" should actually show alll the online/offline CPUs 
monitored,
or, if it is meant to show only online CPUs, it show be a comma 
separated list
representing the hisi_pmcu->cpus mask rather than a range that may ignore
some offline CPUs in the middle.

Will fix this in V2.

