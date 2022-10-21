Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3C0608093
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJUVLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJUVLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37BD29CBAE
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666386701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tb5G8Q5vATxNip+KIvKKwBUveWJ2RwJYjzfJBGeAXxg=;
        b=ZMsvVDZFxd0uEA5CD9fgCQZ0kYp18KM0gTEZl0nrndUmc5l7OWvt9ZwqN1NgiZUBqn7He2
        P9/xyIoh0Kdpn0uxdBMJ9CtTmVTcDPj5JzhdwAlTuqlIBpJ62ftDc0A13H+OkdPWu5PAce
        Rlv/5f/JRd6BL/gR6/D29H0sZmZmuC8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-122-oKntkaKJMdSKksSJTEBaeQ-1; Fri, 21 Oct 2022 17:11:40 -0400
X-MC-Unique: oKntkaKJMdSKksSJTEBaeQ-1
Received: by mail-qv1-f69.google.com with SMTP id ny15-20020a056214398f00b004b9152f4b53so3000251qvb.17
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 14:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tb5G8Q5vATxNip+KIvKKwBUveWJ2RwJYjzfJBGeAXxg=;
        b=1D5oqJvSka+dUI47WKD7/XyTr6CcgEhkbkuXFJvtSUkVwX5iP6WoVA/DZfmzzT89KU
         ETpXbft6aSPnDtzhxBLSz4rLwUJ+1jB2o82oQrY6rliQtETs4JTApMStXFeVDaeJNwH6
         SasQ1pEDtOHhKfw3UCED0fn8Zj5Jbosgdvp6HzWDkEIbkrfV5HYlyzm9J5FSStAHu1/c
         /kaFdbIXVDDgGnW0VWw2mLfbAEwF4j+dAE95CMybFhdPXMn15gJ+khVSIeD52Lz54sEQ
         eZ3NTWUqVr/es3mgXgrBHiHW5wLl+XWYIFTR8OlnTxcHqnEevCkBWN6+whO4UhmqOn4X
         JCbA==
X-Gm-Message-State: ACrzQf0r2Sg+pvH5UwGaGn+gauJDkolCg9jL3mvcXDjAdGtgewflkTk0
        ZFUM7ni5enwKY9d8MK4tI/hkYi/DpHENoG7qtxq8oeN/WmGjP8DPGG0piMo9LpigECwOOdrDEHn
        S9jVN7R5x9VKlr39t0UmEquhY
X-Received: by 2002:a05:6214:2483:b0:4bb:59ec:c5a7 with SMTP id gi3-20020a056214248300b004bb59ecc5a7mr3071180qvb.94.1666386699530;
        Fri, 21 Oct 2022 14:11:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7KgayDfa/OfgLiBOflAoe1rYw1XFXkm1/ap8s3joDTxP0ofbKbGObX5+tK8zXV+pqU3S2xcQ==
X-Received: by 2002:a05:6214:2483:b0:4bb:59ec:c5a7 with SMTP id gi3-20020a056214248300b004bb59ecc5a7mr3071157qvb.94.1666386699307;
        Fri, 21 Oct 2022 14:11:39 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c68:4300::feb? ([2600:4040:5c68:4300::feb])
        by smtp.gmail.com with ESMTPSA id fw10-20020a05622a4a8a00b0039cba52974fsm8491618qtb.94.2022.10.21.14.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 14:11:38 -0700 (PDT)
Message-ID: <54135445ebea45857a95ac86db1c22804996af8c.camel@redhat.com>
Subject: Re: [PATCH -next] nouveau/dmem: Remove duplicated include in
 nouveau_dmem.c
From:   Lyude Paul <lyude@redhat.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, bskeggs@redhat.com
Cc:     kherbst@redhat.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Date:   Fri, 21 Oct 2022 17:11:37 -0400
In-Reply-To: <20221017000723.113744-1-yang.lee@linux.alibaba.com>
References: <20221017000723.113744-1-yang.lee@linux.alibaba.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push in just a moment to drm-misc-next, thanks!

On Mon, 2022-10-17 at 08:07 +0800, Yang Li wrote:
> ./drivers/gpu/drm/nouveau/nouveau_dmem.c: nvif/if000c.h is included more
> than once.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2404
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_dmem.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index 5fe209107246..e2c500aac273 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -33,7 +33,6 @@
>  #include <nvif/if000c.h>
>  #include <nvif/if500b.h>
>  #include <nvif/if900b.h>
> -#include <nvif/if000c.h>
>  
>  #include <nvhw/class/cla0b5.h>
>  

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

