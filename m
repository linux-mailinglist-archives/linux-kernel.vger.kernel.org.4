Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CD963528F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbiKWI2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbiKWI23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:28:29 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B74B14D3F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:28:00 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NHDl466V2zRpSk;
        Wed, 23 Nov 2022 16:27:28 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 16:27:58 +0800
CC:     <linux-kernel@vger.kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] hwtracing: HISI_PTT should depend on ARCH_HISI
To:     Geert Uytterhoeven <geert+renesas@glider.be>
References: <1a31a50f01e880f4c137298a12b8023c55f59cdc.1669044155.git.geert+renesas@glider.be>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <054c87b3-16b0-9075-1ce3-0829822d4625@huawei.com>
Date:   Wed, 23 Nov 2022 16:27:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1a31a50f01e880f4c137298a12b8023c55f59cdc.1669044155.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Hi Geert,

On 2022/11/21 23:23, Geert Uytterhoeven wrote:
> The HiSilicon PCIe Tune and Trace Device is a PCIe Root Complex
> integrated Endpoint (RCiEP) device, which is only present on HiSilicon
> SoCs.  Hence add a dependency on ARCH_HISI, to prevent asking the user
> about this driver when configuring a kernel without HiSilicon SoC
> support.
> 

I don't think we want this since:

1. Our PCIe IP is very common which does not highly depends on specific platforms, it can be used on other products
2. I'm not sure all the products will have ARCH_HISI. if we have this dependence then we cannot see this configuration

The driver config is default to N so I'd prefer to keep it as is.

Thanks.

> Fixes: ff0de066b4632ccb ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/hwtracing/ptt/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/ptt/Kconfig b/drivers/hwtracing/ptt/Kconfig
> index 6d46a09ffeb91992..96ee94a5d5b9fab8 100644
> --- a/drivers/hwtracing/ptt/Kconfig
> +++ b/drivers/hwtracing/ptt/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config HISI_PTT
>  	tristate "HiSilicon PCIe Tune and Trace Device"
> -	depends on ARM64 || (COMPILE_TEST && 64BIT)
> +	depends on ARCH_HISI || (COMPILE_TEST && 64BIT)
>  	depends on PCI && HAS_DMA && HAS_IOMEM && PERF_EVENTS
>  	help
>  	  HiSilicon PCIe Tune and Trace device exists as a PCIe RCiEP
> 
