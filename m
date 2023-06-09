Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79786729A58
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240652AbjFIMsc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Jun 2023 08:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240719AbjFIMsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:48:14 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2E22136;
        Fri,  9 Jun 2023 05:48:14 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-bacbc7a2998so1668039276.3;
        Fri, 09 Jun 2023 05:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686314893; x=1688906893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUnX0UM+Igwa0fUtgyLnX5bA3wv9FfoFnuZ0mnmyxD8=;
        b=QNfBp9nfbz0AfKG00qc1JiVBqf8gMHVWNRy0eaSgvW3FiSjCm7J2ET7tgcwDP+NOXz
         v3ZPc0HMUzAVTumUMPfROmQBlCdKSYCUur6/NeRoBdhGbiDmNChwc2enJoXrwt8Bdz0K
         fIqrWitTmWdNe0gpkhpzu6tmemVvwIbg0nVtAsz+oulZgAO8dNeiledSXDBSw/HBcvdw
         +lOxjSnxbwrsxl9eX7YBW564T5bnrAgWpDb/0mEghoe01DxyUqoQ+TArYQ5czNAJJVqJ
         c5wEL8os1hRXOVTJUoW/TmiUtcVpwGuSKT6av9urD9UQ8lMD/DMAE20apVvmjDFCNCOH
         1ICQ==
X-Gm-Message-State: AC+VfDz+3pwdC/wYEgUXXMNiRFV9o4uSgJuHudZeesogVcMmyCQ8q0fE
        o1m2N5zd8ixE8HwDCg1EJFSGkavCBonYcg==
X-Google-Smtp-Source: ACHHUZ7iOVF1xsri3laKFtxHiXxBTzdHcJz92n4d/K3jiRMka4jRQy8Ck96PBiGAEaEHSisSKXkFNQ==
X-Received: by 2002:a25:8207:0:b0:bab:f4bb:9402 with SMTP id q7-20020a258207000000b00babf4bb9402mr997724ybk.46.1686314893217;
        Fri, 09 Jun 2023 05:48:13 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id ch22-20020a0569020b1600b00bac1087b44esm847720ybb.35.2023.06.09.05.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 05:48:11 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-565ee3d14c2so15657597b3.2;
        Fri, 09 Jun 2023 05:48:10 -0700 (PDT)
X-Received: by 2002:a81:8841:0:b0:569:1ff9:58d3 with SMTP id
 y62-20020a818841000000b005691ff958d3mr1254652ywf.1.1686314890673; Fri, 09 Jun
 2023 05:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685696114.git.geert+renesas@glider.be> <14e091fc522aa63a3e33bda1016e5fa946d47d18.1685696114.git.geert+renesas@glider.be>
 <20230602110459.GC26944@pendragon.ideasonboard.com> <CAMuHMdXR79TTSAcKb=DA2mRVDgaxBERts5PQLMf+mXpZDQJu=Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXR79TTSAcKb=DA2mRVDgaxBERts5PQLMf+mXpZDQJu=Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 9 Jun 2023 14:47:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWcrLme4qHnhXymJZmbYk2Bwr3sBymf5W=t8pdj_g8YXA@mail.gmail.com>
Message-ID: <CAMuHMdWcrLme4qHnhXymJZmbYk2Bwr3sBymf5W=t8pdj_g8YXA@mail.gmail.com>
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

On Fri, Jun 2, 2023 at 1:17 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, Jun 2, 2023 at 1:05 PM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > On Fri, Jun 02, 2023 at 11:11:35AM +0200, Geert Uytterhoeven wrote:
> > > The transitional helpers were removed a long time ago, but some
> > > references stuck.  Remove them.
> > >
> > > Fixes: 21ebe615c16994f3 ("drm: Remove transitional helpers")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > > --- a/drivers/gpu/drm/drm_plane_helper.c
> > > +++ b/drivers/gpu/drm/drm_plane_helper.c
> > > @@ -51,14 +51,6 @@
> > >   * planes, and newly merged drivers must not rely upon these transitional
> > >   * helpers.
> > >   *
> >
> > The first paragraph starts with "This helper library has two parts.". As
> > you're dropping the mention of the second part, I think you should
> > rework the first paragraph too.
>
> That was my initial thought, too.
> However, the code still has a second part, not related to the topic of
> the first part (primary plane support).

Upon deeper investigation, all of this is related to primary plane
support. Will update...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
