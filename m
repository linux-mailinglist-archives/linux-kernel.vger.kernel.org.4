Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F0274BDDE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 16:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGHOeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 10:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHOeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 10:34:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C82DE56;
        Sat,  8 Jul 2023 07:34:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEA9360D24;
        Sat,  8 Jul 2023 14:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F600C433C8;
        Sat,  8 Jul 2023 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688826883;
        bh=7jMPJJXe6YudyGoC/69GZ6MFHuwLHFpgrY1Zr/jDDW8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MEC4LxZcvVtS1h3J0pFwK0rp7E/9enrurNn+WbSP7VTMWcnhk5C9eKygp29zVl1Ai
         NP2TnK4TlNHG83UIUKuIzhD8mMNuPnNsyxhadAvWxCjoNoTZ04Gm4ZDweTBomWWV3X
         qVRAYJ7kWUg8/Ek/dqrwpeNuAHjaRuj4jqLjNQewvrQbSt2rVIuFU9lXX49jyHsWtB
         u9M6V4hzXTdw6O+BatMafrJscQ4QFqM5llJuELYSNz60JeL+BHLob2XFM5+NvzCLwe
         8LkXZFL4GzXnl+BXMUiOidWs6w8duL3JiGcLQv9k12HWhOuNvz2aLDPNBlKk/Hs/Jm
         h7VxQZ5GylzrA==
Date:   Sat, 8 Jul 2023 15:34:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: stm32-adc: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20230708153435.6da5fee5@jic23-huawei>
In-Reply-To: <20230704095808.33780-1-frank.li@vivo.com>
References: <20230704095808.33780-1-frank.li@vivo.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Tue,  4 Jul 2023 17:58:08 +0800
Yangtao Li <frank.li@vivo.com> wrote:

> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-adc-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 48f02dcc81c1..99062a0ba1d9 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -723,8 +723,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	priv->nb_adc_max = priv->cfg->num_adcs;
>  	spin_lock_init(&priv->common.lock);
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	priv->common.base = devm_ioremap_resource(&pdev->dev, res);
> +	priv->common.base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(priv->common.base))
>  		return PTR_ERR(priv->common.base);
>  	priv->common.phys_base = res->start;

