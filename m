Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BC4600B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiJQJuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiJQJuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB31526ACB;
        Mon, 17 Oct 2022 02:50:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C422C60FF1;
        Mon, 17 Oct 2022 09:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8012CC433C1;
        Mon, 17 Oct 2022 09:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666000183;
        bh=UwY1+57tskbawvtQwNEitDpdaL5Aj5k0Npjk4S4RzBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QRv42+9TRbdTsMmVJzw6A+nrBM3Fd0jStzkzoVy25IxWJwBnurudOz5kXzN0OoyB6
         PBrl8DMNynMtCAeNkmC7OYZBv5mSXJUkxSoGyooHFHAZIfBR8nx6+EDDWINI5nS5fn
         sNU6q3mJ316dXpI8q+NGeADsLSkr6lm9egAR57TBWAhPPAUFYz9ovSag6RkRZwnzZR
         AK67MFHtZQfVLPNUFMFxKnuxN4wzketymA//YF0bP0Bo2Ux3yr84Dc/f3F59LO4m8x
         kJYq4vr6LZWqJWcHYpkyP2aiWvwJ/3amNr77yj5l/h7zDSE86XezoSPREtnIYg06+j
         gc7VD6Eeklz+A==
Date:   Mon, 17 Oct 2022 10:49:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     conor.dooley@microchip.com, daire.mcnamara@microchip.com,
        broonie@kernel.org, linux-riscv@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] spi: microchip-core: Remove the unused function
 mchp_corespi_enable()
Message-ID: <Y00lMjEncoxwkNiJ@spud>
References: <20221017092141.9789-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017092141.9789-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 05:21:41PM +0800, Jiapeng Chong wrote:
> The function mchp_corespi_enable() is defined in the spi-microchip-core.c
> file, but not called elsewhere, so delete this unused function.
> 
> drivers/spi/spi-microchip-core.c:122:20: warning: unused function 'mchp_corespi_enable'.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2418
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/spi/spi-microchip-core.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
> index d352844c798c..aeaa1da88f39 100644
> --- a/drivers/spi/spi-microchip-core.c
> +++ b/drivers/spi/spi-microchip-core.c
> @@ -119,15 +119,6 @@ static inline void mchp_corespi_write(struct mchp_corespi *spi, unsigned int reg
>  	writel(val, spi->regs + reg);
>  }
>  
> -static inline void mchp_corespi_enable(struct mchp_corespi *spi)
> -{
> -	u32 control = mchp_corespi_read(spi, REG_CONTROL);
> -
> -	control |= CONTROL_ENABLE;
> -
> -	mchp_corespi_write(spi, REG_CONTROL, control);
> -}

That's a bit silly... Thanks Jiapeng.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> -
>  static inline void mchp_corespi_disable(struct mchp_corespi *spi)
>  {
>  	u32 control = mchp_corespi_read(spi, REG_CONTROL);
> -- 
> 2.20.1.7.g153144c
> 
