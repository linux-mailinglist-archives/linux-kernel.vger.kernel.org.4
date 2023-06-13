Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68CA72ED5B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjFMUxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjFMUxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485FC10F4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686689548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIa77HRSdBKT6S16d75u879eapT8fSGaZYoI3I+WbCE=;
        b=CEh3fK3eXzzSXmq0KCVGvwzF4ETcP945Z1Ysy4ZG9VfJ4nLHngjrrkkqEq61P+mV8Ejqgg
        BAuf+0vx2oNWNBmLBeEDqhKt8PCDs3ULqhF8mgZYDdQxsSaIhGeU188MC4Vr3hAZ+B8jLq
        NOMAEKzOynQwQXliHenWWtmLUzdAXXA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-JzuytH6PN8aRihJL1ZUsOw-1; Tue, 13 Jun 2023 16:52:27 -0400
X-MC-Unique: JzuytH6PN8aRihJL1ZUsOw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62def2d2814so15407336d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686689547; x=1689281547;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIa77HRSdBKT6S16d75u879eapT8fSGaZYoI3I+WbCE=;
        b=cAal1r+A3yWZbCcKiZ0Mvq6Coo6AX8cN8KUoI0Q99i34v36U/7fA2eZ5xnW6VOfpcU
         D87z/0mJ8IYTLfiFwXqdG9Pv8weedhdJ2KryiTI8jCkQ0Q8I9+zq+qQNHk+CpHFr2xD/
         LGzepktfzf3S9XpEgQHEwQSEUgbxN2dcLRcQPWFdPDikDPWHenuhLU2uj916akpPtfKd
         uUCJ/bOiqo/r9DtBvfXTTk74lT4+s8GY8bjHXuUlubh40EQ1zZv4CMIOpONFwThBsiSf
         baq2nFi3UHgphj7YFJL2+j6kpnt6lwjCuq/L6sAVGhdRkeoyqcCuR3HiehYdN7jsR1Da
         9E0w==
X-Gm-Message-State: AC+VfDy+bwf2b1NUgBC9Ag1aWSlxInCIUePWZ+0QlAxt3Dg58/JYxySJ
        8DuY3Q6Jg0yDFtZJ/rVb321ZTCiDjkV6y1aJb5KbcwJl1JTsKnHJ/O6sVUA274+NaO0c1xkuW0Y
        oWGtmFdolqJObxf1uy3sjXN7P
X-Received: by 2002:a05:6214:2a83:b0:626:2e70:1f9e with SMTP id jr3-20020a0562142a8300b006262e701f9emr16080881qvb.43.1686689546867;
        Tue, 13 Jun 2023 13:52:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6xxfS+KO1lw43/6Kbo4gkehjnOBVC8nzu65iDFeRMbZNF7mPkkUq+0dV4/GDawuKv+9xBzcw==
X-Received: by 2002:a05:6214:2a83:b0:626:2e70:1f9e with SMTP id jr3-20020a0562142a8300b006262e701f9emr16080866qvb.43.1686689546580;
        Tue, 13 Jun 2023 13:52:26 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
        by smtp.gmail.com with ESMTPSA id c16-20020a05620a135000b0075aff6f835bsm3876799qkl.19.2023.06.13.13.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:52:26 -0700 (PDT)
Message-ID: <602351ea7a1addf1b1349536fa8d23435d2862ad.camel@redhat.com>
Subject: Re: [PATCH] nouveau_connector: add nv_encoder pointer check for NULL
From:   Lyude Paul <lyude@redhat.com>
To:     Natalia Petrova <n.petrova@fintech.ru>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Karol Herbst <kherbst@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Date:   Tue, 13 Jun 2023 16:52:25 -0400
In-Reply-To: <20230512103320.82234-1-n.petrova@fintech.ru>
References: <20230512103320.82234-1-n.petrova@fintech.ru>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nice catch!

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push upstream

On Fri, 2023-05-12 at 13:33 +0300, Natalia Petrova wrote:
> Pointer nv_encoder could be dereferenced at nouveau_connector.c
> in case it's equal to NULL by jumping to goto label.
> This patch adds a NULL-check to avoid it.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: 3195c5f9784a ("drm/nouveau: set encoder for lvds")
> Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
> ---
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/dr=
m/nouveau/nouveau_connector.c
> index 43a9d1e1cf71..90ba6d0a9c80 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -729,7 +729,8 @@ nouveau_connector_detect_lvds(struct drm_connector *c=
onnector, bool force)
>  #endif
> =20
>  	nouveau_connector_set_edid(nv_connector, edid);
> -	nouveau_connector_set_encoder(connector, nv_encoder);
> +	if (nv_encoder)
> +		nouveau_connector_set_encoder(connector, nv_encoder);
>  	return status;
>  }
> =20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

