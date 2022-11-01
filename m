Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B456147D6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiKAKm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKAKm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:42:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F36A192AD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 03:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667299286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5u9PasPjTt25CsZMfj48skRk6lEO/1rAkid6YQ6vA1c=;
        b=BPogAM6xcbQVZ0BMTp5+G2/VYDbTZ3yTKIvyMkAkBKJf+ZvLc9bfILGKyVVhFcviO420mj
        8XYouv+RDA6O9iAzzCgxNXHU+Hsz+T8XvkgfDAXn/KfW36Z+V4ZY24Re3ZOnFCNIUo5ugi
        jlPBUAMzpkz3RCE7v41CywD9fa3yriw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-665-z46dB8J2Paik5qsJSTBtKA-1; Tue, 01 Nov 2022 06:41:25 -0400
X-MC-Unique: z46dB8J2Paik5qsJSTBtKA-1
Received: by mail-qv1-f72.google.com with SMTP id x2-20020a0cff22000000b004bb07bf7557so7362724qvt.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 03:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5u9PasPjTt25CsZMfj48skRk6lEO/1rAkid6YQ6vA1c=;
        b=1w8ZToKH77TRMpUiHGCwmsbqNC1AXKFhaqiC5TOtNcYPLnMo/X9NKC/svtzYG/0rlD
         M7XP1Vs7lWy1Td/Dp3t+ZUj/BBLCs/UXOVO50TOmduxHL9UKydEbFDFy+h+KrqofTNW4
         X3Atf/6M+xC3almRr0p8td3C684w/qdBfOFdMv6cbb44RNJOm/kVEdsTHvsRFdAGK7rJ
         aveiJvGaik2VTOD/PtDSV+ysXB28XdmCgb0kfSytLlScttO4hAnflzC7fwBBNzfRXOja
         2QO1RSaXl+BAogyA8gNaunfYkg0/g/D2hm4cNG0R4lLItCJyqpvNDtilDHhZXa8WSzu2
         EtSg==
X-Gm-Message-State: ACrzQf2IupNaq7PQxB4oytjlNIxUtNFPH/3p6QD+44smsWemBUUI+oxo
        CZr+yAJd/QdvuzRcji8yOHMBijLA2T9YfdyuCw7sl7ajgenYRBLKdZ4tja9GhVP9caHgFFPB81/
        xtCHLz/RN4zFXD623aH7lcv2GndpkKEQeK1ywJr7S
X-Received: by 2002:a05:622a:178c:b0:39a:90ba:fc53 with SMTP id s12-20020a05622a178c00b0039a90bafc53mr14552074qtk.673.1667299285007;
        Tue, 01 Nov 2022 03:41:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM62iAR+fRGZ/RVubHnk2QR9SONHRM8kee9zOi71zcmsh5EAkF8xAyzqTgseid1agxZWpooGIOHc8TBu0ODXOEE=
X-Received: by 2002:a05:622a:178c:b0:39a:90ba:fc53 with SMTP id
 s12-20020a05622a178c00b0039a90bafc53mr14552068qtk.673.1667299284830; Tue, 01
 Nov 2022 03:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221029184851.25340-1-antoniospg100@gmail.com>
 <20221031163211.13228-1-antoniospg100@gmail.com> <5a61ae6a-8a16-8abb-e718-895c41e2e7a8@gmail.com>
In-Reply-To: <5a61ae6a-8a16-8abb-e718-895c41e2e7a8@gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 1 Nov 2022 11:41:13 +0100
Message-ID: <CACO55tuXRU1X7tU3AvOLW3WZnGWYWBa7MTszqFPrwjeNS-TYfA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: Add support to control backlight using
 bl_power for nva3.
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     antoniospg <antoniospg100@gmail.com>, linux-kernel@vger.kernel.org,
        sam@ravnborg.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 3:12 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 10/31/22 23:32, antoniospg wrote:
> > Summary:
> >
> > * Add support to turn on/off backlight when changing values in bl_power
> >   file. This is achieved by using function backlight_get_brightness()
> >   in nva3_set_intensity to get current brightness.
> >
>
> This is [PATCH v2], right? If so, next time please pass -v <version
> number> to git-format-patch(1).
>
> Also, just say the prose without using bullet list. "Summary:" line
> is also redundant. And again, please describe why this change be made.
>

it's right there in the title....

> > Test plan:
> >
> > * Turn off:
> > echo 1 > /sys/class/backlight/nv_backlight/bl_power
> >
> > * Turn on:
> > echo 0 > /sys/class/backlight/nv_backlight/bl_power
> >
>
> Shouldn't "test plan" above be documented in Documentation/ instead?
>

Given that's already existing infrastructure and is actually
documented already (the existence of `bl_power` I mean), why would
that be needed? I don't think it's needed to point that out in the
commit log, but if the contributor chooses to document how the patch
was tested, then why not?

> Last but not least, is "antoniospg" your real, legal name?
>

Please leave those discussions to subsystem maintainers.

Saying that, if the contributors prefers to go by this name, this is
good enough for me, but having a more explicit or detailed name (like
fore- and surname) is generally prefered.

> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara
>

