Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE35065BE38
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbjACKe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237354AbjACKd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:33:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348D9FD0A;
        Tue,  3 Jan 2023 02:33:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C227A61252;
        Tue,  3 Jan 2023 10:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F04C433EF;
        Tue,  3 Jan 2023 10:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672742005;
        bh=3AtFsn/V/juhk9J0oV7s+OaMbFP/MvkSGNDZ0ydRtvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vw2+Z2C4u5t93OLfaYoVO4s9pW9NOMd3mATOojEfQT8jWa6DvrCg3J/DEyAfugHz3
         K8P4yOBRPWgXv6Z5iVH0sBDAYQDSJjIot70cMVPktUU1q41G9ShYdpUd0TZh2CjKiV
         EnLPkPp8Y9hR7c4/AXYpuN2qM+zFowH8BapQfnvKQY7QnWs1fhPB8EJfNY3iX//qIL
         kt7mPQeqhDl3VpcqiqgLjopCHJeqZyqeDGZbBydOsFLcSvdhYIkfz56gOLhtGGaoB5
         facVv+BEO3zN8sV0tSG2kiJDAFOyI6bdAZGF1GjGkH0xeJlpWYbI6QnhAl/9wa3SEo
         Qo/y/q9zrgm6A==
Date:   Tue, 3 Jan 2023 10:33:20 +0000
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv, kprobes: Stricter c.jr/c.jalr decoding
Message-ID: <Y7QEcDU0sMoKrpw4@spud>
References: <20230102160748.1307289-1-bjorn@kernel.org>
 <Y7M/HlcF3u0qWIDJ@spud>
 <87sfgsp15q.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mtGgv2hibrVtzGE6"
Content-Disposition: inline
In-Reply-To: <87sfgsp15q.fsf@all.your.base.are.belong.to.us>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mtGgv2hibrVtzGE6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 03, 2023 at 07:44:49AM +0100, Bj=F6rn T=F6pel wrote:
> Conor Dooley <conor@kernel.org> writes:
> > On Mon, Jan 02, 2023 at 05:07:48PM +0100, Bj=F6rn T=F6pel wrote:
> >> From: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
> >> diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/ker=
nel/probes/simulate-insn.h
> >> index cb6ff7dccb92..de8474146a9b 100644
> >> --- a/arch/riscv/kernel/probes/simulate-insn.h
> >> +++ b/arch/riscv/kernel/probes/simulate-insn.h
> >> @@ -31,9 +31,9 @@ __RISCV_INSN_FUNCS(fence,	0x7f, 0x0f);
> >>  	} while (0)
> >> =20
> >>  __RISCV_INSN_FUNCS(c_j,		0xe003, 0xa001);
> >> -__RISCV_INSN_FUNCS(c_jr,	0xf007, 0x8002);
> >
> > Hmm, I wonder where the mask originally came from!
>=20
> I think it's just a simple bug -- missing that "rs2" must be zero.
>=20
> > I had a look at the compressed spec, of which the version google gave to
> > me was v1.9 [1], and Table 1.6 in that (Instruction listing for RVC,
> > Quadrant 2) seems to list them all together.

> > [1] -
> > https://riscv.org/wp-content/uploads/2015/11/riscv-compressed-spec-v1.9=
=2Epdf
>=20
> C-ext is part of the unpriv spec:
> https://github.com/riscv/riscv-isa-manual/releases

Yah, I was trying to see if there was some period piece which was
misleading that would have explained the mask. I looked again & the v1.7
spec doesn't have that table, but also has no reason to suggest the
current mask either. Guess it was just a mistake :)

--mtGgv2hibrVtzGE6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7QEcAAKCRB4tDGHoIJi
0hc/AQDgWrBQHm8FFXQEP/Whoo4U/9qhcbi0j+i5qS/9Hizx1gD8CoDVSDxixlw1
e5x0w1UCvjDBlSP1MrtjpC21vo8UwwU=
=WCOx
-----END PGP SIGNATURE-----

--mtGgv2hibrVtzGE6--
