Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2691D73C272
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjFWVSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjFWVSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:18:21 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D23435BE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 14:17:34 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-560b56b638eso814933eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 14:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687555000; x=1690147000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQjsSh8xdWQ7cPSJtrniG176fZtuSK++L5k+xgsmZik=;
        b=ESpvJyVDoB79drIjOoAJ7jJmROWECWJhuY5F5jyzXynNOhh11WpPYLogcylvclyOJ7
         8V3Ahhb1JbiMsfuGm4wi8DnoRbsrMF+JujJB4pAl4Vp3mKrus4tCH4p1qpfXXBILGOLg
         UKRO4DguHNL9cYyvRCefJVd86PI7PDDAFP7eCnFL/bh6OWp3N/ymtdkFn9/ujPX6hRlY
         8gsOKZJT2C+WKBQm8AnGJWkPBJd1tv99Gazdjj6HH1CuEBWA8rn/ens7O21TFtiOT+Xt
         w7sUVCB/Gr1ni0xYvw1YHdhlI+aGyrQCidT0fvtsMeXluncZONwucVTjGToyS2FZLH1+
         l93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687555000; x=1690147000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQjsSh8xdWQ7cPSJtrniG176fZtuSK++L5k+xgsmZik=;
        b=IuVlCzHt697N5A9cIHBcMRMCaCyHuGgdHHSMg8sSu3Cq0rU6QOSDg1YhC+47Z3r6Mm
         0K/LFLc3klrVWoE9DpvFwWcL86NObSyq3oOhm9vJq1+kgykTQSA3yfdQpxQ/AHorHMd7
         2qPBd8JTUaUopF+l2Zi1FLOC6tS6FuulDBR5rvHQ/fJYF6hMMhZGeiv2i3/wv3JZttke
         HU/y8us3Ci9QdLE4iPfV3Ul4WJuW1uWPmTZWSAemYKA3K+SO3xCbNCAjVGgf3vHyzg3y
         2EScn8yBUlQR57iyoDn1QG8+aG9ovDzZsDr78qWoTIItWc/i0fYJjk1U59LPFWOeJNSJ
         bqPQ==
X-Gm-Message-State: AC+VfDxeYgxQI96bTybPfdfCCZLUkTEk99I/ASVd3c8MmagKMHMH1mVS
        Pe03Yey5Pl8iPeeZYsr5WHnVDaz4tePVcwWXMCE=
X-Google-Smtp-Source: ACHHUZ6M+mrqYMfIbhI/K065uI8kB0wZnxk/Y3/Ahj8C7M5Dpjc3wCkpsuKvLxkPy8+BBPcAo/JugzNTgGVqabTNcXo=
X-Received: by 2002:a4a:b6c2:0:b0:560:cb1c:1534 with SMTP id
 w2-20020a4ab6c2000000b00560cb1c1534mr3630658ooo.2.1687554999957; Fri, 23 Jun
 2023 14:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twXadK-V1qttzJV3ks8hZu7jY3Nswzw6EgGADnJZF2+fA@mail.gmail.com>
In-Reply-To: <CAPM=9twXadK-V1qttzJV3ks8hZu7jY3Nswzw6EgGADnJZF2+fA@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 23 Jun 2023 17:16:29 -0400
Message-ID: <CADnq5_NmQdzpmuG+UtQTW3+MLp6em+M7dCQ2ZiAv0_HvM6cU9g@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.4 final
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 2:49=E2=80=AFAM Dave Airlie <airlied@gmail.com> wro=
te:
>
> Hey Linus,
>
> very quiet last week, just two misc fixes, one dp-mst and one qaic.
>
> Should be all ready for the merge window next week.

Was out of the office this week and didn't get to -fixes until today.
Will send the PR to everyone now.

Alex


>
> Dave.
>
> drm-fixes-2023-06-23:
> drm fixes for 6.4 final
>
> qaic:
> - dma-buf import fix
>
> dp-mst:
> - fix NULL ptr deref
> The following changes since commit 45a3e24f65e90a047bef86f927ebdc4c710eda=
a1:
>
>   Linux 6.4-rc7 (2023-06-18 14:06:27 -0700)
>
> are available in the Git repository at:
>
>   git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-06-23
>
> for you to fetch changes up to 9bd9be5cbaf8a8faa175ef4fba04a5623281debe:
>
>   Merge tag 'drm-misc-fixes-2023-06-21' of
> git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2023-06-23
> 12:16:48 +1000)
>
> ----------------------------------------------------------------
> drm fixes for 6.4 final
>
> qaic:
> - dma-buf import fix
>
> dp-mst:
> - fix NULL ptr deref
>
> ----------------------------------------------------------------
> Dave Airlie (1):
>       Merge tag 'drm-misc-fixes-2023-06-21' of
> git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
>
> Jeff Layton (1):
>       drm: use mgr->dev in drm_dbg_kms in drm_dp_add_payload_part2
>
> Pranjal Ramajor Asha Kanojiya (1):
>       accel/qaic: Call DRM helper function to destroy prime GEM
>
>  drivers/accel/qaic/qaic_data.c                | 4 ++--
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
