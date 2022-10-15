Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6969B5FFB08
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJOPak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJOPaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:30:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E44476DF;
        Sat, 15 Oct 2022 08:30:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FFCE60E14;
        Sat, 15 Oct 2022 15:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491CFC433D6;
        Sat, 15 Oct 2022 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665847832;
        bh=nixhoSTGPVkYcTwdctFtaCQC9NEWMN2p+NkTGqnMAzc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jThOJI5J3IcZpSgVnCz5ezAhUxouPL/gYLLAns+c5MKPUOJ6Dfom3BEqPuIJmLU58
         q8fTETdcv2QM3/P3VfjTs6lr75iIE7UPkyNhLsIA0sogQ6SCQp2gBJqwP9GMVN0nOF
         FzNINszJ0I36dHWJWZzqnWC1umXu22l6vvEU5kHl0mNveOZXgrhMSAAs0X1e+AZ8NL
         NB8k263Ol+6WzYCZOHRL8ZuJqyBvJqRbzb2TIun0+wOZDpSAx3hIEbQFTcjW40JTPx
         ByyiVTYcLvJKShgq69aJvr9j/HagmwUYE4tuXwe5145AolTKbMHrEaCLnMQq4RGoyx
         4Go4f6UsqOrnA==
Date:   Sat, 15 Oct 2022 16:30:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mcp3911: mask out device ID in debug prints
Message-ID: <20221015163056.3d1cf27e@jic23-huawei>
In-Reply-To: <20221010194654.676525-1-marcus.folkesson@gmail.com>
References: <20221010194654.676525-1-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 21:46:54 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> The Device ID should not be included when printing register.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Whilst obviously not super important to backport, this is a fix
so I've applied it to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/mcp3911.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index 2c1af11a621f..a71df9f3ab29 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -59,6 +59,7 @@
>  
>  #define MCP3911_REG_READ(reg, id)	((((reg) << 1) | ((id) << 6) | (1 << 0)) & 0xff)
>  #define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 6) | (0 << 0)) & 0xff)
> +#define MCP3911_REG_MASK		GENMASK(4, 1)
>  
>  #define MCP3911_NUM_CHANNELS		2
>  #define MCP3911_NUM_SCALES		6
> @@ -94,8 +95,8 @@ static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
>  
>  	be32_to_cpus(val);
>  	*val >>= ((4 - len) * 8);
> -	dev_dbg(&adc->spi->dev, "reading 0x%x from register 0x%x\n", *val,
> -		reg >> 1);
> +	dev_dbg(&adc->spi->dev, "reading 0x%x from register 0x%lx\n", *val,
> +		FIELD_GET(MCP3911_REG_MASK, reg));
>  	return ret;
>  }
>  

