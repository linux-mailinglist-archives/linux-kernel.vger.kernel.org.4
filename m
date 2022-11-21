Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789F7631E83
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiKUKfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiKUKfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:35:13 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3C7AFE71;
        Mon, 21 Nov 2022 02:35:08 -0800 (PST)
Date:   Mon, 21 Nov 2022 11:35:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669026906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0NQOBu14uyzB45RriwXl3gZNCccf6P2os1r/foz+LNA=;
        b=I9eLI0KYgDHZURWPfXR5VGa1PsBHdLh+rSuS2KVlbWhV7CFrSZrHzKlDmGmGDejmbFAqLE
        g/FNqR/7fXe/1Ci4b6p+yI81fCUP7ovaykYm5ZuVVZpb0TWYptmBe38bJYNnVcrguB/ZqP
        Tc3w6uFD+OB63egzeIAQaHTqzEht7i0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Richard Leitner <richard.leitner@linux.dev>
To:     "David R. Piegdon" <lkml@p23q.org>
Cc:     linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial8250 on tegra hsuart: recover from spurious
 interrupts due to tegra2 silicon bug
Message-ID: <Y3tUWPCVnauLeuG2@skidata.com>
References: <4676ea34-69ce-5422-1ded-94218b89f7d9@p23q.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4676ea34-69ce-5422-1ded-94218b89f7d9@p23q.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 13, 2018 at 11:32:42AM +0000, David R. Piegdon wrote:
> Hi,
> a while back I sent a few mails regarding spurious interrupts in the
> UARTA (hsuart) block of the Tegra2 SoC, when using the 8250 driver for
> it instead of the hsuart driver. After going down a pretty deep
> debugging/testing hole, I think I found a patch that fixes the issue. So
> far testing in a reboot-cycle suggests that the error frequency dropped
> from >3% of all reboots to at least <0.05% of all reboots. Tests
> continue to run over the weekend.
> 
> The patch below already is a second iteration; the first did not reset
> the MCR or contain the lines below '// clear interrupts'. This resulted
> in no more spurious interrupts, but in a few % of spurious interrupts
> that were recovered the UART block did not receive any characters any
> more. So further resetting was required to fully reacquire operational
> state of the UART block.
> 
> I'd love any comments/suggestions on this!

I'd like to follow up on this ancient patch as we are using it
successfully for a few years with different kernel versions on a
tegra20 SOM (tamonten) now and I'm currently cleaning up our tree.

David, have you done any work in regarding this issue since 2018?

What would be needed to get this solution mainline?

The recipient of this mail are from the initial thread [1] and
a current get_maintainers.pl run.

regards;rl

[1] https://patchwork.ozlabs.org/project/linux-tegra/patch/4676ea34-69ce-5422-1ded-94218b89f7d9@p23q.org/

> 
> Cheers,
> 
> David
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index e8819aa20415..1d76eebefd4e 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -140,6 +140,38 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
>  				"serial8250: too much work for irq%d\n", irq);
>  			break;
>  		}
> +
> +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
> +		if (!handled && (port->type == PORT_TEGRA)) {
> +			/*
> +			 * Fix Tegra 2 CPU silicon bug where sometimes
> +			 * "TX holding register empty" interrupts result in a
> +			 * bad (metastable?) state in Tegras HSUART IP core.
> +			 * Only way to recover seems to be to reset all
> +			 * interrupts as well as the TX queue and the MCR.
> +			 * But we don't want to loose any outgoing characters,
> +			 * so only do it if the RX and TX queues are empty.
> +			 */
> +			unsigned char lsr = port->serial_in(port, UART_LSR);
> +			const unsigned char fifo_empty_mask =
> +						(UART_LSR_TEMT | UART_LSR_THRE);
> +			if (((lsr & (UART_LSR_DR | fifo_empty_mask)) ==
> +							fifo_empty_mask)) {
> +				port->serial_out(port, UART_IER, 0);
> +				port->serial_out(port, UART_MCR, 0);
> +				serial8250_clear_and_reinit_fifos(up);
> +				port->serial_out(port, UART_MCR, up->mcr);
> +				port->serial_out(port, UART_IER, up->ier);
> +				// clear interrupts
> +				serial_port_in(port, UART_LSR);
> +				serial_port_in(port, UART_RX);
> +				serial_port_in(port, UART_IIR);
> +				serial_port_in(port, UART_MSR);
> +				up->lsr_saved_flags = 0;
> +				up->msr_saved_flags = 0;
> +			}
> +		}
> +#endif
>  	} while (l != end);
>  
>  	spin_unlock(&i->lock);
