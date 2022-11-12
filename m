Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A30F626AC4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 18:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiKLRUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 12:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLRUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 12:20:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C6010B6A;
        Sat, 12 Nov 2022 09:20:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D8D0B80989;
        Sat, 12 Nov 2022 17:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B0DC433C1;
        Sat, 12 Nov 2022 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668273610;
        bh=TBYplVtCLdDavccVW3miYQQ5hU7uovgIup9ciXBlwmo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PEDLeSqRLCqZBwWSwQbWjY57dDnv2P5O2zfbc7+w51XkZf/PeTFGX467BpZN3jdnG
         /SPAoXPeLXH7R/3Yails/aHJ+FtJPZCgIoBUTfg0cVFG4kVCkJygTNmsG5qrjre+t8
         FzYLuKqof8N0RQ+9EYkcMpY+5JVIN0gOhzBmzhqSgsoFyvtnfs6rH9mqtIsW0F2jU3
         dg5vhdaDcWxB/mpEiRr5phj83Lmcwkt2/lE/booFVgBQqhGOhyj9Vh2z7ecCYY+Rnl
         J9JI+GqqKgLV9AxL5uKldyUTcHk0siEnmpVzpRqaUeMsSgZyayS3qZ1VDUkiKqKU+z
         EvmfYaAfbVwTw==
Date:   Sat, 12 Nov 2022 17:32:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mitja Spes <mitja@lxnav.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: adc: mcp3422: add hardware gain attribute
Message-ID: <20221112173222.0ca56017@jic23-huawei>
In-Reply-To: <20221111112657.1521307-4-mitja@lxnav.com>
References: <20221111112657.1521307-1-mitja@lxnav.com>
        <20221111112657.1521307-4-mitja@lxnav.com>
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

On Fri, 11 Nov 2022 12:26:55 +0100
Mitja Spes <mitja@lxnav.com> wrote:

> Allows setting gain separately from scale.

How are the separate?  We normally only use hardwaregain if
changing it has no input on the scale that we need to apply in userspace
to raw channels.  This normally happens for two reasons
1) There is a micro controller on the sensor that is doing a bunch of
   maths so whilst changing the PGA value changes the range measurable it
   doesn't affect the representation when we read from the device.
2) The hardware gain is controlling say the sensitivity of a light sensor
   in a time of flight device - it affects if we can get a measurement, but
   not the measurement itself.

Any of that true here?

If not, we shouldn't be adding a hardwaregain attribute - which is why
almost no ADCs have them...

Jonathan

> 
> Signed-off-by: Mitja Spes <mitja@lxnav.com>
> ---
>  drivers/iio/adc/mcp3422.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index cfb629b964af..eef35fb2fc22 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -58,7 +58,8 @@
>  		.channel = _index, \
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) \
>  				| BIT(IIO_CHAN_INFO_SCALE) \
> -				| BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +				| BIT(IIO_CHAN_INFO_SAMP_FREQ) \
> +				| BIT(IIO_CHAN_INFO_HARDWAREGAIN), \
>  	}
>  
>  static const int mcp3422_scales[MCP3422_SRATE_COUNT][MCP3422_PGA_COUNT] = {
> @@ -184,6 +185,10 @@ static int mcp3422_read_raw(struct iio_dev *iio,
>  		*val1 = mcp3422_sample_rates[sample_rate];
>  		return IIO_VAL_INT;
>  
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		*val1 = (1 << pga);
> +		return IIO_VAL_INT;
> +
>  	default:
>  		break;
>  	}
> @@ -245,6 +250,29 @@ static int mcp3422_write_raw(struct iio_dev *iio,
>  		adc->ch_config[req_channel] = config;
>  		return 0;
>  
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		switch (val1) {
> +		case 1:
> +			temp = MCP3422_PGA_1;
> +			break;
> +		case 2:
> +			temp = MCP3422_PGA_2;
> +			break;
> +		case 4:
> +			temp = MCP3422_PGA_4;
> +			break;
> +		case 8:
> +			temp = MCP3422_PGA_8;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		config &= ~MCP3422_PGA_MASK;
> +		config |= MCP3422_PGA_VALUE(temp);
> +		adc->ch_config[req_channel] = config;
> +		return 0;
> +
>  	default:
>  		break;
>  	}
> @@ -260,6 +288,8 @@ static int mcp3422_write_raw_get_fmt(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT_PLUS_NANO;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
>  	}

