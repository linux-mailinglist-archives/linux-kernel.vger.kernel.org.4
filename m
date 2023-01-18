Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CD0671F26
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjAROO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjARONc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:13:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA668BA81
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:53:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 767E8B81D2C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B1CC433EF;
        Wed, 18 Jan 2023 13:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674050034;
        bh=w5r9sYL2RG2NQJE13OljQZOKM5j8E2WL4wRHuMh3tTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DoZa7S5Bv0ocCl/sR+1FXm3srL0KZoiUzA6xDqSnJY1xn3gB0EBIC9xbJBfzPZiou
         XOsLjDM+alD7jblgSJo2QDzfzdqn0z4yzHE9PyiBSnXZ5AJQn4oqH7IQyaA5TGb2G3
         gE/1/9byCcSOGQrXWyQqDlVgygR1wiDevmDoc/+sI0FKnk8j9Lg6jyXnVEUv6MAeX0
         aQoDFannscnQMUkEeUL4V3taDKVOHEjKrWk+zh8ckmuB1z+W5Vb+9qw08+FeAbvCdw
         Q+7ADmLOh2rXDg5QfSxmkC9aQKq7C1SB3FYJMOQMVGyKChM+feNfZSXAFdAQfz/vXD
         Z6L//5QAxTang==
Date:   Wed, 18 Jan 2023 13:53:50 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/7] MPFS system controller/mailbox fixes
Message-ID: <Y8f57uKjIAPdAz1b@spud>
References: <20230111134513.2495510-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+7I49tIPzidPH2wa"
Content-Disposition: inline
In-Reply-To: <20230111134513.2495510-1-conor.dooley@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+7I49tIPzidPH2wa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 11, 2023 at 01:45:06PM +0000, Conor Dooley wrote:
> Hey Jassi, all,
>=20
> Here are some fixes for the system controller on PolarFire SoC that I
> ran into while implementing support for using the system controller to
> re-program the FPGA. A few are just minor bits that I fixed in passing,
> but the bulk of the patchset is changes to how the mailbox figures out
> if a "service" has completed.
>=20
> Prior to implementing this particular functionality, the services
> requested from the system controller, via its mailbox interface, always
> triggered an interrupt when the system controller was finished with
> the service.
>=20
> Unfortunately some of the services used to validate the FPGA images
> before programming them do not trigger an interrupt if they fail.
> For example, the service that checks whether an FPGA image is actually
> a newer version than what is already programmed, does not trigger an
> interrupt, unless the image is actually newer than the one currently
> programmed. If it has an earlier version, no interrupt is triggered
> and a status is set in the system controller's status register to
> signify the reason for the failure.

I think, with how things currently are, the timeout is insufficient.
I've noticed some services taking longer (significantly) longer than what
I have provisioned for.

I'll try to find an upper bound and respin a v2. Questions below are
still valid either way!

Thanks,
Conor.

> In order to differentiate between the service succeeding & the system
> controller being inoperative or otherwise unable to function, I had to
> switch the controller to poll a busy bit in the system controller's
> registers to see if it has completed a service.
> This makes sense anyway, as the interrupt corresponds to "data ready"
> rather than "tx done", so I have changed the mailbox controller driver
> to do that & left the interrupt solely for signalling data ready.
> It just so happened that all of the services that I had worked with and
> tested up to this point were "infallible" & did not set a status, so the
> particular code paths were never tested.
>=20
> Jassi, the mailbox and soc patches depend on each other, as the change
> in what the interrupt is used for requires changing the client driver's
> behaviour too, as mbox_send_message() will now return when the system
> controller is no longer busy rather than when the data is ready.
> I'm happy to send the lot via the soc tree with your Ack and/or reivew,
> if that also works you?
>=20
> Secondly, I have a question about what to do if a service does fail, but
> not due to a timeout - eg the above example where the "new" image for
> the FPGA is actually older than the one that currently exists.
> Ideally, if a service fails due to something other than the transaction
> timing out, I would go and read the status registers to see what the
> cause of failure was.
> I could not find a function in the mailbox framework that allows the
> client to request that sort of information from the client. Trying to
> do something with the auxiliary bus, or exporting some function to a
> device specific header seemed like a circumvention of the mailbox
> framework.
> Do you think it would be a good idea to implement something like
> mbox_client_peek_status(struct mbox_chan *chan, void *data) to allow
> clients to request this type of information?
>=20
> It'd certainly allow me to report the actual errors to the drivers
> implementing the service & make better decisions there about how to
> proceed.
> Perhaps I have missed some way of doing this kind of thing that (should
> have been) staring me in the face!
>=20
> Thanks,
> Conor.
>=20
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: Daire McNamara <daire.mcnamara@microchip.com>
> CC: Jassi Brar <jassisinghbrar@gmail.com>
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
>=20
> Conor Dooley (7):
>   mailbox: mpfs: fix an incorrect mask width
>   mailbox: mpfs: switch to txdone_poll
>   mailbox: mpfs: ditch a useless busy check
>   soc: microchip: mpfs: fix some horrible alignment
>   soc: microchip: mpfs: use a consistent completion timeout
>   soc: microchip: mpfs: simplify error handling in
>     mpfs_blocking_transaction()
>   soc: microchip: mpfs: handle timeouts and failed services differently
>=20
>  drivers/mailbox/mailbox-mpfs.c              | 25 +++++++----
>  drivers/soc/microchip/mpfs-sys-controller.c | 48 +++++++++++++--------
>  2 files changed, 47 insertions(+), 26 deletions(-)
>=20
>=20
> base-commit: 88603b6dc419445847923fcb7fe5080067a30f98
> --=20
> 2.39.0
>=20

--+7I49tIPzidPH2wa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8f5zQAKCRB4tDGHoIJi
0uQ1AP9fSIWdrEuF5cYVtH2JW2+2CBmFvbK0cmJCHDzavG/SpgD/fsXfHn5TSM+p
JJGfXx5N8gomdWbZkP0hBAwHcacvvAw=
=liwu
-----END PGP SIGNATURE-----

--+7I49tIPzidPH2wa--
