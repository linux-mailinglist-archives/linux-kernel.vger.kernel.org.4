Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9354D626AB6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbiKLQ6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLQ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:57:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A732636;
        Sat, 12 Nov 2022 08:57:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B327060C74;
        Sat, 12 Nov 2022 16:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83A1C433D6;
        Sat, 12 Nov 2022 16:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668272276;
        bh=gahcWABeDNsx1a9rHW2d00qBd4iElUe5VhEq6F1CpxY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eICRChNBee2Gvb3t4cHsHus4zoTfPh1QAtjyULNxbSigUDIcfUttWwOXYhK52YuiI
         9F5uOcQgzg1hUn2TXhWNB0cEHrobb8RmgNZJ9p0yGE+/qBtZbnPD3F5OSPSK5rFfaQ
         mpil1Nv2cuYynipFDo+Zz/T6jFZSWURkP/p2JJ6JepXqnpZisXAABqH1Tboipf3P/W
         yfeDmr6IT4xO7e2CAm7jSRda3I/FKep04CEjxw018D6rxxnbAMZtEfS/OXL59mdTty
         BKrr2twzpa5yQ/APKOgawGZyJ2HE8ySFUZpzaO9ctiuJRYsX6U028I/SUu/iXqiO8P
         myYqFqkbOChqg==
Date:   Sat, 12 Nov 2022 17:10:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mitja Spes <mitja@lxnav.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: adc: mcp3422: fix scale read bug
Message-ID: <20221112171010.7a511746@jic23-huawei>
In-Reply-To: <20221111112657.1521307-2-mitja@lxnav.com>
References: <20221111112657.1521307-1-mitja@lxnav.com>
        <20221111112657.1521307-2-mitja@lxnav.com>
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

On Fri, 11 Nov 2022 12:26:53 +0100
Mitja Spes <mitja@lxnav.com> wrote:

> Scale was returned for currently active channel instead of the specified
> channel.
> 
> Signed-off-by: Mitja Spes <mitja@lxnav.com>
> Fixes: 07914c84ba30 ("iio: adc: Add driver for Microchip MCP3422/3/4 high resolution ADC")
Hi Mitja,

One trivial comment inline. I might tidy that up whilst applying if others are
otherwise happy with this patch.  If you do a v2 for some other reason please
get rid of that unrelated change.

Jonathan

> ---
>  drivers/iio/adc/mcp3422.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index da353dcb1e9d..3d53de300c89 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -164,8 +164,9 @@ static int mcp3422_read_raw(struct iio_dev *iio,
>  	struct mcp3422 *adc = iio_priv(iio);
>  	int err;
>  
> +	u8 req_channel = channel->channel;
>  	u8 sample_rate = MCP3422_SAMPLE_RATE(adc->config);
> -	u8 pga		 = MCP3422_PGA(adc->config);
> +	u8 pga		 = adc->pga[req_channel];
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -175,7 +176,6 @@ static int mcp3422_read_raw(struct iio_dev *iio,
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> -
Unrelated change.  No problem with cleaning this up but definitely not
in a fix patch!

>  		*val1 = 0;
>  		*val2 = mcp3422_scales[sample_rate][pga];
>  		return IIO_VAL_INT_PLUS_NANO;

