Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C377C69BEE2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 08:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBSHZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 02:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBSHZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 02:25:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1B8126EE;
        Sat, 18 Feb 2023 23:25:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFFAFB80502;
        Sun, 19 Feb 2023 07:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D899C433EF;
        Sun, 19 Feb 2023 07:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676791536;
        bh=UHkB/VkkzDP++rgVKYzziKUMUsh1FssoYAVkjUOMiho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AmGRlYzbXPiZCY+AbynAKdHgn638dY/y9p53jt3I6a+fv2dnmg7ww7uphOMrX6wKj
         stbdO/qZYlGa1tBnxTv4rZT7lQzCnEm/WiydXq48PhMMIG+nHBlGARMRZUNacehoBk
         n83qkkLNf8C/pSR4qCPfq3fe2tcaAHPcWgzNn0TM=
Date:   Sun, 19 Feb 2023 08:25:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mohammad Mahfooz <mohammadmahfoozpersonal@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: jsm: fix style issues
Message-ID: <Y/HO7LjH67NeCwpR@kroah.com>
References: <20230219055746.15298-1-mohammadmahfoozpersonal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219055746.15298-1-mohammadmahfoozpersonal@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 12:57:44AM -0500, Mohammad Mahfooz wrote:
> Use min_t instead of min to improve type safety.
> 
> While at it, replace neo_parse_modem (hard-coded function name) with __func__.
> 
> Also fix minor styling issues, like removing redundant return statement in void function.
> 
> Signed-off-by: Mohammad Mahfooz <mohammadmahfoozpersonal@gmail.com>
> ---
>  drivers/tty/serial/jsm/jsm_neo.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
> index 0c78f66276cd..d4451fe06d99 100644
> --- a/drivers/tty/serial/jsm/jsm_neo.c
> +++ b/drivers/tty/serial/jsm/jsm_neo.c
> @@ -29,7 +29,7 @@ static u32 jsm_offset_table[8] = { 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x8
>   */
>  static inline void neo_pci_posting_flush(struct jsm_board *bd)
>  {
> -      readb(bd->re_map_membase + 0x8D);
> +     readb(bd->re_map_membase + 0x8D);
>  }
>  
>  static void neo_set_cts_flow_control(struct jsm_channel *ch)
> @@ -350,7 +350,7 @@ static void neo_copy_data_from_uart_to_queue(struct jsm_channel *ch)
>  		 * IBM pSeries platform.
>  		 * 15 bytes max appears to be the magic number.
>  		 */
> -		n = min((u32) n, (u32) 12);
> +		n = min_t(u32, n, 12);
>  
>  		/*
>  		 * Since we are grabbing the linestatus register, which
> @@ -433,7 +433,7 @@ static void neo_copy_data_from_uart_to_queue(struct jsm_channel *ch)
>  		/*
>  		 * If our queue is full, we have no choice but to drop some data.
>  		 * The assumption is that HWFLOW or SWFLOW should have stopped
> -		 * things way way before we got to this point.
> +		 * things way before we got to this point.
>  		 *
>  		 * I decided that I wanted to ditch the oldest data first,
>  		 * I hope thats okay with everyone? Yes? Good.
> @@ -560,8 +560,8 @@ static void neo_parse_modem(struct jsm_channel *ch, u8 signals)
>  	u8 msignals = signals;
>  
>  	jsm_dbg(MSIGS, &ch->ch_bd->pci_dev,
> -		"neo_parse_modem: port: %d msignals: %x\n",
> -		ch->ch_portnum, msignals);
> +	"%s: port: %d msignals: %x\n",
> +	__func__, ch->ch_portnum, msignals);
>  
>  	/* Scrub off lower bits. They signify delta's, which I don't care about */
>  	/* Keep DDCD and DDSR though */
> @@ -592,7 +592,7 @@ static void neo_parse_modem(struct jsm_channel *ch, u8 signals)
>  		ch->ch_mistat &= ~UART_MSR_CTS;
>  
>  	jsm_dbg(MSIGS, &ch->ch_bd->pci_dev,
> -		"Port: %d DTR: %d RTS: %d CTS: %d DSR: %d " "RI: %d CD: %d\n",
> +		"Port: %d DTR: %d RTS: %d CTS: %d DSR: %d RI: %d CD: %d\n",
>  		ch->ch_portnum,
>  		!!((ch->ch_mistat | ch->ch_mostat) & UART_MCR_DTR),
>  		!!((ch->ch_mistat | ch->ch_mostat) & UART_MCR_RTS),
> @@ -770,9 +770,9 @@ static void neo_parse_isr(struct jsm_board *brd, u32 port)
>  			spin_lock_irqsave(&ch->ch_lock, lock_flags);
>  			if (cause == UART_17158_XON_DETECT) {
>  				/* Is output stopped right now, if so, resume it */
> -				if (brd->channels[port]->ch_flags & CH_STOP) {
> +				if (brd->channels[port]->ch_flags & CH_STOP)
>  					ch->ch_flags &= ~(CH_STOP);
> -				}
> +
>  				jsm_dbg(INTR, &ch->ch_bd->pci_dev,
>  					"Port %d. XON detected in incoming data\n",
>  					port);
> @@ -1067,7 +1067,6 @@ static void neo_param(struct jsm_channel *ch)
>  
>  	/* Get current status of the modem signals now */
>  	neo_parse_modem(ch, readb(&ch->ch_neo_uart->msr));
> -	return;
>  }
>  
>  /*
> @@ -1147,7 +1146,7 @@ static irqreturn_t neo_intr(int irq, void *voidbrd)
>  		case UART_17158_RXRDY_TIMEOUT:
>  			/*
>  			 * RXRDY Time-out is cleared by reading data in the
> -			* RX FIFO until it falls below the trigger level.
> +			 * RX FIFO until it falls below the trigger level.
>  			 */
>  
>  			/* Verify the port is in range. */
> -- 
> 2.34.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
