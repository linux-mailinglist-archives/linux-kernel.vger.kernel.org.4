Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC745FDAF6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiJMNfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJMNfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:35:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B796E2E3;
        Thu, 13 Oct 2022 06:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36982609D1;
        Thu, 13 Oct 2022 13:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9184DC433D6;
        Thu, 13 Oct 2022 13:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665668131;
        bh=A7gvKvrmvLJ4A2rarNPB79xMmqFf/0zYZuatB2aPs8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dFvyFwBPpBTdhUkdMBScuMCxFxTgy51heucJCrCWlt4tZ0WVGjTf9OQgkbwY9GOLQ
         EqioPMbifzkn+Y4MuM0kqpvbxDAeCkr+JxCc5s3HAZH7vU+vedjPv4CmTYaWhLplGe
         DzWU3OxW4j7O5+s4XPHhR4QgOIfkCmf1r52wefrjh65Xg8XDK/N7Z20rHhgR9ACcdP
         gC45UQ5nEJlz9sFlMf8KJ2XwFQAXMQW5QdzNb+5WoLzbBlQphrlQ27fGPxz+u6kWUp
         tCI37zDwlh9ImvpfSGS4gVbipJ55CREjIujlDC8N1790GpneMUOfv4eZdAE4Uo7KbI
         HPHfNjt/Cwg+Q==
Date:   Thu, 13 Oct 2022 14:35:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v2 SPI for-next 2/2] spi: microchip: pci1xxxx: Add
 suspend and resume support for PCI1XXXX SPI driver
Message-ID: <Y0gUH1fbB/LijKLw@sirena.org.uk>
References: <20221006050514.115564-1-tharunkumar.pasumarthi@microchip.com>
 <20221006050514.115564-3-tharunkumar.pasumarthi@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/peYUdyb9zf/jKcQ"
Content-Disposition: inline
In-Reply-To: <20221006050514.115564-3-tharunkumar.pasumarthi@microchip.com>
X-Cookie: Do you like "TENDER VITTLES"?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/peYUdyb9zf/jKcQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 06, 2022 at 10:35:14AM +0530, Tharun Kumar P wrote:

> +static int pci1xxxx_spi_resume(struct device *dev)
> +{
> +	struct pci1xxxx_spi *spi_ptr = dev_get_drvdata(dev);
> +	struct pci1xxxx_spi_internal *spi_sub_ptr;
> +	u32 regval = SPI_RESUME_CONFIG;
> +	u8 iter;
> +
> +	for (iter = 0; iter < spi_ptr->total_hw_instances; iter++) {
> +		spi_sub_ptr = spi_ptr->spi_int[iter];
> +		spi_master_resume(spi_sub_ptr->spi_host);
> +		writel(regval, spi_ptr->reg_base +
> +		       SPI_MST_EVENT_MASK_REG_OFFSET(iter));
> +
> +		/* Restore config at resume */
> +		store_restore_config(spi_ptr, spi_sub_ptr, iter, 0);
> +	}
> +
> +	return 0;
> +}

There should be a call to spi_controller_suspend() in here (and
similarly in resume) to tell the controller to stop the queue of
operations.

--/peYUdyb9zf/jKcQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNIFB4ACgkQJNaLcl1U
h9C0mgf/cX24A/BrVWf33R8t8kuqByOzEhxH0WGgkAejAd9uxSogJxkrsX9hVnkG
baNvviWqDg4o7jvYl6c2uM57pjbkmycVqHiM1EzHKD60JFaK+fkA74UXMTFuRA2Z
pEdVS65rle7wM5YFttaQD8us9+7zwTr7rcy05si/RQd2UIsiUgx+5fMFaj037dPA
kXafwNEAVrGNNqRdAPXDZ9KfCKubFhGN7Mk8WSJVhyno4vwok+SPkrDOZTWz2Jxi
96p8HhZ9lMDdh06ROTvl+MwlZRTGqfcWASHYAgB6n16OmhZ0HCBXCK7rj4Ix1Ddq
6SzSZ27eUE3DidcdrdlhgZn1mH7/BA==
=5++5
-----END PGP SIGNATURE-----

--/peYUdyb9zf/jKcQ--
