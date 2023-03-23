Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD466C732C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjCWWgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCWWgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:36:47 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AABB233E9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:36:46 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a16so18406600pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679611006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O2EVXxP53sCH2kR6bCBtvDTkeq2j54v1M0wBknWsFZk=;
        b=ZDA+QqKpKudc5b7HJjQhCTmQKFpajXXwL+MJK7LJJ+QCYEeuGxhdnT43AIVD9GIEVf
         x7PYsZCTx+EOLgN23mOLbXglwf6ovJBiKZ1VheRL27JswcOj5Tn99O/isD2UJk2mrpUW
         PGDgsNjyO/OCLJfd1Wtx1aFXzsuFoGSkxG9g9b6zSwE25q2DYK9iKF3545ir0kmxObm0
         i2d0h5UtyJ5mMVYn8ulD/GV+txzg8TWcG6B/1PRZIh/JELWARKZBkUziUfpwD0h0uPdv
         CWshmbyPLp2T/BpPhYy7gl573EPRBreyyjDvvlky+xoTXZyya6RWwgBoVKJ471QOH2I2
         JUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679611006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2EVXxP53sCH2kR6bCBtvDTkeq2j54v1M0wBknWsFZk=;
        b=jOQa0bFMemWdOKOThV3IgXynPDB52PtXHICAZckHSzZ0X2LnIAyRoKa4PMiLvxGKmf
         YgZMZDJHTy9OGZCQVBmELzsatQ+mihHtycvtvDet25+bT3AS2ze9YSsIO9yilINbmpMV
         CvgNFqKDM14ApEOvSVZAzRSt57IDInWQru8lkhMpwFQZyqb9y8K+/qZIeiS0a6rw6ir+
         ox/y12vLLD1MTch/MMeQR/ACUrQMY+xDh0tt0DHtA4XrYhK+y+6i//L8KpYj9GWDouEP
         ySp4irpUOddgZBnY3b11MzL/dC9VUCGyuDVaPr5Xgh8tmdJhiHXeT8OiYAwZERu1qWyT
         li5g==
X-Gm-Message-State: AAQBX9fxbohwBu7bCavcxfsM7tg3n4x1xPXvb8Coedf3efTvKs7ZPiMt
        n313nZkM7KvOS8eevn/XeV56XIhMsYPU4xDP1dM=
X-Google-Smtp-Source: AKy350a8Hts1wCQys+KoyaeDXX6B3yC3s3JOLLf8LLeRQwdW+r3kjhnmJG52vH6H6vfw5z4UgWerLg==
X-Received: by 2002:a17:90b:3811:b0:23b:3d6e:1ed with SMTP id mq17-20020a17090b381100b0023b3d6e01edmr587920pjb.13.1679611005616;
        Thu, 23 Mar 2023 15:36:45 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:e403:39f9:7f9f:340b])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090a7a8300b00230b8402760sm1713333pjf.38.2023.03.23.15.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 15:36:45 -0700 (PDT)
Date:   Thu, 23 Mar 2023 16:36:43 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ye.xingchen@zte.com.cn
Cc:     andersson@kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc/davinci: Use dev_err_probe()
Message-ID: <20230323223643.GA2905636@p14s>
References: <202303231600496082749@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303231600496082749@zte.com.cn>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 04:00:49PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with dev_err_probe() to simplify the code.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/remoteproc/da8xx_remoteproc.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index 98e0be9476a4..b2b7d3347949 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -278,13 +278,9 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  	}
> 
>  	dsp_reset = devm_reset_control_get_exclusive(dev, NULL);
> -	if (IS_ERR(dsp_reset)) {
> -		if (PTR_ERR(dsp_reset) != -EPROBE_DEFER)
> -			dev_err(dev, "unable to get reset control: %ld\n",
> -				PTR_ERR(dsp_reset));
> -
> -		return PTR_ERR(dsp_reset);
> -	}
> +	if (IS_ERR(dsp_reset))
> +		return dev_err_probe(dev, PTR_ERR(dsp_reset),
> +				     "unable to get reset control: %ld\n");

This patch is obviously wrong and doesn't even compile.

> 
>  	if (dev->of_node) {
>  		ret = of_reserved_mem_device_init(dev);
> -- 
> 2.25.1
