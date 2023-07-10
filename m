Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFE474D263
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjGJJ60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjGJJ5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B153D49E1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688982737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XyjO7rBhUclhrrRCvtGKtbyfJKZVHucBecdHP85gxs0=;
        b=HCGjLx9fEJYmehG3p4dakgKfuF8fsBKX0/XWnyCqWcVZSXQL+hI5v4zEq77B8eQGBulWDV
        yw7RhWwF6Nci8n9mI+4qKE43XgI/toxTZBDW2B+KEBeM2wFwNMsOR0m5fSCGiTVuP5+7rY
        GgEd/ZGJeZ1RgfKWSPi5FnVTkZq+zaQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-ezksOHp9OsC9XDe7BwS3fw-1; Mon, 10 Jul 2023 05:52:16 -0400
X-MC-Unique: ezksOHp9OsC9XDe7BwS3fw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-315998d6e7fso610391f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688982735; x=1691574735;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyjO7rBhUclhrrRCvtGKtbyfJKZVHucBecdHP85gxs0=;
        b=Jx9NqPlVM+HT5fz1/q41lUKXg6mXziyZzQJnB1VhHiEzwHH1tVZS4r+bglRznJ/SpI
         n4in8+7UGwUtJtEJEtvUohoqD8dkf8jtaLwMpqm2vsV54MapbV8/MBnNf+l2zhX87o3R
         ktem/9D5HZzgQj73gPYdwNtJVD4KtHzYdbzLr7BKLTL97lVy0z413+c1J6Nb56IQjfq6
         3LUbJP613PvjMS75IGNvln5oAS/sSsr8W9oPr8nAjcr5B5RxLqrPssWV0e3azL6NJgyX
         YbNGgHAzTvr7rnO/DO13dtPf1zbtCNG2NdHWWXDyaBXSg8AH/7iE8eUMVrJ295v4basV
         Twxg==
X-Gm-Message-State: ABy/qLYj1LRhdKL2mYzqe8waTAvtslEaA6PDPWNIJJHl0Ww2bZrqcYbD
        B+d0fjcTSKFkkobQaJl1mw6nMqfhP/9s3TJV4NjMVQO9s6qPzavj/osfgjXTjLE4eiPMpwoUdZ9
        LXe0GN1TFT54Z0/mOBKsqSCcp
X-Received: by 2002:a05:6000:124a:b0:314:2b0a:dabe with SMTP id j10-20020a056000124a00b003142b0adabemr10426017wrx.30.1688982735487;
        Mon, 10 Jul 2023 02:52:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHaQ/+IdPxGPjymocfW9cv9tWGipFqf6RaAd0AZG/bTyXsaB00iseKuCq4q/hOVcXPiHegqow==
X-Received: by 2002:a05:6000:124a:b0:314:2b0a:dabe with SMTP id j10-20020a056000124a00b003142b0adabemr10425963wrx.30.1688982734861;
        Mon, 10 Jul 2023 02:52:14 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d4d0d000000b002fb60c7995esm11286630wrt.8.2023.07.10.02.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:52:14 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, noralf@tronnes.org
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Moritz Duge <MoritzDuge@kolahilft.de>,
        Torsten Krah <krah.tm@gmail.com>,
        Paul Schyska <pschyska@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/client: Send hotplug event after registering a client
In-Reply-To: <20230710091029.27503-1-tzimmermann@suse.de>
References: <20230710091029.27503-1-tzimmermann@suse.de>
Date:   Mon, 10 Jul 2023 11:52:13 +0200
Message-ID: <87edlghz5e.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Generate a hotplug event after registering a client to allow the
> client to configure its display. Remove the hotplug calls from the
> existing clients for fbdev emulation. This change fixes a concurrency
> bug between registering a client and receiving events from the DRM
> core. The bug is present in the fbdev emulation of all drivers.
>
> The fbdev emulation currently generates a hotplug event before
> registering the client to the device. For each new output, the DRM
> core sends an additional hotplug event to each registered client.
>
> If the DRM core detects first output between sending the artificial
> hotplug and registering the device, the output's hotplug event gets
> lost. If this is the first output, the fbdev console display remains
> dark. This has been observed with amdgpu and fbdev-generic.
>
> Fix this by adding hotplug generation directly to the client's
> register helper drm_client_register(). Registering the client and
> receiving events are serialized by struct drm_device.clientlist_mutex.
> So an output is either configured by the initial hotplug event, or
> the client has already been registered.
>
> The bug was originally added in commit 6e3f17ee73f7 ("drm/fb-helper:
> generic: Call drm_client_add() after setup is done"), in which adding
> a client and receiving a hotplug event switched order. It was hidden,
> as most hardware and drivers have at least on static output configured.
> Other drivers didn't use the internal DRM client or still had struct
> drm_mode_config_funcs.output_poll_changed set. That callback handled
> hotplug events as well. After not setting the callback in amdgpu in
> commit 0e3172bac3f4 ("drm/amdgpu: Don't set struct
> drm_driver.output_poll_changed"), amdgpu did not show a framebuffer
> console if output events got lost. The bug got copy-pasted from
> fbdev-generic into the other fbdev emulation.
>
> Reported-by: Moritz Duge <MoritzDuge@kolahilft.de>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2649

Aren't you missing a Fixes: for 0e3172bac3f4 too? Since that's the commit
that unmasked the bug for amdgpu, IMO that is the most important to list.

> Fixes: 6e3f17ee73f7 ("drm/fb-helper: generic: Call drm_client_add() after=
 setup is done")
> Fixes: 8ab59da26bc0 ("drm/fb-helper: Move generic fbdev emulation into se=
parate source file")
> Fixes: b79fe9abd58b ("drm/fbdev-dma: Implement fbdev emulation for GEM DM=
A helpers")
> Fixes: 63c381552f69 ("drm/armada: Implement fbdev emulation as in-kernel =
client")
> Fixes: 49953b70e7d3 ("drm/exynos: Implement fbdev emulation as in-kernel =
client")
> Fixes: 8f1aaccb04b7 ("drm/gma500: Implement client-based fbdev emulation")
> Fixes: 940b869c2f2f ("drm/msm: Implement fbdev emulation as in-kernel cli=
ent")
> Fixes: 9e69bcd88e45 ("drm/omapdrm: Implement fbdev emulation as in-kernel=
 client")
> Fixes: e317a69fe891 ("drm/radeon: Implement client-based fbdev emulation")
> Fixes: 71ec16f45ef8 ("drm/tegra: Implement fbdev emulation as in-kernel c=
lient")
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Tested-by: Moritz Duge <MoritzDuge@kolahilft.de>
> Tested-by: Torsten Krah <krah.tm@gmail.com>
> Tested-by: Paul Schyska <pschyska@gmail.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: freedreno@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: linux-tegra@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.2+

While it's true that the but was introduced by commit 6e3f17ee73f7 and that
landed in v5.2, I wonder if this patch could even be applied to such olders
Linux versions. Probably in practice it would be at most backported to
v6.2, which is the release that exposed the bug for the amdgpu driver.

Your explanation makes sense to me and the patch looks good.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

