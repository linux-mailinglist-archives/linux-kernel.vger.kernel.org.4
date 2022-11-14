Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31696628B2B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbiKNVNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbiKNVNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:13:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F039A5F7E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668460362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p7ORPw9FCS+zEbfmYdWbdnPfb8i6EFWnkcrxCVHohjY=;
        b=HNw6ITWZPfQgzw4g9LmyuMkc7bHG/Bnib07GAZfgCs1bI7s3Yay0NwBvk+qQ5igQU638FH
        x5KlY4zwDfAZscllu4zILroGAKRMDcBmfl8Si/NRrjyQfR5AVzOv+s7txxjgT+6mwbl2Yg
        NvKBln+nrWM3T0Dgy3+ZIn/bliq0QE4=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-107-JzAsaF66NR-o5ufrVAMDSw-1; Mon, 14 Nov 2022 16:12:40 -0500
X-MC-Unique: JzAsaF66NR-o5ufrVAMDSw-1
Received: by mail-oi1-f200.google.com with SMTP id 13-20020aca280d000000b0035a3c3d34c7so3927691oix.21
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7ORPw9FCS+zEbfmYdWbdnPfb8i6EFWnkcrxCVHohjY=;
        b=jKqtCjJE7uqS15BmVuibpxJV7Od2szAR3YFNi1t4L33hPvcyaSnyfK7eaJozwJqTyb
         iDXnyCUs7Qk1nwQ83kar6Vc+8m2TX0Nby220QNzuS5IMwV4TE0IK28/ZmlUD4VMpyOh6
         5hgZIrS0VfJ0SOiAci1daLMUFEiDmzNDCBrIETq2ttDD4kTrp2Q3WnkjCwglA/xm53y/
         FAIMopRvZCSRqDEClOyvUXCV6RiIvpEERBFRZmSf9vwNwlrW6NuV3fZyc+snFGbbN6Kh
         A62kw16pNuvpHWhR6h1IOX8IbxCDDFr6Ob9eVO4fsofYxyiX8T+ARrqJY+pQo3Hsav2I
         YB1w==
X-Gm-Message-State: ANoB5pkWhNi92dxksHDmlOw+AA4ndUOpDC5JIdgDhMn3uxmh0k70AsOX
        NODBahHTNX9v+dX9GrxbIDGaceL0Xl3uw8hGS4ixrc3160dFjWSYgHqa6eg4eemlOcA12hNjOna
        00zYZvN3tn63AROCzdy+rqxbh
X-Received: by 2002:a05:6830:114a:b0:66c:6bac:dd4c with SMTP id x10-20020a056830114a00b0066c6bacdd4cmr7534174otq.166.1668460359326;
        Mon, 14 Nov 2022 13:12:39 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Hp+nVlKWm45R202Fsz4MudiXsv43sYYiUWYOXHUOwmjRH5tCRg4sBxIBOAFhXGlbEFe0Y4g==
X-Received: by 2002:a05:6830:114a:b0:66c:6bac:dd4c with SMTP id x10-20020a056830114a00b0066c6bacdd4cmr7534159otq.166.1668460359021;
        Mon, 14 Nov 2022 13:12:39 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::41])
        by smtp.gmail.com with ESMTPSA id bk31-20020a0568081a1f00b0035a5ed5d935sm4089664oib.16.2022.11.14.13.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 13:12:38 -0800 (PST)
Date:   Mon, 14 Nov 2022 15:12:36 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] gpiolib: of: Use correct fwnode for DT-probed chips
Message-ID: <20221114211236.pfnobreab6twcqw4@halaney-x13s>
References: <20221111113732.461881-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111113732.461881-1-thierry.reding@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 12:37:32PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The OF node store in chip->fwnode is used to explicitly override the FW
> node for a GPIO chip. For chips that use the default FW node (i.e. that
> of their parent device), this will be NULL and cause the chip not to be
> fully registered.
> 
> Instead, use the GPIO device's FW node, which is set to either the node
> of the parent device or the explicit override in chip->fwnode.
> 
> Fixes: 8afe82550240 ("gpiolib: of: Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode")
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Tested-by: Andrew Halaney <ahalaney@redhat.com>

This fixes issues I ran into today on my sa8540p-ride board.

Thanks,
Andrew

> ---
>  drivers/gpio/gpiolib-of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 4be3c21aa718..55c3712592db 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -1067,7 +1067,7 @@ int of_gpiochip_add(struct gpio_chip *chip)
>  	struct device_node *np;
>  	int ret;
>  
> -	np = to_of_node(chip->fwnode);
> +	np = to_of_node(dev_fwnode(&chip->gpiodev->dev));
>  	if (!np)
>  		return 0;
>  
> -- 
> 2.38.1
> 

