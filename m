Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F7872010F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbjFBMAP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Jun 2023 08:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbjFBL7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:59:54 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACAD1B5;
        Fri,  2 Jun 2023 04:59:42 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5559e296433so1472132eaf.0;
        Fri, 02 Jun 2023 04:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685707182; x=1688299182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fxB1hQZUap5NVzPtf/N8icy9UCTybKAh05Yo1w+lsU=;
        b=asSmP+IaIo1UDZSX3CAlWRULxdT68ha/0ULHIze17BQbeAmFBaskyseDy7ep1ra0ZQ
         DCdx25cdrC55W6pm/Zoa5pW5qEmsbPotT6FuHgMBQJHPLS1wh36yvrz8wSohXlLLV0d0
         02+ZprsmxN9EWMfFydchaS/yRotxUPRcK29azMFV2DMBih0YFK0nWMTt6yr3Qb+xlZk1
         R2R3yPF97ihLGjlGTp5XunvSPNH+3KGqQ2GxGiW9uhmG8vpOpkgalKGCnjGl2EjbUqi/
         5yOoBcqMo/O0mrzn84X0RI+qf5OrCeFMZErypOvT7uTq9985S567/pMGlkMTviZ4vZM5
         LXFw==
X-Gm-Message-State: AC+VfDyuIIXz4gIqMDz/RfahRZtnp6FZaM/E26sY6lqnEOE5m9UL0207
        +1YZqAkveVksuN5KJLwqlPaMNgMX++JUC+9o
X-Google-Smtp-Source: ACHHUZ5dxlyk0Sg89uojHjJqI0Rp9E95bb0ifdSHRNP2BAEboQ369S4LOOXqcoxQcdGOVTLzkPYA9A==
X-Received: by 2002:a81:9190:0:b0:569:6bb5:d43b with SMTP id i138-20020a819190000000b005696bb5d43bmr66728ywg.26.1685706579567;
        Fri, 02 Jun 2023 04:49:39 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id k126-20020a816f84000000b00565cf40238csm376038ywc.110.2023.06.02.04.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 04:49:37 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-561b7729a12so49025987b3.1;
        Fri, 02 Jun 2023 04:49:36 -0700 (PDT)
X-Received: by 2002:a25:e613:0:b0:ba8:b425:6bf2 with SMTP id
 d19-20020a25e613000000b00ba8b4256bf2mr3528914ybh.20.1685706576471; Fri, 02
 Jun 2023 04:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685696114.git.geert+renesas@glider.be> <14e091fc522aa63a3e33bda1016e5fa946d47d18.1685696114.git.geert+renesas@glider.be>
 <20230602110459.GC26944@pendragon.ideasonboard.com> <CAMuHMdXR79TTSAcKb=DA2mRVDgaxBERts5PQLMf+mXpZDQJu=Q@mail.gmail.com>
 <20230602113640.GG26944@pendragon.ideasonboard.com>
In-Reply-To: <20230602113640.GG26944@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 2 Jun 2023 13:49:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWWbMW1cspwr0G_NLV5LVHnjaUbqfusUH8-yuqPobCUUA@mail.gmail.com>
Message-ID: <CAMuHMdWWbMW1cspwr0G_NLV5LVHnjaUbqfusUH8-yuqPobCUUA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm: Remove references to removed transitional helpers
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Fri, Jun 2, 2023 at 1:36 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Fri, Jun 02, 2023 at 01:17:58PM +0200, Geert Uytterhoeven wrote:
> > On Fri, Jun 2, 2023 at 1:05 PM Laurent Pinchart wrote:
> > > On Fri, Jun 02, 2023 at 11:11:35AM +0200, Geert Uytterhoeven wrote:
> > > > The transitional helpers were removed a long time ago, but some
> > > > references stuck.  Remove them.
> > > >
> > > > Fixes: 21ebe615c16994f3 ("drm: Remove transitional helpers")
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > > > --- a/drivers/gpu/drm/drm_plane_helper.c
> > > > +++ b/drivers/gpu/drm/drm_plane_helper.c
> > > > @@ -51,14 +51,6 @@
> > > >   * planes, and newly merged drivers must not rely upon these transitional
> > > >   * helpers.
> > > >   *
> > >
> > > The first paragraph starts with "This helper library has two parts.". As
> > > you're dropping the mention of the second part, I think you should
> > > rework the first paragraph too.
> >
> > That was my initial thought, too.
> > However, the code still has a second part, not related to the topic of
> > the first part (primary plane support).
>
> How about mentioning that in the comment then ?

Any suggestion about the wording?
The drm novice in me would write "The second part is not about
primary plane support" ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
