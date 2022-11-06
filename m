Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EEB61E720
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 23:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiKFWyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 17:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiKFWyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 17:54:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938056153;
        Sun,  6 Nov 2022 14:54:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DD7EB80C85;
        Sun,  6 Nov 2022 22:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8997CC433D6;
        Sun,  6 Nov 2022 22:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667775248;
        bh=CCOXKsk1YG6cytIhCugUYJ5LpHswjB66YukQZnjJrb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dHI5IDuxp1uLkeFTUcpRH3bRKYCLaI4GmrmUFk/iFG3nvE5gcAwQBdoS7zh+QeLu1
         7f5/j4eVo3ADiBkrPFu/GxybEOmWlwVtRjHWfwrTC/46ZDNAN6kUIpmNY3kZksY90I
         OdbFe6BYMYjJZALw9ciO/Hcb6dxTBoyEIn3mcecQIwDIH6TpGF6FYqMhLX+OckU8ym
         aF3Ikni8lpbyq1Qcy/7iN3Mlil65LlBdW0XSvo3nc+SnRQo7v+czAs1Esld+tX+W5A
         TgFsXXSFhLpPhzCfLZnEwLMjU1Sp615Ol+5fZZSPZV1vBPaTavbDBf4MfVNUxdNb0X
         hebEDEeu3Bj9w==
Date:   Sun, 6 Nov 2022 23:54:06 +0100
From:   Pratyush Yadav <pratyush@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Bayi Cheng <bayi.cheng@mediatek.com>
Subject: Re: [PATCH] mtd: spi-nor: Fix the number of bytes for the dummy
 cycles
Message-ID: <20221106225406.o36syeso4prdi7yn@yadavpratyush.com>
References: <20221031124633.13189-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031124633.13189-1-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/22 08:46PM, Allen-KH Cheng wrote:
> The number of bytes used by spi_nor_spimem_check_readop() may be
> incorrect for the dummy cycles. Since nor->read_dummy is not initialized
> before spi_nor_spimem_adjust_hwcaps().
> 
> We use both mode and wait state clock cycles instead of nor->read_dummy.
> 
> Fixes: 0e30f47232ab ("mtd: spi-nor: add support for DTR protocol")
> Co-developed-by: Bayi Cheng <bayi.cheng@mediatek.com>
> Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  drivers/mtd/spi-nor/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 6c921eb3fadb..8b9c318a0ad4 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1914,7 +1914,8 @@ static int spi_nor_spimem_check_readop(struct spi_nor *nor,
>  	spi_nor_spimem_setup_op(nor, &op, read->proto);
>  
>  	/* convert the dummy cycles to the number of bytes */
> -	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
> +	op.dummy.nbytes = (read->num_mode_clocks + read->num_wait_states) *
> +			  op.dummy.buswidth / 8;

Good catch!

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

>  	if (spi_nor_protocol_is_dtr(nor->read_proto))
>  		op.dummy.nbytes *= 2;
>  
> -- 
> 2.18.0
> 

-- 
Regards,
Pratyush Yadav
