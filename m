Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE6F627705
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbiKNIEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbiKNIEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:04:15 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADD6220
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:04:13 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 54E31240010;
        Mon, 14 Nov 2022 08:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668413052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cvKVGnbTF4i/qSpcUrTjr5cPePLfjlEgnVYVKtrHHPM=;
        b=TqDNsDAceBd8e2E8Jea/mSZZE3E50Rt2olFVg+yu/1KrHOvo4YNL5Kk9COOL/bv9tyJxHC
        1FXTDCr+U6OeBv4quKeO4+nYYpOTv1789rOqQr5kM7TFivHBYlj5KyrHizQaIB9FFcp3Hy
        JDZmsjseXSgJFbr/HMQxqzpIxtWkGdIF9LYj6emoL7fSgBBEfUdCZMSrcKbTX069fU7M4D
        zv0xFEcgCbWotA8E5xtcFRKGt/F1f0YUvnRR9WvOwIIrEQlL4LGkIJ8C2rfJvM75mhS4t/
        U1Vxdvb2tRS6L55D3imCZRjHo3EYuoMQOyjv2K5vDDF+NjZWyJd1bOOLhF49tg==
Date:   Mon, 14 Nov 2022 09:04:08 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <u.kleine-koenig@pengutronix.de>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <weiyongjun1@huawei.com>,
        <yusongping@huawei.com>
Subject: Re: [PATCH] mtd: lpddr2_nvm: i2c: mux: reg: Fix possible
 null-ptr-deref
Message-ID: <20221114090408.7ed0e7c1@xps-13>
In-Reply-To: <20221114020141.28138-1-tanghui20@huawei.com>
References: <20221114020141.28138-1-tanghui20@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hui,

tanghui20@huawei.com wrote on Mon, 14 Nov 2022 10:01:41 +0800:

> It will cause null-ptr-deref when resource_size(add_range) invoked,
> if platform_get_resource() returns NULL.
>=20
> Fixes: 96ba9dd65788 ("mtd: lpddr: add driver for LPDDR2-NVM PCM memories")
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> ---
>  drivers/mtd/lpddr/lpddr2_nvm.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mtd/lpddr/lpddr2_nvm.c b/drivers/mtd/lpddr/lpddr2_nv=
m.c
> index 367e2d906de0..cf8e86eb4b2c 100644
> --- a/drivers/mtd/lpddr/lpddr2_nvm.c
> +++ b/drivers/mtd/lpddr/lpddr2_nvm.c
> @@ -433,6 +433,8 @@ static int lpddr2_nvm_probe(struct platform_device *p=
dev)
> =20
>  	/* lpddr2_nvm address range */
>  	add_range =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (IS_ERR(add_range))

platform_get_resource() just returns NULL upon error.

> +		return -ENODEV;
> =20
>  	/* Populate map_info data structure */
>  	*map =3D (struct map_info) {


Thanks,
Miqu=C3=A8l
