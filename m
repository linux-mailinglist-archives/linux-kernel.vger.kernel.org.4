Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260706A01AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 05:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjBWEBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 23:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjBWEBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 23:01:08 -0500
Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4D541085;
        Wed, 22 Feb 2023 20:01:04 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08458463|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00787236-0.000697895-0.99143;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.RUUPChN_1677124861;
Received: from 192.168.220.144(mailfrom:michael@allwinnertech.com fp:SMTPD_---.RUUPChN_1677124861)
          by smtp.aliyun-inc.com;
          Thu, 23 Feb 2023 12:01:02 +0800
Message-ID: <03a65972-f4ba-9d52-ed5c-ef5374927e53@allwinnertech.com>
Date:   Thu, 23 Feb 2023 12:01:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230222013944.31095-1-michael@allwinnertech.com>
 <0b6f1b7b-9275-6947-b1b9-73d60ce095ab@gmail.com>
From:   Michael Wu <michael@allwinnertech.com>
In-Reply-To: <0b6f1b7b-9275-6947-b1b9-73d60ce095ab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sergei:

On 2/22/2023 4:59 PM, Sergei Shtylyov wrote:
> Hello!
> 
> On 2/22/23 4:39 AM, Michael Wu wrote:
> 
>> This patch fixes a problem that USB mouse can't wake up the device that
>> enters standby.
>>
>> At present, the kernel only checks whether certain USB manufacturers
>> support wake-up, which will easily cause inconvenience to the
>> development work of other manufacturers and add unnecessary work to the
>> maintenance of kernel.
>>
>> The USB protocol supports judging whether a usb supports the wake-up
>> function, so it should be more reasonable to add a wake-up source by
>> directly checking the settings from the USB protocol.
>>
>> There was a similar issue on the keyboard before, which was fixed by
>> this patch (3d61510f4eca), but now the problem happened on the mouse.
>> This patch uses a similar idea to fix this problem.
>>
>> Signed-off-by: Michael Wu <michael@allwinnertech.com>
>> ---
>>   drivers/hid/usbhid/hid-core.c | 8 ++++++++
>>   drivers/hid/usbhid/usbmouse.c | 1 +
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
>> index be4c731aaa65..d3a6755cca09 100644
>> --- a/drivers/hid/usbhid/hid-core.c
>> +++ b/drivers/hid/usbhid/hid-core.c
>> @@ -1189,6 +1189,14 @@ static int usbhid_start(struct hid_device *hid)
>>   		device_set_wakeup_enable(&dev->dev, 1);
>>   	}
>>   
>> +	/**
> 

>     The kernel-doc comments should not be used here in the function body.

We will remove the NOTE comments.

> 
>> +	 * NOTE: enable remote wakeup by default for all mouse devices
>> +	 * supporting the boot protocol.
>> +	 */
>> +	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT &&
>> +	    interface->desc.bInterfaceProtocol == USB_INTERFACE_PROTOCOL_MOUSE)
>> +		device_set_wakeup_enable(&dev->dev, 1);
>> +
>>   	mutex_unlock(&usbhid->mutex);
>>   	return 0;
>>   
> [...]
> 
> MBR, Sergey

-- 
Regards,
Michael Wu
