Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02987339FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjFPTfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjFPTfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:35:07 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436D812B;
        Fri, 16 Jun 2023 12:35:06 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1BADC1C0AB3; Fri, 16 Jun 2023 21:20:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1686943225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y2rk4kvRju7aOubnhyw279OvS/0R0h16k1UJKj1ECT0=;
        b=EKnmzidIIuwAvSs73weaxKF/7sTzsUp22pM97tkv98yWE6urggNR4x5pYkrZfoo8rSBE6S
        LPVSByzdO3HPAp+rc/6AZP+qSCK6SrbgZOjeYtNKTApiDl8Uzc5txtXTf4AV+BlxwWzVlW
        IKN16Az1LunExwuA+Q+M8pnVPNTNIro=
Date:   Fri, 16 Jun 2023 21:20:24 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Wei Chen <harperchen1110@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, serjk@netup.ru,
        aospan@netup.ru, linux-media@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 09/20] media: netup_unidvb: fix irq init by
 register it at the end of probe
Message-ID: <ZIy1+CA55P2YC4xA@duo.ucw.cz>
References: <20230525184520.2004878-1-sashal@kernel.org>
 <20230525184520.2004878-9-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="WUFgJ3P2V9We42OX"
Content-Disposition: inline
In-Reply-To: <20230525184520.2004878-9-sashal@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WUFgJ3P2V9We42OX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit e6ad6233592593079db5c8fa592c298e51bc1356 ]
>=20
> IRQ handler netup_spi_interrupt() takes spinlock spi->lock. The lock
> is initialized in netup_spi_init(). However, irq handler is registered
> before initializing the lock.
>=20
> Spinlock dma->lock and i2c->lock suffer from the same problem.
>=20
> Fix this by registering the irq at the end of probe.

Are you sure you got the error handling right? AFAICT
netup_unidvb_dma_fini(ndev, 0/1); is needed here.

Best regards,
								Pavel

> +++ b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
> @@ -943,6 +938,14 @@ static int netup_unidvb_initdev(struct pci_dev *pci_=
dev,
>  		dev_err(&pci_dev->dev, "netup_unidvb: DMA setup failed\n");
>  		goto dma_setup_err;
>  	}
> +
> +	if (request_irq(pci_dev->irq, netup_unidvb_isr, IRQF_SHARED,
> +			"netup_unidvb", pci_dev) < 0) {
> +		dev_err(&pci_dev->dev,
> +			"%s(): can't get IRQ %d\n", __func__, pci_dev->irq);
> +		goto dma_setup_err;
> +	}
> +
>  	dev_info(&pci_dev->dev,
>  		"netup_unidvb: device has been initialized\n");
>  	return 0;
> @@ -961,8 +964,6 @@ static int netup_unidvb_initdev(struct pci_dev *pci_d=
ev,
>  	dma_free_coherent(&pci_dev->dev, ndev->dma_size,
>  			ndev->dma_virt, ndev->dma_phys);
>  dma_alloc_err:
> -	free_irq(pci_dev->irq, pci_dev);
> -irq_request_err:
>  	iounmap(ndev->lmmio1);
>  pci_bar1_error:
>  	iounmap(ndev->lmmio0);

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--WUFgJ3P2V9We42OX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZIy1+AAKCRAw5/Bqldv6
8gDrAKCvBjMhvOg8OA9Ur99mEYfRHtkahgCfdlhmTq7oTObM0PyEosH8Lwk13Nk=
=9xtk
-----END PGP SIGNATURE-----

--WUFgJ3P2V9We42OX--
