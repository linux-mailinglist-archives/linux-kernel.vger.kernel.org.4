Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989CB70D43A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 08:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjEWGpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 02:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjEWGpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 02:45:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EE618F
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684824251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LxBwvzkEHqqOVroWlGAw/iNlssiibA+1amVBXCL+nsY=;
        b=NETjl10fiaxkBCzrnKcU2L29HIXeKmgTIxbuLDU/ocmub2AQzNnG+4uK+bfroswc/jE9dl
        xfZUkph/3YrntAbt99EmYL2JPNiqdE4bGdZAr556n6RSlyLe5HthmhmN+6vBMugQgGF6M/
        fkJI1HwJW2bwh7i+BzlVlzttDbU+IZA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-2a3ETr1wOK2X21KhEgJWOA-1; Tue, 23 May 2023 02:44:09 -0400
X-MC-Unique: 2a3ETr1wOK2X21KhEgJWOA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3093e600770so4453158f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 23:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684824249; x=1687416249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxBwvzkEHqqOVroWlGAw/iNlssiibA+1amVBXCL+nsY=;
        b=Y2REYukfcGJpTF6SQMUINGO6yOFruQ/nc374jxR76Kv0VWM3d/X0VPX1DxP2dJuMUM
         leUHO4UU8Z+Onf6eY60twvuPU4WydTTlDvbXa29RSfQYJ17kAY8hLk6X/ULVemdh6qOk
         lxqcl2VnEEGDGk/5Ao00VUloH3dkrnJZJikrrWHJRBY3CjqxgeS7iEuC/AJnjLrLFqWI
         6/+xRmP7EDZwGA+yGPotF6jvnUl+HOIiAeJ7JCDnLaj/EbZMR6yuuMfuZzQbrWRNHUNe
         XBNuT+nUWKo62lWQwCJaGxg8A1st46vbczJc8OMNWJHBsU/ux9TKxW/xhea91vJA6yUN
         /X7w==
X-Gm-Message-State: AC+VfDzm+hXu2sZSku4jjkypn4FkKTFjbSxQo/MIZluSWubh8Hu7B4GH
        I1bFmoq+DmDO9vs1xaosGzlvMznusygPiJokdxKqRf2SzXm6KrdVfBW+m2C+Zd9Q1BJzuKsGqjO
        OBa8d4eXGh6Eu0Hk4IWkYkKMB
X-Received: by 2002:a5d:62c4:0:b0:306:4031:63c5 with SMTP id o4-20020a5d62c4000000b00306403163c5mr9649850wrv.51.1684824248828;
        Mon, 22 May 2023 23:44:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ57Dh7X7JU5EbJCqCwb8NWSsLs6JgePUHyfAxzIV6/bdnDkvcpqSuUq00iz0pdWTp4TRsT6TQ==
X-Received: by 2002:a5d:62c4:0:b0:306:4031:63c5 with SMTP id o4-20020a5d62c4000000b00306403163c5mr9649838wrv.51.1684824248585;
        Mon, 22 May 2023 23:44:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b003f09d7b6e20sm10650421wmc.2.2023.05.22.23.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 23:44:08 -0700 (PDT)
Message-ID: <6fbab263-1f49-126b-a108-6a94664334ee@redhat.com>
Date:   Tue, 23 May 2023 08:44:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drm/mgag200: set variable mgag200_modeset
 storage-class-specifier to static
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, airlied@redhat.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230517134140.874179-1-trix@redhat.com>
From:   Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20230517134140.874179-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 15:41, Tom Rix wrote:
> smatch reports
> drivers/gpu/drm/mgag200/mgag200_drv.c:23:5: warning: symbol
>    'mgag200_modeset' was not declared. Should it be static?
> 
> This variable is only used in its defining file, so it should be static
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
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

It looks good to me,

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

-- 

Jocelyn

