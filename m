Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8819D6D2228
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjCaOOh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 10:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCaOOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:14:35 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6F52139;
        Fri, 31 Mar 2023 07:14:32 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 6CC71186318C;
        Fri, 31 Mar 2023 17:07:43 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id giJl_N6rEoas; Fri, 31 Mar 2023 17:07:41 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 54B59186440C;
        Fri, 31 Mar 2023 17:07:41 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3PFwfdpaitgx; Fri, 31 Mar 2023 17:07:41 +0300 (MSK)
Received: from [10.177.20.58] (unknown [10.177.20.58])
        by mail.astralinux.ru (Postfix) with ESMTPSA id B66B7186318C;
        Fri, 31 Mar 2023 17:07:40 +0300 (MSK)
Message-ID: <bdb41225-b8b0-5202-9457-4c2f465c3cd0@astralinux.ru>
Date:   Fri, 31 Mar 2023 17:07:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] goku_udc: Add check for NULL in goku_irq
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230203101828.14799-1-abelova@astralinux.ru>
 <Y9zly1vrj9z4c1qT@kroah.com>
 <39993564-7310-a2e0-8139-14ccb9a03ba9@astralinux.ru>
 <Y+zivah57216KcuB@kroah.com>
 <a5f90434-f3e5-f25e-76e2-b03e79cc16fe@alu.unizg.hr>
 <ddfab307-d471-ee08-6804-5f903adb1770@astralinux.ru>
 <2681bc20-28a4-341f-5d01-0db4b356ac8e@alu.unizg.hr>
 <a390e831-49af-5c8e-7df3-87612269a83f@astralinux.ru>
 <1751abe2-0195-5c07-a037-6232a6a5b3ee@alu.unizg.hr>
Content-Language: en-US
From:   Anastasia Belova <abelova@astralinux.ru>
In-Reply-To: <1751abe2-0195-5c07-a037-6232a6a5b3ee@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


15.03.2023 19:26, Mirsad Goran Todorovac пишет:
> On 15.3.2023. 15:26, Anastasia Belova wrote:
>>
>> 13.03.2023 16:49, Mirsad Goran Todorovac пишет:
>>> On 13.3.2023. 13:19, Anastasia Belova wrote:
>>>>
>>>> 11.03.2023 06:29, Mirsad Goran Todorovac пишет:
>>>>> On 15. 02. 2023. 14:48, Greg Kroah-Hartman wrote:
>>>>>> On Wed, Feb 15, 2023 at 04:39:56PM +0300, Анастасия Белова wrote:
>>>>>>> 03.02.2023 13:45, Greg Kroah-Hartman пишет:
>>>>>>>> On Fri, Feb 03, 2023 at 01:18:28PM +0300, Anastasia Belova wrote:
>>>>>>>>> Before dereferencing dev->driver check it for NULL.
>>>>>>>>>
>>>>>>>>> If an interrupt handler is called after assigning
>>>>>>>>> NULL to dev->driver, but before resetting dev->int_enable,
>>>>>>>>> NULL-pointer will be dereferenced.
>>>>>>>>>
>>>>>>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>>>>>>>
>>>>>>>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>>>>>>>> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>>>>>>>>> ---
>>>>>>>>>    drivers/usb/gadget/udc/goku_udc.c | 5 +++--
>>>>>>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/usb/gadget/udc/goku_udc.c 
>>>>>>>>> b/drivers/usb/gadget/udc/goku_udc.c
>>>>>>>>> index bdc56b24b5c9..896bba8b47f1 100644
>>>>>>>>> --- a/drivers/usb/gadget/udc/goku_udc.c
>>>>>>>>> +++ b/drivers/usb/gadget/udc/goku_udc.c
>>>>>>>>> @@ -1616,8 +1616,9 @@ static irqreturn_t goku_irq(int irq, 
>>>>>>>>> void *_dev)
>>>>>>>>>    pm_next:
>>>>>>>>>            if (stat & INT_USBRESET) { /* hub reset done */
>>>>>>>>>                ACK(INT_USBRESET);
>>>>>>>>> -            INFO(dev, "USB reset done, gadget %s\n",
>>>>>>>>> -                dev->driver->driver.name);
>>>>>>>>> +            if (dev->driver)
>>>>>>>>> +                INFO(dev, "USB reset done, gadget %s\n",
>>>>>>>>> + dev->driver->driver.name);
>>>>>>>> How can this ever happen?  Can you trigger this somehow?  If 
>>>>>>>> not, I
>>>>>>>> don't think this is going to be possible (also what's up with 
>>>>>>>> printk
>>>>>>>> from an irq handler???)
>>>>>>> Unfortunately, I can't find the way to trigger this at the moment.
>>>>>> Then the change should not be made.
>>>>>>
>>>>>>> What about printk, should trace_printk be used instead?
>>>>>> Why?
>>>>>>
>>>>>>>> Odds are, no one actually has this hardware anymore, right?
>>>>>>> Despite of this, such vulnerability should be fixed because
>>>>>>> there is a possibility to exploit it.
>>>>>> How can this be "exploited" if it can not ever be triggered?
>>>>>>
>>>>>> Also, this would cause a NULL dereference in an irq handler, how 
>>>>>> can you
>>>>>> "exploit" that?
>>>>>>
>>>>>> Please only submit patches that actually do something. It is getting
>>>>>> very hard to want to even review patches from this "project" 
>>>>>> based on
>>>>>> the recent submissions.
>>>>>>
>>>>>> thanks,
>>>>>>
>>>>>> greg k-h
>>>>> Hi Greg, Anastasia,
>>>>
>>>> Hi Misrad,
>>>>
>>>>> Without any pros or cons, or taking sides, there appears to be a 
>>>>> similar check
>>>>> when using dev->driver->driver.name in
>>>>>
>>>>> https://elixir.bootlin.com/linux/latest/source/drivers/usb/gadget/udc/goku_udc.c#L1158 
>>>>>
>>>>>
>>>>>     seq_printf(m,
>>>>>            "%s - %s\n"
>>>>>            "%s version: %s %s\n"
>>>>>            "Gadget driver: %s\n"
>>>>>            "Host %s, %s\n"
>>>>>            "\n",
>>>>>            pci_name(dev->pdev), driver_desc,
>>>>>            driver_name, DRIVER_VERSION, dmastr(),
>>>>>            dev->driver ? dev->driver->driver.name : "(none)",
>>>>>            is_usb_connected
>>>>>                ? ((tmp & PW_PULLUP) ? "full speed" : "powered")
>>>>>                : "disconnected",
>>>>>            udc_ep_state(dev->ep0state));
>>>>>
>>>>> On the other hand, where could dev->drivre be reset without 
>>>>> resetting dev->int_enable?
>>>>>
>>>>> dev->driver = NULL appears here:
>>>>>
>>>>> static int goku_udc_stop(struct usb_gadget *g)
>>>>> {
>>>>>     struct goku_udc    *dev = to_goku_udc(g);
>>>>>     unsigned long    flags;
>>>>>
>>>>>     spin_lock_irqsave(&dev->lock, flags);
>>>>>     dev->driver = NULL;
>>>>>     stop_activity(dev);
>>>>>     spin_unlock_irqrestore(&dev->lock, flags);
>>>>>
>>>>>     return 0;
>>>>> }
>>>>>
>>>>> it is followed by stop_activity() calling udc_reset():
>>>>>
>>>>> static void udc_reset(struct goku_udc *dev)
>>>>> {
>>>>>     struct goku_udc_regs __iomem    *regs = dev->regs;
>>>>>
>>>>>     writel(0, &regs->power_detect);
>>>>>     writel(0, &regs->int_enable);
>>>>>     readl(&regs->int_enable);
>>>>>     dev->int_enable = 0;
>>>>> .
>>>>> .
>>>>> .
>>>>>
>>>>> ... but this happens in between spin_lock_irqsave() and 
>>>>> spin_unlock_irqsave(),
>>>>> which appears like a correct way to do it.
>>>>
>>>> Are you sure that spin_lock_irqsave makes the code safe? This 
>>>> function disables interrupts on
>>>> local processor only (Linux Device Drivers, Third Edition). So it 
>>>> doesn't seem to be
>>>> absolutely safe on multiprocessor systems.
>>>
>>> Hi, Anastasia,
>>>
>>> Looking from the Second Edition or the book and the source, I see that
>>> spin_lock_irqsave() expands to:
>>>
>>> static inline unsigned long __raw_spin_lock_irqsave(raw_spinlock_t 
>>> *lock)
>>> {
>>>     unsigned long flags;
>>>
>>>     local_irq_save(flags);
>>>     preempt_disable();
>>>     spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
>>>     LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
>>>     return flags;
>>> }
>>>
>>> if the multiple threads on multiple cores/SMTs contend for the same 
>>> lock,
>>> that with preempt_disable() should assure mutual exclusion.
>>>
>>> Can you please quote from the Third Edition of Linux Device Drivers 
>>> where
>>> it says otherwise?
>>>
>>
>> Hi, Mirsad,
>>
>>
>> If I get it right, preempt_disable blocks interrupts on all processors,
>> correct? This statement seems to make the code safe, but there is a 
>> quote
>> from Linux Device Drivers, Third Edition, CHAPTER 5, Concurrency and 
>> Race
>> Conditions: "...spin_lock_irqsave disables interrupts (on the local 
>> processor
>> only) before taking the spinlock...". These thoughts contradict, 
>> don't they?
>
> Hi, Anastasia,
>
> To quote the book:
>
> https://static.lwn.net/images/pdf/LDD3/ch05.pdf page 119:
>
> > We have already seen how spin_lock works. spin_lock_irqsave disables 
> interrupts (on
> > the local processor only) before taking the spinlock; the previous 
> interrupt state is
> > stored in flags.
>
> This is consistent with the source. To repeat, spin_lock_irqsave() 
> eventually
> expands to:
>
> https://elixir.bootlin.com/linux/v6.3-rc2/source/include/linux/spinlock_api_smp.h#L97 
>
>
> static inline unsigned long __raw_spin_lock_irqsave(raw_spinlock_t *lock)
> {
>     unsigned long flags;
>
>     local_irq_save(flags);
>     preempt_disable();
>     spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
>     LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
>     return flags;
> }
>
> preempt_disable() disables interrupt only on local CPU, but this is 
> necessary
> so IRQ wouldn't attempt another asynchronous lock attempt on the lock 
> currently being
> acquired, which would of course block forever this CPU, core or SMT.
>
> The magic is in LOCK_CONTENTED, which eventually atomically sets a 
> global semaphore
> and executes a barrier() call, to ensure no compiler optimisation 
> would mess with that
> before all writes are synchronised to RAM.
>
> Additional info on barrier() is here:
>
> https://elixir.bootlin.com/linux/v6.3-rc2/source/include/linux/compiler.h#L83 
>
>
> This guarantees that the next read from the same or another CPU, core 
> or SMT will
> see lock (synchronised and "taken"), so the mutual exclusion between 
> the cores is
> OK. NOTE: the lock must be global, not local to thread for this to work.
>
> So, the key is to go to the Source ;-)
>
Hi, Mirsad,


Thank you so much for our discussion. This case is clearer for me now.


Best regards,

Anastasia

> This of course doesn't invalidate driver hardening against 
> "impossible" situations.
> In userland, assert() is good for this, but it is impractical for 
> kernel to die on
> each bug. Rather log the bug or oops?
>
> Best regards,
> Mirsad
>
>>> BTW, please also consider reading this article:
>>>
>>> https://docs.kernel.org/driver-api/io_ordering.html
>>>
>>> I saw they were using this readl() after writel() for 
>>> synchronisation, so
>>> please see if this clears your doubts. It says "readl() should flush 
>>> any pending
>>> writes".
>>>
>>> But I certainly see no harm in your proposal of guarding against 
>>> NULL pointer
>>> dereference of dev->driver, both in
>>>
>>> > -            INFO(dev, "USB reset done, gadget %s\n",
>>> > -                dev->driver->driver.name);
>>> > +            if (dev->driver)
>>> > +                INFO(dev, "USB reset done, gadget %s\n",
>>> > +                    dev->driver->driver.name);
>>>
>>> or use the construct as the one in another line of the driver:
>>>
>>> > -            INFO(dev, "USB reset done, gadget %s\n",
>>> > -                dev->driver->driver.name);
>>> > +            INFO(dev, "USB reset done, gadget %s\n",
>>> > +                dev->driver ? dev->driver->driver.name : "(none)");
>>>
>>> (This would IMHO enable detecting and logging when dev->driver 
>>> unexpectedly becomes NULL
>>> in a race condition, rather that just silently skipping and ignoring 
>>> the situation.)
>>>
>> Agree, the second construct looks better.
>>> but additionally also in:
>>>
>>> > -     spin_unlock (&dev->lock);
>>> > -     tmp = dev->driver->setup(&dev->gadget, &ctrl);
>>> > -     spin_lock (&dev->lock);
>>> > +     if (dev->driver && dev->driver->setup) {
>>> > +         spin_unlock (&dev->lock);
>>> > +         tmp = dev->driver->setup(&dev->gadget, &ctrl);
>>> > +         spin_lock (&dev->lock);
>>> > +     }
>>>
>>> for completeness and robustness sake.
>>>
>>> The author agrees that the race conditions in the device drivers are 
>>> very hard
>>> to reproduce:
>>>
>>> https://www.oreilly.com/library/view/linux-device-drivers/0596000081/ch09s08.html 
>>>
>>>
>>> But I am really not able to analyse all possible scenarios ATM.
>>> Maybe some ideas come after getting some oxygen.
>>>
>>> (This is not an authoritative answer on the matter, just an attempt 
>>> on analysis.)
>>>
>>> Regards,
>>> Mirsad
>>>
>> Regards,
>>
>> Anastasia
>>
>>>>> But second appearance is here:
>>>>>
>>>>> https://elixir.bootlin.com/linux/latest/source/drivers/usb/gadget/udc/goku_udc.c#L1559 
>>>>>
>>>>>
>>>>>     spin_lock(&dev->lock);
>>>>>
>>>>> rescan:
>>>>>     stat = readl(&regs->int_status) & dev->int_enable;
>>>>>          if (!stat)
>>>>>         goto done;
>>>>>     dev->irqs++;
>>>>>
>>>>>     /* device-wide irqs */
>>>>>     if (unlikely(stat & INT_DEVWIDE)) {
>>>>>         if (stat & INT_SYSERROR) {
>>>>>             ERROR(dev, "system error\n");
>>>>>             stop_activity(dev);
>>>>>             stat = 0;
>>>>>             handled = 1;
>>>>>             // FIXME have a neater way to prevent re-enumeration
>>>>>             dev->driver = NULL;
>>>>>             goto done;
>>>>>         }
>>>>>
>>>>> goto done leads to:
>>>>>
>>>>> done:
>>>>>     (void)readl(&regs->int_enable);
>>>>>     spin_unlock(&dev->lock);
>>>>>
>>>>> This unlocks dev->lock before setting dev->int_enable to zero, or 
>>>>> calling writel(0, &regs->int_enable);
>>>>> which could be problematic. Unless it called stop_activity(dev) 
>>>>> four lines earlier. Which does
>>>>> bot of:
>>>>>
>>>>>     writel(0, &regs->int_enable);
>>>>>     dev->int_enable = 0;
>>>>>
>>>>> So, FWIW, we seem to be safe. Yet, there might be no harm in 
>>>>> printing "(null)" rather
>>>>> than having an NULL pointer dereference, it seems.
>>>>>
>>>>> Yet, there is another unprotected dereference of dev->driver:
>>>>>
>>>>> https://elixir.bootlin.com/linux/latest/source/drivers/usb/gadget/udc/goku_udc.c#L1513 
>>>>>
>>>>>
>>>>>     spin_unlock (&dev->lock);
>>>>>     tmp = dev->driver->setup(&dev->gadget, &ctrl);
>>>>>     spin_lock (&dev->lock);
>>>>>
>>>>> All others (in goku_udc.c, at least) have triple safeguards like:
>>>>>
>>>>>                 if (dev->gadget.speed != USB_SPEED_UNKNOWN
>>>>>                         && dev->driver
>>>>>                         && dev->driver->suspend) {
>>>>>                     spin_unlock(&dev->lock);
>>>>> dev->driver->suspend(&dev->gadget);
>>>>>                     spin_lock(&dev->lock);
>>>>>                 }
>>>>>
>>>>> So the above should maybe put to:
>>>>>
>>>>>     if (dev->driver && dev->driver->setup) {
>>>>>         spin_unlock (&dev->lock);
>>>>>         tmp = dev->driver->setup(&dev->gadget, &ctrl);
>>>>>         spin_lock (&dev->lock);
>>>>>     }
>>>>>
>>>>> instead to be completely certain.
>>>>>
>>>>> Forgive me for this uninspired rant. Thank you if you've read this 
>>>>> far.
>>>>> I hope this helps.
>>>>>
>>>>> My $0.02.
>>>>>
>>>>> Regards,
>>>>> Mirsad
>>>>>
>>>> Thanks,
>>>>
>>>> Anastasia
>>>
>
