Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2666FE737
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbjEJW3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjEJW3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:29:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA65270D
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 15:29:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683757776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G4+R8dMvIyuoK02YFIulI54RDYg/cgLbHTumpMAvjRk=;
        b=eN3OObK5M5DrgQpf7pdgfeJmZOzGFpkXsTuLyukBmPDJdRCI4hF7m6arUX2fjrDCTvCQqT
        T2M13aDeE8sqFJ2PwWvz/XwytlTv0Y9efrUAFs6er6XTAxoAdtN6VsGxBAyggc7eaNUKo1
        KPS7UeD+f746yBWwOvHl6Y5RXNlvSALLm1UGYfY6ekGPrrAroyF7KkUYu7GnyHpPWmOfVG
        DSgWYddJjIvHosEy126vb8cF/LrQMOaqlaWylYd52+fxjZ1mXsAz+nV28ILxpRm4RyN2tt
        2F/RegG0c6vaOy3GndH0O9Fw4jQ6g55lpz0Z1xU4Ba92dml831epu4p4fCZzxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683757776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G4+R8dMvIyuoK02YFIulI54RDYg/cgLbHTumpMAvjRk=;
        b=hcf6qzpS838SyqW8asEbp/DdKAP24NyBA9LrWz3dlpDnOfv+e9qcO6/2PfB4ssAn00kq2L
        lVLQCBaFk8rdtIBw==
To:     Nipun Gupta <nipun.gupta@amd.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "maz@kernel.org" <maz@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "git (AMD-Xilinx)" <git@amd.com>,
        "Anand, Harpreet" <harpreet.anand@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gangurde, Abhijit" <abhijit.gangurde@amd.com>,
        "Cascon, Pablo" <pablo.cascon@amd.com>
Subject: Re: [PATCH] cdx: add MSI support for CDX bus
In-Reply-To: <6dd142f8-5a8e-b62c-c629-a3a5859e73b3@amd.com>
References: <20230508140950.12717-1-nipun.gupta@amd.com>
 <874jom2ash.ffs@tglx>
 <CH3PR12MB83081FC5F89386EA9C54B4A7E8769@CH3PR12MB8308.namprd12.prod.outlook.com>
 <87bkityxk3.ffs@tglx> <6dd142f8-5a8e-b62c-c629-a3a5859e73b3@amd.com>
Date:   Thu, 11 May 2023 00:29:35 +0200
Message-ID: <87ednnes6o.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nipun!

On Wed, May 10 2023 at 19:34, Nipun Gupta wrote:
> On 5/10/2023 3:31 AM, Thomas Gleixner wrote:
>> I'm not insisting on that, but you could at least have had the courtesy
>> of responding to my review reply and explain to me why you want to solve
>> it differently and why my suggestion is not the right solution.
>> 
>> Alternatively you could have added that information in the changelog or
>> cover letter.
>> 
>> So in summary you ignored _all_ review comments I made, went off and did
>> something different and provided a slightly different useless changelog
>> with the extra add on of a broken Signed-off-by chain.
>> 
>> Feel free to ignore my reviews and the documentation which we put out
>> there to make collaboration feasible for both sides, but please don't be
>> upset when I ignore you and your patches in return.
>
> Sincere apology for not responding to the earlier comments. Intention 
> was never to ignore the review comments. Appreciate your vast changes 
> regarding the MSI, and the patch series you shared took time to 
> understand (provided other things as well), and it was quite late to 
> reply. I understand that even in this case atleast I should have added 
> this as part of the cover-letter.

Fair enough. All settled.

> IMHO, use-case for MSI in CDX subsystem is a bit different from per 
> device MSI domain. Here we are trying to create a domain per CDX 
> controller which is attached to a MSI controller, and all devices on a 
> particular CDX controller will have same mechanism of write MSI
> message.

That was exactly the same assumption which PCI/MSI and other MSI
implementations made. It turned out to be the wrong abstraction.

CDX is not any different than PCI. The actual "interrupt chip" is not
part of the bus, it's part of the device and pretending that it is a bus
specific thing is just running in to the same cul-de-sac sooner than
later.

> Also, the current CDX controller that we have added has a different 
> mechanism for MSI prepare (it gets requester ID from firmware).

That's not an argument, that's just an implementation detail.

> In your opinion is there any advantage in moving to a per device domain 
> for CDX devices? We can definitely rethink the implementation of MSI in 
> CDX subsystem.

See above.

While talking about implementation and design. I actually got curious
and looked at CDX because I was amazed about the gazillion indirections
in that msi_write_msg() callback.

So this ends up doing:

   cdx->ops->dev_configure(cdx, ...)
     cdx_configure_device()
       cdx_mcdi_write_msi()
         cdx_mcdi_rpc_async()
           kmalloc()                            <- FAIL #1
           cdx_mcdi_rpc_async_internal()
              queue_work()                      <- FAIL #2

#1) That kmalloc() uses GFP_ATOMIC, but this is invoked deep in the guts
    of interrupt handling with locks held and interrupts disabled.

    Aside of the fact that this breaks on PREEMPT_RT, such allocations
    are generally frowned upon. As a consequence the kref_put()s in the
    error paths of cdx_mcdi_rpc_async_internal() will blow up on RT
    too.

    I know that Xilinx stated publicly that they don't support RT, but
    RT is not that far out to be supported in mainline and aside of that
    I know for sure that quite a lot of Xilinx customers use PREEMPT_RT
    nevertheless.

#2) That's actually the worse part of it and completely broken versus
    device setup

    probe()
      cdx_msi_domain_alloc_irqs()
      ...
      request_irq() {
        ...
        irq_activate()
          irq_chip_write_msi_msg()
            ...
            queue_work()
          ...
      }

      enable_irq_in_device()
      
        <- device raises interrupt and eventually uses an uninitialized
           MSI message because the scheduled work has not yet completed.

    That's going to be a nightmare to debug and it's going to happen
    once in a blue moon out in the field.

The interrupt subsystem already can handle update mechanisms which
require sleepable context:

   irq_bus_lock() and irq_bus_sync_unlock() irqchip callbacks

They were initially implemented to deal with interrupt chips which are
configured via I2C, SPI etc. 

How does that work?

On entry to interrupt management functions the sequence is:

    if (desc->irq_data.chip->irq_bus_lock)
       desc->irq_data.chip->irq_bus_lock(...)
    raw_spin_lock_irq(&desc->lock);

and on exit:

    raw_spin_unlock_irq(&desc->lock);
    if (desc->irq_data.chip->irq_bus_sync_unlock)
       desc->irq_data.chip->irq_bus_sync_unlock(...)

irq_bus_lock() usually just acquires a mutex.

The other irqchip callbacks just cache the relevant information, but do
not execute the bus transaction because that is not possible with
desc->lock held.

In the irq_bus_sync_unlock() they execute the bus transaction with the
cached information before dropping the mutex.

So you can solve #1 and #2 with that. Your msi_write_msg() callback will
just save the message and set some internal flag that it needs to be
written out in the irq_bus_sync_unlock() callback.

See?

IIRC, there is a gap vs. interrupt affinity setting from user space,
which is irrelevant for I2C, SPI etc. configured interrupt chips as they
raise interrupt via an SoC interrupt pin and that's the entity which
does the affinity management w/o requiring I2C/SPI. IIRC I posted a
patch snippet to that effect in one of those lengthy PCI/MSI/IMS threads
because that is also required for MSI storage which happens to be in
queue memory and needs to be synchronized via some command channel. But
I can't be bothered to search for it as it's a no-brainer to fix that
up.

Thanks,

        tglx
