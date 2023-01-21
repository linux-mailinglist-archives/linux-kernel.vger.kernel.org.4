Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55E5676846
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 20:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjAUTNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 14:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjAUTNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 14:13:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68596DBD1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:12:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C4A2B8077E
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 19:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662FDC433D2;
        Sat, 21 Jan 2023 19:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674328376;
        bh=PdhfA3rRgIE2e0kyzwK3wCYUpNWtN8PfB8MESxPqJ+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OI8JbQvzQZ0lJ8r2fM7Uo5WeX8XK4zEzTnirrkRLhCcn4Kl47QPVZ6G2A83YcE9gh
         bSs0A5RSotc317g3JcOmNG4pgTkoX1RjQm911M4WrT6GyupS+at5Kr3TYSuLRvp8i+
         psSBwKQ6250qaZy7MEs6fMW9YLA2aSyxRifEim0rdWdk4mNBf4B72iYM+toHLxlvp2
         yAnx6Bv7BXSBDc7KHMmgo1eg4FSjdU5TUr9AJepjlHFYzkXI2wMp/7KHgDMm3kjU/d
         UvgRgE6jHvGfPjp4HdiNuUJ5pHU/5LtYNJKmd5t+KjDGVyjX8yED6ySf9JEIIOHupE
         ndfO4jLHvaQuQ==
Date:   Sat, 21 Jan 2023 19:12:52 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/7] MPFS system controller/mailbox fixes
Message-ID: <Y8w5NO9E/j/6eT5d@spud>
References: <20230111134513.2495510-1-conor.dooley@microchip.com>
 <CABb+yY3+83AP0B4RUGTabqjR=7rXJFMgAvXsM5Go3sz2RMJA1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zjBIZyBoxjBkWVzW"
Content-Disposition: inline
In-Reply-To: <CABb+yY3+83AP0B4RUGTabqjR=7rXJFMgAvXsM5Go3sz2RMJA1g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zjBIZyBoxjBkWVzW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 21, 2023 at 10:01:41AM -0600, Jassi Brar wrote:
> On Wed, Jan 11, 2023 at 7:45 AM Conor Dooley <conor.dooley@microchip.com> wrote:
> >
> > In order to differentiate between the service succeeding & the system
> > controller being inoperative or otherwise unable to function, I had to
> > switch the controller to poll a busy bit in the system controller's
> > registers to see if it has completed a service.
> > This makes sense anyway, as the interrupt corresponds to "data ready"
> > rather than "tx done", so I have changed the mailbox controller driver
> > to do that & left the interrupt solely for signalling data ready.
> > It just so happened that all of the services that I had worked with and
> > tested up to this point were "infallible" & did not set a status, so the
> > particular code paths were never tested.
> >
> > Jassi, the mailbox and soc patches depend on each other, as the change
> > in what the interrupt is used for requires changing the client driver's
> > behaviour too, as mbox_send_message() will now return when the system
> > controller is no longer busy rather than when the data is ready.
> > I'm happy to send the lot via the soc tree with your Ack and/or reivew,
> > if that also works you?
> >
> Ok, let me review them and get back to you.

FYI, I did sent a v2 on Friday:
https://lore.kernel.org/all/20230120143734.3438755-1-conor.dooley@microchip.com/

The change is just a timeout duration though.

> > Secondly, I have a question about what to do if a service does fail, but
> > not due to a timeout - eg the above example where the "new" image for
> > the FPGA is actually older than the one that currently exists.
> > Ideally, if a service fails due to something other than the transaction
> > timing out, I would go and read the status registers to see what the
> > cause of failure was.
> > I could not find a function in the mailbox framework that allows the
> > client to request that sort of information from the client. Trying to
> > do something with the auxiliary bus, or exporting some function to a
> > device specific header seemed like a circumvention of the mailbox
> > framework.
> > Do you think it would be a good idea to implement something like
> > mbox_client_peek_status(struct mbox_chan *chan, void *data) to allow
> > clients to request this type of information?
> >
> .last_tx_done() is supposed to make sure everything is ok.

Hm, might've explained badly as I think you've misunderstood. Or (see
below) I might have mistakenly thought that last_tx_done() was only meant
to signify that tx was done.

Anyways, I'll try to clarify.
Some services don't set a status, but whether a status is, or isn't,
set has nothing to do with whether the service has completed.
One service that sets a status is "Authenticate Bitstream". This
service sets a status of 0x0 if the bitstream in question is okay _and_
something that the FPGA can be upgraded to. It returns a failure of 0x18
if the bitstream is valid _but_ is the same as that currently programmed.
(and of course a whole host of other possible errors in-between)

These statuses, and whether they are a bad outcome or not, is dependant
on the service and I don't think should be handled in the mailbox
controller driver.

> If the expected status bit is "sometimes not set", that means that bit
> is not the complete status.

If the "busy" bit goes low, then the transmission must be complete,
there should be no need to check other bits for *completion*, but...

> You have to check multiple registers to
> detect if and what caused the failure.

...maybe I have just misunderstood the role of .last_tx_done(). The
comment in mailbox-controller.h lead me to believe that it was used just
to check if it had been completed.

Am I allowed to use .last_tx_done() to pass information back to the
mailbox client? If I could, that'd certainly be a nice way to get the
information on whether the service failed etc.

Hopefully that, plus when you have a chance to look at the code, will
make what I am asking about a little clearer!

Thanks,
Conor.

--zjBIZyBoxjBkWVzW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8w5NAAKCRB4tDGHoIJi
0ldrAQCX/0J7YAojS3DUErApT7uUqiraS8RIYGqZRbdynr1LEwEAvPO8zM9NSaDV
pwmyzML3LI7NGdK+VGFlODcPQTtXig4=
=dVbB
-----END PGP SIGNATURE-----

--zjBIZyBoxjBkWVzW--
