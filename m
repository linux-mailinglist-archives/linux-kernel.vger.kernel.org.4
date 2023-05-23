Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2227170D1E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbjEWC6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjEWC6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:58:04 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347B1CD;
        Mon, 22 May 2023 19:58:02 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VjIGoE4_1684810676;
Received: from 30.240.113.228(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VjIGoE4_1684810676)
          by smtp.aliyun-inc.com;
          Tue, 23 May 2023 10:57:58 +0800
Message-ID: <bb8f6053-fee9-0cd7-06c2-7d3033963f47@linux.alibaba.com>
Date:   Tue, 23 May 2023 10:57:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v5 0/4] drivers/perf: add Synopsys DesignWare PCIe PMU
 driver support
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        baolin.wang@linux.alibaba.com, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
 <20230522035428.69441-1-xueshuai@linux.alibaba.com>
 <20230522152859.0000429e@Huawei.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230522152859.0000429e@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/22 22:28, Jonathan Cameron wrote:
> On Mon, 22 May 2023 11:54:24 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
> Hi,
> 
> Very rarely a good idea to send a new patch set version in reply to an old
> one. Tends to just resort in it being way off the top of people's most recent
> email (depending on client of course!)

Got your point. I will avoid using In-Reply-To explicitly.

> 
> Jonathan

Thank you.

Best Regards,
Shuai

> 
>> changes since v4:
>>
>> 1. addressing commens from Bjorn Helgaas:
>> - reorder the includes by alpha
>> - change all macros with upper-case hex
>> - change ras_des type into u16
>> - remove unnecessary outer "()"
>> - minor format changes
>>
>> 2. Address commensts from Jonathan Cameron:
>> - rewrite doc and add a example to show how to use lane event
>>
>> 3. fix compile error reported by: kernel test robot
>> - remove COMPILE_TEST and add depend on PCI in kconfig
>> - add Reported-by: kernel test robot <lkp@intel.com>
>>
>> Changes since v3:
>>
>> 1. addressing comments from Robin Murphy:
>> - add a prepare patch to define pci id in linux/pci_ids.h
>> - remove unnecessary 64BIT dependency
>> - fix DWC_PCIE_PER_EVENT_OFF/ON macro
>> - remove dwc_pcie_pmu struct and move all its fileds into dwc_pcie_rp_info
>> - remove unnecessary format field show
>> - use sysfs_emit() instead of all the assorted sprintf() and snprintf() calls.
>> - remove unnecessary spaces and remove unnecessary cast to follow event show convention
>> - remove pcie_pmu_event_attr_is_visible
>> - fix a refcout leak on error branch when walk pci device in for_each_pci_dev
>> - remove bdf field from dwc_pcie_rp_info and calculate it at runtime
>> - finish all the checks before allocating rp_info to avoid hanging wasted memory
>> - remove some unused fields
>> - warp out control register configuration from sub function to .add()
>> - make function return type with a proper signature
>> - fix lane event count enable by clear DWC_PCIE_CNT_ENABLE field first
>> - pass rp_info directly to the read_*_counter helpers and in start, stop and add callbacks
>> - move event type validtion into .event_init()
>> - use is_sampling_event() to be consistent with everything else of pmu drivers
>> - remove unnecessary dev_err message in .event_init()
>> - return EINVAL instead EOPNOTSUPP for not a valid event 
>> - finish all the checks before start modifying the event
>> - fix sibling event check by comparing event->pmu with sibling->pmu
>> - probe PMU for each rootport independently
>> - use .update() as .read() directly
>> - remove dynamically generating symbolic name of lane event
>> - redefine static symbolic name of lane event and leave lane filed to user
>> - add CPU hotplug support
>>
>> 2. addressing comments from Baolin:
>> - add a mask to avoid possible overflow
>>
>> Changes since v2 addressing comments from Baolin:
>> - remove redundant macro definitions
>> - use dev_err to print error message
>> - change pmu_is_register to boolean
>> - use PLATFORM_DEVID_NONE macro
>> - fix module author format
>>
>> Changes since v1:
>>
>> 1. address comments from Jonathan:
>> - drop marco for PMU name and VSEC version
>> - simplify code with PCI standard marco
>> - simplify code with FIELD_PREP()/FIELD_GET() to replace shift marco
>> - name register filed with single _ instead double
>> - wrap dwc_pcie_pmu_{write}_dword out and drop meaningless snaity check 
>> - check vendor id while matching vesc with pci_find_vsec_capability()
>> - remove RP_NUM_MAX and use a list to organize PMU devices for rootports
>> - replace DWC_PCIE_CREATE_BDF with standard PCI_DEVID
>> - comments on riping register together
>>
>> 2. address comments from Bjorn:
>> - rename DWC_PCIE_VSEC_ID to DWC_PCIE_VSEC_RAS_DES_ID
>> - rename cap_pos to ras_des
>> - simplify declare of device_attribute with DEVICE_ATTR_RO
>> - simplify code with PCI standard macro and API like pcie_get_width_cap()
>> - fix some code style problem and typo
>> - drop meaningless snaity check of container_of
>>
>> 3. address comments from Yicong:
>> - use sysfs_emit() to replace sprintf()
>> - simplify iteration of pci device with for_each_pci_dev
>> - pick preferred CPUs on a near die and add comments
>> - unregister PMU drivers only for failed ones
>> - log on behalf PMU device and give more hint
>> - fix some code style problem
>>
>> (Thanks for all comments and they are very valuable to me)
>>
>> This patchset adds the PCIe Performance Monitoring Unit (PMU) driver support
>> for T-Head Yitian 710 SoC chip. Yitian 710 is based on the Synopsys PCI Express
>> Core controller IP which provides statistics feature.
>>
>> Shuai Xue (4):
>>   docs: perf: Add description for Synopsys DesignWare PCIe PMU driver
>>   PCI: move Alibaba Vendor ID linux/pci_ids.h
>>   drivers/perf: add DesignWare PCIe PMU driver
>>   MAINTAINERS: add maintainers for DesignWare PCIe PMU driver
>>
>>  .../admin-guide/perf/dwc_pcie_pmu.rst         |  97 +++
>>  Documentation/admin-guide/perf/index.rst      |   1 +
>>  MAINTAINERS                                   |   6 +
>>  drivers/infiniband/hw/erdma/erdma_hw.h        |   2 -
>>  drivers/perf/Kconfig                          |   7 +
>>  drivers/perf/Makefile                         |   1 +
>>  drivers/perf/dwc_pcie_pmu.c                   | 701 ++++++++++++++++++
>>  include/linux/pci_ids.h                       |   2 +
>>  8 files changed, 815 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/admin-guide/perf/dwc_pcie_pmu.rst
>>  create mode 100644 drivers/perf/dwc_pcie_pmu.c
>>
