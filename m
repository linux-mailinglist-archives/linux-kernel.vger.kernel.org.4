Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704D36A16E0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 08:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBXHDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 02:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBXHDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 02:03:00 -0500
Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0732B7DA5;
        Thu, 23 Feb 2023 23:02:56 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07486305|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.432413-0.0454555-0.522131;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.RVTx2Y7_1677222125;
Received: from 192.168.220.144(mailfrom:michael@allwinnertech.com fp:SMTPD_---.RVTx2Y7_1677222125)
          by smtp.aliyun-inc.com;
          Fri, 24 Feb 2023 15:02:52 +0800
Message-ID: <28256d02-e84f-46ec-3802-f1e8497cb281@allwinnertech.com>
Date:   Fri, 24 Feb 2023 15:02:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        richard.gong@amd.com
References: <20230222013944.31095-1-michael@allwinnertech.com>
 <Y/WwXBF37hoZBbQa@kroah.com>
 <9bf4463c-6541-a6cb-9bbc-6d070118509a@allwinnertech.com>
 <Y/dMq2KKYfdMdrjh@kroah.com>
From:   Michael Wu <michael@allwinnertech.com>
In-Reply-To: <Y/dMq2KKYfdMdrjh@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg：

On 2/23/2023 7:23 PM, Greg KH wrote:
> On Thu, Feb 23, 2023 at 07:18:12PM +0800, Michael Wu wrote:
>> Dear Greg,
>>
>> On 2/22/2023 2:04 PM, Greg KH wrote:
>>> On Wed, Feb 22, 2023 at 09:39:44AM +0800, Michael Wu wrote:
>>>> This patch fixes a problem that USB mouse can't wake up the device that
>>>> enters standby.
>>>
>>> This not a problem, it is that way by design.
>>
>> I got it, maybe it's a little problem to say that.
> 
> It is.
> 
>>>> At present, the kernel only checks whether certain USB manufacturers
>>>> support wake-up, which will easily cause inconvenience to the
>>>> development work of other manufacturers and add unnecessary work to the
>>>> maintenance of kernel.
>>>>
>>>> The USB protocol supports judging whether a usb supports the wake-up
>>>> function, so it should be more reasonable to add a wake-up source by
>>>> directly checking the settings from the USB protocol.
>>>
>>> But you do not do that in this patch, why not?
>>
>> I just want to explain the background of my patch, to prove we could use a
>> similar way to avoid such a "disturbing" situation.
>> To reduce the influence, my patch enables remote wakeup for USB mouse
>> devices refer to what keyboard do.
> 
> Keyboards are not mice :)

Sorry, What I wanted to say is that we registered the mouse wake-up 
source by referring to the practice of the keyboard.

> 
>>>> There was a similar issue on the keyboard before, which was fixed by
>>>> this patch (3d61510f4eca), but now the problem happened on the mouse.
>>>> This patch uses a similar idea to fix this problem.
>>>>
>>>> Signed-off-by: Michael Wu <michael@allwinnertech.com>
>>>> ---
>>>>    drivers/hid/usbhid/hid-core.c | 8 ++++++++
>>>>    drivers/hid/usbhid/usbmouse.c | 1 +
>>>>    2 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
>>>> index be4c731aaa65..d3a6755cca09 100644
>>>> --- a/drivers/hid/usbhid/hid-core.c
>>>> +++ b/drivers/hid/usbhid/hid-core.c
>>>> @@ -1189,6 +1189,14 @@ static int usbhid_start(struct hid_device *hid)
>>>>    		device_set_wakeup_enable(&dev->dev, 1);
>>>>    	}
>>>> +	/**
>>>> +	 * NOTE: enable remote wakeup by default for all mouse devices
>>>> +	 * supporting the boot protocol.
>>>> +	 */
>>>> +	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT &&
>>>> +	    interface->desc.bInterfaceProtocol == USB_INTERFACE_PROTOCOL_MOUSE)
>>>> +		device_set_wakeup_enable(&dev->dev, 1);
>>>
>>> Sorry, but we can not take this unless it is proven that this will work
>>> properly for all of these devices.  Other operating systems do not do
>>> this last I checked, so there will be problems.
>>
>> As Mario Limonciello says, they has confirmed that the Microsoft Windows
>> does set a similar policy as well. Can we talk about more in this topic: why
>> does Linux not support it?
>> Of course, if you have other great idea, I will appreciate that if we can
>> have some further discussion.
> 
> You need to provide some sort of "proof" that this has been heavily
> tested on a huge range of devices before we can change this.
> 
> When this was first implemented, Windows did not work this way and many
> devices on the market were broken if this were to be enabled.  I'm sure
> the mailing list archives from 20+ years ago have many more details,
> please dig around there for specifics.
> 
> If you feel strongly that this is the way forward, why not do it in
> userspace today for your systems as part of testing this out?  It should
> not require a kernel change, right?

Thanks for your advises. I'm clear now. I will try it in userspace.

> 
> thanks,
> 
> greg k-h

-- 
Regards,
Michael Wu
