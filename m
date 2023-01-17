Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDA066E4A1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbjAQRP5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Jan 2023 12:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjAQRPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:15:17 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160004995F;
        Tue, 17 Jan 2023 09:14:21 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NxFl52Jb1z6J6LH;
        Wed, 18 Jan 2023 01:10:25 +0800 (CST)
Received: from localhost (10.45.151.130) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 17 Jan
 2023 17:14:19 +0000
Date:   Tue, 17 Jan 2023 17:14:17 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: ipaq-micro-ts - fix DEFINE_SIMPLE_DEV_PM_OPS
 typo
Message-ID: <20230117171417.00002890@Huawei.com>
In-Reply-To: <20230117164539.1631336-1-arnd@kernel.org>
References: <20230117164539.1631336-1-arnd@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.45.151.130]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Tue, 17 Jan 2023 17:45:33 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The previous change was not properly build tested and needs
> a trivial spelling change:
> 
> ipaq-micro-ts.c:146:8: error: type defaults to 'int' in declaration of 'DEFINE_SIMPLE_DEV_PM' [-Werror=implicit-int]
> 
> Fixes: 144ff5e03d74 ("Input: ipaq-micro-ts - use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Hi Arnd,

I clearly messed up my build tests - will look into how that went wrong.
From an initial look, this looks like a driver that could benefit from
a || COMPILE_TEST addition to the Kconfig depenencies. Nothing looks to be
build time dependent on the related MFD.

Thanks for fixing it up.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/input/touchscreen/ipaq-micro-ts.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ipaq-micro-ts.c b/drivers/input/touchscreen/ipaq-micro-ts.c
> index d8e25b502968..94720c41c9be 100644
> --- a/drivers/input/touchscreen/ipaq-micro-ts.c
> +++ b/drivers/input/touchscreen/ipaq-micro-ts.c
> @@ -143,8 +143,8 @@ static int micro_ts_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static DEFINE_SIMPLE_DEV_PM(micro_ts_dev_pm_ops,
> -			    micro_ts_suspend, micro_ts_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(micro_ts_dev_pm_ops,
> +				micro_ts_suspend, micro_ts_resume);
>  
>  static struct platform_driver micro_ts_device_driver = {
>  	.driver	= {

