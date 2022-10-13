Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFC55FDC05
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiJMOHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJMOHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:07:01 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82D65E308;
        Thu, 13 Oct 2022 07:06:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MpB7s11znzKFPn;
        Thu, 13 Oct 2022 22:03:37 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgCHiMpBG0hjshrZAA--.47785S3;
        Thu, 13 Oct 2022 22:05:54 +0800 (CST)
Subject: Re: [PATCH] blk-mq: put the reference of the io scheduler module
 after switching back
To:     Jinlong Chen <chenjinlong2016@outlook.com>, yukuai1@huaweicloud.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <b79a8187-5342-8ff3-73fc-0324bdfb67fb@huaweicloud.com>
 <OSYP286MB0344F8B1AC5F35BEA990B593BE259@OSYP286MB0344.JPNP286.PROD.OUTLOOK.COM>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f1c07b2a-ffdd-0912-139d-d51b34b77bcd@huaweicloud.com>
Date:   Thu, 13 Oct 2022 22:05:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <OSYP286MB0344F8B1AC5F35BEA990B593BE259@OSYP286MB0344.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHiMpBG0hjshrZAA--.47785S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1UCw1rWrWkCrWrtr1rCrg_yoW8GFWkpF
        W8GayYkw4ktr40g3y7Kw47Ja40vrZ5Kr1Ygr1fAa4xXrn5W393Zr1xJa1a9FW5A34vyw1U
        W34xZFWkZ3s8JrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2022/10/13 21:47, Jinlong Chen Ð´µÀ:
> Hi, Yu Kuai!
> 
>>
>> I'm confused here, cause I do think this patch make sense.
>>
>> blk_mq_update_nr_hw_queues
>>    // for each queue using the tagset
>>    blk_mq_freeze_queue
>>    // if current elevator is not none, swith to none
>>    blk_mq_elv_switch_none
>>     // elevator need to be switched back, got a reference to
>>     // prevent module to be removed.
>>     __module_get
>>     elevator_switch(q, NULL);
>>
>>    // switch back from none elevator
>>    blk_mq_elv_switch_back
>>     -> should release the module reference here
>>    blk_mq_unfreeze_queue
>>
> 
> We need to release the reference only if blk_mq_elv_switch_back got its own
>   reference. However, blk_mq_elv_switch_back (precisely elevator_switch_mq)
>   does not increase the reference of the module it is switching to.
>   Hence, the reference got in blk_mq_elv_switch_none does not need to be released,
>   or we'll have to re-increase the reference count manually.'

But I don't see elevator_switch() release the referenct of the module
it is switching from. It's still not balance to me.

Thanks,
Kuai
> 
>>
>> By the way, I do not test yet, but I think problem can be reporduced:
>>
>>
>> 1. modprobe bfq
>> 2. switch elevator to bfq
>> 3. trigger blk_mq_update_nr_hw_queues
>> 4. switch elevator to none
>> 5. rmmod bfq will fail
>>
> 
> I tried to reproduce the problem but failed, so I found my mistake.
> 
> Sincerely,
> Jinlong Chen
> .
> 

