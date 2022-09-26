Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6521E5EA658
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 14:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbiIZMlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 08:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbiIZMkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 08:40:31 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B117310CA5B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:17:18 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id m65so6190144vsc.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Lmh1Xq7Cw51uqBYTm5xf2C78YKt/PjveAkuJS0FQxk4=;
        b=rU+6F/tQrx7PVNGzy/Upg5lqNKd6bFtTWrnTC7Vpf2gzUvB1UUsg5oNq9J10bC7WQd
         n3VmuPRyYOQakMClzUJ7NcXes74t0JvoacyODnJzV+jH94uwLGSSMnNyLyuD9NC4x/nC
         lGxBLgS8P8q3qA2qlR0QWiu8P/BCi24GwKT6qGWN2Moi59LPkXGKuiv+uSm6BZA/H7RP
         uYoFzGcQ5rCCG6kBkhIiHmQ5GqEUuCASUwS0Qz+TtZmLHH/zzV7oc5dSZPmBPGmRD/Ib
         E0sNgmMs7noVi7JC3ZA2X4dikMX25Iw2f+jnO97JbhH6+hD//xe85hJye+6pbU3TGWyh
         klZA==
X-Gm-Message-State: ACrzQf36GIrLwY5fY9FnyyZDT0eiqoCO+h22zvHK/3VjwX/hhNwStAf4
        dKB+NXNEgzpnVVtdCxfnq7f0R7oqaNJ43g==
X-Google-Smtp-Source: AMsMyM5J/Lr42lWHpzXW2+YWzCVN/o0YAcD5twu5BMmsFwmKemAt4f8QABryol2yovhE7gzWE7Ubyw==
X-Received: by 2002:a05:6214:2589:b0:4af:7db6:2a4e with SMTP id fq9-20020a056214258900b004af7db62a4emr401315qvb.116.1664188769054;
        Mon, 26 Sep 2022 03:39:29 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id az35-20020a05620a172300b0069fe1dfbeffsm11608771qkb.92.2022.09.26.03.39.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 03:39:28 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 65so304318ybp.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:39:28 -0700 (PDT)
X-Received: by 2002:a81:758a:0:b0:345:450b:6668 with SMTP id
 q132-20020a81758a000000b00345450b6668mr19133647ywc.316.1664188452440; Mon, 26
 Sep 2022 03:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v2-0-f733a0ed9f90@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-10-f733a0ed9f90@cerno.tech>
 <72a8c3ce-ed03-0a77-fb92-eaa992eb86fe@suse.de> <20220926101716.urehomr2lzv5pqln@houat>
In-Reply-To: <20220926101716.urehomr2lzv5pqln@houat>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Sep 2022 12:34:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXonxXiw4x2PvnQ=xedOQO1y=K0O8g1+ixeSvXmzcOOVw@mail.gmail.com>
Message-ID: <CAMuHMdXonxXiw4x2PvnQ=xedOQO1y=K0O8g1+ixeSvXmzcOOVw@mail.gmail.com>
Subject: Re: [PATCH v2 10/33] drm/modes: Add a function to generate analog
 display modes
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Emma Anholt <emma@anholt.net>,
        Karol Herbst <kherbst@redhat.com>,
        Samuel Holland <samuel@sholland.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Hans de Goede <hdegoede@redhat.com>,
        nouveau@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Dom Cobley <dom@raspberrypi.com>, linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mon, Sep 26, 2022 at 12:17 PM Maxime Ripard <maxime@cerno.tech> wrote:
> On Fri, Sep 23, 2022 at 11:05:48AM +0200, Thomas Zimmermann wrote:
> > > +   /* 63.556us * 13.5MHz = 858 pixels */
> >
> > I kind of get what the comment wants to tell me, but the units don't add up.
>
> I'm not sure how it doesn't add up?
>
> We have a frequency in Hz (equivalent to s^-1) and a duration in s, so
> the result ends up with no dimension, which is to be expected for a
> number of periods?

To make the units add up, it should be 13.5 Mpixel/s
(which is what a pixel clock of 13.5 MHz really means ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
