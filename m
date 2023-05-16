Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE75B704B24
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjEPKxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjEPKxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:53:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B1A5B80
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:52:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so109082525e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684234376; x=1686826376;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S8e0W9XIRRFwkTucaV524mAiYHtqA6kUJZ/8Od4Fg1I=;
        b=ox72IdHqGsLn8rjwhpNCEe+xurcOrXliCf9CMdNLrn7SBoenukNB0sd3QZSrcbzrgh
         cPPpArRj2G6AJ2t9PHQzmnSAO0WemYzbtCkMLRvqDahluj8trXc1G88EB5/IgIkWokfz
         /sKi+gG+hPSi13ifv4FHquVA3UpVuK/lAvY4iu8wFExArkRLTJ4jidkBqvR4yNwPRDaP
         XMElvl4V1Ef/AQiYpWnc/j8JZrh/26pC4diCO1+6zaMuOGdZy9HOF4HW0oIh50gBa/X3
         00Eqx3ZJdZljs06sL6jZPLcc5PPPtJt4inPu1Y6EHYISt7+Bhl7z9r+TN3LKW/wSi91M
         P9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684234376; x=1686826376;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S8e0W9XIRRFwkTucaV524mAiYHtqA6kUJZ/8Od4Fg1I=;
        b=SWbQjrAURg3Wzl8XG2X/dXE7pUyV3XlVRSp1uRYiItKCSAomPtfWAeEaWlWVD5IgJM
         2RRwQ+LwCsbTC34o852p7phWXDueTNDmmsLpQl9EejnjsWRQtuG57Z+PGa7EsbOIz9KW
         Jm0o9Wd5KjOo2sdKgz+BtOlrN7FAAOJpr3LS/XzqnEhvCu5fBfxQx1+DuhRyhQXS3b83
         1m489m6SyW5/r8+dqcY0keJXl2QxshLsNuTZTeC4DKe5mIKySDuz1f7VW3lvVIeMVCXR
         xrgiaYfnTfGmdV/ywyJwBUjCw9hO/HEvJJczdOfTob1+cAQA65YHpPrhHFYuWPqL+MrD
         oQ3w==
X-Gm-Message-State: AC+VfDzIGgp4GRQ+MjVxnd5BLsQbMqrl1oDPtTZ7AopzxOlvwrkBtqmi
        1hqtIAOBRfURnspEQD516GsBog==
X-Google-Smtp-Source: ACHHUZ4NAGd6C/KMQbHDnesnmLick0uXIlD1Wf0A4Guj7OAALzkYL5waJbcu/xBIIOb+vJXswaJVpg==
X-Received: by 2002:a05:600c:2257:b0:3f4:2b98:428f with SMTP id a23-20020a05600c225700b003f42b98428fmr18097657wmm.39.1684234375886;
        Tue, 16 May 2023 03:52:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:86be:97a:a043:77a8? ([2a01:e0a:982:cbb0:86be:97a:a043:77a8])
        by smtp.gmail.com with ESMTPSA id x8-20020a05600c21c800b003f4f8cc4285sm1910151wmj.17.2023.05.16.03.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 03:52:55 -0700 (PDT)
Message-ID: <e6ffc9e1-eead-6cd1-dd59-bc17439e6ec3@linaro.org>
Date:   Tue, 16 May 2023 12:52:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: simple: fix active size for Ampire
 AM-480272H3TMQW-T01H
Content-Language: en-US
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <treding@nvidia.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        dri-devel@lists.freedesktop.org
References: <20230516085039.3797303-1-dario.binacchi@amarulasolutions.com>
Organization: Linaro Developer Services
In-Reply-To: <20230516085039.3797303-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 10:50, Dario Binacchi wrote:
> The previous setting was related to the overall dimension and not to the
> active display area.
> In the "PHYSICAL SPECIFICATIONS" section, the datasheet shows the
> following parameters:
> 
>   ----------------------------------------------------------
> |       Item        |         Specifications        | unit |
>   ----------------------------------------------------------
> | Display area      | 98.7 (W) x 57.5 (H)           |  mm  |
>   ----------------------------------------------------------
> | Overall dimension | 105.5(W) x 67.2(H) x 4.96(D)  |  mm  |
>   ----------------------------------------------------------
> 
> Fixes: 966fea78adf23 ("drm/panel: simple: Add support for Ampire AM-480272H3TMQW-T01H")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>   drivers/gpu/drm/panel/panel-simple.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> index 065f378bba9d..d8efbcee9bc1 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -759,8 +759,8 @@ static const struct panel_desc ampire_am_480272h3tmqw_t01h = {
>   	.num_modes = 1,
>   	.bpc = 8,
>   	.size = {
> -		.width = 105,
> -		.height = 67,
> +		.width = 99,
> +		.height = 58,
>   	},
>   	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
