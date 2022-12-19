Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4F0651479
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiLSUzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiLSUzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:55:10 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BCB250
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671483295; bh=s1sQlm2kQ9grw8/lPjD8fVTCLGUGSAtcnGN7RJNWehY=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=B//zdFtnztVdGIAFg4MqqivQx36REsseZtlYZrGDsWfdCax8Ubb+XuF2qrIW1GFiT
         g+1IfTuuUHuWwKxSAGXJjdncksET5PFJw6D8UT4VYd5cyyk+1lJtNMFflChm1R3BDb
         LMneWYdAM0RUJT00YXAhVxaEVgeuDyyRVfuzrteA=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon, 19 Dec 2022 21:54:55 +0100 (CET)
X-EA-Auth: +xRRt2MufM8h78N2MJA9ct698ssjJ4j4PxrVbxeoZq07KNYf0g4LxEcigp3kTT9WpdEEFVAj78EU1GHr/d8GEKOOvFQINCSM
Date:   Tue, 20 Dec 2022 02:24:50 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: Re: [PATCH] drm/fsl-dcu: Remove redundant error logging
Message-ID: <Y6DPmlBgNGeH+TvU@qemulion>
References: <Y5Wwo6Gr1rJOdf3B@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5Wwo6Gr1rJOdf3B@qemulion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 03:57:47PM +0530, Deepak R Varma wrote:

Hello,
May I please request a review and feedback on this patch proposal?

Thank you,
./drv

> A call to platform_get_irq() already prints an error on failure within
> its own implementation. So printing another error based on its return
> value in the caller is redundant and should be removed. The clean up
> also makes if condition block braces unnecessary. Remove that as well.
>
> Issue identified using platform_get_irq.cocci coccicheck script.
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
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
>


