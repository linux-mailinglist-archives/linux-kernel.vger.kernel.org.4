Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA0473CF99
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 10:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjFYI6d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Jun 2023 04:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjFYI6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 04:58:31 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D863C103;
        Sun, 25 Jun 2023 01:58:30 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-576918f4cf7so12713537b3.3;
        Sun, 25 Jun 2023 01:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687683510; x=1690275510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHMiEoYUk1oN3PyFm+FVXDksw84RMCEjXqcP8Z1moHU=;
        b=fMzo8HWPLTVrQob9IGlt/HMdoun1fYg7gQbvt6MQC0hs8ftwQOlGIWpztXzqx9mx51
         fcZ9ddE48XuiHQMVGdt0N2b+fxY8tWyoB969GWxN7sxDPJi/hBLiw70kGaQftPzPfRHS
         B7bn2BYFe5VVfrj22yfk/BBb5i+4xL+c6X7M9hw79KYcFKFOGuZdzUqWhaJanHYmafZv
         gRATWVokLBVVuxptJ5loY54KCXJ6oYEai3h8EimupO0ncQCZwHBskjBHPsZmjHdOi2zb
         fsOYXK9gQ9qdNF3SNmjrLXA7YA6zA+YdEsDAco9wPojMu8McxtnADcuj6SyJcB9lCbj+
         HeRg==
X-Gm-Message-State: AC+VfDwyRaBHxD+9qlFqoxyd5P0ffI1nBACC1eqFgHa56Yc1iWQ4bwd0
        HwIgi8ZcvluUTCPqO+zfSZqyyTyq0Vwukw==
X-Google-Smtp-Source: ACHHUZ7AKkgI/ys6WIMY9XSs97ATC0YY/LdTAQmI90rIhGr/ET83p33R8hjDny7iGL3BsgQxXSvadA==
X-Received: by 2002:a0d:e293:0:b0:561:d25b:672a with SMTP id l141-20020a0de293000000b00561d25b672amr26546937ywe.21.1687683509887;
        Sun, 25 Jun 2023 01:58:29 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id e6-20020a0dc206000000b0056ffdec590csm735972ywd.41.2023.06.25.01.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 01:58:29 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso2221068276.0;
        Sun, 25 Jun 2023 01:58:29 -0700 (PDT)
X-Received: by 2002:a25:1407:0:b0:b9e:e5b:14ab with SMTP id
 7-20020a251407000000b00b9e0e5b14abmr19307303ybu.55.1687683508805; Sun, 25 Jun
 2023 01:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687423204.git.geert+renesas@glider.be> <95c2af42a89c65ca603126e56c0423407dfc873f.1687423204.git.geert+renesas@glider.be>
 <20230623165038.GB2112@pendragon.ideasonboard.com> <CAMuHMdWsDHMn4P1g_EYKzXyisUOnhJ0Q1Nd5Wq9H_CwPvaSaWw@mail.gmail.com>
 <20230623185052.GR2112@pendragon.ideasonboard.com>
In-Reply-To: <20230623185052.GR2112@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 25 Jun 2023 10:58:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWdeRODcAa26EKuvR3yca0hVqSUR6WBHEtr9+RBKyk_Ow@mail.gmail.com>
Message-ID: <CAMuHMdWdeRODcAa26EKuvR3yca0hVqSUR6WBHEtr9+RBKyk_Ow@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Fri, Jun 23, 2023 at 8:50 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Fri, Jun 23, 2023 at 07:55:22PM +0200, Geert Uytterhoeven wrote:
> > On Fri, Jun 23, 2023 at 6:50 PM Laurent Pinchart wrote:
> > > On Thu, Jun 22, 2023 at 11:21:36AM +0200, Geert Uytterhoeven wrote:
> > > > Unify primary and overlay plane allocation:
> > > >   - Enhance shmob_drm_plane_create() so it can be used to create the
> > > >     primary plane, too,
> > > >   - Move overlay plane creation next to primary plane creation.
> > > >
> > > > As overlay plane index zero now means the primary plane, this requires
> > > > shifting all overlay plane indices by one.
> > >
> > > Do you use index zero to identify the primary plane just for
> > > shmob_drm_plane_create(), or somewhere else too ? If it's just to create
> > > the plane, you could instead pass the plane type to the function.
> >
> > Index zero is just used for the creation.
> > I guess this sort of goes together with my question below...
> >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > > Perhaps it would be better to not use dynamic allocation, but store
> > > > "struct drm_plane primary" and "struct shmob_drm_plane planes[5]" in
> > > > struct drm_shmob_device instead, like is done for the crtc and encoder?
> >
> > ... as embedding separate primary and planes[] would also get rid of
> > the need to adjust the plane indices when converting from logical to physical
> > overlay plane indices.
>
> Do they need to be embedded for that, or could you simple keep the index
> as it is ?

If the plane type would be passed explicitly, they would not need to be
embedded for that.

Then the question becomes: does it make sense to unify primary and
overlay plane handling?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
