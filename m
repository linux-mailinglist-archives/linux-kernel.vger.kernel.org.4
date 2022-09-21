Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9B05C04BD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiIUQxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiIUQwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:52:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51285322;
        Wed, 21 Sep 2022 09:48:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5CC7B831B2;
        Wed, 21 Sep 2022 16:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEB3C433D6;
        Wed, 21 Sep 2022 16:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663778929;
        bh=lrEPP288W1ztvVtKqLc2Qx5zAzNeiXnqsUHoGX4blzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sZsVCx5+DxjcXTU2UWOzibWtuKlfXVoueVFoDHkj6tx1aVXXjJvbMZIpSfNhzbxPR
         sutHHAjpQ36zAbpEZ6+cvRg3j5q65wW40eBvkrFAHsxdUKl33LP5Kf5y0Y81ZEyb28
         8dRbyIydXTkT3ajVJmYYpe+rFAyjqHVnnFM8zg+u2685rPrQ2uRYME2UfGIxxROwXD
         7Ja1AxkK3khqj7enwTtxSfoxi4LZy7D92I5qzDkWEy2xE5sE2wogzqBW1YnbOaFzU1
         qptVgQH6AIiXHZRFkYDI+xyOTWEoNlbjojgVSHMRSvY/xdoWQRcJgBd+oS5B6maj3w
         3gKHSSVPmYJug==
Date:   Wed, 21 Sep 2022 17:48:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com,
        arnd@arndb.de, linux-gpio@vger.kernel.org,
        linux-next@vger.kernel.org, gregkh@linuxfoundation.org,
        bagasdotme@gmail.com, zengheng4@huawei.com
Subject: Re: [PATCH v2 char-misc-next] misc: microchip: pci1xxxx: use
 DEFINE_SIMPLE_DEV_PM_OPS() in place  of the SIMPLE_DEV_PM_OPS() in
 pci1xxxx's gpio driver
Message-ID: <YytAbfmMfxNsIjcy@spud>
References: <20220915094729.646185-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915094729.646185-1-kumaravel.thiagarajan@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 03:17:29PM +0530, Kumaravel Thiagarajan wrote:
> misc: microchip: pci1xxxx: use DEFINE_SIMPLE_DEV_PM_OPS() in place  of the SIMPLE_DEV_PM_OPS() in pci1xxxx's gpio driver
                                                                    ^^
FYI, double space in the subject here, rather a mouthful though and
surely everything after SIMPLE_DEV_PM_OPS() is redundant?

> build errors listed below and reported by Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> for the builds of
> riscv, s390, csky, alpha and loongarch allmodconfig are fixed in
> this patch.

allmodconfig has been broken for a while now, and this patch appears
to have been sitting for a week & a second fix has shown up at:
https://lore.kernel.org/all/20220919094250.858716-1-zengheng4@huawei.com/

I do note that Zeng Hang's patch does slightly more than this one does,
but idk about about the PM APIs /shrug.

Has this just slipped under the radar since so many of us were
attending conferences etc the last while or are you looking for
Kumaravel to do something more here?

Thanks,
Conor.

> 
> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:311:12: error: 'pci1xxxx_gpio_resume' defined but not used [-Werror=unused-function]
>   311 | static int pci1xxxx_gpio_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~
> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:295:12: error: 'pci1xxxx_gpio_suspend' defined but not used [-Werror=unused-function]
>   295 | static int pci1xxxx_gpio_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: 4ec7ac90ff39 ("misc: microchip: pci1xxxx: Add power management functions - suspend & resume handlers.")
> Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
> Changes in v2:
>   - Mention as Sudip had reported in the commit description
>     as suggested by Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> index 9cc771c604ed..4cd541166b0c 100644
> --- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> +++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> @@ -405,7 +405,7 @@ static int pci1xxxx_gpio_probe(struct auxiliary_device *aux_dev,
>  	return devm_gpiochip_add_data(&aux_dev->dev, &priv->gpio, priv);
>  }
>  
> -static SIMPLE_DEV_PM_OPS(pci1xxxx_gpio_pm_ops, pci1xxxx_gpio_suspend, pci1xxxx_gpio_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(pci1xxxx_gpio_pm_ops, pci1xxxx_gpio_suspend, pci1xxxx_gpio_resume);
>  
>  static const struct auxiliary_device_id pci1xxxx_gpio_auxiliary_id_table[] = {
>  	{.name = "mchp_pci1xxxx_gp.gp_gpio"},
> -- 
> 2.25.1
> 
> 
