Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECEE5BB6AD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 08:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIQGfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 02:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIQGf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 02:35:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4972A713
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 23:35:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b35so34414226edf.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 23:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=I7fH7xM2QntBl/3ZfFF6X3xIpZY2sK9i3vAPrDeAMYc=;
        b=FF+dt4BGFbsH14kVvDc+MGjC//oE/MAlXMWtj0S6K/fzF6AkSzzFsgQ7W9w6fPI48q
         Shfo34XJXMS2buiEZPUISCMdIFJj+N40oNvT27xQnP0m7wssqzr7q3bgCKQ0Vlf6osCE
         j+UuteUG2p+QEDDD5S/DWjg08dt5rRUEHXVTaab2u2V32iw4KZml5x/GhcQZhxudSxIS
         8Vusequ2tAsUBhPfWuiNWR5wghTphaHbMIzWo8jrFWXW29KIjtHnpdy8yWOUPlLX/kxn
         j+l/SLpmFVSYK9b15+jGJtQPu4V+pDo6wDO6ozVRny2X3VA6EfcaoiPMtLAt69IoYQep
         DzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=I7fH7xM2QntBl/3ZfFF6X3xIpZY2sK9i3vAPrDeAMYc=;
        b=i21SquklolngmBsiswQ4O8ec+V5e1IGYn0lrHFBQ+uDTdmJbrFlTdNzPOTDhYkWhua
         LHM7/IxnfyMpjrNiakeR6yzEt/FA4gPBx9ASntU/2jhC0WlcFqVfLQaNCZ7yfXIKvl8q
         YoZJJ0VKIsjw1NsIj87lqtHHDzh3vxQGrlkuLLBwkuj2cuKBee2DfJtJzs9+cY2CYFdp
         UrypTqgEcHFzL87uSTgvNUnqjfuGzp33Zw/xFksO84vp8/ckgTtapImMWNLLpnfVsbmG
         vu0VfK7NuOyNNBu0avg877fhNb6aQuWQ7D9VivBPc99JMl6TjN1vBZBatRc1uFWF90WM
         lF0Q==
X-Gm-Message-State: ACrzQf1KixSkSUbg/kvXs2upX0BY2RvxtHw6UtEOLT0cL50+n9cZ9uLm
        IlFunHTmMvlyBtWpSzTXAJM=
X-Google-Smtp-Source: AMsMyM4KC0vfNFMs1aijxmybiqmZRZcNzFkgFje05cuMXXQLT9p3K/oE40zhonkkleVxcqbP4cXTlQ==
X-Received: by 2002:aa7:d51a:0:b0:453:9086:fc37 with SMTP id y26-20020aa7d51a000000b004539086fc37mr2372020edq.174.1663396525771;
        Fri, 16 Sep 2022 23:35:25 -0700 (PDT)
Received: from [192.168.2.181] (46-10-149-62.ip.btc-net.bg. [46.10.149.62])
        by smtp.gmail.com with ESMTPSA id o22-20020aa7c7d6000000b0044e9601e53fsm14929755eds.19.2022.09.16.23.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 23:35:25 -0700 (PDT)
Message-ID: <d9c9e901-a96d-e6ed-497c-a69eede2e36e@gmail.com>
Date:   Sat, 17 Sep 2022 09:35:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/vmwgfx: Fix memory leak in vmw_mksstat_add_ioctl()
Content-Language: en-US
To:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Martin Krastev <krastevm@vmware.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220916204751.720716-1-rafaelmendsr@gmail.com>
From:   "Martin Krastev (VMware)" <martinkrastev768@gmail.com>
In-Reply-To: <20220916204751.720716-1-rafaelmendsr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the catch!

Reviewed-by: Martin Krastev <krastevm@vmware.com>


Regards,

Martin



On 16.09.22 г. 23:47 ч., Rafael Mendonca wrote:
> If the copy of the description string from userspace fails, then the page
> for the instance descriptor doesn't get freed before returning -EFAULT,
> which leads to a memleak.
>
> Fixes: 7a7a933edd6c ("drm/vmwgfx: Introduce VMware mks-guest-stats")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> ---
>   drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
> index 2aceac7856e2..089046fa21be 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
> @@ -1076,6 +1076,7 @@ int vmw_mksstat_add_ioctl(struct drm_device *dev, void *data,
>   
>   	if (desc_len < 0) {
>   		atomic_set(&dev_priv->mksstat_user_pids[slot], 0);
> +		__free_page(page);
>   		return -EFAULT;
>   	}
>   
