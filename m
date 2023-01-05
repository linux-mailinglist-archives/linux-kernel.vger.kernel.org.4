Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C4E65E877
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjAEJ6t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Jan 2023 04:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjAEJ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:58:07 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8774FD5D;
        Thu,  5 Jan 2023 01:58:06 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nnhg730VXz6J6W0;
        Thu,  5 Jan 2023 17:55:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 5 Jan
 2023 09:58:03 +0000
Date:   Thu, 5 Jan 2023 09:58:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] iio: light: max44009: Remove the unused variable
 max44009_of_match
Message-ID: <20230105095802.00002453@Huawei.com>
In-Reply-To: <20230105095038.112564-1-jiapeng.chong@linux.alibaba.com>
References: <20230105095038.112564-1-jiapeng.chong@linux.alibaba.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
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

On Thu, 5 Jan 2023 17:50:38 +0800
Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Variable max44009_of_match is not effectively used, so delete it.
> 
> drivers/iio/light/max44009.c:545:34: warning: ‘max44009_of_match’ defined but not used.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3632
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thanks, but a better fix would be to set the of_device_id element of the driver structure
to point to this (you'll need to move the of_device_id table up a few lines)

Also, the MODULE_DEVICE_TABLE() macro is using this if you are building
modules - so I'm fairly sure this is a false positive warning anyway.
The resulting alias can be used as part of a module autoloading.

Jonathan


> ---
>  drivers/iio/light/max44009.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
> index 3dadace09fe2..2f80a654ad6a 100644
> --- a/drivers/iio/light/max44009.c
> +++ b/drivers/iio/light/max44009.c
> @@ -542,12 +542,6 @@ static struct i2c_driver max44009_driver = {
>  };
>  module_i2c_driver(max44009_driver);
>  
> -static const struct of_device_id max44009_of_match[] = {
> -	{ .compatible = "maxim,max44009" },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, max44009_of_match);
> -
>  MODULE_AUTHOR("Robert Eshleman <bobbyeshleman@gmail.com>");
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("MAX44009 ambient light sensor driver");

