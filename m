Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615A25BCF7A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiISOrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiISOrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:47:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DB1186F1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:47:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r133-20020a1c448b000000b003b494ffc00bso4265419wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=CqA/dBWgnZQs4vtp4JzGxE23MTAfm2Kn3zyouRrwVAU=;
        b=j3ppvcKTM5+ZLv0uOuirTjHOiEkA0SWe9duV3l212kNIXczYmBBiYh49IdK/KJQz6T
         L3IfqqXhTm3BpXH5HthVVoZT85FLVZiQd28yfacDaLBWdpIQiGYQ99V+ccQCPy7eElJZ
         0oTDN2cejYgk+b3jSY7KBa9Aq/q3DGNs2v4tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CqA/dBWgnZQs4vtp4JzGxE23MTAfm2Kn3zyouRrwVAU=;
        b=Z6aufffKX727r8LMuUWMuo5WVPkffKShzet65QLc0IHDPNSqmDMH4MEqE3SIK5K/8N
         Zolf8NAZx6fGDb6dEXTRDg1JeNbGGKThPi1akQGhAGLYZtjzvLN/ryLxlUqawkNr2uQI
         LIOKiI2tH6HHt3oe4LfFXjKWtNM251PCsDw2i4we4flBlyNwSXKa9HMVhqNKrOyEqTwP
         wboN2dsxbl0gZVyExAKOP9QtrNo/UO7R1K46sG73cDkY5DSzXGjfTmQnZDY5R2jd1+z8
         5K4K1ggZeQ8flGsUyKwos/QLvZTIfk56EwCal69IsKlAMuK6w2GK7btB9Cgo4FZIm2v9
         gXrw==
X-Gm-Message-State: ACrzQf1BVxQczlgTAARnDzxvfLLbLSe48LB6ivEEl9MpwlNHKdXTWKmg
        ga+sfHb8gdaUWcuC0ZIevP2HEg==
X-Google-Smtp-Source: AMsMyM76d5CrJrNXlgj/08ynu8WNtwGSQ4pYfTL4RojK3/QD3IddL8AcUWp1EwUXhH6ILcUlCU03jQ==
X-Received: by 2002:a1c:4b0d:0:b0:3b4:76ae:f7a5 with SMTP id y13-20020a1c4b0d000000b003b476aef7a5mr13233336wma.23.1663598863464;
        Mon, 19 Sep 2022 07:47:43 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-56-12.cust.vodafonedsl.it. [188.217.56.12])
        by smtp.gmail.com with ESMTPSA id y6-20020a7bcd86000000b003b33de17577sm13613692wmj.13.2022.09.19.07.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:47:42 -0700 (PDT)
Date:   Mon, 19 Sep 2022 16:47:40 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Martin Kepplinger <martink@posteo.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: hi846: Fix memory leak in hi846_parse_dt()
Message-ID: <20220919144740.GD3958@tom-ThinkPad-T14s-Gen-2i>
References: <20220919021252.730729-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919021252.730729-1-rafaelmendsr@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Sun, Sep 18, 2022 at 11:12:51PM -0300, Rafael Mendonca wrote:
> If any of the checks related to the supported link frequencies fail, then
> the V4L2 fwnode resources don't get released before returning, which leads
> to a memleak. Fix this by properly freeing the V4L2 fwnode data in a
> designated label.
> 
> Fixes: e8c0882685f9 ("media: i2c: add driver for the SK Hynix Hi-846 8M pixel camera")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> ---
>  drivers/media/i2c/hi846.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
> index ad35c3ff3611..254031503c72 100644
> --- a/drivers/media/i2c/hi846.c
> +++ b/drivers/media/i2c/hi846.c
> @@ -2008,22 +2008,24 @@ static int hi846_parse_dt(struct hi846 *hi846, struct device *dev)
>  	    bus_cfg.bus.mipi_csi2.num_data_lanes != 4) {
>  		dev_err(dev, "number of CSI2 data lanes %d is not supported",
>  			bus_cfg.bus.mipi_csi2.num_data_lanes);
> -		v4l2_fwnode_endpoint_free(&bus_cfg);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto check_hwcfg_error;
>  	}
>  
>  	hi846->nr_lanes = bus_cfg.bus.mipi_csi2.num_data_lanes;
>  
>  	if (!bus_cfg.nr_of_link_frequencies) {
>  		dev_err(dev, "link-frequency property not found in DT\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto check_hwcfg_error;
>  	}
>  
>  	/* Check that link frequences for all the modes are in device tree */
>  	fq = hi846_check_link_freqs(hi846, &bus_cfg);
>  	if (fq) {
>  		dev_err(dev, "Link frequency of %lld is not supported\n", fq);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto check_hwcfg_error;
>  	}
>  
>  	v4l2_fwnode_endpoint_free(&bus_cfg);
> @@ -2044,6 +2046,10 @@ static int hi846_parse_dt(struct hi846 *hi846, struct device *dev)
>  	}
>  
>  	return 0;
> +
> +check_hwcfg_error:
> +	v4l2_fwnode_endpoint_free(&bus_cfg);
> +	return ret;
>  }
>  
>  static int hi846_probe(struct i2c_client *client)
> -- 
> 2.34.1
> 

Looks good to me.

Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>


Regards,
Tommaso

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
