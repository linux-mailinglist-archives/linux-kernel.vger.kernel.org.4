Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332C16F296D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 17:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjD3Pt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 11:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD3Pt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 11:49:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B063426AD;
        Sun, 30 Apr 2023 08:49:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 479DC60B8C;
        Sun, 30 Apr 2023 15:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705BCC433EF;
        Sun, 30 Apr 2023 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682869765;
        bh=fssL6K9L1eM0E/LLQqcmp3NyLznFDzcjdbCLTFdkCmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q3jBVYwmYMl2fh7E2KoGY/sDLSejGJX2QbHCZskUw+ga4POKLItmqSGnS2u0CL1Xz
         9C9mctU/dwwPg+WSsuPYkFKbYskIgui6iG+Yuxp0BG0JaQ52MV3q/HpFDFTKLbPEJe
         Ggvc50C+GZce0yn+ynzLWPaaF4EEpHY0gUFvLeTwi/0W+4JFId3+uYKLZwU72jhkRO
         Sy+oT7lND2UpeUUHljFRYuNyPOfbWzTCMcCRCz5iVxFIXtM7QppLq4YKqjTbdcfjQB
         fYVEraoTyL0QPgHdqMQQwMoNIaeb0INoPDW/pM1Xi64RTYpl56Y+BtrUsvN4eeqq99
         dUVJg6zw8DPUg==
Date:   Mon, 1 May 2023 00:49:18 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Use non-atomic xxx_bit() functions
Message-ID: <ZE6N/oZ5DFI6td/0@finisterre.sirena.org.uk>
References: <6b8f405145d3d57a8026dc61ca3f1ae70d690990.1682847325.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ZSxT2A7+0+tsUta"
Content-Disposition: inline
In-Reply-To: <6b8f405145d3d57a8026dc61ca3f1ae70d690990.1682847325.git.christophe.jaillet@wanadoo.fr>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ZSxT2A7+0+tsUta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 30, 2023 at 11:35:35AM +0200, Christophe JAILLET wrote:

> Accesses to 'minors' are guarded by the 'device_list_lock' mutex. So, it is
> safe to use the non-atomic version of (set|clear)_bit() in the
> corresponding sections.

Is it a problem to use the atomic version?

>  	if (status == 0) {
> -		set_bit(minor, minors);
> +		__set_bit(minor, minors);
>  		list_add(&spidev->device_entry, &device_list);

The __ usually means something is the more complicated and less
preferred API.

--7ZSxT2A7+0+tsUta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmROjf0ACgkQJNaLcl1U
h9DBzQf/bUuWkfyEyDhqrOe9e4urnTossTUEGSccL6sXpAaa71GZYx3LFAWimrgt
nT1nrLOOoiV7RiAQKWx5PIY7ArZGBqh/ODSyBEW9yerWLqrDS6HMKKizLt2+cIIT
6AoqPArHsEpwTF6VfBhvHE8YvZxvSh7cs+Xf6gJQXdS8EI4JDzVJ4A9vjeINeRW7
Zrby+DSa5Hi9GnW0NAScITsmcKi4zEVstXJ9Dam+NONm6rdmtJRrmBq3+F4hsVOe
2xeJsr9zYAALx/DHp8sSvBFS9QqPUZy4gxz/MCob/E2RwADS0Vt1p0UFaCoNvXjM
mNx2tDhsF2MprMi4+SRBi6iCLyRx2w==
=ShGm
-----END PGP SIGNATURE-----

--7ZSxT2A7+0+tsUta--
