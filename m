Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF14637349
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKXIDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKXIDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:03:13 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7307088F85;
        Thu, 24 Nov 2022 00:03:07 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id x18so573904qki.4;
        Thu, 24 Nov 2022 00:03:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxhodYFDmdQqVB4ltzcytu+P4hXGUv/V9/mCUnkpmmg=;
        b=TjQExKhIg+vBdXYkhLv4WSk8cKOUj0L6okTupVgp3IkDeqkqTxbAUMEd0mjbGEKszS
         mNSeNrMoSd1qDuiudOFyIfB3p+CpIYUmc9fC0t7mI3BN4b0KzaY0x9Z/X3bvQ1anYO5F
         cSdwnmA5EmJCKVbMcwpCeoEzLyvU7tBJkDZDyBul6vc5SFaK4//X/TUsrTS/vkvewzrT
         /lj1Fa4mW0abRE7BJk/PUCTzbcgff9SunnFM2Jh5IadCaSHOJjvrraQ5STIEh4kSUVcl
         Po8YiKX4oQUmR2+m+tsUGzbu63t4vCkfwz8g0j7po+sclam6sHj8SEDK01ng/UTGJOzO
         habA==
X-Gm-Message-State: ANoB5pkL/IJTMgtChoKWEfrV0tB3DeIgcQBvP5+G/jdKek9pA1G/N3Nf
        vfRxkPG8DF+6GUliwmWhiribdu74dig73g==
X-Google-Smtp-Source: AA0mqf4miuwas6rsAAzI7UyaaKeNZC287sV3PQ6zEM7xecF0LIbC4/38+q9mSLIdsQOsunR7r0753g==
X-Received: by 2002:a37:b986:0:b0:6fa:3244:cf6e with SMTP id j128-20020a37b986000000b006fa3244cf6emr11425612qkf.656.1669276986320;
        Thu, 24 Nov 2022 00:03:06 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id i13-20020a05620a248d00b006fbdeecad51sm474190qkn.48.2022.11.24.00.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 00:03:05 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-3b56782b3f6so8002357b3.13;
        Thu, 24 Nov 2022 00:03:05 -0800 (PST)
X-Received: by 2002:a81:f80f:0:b0:38e:e541:d8ca with SMTP id
 z15-20020a81f80f000000b0038ee541d8camr29389264ywm.283.1669276985156; Thu, 24
 Nov 2022 00:03:05 -0800 (PST)
MIME-Version: 1.0
References: <3ee1f8144feb96c28742b22384189f1f83bcfc1a.1669221671.git.geert@linux-m68k.org>
 <Y35RCaEP0icg6San@phenom.ffwll.local> <CAMuHMdVgqwHjm8Hxms04rg6YXiQacEwKiaRV80nNA_OM9mvZpA@mail.gmail.com>
 <20221124065148.7v4m3qli2k74mic6@sirius.home.kraxel.org>
In-Reply-To: <20221124065148.7v4m3qli2k74mic6@sirius.home.kraxel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Nov 2022 09:02:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUJUUPPxS6VCHV1X9XMqzfACvu8qivUVO2pMbvD7rcQKg@mail.gmail.com>
Message-ID: <CAMuHMdUJUUPPxS6VCHV1X9XMqzfACvu8qivUVO2pMbvD7rcQKg@mail.gmail.com>
Subject: Re: [PATCH resend v2] drm/fourcc: Add missing big-endian XRGB1555 and
 RGB565 formats
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

On Thu, Nov 24, 2022 at 8:29 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > > +#ifdef __BIG_ENDIAN
> > >
> > > Why do we need the #ifdef here? Iirc some hw has big endian flags in the
> > > scanout registers, so could supprt this unconditionally if there's no
> > > #ifdef around the format defines. Some drivers might then also want a
> > > DRM_FORMAT_FOO_BE define to simplify tables and stuff, but that's more a
> > > bikeshed.
> >
> >  "Limit this to big-endian platforms, as there is currently no need
> >  to support these formats on little-endian platforms."
> >
> > Will anyone make use of this? In theory, all of the 16-bpp formats
> > can have a big-endian counterpart.
>
> Highly unlikely.  Dealing with 16-bpp formats in non-native byte order
> is a PITA because it isn't enough to simply adjust the masks and shifts
> to pick the correct bits and be done with it.
>
> The qemu stdvga happens to have a register to switch framebuffer
> byteorder (so both x64 and ppc are happy), and the bochs drm driver
> actually supports that no matter what the cpu byte order is, but it
> supports only DRM_FORMAT_XRGB8888 + DRM_FORMAT_BGRX8888.
>
> Supporting 16 bpp in the driver wouldn't be that much of a problem, but
> processing the framebuffer on the host side when emulating a big endian
> guest on a little endian host is painful.  I think I can't ask pixman to
> do a conversation from DRM_FORMAT_RGB565 | DRM_FORMAT_BIG_ENDIAN to
> DRM_FORMAT_XRGB8888 on a little endian machine.

Indeed. But you can do a quick 16-bit byteswap, and convert from
DRM_FORMAT_RGB565 to DRM_FORMAT_XRGB8888?

There's a similar issue with Cairo, cfr. '[PATCH libdrm v2 08/10]
util: Fix pwetty on big-endian"[1].

BTW, does pixman support converting DRM_FORMAT_RGB565 to
DRM_FORMAT_XRGB8888 on a big-endian machine?

[1] https://lore.kernel.org/all/e8597038478f12e9eda5e86b309b52988f69f2eb.1657302103.git.geert@linux-m68k.org

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
