Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5827F5B6BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiIMKwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiIMKwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:52:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7572A33E1C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:52:13 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MRgDG5kP3zkWvj;
        Tue, 13 Sep 2022 18:48:14 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 18:52:11 +0800
Received: from [10.174.185.210] (10.174.185.210) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 18:52:10 +0800
Subject: Re: A question about Cortex-A73 erratum 858921
To:     Marc Zyngier <maz@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <cce62c36-c2f4-7e0e-ad6d-6eae98f45aee@huawei.com>
 <87czc4rb1x.wl-maz@kernel.org>
From:   Kunkun Jiang <jiangkunkun@huawei.com>
Message-ID: <7f9bc4fb-67f5-5989-21ba-0833bd3cdd78@huawei.com>
Date:   Tue, 13 Sep 2022 18:52:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87czc4rb1x.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Hi Marc,

Thank you for your reply, I've sent a fix.
https://lore.kernel.org/all/20220913104723.332-1-jiangkunkun@huawei.com/

Thanks,
Kunkun Jiang

On 2022/9/9 20:23, Marc Zyngier wrote:
> On Fri, 09 Sep 2022 08:31:43 +0100,
> Kunkun Jiang <jiangkunkun@huawei.com> wrote:
>> Hi all,
>>
>> Recently I am learning the code related to Arm arch timer. I found that the
>> Cortex-A73 erratum 858921 does not set the corresponding callback functions:
>> set_next_event_phys and set_next_event_virt like other erratums. Won't it
>> get the wrong value when reading the counter during setting next event?
> Yup, you're correct.
>
> This is a regression introduced by a38b71b0833e
> ("clocksource/drivers/arm_arch_timer: Move system register timer
> programming over to CVAL"). We used to use the TVAL accessor which
> doesn't need a read of the counter, while the switch to CVAL needs
> one. Obviously, I didn't enough pay attention to the A73 erratum.
>
> Please send in a fix for this.
>
> Thanks,
>
> 	M.
>
