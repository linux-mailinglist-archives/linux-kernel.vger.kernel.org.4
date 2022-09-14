Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576D45B7EEA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 04:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiINCYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 22:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiINCYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 22:24:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E466CF47
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 19:24:08 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MS3tq02w7zNmCN;
        Wed, 14 Sep 2022 10:19:31 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 14 Sep 2022 10:24:06 +0800
Received: from [10.174.185.210] (10.174.185.210) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 10:24:05 +0800
Subject: Re: [PATCH] arm64: arch_timer: Fix the lack of set_next_event* for
 workaround of Cortex-A73 erratum 858921
To:     Oliver Upton <oliver.upton@linux.dev>
CC:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220913104723.332-1-jiangkunkun@huawei.com>
 <YyBo0SPalTLsqYbS@google.com>
From:   Kunkun Jiang <jiangkunkun@huawei.com>
Message-ID: <a5a93e18-b553-3941-203e-b1fb9694b733@huawei.com>
Date:   Wed, 14 Sep 2022 10:24:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YyBo0SPalTLsqYbS@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Hi Oliver,

Thank you for your suggestion. I've modified it in v2.

Thanks,
Kunkun Jiang

On 2022/9/13 19:26, Oliver Upton wrote:
> On Tue, Sep 13, 2022 at 06:47:23PM +0800, Kunkun Jiang wrote:
>> The patch a38b71b0833e moves the programming of the timers from
> Please check your patch with scripts/checkpatch.pl next time.
> Use this pattern when referring to a commit in the changelog:
>
> commit a38b71b0833e ("clocksource/drivers/arm_arch_timer: Move
> system register timer programming over to CVAL") moved the
> programming...
>
>> the countdown timer (TVAL) over to the comparator (CVAL). This
>> makes it necessary to read the counter when setting next event.
>> However, the workaround of Cortex-A73 erratum 858921 does not
>> set the corresponding set_next_event_phys and set_next_event_virt.
>> This patch fixes it.
> Avoid referring to 'this patch', and just state imperatively what the
> change does, perhaps:
>
> Add the appropriate hooks to apply the erratum mitigation when
> programming the next timer event.
>
> Thanks for catching this!
>
> --
> Best,
> Oliver
> .
