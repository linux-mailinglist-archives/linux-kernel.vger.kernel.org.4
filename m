Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F88665A4C2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 15:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbiLaOPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 09:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiLaOPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 09:15:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDD7B844;
        Sat, 31 Dec 2022 06:15:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46412B801BF;
        Sat, 31 Dec 2022 14:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008DCC433EF;
        Sat, 31 Dec 2022 14:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672496113;
        bh=h2/AMQSNOj80xrFQ6+8un+Bo7gd2P8yybtkdCeT7848=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Py0YBznZOc2LPlDDco5UBOWtiaSvJcDgkw6bzubmkNt/8A/NWoRWUcuwr1nZWw2UR
         todf5Hnmh7MeN0DoyjAv1JMlcvwvTDvg5iGMfLcaUpXt7KKYyoH230y5N0AV+Qj3Dp
         n/YGq4ErbncEHQxbHOBl4LpEZy+OjPa6veje2lTfVReZO0f9q1JfYDbcH8CC25kpIB
         2UZuXHUBjyROZs7kF6vS2y4l8Q3SnBQy4PVmM5tgDbxA3YU+l8EszCTfpw12QItNmT
         RBpekvaN2iQI9X8SQEiDKc26blWhN8ZC5D5/PoA2JEggYoiYW4mTE7XB02j7rfPpVb
         bsHoDPQRYxi2Q==
Date:   Sat, 31 Dec 2022 14:28:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Beer <dlbeer@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ad_sigma_delta: fix race between IRQ and completion
Message-ID: <20221231142832.49cb47c7@jic23-huawei>
In-Reply-To: <20221224023158.GA254443@nyquist.nev>
References: <63a01acb.a70a0220.9a08f.987d@mx.google.com>
        <20221223161659.7652c95c@jic23-huawei>
        <20221224023158.GA254443@nyquist.nev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Dec 2022 15:31:58 +1300
Daniel Beer <dlbeer@gmail.com> wrote:

> On Fri, Dec 23, 2022 at 04:16:59PM +0000, Jonathan Cameron wrote:
> > > ad_sigma_delta waits for a conversion which terminates with the firing
> > > of a one-shot IRQ handler. In this handler, the interrupt is disabled
> > > and a completion is set.
> > > 
> > > Meanwhile, the thread that initiated the conversion is waiting on the
> > > completion to know when the conversion happened. If this wait times out,
> > > the conversion is aborted and IRQs are disabled. But the IRQ may fire
> > > anyway between the time the completion wait times out and the disabling
> > > of interrupts. If this occurs, we get a double-disabled interrupt.  
> > 
> > Ouch and good work tracking it down.  just to check, did you see this
> > bug happen in the wild or spotted by code inspection?  
> 
> Hi Jonathan,
> 
> Thanks for reviewing. It was by inspection -- I'd originally thought
> about it and fixed in in a similar way in this patch:
> 
>     https://lore.kernel.org/all/61dd3e0c.1c69fb81.cea15.8d98@mx.google.com/
> 
> But since that's not applied, I thought I'd better put together a
> separate fix for the time being.
> 
> > Given that timeout generally indicates hardware failure, I'm not sure
> > how critical this is to fix.  
> 
> Probably not very critical. I think you'd have to be pretty unlucky to
> encounter it.
> 
> > Is this fix sufficient?  If the interrupt is being handled on a different
> > CPU to the caller of this function, I think we can still race enough that
> > this fails to fix it up.  Might need a spinlock to prevent that.
> > 
> >   CPU 0                                        CPU 1
> > ad_sd_data_rdy_trig_poll()               ad_sd_wait_and_disable()
> >                                        
> >                                          //wait_for_completion ends
> > 					
> > Interrupt
> >                                           disable_irq()
> > 					  if (sigma-delta->irq_dis) !true	
> > 					  else
> > 						sigma_delta->irq_dis = true
> > 
> > disable_irq_nosync(irq)
> > sigma_delta->irq_dis = true;
> > 
> > So we still end up with a doubly disabled irq.  Add a spinlock to make the
> > disable and the setting of sigma_delta->irq_dis atomic then it should all be fine.                  
> 
> My understanding is that the suffix-less version of disable_irq would
> wait for all running handlers on other CPUs (i.e.
> ad_sd_data_rdy_trig_poll) to finish before proceeding, which would
> prevent this from happening. Is that not the case?

Ah. I'd missed that - it is indeed documented as waiting for
pending irq handlers so that race doesn't exist.


> 
> But now that you mention it, there is another small problem: in the case
> where the conversion doesn't time out, the interrupt handler will call
> complete() and then perform some operations on the struct
> ad_sigma_delta.
> 
> This is always ok on a single processor, but if there are multiple CPUs
> there is possibly a brief period where both the interrupt handler and
> the waiting thread are accessing the ad_sigma_delta struct without
> synchronization between them.
> 
> Not sure if that's really a problem in practice, but I think an easy way
> to rule it out would just be to move the complete() call to the bottom
> of the handler and make sure it doesn't touch the structure again after
> that.

Hmm. At first glance, you are correct that moving completion later probably
makes sense. There may be some subtleties in that ordering though so I definitely want
some feedback from those more familiar with this driver than I am before
taking this patch or that further change.

Jonathan


> 
> Cheers,
> Daniel
> 

