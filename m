Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37C1649413
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 13:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiLKMDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 07:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiLKMC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 07:02:58 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEF86581;
        Sun, 11 Dec 2022 04:02:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DF504CE0B15;
        Sun, 11 Dec 2022 12:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E5EC433D2;
        Sun, 11 Dec 2022 12:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670760173;
        bh=iqV1X9rvKqHgUZcJaxu1kVP8qwtaiBTngOFZ9cJX0Xo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZRBz8ZinvhiygoYtHlTj5lVneYyONpAO+ttETC1Iy2lZd29HrxZBgmGKrY3U9SUQZ
         QHUi/HeK3FGk8E98aFFk0+FqAt0CJW/X82kEubSj2yxu03tfSfQsc4Q7AaT4GcfeJb
         5jfL7vgy9WL5cE8nj8rpMG/EgxlugreyGlZ2SkteNb6f5tQixytuoJGNSSNybdP5Zh
         74YA1LTzpp7BmG6k56CkT1v3dzR45eMioV6MPt3S5gqiQH/rosGQFEgzqrMu9k0nxd
         uGAsapBU+hFn9gZiazZ0aod1AxLBiPs5ee7biqZEJJYtSrNM+RgiDc3cR0Oko9NIr1
         NP4Av+OPOVR9g==
Date:   Sun, 11 Dec 2022 12:15:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <ye.xingchen@zte.com.cn>
Cc:     <lars@metafoo.de>, <andriy.shevchenko@linux.intel.com>,
        <miquel.raynal@bootlin.com>, <nuno.sa@analog.com>,
        <wsa+renesas@sang-engineering.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: st_sensors: Convert to use sysfs_emit_at() API
Message-ID: <20221211121547.007f750f@jic23-huawei>
In-Reply-To: <202212071553556022992@zte.com.cn>
References: <202212071553556022992@zte.com.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

On Wed, 7 Dec 2022 15:53:55 +0800 (CST)
<ye.xingchen@zte.com.cn> wrote:

> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index c77d7bdcc121..44e374f84197 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -628,8 +628,7 @@ ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
>  		if (sdata->sensor_settings->odr.odr_avl[i].hz == 0)
>  			break;
> 
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> -				sdata->sensor_settings->odr.odr_avl[i].hz);
> +		len += sysfs_emit_at(buf, len, "%d ", sdata->sensor_settings->odr.odr_avl[i].hz);

Another case where I would prefer we keep the line break.

>  	}
>  	buf[len - 1] = '\n';
> 
> @@ -651,7 +650,7 @@ ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
>  		q = sdata->sensor_settings->fs.fs_avl[i].gain / 1000000;
>  		r = sdata->sensor_settings->fs.fs_avl[i].gain % 1000000;
> 
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%u.%06u ", q, r);
> +		len += sysfs_emit_at(buf, len, "%u.%06u ", q, r);
>  	}
>  	buf[len - 1] = '\n';
> 

