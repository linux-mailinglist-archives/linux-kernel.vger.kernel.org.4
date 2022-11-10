Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5AE623D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiKJIet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiKJIeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:34:46 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8788024945;
        Thu, 10 Nov 2022 00:34:43 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7FWB6Z83zRpB4;
        Thu, 10 Nov 2022 16:34:30 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 16:34:41 +0800
CC:     <yangyicong@hisilicon.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        <liuqi6124@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Garry <john.garry@huawei.com>,
        <jonathan.cameron@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
        <f.fangjian@huawei.com>, <prime.zeng@huawei.com>
Subject: Re: [PATCH 3/3] drivers/perf: hisi: Add TLP filter support
To:     Bagas Sanjaya <bagasdotme@gmail.com>
References: <20221025113242.58271-1-yangyicong@huawei.com>
 <20221025113242.58271-4-yangyicong@huawei.com> <Y2x7Bfb12nwcCfL0@debian.me>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <0544f3df-bbf3-2673-873a-fdb70ab90691@huawei.com>
Date:   Thu, 10 Nov 2022 16:34:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <Y2x7Bfb12nwcCfL0@debian.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/10 12:16, Bagas Sanjaya wrote:
> On Tue, Oct 25, 2022 at 07:32:42PM +0800, Yicong Yang wrote:
>> +4. TLP Length filter
>> +When counting bandwidth, the data can be composed of certain parts of TLP
>> +packets. You can specify it through "len_mode":
>> +
>> +- 2'b00: Reserved (Do not use this since the behaviour is undefined)
>> +- 2'b01: Bandwidth of TLP payloads
>> +- 2'b10: Bandwidth of TLP headers
>> +- 2'b11: Bandwidth of both TLP payloads and headers
>> +
>> +For example, "len_mode=2" means only counting the bandwidth of TLP headers
>> +and "len_mode=3" means the final bandwidth data is composed of both TLP
>> +headers and payloads. You need to carefully using this to avoid losing
>> +data. For example you're likely to get no counts by "len_mode=1" if the TLPs
>> +on the traffic has no payload. This config is optional, by default it'll
>> +be 2'b11.
>> +
>> +Example usage of perf::
>> +
>> +  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,len_mode=0x1/ sleep 5
> 
> The indentation is rather ugly, so I have applied the fixup:
> 

will apply the fix and include your patch in v2.

Thanks.

> ---- >8 ----
> 
> diff --git a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
> index 83a2ef11b1a08d..bae690dddbebfd 100644
> --- a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
> +++ b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
> @@ -106,21 +106,22 @@ Example usage of perf::
>    $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,thr_len=0x4,thr_mode=1/ sleep 5
>  
>  4. TLP Length filter
> -When counting bandwidth, the data can be composed of certain parts of TLP
> -packets. You can specify it through "len_mode":
>  
> -- 2'b00: Reserved (Do not use this since the behaviour is undefined)
> -- 2'b01: Bandwidth of TLP payloads
> -- 2'b10: Bandwidth of TLP headers
> -- 2'b11: Bandwidth of both TLP payloads and headers
> +   When counting bandwidth, the data can be composed of certain parts of TLP
> +   packets. You can specify it through "len_mode":
>  
> -For example, "len_mode=2" means only counting the bandwidth of TLP headers
> -and "len_mode=3" means the final bandwidth data is composed of both TLP
> -headers and payloads. You need to carefully using this to avoid losing
> -data. For example you're likely to get no counts by "len_mode=1" if the TLPs
> -on the traffic has no payload. This config is optional, by default it'll
> -be 2'b11.
> +   - 2'b00: Reserved (Do not use this since the behaviour is undefined)
> +   - 2'b01: Bandwidth of TLP payloads
> +   - 2'b10: Bandwidth of TLP headers
> +   - 2'b11: Bandwidth of both TLP payloads and headers
>  
> -Example usage of perf::
> +   For example, "len_mode=2" means only counting the bandwidth of TLP headers
> +   and "len_mode=3" means the final bandwidth data is composed of both TLP
> +   headers and payloads. You need to carefully using this to avoid losing
> +   data. For example you're likely to get no counts by "len_mode=1" if the TLPs
> +   on the traffic has no payload. This config is optional, by default it'll
> +   be 2'b11.
>  
> -  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,len_mode=0x1/ sleep 5
> +   Example usage of perf::
> +
> +     $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,len_mode=0x1/ sleep 5
> 
> Also, for formatting consistency, you need to pick up the fix for rest of
> documentation (as separate patch in your series):
> 
> ---- >8 ----
> 
> From 5f286aceb959a7c70a56cb5c453d3ac0b844fb49 Mon Sep 17 00:00:00 2001
> From: Bagas Sanjaya <bagasdotme@gmail.com>
> Date: Thu, 10 Nov 2022 11:03:08 +0700
> Subject: [PATCH] Documentation: perf: Indent filter options list
> 
> The "Filter options" list have a rather ugly indentation. Also, the first
> paragraph after list name is rendered without separator (as continuation
> from the name).
> 
> Align the list by indenting the list items and add a blank line
> separator for each list name.
> 
> Fixes: c8602008e247f5 ("docs: perf: Add description for HiSilicon PCIe PMU driver")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  .../admin-guide/perf/hisi-pcie-pmu.rst        | 80 ++++++++++---------
>  1 file changed, 43 insertions(+), 37 deletions(-)
> 
> diff --git a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
> index bae690dddbebfd..54fab870a2aefb 100644
> --- a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
> +++ b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
> @@ -48,62 +48,68 @@ Filter options
>  --------------
>  
>  1. Target filter
> -PMU could only monitor the performance of traffic downstream target Root Ports
> -or downstream target Endpoint. PCIe PMU driver support "port" and "bdf"
> -interfaces for users, and these two interfaces aren't supported at the same
> -time.
>  
> --port
> -"port" filter can be used in all PCIe PMU events, target Root Port can be
> -selected by configuring the 16-bits-bitmap "port". Multi ports can be selected
> -for AP-layer-events, and only one port can be selected for TL/DL-layer-events.
> +   PMU could only monitor the performance of traffic downstream target Root
> +   Ports or downstream target Endpoint. PCIe PMU driver support "port" and
> +   "bdf" interfaces for users, and these two interfaces aren't supported at the
> +   same time.
>  
> -For example, if target Root Port is 0000:00:00.0 (x8 lanes), bit0 of bitmap
> -should be set, port=0x1; if target Root Port is 0000:00:04.0 (x4 lanes),
> -bit8 is set, port=0x100; if these two Root Ports are both monitored, port=0x101.
> +   - port
>  
> -Example usage of perf::
> +     "port" filter can be used in all PCIe PMU events, target Root Port can be
> +     selected by configuring the 16-bits-bitmap "port". Multi ports can be
> +     selected for AP-layer-events, and only one port can be selected for
> +     TL/DL-layer-events.
>  
> -  $# perf stat -e hisi_pcie0_core0/rx_mwr_latency,port=0x1/ sleep 5
> +     For example, if target Root Port is 0000:00:00.0 (x8 lanes), bit0 of
> +     bitmap should be set, port=0x1; if target Root Port is 0000:00:04.0 (x4
> +     lanes), bit8 is set, port=0x100; if these two Root Ports are both
> +     monitored, port=0x101.
>  
> --bdf
> +     Example usage of perf::
>  
> -"bdf" filter can only be used in bandwidth events, target Endpoint is selected
> -by configuring BDF to "bdf". Counter only counts the bandwidth of message
> -requested by target Endpoint.
> +       $# perf stat -e hisi_pcie0_core0/rx_mwr_latency,port=0x1/ sleep 5
>  
> -For example, "bdf=0x3900" means BDF of target Endpoint is 0000:39:00.0.
> +   - bdf
>  
> -Example usage of perf::
> +     "bdf" filter can only be used in bandwidth events, target Endpoint is
> +     selected by configuring BDF to "bdf". Counter only counts the bandwidth of
> +     message requested by target Endpoint.
>  
> -  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,bdf=0x3900/ sleep 5
> +     For example, "bdf=0x3900" means BDF of target Endpoint is 0000:39:00.0.
> +
> +     Example usage of perf::
> +
> +       $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,bdf=0x3900/ sleep 5
>  
>  2. Trigger filter
> -Event statistics start when the first time TLP length is greater/smaller
> -than trigger condition. You can set the trigger condition by writing "trig_len",
> -and set the trigger mode by writing "trig_mode". This filter can only be used
> -in bandwidth events.
>  
> -For example, "trig_len=4" means trigger condition is 2^4 DW, "trig_mode=0"
> -means statistics start when TLP length > trigger condition, "trig_mode=1"
> -means start when TLP length < condition.
> +   Event statistics start when the first time TLP length is greater/smaller
> +   than trigger condition. You can set the trigger condition by writing
> +   "trig_len", and set the trigger mode by writing "trig_mode". This filter can
> +   only be used in bandwidth events.
>  
> -Example usage of perf::
> +   For example, "trig_len=4" means trigger condition is 2^4 DW, "trig_mode=0"
> +   means statistics start when TLP length > trigger condition, "trig_mode=1"
> +   means start when TLP length < condition.
>  
> -  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,trig_len=0x4,trig_mode=1/ sleep 5
> +   Example usage of perf::
> +
> +     $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,trig_len=0x4,trig_mode=1/ sleep 5
>  
>  3. Threshold filter
> -Counter counts when TLP length within the specified range. You can set the
> -threshold by writing "thr_len", and set the threshold mode by writing
> -"thr_mode". This filter can only be used in bandwidth events.
>  
> -For example, "thr_len=4" means threshold is 2^4 DW, "thr_mode=0" means
> -counter counts when TLP length >= threshold, and "thr_mode=1" means counts
> -when TLP length < threshold.
> +   Counter counts when TLP length within the specified range. You can set the
> +   threshold by writing "thr_len", and set the threshold mode by writing
> +   "thr_mode". This filter can only be used in bandwidth events.
>  
> -Example usage of perf::
> +   For example, "thr_len=4" means threshold is 2^4 DW, "thr_mode=0" means
> +   counter counts when TLP length >= threshold, and "thr_mode=1" means counts
> +   when TLP length < threshold.
>  
> -  $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,thr_len=0x4,thr_mode=1/ sleep 5
> +   Example usage of perf::
> +
> +     $# perf stat -e hisi_pcie0_core0/rx_mrd_flux,thr_len=0x4,thr_mode=1/ sleep 5
>  
>  4. TLP Length filter
>  
> 
