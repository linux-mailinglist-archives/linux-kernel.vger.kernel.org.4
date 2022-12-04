Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970AA641DA8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 16:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiLDPdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 10:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiLDPdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 10:33:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E49120AD;
        Sun,  4 Dec 2022 07:33:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 461D0B80184;
        Sun,  4 Dec 2022 15:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C36C433C1;
        Sun,  4 Dec 2022 15:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670168015;
        bh=yxKf05+cFmoyI5uei5HHUeN5U35ydw6bkv8/4NHs5O8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ELgifSQkKU4A+1JzRiGvD7bTznHKS72pg+BDZRe4cUG0R6dKmwqMCgMiXTpXHMTCn
         bDTmrpgfrr1w07AMOJGAJhASWZ38b889pBJgAiDFlMFTsmA7ISUdkh+SAvaZ/210FU
         CCDCGV0jaSugJdN514xNHZuP3kh9tKyy/S4sQx2CWGIEFsPH0xaSDPlEroPufnQfNz
         I5TudLa8nQigMXTR2muAA/2w5iqPDnDt8nhSs/VMUvvma1WA9aR20mZ7a/4Id1XZCX
         wcgngIuRezRpHbLU0g3JXzbZLtaW5L/f/itoehO1Z1a2/C6NvW8NUTluwaK3vroyB7
         vFZD80jO4Xq9g==
Date:   Sun, 4 Dec 2022 15:46:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <ye.xingchen@zte.com.cn>
Cc:     <eugen.hristev@microchip.com>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: use sysfs_emit() to instead
 of   scnprintf()
Message-ID: <20221204154621.3b76d888@jic23-huawei>
In-Reply-To: <202212011142333790361@zte.com.cn>
References: <202212011142333790361@zte.com.cn>
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

On Thu, 1 Dec 2022 11:42:33 +0800 (CST)
<ye.xingchen@zte.com.cn> wrote:

> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with sysfs_emit() to simplify the code.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
Applied. 

Thanks,

Jonathan

> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index ed4f8501bda8..50d02e5fc6fc 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -2181,7 +2181,7 @@ static ssize_t at91_adc_get_fifo_state(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct at91_adc_state *st = iio_priv(indio_dev);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", !!st->dma_st.dma_chan);
> +	return sysfs_emit(buf, "%d\n", !!st->dma_st.dma_chan);
>  }
> 
>  static ssize_t at91_adc_get_watermark(struct device *dev,
> @@ -2190,7 +2190,7 @@ static ssize_t at91_adc_get_watermark(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct at91_adc_state *st = iio_priv(indio_dev);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", st->dma_st.watermark);
> +	return sysfs_emit(buf, "%d\n", st->dma_st.watermark);
>  }
> 
>  static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,

