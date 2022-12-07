Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1CC6456FC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiLGKAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLGKAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:00:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9969D2B607
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:00:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D646D6E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:00:25 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4DD4A3FA58
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:00:18 -0800 (PST)
Date:   Wed, 7 Dec 2022 10:00:12 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     brian.starkey@arm.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: mali-dp: Add check for kzalloc
Message-ID: <Y5BkLAJM9e/t+Pya@e110455-lin.cambridge.arm.com>
References: <20221207092118.20603-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221207092118.20603-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 05:21:18PM +0800, Jiasheng Jiang wrote:
> As kzalloc may fail and return NULL pointer, it should be better to check
> the return value in order to avoid the NULL pointer dereference in
> __drm_atomic_helper_connector_reset.
> 
> Fixes: 8cbc5caf36ef ("drm: mali-dp: Add writeback connector")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Thanks for catching this!


Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu


> ---
>  drivers/gpu/drm/arm/malidp_mw.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
> index ef76d0e6ee2f..fe4474c2ddcf 100644
> --- a/drivers/gpu/drm/arm/malidp_mw.c
> +++ b/drivers/gpu/drm/arm/malidp_mw.c
> @@ -72,7 +72,11 @@ static void malidp_mw_connector_reset(struct drm_connector *connector)
>  		__drm_atomic_helper_connector_destroy_state(connector->state);
>  
>  	kfree(connector->state);
> -	__drm_atomic_helper_connector_reset(connector, &mw_state->base);
> +
> +	if (mw_state)
> +		__drm_atomic_helper_connector_reset(connector, &mw_state->base);
> +	else
> +		__drm_atomic_helper_connector_reset(connector, NULL);
>  }
>  
>  static enum drm_connector_status
> -- 
> 2.25.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
