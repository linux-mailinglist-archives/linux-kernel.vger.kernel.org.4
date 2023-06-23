Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9237C73BE26
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjFWRzk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjFWRzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:55:38 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579332133;
        Fri, 23 Jun 2023 10:55:37 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-57012b2973eso8340457b3.2;
        Fri, 23 Jun 2023 10:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687542936; x=1690134936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFXAla+djoi2aCew92bu3sbYORcetmmfg6s1u4vqHgw=;
        b=PNE2n+t6MLUXVBprmn+obqUzyx0W+Foapp0JhQICtKXbMWM5jzVgrdW2KL87fw1Cbk
         /Yi/p2jIYO6tdFtWE9QOkR3utxToEr3yKLKY4C2ty4bH46dpCNxIyCF1BPCM7Kpd0th0
         Wb8IGlsHaMedYCCRJaVgqMjdtrWS+xW8iX+9FFhZCHhiANESwR4WHkZrffAllDO8dwri
         AkC/fGJSqe3fdrtUgdjAcP4f8dmy7K6MRa0o1/EL+PQHXl8tMMJoQrmzStoytIksZqoO
         zdshgjtTRz0/SXwQQoVe7TIMiljRDtMkkCFi6KFJ26C9H3R2oLgIKFO7RXu+8shzYty0
         SmlA==
X-Gm-Message-State: AC+VfDwwYzMwBMdsEa08/2ygwmcj6Xs7E+tDZoPWNIJ2w6ls2k8itY1Z
        JCdSISVxBZM5vTj9ExEBfMJkNFAfc0sIAA==
X-Google-Smtp-Source: ACHHUZ4aMXMvXpqYJAvOZoQGv7naNfa7ATWYqGLzSDzIfQKigwIXcQpgtQcQz8ni1Hxbpp/3QeYN+w==
X-Received: by 2002:a81:8316:0:b0:56c:fbb4:7d46 with SMTP id t22-20020a818316000000b0056cfbb47d46mr26260526ywf.28.1687542936135;
        Fri, 23 Jun 2023 10:55:36 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id o17-20020a0dcc11000000b005702597583fsm2555646ywd.26.2023.06.23.10.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 10:55:35 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-bc40d4145feso744144276.1;
        Fri, 23 Jun 2023 10:55:34 -0700 (PDT)
X-Received: by 2002:a05:6902:18b:b0:bc6:c22f:581a with SMTP id
 t11-20020a056902018b00b00bc6c22f581amr17144067ybh.38.1687542933934; Fri, 23
 Jun 2023 10:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687423204.git.geert+renesas@glider.be> <95c2af42a89c65ca603126e56c0423407dfc873f.1687423204.git.geert+renesas@glider.be>
 <20230623165038.GB2112@pendragon.ideasonboard.com>
In-Reply-To: <20230623165038.GB2112@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Jun 2023 19:55:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWsDHMn4P1g_EYKzXyisUOnhJ0Q1Nd5Wq9H_CwPvaSaWw@mail.gmail.com>
Message-ID: <CAMuHMdWsDHMn4P1g_EYKzXyisUOnhJ0Q1Nd5Wq9H_CwPvaSaWw@mail.gmail.com>
Subject: Re: [PATCH 24/39] drm: renesas: shmobile: Unify plane allocation
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Fri, Jun 23, 2023 at 6:50 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thu, Jun 22, 2023 at 11:21:36AM +0200, Geert Uytterhoeven wrote:
> > Unify primary and overlay plane allocation:
> >   - Enhance shmob_drm_plane_create() so it can be used to create the
> >     primary plane, too,
> >   - Move overlay plane creation next to primary plane creation.
> >
> > As overlay plane index zero now means the primary plane, this requires
> > shifting all overlay plane indices by one.
>
> Do you use index zero to identify the primary plane just for
> shmob_drm_plane_create(), or somewhere else too ? If it's just to create
> the plane, you could instead pass the plane type to the function.

Index zero is just used for the creation.
I guess this sort of goes together with my question below...

> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Perhaps it would be better to not use dynamic allocation, but store
> > "struct drm_plane primary" and "struct shmob_drm_plane planes[5]" in
> > struct drm_shmob_device instead, like is done for the crtc and encoder?

... as embedding separate primary and planes[] would also get rid of
the need to adjust the plane indices when converting from logical to physical
overlay plane indices.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
