Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0EC74FADA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjGKWTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjGKWTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:19:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D710170E;
        Tue, 11 Jul 2023 15:19:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09F7261633;
        Tue, 11 Jul 2023 22:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F58CC433C8;
        Tue, 11 Jul 2023 22:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689113974;
        bh=QiGw3IUmr9u/cOXBUpvP1n/R7zjakhkvbq/PAFBNEp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oYg6NhE+Pz+v/gyFwkwdF7lFqFLPjS89DaJiIiBqzRWgCfhVDHoZjEizizD0k4UdB
         HhJFpGwqU+s+XT7MhXwa55AgsPKIn29094qxuq6CdqWazdCB1Fl8SwoiMWrsaHxHf2
         vPad4VT+/T/2VyQf8+D6fzv0L3GuvSGpk3hgmlA5xV+e2+43vYxOMlWlnZGDQDmtXX
         EUne5GcZLKV8LLGIXL1G3ZckKNRNw/ei3pYfxNWgmHul6Ky5oepE+c1n6oH5atXZXf
         PNjkGrY0UHR8P765AlVP24pS91y8Ik32a2b4y3zmchLKxyoi15fmiTNy2+e8L1Pj1u
         a8Pdeyrx2eOHA==
Date:   Wed, 12 Jul 2023 00:19:30 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH] spi: s3c64xx: clear loopback bit after loopback test
Message-ID: <20230711221930.2qinef626kxtthsv@intel.intel>
References: <CGME20230711082508epcas2p3088d488035e7e2910bf087d640e9c268@epcas2p3.samsung.com>
 <20230711082020.138165-1-jaewon02.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711082020.138165-1-jaewon02.kim@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaewon,

On Tue, Jul 11, 2023 at 05:20:20PM +0900, Jaewon Kim wrote:
> When SPI loopback transfer is performed, S3C64XX_SPI_MODE_SELF_LOOPBACK
> bit still remained. It works as loopback even if the next transfer is
> not spi loopback mode.
> If not SPI_LOOP, needs to clear S3C64XX_SPI_MODE_SELF_LOOPBACK bit.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>

with the change suggested by Chanho:

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Mark, can you add the

Fixes: ffb7bcd3b27e ("spi: s3c64xx: support loopback mode")

tag or should Jaewon resend?

Thanks,
Andi

> ---
>  drivers/spi/spi-s3c64xx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index fd55697144cc..b6c2659a66ca 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -684,6 +684,8 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
>  
>  	if ((sdd->cur_mode & SPI_LOOP) && sdd->port_conf->has_loopback)
>  		val |= S3C64XX_SPI_MODE_SELF_LOOPBACK;
> +	else
> +		val &= ~S3C64XX_SPI_MODE_SELF_LOOPBACK;
>  
>  	writel(val, regs + S3C64XX_SPI_MODE_CFG);
>  
> -- 
> 2.17.1
> 
