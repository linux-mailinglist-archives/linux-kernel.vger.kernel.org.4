Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8466D6B7755
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCMMUI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 08:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCMMUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:20:06 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DA65072D;
        Mon, 13 Mar 2023 05:20:03 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 6928B1863CD5;
        Mon, 13 Mar 2023 15:19:59 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Y7GYg_myE7ai; Mon, 13 Mar 2023 15:19:58 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id ABACE1863CCF;
        Mon, 13 Mar 2023 15:19:58 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZmlpE9MgWsBK; Mon, 13 Mar 2023 15:19:58 +0300 (MSK)
Received: from [10.177.20.58] (unknown [10.177.20.58])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 29DC41863D04;
        Mon, 13 Mar 2023 15:19:58 +0300 (MSK)
Message-ID: <ddfab307-d471-ee08-6804-5f903adb1770@astralinux.ru>
Date:   Mon, 13 Mar 2023 15:19:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] goku_udc: Add check for NULL in goku_irq
Content-Language: en-US
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230203101828.14799-1-abelova@astralinux.ru>
 <Y9zly1vrj9z4c1qT@kroah.com>
 <39993564-7310-a2e0-8139-14ccb9a03ba9@astralinux.ru>
 <Y+zivah57216KcuB@kroah.com>
 <a5f90434-f3e5-f25e-76e2-b03e79cc16fe@alu.unizg.hr>
From:   Anastasia Belova <abelova@astralinux.ru>
In-Reply-To: <a5f90434-f3e5-f25e-76e2-b03e79cc16fe@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


11.03.2023 06:29, Mirsad Goran Todorovac пишет:
> On 15. 02. 2023. 14:48, Greg Kroah-Hartman wrote:
>> On Wed, Feb 15, 2023 at 04:39:56PM +0300, Анастасия Белова wrote:
>>> 03.02.2023 13:45, Greg Kroah-Hartman пишет:
>>>> On Fri, Feb 03, 2023 at 01:18:28PM +0300, Anastasia Belova wrote:
>>>>> Before dereferencing dev->driver check it for NULL.
>>>>>
>>>>> If an interrupt handler is called after assigning
>>>>> NULL to dev->driver, but before resetting dev->int_enable,
>>>>> NULL-pointer will be dereferenced.
>>>>>
>>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>>>
>>>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>>>> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>>>>> ---
>>>>>    drivers/usb/gadget/udc/goku_udc.c | 5 +++--
>>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/goku_udc.c
>>>>> index bdc56b24b5c9..896bba8b47f1 100644
>>>>> --- a/drivers/usb/gadget/udc/goku_udc.c
>>>>> +++ b/drivers/usb/gadget/udc/goku_udc.c
>>>>> @@ -1616,8 +1616,9 @@ static irqreturn_t goku_irq(int irq, void *_dev)
>>>>>    pm_next:
>>>>>    		if (stat & INT_USBRESET) {		/* hub reset done */
>>>>>    			ACK(INT_USBRESET);
>>>>> -			INFO(dev, "USB reset done, gadget %s\n",
>>>>> -				dev->driver->driver.name);
>>>>> +			if (dev->driver)
>>>>> +				INFO(dev, "USB reset done, gadget %s\n",
>>>>> +					dev->driver->driver.name);
>>>> How can this ever happen?  Can you trigger this somehow?  If not, I
>>>> don't think this is going to be possible (also what's up with printk
>>>> from an irq handler???)
>>> Unfortunately, I can't find the way to trigger this at the moment.
>> Then the change should not be made.
>>
>>> What about printk, should trace_printk be used instead?
>> Why?
>>
>>>> Odds are, no one actually has this hardware anymore, right?
>>> Despite of this, such vulnerability should be fixed because
>>> there is a possibility to exploit it.
>> How can this be "exploited" if it can not ever be triggered?
>>
>> Also, this would cause a NULL dereference in an irq handler, how can you
>> "exploit" that?
>>
>> Please only submit patches that actually do something.  It is getting
>> very hard to want to even review patches from this "project" based on
>> the recent submissions.
>>
>> thanks,
>>
>> greg k-h
> Hi Greg, Anastasia,

Hi Misrad,

> Without any pros or cons, or taking sides, there appears to be a similar check
> when using dev->driver->driver.name in
>
> https://elixir.bootlin.com/linux/latest/source/drivers/usb/gadget/udc/goku_udc.c#L1158
>
> 	seq_printf(m,
> 		   "%s - %s\n"
> 		   "%s version: %s %s\n"
> 		   "Gadget driver: %s\n"
> 		   "Host %s, %s\n"
> 		   "\n",
> 		   pci_name(dev->pdev), driver_desc,
> 		   driver_name, DRIVER_VERSION, dmastr(),
> 		   dev->driver ? dev->driver->driver.name : "(none)",
> 		   is_usb_connected
> 			   ? ((tmp & PW_PULLUP) ? "full speed" : "powered")
> 			   : "disconnected",
> 		   udc_ep_state(dev->ep0state));
>
> On the other hand, where could dev->drivre be reset without resetting dev->int_enable?
>
> dev->driver = NULL appears here:
>
> static int goku_udc_stop(struct usb_gadget *g)
> {
> 	struct goku_udc	*dev = to_goku_udc(g);
> 	unsigned long	flags;
>
> 	spin_lock_irqsave(&dev->lock, flags);
> 	dev->driver = NULL;
> 	stop_activity(dev);
> 	spin_unlock_irqrestore(&dev->lock, flags);
>
> 	return 0;
> }
>
> it is followed by stop_activity() calling udc_reset():
>
> static void udc_reset(struct goku_udc *dev)
> {
> 	struct goku_udc_regs __iomem	*regs = dev->regs;
>
> 	writel(0, &regs->power_detect);
> 	writel(0, &regs->int_enable);
> 	readl(&regs->int_enable);
> 	dev->int_enable = 0;
> .
> .
> .
>
> ... but this happens in between spin_lock_irqsave() and spin_unlock_irqsave(),
> which appears like a correct way to do it.

Are you sure that spin_lock_irqsave makes the code safe? This function 
disables interrupts on

local processor only (Linux Device Drivers, Third Edition). So it 
doesn't seem to be

absolutely safe on multiprocessor systems.

> But second appearance is here:
>
> https://elixir.bootlin.com/linux/latest/source/drivers/usb/gadget/udc/goku_udc.c#L1559
>
> 	spin_lock(&dev->lock);
>
> rescan:
> 	stat = readl(&regs->int_status) & dev->int_enable;
>          if (!stat)
> 		goto done;
> 	dev->irqs++;
>
> 	/* device-wide irqs */
> 	if (unlikely(stat & INT_DEVWIDE)) {
> 		if (stat & INT_SYSERROR) {
> 			ERROR(dev, "system error\n");
> 			stop_activity(dev);
> 			stat = 0;
> 			handled = 1;
> 			// FIXME have a neater way to prevent re-enumeration
> 			dev->driver = NULL;
> 			goto done;
> 		}
>
> goto done leads to:
>
> done:
> 	(void)readl(&regs->int_enable);
> 	spin_unlock(&dev->lock);
>
> This unlocks dev->lock before setting dev->int_enable to zero, or calling writel(0, &regs->int_enable);
> which could be problematic. Unless it called stop_activity(dev) four lines earlier. Which does
> bot of:
>
> 	writel(0, &regs->int_enable);
> 	dev->int_enable = 0;
>
> So, FWIW, we seem to be safe. Yet, there might be no harm in printing "(null)" rather
> than having an NULL pointer dereference, it seems.
>
> Yet, there is another unprotected dereference of dev->driver:
>
> https://elixir.bootlin.com/linux/latest/source/drivers/usb/gadget/udc/goku_udc.c#L1513
>
> 	spin_unlock (&dev->lock);
> 	tmp = dev->driver->setup(&dev->gadget, &ctrl);
> 	spin_lock (&dev->lock);
>
> All others (in goku_udc.c, at least) have triple safeguards like:
>
> 				if (dev->gadget.speed != USB_SPEED_UNKNOWN
> 						&& dev->driver
> 						&& dev->driver->suspend) {
> 					spin_unlock(&dev->lock);
> 					dev->driver->suspend(&dev->gadget);
> 					spin_lock(&dev->lock);
> 				}
>
> So the above should maybe put to:
>
> 	if (dev->driver && dev->driver->setup) {
> 		spin_unlock (&dev->lock);
> 		tmp = dev->driver->setup(&dev->gadget, &ctrl);
> 		spin_lock (&dev->lock);
> 	}
>
> instead to be completely certain.
>
> Forgive me for this uninspired rant. Thank you if you've read this far.
> I hope this helps.
>
> My $0.02.
>
> Regards,
> Mirsad
>
Thanks,

Anastasia

