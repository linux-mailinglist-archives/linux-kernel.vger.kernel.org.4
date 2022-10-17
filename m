Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F52A600AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiJQJft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiJQJfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:35:38 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1CD5A827;
        Mon, 17 Oct 2022 02:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1665999277; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GeDt2s8rzg1Q+BLHuQW/3eUdGAnY4/eHL4oRJbtI0c8=;
        b=dQijxU+88mqZJNTLpOfo0QEt+EnW/LPig0GNRnPdyX6Wlohjv8ynxuY6RjL547nHczZkHO
        +u3iZMRRpPScwEy6aky42P5yXpB5tb4KdnKJQu9y2tRvabdMqRGhkxzAAzUV+pccoOLcRY
        UV8jejG+FhroB99mdSOvR7YaJiZ8yEM=
Date:   Mon, 17 Oct 2022 10:34:20 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 2/2] dmaengine: JZ4780: Add support for the JZ4755.
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Message-Id: <895WJR.03DS0G5N9R0V1@crapouillou.net>
In-Reply-To: <20221016151256.3021729-3-lis8215@gmail.com>
References: <20221016151256.3021729-1-lis8215@gmail.com>
        <20221016151256.3021729-3-lis8215@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siarhei,

Le dim., oct. 16 2022 at 18:12:56 +0300, Siarhei Volkau=20
<lis8215@gmail.com> a =E9crit :
> The JZ4755 has 4 DMA channels per DMA unit, two idential DMA units.
>=20
> The JZ4755 has the similar DMA engine to JZ4725b, so I assume it has=20
> the
> same bug as JZ4725b, see commit a40c94be2336.

Can you verify that?

It should be pretty simple, if it has the bug you'll see I/O errors on=20
the SD card.

Cheers,
-Paul

> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> ---
>  drivers/dma/dma-jz4780.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index 2a483802d..9c1a6e9a9 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -1038,6 +1038,13 @@ static const struct jz4780_dma_soc_data=20
> jz4725b_dma_soc_data =3D {
>  		 JZ_SOC_DATA_BREAK_LINKS,
>  };
>=20
> +static const struct jz4780_dma_soc_data jz4755_dma_soc_data =3D {
> +	.nb_channels =3D 4,
> +	.transfer_ord_max =3D 5,
> +	.flags =3D JZ_SOC_DATA_PER_CHAN_PM | JZ_SOC_DATA_NO_DCKES_DCKEC |
> +		 JZ_SOC_DATA_BREAK_LINKS,
> +};
> +
>  static const struct jz4780_dma_soc_data jz4760_dma_soc_data =3D {
>  	.nb_channels =3D 5,
>  	.transfer_ord_max =3D 6,
> @@ -1101,6 +1108,7 @@ static const struct jz4780_dma_soc_data=20
> x1830_dma_soc_data =3D {
>  static const struct of_device_id jz4780_dma_dt_match[] =3D {
>  	{ .compatible =3D "ingenic,jz4740-dma", .data =3D &jz4740_dma_soc_data=20
> },
>  	{ .compatible =3D "ingenic,jz4725b-dma", .data =3D=20
> &jz4725b_dma_soc_data },
> +	{ .compatible =3D "ingenic,jz4755-dma", .data =3D &jz4755_dma_soc_data=20
> },
>  	{ .compatible =3D "ingenic,jz4760-dma", .data =3D &jz4760_dma_soc_data=20
> },
>  	{ .compatible =3D "ingenic,jz4760-mdma", .data =3D=20
> &jz4760_mdma_soc_data },
>  	{ .compatible =3D "ingenic,jz4760-bdma", .data =3D=20
> &jz4760_bdma_soc_data },
> --
> 2.36.1
>=20


