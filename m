Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8CE725770
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbjFGIWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbjFGIWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:22:38 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C6D188
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:22:36 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686126155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DpORB+IN6U+aRu3L9s9vgXbxWmRnjryOsKFqv22aZm8=;
        b=CWBDB0i0rSuNMui67RHlpy7Ed4YOz1WXtKly2mWK2WdpbkPNGr2FT4492mNFMRWI8IWsOO
        cMD9ZGmAQaav5Vtx0SYk26C38n+HKYf2+jY/IDtaLWRxKU8xCinapo/jc5RZxHIUMvnaml
        Utx/sX+lurARDrmaFAJ0QQ2rY05pUCicdI+KSAHou8uBDY6ghRBZt9IAY6oxhLKywJ5KVh
        ucJN/tnHuI5/dZ5fL+q/rC5a6PTS4WmVDZrUK8XdfT8dfOHS7Uh9Y1UuHARCOmfydJL5QY
        K7s1iGoGFnUeFoad9kqsHl3RxIuEawE7S+PxwPbPZJej6qNzLc+0P0JrEobGAw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 387CF4000B;
        Wed,  7 Jun 2023 08:22:33 +0000 (UTC)
Date:   Wed, 7 Jun 2023 10:22:32 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>,
        f.fainelli@gmail.com, rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/12] mtd: rawnand: brcmnand: Add BCMBCA read data bus
 interface
Message-ID: <20230607102232.17c4a27b@xps-13>
In-Reply-To: <20230606231252.94838-11-william.zhang@broadcom.com>
References: <20230606231252.94838-1-william.zhang@broadcom.com>
        <20230606231252.94838-11-william.zhang@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

william.zhang@broadcom.com wrote on Tue,  6 Jun 2023 16:12:50 -0700:

> The BCMBCA broadband SoC integrates the NAND controller differently than
> STB, iProc and other SoCs.  It has different endianness for NAND cache
> data and ONFI parameter data.
>=20
> Add a SoC read data bus shim for BCMBCA to meet the specific SoC need
> and performance improvement using the optimized memcpy function on NAND
> cache memory.
>=20
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
>=20
>  drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c | 36 +++++++++++++++++
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c    | 44 ++++++++++++++-------
>  drivers/mtd/nand/raw/brcmnand/brcmnand.h    |  2 +
>  3 files changed, 68 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c b/drivers/mtd/na=
nd/raw/brcmnand/bcmbca_nand.c
> index 7e48b6a0bfa2..899103a62c98 100644
> --- a/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c
> @@ -26,6 +26,18 @@ enum {
>  	BCMBCA_CTLRDY		=3D BIT(4),
>  };
> =20
> +#if defined(CONFIG_ARM64)
> +#define ALIGN_REQ		8
> +#else
> +#define ALIGN_REQ		4
> +#endif
> +
> +static inline bool bcmbca_nand_is_buf_aligned(void *flash_cache,  void *=
buffer)
> +{
> +	return IS_ALIGNED((uintptr_t)buffer, ALIGN_REQ) &&
> +				IS_ALIGNED((uintptr_t)flash_cache, ALIGN_REQ);
> +}
> +
>  static bool bcmbca_nand_intc_ack(struct brcmnand_soc *soc)
>  {
>  	struct bcmbca_nand_soc *priv =3D
> @@ -56,6 +68,29 @@ static void bcmbca_nand_intc_set(struct brcmnand_soc *=
soc, bool en)
>  	brcmnand_writel(val, mmio);
>  }
> =20
> +static void bcmbca_read_data_bus(struct brcmnand_soc *soc,
> +				 void __iomem *flash_cache,  u32 *buffer,
> +				 int fc_words, bool is_param)
> +{
> +	int i;
> +
> +	if (!is_param) {
> +		/*
> +		 * memcpy can do unaligned aligned access depending on source
> +		 * and dest address, which is incompatible with nand cache. Fallback
> +		 * to the memcpy for io version
> +		 */
> +		if (bcmbca_nand_is_buf_aligned(flash_cache, buffer))
> +			memcpy((void *)buffer, (void *)flash_cache, fc_words * 4);
> +		else
> +			memcpy_fromio((void *)buffer, (void *)flash_cache, fc_words * 4);
> +	} else {
> +		/* Flash cache has same endian as the host for parameter pages */
> +		for (i =3D 0; i < fc_words; i++, buffer++)
> +			*buffer =3D __raw_readl(flash_cache + i * 4);
> +	}
> +}
> +
>  static int bcmbca_nand_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> @@ -75,6 +110,7 @@ static int bcmbca_nand_probe(struct platform_device *p=
dev)
> =20
>  	soc->ctlrdy_ack =3D bcmbca_nand_intc_ack;
>  	soc->ctlrdy_set_enabled =3D bcmbca_nand_intc_set;
> +	soc->read_data_bus =3D bcmbca_read_data_bus;
> =20
>  	return brcmnand_probe(pdev, soc);
>  }
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.c
> index d920e88c7f5b..656be4d73016 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -814,6 +814,30 @@ static inline u32 edu_readl(struct brcmnand_controll=
er *ctrl,
>  	return brcmnand_readl(ctrl->edu_base + offs);
>  }
> =20
> +static inline void brcmnand_read_data_bus(struct brcmnand_controller *ct=
rl,
> +					   void __iomem *flash_cache, u32 *buffer,
> +					   int fc_words, bool is_param)
> +{
> +	struct brcmnand_soc *soc =3D ctrl->soc;
> +	int i;
> +
> +	if (soc->read_data_bus) {
> +		soc->read_data_bus(soc, flash_cache, buffer, fc_words, is_param);
> +	} else {
> +		if (!is_param) {
> +			for (i =3D 0; i < fc_words; i++, buffer++)
> +				*buffer =3D brcmnand_read_fc(ctrl, i);
> +		} else {
> +			for (i =3D 0; i < fc_words; i++)
> +				/*
> +				 * Flash cache is big endian for parameter pages, at
> +				 * least on STB SoCs
> +				 */
> +				buffer[i] =3D be32_to_cpu(brcmnand_read_fc(ctrl, i));
> +		}
> +	}

Perhaps we could have a single function that is statically assigned at
probe time instead of a first helper with two conditions which calls in
one case another hook... This can be simplified I guess.

> +}
> +
>  static void brcmnand_clear_ecc_addr(struct brcmnand_controller *ctrl)
>  {
> =20
> @@ -1811,20 +1835,11 @@ static void brcmnand_cmdfunc(struct nand_chip *ch=
ip, unsigned command,
>  			native_cmd =3D=3D CMD_PARAMETER_CHANGE_COL) {
>  		/* Copy flash cache word-wise */
>  		u32 *flash_cache =3D (u32 *)ctrl->flash_cache;
> -		int i;
> =20
>  		brcmnand_soc_data_bus_prepare(ctrl->soc, true);
> =20
> -		/*
> -		 * Must cache the FLASH_CACHE now, since changes in
> -		 * SECTOR_SIZE_1K may invalidate it
> -		 */
> -		for (i =3D 0; i < FC_WORDS; i++)
> -			/*
> -			 * Flash cache is big endian for parameter pages, at
> -			 * least on STB SoCs
> -			 */
> -			flash_cache[i] =3D be32_to_cpu(brcmnand_read_fc(ctrl, i));
> +		brcmnand_read_data_bus(ctrl, ctrl->nand_fc, flash_cache,
> +				   FC_WORDS, true);
> =20
>  		brcmnand_soc_data_bus_unprepare(ctrl->soc, true);
> =20
> @@ -2137,7 +2152,7 @@ static int brcmnand_read_by_pio(struct mtd_info *mt=
d, struct nand_chip *chip,
>  {
>  	struct brcmnand_host *host =3D nand_get_controller_data(chip);
>  	struct brcmnand_controller *ctrl =3D host->ctrl;
> -	int i, j, ret =3D 0;
> +	int i, ret =3D 0;
> =20
>  	brcmnand_clear_ecc_addr(ctrl);
> =20
> @@ -2150,8 +2165,9 @@ static int brcmnand_read_by_pio(struct mtd_info *mt=
d, struct nand_chip *chip,
>  		if (likely(buf)) {
>  			brcmnand_soc_data_bus_prepare(ctrl->soc, false);
> =20
> -			for (j =3D 0; j < FC_WORDS; j++, buf++)
> -				*buf =3D brcmnand_read_fc(ctrl, j);
> +			brcmnand_read_data_bus(ctrl, ctrl->nand_fc, buf,
> +					FC_WORDS, false);
> +			buf +=3D FC_WORDS;
> =20
>  			brcmnand_soc_data_bus_unprepare(ctrl->soc, false);
>  		}
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.h b/drivers/mtd/nand/=
raw/brcmnand/brcmnand.h
> index f1f93d85f50d..88819bc395f8 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
> @@ -24,6 +24,8 @@ struct brcmnand_soc {
>  	void (*ctlrdy_set_enabled)(struct brcmnand_soc *soc, bool en);
>  	void (*prepare_data_bus)(struct brcmnand_soc *soc, bool prepare,
>  				 bool is_param);
> +	void (*read_data_bus)(struct brcmnand_soc *soc, void __iomem *flash_cac=
he,
> +				 u32 *buffer, int fc_words, bool is_param);
>  	const struct brcmnand_io_ops *ops;
>  };
> =20


Thanks,
Miqu=C3=A8l
