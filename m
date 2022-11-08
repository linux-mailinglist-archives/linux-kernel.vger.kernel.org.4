Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C15E6212BE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiKHNmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbiKHNmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:42:17 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F054FF8A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 05:42:16 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id z6so8643327qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 05:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbRh/ro3AF7kveHByL39OkW+4w9BfWleF28OTQj/Mw0=;
        b=bng3mk3jYBDPQwLqyqEvjde3EKQRyfbGkm/qGihCRLHXMxprART83jNODqi2HzVEuL
         zOtnCK3TI2F29GAOKKAIg6lE1L854XqT09BrwHxrfXCnH2EmAphy4z0HHILGi5Sgj0Ft
         7yXJ4/acXey0dmhUGKgRpKw/WnS2VOPm8S9YNzA82aRZxTNCeWMQCK+Z+IYR+uZBMntZ
         JtKo3+lv9zsbc5P6POpnGw8zry5NdwYQs6aV1zRahSIXQK6xmZrJmQ5dU8p/83kY23Nh
         a2NWrzSA5yRPcxZM/WErKt8mnPhDNP8IOkoMeap7KTQ6xo/S8JwaHa8afZTnvxPTzL6Z
         A5gA==
X-Gm-Message-State: ACrzQf1L5z840BOvY3IXzrdpNOQXOGNQYq6SEOcYUYnpx5qZprIE3RCl
        O8aRGtEP9o4PyG9uiCqQs9BrnzQTKr6nGVPE
X-Google-Smtp-Source: AMsMyM6tBzmFGlC0Lzie5A1mA3deG/CZVlLzd4JSpr856y0/ALQZxY/2ZAGIHjFLB1Sj1GQePgSPAg==
X-Received: by 2002:a05:622a:d4:b0:39c:c755:45bd with SMTP id p20-20020a05622a00d400b0039cc75545bdmr42882691qtw.112.1667914935032;
        Tue, 08 Nov 2022 05:42:15 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id f39-20020a05622a1a2700b003a586888a20sm5240324qtb.79.2022.11.08.05.42.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 05:42:13 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-368edbc2c18so133587267b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 05:42:12 -0800 (PST)
X-Received: by 2002:a0d:e301:0:b0:374:a8ba:99b0 with SMTP id
 m1-20020a0de301000000b00374a8ba99b0mr7181781ywe.358.1667914932477; Tue, 08
 Nov 2022 05:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v7-0-7072a478c6b3@cerno.tech> <CAEFVmOKCTc_ZrFyCxiSwCmhtjJj_fzr6n99cWtb9aECFzzYVXg@mail.gmail.com>
In-Reply-To: <CAEFVmOKCTc_ZrFyCxiSwCmhtjJj_fzr6n99cWtb9aECFzzYVXg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Nov 2022 14:42:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXDK6-wDjpx27KJd4_gwoXQWcP6qctN-zvG6OrUgYtGAA@mail.gmail.com>
Message-ID: <CAMuHMdXDK6-wDjpx27KJd4_gwoXQWcP6qctN-zvG6OrUgYtGAA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v7 00/23] drm: Analog TV Improvements
To:     Lukas Satin <luke.satin@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Emma Anholt <emma@anholt.net>,
        Karol Herbst <kherbst@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Dom Cobley <dom@raspberrypi.com>,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Phil Elwell <phil@raspberrypi.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On Tue, Nov 8, 2022 at 2:20 PM Lukas Satin <luke.satin@gmail.com> wrote:
> One can switch from NTSC to PAL now using (on vc4)
>
> modetest -M vc4  -s 53:720x480i -w 53:'TV mode':1 # NTSC
> modetest -M vc4  -s 53:720x576i -w 53:'TV mode':4 # PAL
>
> NTSC should be 640x480i, not 720. It will probably work on most TV's, but NTSC by the spec is 640x480i.

The above are actually the digital ("DVD Video") variants, which have 720
horizontal pixels (incl. overscan).
The analog variants do not have a fixed horizontal resolution, except
for bandwidth limitations.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
