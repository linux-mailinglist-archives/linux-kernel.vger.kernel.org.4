Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAF85BD11A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiISPeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISPeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:34:12 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FA124F17
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 08:34:11 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EF5A46000C;
        Mon, 19 Sep 2022 15:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663601650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=otCWrPNWQ5MomFUk/X90/eu5c24/hNv1Pq/ZremXurw=;
        b=gZVIhA5r0CA2UzxC+RfomSYhPEnzOIktGl7i+FeBA63klk5KjrktWPhjnZmnxtsAozovHs
        Fh23dxVr/syQIdjfZ2sAN5EjiD65blsZwLxtmvP+x9Ti/9ETQlxafJ5H/bfZMEDUPis3Ol
        BzIwdSH996b6JPSqE33YDuM9N9vLjpVbrVRql+EMr6SG3yIj3OHGS0OdrM7OuE09uBta/L
        piCxbAEJBVyoUVsLFYlOep9MRkFUqQmiMkEMZOT5vsYyf/Ov37VLkLEvWOFF57OmwVypDu
        f68i0FrKLLjxqMAHgAA73LRjoBXKpmyjXiWwGl6pdsMsLlezHTxsM4ZfYjuULA==
Date:   Mon, 19 Sep 2022 17:34:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangweiyang2@huawei.com>
Subject: Re: [PATCH] mtd: rawnand: denali: Fix a possible resource leak in
 denali_pci_probe
Message-ID: <20220919173407.7068709a@xps-13>
In-Reply-To: <20220801080315.1713934-1-gongruiqi1@huawei.com>
References: <20220801080315.1713934-1-gongruiqi1@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ruiqi,

gongruiqi1@huawei.com wrote on Mon, 1 Aug 2022 16:03:15 +0800:

> Call pci_release_regions() to retrieve the allocated resource when
> devm_ioremap() or denali_init() failed.

				  fail
>=20
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
>  drivers/mtd/nand/raw/denali_pci.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/denali_pci.c b/drivers/mtd/nand/raw/den=
ali_pci.c
> index de7e722d3826..40943cda0914 100644
> --- a/drivers/mtd/nand/raw/denali_pci.c
> +++ b/drivers/mtd/nand/raw/denali_pci.c
> @@ -74,21 +74,22 @@ static int denali_pci_probe(struct pci_dev *dev, cons=
t struct pci_device_id *id)
>  		return ret;
>  	}
> =20
> +	ret =3D -ENOMEM;

I don't like so much this construction as later changes in the probe
might just fail this logic.

Please just set ret =3D -ENOMEM; in the error path each time it's needed.
I don't care about loosing 3 lines of code if it clarifies what the
error path returns.

>  	denali->reg =3D devm_ioremap(denali->dev, csr_base, csr_len);
>  	if (!denali->reg) {
>  		dev_err(&dev->dev, "Spectra: Unable to remap memory region\n");
> -		return -ENOMEM;
> +		goto out_release_pci;
>  	}
> =20
>  	denali->host =3D devm_ioremap(denali->dev, mem_base, mem_len);
>  	if (!denali->host) {
>  		dev_err(&dev->dev, "Spectra: ioremap failed!");
> -		return -ENOMEM;
> +		goto out_release_pci;
>  	}
> =20
>  	ret =3D denali_init(denali);
>  	if (ret)
> -		return ret;
> +		goto out_release_pci;
> =20
>  	nsels =3D denali->nbanks;
> =20
> @@ -116,6 +117,8 @@ static int denali_pci_probe(struct pci_dev *dev, cons=
t struct pci_device_id *id)
> =20
>  out_remove_denali:
>  	denali_remove(denali);
> +out_release_pci:
> +	pci_release_regions(dev);
>  	return ret;
>  }
> =20


Thanks,
Miqu=C3=A8l
