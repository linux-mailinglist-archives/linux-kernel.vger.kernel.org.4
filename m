Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9204A73A10C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjFVMgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjFVMgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:36:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025251BC6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687437355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o3pBXTuB3tzuuBUsdWyQRug37awOIMzuxqG56/45cYw=;
        b=YefFbdO1nR2+EZnSXKgq6ZgbTxRQZCQrK3FS8AMBQBRMTNtjr34iPZHqS2DzO3GnqVWJEp
        V8l0Wvw0ZSGybFA0+II3SkEzCqFBoSkaa8wkbujY6k5yx/4LSZQAky/to0cMN9zohpW+IM
        AYTKZE1xb7uvX0U2uhp+2pD/PAP6lnQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-QLAevEJsN3Ctzzd4iEGrbw-1; Thu, 22 Jun 2023 08:35:54 -0400
X-MC-Unique: QLAevEJsN3Ctzzd4iEGrbw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30e4d85e1ffso10645111f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 05:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687437353; x=1690029353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3pBXTuB3tzuuBUsdWyQRug37awOIMzuxqG56/45cYw=;
        b=doZ03reTh8ROTlfuj3thtnP2Fgms97IsZhX4Jy3FBYgExeV1ZIk2/LA3yEXwdNowSD
         ONI+QY27XQ/ZXZs925XLb+7Bsm6enuXhmuZrNJS16fdnJ+D+m0W5HtfsmA7Wx03dodFO
         hwSmpS7EtZq59NoW8T/LJnPvrnBHQ0j/En1syjHuXzOUEeydp42yaF550HXNIIbvUf5V
         Mju9AsM+C/H4uF7ZlDJrUZNdSW2XO2doBHo4YNGwbR+3DwDM7bWX63dKx3NnefCAyXfb
         zb8hIaOhugFyeKA8F50WyvwOeFyUV4z6XGDmzMvsWDIGVcgnxdlTrMJRBVI8cjq2MzcQ
         NotQ==
X-Gm-Message-State: AC+VfDzKZOzDfIjUxKIcfLB8aVb6AOvC958KE6HBq4YVp+9ZfTg0a1A8
        VvHhD66QoguwYvUhZmB7BhCqmWUAuhsTitGwfoeU1HBcm88N64LEnSAW26tiuOsgiwAfTkE9baF
        nhQ8kmNAFsqNmANeiBENW2KxX
X-Received: by 2002:adf:df81:0:b0:311:1cd7:68b3 with SMTP id z1-20020adfdf81000000b003111cd768b3mr18688363wrl.57.1687437353357;
        Thu, 22 Jun 2023 05:35:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/IgalXYDuJ4s/OfSxQU7RlstK05ku6b/vAJRJl/dYkeQFv9nh31ixKyyAH3vZITc0Y/uPcg==
X-Received: by 2002:adf:df81:0:b0:311:1cd7:68b3 with SMTP id z1-20020adfdf81000000b003111cd768b3mr18688349wrl.57.1687437353049;
        Thu, 22 Jun 2023 05:35:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id a16-20020adfe5d0000000b0030e5a63e2dbsm6993575wrn.80.2023.06.22.05.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 05:35:52 -0700 (PDT)
Message-ID: <8e7011fe-6757-e89f-c3c5-d5f87cf83766@redhat.com>
Date:   Thu, 22 Jun 2023 14:35:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/mgag200: Fix a warning reported by Fi.CI.SPARSE
Content-Language: en-US
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230621191139.2291139-1-suijingfeng@loongson.cn>
From:   Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20230621191139.2291139-1-suijingfeng@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was already sent by Tom Rix last month:
https://patchwork.freedesktop.org/series/117881/

I can push it to drm-misc-next, if Thomas is ok.

Best regards,

-- 

Jocelyn

On 21/06/2023 21:11, Sui Jingfeng wrote:
> drivers/gpu/drm/mgag200/mgag200_drv.c:23:5: warning: symbol 'mgag200_modeset' was not declared. Should it be static?
> 
> Found in the log of Fi.CI.SPARSE test [1]
> 
> [1] https://patchwork.freedesktop.org/series/119249/
> 
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>   drivers/gpu/drm/mgag200/mgag200_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
> index 976f0ab2006b..abddf37f0ea1 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_drv.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
> @@ -20,7 +20,7 @@
>   
>   #include "mgag200_drv.h"
>   
> -int mgag200_modeset = -1;
> +static int mgag200_modeset = -1;
>   MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
>   module_param_named(modeset, mgag200_modeset, int, 0400);
>   

