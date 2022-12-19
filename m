Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D616A65147A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiLSUz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiLSUzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:55:50 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2882BF0D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1671483337; bh=waCi45GdEdTwDkLLovTT2hmNdulmbavhyJqMsALuGDQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=dLqRjNyilTr7mIMwT2/JTnrKremz09RAY7UNTEESt/F4CtiEewh98v/1AvrGe8WIq
         3yHYfaD/a5GZ1z67Z7EYG/fNOtVogx/PT+1Ml8Y7HMEK+C9fU2dKfL1c8UsIFU8q4Q
         hEG6y9I9angkB2dCvdaSI/EWh+wr1kLpmO58dMMY=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon, 19 Dec 2022 21:55:37 +0100 (CET)
X-EA-Auth: X7OgntSeEwUep+7q3TqTeZXw7KjXoM8PSczU0FZ1xHjtCg6EB278jhA0NJruH5+8nhteGA5v1YCNAjVNCmMT/vLkxAobcNRG
Date:   Tue, 20 Dec 2022 02:25:32 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>, drv@mailo.com
Subject: Re: [PATCH] drm/sprd: remove redundant error logging
Message-ID: <Y6DPxKGmfRH5Bujn@qemulion>
References: <Y5XhPJ39ipMCcctq@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5XhPJ39ipMCcctq@qemulion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 07:25:08PM +0530, Deepak R Varma wrote:

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
>  drivers/gpu/drm/sprd/sprd_dpu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
> index 88f4259680f1..db0bcea1d9f4 100644
> --- a/drivers/gpu/drm/sprd/sprd_dpu.c
> +++ b/drivers/gpu/drm/sprd/sprd_dpu.c
> @@ -803,10 +803,8 @@ static int sprd_dpu_context_init(struct sprd_dpu *dpu,
>  	}
>
>  	ctx->irq = platform_get_irq(pdev, 0);
> -	if (ctx->irq < 0) {
> -		dev_err(dev, "failed to get dpu irq\n");
> +	if (ctx->irq < 0)
>  		return ctx->irq;
> -	}
>
>  	/* disable and clear interrupts before register dpu IRQ. */
>  	writel(0x00, ctx->base + REG_DPU_INT_EN);
> --
> 2.34.1
>


