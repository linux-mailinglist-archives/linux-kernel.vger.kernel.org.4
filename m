Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833A66A9992
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 15:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjCCOfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 09:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjCCOen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 09:34:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6561ADE4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 06:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677854026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F1Sn0/mypHkU6ly+1mTIVNlEYcj+rMktwAvyJJ3xDBs=;
        b=I6p1X2k/mW8MaIC7/hbJTVnqCv7I8acbSQbiIGXrWYDwB9Pxfp+NiOQnZy46ztN3kvdX02
        x6WVa2oXZI307RkrLMsQsZaf8dEWV7TYsujX6MNKXC4JVY19OvmAaNnGBxrQHee6+qL2IA
        E4yBohRB/5mzCUGqfUgTK+L6Da2OeUo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-bTS_egN-Njm6DXCXTLzQrg-1; Fri, 03 Mar 2023 09:33:45 -0500
X-MC-Unique: bTS_egN-Njm6DXCXTLzQrg-1
Received: by mail-lf1-f72.google.com with SMTP id o22-20020a056512051600b004db26d37741so1088387lfb.19
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 06:33:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677854024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1Sn0/mypHkU6ly+1mTIVNlEYcj+rMktwAvyJJ3xDBs=;
        b=X3x0XohmZZPPJjtBaFnnf9ZX2Sy94ecds08wYXGailLblJgVCU9ouVcGLMiqVIGfOz
         yG3FZaGb/oolkCPaEmlgZwO8YmDUkMJOJBzdoOH+6TcBpK6pGWm+kHWFxBhQc+Po8BFR
         NVgsOrHEwOeFiKYaj/sxGzbsUSkQe02r9vk3bWs6utsrvGaZrRDazT4BTQgZEyyZyd+X
         thv2cxBhJGzC3WizmOn7O/v9XCfX1WPyUSW4fcG8CW6QhT9CuJM5I6pEpWLW9D5G6pwZ
         C/5m51D/AVmIsXh5MbI0Btmz6Gvn1TxR6eMsPClinQnfYv4c5+4ChrqhehV7nkxQE6yd
         BGew==
X-Gm-Message-State: AO0yUKWfEFe4mpX1zS4gtlLA9KWUIMYmxtxjLQ4defYSR5cGsDQhfzmQ
        IuCTFpQ4E7Asqf7nMv6F4HhzJAECSncYIhVy0ZLQx0aPoHRXSrzD6b1ACrEwgLNxAU/K7xWTgQR
        lw3vlOcBsTtAqlaZljqrNzyOBvtsunhA6M7qFFqTD
X-Received: by 2002:a2e:a269:0:b0:295:ab47:119b with SMTP id k9-20020a2ea269000000b00295ab47119bmr617037ljm.8.1677854024021;
        Fri, 03 Mar 2023 06:33:44 -0800 (PST)
X-Google-Smtp-Source: AK7set8dskGiDMeG1f4EFzCLSCJINA3Rk6cJqgMITbg2NCrdgTqKLg2n24Jl1IpBJ42JYGk53ZIokiHYAl2dT1gNbFI=
X-Received: by 2002:a2e:a269:0:b0:295:ab47:119b with SMTP id
 k9-20020a2ea269000000b00295ab47119bmr617027ljm.8.1677854023781; Fri, 03 Mar
 2023 06:33:43 -0800 (PST)
MIME-Version: 1.0
References: <20230228221533.3240520-1-trix@redhat.com>
In-Reply-To: <20230228221533.3240520-1-trix@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 3 Mar 2023 15:33:31 +0100
Message-ID: <CACO55tvJH=VmTf+Wv4Lf56eEPp3vO1Aoa6Sb1=UYnRzFkVardg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/fifo: set nvkm_engn_cgrp_get
 storage-class-specifier to static
To:     Tom Rix <trix@redhat.com>
Cc:     bskeggs@redhat.com, lyude@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

will push in a moment

On Tue, Feb 28, 2023 at 11:15 PM Tom Rix <trix@redhat.com> wrote:
>
> smatch reports
> drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c:33:18:
>   warning: symbol 'nvkm_engn_cgrp_get' was not declared. Should it be static?
>
> nvkm_engn_cgrp_get is only used in runl.c, so it should be static
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c
> index b5836cbc29aa..93d628d7d508 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/runl.c
> @@ -30,7 +30,7 @@
>  #include <subdev/timer.h>
>  #include <subdev/top.h>
>
> -struct nvkm_cgrp *
> +static struct nvkm_cgrp *
>  nvkm_engn_cgrp_get(struct nvkm_engn *engn, unsigned long *pirqflags)
>  {
>         struct nvkm_cgrp *cgrp = NULL;
> --
> 2.27.0
>

