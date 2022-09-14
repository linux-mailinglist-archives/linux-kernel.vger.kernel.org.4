Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875C65B817C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 08:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiINGWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 02:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiINGV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 02:21:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EA971BC5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 23:21:54 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MS9994bzQzNmCD;
        Wed, 14 Sep 2022 14:17:17 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 14 Sep 2022 14:21:50 +0800
Received: from [10.174.185.210] (10.174.185.210) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 14:21:49 +0800
Subject: Re: [PATCH v2] clocksource/drivers/arm_arch_timer: Fix handling of
 ARM erratum 85821
To:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oliver Upton <oupton@google.com>
CC:     <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220914022122.1175-1-jiangkunkun@huawei.com>
From:   Kunkun Jiang <jiangkunkun@huawei.com>
Message-ID: <76f3e7ca-15c9-9b78-2520-f299b3e14cf8@huawei.com>
Date:   Wed, 14 Sep 2022 14:21:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220914022122.1175-1-jiangkunkun@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject is wrong. s/85821/858921
Please review v3.

Thanks,
Kunkun Jiang

On 2022/9/14 10:21, Kunkun Jiang wrote:
> The commit a38b71b0833e ("clocksource/drivers/arm_arch_timer:
> Move system register timer programming over to CVAL") moves the
> programming of the timers from the countdown timer (TVAL) over
> to the comparator (CVAL). This makes it necessary to read the
> counter when programming next event. However, the workaround of
> Cortex-A73 erratum 858921 does not set the corresponding
> set_next_event_phys and set_next_event_virt.
>
> Add the appropriate hooks to apply the erratum mitigation when
> programming the next timer event.
>
> Fixes: a38b71b0833e ("clocksource/drivers/arm_arch_timer: Move system register timer programming over to CVAL")
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> Acked-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/clocksource/arm_arch_timer.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 9ab8221ee3c6..ff935efb6a88 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -473,6 +473,8 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>   		.desc = "ARM erratum 858921",
>   		.read_cntpct_el0 = arm64_858921_read_cntpct_el0,
>   		.read_cntvct_el0 = arm64_858921_read_cntvct_el0,
> +		.set_next_event_phys = erratum_set_next_event_phys,
> +		.set_next_event_virt = erratum_set_next_event_virt,
>   	},
>   #endif
>   #ifdef CONFIG_SUN50I_ERRATUM_UNKNOWN1
