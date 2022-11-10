Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547476239D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 03:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiKJChD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 21:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiKJCg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 21:36:59 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D19201BD;
        Wed,  9 Nov 2022 18:36:57 -0800 (PST)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N75W54m3ZzJnZQ;
        Thu, 10 Nov 2022 10:33:53 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 10:36:54 +0800
Message-ID: <f118d0b1-1bf2-b710-c3b4-2745c72f02b3@huawei.com>
Date:   Thu, 10 Nov 2022 10:36:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] gpiolib: fix memory leak in gpiochip_setup_dev
Content-Language: en-US
To:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        <linux@roeck-us.net>
CC:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <liwei391@huawei.com>,
        <yuancan@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Y2ttmcV+PFDUZR3l@sol>
 <20221109093120.3128541-1-zengheng4@huawei.com>
 <Y2u9bLIohQ8eFTY1@smile.fi.intel.com> <Y2xTSyce8WfLdtge@sol>
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <Y2xTSyce8WfLdtge@sol>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/11/10 9:26, Kent Gibson wrote:
> On Wed, Nov 09, 2022 at 04:47:08PM +0200, Andy Shevchenko wrote:
>> On Wed, Nov 09, 2022 at 05:31:20PM +0800, Zeng Heng wrote:
>>> gcdev_register & gcdev_unregister call device_add & device_del to
>>> request/release source. But in device_add, the dev->p allocated by
>>> device_private_init is not released by device_del.
>> First of all, we refer to the functions like func().
Thanks, it would be updated in next version.
> Further to this, the description of the problem could be clearer -
> it would be helpful to indicate the code path that triggers the problem
> - it is gpiochip_sysfs_register() returning an error?
>
>>> So when calling gcdev_unregister to release gdev, it needs put_device
>>> to release dev in the following.
>>>
>>> Otherwise, kmemleak would report memory leak such as below:
>>>
>>> unreferenced object 0xffff88810b406400 (size 512):
>>>    comm "python3", pid 1682, jiffies 4295346908 (age 24.090s)
>>>    hex dump (first 32 bytes):
>>>      00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
>>>      ff ff ff ff ff ff ff ff a0 5e 23 90 ff ff ff ff  .........^#.....
>>>    backtrace:
>> Second, read Submitting Patches on how to provide your backtraces in the
>> message body.

Thanks, it would be updated in next version.

>>
>>>      [<00000000a58ee5fe>] kmalloc_trace+0x22/0x110
>>>      [<0000000045fe2058>] device_add+0xb34/0x1130
>>>      [<00000000d778b45f>] cdev_device_add+0x83/0xe0
>>>      [<0000000089f948ed>] gpiolib_cdev_register+0x73/0xa0
>>>      [<00000000a3a8a316>] gpiochip_setup_dev+0x1c/0x70
>>>      [<00000000787227b4>] gpiochip_add_data_with_key+0x10f6/0x1bf0
>>>      [<000000009ac5742c>] devm_gpiochip_add_data_with_key+0x2e/0x80
>>>      [<00000000bf2b23d9>] xra1403_probe+0x192/0x1b0 [gpio_xra1403]
>>>      [<000000005b5ef2d4>] spi_probe+0xe1/0x140
>>>      [<000000002b26f6f1>] really_probe+0x17c/0x3f0
>>>      [<00000000dd2dad9c>] __driver_probe_device+0xe3/0x170
>>>      [<000000005ca60d2a>] device_driver_attach+0x34/0x80
>>>      [<00000000e9db90db>] bind_store+0x10b/0x1a0
>>>      [<00000000e2650f8a>] drv_attr_store+0x49/0x70
>>>      [<0000000080a80b2b>] sysfs_kf_write+0x8c/0xb0
>>>      [<00000000a28b45b9>] kernfs_fop_write_iter+0x216/0x2e0
>>>
>>> unreferenced object 0xffff888100de9800 (size 512):
>>>    comm "python3", pid 264, jiffies 4294737615 (age 33.514s)
>>>    hex dump (first 32 bytes):
>>>      00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
>>>      ff ff ff ff ff ff ff ff a0 5e 63 a1 ff ff ff ff  .........^c.....
>>>    backtrace:
>>>      [<00000000bcc571d0>] kmalloc_trace+0x22/0x110
>>>      [<00000000eeb06124>] device_add+0xb34/0x1130
>>>      [<000000007e5cd2fd>] cdev_device_add+0x83/0xe0
>>>      [<000000008f6bcd3a>] gpiolib_cdev_register+0x73/0xa0
>>>      [<0000000012c93b24>] gpiochip_setup_dev+0x1c/0x70
>>>      [<00000000a24b646a>] gpiochip_add_data_with_key+0x10f6/0x1bf0
>>>      [<000000000c225212>] tpic2810_probe+0x16e/0x196 [gpio_tpic2810]
>>>      [<00000000b52d04ff>] i2c_device_probe+0x651/0x680
>>>      [<0000000058d3ff6b>] really_probe+0x17c/0x3f0
>>>      [<00000000586f43d3>] __driver_probe_device+0xe3/0x170
>>>      [<000000003f428602>] device_driver_attach+0x34/0x80
>>>      [<0000000040e91a1b>] bind_store+0x10b/0x1a0
>>>      [<00000000c1d990b9>] drv_attr_store+0x49/0x70
>>>      [<00000000a23bfc22>] sysfs_kf_write+0x8c/0xb0
>>>      [<00000000064e6572>] kernfs_fop_write_iter+0x216/0x2e0
>>>      [<00000000026ce093>] vfs_write+0x658/0x810
>>>
>>> Because at the point of gpiochip_setup_dev here, where dev.release
>>> does not set yet, calling put_device would cause the warning of
>>> no release function and double-free in the following fault handler
>>> route (when kfree dev_name). So directly calling kfree to release
>>> dev->p here in case of memory leak.
> Again, this could be clearer.  The dev->p is normally freed by
> device_release() - why is that not happening in this case?
> (as put_device() is never called in this path)
>
> The double free you see if you do call put_device() appears to be due to
> different expectations as to the cleanup that gpiochip_setup_dev() will
> perform on error, depending on where it is called. gpiochip_setup_devs()
> assumes any cleanup is performed by gpiochip_setup_dev(), while
> gpiochip_add_data_with_key() assumes that it hasn't performed any cleanup.
>
> Having gpiochip_setup_dev() perform its own cleanup makes the most sense
> to me, so gpiochip_add_data_with_key() should be changed to allow for
> that.


Right, the cleanup route of gpiochip_add_data_with_key() & 
gpiochip_setup_dev()

has to be considered comprehensively after any possible cases of fault 
injections.


>> ...
>>
>>> @@ -539,6 +539,7 @@ static int gpiochip_setup_dev(struct gpio_device *gdev)
>>>   
>>>   err_remove_device:
>>>   	gcdev_unregister(gdev);
>>> +	kfree(gdev->dev.p);
>>>   	return ret;
>> Third, I do not believe it's a correct fix.
>> Have you read comments around device_del() / etc.?

Yes, not only the comments I read, but also the device_del() implement code.

Releasing the dev->p pointer is not the business with device_del(), but 
it's relied on

put_device() calling release function.

Turning back here, the release function is not set yet at this point, 
there is a gap

between device_add() and set release function pointer.

That's the reason why choose to free dev->p explicitly as the mail 
mentioned above.

> I agree - this is not the correct fix.  The correct fix is to trigger the
> normal cleanup mechanism, so put_device().
> The fact that that triggers a warning:
>
> "Device '%s' does not have a release() function, it is broken and must be
> fixed. See Documentation/core-api/kobject.rst.\n"
>
> is an indicator that dev.release should be set earlier.
> If gpiodevice_release() is not appropriate, or cannot be modified to deal
> with the device state at that point, then an appropriate interim release
> function should be set.
>
> And, as mentioned above, gpiochip_add_data_with_key() needs to be modified
> to allow for gpiochip_setup_dev() cleaning up its own mess.
>
> That is my take, but that is just from perusing the code so I may be
> totally off base.  Either way, an ACK/NACK on this from a maintainer or
> other gpiolib expert would be helpful to expiditing a solution.
>
> Cheers,
> Kent.

Yes, exactly.

Thanks to all,

Zeng Heng

