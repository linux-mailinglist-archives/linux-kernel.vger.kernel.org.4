Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA795E60C3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiIVLS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiIVLSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:18:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78889DED5D;
        Thu, 22 Sep 2022 04:18:54 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MYCMx3fZZz688vP;
        Thu, 22 Sep 2022 19:14:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 13:18:52 +0200
Received: from localhost (10.81.208.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 12:18:51 +0100
Date:   Thu, 22 Sep 2022 12:18:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun@huaweicloud.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] spi: Introduce spi_get_device_match_data()
 helper
Message-ID: <20220922121850.000006f3@huawei.com>
In-Reply-To: <20220921204520.23984-1-andriy.shevchenko@linux.intel.com>
References: <20220921204520.23984-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.208.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2022 23:45:20 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The proposed spi_get_device_match_data() helper is for retrieving
> a driver data associated with the ID in an ID table. First, it tries
> to get driver data of the device enumerated by firmware interface
> (usually Device Tree or ACPI). If none is found it falls back to
> the SPI ID table matching.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


I like this in general, but we need to keep a close eye on usecases
that are introduced to make sure that there is alignment between the
contents of the tables.

Perhaps the text should also explain a bit about why we would allow
both paths (in many case, the fallback will work fine)...
Previously a strong reason for that was that there was nothing to ensure
that all dt table entries were mirrored in the spi_device_id table.
As a side effect of the check to ensure module autoloading works, there
is now a check for that.

My personal view is we should still use the more generic path, even if
magic under the hood puts the data in spi_id->driver_data.

Jonathan


> ---
>  drivers/spi/spi.c       | 12 ++++++++++++
>  include/linux/spi/spi.h |  3 +++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index ad254b94308e..a0947d63afbc 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -360,6 +360,18 @@ const struct spi_device_id *spi_get_device_id(const struct spi_device *sdev)
>  }
>  EXPORT_SYMBOL_GPL(spi_get_device_id);
>  
> +const void *spi_get_device_match_data(const struct spi_device *sdev)
> +{
> +	const void *match;
> +
> +	match = device_get_match_data(&sdev->dev);
> +	if (match)
> +		return match;
> +
> +	return (const void *)spi_get_device_id(sdev)->driver_data;
> +}
> +EXPORT_SYMBOL_GPL(spi_get_device_match_data);
> +
>  static int spi_match_device(struct device *dev, struct device_driver *drv)
>  {
>  	const struct spi_device	*spi = to_spi_device(dev);
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 6ea889df0813..f2565c24ef27 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -1510,6 +1510,9 @@ extern void spi_unregister_device(struct spi_device *spi);
>  extern const struct spi_device_id *
>  spi_get_device_id(const struct spi_device *sdev);
>  
> +extern const void *
> +spi_get_device_match_data(const struct spi_device *sdev);
> +
>  static inline bool
>  spi_transfer_is_last(struct spi_controller *ctlr, struct spi_transfer *xfer)
>  {

