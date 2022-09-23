Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF1C5E7C50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiIWNvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiIWNvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:51:47 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A84128894
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 06:51:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VQXAnA7_1663941100;
Received: from 30.240.121.51(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VQXAnA7_1663941100)
          by smtp.aliyun-inc.com;
          Fri, 23 Sep 2022 21:51:41 +0800
Message-ID: <a01eae44-5daf-08bb-ea28-eeacd7006ab9@linux.alibaba.com>
Date:   Fri, 23 Sep 2022 21:51:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
From:   Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v1 1/3] docs: perf: Add description for Synopsys
 DesignWare PCIe PMU driver
To:     Will Deacon <will@kernel.org>
Cc:     Jonathan.Cameron@Huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        robin.murphy@arm.com, mark.rutland@arm.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
 <20220917121036.14864-2-xueshuai@linux.alibaba.com>
 <20220922132543.GA12095@willie-the-truck>
Content-Language: en-US
In-Reply-To: <20220922132543.GA12095@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/22 PM9:25, Will Deacon 写道:
> On Sat, Sep 17, 2022 at 08:10:34PM +0800, Shuai Xue wrote:
>> Alibaba's T-Head Yitan 710 SoC is built on Synopsys' widely deployed and
>> silicon-proven DesignWare Core PCIe controller which implements PMU for
>> performance and functional debugging to facilitate system maintenance.
>> Document it to provide guidance on how to use it.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>  .../admin-guide/perf/dwc_pcie_pmu.rst         | 61 +++++++++++++++++++
>>  Documentation/admin-guide/perf/index.rst      |  1 +
>>  2 files changed, 62 insertions(+)
>>  create mode 100644 Documentation/admin-guide/perf/dwc_pcie_pmu.rst
>>
>> diff --git a/Documentation/admin-guide/perf/dwc_pcie_pmu.rst b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
>> new file mode 100644
>> index 000000000000..fbcbf10b23b7
>> --- /dev/null
>> +++ b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
>> @@ -0,0 +1,61 @@
>> +======================================================================
>> +Synopsys DesignWare Cores (DWC) PCIe Performance Monitoring Unit (PMU)
>> +======================================================================
>> +
>> +DesignWare Cores (DWC) PCIe PMU
>> +===============================
>> +
>> +To facilitate collection of statistics, Synopsys DesignWare Cores PCIe
>> +controller provides the following two features:
>> +
>> +- Time Based Analysis (RX/TX data throughput and time spent in each
>> +  low-power LTSSM state)
>> +- Lane Event counters (Error and Non-Error for lanes)
>> +
>> +The PMU is not a PCIe Root Complex integrated End Point (RCiEP) device but
>> +only register counters provided by each PCIe Root Port.
>> +
>> +Time Based Analysis
>> +-------------------
>> +
>> +Using this feature you can obtain information regarding RX/TX data
>> +throughput and time spent in each low-power LTSSM state by the controller.
>> +
>> +The counters are 64-bit width and measure data in two categories,
>> +
>> +- percentage of time does the controller stay in LTSSM state in a
>> +  configurable duration. The measurement range of each Event in Group#0.
>> +- amount of data processed (Units of 16 bytes). The measurement range of
>> +  each Event in Group#1.
>> +
>> +Lane Event counters
>> +-------------------
>> +
>> +Using this feature you can obtain Error and Non-Error information in
>> +specific lane by the controller.
>> +
>> +The counters are 32-bit width and the measured event is select by:
>> +
>> +- Group i
>> +- Event j within the Group i
>> +- and Lank k
>> +
>> +Some of the event counters only exist for specific configurations.
>> +
>> +DesignWare Cores (DWC) PCIe PMU Driver
>> +=======================================
>> +
>> +This driver add PMU devices for each PCIe Root Port. And the PMU device is
>> +named based the BDF of Root Port. For example,
>> +
>> +    10:00.0 PCI bridge: Device 1ded:8000 (rev 01)
>> +
>> +the PMU device name for this Root Port is pcie_bdf_100000.
>> +
>> +Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
>> +
>> +    $# perf stat -a -e pcie_bdf_200/Rx_PCIe_TLP_Data_Payload/
> 
> Do you really need to expose a separate PMU instance to userspace for each
> BDF? I think it would be much cleaner if you could follow the approach used
> by hisilicon/hisi_pcie_pmu.c and hide these details in the driver, exposing
> a `bdf=' selector to userspace instead.

Thank you for your valuable comments.

It's a good idea to encode bdf in bitmap and exposing a `bdf=' selector to userspace.
The problem of bdf selector is that the user need to compute bdf from lanes, do you
think it is user friendly? I'm worried about increasing the burden of users.

Best Regards
Shuai


