Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8738E6B6004
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 20:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjCKTFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 14:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCKTFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 14:05:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05886421A;
        Sat, 11 Mar 2023 11:05:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72B23B80522;
        Sat, 11 Mar 2023 19:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB58C433D2;
        Sat, 11 Mar 2023 19:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678561543;
        bh=qPIKFEJGZJDWtEu+7/bcEu38Bz9zJE9vsrp4FTLoaXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cGAPRqNfX+wHvWVHnUZMOGZPnZ9oEa5LSWq08/N0U9bO+u9J9ldXgSGSYvaB/9Sns
         nnwNQ9N0mgmoe+8krfPG5ERkdJspButpa4Wl/g9dw5DMxlDGYsxLCxLoGCTB9CZa1y
         BBTQlXG0Dxeg0ZdZMF7YecfyUYg62RKcobC+CAU0LSTOOdCo84ZpJpbLDs4XcHQHPF
         iN3nbkmXg4wsk+prjKXoJCwc3ZiWwcWUqJakAn92+V236sEciDpheVRFDlNi8ip+Y/
         xDrhQgJohoYPANUVzGrVWZ6qz0irzyO+CyS6k9eVJjZMOyBFAW+H+HSscwZl7IEQT9
         /J9MxukmBOWgA==
Date:   Sat, 11 Mar 2023 19:05:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        michal.simek@amd.com, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: adc: Use devm_krealloc_array
Message-ID: <20230311190545.4ed8acf8@jic23-huawei>
In-Reply-To: <20230309150334.216760-4-james.clark@arm.com>
References: <20230309150334.216760-1-james.clark@arm.com>
        <20230309150334.216760-4-james.clark@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Thu,  9 Mar 2023 15:03:32 +0000
James Clark <james.clark@arm.com> wrote:

> Now that it exists, use it instead of doing the multiplication and
> checking for overflow manually.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iio/adc/xilinx-ams.c       |  9 +++------
>  drivers/iio/adc/xilinx-xadc-core.c | 17 +++++++----------
>  2 files changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> index 34cf336b3490..f0b71a1220e0 100644
> --- a/drivers/iio/adc/xilinx-ams.c
> +++ b/drivers/iio/adc/xilinx-ams.c
> @@ -1263,7 +1263,7 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
>  	struct device *dev = indio_dev->dev.parent;
>  	struct fwnode_handle *child = NULL;
>  	struct fwnode_handle *fwnode = dev_fwnode(dev);
> -	size_t ams_size, dev_size;
> +	size_t ams_size;
>  	int ret, ch_cnt = 0, i, rising_off, falling_off;
>  	unsigned int num_channels = 0;
>  
> @@ -1320,11 +1320,8 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
>  		}
>  	}
>  
> -	dev_size = array_size(sizeof(*dev_channels), num_channels);
> -	if (dev_size == SIZE_MAX)
> -		return -ENOMEM;
> -
> -	dev_channels = devm_krealloc(dev, ams_channels, dev_size, GFP_KERNEL);
> +	dev_channels = devm_krealloc_array(dev, ams_channels, num_channels,
> +					   sizeof(*dev_channels), GFP_KERNEL);
>  	if (!dev_channels)
>  		return -ENOMEM;
>  
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 292f2892d223..dba73300f894 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -613,20 +613,17 @@ static int xadc_update_scan_mode(struct iio_dev *indio_dev,
>  	const unsigned long *mask)
>  {
>  	struct xadc *xadc = iio_priv(indio_dev);
> -	size_t new_size, n;
> +	size_t n;
>  	void *data;
>  
>  	n = bitmap_weight(mask, indio_dev->masklength);
>  
> -	if (check_mul_overflow(n, sizeof(*xadc->data), &new_size))
> -		return -ENOMEM;
> -
> -	data = devm_krealloc(indio_dev->dev.parent, xadc->data,
> -			     new_size, GFP_KERNEL);
> +	data = devm_krealloc_array(indio_dev->dev.parent, xadc->data,
> +				   n, sizeof(*xadc->data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> -	memset(data, 0, new_size);
> +	memset(data, 0, n * sizeof(*xadc->data));
>  	xadc->data = data;
>  
>  	return 0;
> @@ -1281,9 +1278,9 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
>  	}
>  
>  	indio_dev->num_channels = num_channels;
> -	indio_dev->channels = devm_krealloc(dev, channels,
> -					    sizeof(*channels) * num_channels,
> -					    GFP_KERNEL);
> +	indio_dev->channels = devm_krealloc_array(dev, channels,
> +						  num_channels, sizeof(*channels),
> +						  GFP_KERNEL);
>  	/* If we can't resize the channels array, just use the original */
>  	if (!indio_dev->channels)
>  		indio_dev->channels = channels;

