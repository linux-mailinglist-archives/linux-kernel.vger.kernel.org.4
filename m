Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1696914CB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBIXln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjBIXlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:41:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AC96F8FF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 15:40:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEEA061B5A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 23:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D34FC433EF;
        Thu,  9 Feb 2023 23:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675986050;
        bh=MrjTCzC/xPfvf63xVJNKaSFm6WBboTWZnObZjd8N9Nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zf8ncTjO5xdofGbd3VZDQDbD3AAwrOi2UVP5Cs0gn1BynBshSQGynbIcT0oF2JCbp
         AVGrXuCakPdSOxtIRbOH5gIeZCYq27FEH0DvmAzeU5TzjO0JSWL9ZA+xkdrTWykhef
         CPMuORjE9XYNXErO1twCUfwb20J3GOAMRLtBL9CglAmDobmSXxXi23CLCql735IV3b
         1EKWT3vNtd+9Iq2ILytVA36AvFStd+FmVBDTEw/x3zZShFoDhl6Rcipwsc9MkR5KQA
         i4nymv6W8JDlmM2t/Urh0lSbBrX0Due4oANP9Ybq0ead/pxPqITgRbTN+SB+x7iCSQ
         ljOFUL4jcGPRQ==
Date:   Thu, 9 Feb 2023 23:40:45 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH] clocksource/drivers/riscv: Refuse to probe on T-Head
Message-ID: <Y+WEfc2fYd3qJmUe@spud>
References: <20230209232302.25658-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kF+jlzWmrA/0Tmz3"
Content-Disposition: inline
In-Reply-To: <20230209232302.25658-1-palmer@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kF+jlzWmrA/0Tmz3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Palmer,

On Thu, Feb 09, 2023 at 03:23:02PM -0800, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> As of d9f15a9de44a ("Revert "clocksource/drivers/riscv: Events are
> stopped during CPU suspend"") this driver no longer functions correctly
> for the T-Head firmware.  That shouldn't impact any users, as we've got
> a functioning driver that's higher priority, but let's just be safe and
> ban it from probing at all.
>=20
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> This feel super ugly to me, but I'm not sure how to do this more
> cleanly.  I'm not even sure if it's necessary, but I just ran back into
> the driver reviewing some other patches so I figured I'd say something.

I'm not super sure what you're trying to fix here. That revert went
through to restore behaviour for the SiFive stuff that do deliver events
in suspend.

Subsequently, we added a DT property (probably the wrong one tbh, but
that's all said and done now) that communicates that a timer is
incapable of waking the cpus. See commit 98ce3981716c ("dt-bindings:
timer: Add bindings for the RISC-V timer device") & the full patchset is
at:
https://lore.kernel.org/linux-riscv/20230103141102.772228-1-apatel@ventanam=
icro.com/

AFAIU, the binding for the T-HEAD clint was only accepted in the last
week & there's nothing actually using this timer. IIRC, when I wanted to
test the timer, Samuel cooked me up a WIP openSBI etc to enable it.

So ye, I don't think this is needed fortunately!

Cheers,
Conor.

--kF+jlzWmrA/0Tmz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+WEfQAKCRB4tDGHoIJi
0iq2AQDQ4+8gWTOCL4PzVQpY62hag3wY4yKJStKUA6r8bSFh8AEAk+uY/85Khd8Z
Y4IggxcjK79QG6A7SPHYyC9GuVl0/QE=
=j9J3
-----END PGP SIGNATURE-----

--kF+jlzWmrA/0Tmz3--
