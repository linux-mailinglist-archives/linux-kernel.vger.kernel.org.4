Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1937170A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjE3WWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjE3WWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:22:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8347106;
        Tue, 30 May 2023 15:21:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83D1863450;
        Tue, 30 May 2023 22:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E71C433D2;
        Tue, 30 May 2023 22:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685485314;
        bh=KIc/pp1lOWtTgIyst2JNrfoGv5WLci5gKABpg1IBUx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lrm6iAfkq5oCiLKo3eLSlvibhpItzBRgAlKYT1IbbWm4DhfffmNQ5Kbkc5IMBT+dQ
         z/BlERcBVmq+eA3PmJ925+zx3TlxlFkZYRtmlegS3m6V74SYfGu/9bg/UOaydE+2wA
         UE2jROuXxcjlOZuPyXn+MNvP036ABcil7TWUoev531/tJhsptWY1FlLboQPsOy8m4Z
         XE7Wuy52mG5UcB2uKJXLZt3fVOMRmQ9DSaEWmQluiaaOHmtoNLJzzQf8novuLLn8D0
         WHk1ok406k2DSu0ootecDRmT8bcqBgN4vn8yYuw25dS45x9pReZlAdQ7zrErXV+q8f
         MknRyZ6XAPF+A==
Date:   Wed, 31 May 2023 00:21:50 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Min Li <lm0963hack@gmail.com>
Cc:     inki.dae@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@gmail.com, daniel@ffwll.ch,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/exynos: fix race condition UAF in
 exynos_g2d_exec_ioctl
Message-ID: <20230530222150.24oogloda6wtvpvm@intel.intel>
References: <20230526130131.16521-1-lm0963hack@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526130131.16521-1-lm0963hack@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Min,

On Fri, May 26, 2023 at 09:01:31PM +0800, Min Li wrote:
> If it is async, runqueue_node is freed in g2d_runqueue_worker on another
> worker thread. So in extreme cases, if g2d_runqueue_worker runs first, and
> then executes the following if statement, there will be use-after-free.
> 
> Signed-off-by: Min Li <lm0963hack@gmail.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> index ec784e58da5c..414e585ec7dd 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> @@ -1335,7 +1335,7 @@ int exynos_g2d_exec_ioctl(struct drm_device *drm_dev, void *data,
>  	/* Let the runqueue know that there is work to do. */
>  	queue_work(g2d->g2d_workq, &g2d->runqueue_work);
>  
> -	if (runqueue_node->async)
> +	if (req->async)

did you actually hit this? If you did, then the fix is not OK.

Andi

>  		goto out;
>  
>  	wait_for_completion(&runqueue_node->complete);
> -- 
> 2.34.1
> 
