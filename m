Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5670F651BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiLTHlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiLTHln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:41:43 -0500
X-Greylist: delayed 579 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Dec 2022 23:41:42 PST
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D22F72
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:41:42 -0800 (PST)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id AEEBC5C03AF;
        Tue, 20 Dec 2022 08:32:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1671521520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/z0MB0ZIFP6aeujFH0p44anRHbnTFFLRrIGfOtCkCsA=;
        b=wgXLk1fPwI5tusswIE/FVXABCqdMsTd4Ewelb8wZZfeqOiyccCdgwwMycuAL9xayASQ5OP
        NPl6uRIVPAqWR3ncZNOHxYkBz9ZHZQJKSUf2V1sxdsTKuqrAAmgiWFIEth433dZFi6IG9F
        84bJ8jwNDilNZ+t8o29aIl5LA+nVjVU=
MIME-Version: 1.0
Date:   Tue, 20 Dec 2022 08:32:00 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Alison Wang <alison.wang@nxp.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] drm/fsl-dcu: Remove redundant error logging
In-Reply-To: <Y5Wwo6Gr1rJOdf3B@qemulion>
References: <Y5Wwo6Gr1rJOdf3B@qemulion>
Message-ID: <cbc2c587a04324f807a9c3d8d221f289@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-11 11:27, Deepak R Varma wrote:
> A call to platform_get_irq() already prints an error on failure within
> its own implementation. So printing another error based on its return
> value in the caller is redundant and should be removed. The clean up
> also makes if condition block braces unnecessary. Remove that as well.
> 
> Issue identified using platform_get_irq.cocci coccicheck script.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>

Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> ---
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> index 8579c7629f5e..1ba7d95e1956 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> @@ -272,10 +272,8 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
>  	}
> 
>  	fsl_dev->irq = platform_get_irq(pdev, 0);
> -	if (fsl_dev->irq < 0) {
> -		dev_err(dev, "failed to get irq\n");
> +	if (fsl_dev->irq < 0)
>  		return fsl_dev->irq;
> -	}
> 
>  	fsl_dev->regmap = devm_regmap_init_mmio(dev, base,
>  			&fsl_dcu_regmap_config);
> --
> 2.34.1
