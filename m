Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDB5628FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbiKOCHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbiKOCHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:07:24 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5052C1A3B0;
        Mon, 14 Nov 2022 18:07:22 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NB8h41jQkz4f3v71;
        Tue, 15 Nov 2022 10:07:16 +0800 (CST)
Received: from [10.174.178.165] (unknown [10.174.178.165])
        by APP2 (Coremail) with SMTP id Syh0CgDX7rlS9HJjtCAnAg--.45139S2;
        Tue, 15 Nov 2022 10:07:19 +0800 (CST)
Message-ID: <d509ee79-e73a-b236-bed9-8d40b8f6d460@huaweicloud.com>
Date:   Tue, 15 Nov 2022 10:06:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 02/13] leds: el15203000: Fix devm vs. non-devm ordering
To:     Oleh Kravchenko <oleg@kaa.org.ua>, wangyufen <wangyufen@huawei.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
References: <1667983694-15040-1-git-send-email-wangyufen@huawei.com>
 <1667983694-15040-3-git-send-email-wangyufen@huawei.com>
 <5D15416B-1866-4031-9958-7CD763C0BD6E@kaa.org.ua>
 <bbd67e6a-8ce0-dbe8-6ab1-9d4a015f4ee9@huawei.com>
 <6D18A607-EC63-495F-BA2D-78E0DB056D3C@kaa.org.ua>
 <c53e4614-eb06-cda8-f9da-2ca58396df54@huawei.com>
 <AA4E5187-59BC-4E04-B392-7BD48F0443A1@kaa.org.ua>
From:   Wei Yongjun <weiyongjun@huaweicloud.com>
In-Reply-To: <AA4E5187-59BC-4E04-B392-7BD48F0443A1@kaa.org.ua>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDX7rlS9HJjtCAnAg--.45139S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF48Zw48uw4xur1DWF4fGrg_yoW5Wr4kpr
        y8Gay7K3y8Wr4DGwnFv3WUWF10g3WFya1rXr12gr1F9rnxArZ2gFyktFyYk398JrWkJF4D
        t34jqw1fXF1qvaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UUUUU==
X-CM-SenderInfo: 5zhl50pqjm3046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleh,

On 2022/11/11 18:39, Oleh Kravchenko wrote:
> Hello Wang,
> 
>> 11 лист. 2022 р. о 11:21 wangyufen <wangyufen@huawei.com> написав(ла):
>>
>>
>> 在 2022/11/9 18:43, Oleh Kravchenko 写道:
>>>
>>>
>>>> 9 лист. 2022 р. о 12:25 wangyufen <wangyufen@huawei.com> написав(ла):
>>>>
>>>>
>>>> 在 2022/11/9 17:39, Oleh Kravchenko 写道:
>>>>
>>>>>> -static void el15203000_remove(struct spi_device *spi)
>>>>>>
>>>>> Is remove() callback from struct spi_driver deprecated?
>>>>>
>>>> It is not that remove() callback is deprecated,
>>>> it's that after wrapping mutex_destroy() call with devm_add_action_or_reset(),
>>>> remove() callback is unnecessary here.
>>>>
>>> When remove() is called, the memory allocated by devm_*() is valid.
>>> So what you try to fix here?
>>
>> Fix the &priv->lock used after destroy, for details, please see patch #0
>> LKML: Wang Yufen: [PATCH 00/13] leds: Fix devm vs. non-devm ordering
> 
> It doesn’t make any sense for me.
> You saying that remove() called before devm_* allocation
> if it true then set_brightness_delayed() will crash the system in anyway.
> 
> LED device has a parent SPI device; LED device can’t exist without SPI device.
> 
> So deallocation order should be next:
> 1. LED device devm_*()
> 2. SPI device remove()

The allocation order is as follows:

el15203000_probe()
  mutex_init(&priv->lock);
  el15203000_probe_dt(priv)
    device_for_each_child_node(priv->dev, child) {
      ...
      led->ldev.brightness_set_blocking = el15203000_set_blocking;
      ...
      devm_led_classdev_register_ext(priv->dev, &led->ldev, &init_data);
         dr = devres_alloc(devm_led_classdev_release, sizeof(*dr), GFP_KERNEL);
         <-- dr->node.release = devm_led_classdev_release()
         ...
         devres_add(parent, dr);
         <-- add dr->node to &priv->dev->devres_head

And the full deallocation order should be this:

1. SPI device .remove callback
2. LED device devm_*()
3. SPI device deallocation

spi_unregister_device()
  device_del()
    bus_remove_device()
      device_release_driver_internal()
        __device_release_driver()
          ...
	  device_remove()
	    spi_remove()   <-- call el15203000_remove() here, mutex_destroy(&priv->lock), lock destroy
          ...
          device_unbind_cleanup()
            devres_release_all()
              release_nodes()
              <-- traverse spi->dev->devres_head list and call dr->node.release in sequence.
                   devm_led_classdev_release()
                     led_classdev_unregister()
                     <-- flush set_brightness_work here, before the work flush, set_brightness_work may be sched.
                     <-- that is el15203000_set_blocking()..-> mutex_lock(&led->priv->lock) is called,
                     <-- this leads to the priv->lock use after destroy.
 put_device(&spi->dev) <-- spi device is deallocation in here


Regards,
Wei Yongjun

