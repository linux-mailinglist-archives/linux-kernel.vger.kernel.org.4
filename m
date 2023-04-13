Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28D66E1622
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 22:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjDMUvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 16:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDMUvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 16:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F618697
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 13:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681419046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmQxpMzSuEyk+3REh88Siq0gb5rqCSxABB+pkkoj8lI=;
        b=HxkvCkJPlF4Hs93oHeK1O8L0Mg1SbCXa4sWSrxCwxDfB8GfArz0/w1d39YKcomF9tnyqVi
        ko+ZyPogPQCCfoQsG+W+mOheuh6nT1x9FBkatPsvSLWYRLzzT3Xoz/FoH9uw58ORSpSvfE
        YirKDJAhdX3Az0EtiyRMCHBtJWlUx5Q=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-VUY3R5JbNF2OpXCy7uCBJA-1; Thu, 13 Apr 2023 16:50:45 -0400
X-MC-Unique: VUY3R5JbNF2OpXCy7uCBJA-1
Received: by mail-qk1-f200.google.com with SMTP id q79-20020a374352000000b007484744a472so7886542qka.22
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 13:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681419045; x=1684011045;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmQxpMzSuEyk+3REh88Siq0gb5rqCSxABB+pkkoj8lI=;
        b=XKMXMiWjQLUfSNG/cIz+1n+ZinLmEPI68VW61zsj6/Of43j/SehrUF6BLu1RqjIyJa
         KKVff+0YZ1xu6KN+MIWuGYcItCwrZ62o+k5t/1B3Q0FOyzUh553s+69F0Pe02Yr3Hg4J
         ihLAXf7vDAmZUAozuKfqNN1+/G9rUSPGf7ew1AlbkNrLpDamhQl1SSw19/gvFE7Fgw4h
         S+sxHsbcOgEZ+zYzySd0BY/l8z73z7tmdUUx43Vd2uvKpIS7x0A8gJLxMoqgFZvZ6oe1
         lax75EGVKjjABY8ZSfn1J3gvkzQZL25Nact4z92RSdMb7EuxkDtNBIEvAFNjCwwTDwQX
         lXJA==
X-Gm-Message-State: AAQBX9euvFGhSfa7TzcMk/fiUg3EerV8QLjHa8FweabcJpIuYONx7pcc
        2m8yz5NuNtA0Fx2WWF/2F28ZNSZ9EI5JqMZKkD8fBywwvY/HJA2t+XmZ+QF4HoufhHCd0oUGJ4T
        bCkrWxIGUbTWDmqmZ0kxEDrdM
X-Received: by 2002:a05:622a:178f:b0:3d2:7950:f790 with SMTP id s15-20020a05622a178f00b003d27950f790mr5567159qtk.62.1681419044904;
        Thu, 13 Apr 2023 13:50:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350b12qT4nXWBVHubQJPdBC5iGLT75vNx2WB6Tcl30hDHb8I1dl6zwV8CoKpd3QHFzc9a8KqSHw==
X-Received: by 2002:a05:622a:178f:b0:3d2:7950:f790 with SMTP id s15-20020a05622a178f00b003d27950f790mr5567138qtk.62.1681419044690;
        Thu, 13 Apr 2023 13:50:44 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
        by smtp.gmail.com with ESMTPSA id a24-20020ac84358000000b003e64303bd2dsm739869qtn.63.2023.04.13.13.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 13:50:44 -0700 (PDT)
Message-ID: <61cccdbc80bfcaa2222c274e40c329ed84d41e55.camel@redhat.com>
Subject: Re: [PATCH 2/2] drm/nouveau: constify pointers to hwmon_channel_info
From:   Lyude Paul <lyude@redhat.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Date:   Thu, 13 Apr 2023 16:50:43 -0400
In-Reply-To: <20230407150031.79749-2-krzysztof.kozlowski@linaro.org>
References: <20230407150031.79749-1-krzysztof.kozlowski@linaro.org>
         <20230407150031.79749-2-krzysztof.kozlowski@linaro.org>
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

On Fri, 2023-04-07 at 17:00 +0200, Krzysztof Kozlowski wrote:
> Statically allocated array of pointed to hwmon_channel_info can be made
> const for safety.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> This depends on hwmon core patch:
> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@=
linaro.org/
>=20
> Therefore I propose this should also go via hwmon tree.
>=20
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> ---
>  drivers/gpu/drm/nouveau/nouveau_hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/no=
uveau/nouveau_hwmon.c
> index e844be49e11e..db30a4c2cd4d 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
> @@ -211,7 +211,7 @@ static const struct attribute_group temp1_auto_point_=
sensor_group =3D {
> =20
>  #define N_ATTR_GROUPS   3
> =20
> -static const struct hwmon_channel_info *nouveau_info[] =3D {
> +static const struct hwmon_channel_info * const nouveau_info[] =3D {
>  	HWMON_CHANNEL_INFO(chip,
>  			   HWMON_C_UPDATE_INTERVAL),
>  	HWMON_CHANNEL_INFO(temp,

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

