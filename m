Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B94A667CB3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 18:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjALRh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 12:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjALRgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:36:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91978CBBC8;
        Thu, 12 Jan 2023 08:58:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 014DA620DC;
        Thu, 12 Jan 2023 16:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4F3C43398;
        Thu, 12 Jan 2023 16:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673542681;
        bh=fFRqgsrl7Ewslx/ZwWvBlTVHZWIOjbNberPekWlv87Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vJ1kIpslROY2MZ+qkiqGFEmYrbEbgPz1K1+ljcqoFfC4YRRzL+DLJ8HD00cpLPI77
         iCXwCf+2nD5jZvYJhMOGhrC3cMP39qnG0M3HDS309gfnOwPYu0NZ1WxjrzAYtFqPdn
         wViCjfbz02u8+vjIMSSKyOR6hmNm6psvkE4VWAJ8zvhnOZwIl8XQmqyO7mRARWnebP
         +8tFSbZvWIkucAUmkNNZoCAQBCCHtNkHd3faMumvtIev6x32Zisz1nx5RCSZizwfmd
         aTzdvXZQvDWkYTyQOHShHuSyGI7ww2j3y5cLrhQ89eCYhSumbufhAegpY3iLcQ0oQp
         r0ZlSRaRL4W5g==
Date:   Thu, 12 Jan 2023 16:57:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/16] spi: bcm63xx-hsspi: Add prepend feature support
Message-ID: <Y8A8EykJYWuu17ew@sirena.org.uk>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-12-william.zhang@broadcom.com>
 <Y7iaEOBP4TRBoDYy@sirena.org.uk>
 <88534207-6b1c-75c1-26a1-be88a19eeecb@broadcom.com>
 <Y7xrhjhhY3g5DE25@sirena.org.uk>
 <04b740e0-09d1-8c39-4f0e-8f61a74eeb58@broadcom.com>
 <Y73WL3Gwo6w6dJJr@sirena.org.uk>
 <7871b35b-df7f-793c-c4a9-c850425ca2b4@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tB4e0N4NIUaXxw/e"
Content-Disposition: inline
In-Reply-To: <7871b35b-df7f-793c-c4a9-c850425ca2b4@broadcom.com>
X-Cookie: A watched clock never boils.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tB4e0N4NIUaXxw/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 11, 2023 at 11:42:57AM -0800, William Zhang wrote:
> On 01/10/2023 01:18 PM, Mark Brown wrote:

> > spi_replace_transfers().

> Okay I saw this function is used by spi_split_transfers_maxsize which a few
> drivers use to limit the transfer size and it make sense.  I can come up
> something like spi_merge_transfers to be used by my driver's prepend
> function.  But it has the same issue I mentioned early as the these tx, rx
> transfers have the dependency on the order they present in the original
> transfer list for my prepend function to work.  And for the same reason, it
> won't be generally useful for other drivers.

I wouldn't be surprised if something else turned up which had similar
constraints, SPI isn't the most complex thing ever so there's a lot of
patterns in controlers that get reproduced.

--tB4e0N4NIUaXxw/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPAPBIACgkQJNaLcl1U
h9B7owf+NOOGAbdzEW4Bw5MOOF0h1haRJ/Fc1hX/4OplSftennksQwctqCI9LB5s
jxA3Rn8Itza83awPYWcIJ9fT5ZwNeXBTcNEsQ1KPhHBE+vzYTWYiNlTWABa7vFOE
EFqu9erZJoYHYgXlb86MSuzC5om0zYGzt/xeGnvaZcMzqQNV3+Ib6urT0I0jRncL
Uo3sjZoNyJ7FGCRGYVvBuqov9igoCLPFsV0C6+T6NtsE2YwDF9I000oWwmVGgRuo
dOh8QAZYFfWxvmmw2tIzUGwfyxZshgBCKzlO7PFOprbLza3c1Tf34gLIzJ9lYJ4n
Rt2HOSabCoThRauJ2p5o/HcW+WjBhw==
=6GPD
-----END PGP SIGNATURE-----

--tB4e0N4NIUaXxw/e--
