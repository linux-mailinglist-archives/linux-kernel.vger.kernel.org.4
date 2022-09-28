Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39975EDBBC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiI1L1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiI1L1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:27:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C737195AC9;
        Wed, 28 Sep 2022 04:27:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 505AC61E43;
        Wed, 28 Sep 2022 11:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0931C433C1;
        Wed, 28 Sep 2022 11:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664364422;
        bh=eSOL/DU5Kf1L5G90ZcqNd6aD098V2uIxPc9AmJrcuzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfm/W6biWgH8TAWPurd4Oa5K5nlURO6BVQniuHSOTVhylPTxJD2cbWFxXALXWMto3
         FZVImDywwoJROu1T0AQ4e10wKwLMYKX+2+vQQ207Dxb+l6aE+IOrqjImyHkuTWV03q
         JQYQrdJo+H+pBoBWP5I6uDjaGmGzRagnx6llB0WDPvxsmYgTPb4XwlQ+OZSlh/dnAM
         qcVNNHaf9V6HyL/VtD1W25tf/GV11ZQMjn8k7ZmA6cXUrel5rDOJJX09K5BTojhxIN
         Kn3Hb5KZCyH5vx0CGjQ2H1Y/iEQA5gHsTx7OHZncFA3Tr3aPeAPFD1v5g1RhuwHT0q
         k2EmCPWDvCSHA==
Date:   Wed, 28 Sep 2022 12:26:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH RFC SPI for-next 1/2] spi: microchip: pci1xxxx: Add
 driver for SPI controller of PCI1XXXX PCIe switch
Message-ID: <YzQvgmE9Hubx9mxN@sirena.org.uk>
References: <20220928034336.2939265-1-tharunkumar.pasumarthi@microchip.com>
 <20220928034336.2939265-2-tharunkumar.pasumarthi@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2ZkGJ89x+m0DsCiW"
Content-Disposition: inline
In-Reply-To: <20220928034336.2939265-2-tharunkumar.pasumarthi@microchip.com>
X-Cookie: You look tired.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2ZkGJ89x+m0DsCiW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 28, 2022 at 09:13:35AM +0530, Tharun Kumar P wrote:

> @@ -0,0 +1,378 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * PCI1xxxx SPI driver
> + * Copyright (C) 2022 Microchip Technology Inc.
> + * Authors: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> + *          Kumaravel Thiagarajan <Kumaravel.Thiagarajan@microchip.com>
> + */

Please make the above a single C++ style comment block so things look
more intentional.

> +static void pci1xxxx_spi_set_cs(struct spi_device *spi, bool enable)
> +{
> +	struct pci1xxxx_spi_internal *p = spi_controller_get_devdata(spi->controller);
> +	struct pci1xxxx_spi *par = p->parent;
> +	u32 regval;
> +
> +	/* Set the DEV_SEL bits of the SPI_MST_CTL_REG */
> +	regval = readl(par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
> +	if (enable) {
> +		regval &= ~SPI_MST_CTL_DEVSEL_MASK;
> +		regval |= (spi->chip_select << 25);
> +		writel(regval,
> +		       par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
> +	}
> +}

This does nothing if the chip select is to be disabled, that's clearly
not going to work.

> +static int pci1xxxx_spi_transfer_one(struct spi_controller *spi_ctlr,
> +				     struct spi_device *spi, struct spi_transfer *xfer)
> +{

> +	if (tx_buf) {

> +			if (rx_buf) {

The driver should set SPI_CONTROLLER_MUST_TX since it needs to transmit
data in order to recieve.

> +static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	u8 hw_inst_cnt, iter, start, only_sec_inst;
> +	struct pci1xxxx_spi_internal *spi_sub_ptr;
> +	struct device *dev = &pdev->dev;
> +	struct pci1xxxx_spi *spi_bus;
> +	struct spi_master *spi_host;
> +	u32 regval;
> +	int ret;
> +
> +	hw_inst_cnt = ent->driver_data & 0x0f;
> +	start = (ent->driver_data & 0xf0) >> 4;
> +	(start == 1) ? (only_sec_inst = 1) : (only_sec_inst = 0);

Please write normal conditional statements to improve legibility.

> +
> +			ret = devm_request_irq(&pdev->dev, spi_sub_ptr->irq,
> +					       pci1xxxx_spi_isr, PCI1XXXX_IRQ_FLAGS,
> +					       pci_name(pdev), spi_sub_ptr);
> +			if (ret < 0) {
> +				dev_err(&pdev->dev, "Unable to request irq : %d",
> +					spi_sub_ptr->irq);
> +				ret = -ENODEV;
> +				goto error;
> +			}

Are you sure the device is fully set up and ready for interrupts at this
point, and that the freeing of the driver will work fine with devm?

> +		init_completion(&spi_sub_ptr->spi_xfer_done);

I note that the completion that the interrupt handler uses isn't
allocated yet for example...

> +		/* Initialize Interrupts - SPI_INT */
> +		regval = readl(spi_bus->reg_base +
> +			       SPI_MST_EVENT_MASK_REG_OFFSET(spi_sub_ptr->hw_inst));
> +		regval &= ~SPI_INTR;
> +		writel(regval, spi_bus->reg_base +
> +		       SPI_MST_EVENT_MASK_REG_OFFSET(spi_sub_ptr->hw_inst));

...and we do some interrupt mask management later.

--2ZkGJ89x+m0DsCiW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmM0L4EACgkQJNaLcl1U
h9BPDAf9HNtpH+r1t/Et40XKvrwTJ27xRyncaDAtFkesUESXpS2bU9qln8TnSGuF
Co6VOt7kFzIe/RTRk0CqEFMg2bSW3Q84zEDK5rPEhllrVsVCeajj5dte9LonPUDr
DytVxW1M/SPUnX0VPyjymmLa1SgI92NtIsrrq0V+0GR+gjWa2X0iLIOfHDBHDJky
RGv1vhewmKRLtRoStzY/7LPUriPbeohccXBrQ6aSFwVFbJpb+Enx4oahthcybKjI
zsOh5Zgw+oY8qPqOd39vYk9tYbZhyCcqhAxu/lW1ZqRCgoiIBuhciR7pBXxTKqvV
CSTeLJufwGh0pbHIVHii0DfIOIMR6w==
=ZzTi
-----END PGP SIGNATURE-----

--2ZkGJ89x+m0DsCiW--
