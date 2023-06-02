Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A775272003D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbjFBLSe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Jun 2023 07:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbjFBLSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:18:30 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0121A1B9;
        Fri,  2 Jun 2023 04:18:15 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ba8cd61ee2dso4799658276.1;
        Fri, 02 Jun 2023 04:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685704695; x=1688296695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55TCnNM7kMHRew3G4Jl4TYRy0f4Haiew0/tikDTeZNg=;
        b=QUfrLdFvAGwzYmoCbap1nhDGCSYytke1ndKiXgRySPehbNi0hgnyQQR2CPr7AKeurm
         fuelDWEh6jNgdD1SbWJUT+VbxS1Q2/XEhsadC7sp3aujSvxtHDW5lcm/s/3vkygnpWhl
         43A5rQVCMfuXBYNHPPqoXys5KGN7YsHehRXutO+sI/FJiK6I/VJ9kCND4laKowv7pXko
         cASjaGLcd9sV4kP6mHx/N+Z0UTEFIis+FtI9asH5NR1d3ndSQP+RJ4CFtxl427mKjYgA
         6miDMlkGwRgN7TNJejn0/lmDgJNSgoyZ/qZ69OLmBl3jRlA+5yWRMJPEJwPtLdQFZKiX
         iCDA==
X-Gm-Message-State: AC+VfDwtaeWC9oIyG4myUjM5VlQpN9f9FzhN1No89Zm8MJDIUATj85Bi
        VeUntkpOjtk9CB0+gb8rFLByLNPjfzboqDzv
X-Google-Smtp-Source: ACHHUZ5WDEDLyze0p2DKzK94QluEN0m78XsgT8PdUjwD4yVHgBuwa/3hvekURaEK3p0XCi4S2blrlg==
X-Received: by 2002:a81:4f15:0:b0:561:94a9:f9f7 with SMTP id d21-20020a814f15000000b0056194a9f9f7mr5542787ywb.20.1685704694917;
        Fri, 02 Jun 2023 04:18:14 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id h187-20020a0dc5c4000000b0055aafcef659sm387316ywd.5.2023.06.02.04.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 04:18:13 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-568928af8f5so30320507b3.1;
        Fri, 02 Jun 2023 04:18:12 -0700 (PDT)
X-Received: by 2002:a81:4f15:0:b0:561:94a9:f9f7 with SMTP id
 d21-20020a814f15000000b0056194a9f9f7mr5542636ywb.20.1685704692143; Fri, 02
 Jun 2023 04:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685696114.git.geert+renesas@glider.be> <14e091fc522aa63a3e33bda1016e5fa946d47d18.1685696114.git.geert+renesas@glider.be>
 <20230602110459.GC26944@pendragon.ideasonboard.com>
In-Reply-To: <20230602110459.GC26944@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 2 Jun 2023 13:17:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXR79TTSAcKb=DA2mRVDgaxBERts5PQLMf+mXpZDQJu=Q@mail.gmail.com>
Message-ID: <CAMuHMdXR79TTSAcKb=DA2mRVDgaxBERts5PQLMf+mXpZDQJu=Q@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Fri, Jun 2, 2023 at 1:05 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Fri, Jun 02, 2023 at 11:11:35AM +0200, Geert Uytterhoeven wrote:
> > The transitional helpers were removed a long time ago, but some
> > references stuck.  Remove them.
> >
> > Fixes: 21ebe615c16994f3 ("drm: Remove transitional helpers")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/gpu/drm/drm_plane_helper.c
> > +++ b/drivers/gpu/drm/drm_plane_helper.c
> > @@ -51,14 +51,6 @@
> >   * planes, and newly merged drivers must not rely upon these transitional
> >   * helpers.
> >   *
>
> The first paragraph starts with "This helper library has two parts.". As
> you're dropping the mention of the second part, I think you should
> rework the first paragraph too.

That was my initial thought, too.
However, the code still has a second part, not related to the topic of
the first part (primary plane support).

>
> > - * The second part also implements transitional helpers which allow drivers to
> > - * gradually switch to the atomic helper infrastructure for plane updates. Once
> > - * that switch is complete drivers shouldn't use these any longer, instead using
> > - * the proper legacy implementations for update and disable plane hooks provided
> > - * by the atomic helpers.
> > - *
> > - * Again drivers are strongly urged to switch to the new interfaces.
> > - *
> >   * The plane helpers share the function table structures with other helpers,
> >   * specifically also the atomic helpers. See &struct drm_plane_helper_funcs for
> >   * the details.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
