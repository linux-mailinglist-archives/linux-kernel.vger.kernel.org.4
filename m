Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3315722F32
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjFETGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjFETGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:06:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A77EA;
        Mon,  5 Jun 2023 12:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8308062973;
        Mon,  5 Jun 2023 19:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D62C433EF;
        Mon,  5 Jun 2023 19:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685991975;
        bh=bpR5cLB1DKy6DMGCswIvq3YpVkE4aZVvPSf2eCPO5cc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BDoywDP4Ex70+1iCicHZ0SQjW09+awjt84XORka9Ul1SCL8ILYV8guUCcySDQUO55
         CaoP3hAA5+Ri5v1QaoggF0ks3OtwK7kgAWI88ncZylqihKVsDLsq6mY4VbdLA9QRK0
         pgBg+EhPB1Fq9OfyrNOJojRtcuZZ4EMhUDBKL5kNmfQsJRUEWfswf2qg5oMtDtkKE+
         8BdDfy7t1mCzqyLtuNorJPvkrfnHPRzGptYRbk1WKZ3/k2wbntkyIvoW9Q5AdH7Jsn
         EPJjGZj0a4YeUIpDcDFft0q768pDEpDaZ+qNtL43qEo1Ftcu0idt5JIkNAidX+b+Di
         tAc7nvZ9MEYeQ==
Date:   Mon, 5 Jun 2023 20:06:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: accel: fxls8962af: errata bug only applicable
 for FXLS8962AF
Message-ID: <20230605200613.69830319@jic23-huawei>
In-Reply-To: <20230605103223.1400980-2-sean@geanix.com>
References: <20230605103223.1400980-1-sean@geanix.com>
        <20230605103223.1400980-2-sean@geanix.com>
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

On Mon,  5 Jun 2023 12:32:22 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> Remove special errata handling if FXLS8964AF is used.
> 
> Fixes: af959b7b96b8 ("iio: accel: fxls8962af: fix errata bug E3 - I2C burst reads")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Cc: stable@vger.kernel.org

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> ---
>  drivers/iio/accel/fxls8962af-core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index bf7949e51e6c..3f27834ef04c 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -904,9 +904,10 @@ static int fxls8962af_fifo_transfer(struct fxls8962af_data *data,
>  	int total_length = samples * sample_length;
>  	int ret;
>  
> -	if (i2c_verify_client(dev))
> +	if (i2c_verify_client(dev) &&
> +	    data->chip_info->chip_id == FXLS8962AF_DEVICE_ID)
>  		/*
> -		 * Due to errata bug:
> +		 * Due to errata bug (only applicable on fxls8962af):
>  		 * E3: FIFO burst read operation error using I2C interface
>  		 * We have to avoid burst reads on I2C..
>  		 */

