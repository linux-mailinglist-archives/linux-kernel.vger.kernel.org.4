Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DF067F9E0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 18:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbjA1R2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 12:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbjA1R2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 12:28:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1E6233ED;
        Sat, 28 Jan 2023 09:28:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB63EB806A0;
        Sat, 28 Jan 2023 17:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D90C433EF;
        Sat, 28 Jan 2023 17:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674926914;
        bh=eavz0MMuJlAPnvVE2PM75ag4JmsVT4sDhzf+WOsIp5A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rVUEWtnJMQHVpfW8Ei9Fh2DQaEiQAZuhqrqvsQWUaFf7LdHSueNoiEOsvRSM3k0yC
         tDLyoMC/1U7Ty92YgazIIP6wgpMwd2ZUyBoE+3uzl3/KpJe2f+rUjGUejO5H4obGif
         lP9emKC++TH/dZ8lzOTb3aZTB4eJW7yowot1GdqU2CZUYKRreARkyDMNOqzJsMfX5F
         wjPQapNH4DqjtavHVXDk1qg/g0uLB5gVnpWi+2s1kmwQE7h1Pd/R+44RIvZLiXGatP
         dLs17QN9ZhhGW8qTh2xRI2y1DkJqtfn5IG2Fh+amzvboHUlz4r86ZrYTflO2+Lvl8L
         8rUSDi+UPrBxQ==
Date:   Sat, 28 Jan 2023 17:42:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, Lars-Peter Clausen <lars@metafoo.de>,
        Irina Tirdea <irina.tirdea@intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma9551_core: Prevent uninitialized
 variable in mma9551_read_config_word()
Message-ID: <20230128174227.7c240576@jic23-huawei>
In-Reply-To: <20230126153610.3586243-1-harshit.m.mogalapalli@oracle.com>
References: <20230126153610.3586243-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 07:36:09 -0800
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> Smatch Warns:
> drivers/iio/accel/mma9551_core.c:299
> 	mma9551_read_config_word() error: uninitialized symbol 'v'.
> 
> When (offset >= 1 << 12) is true mma9551_transfer() will return -EINVAL
> without 'v' being initialized, so check for the error and return.
> 
> Fixes: 40cb761306d6 ("iio: add driver for Freescale MMA9553")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Similar to previous.  It's tidying up an inelegant bit of code, but no
actual bug due to checks at the caller.  Hence I've dropped the fixes
tag and added a note to the commit description for anyone considering backporting.

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to take a look at it and see if we missed anything.

Thanks,

Jonathan

> ---
> This is detected using static analysis.
> ---
>  drivers/iio/accel/mma9551_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
> index 64ca7d7a9673..75eee7f7303a 100644
> --- a/drivers/iio/accel/mma9551_core.c
> +++ b/drivers/iio/accel/mma9551_core.c
> @@ -296,9 +296,12 @@ int mma9551_read_config_word(struct i2c_client *client, u8 app_id,
>  
>  	ret = mma9551_transfer(client, app_id, MMA9551_CMD_READ_CONFIG,
>  			       reg, NULL, 0, (u8 *)&v, 2);
> +	if (ret < 0)
> +		return ret;
> +
>  	*val = be16_to_cpu(v);
>  
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL_NS(mma9551_read_config_word, IIO_MMA9551);
>  

