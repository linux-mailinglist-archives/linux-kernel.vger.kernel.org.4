Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73956CBF81
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjC1Mop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjC1Mon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:44:43 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5845B9;
        Tue, 28 Mar 2023 05:44:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 89A2060502;
        Tue, 28 Mar 2023 14:44:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680007452; bh=oEFBB9KnqftP3o35DYs+XayAo1ekIcKT8h4VdA4XXnw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dxwGwN/yVn99PodGaEjTMkiOLAru/TtCzTOXtit+DKtChaRw4X345MfkUSWdaiNTk
         blmotBgILAxzwwZcSsvWbU5+/Fgzv0jmyVbcS3lOY29zEcJJd0WcSuuq8qwuDr3ct1
         TikXisG0zXpx5yc2msy9rEIdWbh9YRrjScCJneOvaik0H8KLpg2czxhgIoUrDpLv5b
         S8tj0CNX5+W+It55ZlwQyiUW4JPU2FpV7v23FVCoCeSozxSfDrwh0jhJbeXnxNyklt
         kYVPoSxagYWuxLvqiTz0ov+FS+iJifk0DDFzvJAZ8ewM08nb5K2yG4AVY1/yXzrUYL
         e2Mo62GJEwoyg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w7DwJIH0Ydx3; Tue, 28 Mar 2023 14:44:09 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id 7329D604FE;
        Tue, 28 Mar 2023 14:44:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680007449; bh=oEFBB9KnqftP3o35DYs+XayAo1ekIcKT8h4VdA4XXnw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eCMgSOuPSznW2sEsUkKUvwPQDQnUJli6JEUFR1s6EMWzw4YDp51HTJzqB9Klr4WIP
         IzmkfnWARhpuUY/4xRgsn/jcnjIBNLnAK9+A7SgJMI8NFGGt2Z1I3jPPKcRz1Q90Hh
         JBq6bO6GlSEW9U5M7qpJJYqddUCDNRrCv/kjt8NAbg6VCDNN8nE8WMaYXhOcHXkBdS
         gySKwtgJAS0wvgbHY1VFSiDPbN9yni2HWwkIoVh/y8uG1tVWGCI+KEdb7SEaTbVhif
         RPW8I70KxG7H+ToczzbJpS90uUvGYxrZTwbh74kPHzIqWle2fezOmVjEWx6G7yIiec
         5ZYxW8bIJcF5g==
Message-ID: <b50f9460-ac54-e997-f9b9-3c47a9b87aae@alu.unizg.hr>
Date:   Tue, 28 Mar 2023 14:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [BUG] systemd-devd triggers kernel memleak apparently in
 drivers/core/dd.c: driver_register()
Content-Language: en-US, hr
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
References: <5059b11b-8b6e-394b-338f-49e1339067fa@alu.unizg.hr>
 <ZCLPaYGKHlFQGKYQ@kroah.com>
 <542c13f5-4cdd-7750-f10a-ef64bb7e8faa@alu.unizg.hr>
 <d011a1d7-34ab-5f54-fcc7-d727abc7ec9b@alu.unizg.hr>
 <ZCLa3_HnLQA0GQKS@kroah.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZCLa3_HnLQA0GQKS@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/23 14:17, Greg Kroah-Hartman wrote:
> On Tue, Mar 28, 2023 at 02:08:06PM +0200, Mirsad Todorovac wrote:
>> On 3/28/23 13:59, Mirsad Todorovac wrote:
>>
>>> On 3/28/23 13:28, Greg Kroah-Hartman wrote:
>>>> On Tue, Mar 28, 2023 at 01:13:33PM +0200, Mirsad Todorovac wrote:
>>>>> Hi all,
>>>>>
>>>>> Here is another kernel memory leak report, just as I thought we have done with
>>>>> them by the xhci patch by Mathias.
>>>>>
>>>>> The memory leaks were caught on an AlmaLinux 8.7 (CentOS) fork system, running
>>>>> on a Lenovo desktop box (see lshw.txt) and the newest Linux kernel 6.3-rc4 commit
>>>>> g3a93e40326c8 with Mathias' patch for a xhci systemd-devd triggered leak.
>>>>>
>>>>>           See: <20230327095019.1017159-1-mathias.nyman@linux.intel.com> on LKML.
>>>>>
>>>>> This leak is also systemd-devd triggered, except for the memstick_check() leaks
>>>>> which I was unable to bisect due to the box not booting older kernels (work in
>>>>> progress).
>>>>>
>>>>> unreferenced object 0xffff88ad12392710 (size 96):
>>>>>     comm "systemd-udevd", pid 735, jiffies 4294896759 (age 2257.568s)
>>>>>     hex dump (first 32 bytes):
>>>>>       53 65 72 69 61 6c 50 6f 72 74 31 41 64 64 72 65  SerialPort1Addre
>>>>>       73 73 2c 33 46 38 2f 49 52 51 34 3b 5b 4f 70 74  ss,3F8/IRQ4;[Opt
>>>>>     backtrace:
>>>>>       [<ffffffffae8fb26c>] slab_post_alloc_hook+0x8c/0x3e0
>>>>>       [<ffffffffae902b49>] __kmem_cache_alloc_node+0x1d9/0x2a0
>>>>>       [<ffffffffae8773c9>] __kmalloc_node_track_caller+0x59/0x180
>>>>>       [<ffffffffae866a1a>] kstrdup+0x3a/0x70
>>>>>       [<ffffffffc0d839aa>] tlmi_extract_output_string.isra.0+0x2a/0x60 [think_lmi]
>>>>>       [<ffffffffc0d83b64>] tlmi_setting.constprop.4+0x54/0x90 [think_lmi]
>>>>>       [<ffffffffc0d842b1>] tlmi_probe+0x591/0xba0 [think_lmi]
>>>>>       [<ffffffffc051dc53>] wmi_dev_probe+0x163/0x230 [wmi]
>>>>
>>>> Why aren't you looking at the wmi.c driver?  That should be where the
>>>> issue is, not the driver core, right?
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>> Hi, Mr. Greg,
>>>
>>> Thanks for the quick reply.
>>>
>>> I have added CC: for additional developers per drivers/platform/x86/wmi.c,
>>> however, this seems to me like hieroglyphs. There is nothing obvious, but
>>> I had not noticed it with v6.3-rc3?
>>>
>>> Maybe, there seems to be something off:
>>>
>>>       949 static int wmi_dev_probe(struct device *dev)
>>>       950 {
>>>       951         struct wmi_block *wblock = dev_to_wblock(dev);
>>>       952         struct wmi_driver *wdriver = drv_to_wdrv(dev->driver);
>>>       953         int ret = 0;
>>>       954         char *buf;
>>>       955
>>>       956         if (ACPI_FAILURE(wmi_method_enable(wblock, true)))
>>>       957                 dev_warn(dev, "failed to enable device -- probing anyway\n");
>>>       958
>>>       959         if (wdriver->probe) {
>>>       960                 ret = wdriver->probe(dev_to_wdev(dev),
>>>       961                                 find_guid_context(wblock, wdriver));
>>>       962                 if (ret != 0)
>>>       963                         goto probe_failure;
>>>       964         }
>>>       965
>>>       966         /* driver wants a character device made */
>>>       967         if (wdriver->filter_callback) {
>>>       968                 /* check that required buffer size declared by driver or MOF */
>>>       969                 if (!wblock->req_buf_size) {
>>>       970                         dev_err(&wblock->dev.dev,
>>>       971                                 "Required buffer size not set\n");
>>>       972                         ret = -EINVAL;
>>>       973                         goto probe_failure;
>>>       974                 }
>>>       975
>>>       976                 wblock->handler_data = kmalloc(wblock->req_buf_size,
>>>       977                                                GFP_KERNEL);
>>>       978                 if (!wblock->handler_data) {
>>>       979                         ret = -ENOMEM;
>>>       980                         goto probe_failure;
>>>       981                 }
>>>       982
>>>       983                 buf = kasprintf(GFP_KERNEL, "wmi/%s", wdriver->driver.name);
>>>       984                 if (!buf) {
>>>       985                         ret = -ENOMEM;
>>>       986                         goto probe_string_failure;
>>>       987                 }
>>>       988                 wblock->char_dev.minor = MISC_DYNAMIC_MINOR;
>>>       989                 wblock->char_dev.name = buf;
>>>       990                 wblock->char_dev.fops = &wmi_fops;
>>>       991                 wblock->char_dev.mode = 0444;
>>>       992                 ret = misc_register(&wblock->char_dev);
>>>       993                 if (ret) {
>>>       994                         dev_warn(dev, "failed to register char dev: %d\n", ret);
>>>       995                         ret = -ENOMEM;
>>>       996                         goto probe_misc_failure;
>>>       997                 }
>>>       998         }
>>>       999
>>>      1000         set_bit(WMI_PROBED, &wblock->flags);
>>>      1001         return 0;
>>>      1002
>>>      1003 probe_misc_failure:
>>>      1004         kfree(buf);
>>>      1005 probe_string_failure:
>>>      1006         kfree(wblock->handler_data);
>>>      1007 probe_failure:
>>>      1008         if (ACPI_FAILURE(wmi_method_enable(wblock, false)))
>>>      1009                 dev_warn(dev, "failed to disable device\n");
>>>
>>>
>>> char *buf is passed to kfree(buf) uninitialised if wdriver->filter_callback
>>> is not set.
>>>
>>> It seems like a logical error per se, but I don't believe this is the cause
>>> of the leak?
>>
>> CORRECTION:
>>
>> I overlooked the "return 0" in line 1001.
> 
> Yeah, and the memory looks to be freed properly in the wmi_dev_remove()
> callback, right?

It would appear so. To verify that:

Alloc:
976		wblock->handler_data = kmalloc(wblock->req_buf_size,
					       GFP_KERNEL);
		<check>

983		buf = kasprintf(GFP_KERNEL, "wmi/%s", wdriver->driver.name);
		<check>
989		wblock->char_dev.name = buf;

In lines 1022-1023:

1022		kfree(wblock->char_dev.name);
1023		kfree(wblock->handler_data);

>> This is why I don't think things should be rushed, but analysed with clear and
>> cold head. And with as many eyes as possible :)
>>
>> The driver stuff is my long-term research interest. To state the obvious,
>> the printing and multimedia education and industry in general would benefit from
>> the open-source drivers for many instruments that still work, but are obsoleted
>> by the producer and require unsupported versions of the OS.
>>
>> Thank you again for reviewing the bug report, however, ATM I do not think I have
>> what it takes to hunt down the memleak. :-/
> 
> Do you have a reproducer that you can use to show the problem better?

Unfortunately, the problem doesn't seem to appear during the run of a particular
test, but immediately on startup of the OS. This makes it awkward to pinpoint the
exact service that triggered memory leaks. But they would appear to have to do
with the initialisation of the USB devices, wouldn't they?

There seem to be strings:

"USBPortAccess,Enabled;[Optional:"
"USBBIOSSupport,Enabled;[Optional"
"USBEnumerationDelay,Disabled;[Op"

This seems to be happening during USB initialisation and before any services.
But I might as well be wrong.

> Or can you test kernel patches to verify the problem is fixed or not if
> we send you patches to test?

Certainly, Lord willing, I can test the patches in the same environment that
mainfeted the bug (or memleak).

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia

"What’s this thing suddenly coming towards me very fast? Very very fast.
... I wonder if it will be friends with me?"
