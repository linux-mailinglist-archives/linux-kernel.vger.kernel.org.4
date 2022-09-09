Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC5C5B3862
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiIIM6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiIIM6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:58:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6E612EDB5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:58:13 -0700 (PDT)
Received: from [192.168.1.111] (91-158-154-79.elisa-laajakaista.fi [91.158.154.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1EA0EDD;
        Fri,  9 Sep 2022 14:58:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1662728291;
        bh=xZE/ULnaE8gHZyDMtXBvtajaMHf/HkDKqUGVh12Fz+w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=wJ/oohFEKz/CiEZ/GmeHmIwxb2UYdipO8+tblKR+blponZwZfDP2XbXwQyRz8YZ2B
         s4ETAnxEnNokPoS/vHdfPGnajIThS/FkKQlly55joPfaM9XoqBYx1Ngq5oXqYENs5+
         7Rruq4W5SubQmC8JXk2S5ucp0fg6F0rvXvYrXK/Y=
Message-ID: <6c073c53-a8ed-7654-4fdc-460015a60537@ideasonboard.com>
Date:   Fri, 9 Sep 2022 15:58:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm: omapdrm: dss: replace ternary operator with max()
Content-Language: en-US
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Benoit Parrot <bparrot@ti.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:DRM DRIVERS FOR TI OMAP" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     zhengkui_guo@outlook.com
References: <20220517050208.121488-1-guozhengkui@vivo.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20220517050208.121488-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 08:02, Guo Zhengkui wrote:
> Fix the following coccicheck warning:
> 
> drivers/gpu/drm/omapdrm/dss/dispc.c:2454:21-22: WARNING opportunity for max()
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>   drivers/gpu/drm/omapdrm/dss/dispc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
> index c4de142cc85b..0ee344ebcd1c 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dispc.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
> @@ -2451,7 +2451,7 @@ static int dispc_ovl_calc_scaling_44xx(struct dispc_device *dispc,
>   
>   	*decim_x = DIV_ROUND_UP(width, in_width_max);
>   
> -	*decim_x = *decim_x > decim_x_min ? *decim_x : decim_x_min;
> +	*decim_x = max(*decim_x, decim_x_min);
>   	if (*decim_x > *x_predecim)
>   		return -EINVAL;
>   

Thanks, applying to drm-misc.

  Tomi
