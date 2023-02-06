Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B40D68C03F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBFOgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjBFOgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:36:44 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E35724CB8;
        Mon,  6 Feb 2023 06:36:41 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P9THt523vz689vq;
        Mon,  6 Feb 2023 22:32:42 +0800 (CST)
Received: from localhost (10.81.207.58) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 6 Feb
 2023 14:36:39 +0000
Date:   Mon, 6 Feb 2023 14:36:37 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
CC:     <ktsai@capellamicro.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <hdegoede@redhat.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: light: cm32181: Unregister second I2C client if
 present
Message-ID: <20230206143637.00001b00@Huawei.com>
In-Reply-To: <20230206063616.981225-1-kai.heng.feng@canonical.com>
References: <20230206063616.981225-1-kai.heng.feng@canonical.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.207.58]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Mon,  6 Feb 2023 14:36:16 +0800
Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> If a second client that talks to the actual I2C address was created in
> probe(), there should be a corresponding cleanup in remove() to avoid
> leakage.
> 
> So if the "client" is not the same one used by I2C core, unregister it
> accordingly.
> 
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2152281
> Fixes: c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices with 2 I2C resources")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Whilst this fixes the leak, it introduces a race between unregistering
some of the hardware and the later removal of userspace interfaces. 
This needs to be handled via a devm_add_action_or_reset()
registered handler so it's automatically cleaned up at the right place
in the driver remove flow.

Jonathan


> ---
>  drivers/iio/light/cm32181.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index b1674a5bfa368..37439e103d273 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -488,6 +488,15 @@ static int cm32181_probe(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static void cm32181_remove(struct i2c_client *client)
> +{
> +	struct cm32181_chip *cm32181 = iio_priv(i2c_get_clientdata(client));
> +
> +	/* Unregister the dummy client */
> +	if (cm32181->client != client)
> +		i2c_unregister_device(cm32181->client);
> +}
> +
>  static int cm32181_suspend(struct device *dev)
>  {
>  	struct cm32181_chip *cm32181 = iio_priv(dev_get_drvdata(dev));
> @@ -531,6 +540,7 @@ static struct i2c_driver cm32181_driver = {
>  		.pm = pm_sleep_ptr(&cm32181_pm_ops),
>  	},
>  	.probe_new	= cm32181_probe,
> +	.remove		= cm32181_remove,
>  };
>  
>  module_i2c_driver(cm32181_driver);

