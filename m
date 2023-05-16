Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A54704662
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjEPH2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjEPH2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:28:42 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B82EA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:28:40 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f41d087b24so74088215e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684222119; x=1686814119;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ojo8Lo8R8XK8o8hGTtw1jHEFL4HUoJLCCoc9AkFSnY=;
        b=v12KTHKxQx7EnacdOQpBFL+2hIuhtbpaBbjxbrtAe+ChJ5RR3t3q0K8xFdWFrO2Bd7
         qooSrpWB9G2Ay9YQPq7IS4vmR0bX1XLPQjghM3T6aYnncg+D0zWmt+d2TDo4FfKj5MBf
         FyP908dAJUBDgGUS8uSLj5WxFzkvp/qPmFpc4GucM8e1KTSP2xmdpaabCHaotXD1KWRZ
         ctxP24JPGrwkbvnDIPGSWK5Ua/JfgxJc4BddTj6rIgT7JMdwShv7+2vM9u/GEXh9b8K6
         gd2hbwSItIRpK6VFJN2wCWENQACqqel/Q4M9gccQh1uaM3ILrYQjuLQGa7pZwq5NDN9p
         x3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684222119; x=1686814119;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Ojo8Lo8R8XK8o8hGTtw1jHEFL4HUoJLCCoc9AkFSnY=;
        b=X6k9G5j5piSpj1qlnhM8SMxePuFOzdu7EA6GYpOSsXEigF9nIc7DznpPZtPW80uS9d
         Oy6JOERR0PbMyx5Rd8owvs/4QecU7LU87pJtkbyhBCSxwQMTbGYEedt5tnsIwcYR4pFE
         F8q9X00ZN2ICwcr3D9CktqsQtq+CNvYh36y0y8JYhg3zuqO9fAKgbSGHtLbn4rqQLX/P
         cVRGNV9iyKigip3Nk9auaugf55UX+pqLjl5mXMoPsygAQOYGWkyInSoyXwMEO//5+WYW
         /eV/QdGydXpuduqsclNtD5zhxqq4E3694XtAO0on7syOQd5t5EOBAh2lAwyVBnWW7L1L
         VFpg==
X-Gm-Message-State: AC+VfDwxFxWdfLQfVAyAwrH2vyJJVeHX9utPu86a1SFLXkra1PJRwNdx
        HMOIWSklVbGNKha2H/m/6+fXgA==
X-Google-Smtp-Source: ACHHUZ42qX1J7JrLjIhLZuo1JUdK8Gbwanywl8mt+dn28iE4LA33oZ6g2EXTVXGGEh0KZWJM0LufwA==
X-Received: by 2002:a1c:4b16:0:b0:3f4:fc5e:fbf2 with SMTP id y22-20020a1c4b16000000b003f4fc5efbf2mr7168144wma.8.1684222118984;
        Tue, 16 May 2023 00:28:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:86be:97a:a043:77a8? ([2a01:e0a:982:cbb0:86be:97a:a043:77a8])
        by smtp.gmail.com with ESMTPSA id j7-20020a5d4527000000b00307c46f4f08sm1533771wra.79.2023.05.16.00.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 00:28:38 -0700 (PDT)
Message-ID: <4cb44d8c-eff9-33a5-7488-d79963806a91@linaro.org>
Date:   Tue, 16 May 2023 09:28:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] gpu: drm: bridge: No need to set device_driver owner
Content-Language: en-US
To:     Anup Sharma <anupnewsmail@gmail.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <ZF9igb/nvL6GRBsq@yoga>
Organization: Linaro Developer Services
In-Reply-To: <ZF9igb/nvL6GRBsq@yoga>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2023 12:12, Anup Sharma wrote:
> There is no need to exclusively set the .owner member of the struct
> device_driver when defining the platform_driver struct. The Linux core
> takes care of setting the .owner member as part of the call to
> module_platform_driver() helper function.
> 
> Issue identified using the platform_no_drv_owner.cocci Coccinelle
> semantic patch as:
> drivers/gpu/drm/bridge/samsung-dsim.c:1957:6-11: No need to set .owner here.
> The core will do it.
> 
> No functional changes are intended.
> 
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>   drivers/gpu/drm/bridge/samsung-dsim.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index e0a402a85787..10dc3315e69e 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1954,7 +1954,6 @@ static struct platform_driver samsung_dsim_driver = {
>   	.remove = samsung_dsim_remove,
>   	.driver = {
>   		   .name = "samsung-dsim",
> -		   .owner = THIS_MODULE,
>   		   .pm = &samsung_dsim_pm_ops,
>   		   .of_match_table = samsung_dsim_of_match,
>   	},

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
