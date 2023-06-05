Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E29722F2B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjFETFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjFETFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:05:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691BD187;
        Mon,  5 Jun 2023 12:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F23E0615B9;
        Mon,  5 Jun 2023 19:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFAEC433EF;
        Mon,  5 Jun 2023 19:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685991891;
        bh=4V4TssFv8IPPka7MQnZ2K4ANMzvY6OosA91feEWbOVk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eoA92xoVbG4wfylb6j4b/kbgL3CPiEJTgrdF3gTRzsqM5ahuKvSp2WJpneigTB++L
         0dm7t3+lRVgHNXurRzC1gn8d3cE87aHqVqJl5A+2+dz/NIarMbB+AHFnShcNK63UHk
         lC5qPcCCYIuBwE09NpzxgFQBHorBK67HQ2Mcdxep1iULN8ZmIKwzXr8SHZ2sUcLQR/
         seVyOag/QP3qbCzPPgWC3Yo72G37O53ya2qmHlnME370plUCEsxl6AFkAyBoFbcCaG
         I4hwtTOkZ55G5B5m294yWCYDkSedIY1eGwU9U6tPE6w0/FeK2dpfaNvaMPAYRTOJ6C
         Gjlg4zorNZuVg==
Date:   Mon, 5 Jun 2023 20:04:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: accel: fxls8962af: fixup buffer scan element
 type
Message-ID: <20230605200448.3db08268@jic23-huawei>
In-Reply-To: <20230605103223.1400980-1-sean@geanix.com>
References: <20230605103223.1400980-1-sean@geanix.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Jun 2023 12:32:21 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Scan elements for x,y,z channels is little endian and requires no bit shifts.
> LE vs. BE is controlled in register SENS_CONFIG2 and bit LE_BE, default
> value is LE.
> 
> Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Cc: stable@vger.kernel.org

Hmm. I'm not going to ask how this didn't come up in testing before now...

> ---
>  drivers/iio/accel/fxls8962af-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 0d672b1469e8..bf7949e51e6c 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -724,8 +724,8 @@ static const struct iio_event_spec fxls8962af_event[] = {
>  		.sign = 's', \
>  		.realbits = 12, \
>  		.storagebits = 16, \
> -		.shift = 4, \
> -		.endianness = IIO_BE, \
> +		.shift = 0, \

We'd normally not explicitly specify shift = 0 as that's both the obvious default and
what C will give us for free.

I'll tidy that up whilst applying.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> +		.endianness = IIO_LE, \
>  	}, \
>  	.event_spec = fxls8962af_event, \
>  	.num_event_specs = ARRAY_SIZE(fxls8962af_event), \

