Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703C25BB7F9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 13:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiIQLUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 07:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiIQLT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 07:19:58 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487BB1117F;
        Sat, 17 Sep 2022 04:19:57 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MV7hX6V53zHnVp;
        Sat, 17 Sep 2022 19:17:48 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 17 Sep 2022 19:19:54 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 17 Sep 2022 19:19:53 +0800
Subject: Re: [PATCH -next v2 1/2] pinctrl: ocelot: add missing
 destroy_workqueue() in error path in ocelot_pinctrl_probe()
To:     <andy.shevchenko@gmail.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <p.zabel@pengutronix.de>,
        <horatiu.vultur@microchip.com>
References: <20220917024634.1021861-1-yangyingliang@huawei.com>
 <YyWLVF6OAyerJKvR@surfacebook>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <3bb3ca59-a248-eacd-9452-f1e7429b0557@huawei.com>
Date:   Sat, 17 Sep 2022 19:19:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YyWLVF6OAyerJKvR@surfacebook>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/9/17 16:54, andy.shevchenko@gmail.com wrote:
> Sat, Sep 17, 2022 at 10:46:33AM +0800, Yang Yingliang kirjoitti:
>> Add the missing destroy_workqueue() before return from ocelot_pinctrl_probe()
>> in error path.
>>
>> Fixes: c297561bc98a ("pinctrl: ocelot: Fix interrupt controller")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>> v2:
>>    move alloc_ordered_workqueue() after ocelot_pinctrl_register().
> Why? What will happen if user space start using pins before workqueue is allocated?
This is a suggestion from Horatiu Vultur.

And I think the workqueue is used in ocelot_irq_unmask_level(), but 
before ocelot_gpiochip_register() calling,
the irq is not prepared, the work won't be queued before 
ocelot_gpiochip_register().
>
> If you really want to have it correct, you need either drop all devm_ calls
> after allocating workqueue, or wrap destroying into devm.
I am trying to add devm APIs for allocating workqueue.

Thanks,
Yang
>
