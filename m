Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E666F98D7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 16:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjEGOKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 10:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEGOKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 10:10:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F5E3C11;
        Sun,  7 May 2023 07:10:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 379FF60DB7;
        Sun,  7 May 2023 14:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB675C433D2;
        Sun,  7 May 2023 14:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683468636;
        bh=FddBsyxwkzQNOB0PnRvoKLTZYTgsFaQ477EH4b3Ox0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cNnk7alK2asreMJtlx8iCgDmWxAUz9OY2kSeAkh4sUAgGn9yK7IR2Rw6Cibj+vUOF
         R1Fh49tdMjRqShflJXqRmaxOxUB/seCegIO243LCbmH/ghd0jiqmz2y8LsyV45Er0F
         6hH/ztkr/jfdGiSNS0ZfHDHNMy/pUbv5S+xBgCw3ApLHieZUHf2sYkJyUoUCTmm6aa
         Aal0Zr5nsxnihEJMX2Vz4jtugUykKL8u2G4EdhbYNwYTgSzmTchwIG/zgFNUsqU/2x
         Q2EeEL8NYfQAz7PiPr5tYHuK6ZhUNpQXQizxFsDcE/tZ/DghRucXIjmC/2L9X8dIf9
         Tluwh6NuksVfg==
Date:   Sun, 7 May 2023 15:26:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ajay Gupta <ajayg@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Parthiban Nallathambi <pn@denx.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list), imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] iio: light: vcnl4035: fixed chip ID check
Message-ID: <20230507152629.3a30e233@jic23-huawei>
In-Reply-To: <20230501143605.1615549-1-Frank.Li@nxp.com>
References: <20230501143605.1615549-1-Frank.Li@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 May 2023 10:36:04 -0400
Frank Li <Frank.Li@nxp.com> wrote:

> VCNL4035 register(0xE) ID_L and ID_M define as:
> 
>  ID_L: 0x80
>  ID_H: 7:6 (0:0)
>        5:4 (0:0) slave address = 0x60 (7-bit)
>            (0:1) slave address = 0x51 (7-bit)
>            (1:0) slave address = 0x40 (7-bit)
>            (1:0) slave address = 0x41 (7-bit)
>        3:0 Version code default	(0:0:0:0)
> 
> So just check ID_L.
> 
> Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> ---
> Change from v1 to V2: 
> -define VCNL4035_DEV_ID_MASK instead hardcode 0xff
> -using FIELD_GET
> -update commit message, remove a space line between fixes and signed-off
> 
>  drivers/iio/light/vcnl4035.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index 3ed37f6057fb..a23c415fcb7a 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -8,6 +8,7 @@
>   * TODO: Proximity
>   */
>  #include <linux/bitops.h>
> +#include <linux/bitfield.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
> @@ -42,6 +43,7 @@
>  #define VCNL4035_ALS_PERS_MASK		GENMASK(3, 2)
>  #define VCNL4035_INT_ALS_IF_H_MASK	BIT(12)
>  #define VCNL4035_INT_ALS_IF_L_MASK	BIT(13)
> +#define VCNL4035_DEV_ID_MASK		GENMASK(7, 0)
>  
>  /* Default values */
>  #define VCNL4035_MODE_ALS_ENABLE	BIT(0)
> @@ -413,6 +415,7 @@ static int vcnl4035_init(struct vcnl4035_data *data)
>  		return ret;
>  	}
>  
> +	id = FIELD_GET(VCNL4035_DEV_ID_MASK, id);
>  	if (id != VCNL4035_DEV_ID_VAL) {
>  		dev_err(&data->client->dev, "Wrong id, got %x, expected %x\n",
>  			id, VCNL4035_DEV_ID_VAL);

