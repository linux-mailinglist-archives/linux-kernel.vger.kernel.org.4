Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C993A70F5B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjEXLyV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 07:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjEXLyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:54:19 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7E9130;
        Wed, 24 May 2023 04:54:18 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ba829e17aacso1332617276.0;
        Wed, 24 May 2023 04:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684929257; x=1687521257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mB+yJW9GxDPC7vWCyTgkNtqkSRQGKRDyuctXyoPIN+0=;
        b=Y2+fmgJTPEZXQE0T1YaGGIniNCWNMYLAPCZbQt11SrboYMsAH7nY9ffJuBghP33BU2
         gYtXPANKugy5Qu3B2N3JauJzBzDDDnxO2fJsKchUqYHp+//rJS28tavK7cleJfZj4ZJG
         PM6qs5twP+4RtSi1BAGWqNcgGZvEPdwZT6qQ2GfKkUTpLISOrwQFMVhaxKeMGSN+cTP8
         CEGvx9pg1dcj5L3LCx8g3m+HeQpymiU6IxJrbWAx8AhQzBim6tp2IbeGlk1M1lPrcisF
         Ibak8MvbmpYRTSiZI9yYL7DhJn8MkiPJbwjFEkqUVnnpxK6LFMLQ7DLaqjm2aOa618Pp
         Tk5g==
X-Gm-Message-State: AC+VfDxuGGTC/+jzD+e+yQnOTE408GiEbNd8W2XUdbz4AupQQs2SJFTE
        XsWwesBhinG2UGztYIcWxOvWxcix/EI6Pg==
X-Google-Smtp-Source: ACHHUZ4URujJT/VuMXlr7/M/3PHGt78GqQjWgeHLmoXaViuBJm26DxxDcg/XokClTYsXEKitekVXdw==
X-Received: by 2002:a25:f80b:0:b0:ba8:707a:7ff4 with SMTP id u11-20020a25f80b000000b00ba8707a7ff4mr1623342ybd.62.1684929256901;
        Wed, 24 May 2023 04:54:16 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id e7-20020a259247000000b00b9def138173sm2633333ybo.1.2023.05.24.04.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 04:54:16 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-561e919d355so12116427b3.0;
        Wed, 24 May 2023 04:54:15 -0700 (PDT)
X-Received: by 2002:a25:342:0:b0:ba8:5009:db33 with SMTP id
 63-20020a250342000000b00ba85009db33mr17581461ybd.59.1684929255682; Wed, 24
 May 2023 04:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684854992.git.geert+renesas@glider.be> <d800a238-83e0-0ec2-cf3a-67d07d749b5b@suse.de>
In-Reply-To: <d800a238-83e0-0ec2-cf3a-67d07d749b5b@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 May 2023 13:54:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXPJ02UWuH1v_ZaoWmbHALu0Qe2K27nhuvwKBmjno+YMw@mail.gmail.com>
Message-ID: <CAMuHMdXPJ02UWuH1v_ZaoWmbHALu0Qe2K27nhuvwKBmjno+YMw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] drm: shmobile: Fixes and enhancements
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
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

Hi Thomas,

On Wed, May 24, 2023 at 1:42 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 23.05.23 um 17:31 schrieb Geert Uytterhoeven:
> > Currently, there are two drivers for the LCD controller on Renesas
> > SuperH-based and ARM-based SH-Mobile and R-Mobile SoCs:
> >    1. sh_mobile_lcdcfb, using the fbdev framework,
> >    2. shmob_drm, using the DRM framework.
> > However, only the former driver can be used, as all platform support
> > integrates the former.  None of these drivers support DT-based systems.
> >
> > This patch series is a first step to enable the SH-Mobile DRM driver for
> > Renesas ARM-based SH-Mobile and R-Mobile SoCs.  The next steps planned are
> > to (1) add DT support (works, but needs a hack due to lack of (2)), and (2)
> > convert the driver to atomic modesetting.
> >
> > Changes compared to v2[1]:
> >    - Add Reviewed-by.
> >
> > Changes compared to v1[2]:
> >    - Add Reviewed-by,
> >    - Drop dependency on ARM.
> >
> > This has been tested on the R-Mobile A1-based Atmark Techno
> > Armadillo-800-EVA development board, using a temporary
> > platform-enablement patch[3].
> >
> > Thanks for applying to drm-misc!
>
> It's all been reviewed. Do you want me to merge the patchset?

That would be great! Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
