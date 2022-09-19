Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00725BCEF1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiISOdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiISOcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:32:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50C82B612
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:32:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d12-20020a05600c3acc00b003b4c12e47f3so4682318wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=A9ZVitjkAEGpnZEnzG/yYMW8bMjYpZFzQstbESMk85k=;
        b=Hsc0/7dJ93g3C+RM6B0gh6s2C0QY2FmJ2P8mPyz5ZiV6KdI21qpn/nqwB3o55E9v/3
         yr2IWNh6rundlOl3H7tKrAkLDuqs2TVP+MXlbsOcZTqBWlUK9tbf+2d94EKJXjA9AWPk
         4R6zaAk8+PXOqmGdDUMp0HcFpeX8P8wI9Omm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=A9ZVitjkAEGpnZEnzG/yYMW8bMjYpZFzQstbESMk85k=;
        b=NaO1VbXzVzGVvirI0RVr/Agq9H34HrJRvJ/jEueX0D3qnDUkTSmoRrVWl2ht+a3oHv
         C+wAEig9XX+SdA6/TL+X2oSYC1u4bX6G8e9xUQeBG9l2qj9ahwlCng2UrvEJGzIEhmqb
         oTkQpYPjXXK/9h/JOiXG5qhgjfFhvc0xrHw+87uMGzRC6gpWRYsZj3gumkkPwDFcYMAQ
         P1hcH/+Z/qCkuzuf909LC8V7dWJLBh6pAJpmL2rFObujkgrxMnXGZ46Pdt7tXS7ixgG8
         tS9KfUZUug7W+TdvT5+v3qZUpUMVcVLN6GhLDvbaMLdf7iyFVQxsCI0SPRBxX1CzR8LK
         9JqQ==
X-Gm-Message-State: ACrzQf0Eh3eSDjgZjbyDL3x+kbmOLE4yrURjkIuUcCnEdSLwcjRNWEa1
        e7IMrFD7Dc3KBNtX7/NMsy77Dw==
X-Google-Smtp-Source: AMsMyM68+bWGmJaxNe7ptaLx1otoAMgV7X/EAQqBGtn/31ky1deDBYUNZ9a/l1yfeCEUFlWL/PfDQw==
X-Received: by 2002:a05:600c:434c:b0:3b4:82fb:5f78 with SMTP id r12-20020a05600c434c00b003b482fb5f78mr12493510wme.157.1663597950298;
        Mon, 19 Sep 2022 07:32:30 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-56-12.cust.vodafonedsl.it. [188.217.56.12])
        by smtp.gmail.com with ESMTPSA id p5-20020a5d4585000000b002206203ed3dsm13909632wrq.29.2022.09.19.07.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:32:29 -0700 (PDT)
Date:   Mon, 19 Sep 2022 16:32:27 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: ov5648: Free V4L2 fwnode data on unbind
Message-ID: <20220919143227.GC3958@tom-ThinkPad-T14s-Gen-2i>
References: <20220919023247.731106-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919023247.731106-1-rafaelmendsr@gmail.com>
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

On Sun, Sep 18, 2022 at 11:32:46PM -0300, Rafael Mendonca wrote:
> The V4L2 fwnode data structure doesn't get freed on unbind, which leads to
> a memleak.
> 
> Fixes: e43ccb0a045f ("media: i2c: Add support for the OV5648 image sensor")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> ---
>  drivers/media/i2c/ov5648.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/i2c/ov5648.c b/drivers/media/i2c/ov5648.c
> index dfcd33e9ee13..95850f06112b 100644
> --- a/drivers/media/i2c/ov5648.c
> +++ b/drivers/media/i2c/ov5648.c
> @@ -2598,6 +2598,8 @@ static int ov5648_remove(struct i2c_client *client)
>  	mutex_destroy(&sensor->mutex);
>  	media_entity_cleanup(&subdev->entity);
>  
> +	v4l2_fwnode_endpoint_free(&sensor->endpoint);
> +
>  	return 0;
>  }
>  
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
