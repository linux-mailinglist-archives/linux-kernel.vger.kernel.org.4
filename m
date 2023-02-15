Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553B1698876
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 00:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjBOXCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 18:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBOXCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 18:02:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F179CA5EC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 15:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676502094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bsYrZzYMtnpPy1dLr5xbLMKSM/UlrfB6vQQZ4rqlNLU=;
        b=NiXaxVTK20gbeaP3qVDS4q5xLiKwCMIxLWiXEDZM0sR7HlNvstDGGg/dtuDFUPflaekL1B
        AMXIAX7ujD0v3/RprwwZDbOqivIcYP+ksqWrbOyWaMlrApUn5fP++xNM+mt5CgYU2dncKt
        dcVoclvt/UP5eq4dW1bN5mmkIU70RRs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-310-zO2lA7PFOX6_bUE2f0ELLw-1; Wed, 15 Feb 2023 18:01:32 -0500
X-MC-Unique: zO2lA7PFOX6_bUE2f0ELLw-1
Received: by mail-qk1-f200.google.com with SMTP id a6-20020a05620a102600b00729952b4c73so112489qkk.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 15:01:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsYrZzYMtnpPy1dLr5xbLMKSM/UlrfB6vQQZ4rqlNLU=;
        b=sj0d5FESTyANXwy/+81O4q0j4yFHqbnzi09oIymuxbjMw1QS2WptROU+UvpIdgWHfS
         cJ25NVKkXbJLBbNDDfp12UuQjJ2NLWns27aHJQTYoHYlGcq4ie/lvE6cy2tZVPhrCLaw
         PHQ5ZGr4UApyh61UBFePq4OV1fexTKLuiQCOJDR5l0lzlJEf4QcwBbiqpDO3zerSNOSc
         29xtdwQOVgdd+jN5JZ1F4soh4GQ6WJg9xf4InX0lWlcNSDP+K2Zy90eI2kEPWyO6Omy0
         eXcTcoL2tXl+qdp1RrEcpjh5aA49OMgN4eYr2nbotkECtniSkKp7aEcDlQKtX3FdiDpx
         oiYA==
X-Gm-Message-State: AO0yUKVy1SzrFJdgvPWvYlcUlonVovbLWFBB9P1py8lflaiK5yCkfURL
        coIvRz5v1ZaT7Bw1fCRY/61WddG34afCnVaxIaZjoB59TdcYeOVjTw2Xd4jJ4Y6BJDzt+ZPwi60
        0daB2oDUs3iNsnsnWQGBcjbmC
X-Received: by 2002:ac8:7f16:0:b0:3b9:b422:4d5b with SMTP id f22-20020ac87f16000000b003b9b4224d5bmr6282646qtk.26.1676502092426;
        Wed, 15 Feb 2023 15:01:32 -0800 (PST)
X-Google-Smtp-Source: AK7set+qnHViHFdBUIjxUI6M3KrFKZ6NirVS+Cp47Y7N9ahccvHsZrp34JkpSRGEGSaqRlksgX+0TA==
X-Received: by 2002:ac8:7f16:0:b0:3b9:b422:4d5b with SMTP id f22-20020ac87f16000000b003b9b4224d5bmr6282620qtk.26.1676502092198;
        Wed, 15 Feb 2023 15:01:32 -0800 (PST)
Received: from ?IPv6:2600:4040:5c68:6800::feb? ([2600:4040:5c68:6800::feb])
        by smtp.gmail.com with ESMTPSA id o190-20020a375ac7000000b0073b45004754sm6662405qkb.34.2023.02.15.15.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 15:01:31 -0800 (PST)
Message-ID: <d676862c180af8c5325fb00f0e2e469e6f600835.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/led: explicitly include linux/leds.h
From:   Lyude Paul <lyude@redhat.com>
To:     Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 15 Feb 2023 18:01:30 -0500
In-Reply-To: <20230215-power_supply-leds-nouveau-v1-1-ea93bfa0ba7e@weissschuh.net>
References: <20230215-power_supply-leds-nouveau-v1-1-ea93bfa0ba7e@weissschuh.net>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-next in a moment

On Wed, 2023-02-15 at 01:04 +0000, Thomas Wei=C3=9Fschuh wrote:
> Instead of relying on an accidental, transitive inclusion of linux/leds.h
> use it directly.
>=20
> Also drop the forware definition of struct led_classdev that is now
> provided by linux/leds.h.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  drivers/gpu/drm/nouveau/nouveau_led.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_led.h b/drivers/gpu/drm/nouv=
eau/nouveau_led.h
> index 21a5775028cc..bc9bc7208da3 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_led.h
> +++ b/drivers/gpu/drm/nouveau/nouveau_led.h
> @@ -27,7 +27,7 @@
> =20
>  #include "nouveau_drv.h"
> =20
> -struct led_classdev;
> +#include <linux/leds.h>
> =20
>  struct nouveau_led {
>  	struct drm_device *dev;
>=20
> ---
> base-commit: e1c04510f521e853019afeca2a5991a5ef8d6a5b
> change-id: 20230215-power_supply-leds-nouveau-ff4995ba0794
>=20
> Best regards,

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

