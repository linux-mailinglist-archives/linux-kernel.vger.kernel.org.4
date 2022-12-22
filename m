Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC31F653E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbiLVKaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbiLVKaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:30:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A40D1FCF7;
        Thu, 22 Dec 2022 02:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671705019; x=1703241019;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Rbzof44+EtrdYScW9KjRxHkIGR0ZtgJFbtkIuoytGKc=;
  b=PoCwBwtcO185hqvPbW60HJsWuCiNCRYw6jsg4jgsQwCXwyO4WKkv0yXk
   nHuKA0137PU0bpOZV0+bFWC9W9kFl3c2oLWgyzcRVUs3mHUQ8WHbGqAv/
   xuk2Ufxkwi9vgaV7o9SUrI7RVgIFJ4u9IWmnGtxRg6W27JmxXZ+rxPrRb
   DaLNmarThN4xZoUh2Kw/lZcLJY0SyzZGP+NPyTLZbzAZs5trk7VcntPbd
   ++ADwBIOZfacrPbRLOISvdPPAMP1yQcRUt2TjVGg2mmA4DhIcBD5Hac4S
   +vjCOgXFCre89gFvbmmasQPxENs2B98AzdKwhHyI8qZkE9jWcVM9WRWE4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="347239118"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="347239118"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 02:30:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="720268696"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="720268696"
Received: from lardelea-mobl1.ger.corp.intel.com ([10.251.219.104])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 02:30:16 -0800
Date:   Thu, 22 Dec 2022 12:30:14 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Richard Leitner <richard.leitner@linux.dev>
cc:     "David R. Piegdon" <lkml@p23q.org>, linux-tegra@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial8250 on tegra hsuart: recover from spurious
 interrupts due to tegra2 silicon bug
In-Reply-To: <Y3tUWPCVnauLeuG2@skidata.com>
Message-ID: <e48e8030-f15e-fe5b-84b7-44406937e51@linux.intel.com>
References: <4676ea34-69ce-5422-1ded-94218b89f7d9@p23q.org> <Y3tUWPCVnauLeuG2@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022, Richard Leitner wrote:

> Hi,
> 
> On Fri, Jul 13, 2018 at 11:32:42AM +0000, David R. Piegdon wrote:
> > Hi,
> > a while back I sent a few mails regarding spurious interrupts in the
> > UARTA (hsuart) block of the Tegra2 SoC, when using the 8250 driver for
> > it instead of the hsuart driver. After going down a pretty deep
> > debugging/testing hole, I think I found a patch that fixes the issue. So
> > far testing in a reboot-cycle suggests that the error frequency dropped
> > from >3% of all reboots to at least <0.05% of all reboots. Tests
> > continue to run over the weekend.
> > 
> > The patch below already is a second iteration; the first did not reset
> > the MCR or contain the lines below '// clear interrupts'. This resulted
> > in no more spurious interrupts, but in a few % of spurious interrupts
> > that were recovered the UART block did not receive any characters any
> > more. So further resetting was required to fully reacquire operational
> > state of the UART block.
> > 
> > I'd love any comments/suggestions on this!
> 
> I'd like to follow up on this ancient patch as we are using it
> successfully for a few years with different kernel versions on a
> tegra20 SOM (tamonten) now and I'm currently cleaning up our tree.
> 
> David, have you done any work in regarding this issue since 2018?
> 
> What would be needed to get this solution mainline?

It seems that the code would belong to ->handle_irq() rather than 
8250_core. Do the affected device belong under 8250_tegra.c? If they do, 
then just create .handle_irq for it and detect this condition there after 
call to serial8250_handle_irq().

> The recipient of this mail are from the initial thread [1] and
> a current get_maintainers.pl run.
> 
> regards;rl
> 
> [1] https://patchwork.ozlabs.org/project/linux-tegra/patch/4676ea34-69ce-5422-1ded-94218b89f7d9@p23q.org/
> 
> > 
> > Cheers,
> > 
> > David
> > 
> > diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> > index e8819aa20415..1d76eebefd4e 100644
> > --- a/drivers/tty/serial/8250/8250_core.c
> > +++ b/drivers/tty/serial/8250/8250_core.c
> > @@ -140,6 +140,38 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
> >  				"serial8250: too much work for irq%d\n", irq);
> >  			break;
> >  		}
> > +
> > +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
> > +		if (!handled && (port->type == PORT_TEGRA)) {
> > +			/*
> > +			 * Fix Tegra 2 CPU silicon bug where sometimes
> > +			 * "TX holding register empty" interrupts result in a
> > +			 * bad (metastable?) state in Tegras HSUART IP core.
> > +			 * Only way to recover seems to be to reset all
> > +			 * interrupts as well as the TX queue and the MCR.
> > +			 * But we don't want to loose any outgoing characters,
> > +			 * so only do it if the RX and TX queues are empty.
> > +			 */
> > +			unsigned char lsr = port->serial_in(port, UART_LSR);

serial_lsr_in(), make sure you take the port's lock btw.

> > +			const unsigned char fifo_empty_mask =
> > +						(UART_LSR_TEMT | UART_LSR_THRE);
> > +			if (((lsr & (UART_LSR_DR | fifo_empty_mask)) ==
> > +							fifo_empty_mask)) {

uart_lsr_tx_empty(lsr) && !(lsr & UART_LSR_DR)

fifo_empty_mask can be dropped.

-- 
 i.

> > +				port->serial_out(port, UART_IER, 0);
> > +				port->serial_out(port, UART_MCR, 0);
> > +				serial8250_clear_and_reinit_fifos(up);
> > +				port->serial_out(port, UART_MCR, up->mcr);
> > +				port->serial_out(port, UART_IER, up->ier);
> > +				// clear interrupts
> > +				serial_port_in(port, UART_LSR);
> > +				serial_port_in(port, UART_RX);
> > +				serial_port_in(port, UART_IIR);
> > +				serial_port_in(port, UART_MSR);
> > +				up->lsr_saved_flags = 0;
> > +				up->msr_saved_flags = 0;
> > +			}
> > +		}
> > +#endif
> >  	} while (l != end);
> >  
> >  	spin_unlock(&i->lock);
> 

