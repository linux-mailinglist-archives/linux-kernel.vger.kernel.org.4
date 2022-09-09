Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CB55B2E9C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIIGRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIIGRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:17:15 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9B01177B6;
        Thu,  8 Sep 2022 23:17:14 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MP5Jx2PsTz14QXx;
        Fri,  9 Sep 2022 14:13:21 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 14:17:11 +0800
CC:     <yangyicong@hisilicon.com>, <gregkh@linuxfoundation.org>,
        <alexander.shishkin@linux.intel.com>, <leo.yan@linaro.org>,
        <james.clark@arm.com>, <will@kernel.org>, <robin.murphy@arm.com>,
        <acme@kernel.org>, <peterz@infradead.org>, <corbet@lwn.net>,
        <mark.rutland@arm.com>, <jonathan.cameron@huawei.com>,
        <john.garry@huawei.com>, <helgaas@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <suzuki.poulose@arm.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <iommu@lists.linux.dev>,
        <linux-doc@vger.kernel.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <bagasdotme@gmail.com>
Subject: Re: [PATCH v12 0/5] Add driver support for HiSilicon PCIe Tune and
 Trace device
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
References: <20220816114414.4092-1-yangyicong@huawei.com>
 <20220908230914.GA246683@p14s>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <05e54c98-a42f-6362-c6d3-0268e91bf3a0@huawei.com>
Date:   Fri, 9 Sep 2022 14:17:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220908230914.GA246683@p14s>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/9 7:09, Mathieu Poirier wrote:
> On Tue, Aug 16, 2022 at 07:44:09PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> HiSilicon PCIe tune and trace device (PTT) is a PCIe Root Complex integrated
>> Endpoint (RCiEP) device, providing the capability to dynamically monitor and
>> tune the PCIe traffic (tune), and trace the TLP headers (trace).
>>
>> PTT tune is designed for monitoring and adjusting PCIe link parameters. We provide
>> several parameters of the PCIe link. Through the driver, user can adjust the value
>> of certain parameter to affect the PCIe link for the purpose of enhancing the
>> performance in certian situation.
>>
>> PTT trace is designed for dumping the TLP headers to the memory, which can be
>> used to analyze the transactions and usage condition of the PCIe Link. Users
>> can choose filters to trace headers, by either requester ID, or those downstream
>> of a set of Root Ports on the same core of the PTT device. It's also supported
>> to trace the headers of certain type and of certain direction.
>>
>> The driver registers a PMU device for each PTT device. The trace can be used
>> through `perf record` and the traced headers can be decoded by `perf report`.
>> The tune can be used through the sysfs attributes of related PMU device. See
>> the documentation for the detailed usage.
>>
>> This patchset adds an initial driver support for the PTT device. The userspace
>> perf tool support will be sent in a separate patchset.
>>
>> Change since v11:
>> - Drop WARN_ON() for irq_set_affinity() failure per Greg
>> - Split out userspace perf support patches according to the comments
>> Link: https://lore.kernel.org/lkml/20220721130116.43366-1-yangyicong@huawei.com/
>>
>> Change since v10:
>> - Use title case in the documentation
>> - Add RB from Bagas, thanks.
>> Link: https://lore.kernel.org/lkml/20220714092710.53486-1-yangyicong@hisilicon.com/
>>
>> Change since v9:
>> - Add sysfs ABI description documentation
>> - Remove the controversial available_{root_port, requester}_filters sysfs file
>> - Shorten 2 tune sysfs attributes name and add some comments
>> - Move hisi_ptt_process_auxtrace_info() to Patch 6.
>> - Add RB from Leo and Ack-by from Mathieu, thanks!
>> Link: https://lore.kernel.org/lkml/20220606115555.41103-1-yangyicong@hisilicon.com/
>>
>> Change since v8:
>> - Cleanups and one minor fix from Jonathan and John, thanks
>> Link: https://lore.kernel.org/lkml/20220516125223.32012-1-yangyicong@hisilicon.com/
>>
>> Change since v7:
>> - Configure the DMA in probe rather than in runtime. Also use devres to manage
>>   PMU device as we have no order problem now
>> - Refactor the config validation function per John and Leo
>> - Use a spinlock hisi_ptt::pmu_lock instead of mutex to serialize the perf process
>>   in pmu::start as it's in atomic context
>> - Only commit the traced data when stop, per Leo and James
>> - Drop the filter dynamically updating patch from this series to simply the review
>>   of the driver. That patch will be send separately.
>> - add a cpumask sysfs attribute and handle the cpu hotplug events, follow the
>>   uncore PMU convention
>> - Other cleanups and fixes, both in driver and perf tool
>> Link: https://lore.kernel.org/lkml/20220407125841.3678-1-yangyicong@hisilicon.com/
>>
>> Change since v6:
>> - Fix W=1 errors reported by lkp test, thanks
>>
>> Change since v5:
>> - Squash the PMU patch into PATCH 2 suggested by John
>> - refine the commit message of PATCH 1 and some comments
>> Link: https://lore.kernel.org/lkml/20220308084930.5142-1-yangyicong@hisilicon.com/
>>
>> Change since v4:
>> Address the comments from Jonathan, John and Ma Ca, thanks.
>> - Use devm* also for allocating the DMA buffers
>> - Remove the IRQ handler stub in Patch 2
>> - Make functions waiting for hardware state return boolean
>> - Manual remove the PMU device as it should be removed first
>> - Modifier the orders in probe and removal to make them matched well
>> - Make available {directions,type,format} array const and non-global
>> - Using the right filter list in filters show and well protect the
>>   list with mutex
>> - Record the trace status with a boolean @started rather than enum
>> - Optimize the process of finding the PTT devices of the perf-tool
>> Link: https://lore.kernel.org/linux-pci/20220221084307.33712-1-yangyicong@hisilicon.com/
>>
>> Change since v3:
>> Address the comments from Jonathan and John, thanks.
>> - drop members in the common struct which can be get on the fly
>> - reduce buffer struct and organize the buffers with array instead of list
>> - reduce the DMA reset wait time to avoid long time busy loop
>> - split the available_filters sysfs attribute into two files, for root port
>>   and requester respectively. Update the documentation accordingly
>> - make IOMMU mapping check earlier in probe to avoid race condition. Also
>>   make IOMMU quirk patch prior to driver in the series
>> - Cleanups and typos fixes from John and Jonathan
>> Link: https://lore.kernel.org/linux-pci/20220124131118.17887-1-yangyicong@hisilicon.com/
>>
>> Change since v2:
>> - address the comments from Mathieu, thanks.
>>   - rename the directory to ptt to match the function of the device
>>   - spinoff the declarations to a separate header
>>   - split the trace function to several patches
>>   - some other comments.
>> - make default smmu domain type of PTT device to identity
>>   Drop the RMR as it's not recommended and use an iommu_def_domain_type
>>   quirk to passthrough the device DMA as suggested by Robin. 
>> Link: https://lore.kernel.org/linux-pci/20211116090625.53702-1-yangyicong@hisilicon.com/
>>
>> Change since v1:
>> - switch the user interface of trace to perf from debugfs
>> - switch the user interface of tune to sysfs from debugfs
>> - add perf tool support to start trace and decode the trace data
>> - address the comments of documentation from Bjorn
>> - add RMR[1] support of the device as trace works in RMR mode or
>>   direct DMA mode. RMR support is achieved by common APIs rather
>>   than the APIs implemented in [1].
>> Link: https://lore.kernel.org/lkml/1618654631-42454-1-git-send-email-yangyicong@hisilicon.com/
>> [1] https://lore.kernel.org/linux-acpi/20210805080724.480-1-shameerali.kolothum.thodi@huawei.com/
>>
>> Yicong Yang (5):
>>   iommu/arm-smmu-v3: Make default domain type of HiSilicon PTT device to
>>     identity
>>   hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe
>>     Tune and Trace device
>>   hwtracing: hisi_ptt: Add tune function support for HiSilicon PCIe Tune
>>     and Trace device
>>   docs: trace: Add HiSilicon PTT device driver documentation
>>   MAINTAINERS: Add maintainer for HiSilicon PTT driver
>>
>>  .../ABI/testing/sysfs-devices-hisi_ptt        |   61 +
>>  Documentation/trace/hisi-ptt.rst              |  298 +++++
>>  Documentation/trace/index.rst                 |    1 +
>>  MAINTAINERS                                   |    8 +
>>  drivers/Makefile                              |    1 +
>>  drivers/hwtracing/Kconfig                     |    2 +
>>  drivers/hwtracing/ptt/Kconfig                 |   12 +
>>  drivers/hwtracing/ptt/Makefile                |    2 +
>>  drivers/hwtracing/ptt/hisi_ptt.c              | 1047 +++++++++++++++++
>>  drivers/hwtracing/ptt/hisi_ptt.h              |  200 ++++
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   21 +
> 
> I fixed the month and kernel revision in sysfs-devices-hisi_ptt before applying
> this set.  You can double check that everything is to your liking in the
> coresight next tree[1].
> 

Thanks a lot for the fixes, I thought to use the month when posting the patches and sorry for
calculating a wrong release version. I've pulled and checked again and everything is fine.

Thanks you again and everybody helped reveiw this series!

Regards,
Yicong.

> Thanks,
> Mathieu
> 
> [1]. https://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git/log/?h=next
> 
> 
>>  11 files changed, 1653 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-devices-hisi_ptt
>>  create mode 100644 Documentation/trace/hisi-ptt.rst
>>  create mode 100644 drivers/hwtracing/ptt/Kconfig
>>  create mode 100644 drivers/hwtracing/ptt/Makefile
>>  create mode 100644 drivers/hwtracing/ptt/hisi_ptt.c
>>  create mode 100644 drivers/hwtracing/ptt/hisi_ptt.h
>>
>> -- 
>> 2.24.0
>>
> .
> 
