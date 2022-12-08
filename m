Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120A0646ED2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLHLnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiLHLnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:43:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1D1054777
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 03:43:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94FB9D6E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 03:43:07 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B2FB3F73B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 03:43:00 -0800 (PST)
Date:   Thu, 8 Dec 2022 11:42:55 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     robin.murphy@arm.com, brian.starkey@arm.com, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: mali-dp: Add check for kzalloc
Message-ID: <Y5HNv5BEEzB2Gt9W@e110455-lin.cambridge.arm.com>
References: <20221208031621.3274-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221208031621.3274-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiasheng,

I appreciate the effort you have put into this and I find nothing wrong with the
intention of the patch. However, I don't intend to move base from being the first
member of the malidp_mw_connector_state struct as it has other benefits in the code
and we can use container_of() in implementation of generic APIs. As Robin has rightly
pointed, it is unlikely that a compiler will dereference the pointer before doing
offset_of(), so having mw_state == NULL is safe, even if quirky.

So I'm going to thank you for the patch but I will not merge it.

As a side comment, please use --in-reply-to and link to previous email when re-sending
patches with small spelling fixes as otherwise it gets confusing on which email is the last
one and it also relies on the servers delivering messages in the order you've sent,
not always a strong guarantee.

Best regards,
Liviu

On Thu, Dec 08, 2022 at 11:16:21AM +0800, Jiasheng Jiang wrote:
> As kzalloc may fail and return NULL pointer, the "mw_state" can be NULL.
> If the layout of struct malidp_mw_connector_state ever changes, it
> will cause NULL poineter derefernce of "&mw_state->base".
> Therefore, the "mw_state" should be checked whether it is NULL in order
> to improve the robust.
> 
> Fixes: 8cbc5caf36ef ("drm: mali-dp: Add writeback connector")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
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
