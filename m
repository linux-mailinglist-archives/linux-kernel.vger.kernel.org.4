Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1857626AC6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 18:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbiKLRVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 12:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLRVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 12:21:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B3E10B77;
        Sat, 12 Nov 2022 09:21:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43869B808CB;
        Sat, 12 Nov 2022 17:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F53C433D6;
        Sat, 12 Nov 2022 17:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668273676;
        bh=4t9mbRVCTjaSHtqUcukiOe1kyOFByC+AQf5pvZIi5yM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m24E+nCp5n1dAuoIRgqPs3nokGD8I4zqLvMS/ouaqPc64BHkv9hJZ088HS7m4kHqB
         NdgTsX64XFe/ibWoz3QcmHkBRBgEPR+/8a1bW3LuWe8R5WtQEBI/FHMcnIqB0wzSRO
         VJdZPIochoaa6BrO2pCSsymJ/ECDld845LJf5MAwIWJxskU9lnSJcKvGSdn2SbpKvP
         9I0zZ4/6RTsUQI/cLpYZbgF2ScA4qBxSpekPNvNYX6wGNrSrVE8eO6T4BclkDnbpf6
         B0RtXhiF3nabXOQ4QJAQJ/ABWB1XA95ewI3KV6XVFkXz3pAOinyekroZRyPPUs10KA
         Tur5tm+PnLRjw==
Date:   Sat, 12 Nov 2022 17:33:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mitja Spes <mitja@lxnav.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: adc: mcp3422: reduce sleep for fast sampling
 rates
Message-ID: <20221112173330.77568785@jic23-huawei>
In-Reply-To: <20221111112657.1521307-5-mitja@lxnav.com>
References: <20221111112657.1521307-1-mitja@lxnav.com>
        <20221111112657.1521307-5-mitja@lxnav.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 11 Nov 2022 12:26:56 +0100
Mitja Spes <mitja@lxnav.com> wrote:

> - reduced sleep time for 240 & 60 sps rates
> - minor roundup fix for sleep times
> 
> Signed-off-by: Mitja Spes <mitja@lxnav.com>
This patch looks fine to me.

Jonathan

> ---
>  drivers/iio/adc/mcp3422.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index eef35fb2fc22..dbcc8fe91aaa 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -70,10 +70,11 @@ static const int mcp3422_scales[MCP3422_SRATE_COUNT][MCP3422_PGA_COUNT] = {
>  
>  /* Constant msleep times for data acquisitions */
>  static const int mcp3422_read_times[MCP3422_SRATE_COUNT] = {
> -	[MCP3422_SRATE_240] = 1000 / 240,
> -	[MCP3422_SRATE_60] = 1000 / 60,
> -	[MCP3422_SRATE_15] = 1000 / 15,
> -	[MCP3422_SRATE_3] = 1000 / 3 };
> +	[MCP3422_SRATE_240] = DIV_ROUND_UP(1000, 240),
> +	[MCP3422_SRATE_60] = DIV_ROUND_UP(1000, 60),
> +	[MCP3422_SRATE_15] = DIV_ROUND_UP(1000, 15),
> +	[MCP3422_SRATE_3] = (100000 + 375 - 100) / 375 /* real rate is 3.75 sps */
> +};
>  
>  /* sample rates to integer conversion table */
>  static const int mcp3422_sample_rates[MCP3422_SRATE_COUNT] = {
> @@ -137,6 +138,7 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
>  				struct iio_chan_spec const *channel, int *value)
>  {
>  	int ret;
> +	int sleep_duration;
>  	u8 config;
>  	u8 req_channel = channel->channel;
>  
> @@ -148,7 +150,11 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
>  			mutex_unlock(&adc->lock);
>  			return ret;
>  		}
> -		msleep(mcp3422_read_times[MCP3422_SAMPLE_RATE(adc->active_config)]);
> +		sleep_duration = mcp3422_read_times[MCP3422_SAMPLE_RATE(adc->active_config)];
> +		if (sleep_duration < 20)
> +			usleep_range(sleep_duration * 1000, sleep_duration * 1300);
> +		else
> +			msleep(sleep_duration);
>  	}
>  
>  	ret = mcp3422_read(adc, value, &config);

