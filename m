Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3AA5E7161
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiIWB2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 21:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiIWB2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:28:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E40A1176CD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 18:28:00 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYZDP1WbGzlXT3;
        Fri, 23 Sep 2022 09:23:49 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 09:27:58 +0800
CC:     <yangyicong@hisilicon.com>, <will@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Jonathan.Cameron@Huawei.com>, <rdunlap@infradead.org>,
        <robin.murphy@arm.com>, <mark.rutland@arm.com>,
        <baolin.wang@linux.alibaba.com>, <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v1 1/3] docs: perf: Add description for Synopsys
 DesignWare PCIe PMU driver
To:     Shuai Xue <xueshuai@linux.alibaba.com>
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
 <20220917121036.14864-2-xueshuai@linux.alibaba.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <6696990d-2555-16c0-e3f4-c9a497917d02@huawei.com>
Date:   Fri, 23 Sep 2022 09:27:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20220917121036.14864-2-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/17 20:10, Shuai Xue wrote:
> Alibaba's T-Head Yitan 710 SoC is built on Synopsys' widely deployed and
> silicon-proven DesignWare Core PCIe controller which implements PMU for
> performance and functional debugging to facilitate system maintenance.
> Document it to provide guidance on how to use it.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  .../admin-guide/perf/dwc_pcie_pmu.rst         | 61 +++++++++++++++++++
>  Documentation/admin-guide/perf/index.rst      |  1 +
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> 
> diff --git a/Documentation/admin-guide/perf/dwc_pcie_pmu.rst b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> new file mode 100644
> index 000000000000..fbcbf10b23b7
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
> @@ -0,0 +1,61 @@
> +======================================================================
> +Synopsys DesignWare Cores (DWC) PCIe Performance Monitoring Unit (PMU)
> +======================================================================
> +
> +DesignWare Cores (DWC) PCIe PMU
> +===============================
> +
> +To facilitate collection of statistics, Synopsys DesignWare Cores PCIe
> +controller provides the following two features:
> +
> +- Time Based Analysis (RX/TX data throughput and time spent in each
> +  low-power LTSSM state)
> +- Lane Event counters (Error and Non-Error for lanes)
> +
> +The PMU is not a PCIe Root Complex integrated End Point (RCiEP) device but
> +only register counters provided by each PCIe Root Port.
> +
> +Time Based Analysis
> +-------------------
> +
> +Using this feature you can obtain information regarding RX/TX data
> +throughput and time spent in each low-power LTSSM state by the controller.
> +
> +The counters are 64-bit width and measure data in two categories,
> +
> +- percentage of time does the controller stay in LTSSM state in a
> +  configurable duration. The measurement range of each Event in Group#0.
> +- amount of data processed (Units of 16 bytes). The measurement range of
> +  each Event in Group#1.
> +
> +Lane Event counters
> +-------------------
> +
> +Using this feature you can obtain Error and Non-Error information in
> +specific lane by the controller.
> +
> +The counters are 32-bit width and the measured event is select by:
> +
> +- Group i
> +- Event j within the Group i
> +- and Lank k

Typo here? I guess it's "Lane k"?

> +
> +Some of the event counters only exist for specific configurations.
> +
> +DesignWare Cores (DWC) PCIe PMU Driver
> +=======================================
> +
> +This driver add PMU devices for each PCIe Root Port. And the PMU device is
> +named based the BDF of Root Port. For example,
> +
> +    10:00.0 PCI bridge: Device 1ded:8000 (rev 01)
> +
> +the PMU device name for this Root Port is pcie_bdf_100000.
> +
> +Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
> +
> +    $# perf stat -a -e pcie_bdf_200/Rx_PCIe_TLP_Data_Payload/
> +
> +average RX bandwidth can be calculated like this:
> +
> +    PCIe TX Bandwidth = PCIE_TX_DATA * 16B / Measure_Time_Window
> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
> index 9c9ece88ce53..8e6a5472aeb3 100644
> --- a/Documentation/admin-guide/perf/index.rst
> +++ b/Documentation/admin-guide/perf/index.rst
> @@ -18,3 +18,4 @@ Performance monitor support
>     xgene-pmu
>     arm_dsu_pmu
>     thunderx2-pmu
> +   dwc_pcie_pmu
> 
