Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A6067872D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjAWUGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjAWUF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:05:57 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDC85270;
        Mon, 23 Jan 2023 12:05:54 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id q10so9972228qvt.10;
        Mon, 23 Jan 2023 12:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rvuJ8A4IlyfXCsyYan/KpC79RkPAFCYwtl7xuTdER9c=;
        b=KT2e53XUOUdDix7v7jXQ2Ki4M+qfO0LAqdqBru4J1aGtMklMemvUw6pw4WFM6LCL7/
         mgNvDMwgOQ/WXi5Kf4bbWjoEZaRUR07h6h3kUGjGy/Cz33ouBfJhm6tkoE2NQU4o/krB
         uYSMtpYcZFLw+yyRr5KvCRXmQeHSuOWZKFGZh6npLnGHnwZZ4BVDS3Wq/qSGrWcfPDCS
         qimzJRxrbj8pNmN+CatdxigzvU3HwjExluKUjiFEP6DUMbnoMxi+7pv/XdCFBZBcRYd/
         3DGlfLOXzuaKauYj18kZzuivS9cIvKXpW3/+dCfxybEi+yq+152XSBBFBbsnb6k+h1JO
         nPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvuJ8A4IlyfXCsyYan/KpC79RkPAFCYwtl7xuTdER9c=;
        b=pM40QrRnGLaTN3HtcaQcBRaJHC5aJc2i9zT97Qg+e7zc/LWrz4ZDECW0Ah3ALgznux
         lc1XyoFewCcyKQXaeI7JANrAtZm8UmLsnHljx/znrN0jQYw2X+/1y/isYEvS225DBY9k
         ixCGCY3NyPdCSHo8c9G+5kFlpIGQZ9Z0Yh4PpaVcg0+6+O/Uas/UlVQyueQlklJX3kII
         EJ5aXFahn+e0IY6a5zD5QHutztBObLFJ9qbyD7gl1qqkiSI2SBq+QrVvFtcgH4q/wcKE
         Y99ckJYf6pDXZXRsOa6s9FcaUXL/YD5DLcynZOoX07g2I0X4Aaoa3gBVYUyDMpv1CO69
         zUeQ==
X-Gm-Message-State: AFqh2krSV13b4kFAXfA0DxuNyc2kiihuEHv20QBC9NpxJsfkoCv7lgl1
        YB2s6IY0y2wVw+9K/T9vG22o4PGZZaHtwg==
X-Google-Smtp-Source: AMrXdXuSQ0q2Qr9Qof3A6qdsGO16cHNphtT4ih0Fr99dpzSra6Tv0sC1wUjjkxtPImruqRvkPeX5uA==
X-Received: by 2002:a05:6214:3312:b0:535:2264:7437 with SMTP id mo18-20020a056214331200b0053522647437mr39171914qvb.5.1674504353599;
        Mon, 23 Jan 2023 12:05:53 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id j10-20020a05620a0a4a00b00706a452c074sm56604qka.104.2023.01.23.12.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 12:05:53 -0800 (PST)
Date:   Mon, 23 Jan 2023 15:05:51 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v1 1/1] serial: liteuart: Don't mix devm_*() with
 non-devm_*() calls
Message-ID: <Y87on7jISJMV0CpX@errol.ini.cmu.edu>
References: <20230123191741.79751-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123191741.79751-1-andriy.shevchenko@linux.intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 09:17:41PM +0200, Andy Shevchenko wrote:
> In the probe we need to call all devm_*() first followed by
> non-devm_*() calls. This is due to reversed clean up that
> may happen in a wrong order otherwise. The driver currently
> allocates xarray before calling
> devm_platform_get_and_ioremap_resource(). While it's not an
> issue in this certain case, it's still better to be pedantic.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/liteuart.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
> index 192ad681de35..562892395570 100644
> --- a/drivers/tty/serial/liteuart.c
> +++ b/drivers/tty/serial/liteuart.c
> @@ -286,37 +286,35 @@ static int liteuart_probe(struct platform_device *pdev)
>  	struct xa_limit limit;
>  	int dev_id, ret;
>  
> -	/* look for aliases; auto-enumerate for free index if not found */
> -	dev_id = of_alias_get_id(pdev->dev.of_node, "serial");
> -	if (dev_id < 0)
> -		limit = XA_LIMIT(0, CONFIG_SERIAL_LITEUART_MAX_PORTS);
> -	else
> -		limit = XA_LIMIT(dev_id, dev_id);
> -
>  	uart = devm_kzalloc(&pdev->dev, sizeof(struct liteuart_port), GFP_KERNEL);
>  	if (!uart)
>  		return -ENOMEM;
>  
> -	ret = xa_alloc(&liteuart_array, &dev_id, uart, limit, GFP_KERNEL);
> -	if (ret)
> -		return ret;
> -
> -	uart->id = dev_id;
>  	port = &uart->port;
>  
>  	/* get membase */
>  	port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
> -	if (IS_ERR(port->membase)) {
> -		ret = PTR_ERR(port->membase);
> -		goto err_erase_id;
> -	}
> +	if (IS_ERR(port->membase))
> +		return PTR_ERR(port->membase);
>  
>  	ret = platform_get_irq_optional(pdev, 0);
>  	if (ret < 0 && ret != -ENXIO)
> -		goto err_erase_id;
> +		return ret;
>  	if (ret > 0)
>  		port->irq = ret;
>  
> +	/* look for aliases; auto-enumerate for free index if not found */
> +	dev_id = of_alias_get_id(pdev->dev.of_node, "serial");
> +	if (dev_id < 0)
> +		limit = XA_LIMIT(0, CONFIG_SERIAL_LITEUART_MAX_PORTS);
> +	else
> +		limit = XA_LIMIT(dev_id, dev_id);
> +
> +	ret = xa_alloc(&liteuart_array, &dev_id, uart, limit, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	uart->id = dev_id;
>  	/* values not from device tree */
>  	port->dev = &pdev->dev;
>  	port->iotype = UPIO_MEM;

Reviewed-by: Gabriel Somlo <somlo@cmu.edu>

Thanks,
--Gabriel

> -- 
> 2.39.0
> 
