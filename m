Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218BF6D7F2E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbjDEOUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbjDEOT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:19:57 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F906E97;
        Wed,  5 Apr 2023 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=nr9B9YoFHcdAnOk7XIXV4TXm5HEeAm6xhWvRCkvPnGM=; b=lg1cvw0Ep9UfBxMr4NkkCG2qNy
        Vo2pSByM8dzATy23gBaOsMupsW2sOxcdSAK3k4B2GwHL0S7DTWM7U/lWiWZbPe4UAgqgA9Qr4LOcf
        ImiXZtqi3eo6X3x8Wwq4m8U92HJA97/1GFKLsNDrQn1QD+2449d84Mr7YEOIFOPeR2aHiA16Gj6p4
        nt5YQ2YP90y5PLSQEFNHyINfL2MC7CxLEh37JTE30r6xe8d21LDkYHIgy+wKY8CgvrJ+UsLUDkecv
        SbWV+OIjUydKC5gHLZ8UuMGegMh+iljDpYOME4X0ABdXJuw7PUpbYOlFaxU2dDCiBYiw8jS5soJUX
        tqfwA2PQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pk3yL-0004CV-2A; Wed, 05 Apr 2023 16:18:49 +0200
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pk3yK-000UOi-Na; Wed, 05 Apr 2023 16:18:48 +0200
Message-ID: <9a203f56-c19a-48f2-f10c-ca0794ce79ed@metafoo.de>
Date:   Wed, 5 Apr 2023 07:18:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/4] iio: dac: mcp4922: add support for mcp48xx series
 chips
Content-Language: en-US
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
 <20230405140114.99011-5-frattaroli.nicolas@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230405140114.99011-5-frattaroli.nicolas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26866/Wed Apr  5 09:23:41 2023)
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks very good. A few small comments inline.
[...]
> @@ -50,6 +58,35 @@ struct mcp4922_state {
>   	},						\
>   }
>   
> +static bool mcp4922_needs_vref(int device_id)

`enum mcp4922_supported_device_ids` instead of `int`. Same for num_channels() below.

> +{
> +	switch (device_id) {
> +	case ID_MCP4902:
> +	case ID_MCP4912:
> +	case ID_MCP4921:
> +	case ID_MCP4922:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> [...]
>   static int mcp4922_spi_write(struct mcp4922_state *state, u8 addr, u32 val)
>   {
>   	state->mosi[1] = val & 0xff;
> @@ -108,11 +145,17 @@ static int mcp4922_write_raw(struct iio_dev *indio_dev,
>   	}
>   }
>   
> -static const struct iio_chan_spec mcp4922_channels[4][MCP4922_NUM_CHANNELS] = {
> +static const struct iio_chan_spec mcp4922_channels[10][MCP4922_NUM_CHANNELS] = {

mcp4922_channels[][MCP4922_NUM_CHANNELS]

So it does not have to be changed again when adding additional devices 
in the future.

> [...]
> @@ -197,11 +244,14 @@ static void mcp4922_remove(struct spi_device *spi)
>   {
>   	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>   	struct mcp4922_state *state;
> +	const struct spi_device_id *id = spi_get_device_id(spi);
>   
>   	iio_device_unregister(indio_dev);
>   	state = iio_priv(indio_dev);
>   	regulator_disable(state->vdd_reg);
> -	regulator_disable(state->vref_reg);
> +	if (mcp4922_needs_vref(id->driver_data)) {
Could be `if (state->vref_reg)`, this way you don't need to lookup the 
spi_device_id. But either way is fine.
> +		regulator_disable(state->vref_reg);
> +	}
>   }
>   
> [...]


