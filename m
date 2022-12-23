Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E5965526B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 16:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbiLWPsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 10:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbiLWPsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 10:48:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E490930F40;
        Fri, 23 Dec 2022 07:48:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8228461221;
        Fri, 23 Dec 2022 15:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C985FC433F0;
        Fri, 23 Dec 2022 15:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671810531;
        bh=uDdlMtPBoNlyiwxUajCYBTLiiIYPz+lZctiEtYYrPqo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l1XRUTa2A3U3SY1HMy/7J7VzlLcJ7qr+pUjt4egi3potOh/1ksa65BknI7s+ISdSY
         KR3BvHDwUR+yEz8ow3a6MoW2a+RfIb5SimtDkjo8qZWD9WVvmmHW+5/JC3+1dkjbFK
         IIVCQn0mjoT9UY5UnkXHYV0677RYED/X13PXeZtM4V+J5jUd2yjFQAeHpcvuBdWHJc
         FXjuEg5N83GDQOXiWtipkt8fqpNLYsd1M8Lgsbn/IvBEXGQuO3AdZVsoujQ3tAyy9j
         OIHoixikAx7Dawbiq7r7p6V99D+JXV3Obo4e4w04hGOdKv4cH2xRbhvG82EltGBdCz
         VMuGxxiL6fkEA==
Date:   Fri, 23 Dec 2022 16:02:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lars@metafoo.de, paul@crapouillou.net, jiasheng@iscas.ac.cn,
        oleksandr.kozaruk@ti.com, gg@slimlogic.co.uk, balajitk@ti.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] iio:adc:twl6030: Enable measurement of VAC
Message-ID: <20221223160200.1ae6df91@jic23-huawei>
In-Reply-To: <20221217221305.671117-1-andreas@kemnade.info>
References: <20221217221305.671117-1-andreas@kemnade.info>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

On Sat, 17 Dec 2022 23:13:05 +0100
Andreas Kemnade <andreas@kemnade.info> wrote:

> VAC needs to be wired up to produce proper measurements,
> without this change only near zero values are reported.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Fixes: 1696f36482e7 ("iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/twl6030-gpadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
> index 40438e5b4970..32873fb5f367 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -952,7 +952,7 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = twl_i2c_write_u8(TWL6030_MODULE_ID0,
> -				VBAT_MEAS | BB_MEAS | BB_MEAS,
> +				VBAT_MEAS | BB_MEAS | VAC_MEAS,
>  				TWL6030_MISC1);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to wire up inputs\n");

