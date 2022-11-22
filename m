Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22155633203
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiKVBLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiKVBLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:11:24 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB9DE6342;
        Mon, 21 Nov 2022 17:10:17 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NGR4y540Mz4f3m7D;
        Tue, 22 Nov 2022 09:10:10 +0800 (CST)
Received: from [10.174.179.191] (unknown [10.174.179.191])
        by APP3 (Coremail) with SMTP id _Ch0CgC3xaF0IXxjWVVwAw--.43966S2;
        Tue, 22 Nov 2022 09:10:13 +0800 (CST)
Message-ID: <f5969fbb-bdbb-6841-e1db-3c32a7a27061@huaweicloud.com>
Date:   Tue, 22 Nov 2022 09:10:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 02/13] leds: el15203000: Fix devm vs. non-devm ordering
To:     Wei Yongjun <weiyongjun@huaweicloud.com>,
        Oleh Kravchenko <oleg@kaa.org.ua>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
References: <1667983694-15040-1-git-send-email-wangyufen@huawei.com>
 <1667983694-15040-3-git-send-email-wangyufen@huawei.com>
 <5D15416B-1866-4031-9958-7CD763C0BD6E@kaa.org.ua>
 <bbd67e6a-8ce0-dbe8-6ab1-9d4a015f4ee9@huawei.com>
 <6D18A607-EC63-495F-BA2D-78E0DB056D3C@kaa.org.ua>
 <c53e4614-eb06-cda8-f9da-2ca58396df54@huawei.com>
 <AA4E5187-59BC-4E04-B392-7BD48F0443A1@kaa.org.ua>
 <d509ee79-e73a-b236-bed9-8d40b8f6d460@huaweicloud.com>
From:   Wang Yufen <wangyufen@huaweicloud.com>
In-Reply-To: <d509ee79-e73a-b236-bed9-8d40b8f6d460@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3xaF0IXxjWVVwAw--.43966S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF48Gw13Zr15Kr1xtr1fWFg_yoW5Cw1Dpr
        WrGa1UKay8Wr1DGwnFv3WUWFy0g3WYya1rXw12gr1S9rnIyr92gayktrWYkrWkJrWkJF4D
        t34jgFyfXF4qqw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5zdqw5hxih0q5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/15 10:06, Wei Yongjun 写道:
> Hi Oleh,
> 
> On 2022/11/11 18:39, Oleh Kravchenko wrote:
>> Hello Wang,
>>
>>> 11 лист. 2022 р. о 11:21 wangyufen <wangyufen@huawei.com> написав(ла):
>>>
>>>
>>> 在 2022/11/9 18:43, Oleh Kravchenko 写道:
>>>>
>>>>
>>>>> 9 лист. 2022 р. о 12:25 wangyufen <wangyufen@huawei.com> написав(ла):
>>>>>
>>>>>
>>>>> 在 2022/11/9 17:39, Oleh Kravchenko 写道:
>>>>>
>>>>>>> -static void el15203000_remove(struct spi_device *spi)
>>>>>>>
>>>>>> Is remove() callback from struct spi_driver deprecated?
>>>>>>
>>>>> It is not that remove() callback is deprecated,
>>>>> it's that after wrapping mutex_destroy() call with devm_add_action_or_reset(),
>>>>> remove() callback is unnecessary here.
>>>>>
>>>> When remove() is called, the memory allocated by devm_*() is valid.
>>>> So what you try to fix here?
>>>
>>> Fix the &priv->lock used after destroy, for details, please see patch #0
>>> LKML: Wang Yufen: [PATCH 00/13] leds: Fix devm vs. non-devm ordering
>>
>> It doesn’t make any sense for me.
>> You saying that remove() called before devm_* allocation
>> if it true then set_brightness_delayed() will crash the system in anyway.
>>
>> LED device has a parent SPI device; LED device can’t exist without SPI device.
>>
>> So deallocation order should be next:
>> 1. LED device devm_*()
>> 2. SPI device remove()
> 
> The allocation order is as follows:
> 
> el15203000_probe()
>    mutex_init(&priv->lock);
>    el15203000_probe_dt(priv)
>      device_for_each_child_node(priv->dev, child) {
>        ...
>        led->ldev.brightness_set_blocking = el15203000_set_blocking;
>        ...
>        devm_led_classdev_register_ext(priv->dev, &led->ldev, &init_data);
>           dr = devres_alloc(devm_led_classdev_release, sizeof(*dr), GFP_KERNEL);
>           <-- dr->node.release = devm_led_classdev_release()
>           ...
>           devres_add(parent, dr);
>           <-- add dr->node to &priv->dev->devres_head
> 
> And the full deallocation order should be this:
> 
> 1. SPI device .remove callback
> 2. LED device devm_*()
> 3. SPI device deallocation
> 
> spi_unregister_device()
>    device_del()
>      bus_remove_device()
>        device_release_driver_internal()
>          __device_release_driver()
>            ...
> 	  device_remove()
> 	    spi_remove()   <-- call el15203000_remove() here, mutex_destroy(&priv->lock), lock destroy
>            ...
>            device_unbind_cleanup()
>              devres_release_all()
>                release_nodes()
>                <-- traverse spi->dev->devres_head list and call dr->node.release in sequence.
>                     devm_led_classdev_release()
>                       led_classdev_unregister()
>                       <-- flush set_brightness_work here, before the work flush, set_brightness_work may be sched.
>                       <-- that is el15203000_set_blocking()..-> mutex_lock(&led->priv->lock) is called,
>                       <-- this leads to the priv->lock use after destroy.
>   put_device(&spi->dev) <-- spi device is deallocation in here
> 
>
Hi Oleh,

Judging from the deallocation order above, there is a issue that the 
&priv->lock used after destroy, right?

And thanks Wei for the detailed explanation.

Thanks,
Wang


> Regards,
> Wei Yongjun
> 

