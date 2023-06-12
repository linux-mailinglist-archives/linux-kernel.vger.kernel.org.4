Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0600272CBE5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbjFLQyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjFLQyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:54:04 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95995E6F;
        Mon, 12 Jun 2023 09:54:02 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686588841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NFGxXNGT2vK1aUEX2eyULHFBjMjXTv31072os0BOR0g=;
        b=mHk7ZmABb6+jLf8CSEj5alyT7gtzsLQ/af3KkhMXMBK865t1U4a9QYi89GSejccyVDNYO1
        HA27/ujiKRz535P9LvuKW0o/Tj08WfULwQYETjKw9J7prUAap7rVXHM+zXQkEy8H+P6wM+
        A2cb8AIWYGMACEwwlTFggRH/v5WpNhDxQZ2FQ3lHra0CnY087M/uT7Qj8nyb1N7bxSHXtu
        banLsigVSie9/0MxbAuKMc2S/c70jxXhyFuUYbpY+RyyLfaYI21PLDppKfee2WB5T+hdD2
        dE8dxZ7h57tjG69bo2CpTyDxH8EbY2GGe4peU8Wbw4E4MIp8D4ohFUZOsAhyTQ==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB50F20003;
        Mon, 12 Jun 2023 16:53:56 +0000 (UTC)
Date:   Mon, 12 Jun 2023 18:53:54 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Jaime Liao <jaimeliao.tw@gmail.com>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Mason Yang <masonccyang@mxic.com.tw>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>
Subject: Re: [PATCH v4] mtd: rawnand: macronix: OTP access for MX30LFxG18AC
Message-ID: <20230612185354.09b88e0d@xps-13>
In-Reply-To: <20230523101637.3009746-1-AVKrasnov@sberdevices.ru>
References: <20230523101637.3009746-1-AVKrasnov@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

AVKrasnov@sberdevices.ru wrote on Tue, 23 May 2023 13:16:34 +0300:

> This adds support for OTP area access on MX30LFxG18AC chip series.

Jaime, any feedback on this? Will you test it?

How are we supposed to test the OTP is locked? I see this is still an
open point.

>=20
> Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> ---
>   v1 -> v2:
>   * Add slab.h include due to kernel test robot error.
>   v2 -> v3:
>   * Use 'uint64_t' as input argument for 'do_div()' instead
>     of 'unsigned long' due to kernel test robot error.
>   v3 -> v4:
>   * Use 'dev_err()' instead of 'WARN()'.
>   * Call 'match_string()' before checking 'supports_set_get_features'
>     in 'macronix_nand_setup_otp().
>   * Use 'u8' instead of 'uint8_t' as ./checkpatch.pl wants.
>=20
>  drivers/mtd/nand/raw/nand_macronix.c | 216 +++++++++++++++++++++++++++
>  1 file changed, 216 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/=
nand_macronix.c
> index 1472f925f386..be1ffa93bebb 100644
> --- a/drivers/mtd/nand/raw/nand_macronix.c
> +++ b/drivers/mtd/nand/raw/nand_macronix.c
> @@ -6,6 +6,7 @@
>   * Author: Boris Brezillon <boris.brezillon@free-electrons.com>
>   */
> =20
> +#include <linux/slab.h>
>  #include "linux/delay.h"
>  #include "internals.h"
> =20
> @@ -31,6 +32,20 @@
> =20
>  #define MXIC_CMD_POWER_DOWN 0xB9
> =20
> +#define ONFI_FEATURE_ADDR_30LFXG18AC_OTP	0x90
> +#define MACRONIX_30LFXG18AC_OTP_START_PAGE	0
> +#define MACRONIX_30LFXG18AC_OTP_PAGES		30
> +#define MACRONIX_30LFXG18AC_OTP_PAGE_SIZE	2112
> +#define MACRONIX_30LFXG18AC_OTP_START_BYTE	\
> +	(MACRONIX_30LFXG18AC_OTP_START_PAGE *	\
> +	 MACRONIX_30LFXG18AC_OTP_PAGE_SIZE)
> +#define MACRONIX_30LFXG18AC_OTP_SIZE_BYTES	\
> +	(MACRONIX_30LFXG18AC_OTP_PAGES *	\
> +	 MACRONIX_30LFXG18AC_OTP_PAGE_SIZE)
> +
> +#define MACRONIX_30LFXG18AC_OTP_EN		BIT(0)
> +#define MACRONIX_30LFXG18AC_OTP_LOCKED		BIT(1)
> +
>  struct nand_onfi_vendor_macronix {
>  	u8 reserved;
>  	u8 reliability_func;
> @@ -316,6 +331,206 @@ static void macronix_nand_deep_power_down_support(s=
truct nand_chip *chip)
>  	chip->ops.resume =3D mxic_nand_resume;
>  }
> =20
> +static int macronix_30lfxg18ac_get_otp_info(struct mtd_info *mtd, size_t=
 len,
> +					    size_t *retlen,
> +					    struct otp_info *buf)
> +{
> +	if (len < sizeof(*buf))
> +		return -EINVAL;
> +
> +	/* Don't know how to check that OTP is locked. */
> +	buf->locked =3D 0;
> +	buf->start =3D MACRONIX_30LFXG18AC_OTP_START_BYTE;
> +	buf->length =3D MACRONIX_30LFXG18AC_OTP_SIZE_BYTES;
> +
> +	*retlen =3D sizeof(*buf);
> +
> +	return 0;
> +}
> +
> +static int macronix_30lfxg18ac_otp_enable(struct nand_chip *nand)
> +{
> +	u8 feature_buf[ONFI_SUBFEATURE_PARAM_LEN] =3D { 0 };
> +
> +	feature_buf[0] =3D MACRONIX_30LFXG18AC_OTP_EN;
> +	return nand_set_features(nand, ONFI_FEATURE_ADDR_30LFXG18AC_OTP,
> +				 feature_buf);
> +}
> +
> +static int macronix_30lfxg18ac_otp_disable(struct nand_chip *nand)
> +{
> +	u8 feature_buf[ONFI_SUBFEATURE_PARAM_LEN] =3D { 0 };
> +
> +	return nand_set_features(nand, ONFI_FEATURE_ADDR_30LFXG18AC_OTP,
> +				 feature_buf);
> +}
> +
> +static int __macronix_30lfxg18ac_rw_otp(struct mtd_info *mtd,
> +					loff_t offs_in_flash,
> +					size_t len, size_t *retlen,
> +					u_char *buf, bool write)
> +{
> +	struct nand_chip *nand;
> +	size_t bytes_handled;
> +	off_t offs_in_page;
> +	void *dma_buf;
> +	u64 page;
> +	int ret;
> +
> +	/* 'nand_prog/read_page_op()' may use 'buf' as DMA buffer,
> +	 * so allocate properly aligned memory for it. This is
> +	 * needed because cross page accesses may lead to unaligned
> +	 * buffer address for DMA.
> +	 */
> +	dma_buf =3D kmalloc(MACRONIX_30LFXG18AC_OTP_PAGE_SIZE, GFP_KERNEL);
> +	if (!dma_buf)
> +		return -ENOMEM;
> +
> +	nand =3D mtd_to_nand(mtd);
> +	nand_select_target(nand, 0);
> +
> +	ret =3D macronix_30lfxg18ac_otp_enable(nand);
> +	if (ret)
> +		goto out_otp;
> +
> +	page =3D offs_in_flash;
> +	/* 'page' will be result of division. */
> +	offs_in_page =3D do_div(page, MACRONIX_30LFXG18AC_OTP_PAGE_SIZE);
> +	bytes_handled =3D 0;
> +
> +	while (bytes_handled < len &&
> +	       page < MACRONIX_30LFXG18AC_OTP_PAGES) {
> +		size_t bytes_to_handle;
> +
> +		bytes_to_handle =3D min_t(size_t, len - bytes_handled,
> +					MACRONIX_30LFXG18AC_OTP_PAGE_SIZE -
> +					offs_in_page);
> +
> +		if (write) {
> +			memcpy(dma_buf, &buf[bytes_handled], bytes_to_handle);
> +			ret =3D nand_prog_page_op(nand, page, offs_in_page,
> +						dma_buf, bytes_to_handle);
> +		} else {
> +			ret =3D nand_read_page_op(nand, page, offs_in_page,
> +						dma_buf, bytes_to_handle);
> +			if (!ret)
> +				memcpy(&buf[bytes_handled], dma_buf,
> +				       bytes_to_handle);
> +		}
> +		if (ret)
> +			goto out_otp;
> +
> +		bytes_handled +=3D bytes_to_handle;
> +		offs_in_page =3D 0;
> +		page++;
> +	}
> +
> +	*retlen =3D bytes_handled;
> +
> +out_otp:
> +	if (ret)
> +		dev_err(&mtd->dev, "failed to perform OTP IO: %i\n", ret);
> +
> +	ret =3D macronix_30lfxg18ac_otp_disable(nand);
> +	if (ret)
> +		dev_err(&mtd->dev, "failed to leave OTP mode after %s\n",
> +			write ? "write" : "read");
> +
> +	nand_deselect_target(nand);
> +	kfree(dma_buf);
> +
> +	return ret;
> +}
> +
> +static int macronix_30lfxg18ac_write_otp(struct mtd_info *mtd, loff_t to,
> +					 size_t len, size_t *rlen,
> +					 const u_char *buf)
> +{
> +	return __macronix_30lfxg18ac_rw_otp(mtd, to, len, rlen, (u_char *)buf,
> +					    true);
> +}
> +
> +static int macronix_30lfxg18ac_read_otp(struct mtd_info *mtd, loff_t fro=
m,
> +					size_t len, size_t *rlen,
> +					u_char *buf)
> +{
> +	return __macronix_30lfxg18ac_rw_otp(mtd, from, len, rlen, buf, false);
> +}
> +
> +static int macronix_30lfxg18ac_lock_otp(struct mtd_info *mtd, loff_t fro=
m,
> +					size_t len)
> +{
> +	u8 feature_buf[ONFI_SUBFEATURE_PARAM_LEN] =3D { 0 };
> +	struct nand_chip *nand;
> +	int ret;
> +
> +	if (from !=3D MACRONIX_30LFXG18AC_OTP_START_BYTE ||
> +	    len !=3D MACRONIX_30LFXG18AC_OTP_SIZE_BYTES)
> +		return -EINVAL;
> +
> +	dev_dbg(&mtd->dev, "locking OTP\n");
> +
> +	nand =3D mtd_to_nand(mtd);
> +	nand_select_target(nand, 0);
> +
> +	feature_buf[0] =3D MACRONIX_30LFXG18AC_OTP_EN |
> +			 MACRONIX_30LFXG18AC_OTP_LOCKED;
> +	ret =3D nand_set_features(nand, ONFI_FEATURE_ADDR_30LFXG18AC_OTP,
> +				feature_buf);
> +	if (ret) {
> +		dev_err(&mtd->dev,
> +			"failed to lock OTP (set features): %i\n", ret);
> +		nand_deselect_target(nand);
> +		return ret;
> +	}
> +
> +	/* Do dummy page prog with zero address. */
> +	feature_buf[0] =3D 0;
> +	ret =3D nand_prog_page_op(nand, 0, 0, feature_buf, 1);
> +	if (ret)
> +		dev_err(&mtd->dev,
> +			"failed to lock OTP (page prog): %i\n", ret);
> +
> +	ret =3D macronix_30lfxg18ac_otp_disable(nand);
> +	if (ret)
> +		dev_err(&mtd->dev, "failed to leave OTP mode after lock\n");
> +
> +	nand_deselect_target(nand);
> +
> +	return ret;
> +}
> +
> +static void macronix_nand_setup_otp(struct nand_chip *chip)
> +{
> +	static const char * const supported_otp_models[] =3D {
> +		"MX30LF1G18AC",
> +		"MX30LF2G18AC",
> +		"MX30LF4G18AC",
> +	};
> +	struct mtd_info *mtd;
> +
> +	if (match_string(supported_otp_models,
> +			 ARRAY_SIZE(supported_otp_models),
> +			 chip->parameters.model) < 0)
> +		return;
> +
> +	if (!chip->parameters.supports_set_get_features)
> +		return;
> +
> +	bitmap_set(chip->parameters.get_feature_list,
> +		   ONFI_FEATURE_ADDR_30LFXG18AC_OTP, 1);
> +	bitmap_set(chip->parameters.set_feature_list,
> +		   ONFI_FEATURE_ADDR_30LFXG18AC_OTP, 1);
> +
> +	mtd =3D nand_to_mtd(chip);
> +	mtd->_get_fact_prot_info =3D macronix_30lfxg18ac_get_otp_info;
> +	mtd->_read_fact_prot_reg =3D macronix_30lfxg18ac_read_otp;
> +	mtd->_get_user_prot_info =3D macronix_30lfxg18ac_get_otp_info;
> +	mtd->_read_user_prot_reg =3D macronix_30lfxg18ac_read_otp;
> +	mtd->_write_user_prot_reg =3D macronix_30lfxg18ac_write_otp;
> +	mtd->_lock_user_prot_reg =3D macronix_30lfxg18ac_lock_otp;
> +}
> +
>  static int macronix_nand_init(struct nand_chip *chip)
>  {
>  	if (nand_is_slc(chip))
> @@ -325,6 +540,7 @@ static int macronix_nand_init(struct nand_chip *chip)
>  	macronix_nand_onfi_init(chip);
>  	macronix_nand_block_protection_support(chip);
>  	macronix_nand_deep_power_down_support(chip);
> +	macronix_nand_setup_otp(chip);
> =20
>  	return 0;
>  }


Thanks,
Miqu=C3=A8l
