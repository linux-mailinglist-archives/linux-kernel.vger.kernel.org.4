Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B10C699FAF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjBPWYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBPWYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:24:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BE8FC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 14:24:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBBFEB829D3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 22:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE29C433EF;
        Thu, 16 Feb 2023 22:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676586287;
        bh=AkZM/C98uZwsgM85uiCRPO8EwcX7/vGb5dRzoigiFTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h4twjsHpYg1ZsRqwRiklnPfq4ZL4PLdfXIOwL4h/BMGngn3raqEE+AFRX1+MzO+rI
         9kdpAw/cISlY2uNSKIhFBvBn+9/Vg0MXjApHlpFLECWOBFDKeAKjoZP01mgOBwqt0x
         FuOnjxyytzEFmLvfvBcf5v/oEbAjvwWy1RhdiMo1WPmzZXMJUwmkAzUFYYIbSGd5UW
         3obfXS5e3o6e91XRY//h/6oZEjzpS80cQzgtzbmxQAund+ojjNesgnCP2pi3Nyjc8v
         +j362C3E0UB1uIZH/wFy21eps9zuTshDeDXbsn/7ySECxAmJc2lHMzXJhVSG6CTi/F
         CwijcSlo/c7eg==
Date:   Thu, 16 Feb 2023 22:24:43 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/7] MPFS system controller/mailbox fixes
Message-ID: <Y+6tK/OS13THpQo4@spud>
References: <20230111134513.2495510-1-conor.dooley@microchip.com>
 <CABb+yY3+83AP0B4RUGTabqjR=7rXJFMgAvXsM5Go3sz2RMJA1g@mail.gmail.com>
 <Y8w5NO9E/j/6eT5d@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cHIZQMqJK0RslrQL"
Content-Disposition: inline
In-Reply-To: <Y8w5NO9E/j/6eT5d@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cHIZQMqJK0RslrQL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Jassi,

On Sat, Jan 21, 2023 at 07:12:52PM +0000, Conor Dooley wrote:
> On Sat, Jan 21, 2023 at 10:01:41AM -0600, Jassi Brar wrote:
> > On Wed, Jan 11, 2023 at 7:45 AM Conor Dooley <conor.dooley@microchip.co=
m> wrote:
> > >
> > > In order to differentiate between the service succeeding & the system
> > > controller being inoperative or otherwise unable to function, I had to
> > > switch the controller to poll a busy bit in the system controller's
> > > registers to see if it has completed a service.
> > > This makes sense anyway, as the interrupt corresponds to "data ready"
> > > rather than "tx done", so I have changed the mailbox controller driver
> > > to do that & left the interrupt solely for signalling data ready.
> > > It just so happened that all of the services that I had worked with a=
nd
> > > tested up to this point were "infallible" & did not set a status, so =
the
> > > particular code paths were never tested.
> > >
> > > Jassi, the mailbox and soc patches depend on each other, as the change
> > > in what the interrupt is used for requires changing the client driver=
's
> > > behaviour too, as mbox_send_message() will now return when the system
> > > controller is no longer busy rather than when the data is ready.
> > > I'm happy to send the lot via the soc tree with your Ack and/or reive=
w,
> > > if that also works you?
> > >
> > Ok, let me review them and get back to you.
>=20
> FYI, I did sent a v2 on Friday:
> https://lore.kernel.org/all/20230120143734.3438755-1-conor.dooley@microch=
ip.com/
>=20
> The change is just a timeout duration though.
>=20
> > > Secondly, I have a question about what to do if a service does fail, =
but
> > > not due to a timeout - eg the above example where the "new" image for
> > > the FPGA is actually older than the one that currently exists.
> > > Ideally, if a service fails due to something other than the transacti=
on
> > > timing out, I would go and read the status registers to see what the
> > > cause of failure was.
> > > I could not find a function in the mailbox framework that allows the
> > > client to request that sort of information from the client. Trying to
> > > do something with the auxiliary bus, or exporting some function to a
> > > device specific header seemed like a circumvention of the mailbox
> > > framework.
> > > Do you think it would be a good idea to implement something like
> > > mbox_client_peek_status(struct mbox_chan *chan, void *data) to allow
> > > clients to request this type of information?
> > >
> > .last_tx_done() is supposed to make sure everything is ok.
>=20
> Hm, might've explained badly as I think you've misunderstood. Or (see
> below) I might have mistakenly thought that last_tx_done() was only meant
> to signify that tx was done.
>=20
> Anyways, I'll try to clarify.
> Some services don't set a status, but whether a status is, or isn't,
> set has nothing to do with whether the service has completed.
> One service that sets a status is "Authenticate Bitstream". This
> service sets a status of 0x0 if the bitstream in question is okay _and_
> something that the FPGA can be upgraded to. It returns a failure of 0x18
> if the bitstream is valid _but_ is the same as that currently programmed.
> (and of course a whole host of other possible errors in-between)
>=20
> These statuses, and whether they are a bad outcome or not, is dependant
> on the service and I don't think should be handled in the mailbox
> controller driver.
>=20
> > If the expected status bit is "sometimes not set", that means that bit
> > is not the complete status.
>=20
> If the "busy" bit goes low, then the transmission must be complete,
> there should be no need to check other bits for *completion*, but...
>=20
> > You have to check multiple registers to
> > detect if and what caused the failure.
>=20
> ...maybe I have just misunderstood the role of .last_tx_done(). The
> comment in mailbox-controller.h lead me to believe that it was used just
> to check if it had been completed.
>=20
> Am I allowed to use .last_tx_done() to pass information back to the
> mailbox client? If I could, that'd certainly be a nice way to get the
> information on whether the service failed etc.
>=20
> Hopefully that, plus when you have a chance to look at the code, will
> make what I am asking about a little clearer!

Just wondering if you've had a chance to look at this again! I know it's
missed the merge window this time around but I would like to get this
behaviour fixed as other work depends on it.

Thanks,
Conor.


--cHIZQMqJK0RslrQL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+6tKwAKCRB4tDGHoIJi
0l6cAQCsWrIH+pqBwAf69uZLhrJvtlpPqSCTYxGM7EMsGHBwnQD+OgimOQeWf7mr
9KgBmT+TJwYcmQ2Rk1rSxiDu3y+fhgo=
=AfHa
-----END PGP SIGNATURE-----

--cHIZQMqJK0RslrQL--
