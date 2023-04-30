Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA4B6F29CC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 19:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjD3RHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 13:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjD3RHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 13:07:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC03172C;
        Sun, 30 Apr 2023 10:07:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B34160BA9;
        Sun, 30 Apr 2023 17:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B54FC433EF;
        Sun, 30 Apr 2023 17:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682874433;
        bh=LVTTku4thsZ0OAQMywyia2sdi32S1ddGjboXKjQtnU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vLRvuln9GQSrDhh7RrqMipYwXP/IFEr8K9epbL1QPVvgJ0jj+DG/q6W68Yu5Ewi/z
         yIaTG1qkQPqE9kSur8WCEXJFaO+eLAMBGPRbN4174u4ZKWB7kYx6M9su/948OUf/uh
         MtWkKhs5cSqbMHel6cML7mbvgNmGmTF7IEHZGXiGKMCFqdeIpO0Akr6R/6kfA9yvNP
         sqwmlXYs8sb+rjKIlWx/r0swDyWbpoDkAQ3w5OREsRTgcDrRhsK+ynZ3G2MeVEbj6h
         96ZazLVSwOdrHxBPBWTdaHDOaJ9vPLoPEAx3TwSglvhpPMM7kT3wdpBVkU538irZR9
         +HKOYswoq6Z6A==
Date:   Sun, 30 Apr 2023 18:22:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= 
        <u.kleine-koenig@pengutronix.de>, Petr Machata <petrm@nvidia.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Parthiban Nallathambi <pn@denx.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list), imx@lists.linux.dev
Subject: Re: [PATCH 1/1] iio: light: vcnl4035: fixed chip ID check
Message-ID: <20230430182258.7dbdd39d@jic23-huawei>
In-Reply-To: <20230427213038.1375404-1-Frank.Li@nxp.com>
References: <20230427213038.1375404-1-Frank.Li@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2023 17:30:37 -0400
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

Hi Frank,

Thanks for the fix. A few minor things inline.

> 
> Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
> 

No blank line here as the Fixes tag is part of the main tag block.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Just to check, the result of this bug is that the driver probe fails
if the slave address isn't 0x60?

> ---
>  drivers/iio/light/vcnl4035.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index 3ed37f6057fb..8b7769930f3b 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -413,7 +413,7 @@ static int vcnl4035_init(struct vcnl4035_data *data)
>  		return ret;
>  	}
>  
> -	if (id != VCNL4035_DEV_ID_VAL) {
> +	if ((id & 0xff) != VCNL4035_DEV_ID_VAL) {

Please add a define for that 0xff mask and perhaps also use
FIELD_GET() to extract the field for comparison with VCNL4035_DEV_ID_VAL.
Whilst that isn't being done elsewhere in this driver, the heavy use
of set bits means it isn't appropriate anywhere else that I can quickly
identify. You'll also need to include linux/bitfield.h if making that change.

Thanks,

Jonathan

>  		dev_err(&data->client->dev, "Wrong id, got %x, expected %x\n",
>  			id, VCNL4035_DEV_ID_VAL);
>  		return -ENODEV;

