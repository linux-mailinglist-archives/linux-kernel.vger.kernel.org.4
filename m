Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B445C0553
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiIUReL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIUReI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:34:08 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEE6A1D69
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:34:07 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 207so6619151pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=tqW8IrEN/2v5/od3wWBPeJsmt7XPs5O3rrI2SPgUWJU=;
        b=OV+pX2ADGO9Thd3w6cm3wsy6HdwQyBOvRf3huuNhr2e0lzE8RaczFP0LrefxluscY9
         ZPCVPDcdkhtnnUZfzL7ttXlzZ85N/hsaAAFVphy/dScnDWmX9cgnmEr4d28k3H12SJDv
         ch+plLUbtXcWNmsNJtbjOriDr4ATFMmz1WmnoUoIQ3l1bcOm7LlQ2WO1a2dhuyhR+oD3
         UVnH3JrOVmFbwlAv7t8cC65sf5+dZuLd7HRKWWFLq1tsZIMitML2ga+3690alWtTGHSi
         b6xihVujC5Bn2qvaStzOR6jWtE+yBBdoXICHz4rU6A9zXNuR1Me+6mjcyQhH4DxkWQ2X
         AGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=tqW8IrEN/2v5/od3wWBPeJsmt7XPs5O3rrI2SPgUWJU=;
        b=KqpaIUIWWiIRpbcIzoo6UA4X+nnYgXf30iO7n1UTIFCmmul0fnDXs4d7/XWe95EaIz
         daUExv5TINlTQsoC8hqdv975jwHjMBiEj+5crNLVhdjNKhNvOB7yeq9Et3aTEW8V/iAb
         t1DOTqML6FD35PgZ1wKNsuQHVOLm1JlgUYDnz5nVYUvrT9xFhSWLublifXf2KsuGJIW1
         iFY+H9S8iKf/SOjyPvIcEuiCLGFzyOCkLgx2TYpY+IKgB9Plx8VJSwkIGWLLO/LIbDW6
         f81N5kkUxE9ufPCfX6Ug2xCixYgIiL1+TJoztWjJ2iUc5PGWygHBLKyQBnTxMjM566fk
         L3MQ==
X-Gm-Message-State: ACrzQf2EgY+q74qnibTia+YOUkDCmV/yT3mFool+5zqJ6gCFttbofKIN
        r1GJNnpBLCJ47S597doh33G5Vw==
X-Google-Smtp-Source: AMsMyM4pLXs9BEKjMLbhvSH92Rqr3M26qZQoo1sXp7W9nWSNMBersFVbi36c3lLwS/o5v+HDmjXqOg==
X-Received: by 2002:a05:6a00:1781:b0:53a:8572:4453 with SMTP id s1-20020a056a00178100b0053a85724453mr30657060pfg.76.1663781647136;
        Wed, 21 Sep 2022 10:34:07 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902e98b00b001751c61d3b8sm2288550plb.211.2022.09.21.10.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 10:34:05 -0700 (PDT)
Date:   Wed, 21 Sep 2022 11:34:03 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     andersson@kernel.org, arnaud.pouliquen@foss.st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com
Subject: Re: [PATCH v2] rpmsg: char: Avoid double destroy of default endpoint
Message-ID: <20220921173403.GB1126145@p14s>
References: <1663725523-6514-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663725523-6514-1-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 09:58:43AM +0800, Shengjiu Wang wrote:
> The rpmsg_dev_remove() in rpmsg_core is the place for releasing
> this default endpoint.
> 
> So need to avoid destroying the default endpoint in
> rpmsg_chrdev_eptdev_destroy(), this should be the same as
> rpmsg_eptdev_release(). Otherwise there will be double destroy
> issue that ept->refcount report warning:
> 
> refcount_t: underflow; use-after-free.
> 
> Call trace:
>  refcount_warn_saturate+0xf8/0x150
>  virtio_rpmsg_destroy_ept+0xd4/0xec
>  rpmsg_dev_remove+0x60/0x70
> 
> The issue can be reproduced by stopping remoteproc before
> closing the /dev/rpmsgX.
> 
> Fixes: bea9b79c2d10 ("rpmsg: char: Add possibility to use default endpoint of the rpmsg device")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> changes in v2:
> - Add comments
> 
>  drivers/rpmsg/rpmsg_char.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 0850ae34fb88..3e0b8f3496ed 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -76,7 +76,9 @@ int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
>  
>  	mutex_lock(&eptdev->ept_lock);
>  	if (eptdev->ept) {
> -		rpmsg_destroy_ept(eptdev->ept);
> +		/* The default endpoint is released by the rpmsg core */
> +		if (!eptdev->default_ept)
> +			rpmsg_destroy_ept(eptdev->ept);

Applied.

Thanks,
Mathieu

>  		eptdev->ept = NULL;
>  	}
>  	mutex_unlock(&eptdev->ept_lock);
> -- 
> 2.34.1
> 
