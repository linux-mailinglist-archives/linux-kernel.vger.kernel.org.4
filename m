Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186626AFB06
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCHAXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCHAXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:23:22 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA0152F49;
        Tue,  7 Mar 2023 16:23:08 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id e21so11042718oie.1;
        Tue, 07 Mar 2023 16:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678234988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhZTPcT1ZLPmPnwbbNMGANfRu/qeCcdG2pV9Oue9Cpw=;
        b=hFtPaDxJfDasSDgUNglBfdD8rA+R2vedFJ9S0P25rGcpp1WJFkGO880Q7Rw8nPUh6h
         Zvuhi4+r+c44oai0KcER9n4E35+26uKe3/I3Nnwb3BFLZXT3R6wIMYjiwXNrIlQ0NihG
         53yUM27Ibl+GZFCR5XUgq681FUecsk9ftvXzAnxbqQr04piC4/x7xPU4K0+9HaiHJj48
         0VsamHGc2TyXo+k1eOVSUhm0xNUYQDhoxVrIya0LaYjYO1MzYOL8rsKwvLhwAsQw4Wvj
         7EiYmDhZECwyRgqf3G4sOYSn6KgDON8WPCT/H+2KrZCC0V7czJa8LKNJE42qLC7WABUa
         UQ7w==
X-Gm-Message-State: AO0yUKWM9v8oqnSZStULpYVPfaC5i5Vbp+IcgzaGaWpTTwu51+0wb1j+
        vHEhUgYIIRc6ncCyxUd0/Q==
X-Google-Smtp-Source: AK7set9V9VdEeZYGpbEeDGQdr9TVJX1PtfXopLn0mwWKfaxcu+x/xijWMjWRMXNueLrorPEO1B48nA==
X-Received: by 2002:aca:110f:0:b0:37e:aa97:4660 with SMTP id 15-20020aca110f000000b0037eaa974660mr7833692oir.16.1678234987950;
        Tue, 07 Mar 2023 16:23:07 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o188-20020acaf0c5000000b00383ef58c15bsm5812516oih.28.2023.03.07.16.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 16:23:07 -0800 (PST)
Received: (nullmailer pid 528287 invoked by uid 1000);
        Wed, 08 Mar 2023 00:23:06 -0000
Date:   Tue, 7 Mar 2023 18:23:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 04/21] of: Move of_modalias() to module.c
Message-ID: <20230308002306.GB513330-robh@kernel.org>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
 <20230307165359.225361-5-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307165359.225361-5-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 05:53:42PM +0100, Miquel Raynal wrote:
> Create a specific .c file for of related module handling.
> Move of_modalias() inside as a first step.

Perhaps a comment as to why it needs to be public? Or is it just shared 
within the DT core? If so, we have of_private.h for that.

> 
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/of/Makefile |  2 +-
>  drivers/of/device.c | 37 -------------------------------------
>  drivers/of/module.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h  |  8 ++++++++
>  4 files changed, 52 insertions(+), 38 deletions(-)
>  create mode 100644 drivers/of/module.c
> 
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index e0360a44306e..ae9923fd2940 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-y = base.o device.o platform.o property.o
> +obj-y = base.o device.o module.o platform.o property.o
>  obj-$(CONFIG_OF_KOBJ) += kobj.o
>  obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
>  obj-$(CONFIG_OF_FLATTREE) += fdt.o
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 2bbb67798916..44f1f2ef12b7 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/string.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -248,42 +247,6 @@ const void *of_device_get_match_data(const struct device *dev)
>  }
>  EXPORT_SYMBOL(of_device_get_match_data);
>  
> -static ssize_t of_modalias(struct device_node *np, char *str, ssize_t len)
> -{
> -	const char *compat;
> -	char *c;
> -	struct property *p;
> -	ssize_t csize;
> -	ssize_t tsize;
> -
> -	/* Name & Type */
> -	/* %p eats all alphanum characters, so %c must be used here */
> -	csize = snprintf(str, len, "of:N%pOFn%c%s", np, 'T',
> -			 of_node_get_device_type(np));
> -	tsize = csize;
> -	len -= csize;
> -	if (str)
> -		str += csize;
> -
> -	of_property_for_each_string(np, "compatible", p, compat) {
> -		csize = strlen(compat) + 1;
> -		tsize += csize;
> -		if (csize > len)
> -			continue;
> -
> -		csize = snprintf(str, len, "C%s", compat);
> -		for (c = str; c; ) {
> -			c = strchr(c, ' ');
> -			if (c)
> -				*c++ = '_';
> -		}
> -		len -= csize;
> -		str += csize;
> -	}
> -
> -	return tsize;
> -}
> -
>  int of_device_request_module(struct device *dev)
>  {
>  	char *str;
> diff --git a/drivers/of/module.c b/drivers/of/module.c
> new file mode 100644
> index 000000000000..9c6a53f32c0f
> --- /dev/null
> +++ b/drivers/of/module.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0+

Existing license was GPL-2.0 (-only).

> +/*
> + * Linux kernel module helpers.
> + */
> +
> +#include <linux/of.h>
> +#include <linux/string.h>
> +
> +ssize_t of_modalias(struct device_node *np, char *str, ssize_t len)
> +{
> +	const char *compat;
> +	char *c;
> +	struct property *p;
> +	ssize_t csize;
> +	ssize_t tsize;
> +
> +	/* Name & Type */
> +	/* %p eats all alphanum characters, so %c must be used here */
> +	csize = snprintf(str, len, "of:N%pOFn%c%s", np, 'T',
> +			 of_node_get_device_type(np));
> +	tsize = csize;
> +	len -= csize;
> +	if (str)
> +		str += csize;
> +
> +	of_property_for_each_string(np, "compatible", p, compat) {
> +		csize = strlen(compat) + 1;
> +		tsize += csize;
> +		if (csize > len)
> +			continue;
> +
> +		csize = snprintf(str, len, "C%s", compat);
> +		for (c = str; c; ) {
> +			c = strchr(c, ' ');
> +			if (c)
> +				*c++ = '_';
> +		}
> +		len -= csize;
> +		str += csize;
> +	}
> +
> +	return tsize;
> +}
> diff --git a/include/linux/of.h b/include/linux/of.h
> index fc7ada57df33..1372f8647272 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -373,6 +373,9 @@ extern int of_parse_phandle_with_args_map(const struct device_node *np,
>  extern int of_count_phandle_with_args(const struct device_node *np,
>  	const char *list_name, const char *cells_name);
>  
> +/* module functions */
> +extern ssize_t of_modalias(struct device_node *np, char *str, ssize_t len);
> +
>  /* phandle iterator functions */
>  extern int of_phandle_iterator_init(struct of_phandle_iterator *it,
>  				    const struct device_node *np,
> @@ -730,6 +733,11 @@ static inline int of_count_phandle_with_args(const struct device_node *np,
>  	return -ENOSYS;
>  }
>  
> +static inline ssize_t of_modalias(struct device_node *np, char *str, ssize_t len)
> +{
> +	return -ENODEV;
> +}
> +
>  static inline int of_phandle_iterator_init(struct of_phandle_iterator *it,
>  					   const struct device_node *np,
>  					   const char *list_name,
> -- 
> 2.34.1
> 
