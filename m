Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAD25EDBC7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiI1La1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiI1LaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:30:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5253F3122E;
        Wed, 28 Sep 2022 04:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06702B82033;
        Wed, 28 Sep 2022 11:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738AFC433C1;
        Wed, 28 Sep 2022 11:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664364617;
        bh=LLgQr+IZeqd1fCWoaJBn5Zst3hBUR5X5/tGRuPRH9bU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XelQ4lZLLW0gM2Ze9jwlLRVZtDBfbobvaGWyQAHg832q0mgJBOWVvj2db6xvxm0rm
         sxeiKO0h13Yyt+rQphCStMEPR66Lt/moG9ZfRy+/3J+E33FQ1Uqf6UvVTyBkq/7g9+
         Eqyr+J8JHUkqCatt71RN6Z12RArmRqVPyhc0eayK0pXVY1oDdL7D1yroMSAHcYaZNJ
         i+1h/x6NaJI8sAZtK1crGIAbY2eUk9FVWsYHEK1bibmERuK8qbtd6uxON9F4ir5iEx
         kUJtyqfvAIT6R+debFFHqTO1/P45fy7uZLrachbGHmnZn338V/pem7mPjTpWznXGEJ
         iwKrspsTblBeA==
Date:   Wed, 28 Sep 2022 12:30:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH RFC SPI for-next 2/2] spi: microchip: pci1xxxx: Add
 suspend and resume support for PCI1XXXX SPI driver
Message-ID: <YzQwQwL4NOTMMe18@sirena.org.uk>
References: <20220928034336.2939265-1-tharunkumar.pasumarthi@microchip.com>
 <20220928034336.2939265-3-tharunkumar.pasumarthi@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="22Z4F81dhKsw65X1"
Content-Disposition: inline
In-Reply-To: <20220928034336.2939265-3-tharunkumar.pasumarthi@microchip.com>
X-Cookie: You look tired.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--22Z4F81dhKsw65X1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 28, 2022 at 09:13:36AM +0530, Tharun Kumar P wrote:

> +	for (iter = 0; iter < spi_ptr->total_hw_instances; iter++) {
> +		spi_sub_ptr = spi_ptr->spi_int[iter];
> +
> +		/* Store existing config before suspend */
> +		store_restore_config(spi_ptr, spi_sub_ptr, iter, 1);
> +		spi_master_suspend(spi_sub_ptr->spi_host);
> +		writel(reg1, spi_ptr->reg_base +
> +		       SPI_MST_EVENT_MASK_REG_OFFSET(iter));
> +	}

This saves the register configuration before suspending the device,
meaning there may be in progress transfers changing the device while the
save is going on.

--22Z4F81dhKsw65X1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmM0MEIACgkQJNaLcl1U
h9D/AAf+LQT7PEYJ8TrU3S/DzYnr+TF7s6GXgvJfvmIQHm08SLGYRxkSuXpqUIqg
smWC06LcwszgB+BznAeh4TR/k/J4BHWzFhmh2JTNqlFXLLrIEQdbr/1yAtr1p/xM
cX1StsHfAy9l0XsSxUogUA4FUWvZpCapn+Gd8+dWt2a9nhZF256Gta6uMmZF4Cqr
gL0SPqR6JZ8GsGjwl9hgm20sXF8Uvi0eXMS/TGRrCh+JH84uKBTh8HygtpURdZBh
DolaJujlrvj8ADj1klAtYHPfpGNxfxd+uihx6oz0H9ouis/mifJvUpWt2L1YmGP6
saMkA9dVg664heUoaS6rAmGVAl1CDg==
=l/HG
-----END PGP SIGNATURE-----

--22Z4F81dhKsw65X1--
