Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D88D6862BB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjBAJZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjBAJZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:25:02 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3458D3C283;
        Wed,  1 Feb 2023 01:24:59 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.14])
        by gateway (Coremail) with SMTP id _____8Bxa+rqL9pjaloLAA--.23123S3;
        Wed, 01 Feb 2023 17:24:58 +0800 (CST)
Received: from [10.180.13.14] (unknown [10.180.13.14])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx2r3pL9pjQ08mAA--.9807S3;
        Wed, 01 Feb 2023 17:24:57 +0800 (CST)
Subject: Re: [PATCH v1] usb: handle warm-reset port requests on hub_init
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ray Chi <raychi@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yinbo Zhu <zhuyinbo@loongson.cn>
References: <20230110081938.30308-1-yangyinglu@loongson.cn>
 <CAAd53p6eUNJf7aNkiXcTKAfhL_cM1Ki7JnW7s4oP7BeFQkP6ag@mail.gmail.com>
 <e684e8d7-6fc9-3331-868c-6cc4122f2cef@loongson.cn>
 <CAAd53p7_dQc0z_2Bw29xxnxMx6rSdJE7hj-MvH3HszSyE0uWCQ@mail.gmail.com>
From:   yangyinglu <yangyinglu@loongson.cn>
Message-ID: <55bc0144-6d04-db68-b77b-59bd9e7206dc@loongson.cn>
Date:   Wed, 1 Feb 2023 17:24:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAd53p7_dQc0z_2Bw29xxnxMx6rSdJE7hj-MvH3HszSyE0uWCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx2r3pL9pjQ08mAA--.9807S3
X-CM-SenderInfo: 51dqw5xlqjz3o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxuF18AFWktrW7Wr4xAFy8Grg_yoW5CF13pF
        y7JF97Kr4DJ3Wjkr9Fkwn5Wa45t3ySvFW3WrWjq3s0v3sY93ZxA3W3Xa43WayDXr1fAay5
        Z3W8KrZrXrW7GaDanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnEfOUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  Kai-Heng,

I'm sorry that it took so long to reply. I found other ways to fix this 
problem. I don't need to fix this code. Thank you.


在 2023/1/11 下午3:04, Kai-Heng Feng 写道:
> Hi yangyinglu,
> 
> On Wed, Jan 11, 2023 at 11:32 AM yangyinglu <yangyinglu@loongson.cn> wrote:
>>
>>
>>
>> 在 2023/1/11 上午10:33, Kai-Heng Feng 写道:
>>> Hi yangyinglu,
>>>
>>> On Tue, Jan 10, 2023 at 4:20 PM yangyinglu <yangyinglu@loongson.cn> wrote:
>>>>
>>>> USB-C storage device not detected on USB 3.0 host when
>>>> plugged in after boot, so need to warm-reset port
>>>
>>> Is it possible to enable USB dyndbg, plug a USB 3.0 device, then paste
>>> the relevant dmesg here? Thanks!
>>>
>>> Kai-Heng
>>
>>    hi,
>>       After entering the system, directly plug and unplug the USB flash
>> disk. usb control is  etron Technology Inc.The log is as follows:
>>    [   10.354484] radeon 0000:04:00.0: vgaarb: changed VGA decodes:
>> olddecodes=io+mem,decodes=none:owns=none
>>    [   10.484794] bridge: filtering via arp/ip/ip6tables is no longer
>> available by default. Update your scripts to load br_netfilter if you
>> need this.
>>    [   10.506968] tun: Universal TUN/TAP device driver, 1.6
>>    [   10.514128] virbr0: port 1(virbr0-nic) entered blocking state
>>    [   10.519858] virbr0: port 1(virbr0-nic) entered disabled state
>>    [   10.525646] device virbr0-nic entered promiscuous mode
>>    [   10.666536] virbr0: port 1(virbr0-nic) entered blocking state
>>    [   10.672268] virbr0: port 1(virbr0-nic) entered listening state
>>    [   10.748564] virbr0: port 1(virbr0-nic) entered disabled state
>>
>>    Loongnix GNU/Linux 20 Release 3 loongson-pc ttyS0
>>
>>
>>    loongson-pc login: [  147.701011] usb usb4-port1: Cannot enable. Maybe
>> the USB cable is bad?
>>    [  151.793206] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
>>    [  151.799726] usb usb4-port1: attempt power cycle
>>    [  157.465465] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
>>    [  161.557649] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
>>    [  161.564167] usb usb4-port1: unable to enumerate USB device
>>    [  165.641834] usb usb4-port1: Cannot enable. Maybe the USB cable is bad?
> 
> Is it possible to enable USB dyndbg by adding kernel parameter
> "usbcore.dyndbg" so we can see the portsc?
> 
> Kai-Heng
> 
>>
>>>
>>>>
>>>> Signed-off-by: yangyinglu <yangyinglu@loongson.cn>
>>>> ---
>>>>    drivers/usb/core/hub.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>>>> index 77e73fc8d673..bd4496b80c2d 100644
>>>> --- a/drivers/usb/core/hub.c
>>>> +++ b/drivers/usb/core/hub.c
>>>> @@ -1159,7 +1159,7 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
>>>>                   }
>>>>
>>>>                   /* Make sure a warm-reset request is handled by port_event */
>>>> -               if (type == HUB_RESUME &&
>>>> +               if ((type == HUB_RESUME || type == HUB_INIT2) &&
>>>>                       hub_port_warm_reset_required(hub, port1, portstatus))
>>>>                           set_bit(port1, hub->event_bits);
>>>>
>>>> --
>>>> 2.20.1
>>>>
>>

