Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7B67030C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbjEOO7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjEOO7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:59:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356DDE76
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:59:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C156B618A2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE644C433EF;
        Mon, 15 May 2023 14:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684162782;
        bh=1RqaJ7zL8Xh2zQspFkvZOJWVHT+8/oHrnCovbywYfng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ia2t35pbyhHgJY7HWrM5wDKgyaGzqUfDJ5/DDk/GlapfeGL2usAGBX5CDVDBG4Kfw
         jGUWE9fu2ZReTTwgnglprwPfxJn4qoFbp+xUcZRduBomsBzqweMG4Dtwbr6I48EucN
         NXDuag41PqUtLU+aUL6I9Z3o/mH0S6+PbB7FpdkIoRMJ2rc6Ml0sB/l62Wxi0PZ5bA
         Rwo5z2/+p9S4pU/Tb8yV3It/yzqPGHPVtNp+Ld1p2rx3roMT2oNPWmSmIUvQuSxUjX
         xVNUehF6cgXCvcieCWVSoz1PqKNSeQFUJ9Qc9YfB/aX0/XweawHv/7BO6qZbNjnHLj
         fc5JUfL7WCkng==
Date:   Mon, 15 May 2023 23:59:39 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Jim Wylder <jwylder@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: Account for register length when chunking
Message-ID: <ZGJI2zU/bxDPxLAh@finisterre.sirena.org.uk>
References: <20230515143927.973493-1-jwylder@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zlP1mulNB2rcoCwA"
Content-Disposition: inline
In-Reply-To: <20230515143927.973493-1-jwylder@google.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zlP1mulNB2rcoCwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 15, 2023 at 09:39:26AM -0500, Jim Wylder wrote:

> To avoid this problem, add a flag in the regmap_bus structure to declare
> that, for a given bus, the register length should be accounted for.  Set
> the flag to true for I2C buses, and subtract the length of the register
> from the maximum transmission value if the flag is set.

This will be needed for any bus with a format operation so we should
just check for that and it should also take account of any pad bytes.

--zlP1mulNB2rcoCwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRiSNoACgkQJNaLcl1U
h9BREAf+OPFX69iHFbV2Eej7NzDvaUVSEokzVoviy8h5SjAISwrknHvRc/FBO6oq
fiqF3hom4Zc7+PI9zkPDVucZxmYj0a1dT4AtK+sdO29p6L6bPLnSyq7+THFXZ8t3
yMBIn5EZDDILG8jNNAi/OlRBELdSIAqcuT+Q955P0GdV5ISsICkuD5PP8HGZuAw0
IwX7o2MassAeDuq6U+odNtSQzI7aM9udjzrbkS5W9vIDLoK2/2CvyHEdam4vf5ji
Anm7NKRA9ImvpLTFBXlFxE4siJosz5i+bwhiwmdFUelAyUtyI7uYF08xnmkjFzVn
liYlSeWgwJwG+jFCNSxSFOXTzoV3lg==
=UoQL
-----END PGP SIGNATURE-----

--zlP1mulNB2rcoCwA--
