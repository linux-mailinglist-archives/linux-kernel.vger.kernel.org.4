Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA0E6AF927
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjCGWpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjCGWpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:45:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBED9DE18
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678228991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bBISRmWtyk5b0q7tO/ZlpLIwLMdyIaEEvwZMNTD2oyo=;
        b=LnhD8ZopbZZz6e9Rn9+o+e3d+qD1qJNluPe3gkNt0xwI5PeCpDF/vDrBcDmhuALu0s8iuy
        gJH+ogCO9ro4ZUSahvmWP4X5TKf8lVWRyu++5NY4KKE2MVwIcep6NXGITo4oD3wTff+tqF
        Ogvk4/WOmL6N3FGLLR0hSaN//xL56xA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-CAR8tR0uO1CAJXxqFYJQqA-1; Tue, 07 Mar 2023 17:43:10 -0500
X-MC-Unique: CAR8tR0uO1CAJXxqFYJQqA-1
Received: by mail-qt1-f198.google.com with SMTP id l17-20020ac84cd1000000b003bfbae42753so7984696qtv.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 14:43:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678228990;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBISRmWtyk5b0q7tO/ZlpLIwLMdyIaEEvwZMNTD2oyo=;
        b=pHi9KvuG8CNtJtw9A3IzKrmgv7HyGk2Pzl5UEcc158TTR2wJScFFcvzW7nCOsaY5ra
         2XDjctKGFeGmwqMAynynWieXR31keUXzwiol9sP5z43YhWFsqygTSm+7Y9Jiyls8wGcq
         hhw/l4LifYHNNK2+vVcrIpUcQaMoBPkg7valE6c8DRTGWiN4VErDs+quRV+UWCEHOa3k
         TBUdkLL5czn7D2MWSwPm3NDw2Ys1aRy8Bu54ASpV6WCi3WVUGmRCV15QI8xQtLOWBmBz
         iZBOiq1HxLb0jpEs1CGoWfBLltpkxIG+Kwhnv7NK4b5rqibZ8QViK9jDvoBfxzwXclz2
         OI9g==
X-Gm-Message-State: AO0yUKXYyKKwGFJ/Pr/bZUDIUkV0UTMlM/FntjFrFmF0/INjn5Q1WOte
        tQPCd5djRg+/rQ07Eia44k3I6vr1LiGBpvER6S5/ewj4doAXhmNMD05GJ3BkoaKGHORaBIPBva6
        ENrvKgs1NigIYiqB9mi8yFgwd
X-Received: by 2002:ac8:5c02:0:b0:3b8:525e:15ec with SMTP id i2-20020ac85c02000000b003b8525e15ecmr30590750qti.27.1678228989822;
        Tue, 07 Mar 2023 14:43:09 -0800 (PST)
X-Google-Smtp-Source: AK7set+Me9bTPhI1hFsGeGjWpMBd7fZ9BKtiTY5Thb2DH2wKRapu1088yY+WA0JY2Qyr92U3nNacYw==
X-Received: by 2002:ac8:5c02:0:b0:3b8:525e:15ec with SMTP id i2-20020ac85c02000000b003b8525e15ecmr30590731qti.27.1678228989586;
        Tue, 07 Mar 2023 14:43:09 -0800 (PST)
Received: from ?IPv6:2600:4040:5c68:6800::feb? ([2600:4040:5c68:6800::feb])
        by smtp.gmail.com with ESMTPSA id u24-20020a37ab18000000b006fa16fe93bbsm10313451qke.15.2023.03.07.14.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:43:09 -0800 (PST)
Message-ID: <2732d141a82c0f9410d001fe656d30c5e32311de.camel@redhat.com>
Subject: Re: [PATCH 0/2] drm/nouveau: avoid usage of list iterator after loop
From:   Lyude Paul <lyude@redhat.com>
To:     Jakob Koschel <jkl820.git@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Date:   Tue, 07 Mar 2023 17:43:07 -0500
In-Reply-To: <20230301-drm-nouveau-avoid-iter-after-loop-v1-0-0702ec23f970@gmail.com>
References: <20230301-drm-nouveau-avoid-iter-after-loop-v1-0-0702ec23f970@gmail.com>
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

Will push upstream in just a moment

On Wed, 2023-03-01 at 18:25 +0100, Jakob Koschel wrote:
> This patch set includes two instances where the list iterator variable
> 'pstate' is implicitly assumed to be valid after the iterator loop.
> While in pratice that is most likely the case (if
> 'pstatei'/'args->v0.state' is <=3D the elements in clk->states), we shoul=
d
> explicitly only allow 'pstate' to always point to correct 'nvkm_pstate'
> structs.
>=20
> That allows catching potential bugs with BUG_ON(!pstate) that otherwise
> would be completely undetectable.
>=20
> It also helps the greater mission to hopefully move the list iterator
> variable into the iterating macro directly [1].
>=20
> Link: https://lore.kernel.org/all/CAHk-=3DwgRr_D8CB-D9Kg-c=3DEHreAsk5SqXP=
wr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
> ---
> Jakob Koschel (2):
>       drm/nouveau/device: avoid usage of list iterator after loop
>       drm/nouveau/clk: avoid usage of list iterator after loop
>=20
>  drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c | 9 ++++++---
>  drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c    | 9 ++++++---
>  2 files changed, 12 insertions(+), 6 deletions(-)
> ---
> base-commit: c0927a7a5391f7d8e593e5e50ead7505a23cadf9
> change-id: 20230301-drm-nouveau-avoid-iter-after-loop-4bff97166efa
>=20
> Best regards,

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

