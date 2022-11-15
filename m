Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631AB6293EB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbiKOJKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiKOJKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:10:32 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48D525D5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:10:30 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NBL4J6KcKz4f3vdd
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 17:10:24 +0800 (CST)
Received: from [10.174.178.165] (unknown [10.174.178.165])
        by APP2 (Coremail) with SMTP id Syh0CgBnfrmCV3Nj+0M3Ag--.105S2;
        Tue, 15 Nov 2022 17:10:28 +0800 (CST)
Message-ID: <0ec81207-23e9-d5e4-27ae-63197c98c549@huaweicloud.com>
Date:   Tue, 15 Nov 2022 17:10:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] irqchip/wpcm450: fix memory leak in ap_init_qci_info()
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20221114110854.554220-1-weiyongjun@huaweicloud.com>
 <Y3NPcfuS9M6BSoEW@probook>
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
In-Reply-To: <Y3NPcfuS9M6BSoEW@probook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBnfrmCV3Nj+0M3Ag--.105S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4rtFWDZry5tr47WrW3Jrb_yoWkuwc_ur
        4Uurn3ZF4vkF4rtay3uF45X390yF1vgrnaqF12yry5Zay0q393Grn7Zr93JF4IgF4xtrs7
        Cr9avFy8A347GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5zhl50pqjm3046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/11/15 16:36, Jonathan Neuschäfer wrote:
> Hi,
>
> the function name is wrong in the in the subject line. Other than that,
> the patch looks good.


Thanks, will fix in next version.


Regards,

Wei Yongjun


>
> Thanks,
> Jonathan
>
>
> On Mon, Nov 14, 2022 at 11:08:54AM +0000, Wei Yongjun wrote:
>> From: Wei Yongjun <weiyongjun1@huawei.com>
>>
>> If of_iomap() failed, 'aic' should be freed before return. Otherwise
>> there is a memory leak.
>>
>> Fixes: fead4dd49663 ("irqchip: Add driver for WPCM450 interrupt controller")
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>> ---
>>  drivers/irqchip/irq-wpcm450-aic.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/irqchip/irq-wpcm450-aic.c b/drivers/irqchip/irq-wpcm450-aic.c
>> index 0dcbeb1a05a1..91df62a64cd9 100644
>> --- a/drivers/irqchip/irq-wpcm450-aic.c
>> +++ b/drivers/irqchip/irq-wpcm450-aic.c
>> @@ -146,6 +146,7 @@ static int __init wpcm450_aic_of_init(struct device_node *node,
>>  	aic->regs = of_iomap(node, 0);
>>  	if (!aic->regs) {
>>  		pr_err("Failed to map WPCM450 AIC registers\n");
>> +		kfree(aic);
>>  		return -ENOMEM;
>>  	}
>>  
>> -- 
>> 2.34.1
>>

