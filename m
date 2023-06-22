Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898B173AB6E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjFVVQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjFVVQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:16:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDB7195;
        Thu, 22 Jun 2023 14:16:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C57361903;
        Thu, 22 Jun 2023 21:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB0EC433C8;
        Thu, 22 Jun 2023 21:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687468609;
        bh=xSZmrtBW6K2rFKUlZrWXt4n85rXjSVP9x5eUXJgvqlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GWOWGlXKarrlCwefPs3N9AZYJF7/V69mjTQH5dY7oYTdXl96w80eQks0w6kb9DXIl
         3MCXebr6FFkL4gWeuhLDUaG7BRQwdliUwS1t1ZjCI6WppJUmUC5zBZiAiMkrvO0hJ6
         EumX4G34tn8LzfFU3hgon6XcXqgIBhiB9tz5GqPM5uU8xLYq/trbuQwq8MD4DL57Kn
         1u11VAIytyWQGo1EFZxOY3dI2LyJB5mmVXDRWw0LkBBch3MzMpzZBGLENIxzX6NShd
         b0PPjUcVbumaPcZVESJfw0M6DypUW8ZTmzjTosWiqDtbDqAMLKNuqQcTI1jGrSzhWK
         alHlYpiXJv4zA==
Date:   Thu, 22 Jun 2023 22:16:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        krzysztof.kozlowski@linaro.org, andi@etezian.org, kernel@axis.com,
        alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] spi: Split transfers larger than max size
Message-ID: <ZJS6OnzRapPCboC8@finisterre.sirena.org.uk>
References: <20220927112117.77599-1-vincent.whitchurch@axis.com>
 <20220927112117.77599-4-vincent.whitchurch@axis.com>
 <6dff003d-c727-e4a3-b5d3-f58beb2b02cb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NQj34PwTfnw4PHDi"
Content-Disposition: inline
In-Reply-To: <6dff003d-c727-e4a3-b5d3-f58beb2b02cb@linux.ibm.com>
X-Cookie: Slow day.  Practice crawling.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NQj34PwTfnw4PHDi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2023 at 02:48:36PM -0500, Eddie James wrote:
> On 9/27/22 06:21, Vincent Whitchurch wrote:
> > A couple of drivers call spi_split_transfers_maxsize() from their
> > ->prepare_message() callbacks to split transfers which are too big for
> > them to handle.  Add support in the core to do this based on
> > ->max_transfer_size() to avoid code duplication.

> I've been testing AT25 functionality in linux 6.1 and I believe this patch
> is breaking the AT25 protocol. It will split a write command up such that
> some of the data is in a different transfer than=A0 the write enable and
> address. According to my understanding of the AT25 spec, that doesn't
> work... Someone correct me if I'm wrong though. Do we need a flag to
> enable/disable this behavior depending on the client perhaps?

Could you be more specific about the manner in which you think this is
breaking things?  The size of transfer is immaterial to the client
device on SPI, the client will be counting clocks while the chip select
is asserted.  How the controller chooses to split things up is really
not particularly visible or relevant, it might bitbang things out one
bit at a time, transfer a single word at a time or batch things up
further.  So long as the chip select is asserted it's all the same to
the client device.

In any case this is all based on the maximum transfer size advertised by
the conteroller driver, if the device can physically handle larger
transfers then there's no reason for it to set a limit.  If the driver
can't physically handle larger transfers and it does make a difference
then the system simply won't work.

--NQj34PwTfnw4PHDi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSUujkACgkQJNaLcl1U
h9CPqgf/X1FRQ/Sr3bPuUa1Qk8QD6FT06cmknaYG6mWBtbznGfhPMgnpM0ivm/2c
FKdQxPc7eUI5mBzxjx3wsm6Agmnw3LEV7kfgrwNYBUlwMH6BcMxmQ9S6rBqhvgXj
tBXUiGkEjui8JRRBQZKy+lYexFEp6tGeFeW6OiLYShkyIZtZQiX93RhXB8zhLglK
TMuOVuzrJDnXG35gAaa2ws0NQDkjI+5x/gsnQqkeRKOAyf8My2euyWMi2I2MWK7z
L2dW33I3biwLv4X0fK75Yd5IhbRNBuu+hLv1WLutJ/v2yB4MHYaljnFbwlW57ooA
EIT4Z/A4Qgo5MQl1zHN2TEGYH8+wIg==
=vzqY
-----END PGP SIGNATURE-----

--NQj34PwTfnw4PHDi--
