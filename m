Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA9D655289
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbiLWQHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWQHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:07:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3B3379E4;
        Fri, 23 Dec 2022 08:07:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43194B82045;
        Fri, 23 Dec 2022 16:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37274C433D2;
        Fri, 23 Dec 2022 16:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671811636;
        bh=Q8ELXJCh1YDyuxTg7vg3kz6RhNqF1hvv6kbMTZMHhko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=liwW+MtIuhO6vuS9IFRHsu6SCHHpRBU6ZMTew6hDmglCIgsL4WfJljVnmj4alS+43
         qmhBnmKFtlYC59uJ8N+45PbZFFUTYhLzQCbQ5ec5eA7P9mNowddJEfPVxzHlEIplGI
         dCv3j4m5TFlMEeg84aYLAJHyPdqwkqw49FHQ2TeGk4/MeyShsuBAANGwyumiSgnkex
         aplAmI6Q0nwg6YiV3v1oVUxYTXoeXpkyELUz03ItfElOs+0lIUeVbFhuHdT1c5crOi
         DODzc7+fHwyTcGEqnRQLWOcoXMZJhWifdsQSU5QjodFICOzXcyeh6k8ehwwsRABdnI
         G14m/w/CgGMuQ==
Date:   Fri, 23 Dec 2022 16:20:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ep93xx: Add OF support
Message-ID: <20221223162024.46636cce@jic23-huawei>
In-Reply-To: <20221219173618.1030415-2-alexander.sverdlin@gmail.com>
References: <20221219173618.1030415-1-alexander.sverdlin@gmail.com>
        <20221219173618.1030415-2-alexander.sverdlin@gmail.com>
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

On Mon, 19 Dec 2022 18:36:18 +0100
Alexander Sverdlin <alexander.sverdlin@gmail.com> wrote:

> Prepare for EP93xx conversion to DT.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Hi Alexander,

Comments inline,

Jonathan

> ---
>  drivers/iio/adc/ep93xx_adc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
> index fd5a9404c8dc..e530a37180e1 100644
> --- a/drivers/iio/adc/ep93xx_adc.c
> +++ b/drivers/iio/adc/ep93xx_adc.c
> @@ -21,6 +21,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
> +#include <linux/of.h>
>  
>  /*
>   * This code could benefit from real HR Timers, but jiffy granularity would
> @@ -227,9 +228,18 @@ static int ep93xx_adc_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id ep93xx_adc_of_ids[] = {
> +	{ .compatible = "cirrus,ep9301-adc" },
> +	{},

No comma needed for 'NULL' terminator of the array.

> +};
> +MODULE_DEVICE_TABLE(of, ep93xx_adc_of_ids);
> +#endif
> +
>  static struct platform_driver ep93xx_adc_driver = {
>  	.driver = {
>  		.name = "ep93xx-adc",
> +		.of_match_table = of_match_ptr(ep93xx_adc_of_ids),
drop the of_match_ptr() protection and the ifdefs.
They only save a tiny amount of space, and add complexity that outweighs it.
The other normal reason we don't like these is that there are ACPI paths
that use of_match_table and this breaks them.  Not likely to be relevant
here though I guess.

Jonathan




>  	},
>  	.probe = ep93xx_adc_probe,
>  	.remove = ep93xx_adc_remove,

