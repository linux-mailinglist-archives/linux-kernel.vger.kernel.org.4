Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1295668663E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjBAMvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjBAMve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:51:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3688EC671;
        Wed,  1 Feb 2023 04:51:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D900CB8215F;
        Wed,  1 Feb 2023 12:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DF4C433D2;
        Wed,  1 Feb 2023 12:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675255890;
        bh=Hso2+wDezt629s0YjZW3kGWvktFxf9c1wVzkNT23w6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zOrGrZQtzJFw1Cnt/C/TYSTybjanKs43odAn0WSpb4JurPU0+1Zj8i9kxvWpjXeNg
         n9slVLpvLwoODBisBxaMi5BV/EDUap3Q4724MN3ynkxhs0XqyYBXLtvYCR7e65Y3iJ
         jX6hnFOH2HwH6lBWTkKAnXNbGemIOqxfLejvhCnA=
Date:   Wed, 1 Feb 2023 13:51:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tty: n_gsm: add TIOCMIWAIT support
Message-ID: <Y9pgT4VcW3oGaSbY@kroah.com>
References: <20230201080151.2068-1-daniel.starke@siemens.com>
 <20230201080151.2068-3-daniel.starke@siemens.com>
 <Y9oluEimqDixw60I@kroah.com>
 <DB9PR10MB588166BD5DA668E4F6DEA597E0D19@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB588166BD5DA668E4F6DEA597E0D19@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 09:30:28AM +0000, Starke, Daniel wrote:
> > > Add support for the TIOCMIWAIT ioctl on the virtual ttys. This enables the
> > > user to wait for virtual modem signals like RING.
> > > 
> > > Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> > > ---
> > >  drivers/tty/n_gsm.c | 32 ++++++++++++++++++++++++++++++++
> > >  1 file changed, 32 insertions(+)
> > > 
> > > diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> > > index 118511c1fa37..48fb7dad44cd 100644
> > > --- a/drivers/tty/n_gsm.c
> > > +++ b/drivers/tty/n_gsm.c
> > > @@ -1542,6 +1542,7 @@ static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
> > >  	if (brk & 0x01)
> > >  		tty_insert_flip_char(&dlci->port, 0, TTY_BREAK);
> > >  	dlci->modem_rx = mlines;
> > > +	wake_up_interruptible(&dlci->gsm->event);
> > >  }
> > >  
> > >  /**
> > > @@ -3848,6 +3849,35 @@ static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
> > >  	return -EPROTONOSUPPORT;
> > >  }
> > >  
> > > +/**
> > > + * gsm_wait_modem_change	-	wait for modem status line change
> > 
> > No need for tabs.
> > 
> > Or for kernel doc for static functions, but that's not a big deal.
> 
> All other functions follow the same style here. Nevertheless, I will
> replace the tabs with spaces. Originally, I had planned a code clean-up
> after committing all the changes from my original RFC.

Ah, ok, nevermind then, I didn't see that as it's not in the diffs.

Cleaning up later is fine.

> > > +static int gsm_wait_modem_change(struct gsm_dlci *dlci, u32 mask)
> > > +{
> > > +	struct gsm_mux *gsm = dlci->gsm;
> > > +	u32 old = dlci->modem_rx & mask;
> > > +	int ret;
> > > +
> > > +	if (gsm->dead)
> > > +		return -ENODEV;
> > > +
> > > +	do {
> > > +		ret = wait_event_interruptible(gsm->event, gsm->dead
> > > +					      || old ^ (dlci->modem_rx & mask));
> > > +		if (ret)
> > > +			return ret;
> > > +		if (dlci->state != DLCI_OPEN)
> > > +			return -EL2NSYNC;
> > > +		if (gsm->dead)
> > > +			return -ENODEV;
> > > +	} while ((old ^ (dlci->modem_rx & mask)) == 0);
> > 
> > No way to break out of the loop if it goes for forever?
> 
> I assume that this is the expected behavior for TIOCMIWAIT. The functions
> returns if:
> - the requested modem signal changed
> - the wait function got interrupted (e.g. by a signal)
> - the underlying DLCI was closed
> - the underlying ldisc device was removed

Hm, I guess you are right.  But wow, reading that
wait_event_interruptible() condition is crazy, please document that
really well to explain this properly so you will be able to understand
it in a year when you next have to fix it up :)

> I can add that the function returns immediate if a mask has been passed
> which matches no modem signal if this is preferred?

I don't think that would work, try it on some existing serial ports to
see what they do.

thanks,

greg k-h
