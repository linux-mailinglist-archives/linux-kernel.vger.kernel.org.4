Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F7F66E5DC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjAQSTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjAQSOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:14:54 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6840F59E6C;
        Tue, 17 Jan 2023 09:55:17 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 417FE40006;
        Tue, 17 Jan 2023 17:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673978115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QBM+HgXjAFT76F06W1VN1fbTEOg+eVsRbHSiYU85qfU=;
        b=b5UiCiDTkPXfaXibNh5BJw2ZYyy7DF3xR+Dai76oOEMRBTBckJJsiKyQnFVTen5yYXkNOR
        cDVXHXl+PMTKs1zwdw+sCXRAMhfVssyqoAo7pPpgtARKLWSGIlR6vwWCUbsUAurry8TFcR
        mCb27XZQl7sWN0aMulKqR6KfB7Lgvu1zjpOQDpmryHWiK7XnXZUtGZsMLW/eycnxnf2AMX
        Rx0OqkhjErr0td0fV/+PRBr7w1AJiyrVd/epGGvBn1DWuGOoen0Z4vGFIA1hvU4p0tPc6V
        PGluKnl6DmmY661Z+hXWnvHZVixOYDw54MjBFXxMYMz35gsPc5Y5yiEMqflEIw==
Date:   Tue, 17 Jan 2023 18:55:14 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Vincent Shih <vincent.sunplus@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: sunplus: fix format string for printing resource
Message-ID: <Y8bhApoC4Bmgtjoq@mail.local>
References: <20230117172450.2938962-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117172450.2938962-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 18:24:44+0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On 32-bit architectures with 64-bit resource_size_t, sp_rtc_probe()
> causes a compiler warning:
> 
> drivers/rtc/rtc-sunplus.c: In function 'sp_rtc_probe':
> drivers/rtc/rtc-sunplus.c:243:33: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
>   243 |         dev_dbg(&plat_dev->dev, "res = 0x%x, reg_base = 0x%lx\n",
>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The best way to print a resource is the special %pR format string,
> and similarly to print a pointer we can use %p and avoid the cast.
> 

I got this one this morning, which one is more correct? :)
https://lore.kernel.org/all/20230117054232.24023-1-rdunlap@infradead.org/

> Fixes: fad6cbe9b2b4 ("rtc: Add driver for RTC in Sunplus SP7021")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/rtc/rtc-sunplus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-sunplus.c b/drivers/rtc/rtc-sunplus.c
> index e8e2ab1103fc..4b578e4d44f6 100644
> --- a/drivers/rtc/rtc-sunplus.c
> +++ b/drivers/rtc/rtc-sunplus.c
> @@ -240,8 +240,8 @@ static int sp_rtc_probe(struct platform_device *plat_dev)
>  	if (IS_ERR(sp_rtc->reg_base))
>  		return dev_err_probe(&plat_dev->dev, PTR_ERR(sp_rtc->reg_base),
>  					    "%s devm_ioremap_resource fail\n", RTC_REG_NAME);
> -	dev_dbg(&plat_dev->dev, "res = 0x%x, reg_base = 0x%lx\n",
> -		sp_rtc->res->start, (unsigned long)sp_rtc->reg_base);
> +	dev_dbg(&plat_dev->dev, "res = %pR, reg_base = %p\n",
> +		sp_rtc->res, sp_rtc->reg_base);
>  
>  	sp_rtc->irq = platform_get_irq(plat_dev, 0);
>  	if (sp_rtc->irq < 0)
> -- 
> 2.39.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
