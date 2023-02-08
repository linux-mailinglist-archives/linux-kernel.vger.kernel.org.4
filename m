Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D6E68EC50
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjBHKE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBHKEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:04:02 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C643C28
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:04:00 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id fi26so19675198edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b+MKsAgNDECJNr7eMNpaLeacOaefQQKTyy5x3zYKwJc=;
        b=L5/YqM2y4zXvNIHu8hHVmDZHKwSASI9vFWwQM0eJTMhL1WAAP6ppPH6EMEQ9E8HJur
         6v7MRZ3Gu0aHxW3UB81WjirBFpSZKe3CxKWaoSSTRJP5eK5za9Na4uEa4mBTDVPGw83U
         LjprxgObBiZoHfJ2LHtNnBbwCbV9sclsQNKSucwMOMhOhtL5Xc+1mZzDUgk7CClA1v/5
         KnPn0Ug88rWl1W/mfJYV5ttYq/FGTrGhf/t6uiXM+MzF1uB7pGTIFIWXrZB8ls4g9k3q
         zQ3Ul3DPo7+kAlvzAyTxevtPfa1pDiT8GtHLsXdVbNNi2crNLuZgn47Q19hDxTt9mbcg
         x0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+MKsAgNDECJNr7eMNpaLeacOaefQQKTyy5x3zYKwJc=;
        b=ES1dJsvYrI32wp/umN4P3JRLa0NNAyZD/UpKsPPhulUTUo0Qvw3MegqqKxBwqCJ+T3
         Y3+0lkhsvxvpo+OfPGtS59ycPxkTIa2vDOuUv/Oe64xp8HwPZuL0Ewza2JiElMF/RLrh
         iKo/uzpCJS5iLoxooJngotGITR/jBCCp78jLv4+EWPlAvRx6P4gQWtQUV+rMrjs1zRHT
         Mx6QirCCY43T41Q4xP9OGsP4d96fRcsMpEVHYFWVceJwGtsullZgmdNqvSxXDhlAXETd
         Hry/PJwYscUPN0on5YVdN3G+YcxoaMgfSEmYllv2fK4WzBBOrhPCf61uuyc8boZF9ABK
         tYQw==
X-Gm-Message-State: AO0yUKUb9Lgh77YF5WKp2BETbZmEf5ReOJPDVZjbESqw8lKLCIHYh64u
        JJ8gfwUvLF6gLHZD5c4ObNdMnA==
X-Google-Smtp-Source: AK7set8UVI3GFjjZ9+gVal+0sRv8IrpfJOpwhuo8tSLoaO04fElwyDBtqDiB8DKCXs9a0oiE1Rux8A==
X-Received: by 2002:a50:99c5:0:b0:4aa:b63f:a0e with SMTP id n5-20020a5099c5000000b004aab63f0a0emr7361416edb.17.1675850639600;
        Wed, 08 Feb 2023 02:03:59 -0800 (PST)
Received: from localhost (h-46-59-89-207.A463.priv.bahnhof.se. [46.59.89.207])
        by smtp.gmail.com with ESMTPSA id k10-20020aa7c04a000000b0049e09105705sm7546541edo.62.2023.02.08.02.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 02:03:59 -0800 (PST)
Date:   Wed, 8 Feb 2023 11:03:58 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     ye.xingchen@zte.com.cn
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: =?iso-8859-1?Q?platform?=
 =?iso-8859-1?Q?=3A_renesas=3A_use=A0devm=5Fplatform=5Fget=5Fand=5Fioremap?=
 =?iso-8859-1?B?X3Jlc291cmNlKCk=?=
Message-ID: <Y+NzjmNHaZFA5dxf@oden.dyn.berto.se>
References: <202302081659401393135@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202302081659401393135@zte.com.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ye,

Thanks for your work.

On 2023-02-08 16:59:40 +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/media/platform/renesas/rcar-isp.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/renesas/rcar-isp.c b/drivers/media/platform/renesas/rcar-isp.c
> index 10b3474f93a4..a3cfd21f8aae 100644
> --- a/drivers/media/platform/renesas/rcar-isp.c
> +++ b/drivers/media/platform/renesas/rcar-isp.c
> @@ -419,10 +419,7 @@ static const struct media_entity_operations risp_entity_ops = {
>  static int risp_probe_resources(struct rcar_isp *isp,
>  				struct platform_device *pdev)
>  {
> -	struct resource *res;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	isp->base = devm_ioremap_resource(&pdev->dev, res);
> +	isp->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
>  	if (IS_ERR(isp->base))
>  		return PTR_ERR(isp->base);
> 
> -- 
> 2.25.1

-- 
Kind Regards,
Niklas Söderlund
