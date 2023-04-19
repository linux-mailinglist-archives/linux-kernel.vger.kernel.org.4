Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A933F6E7B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjDSNtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjDSNtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:49:21 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E19469A;
        Wed, 19 Apr 2023 06:49:20 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-187df75c901so692612fac.1;
        Wed, 19 Apr 2023 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681912160; x=1684504160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ym31HW14DbhCOWHrnpXKAPN5kGz7nsQnyeLEhvgz9o8=;
        b=g6DUqsbuqHCbSnGehf924bmMmY5pk8Jf320EWXg+W/jXCTmRx9mO2tW0hXviPMnP/v
         n0jaFKOt1zAjyYScjefGItuXl3SpqypDwKjPys8cAemLMLZpQwWKuV5awwimcpx4xAtT
         xl83lQBtTvOAwJiZkIFzI8KCJ003nRW1JHU316/6AFEGSwbuaibWiB4gh6b9d+7F1u3V
         GCGN2MuPwgpU2ywXp0cqvC2bBdq7j+8yuPbgHQhudUfSJg4FPAwZwFCzOL6XiR0snabn
         gAgK5coRUH2r7NecaHDAXzGS5sOcIoOl25ti9vny7GH/T5ocwf6oXtq1CtTQz9TYsfHC
         vx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681912160; x=1684504160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ym31HW14DbhCOWHrnpXKAPN5kGz7nsQnyeLEhvgz9o8=;
        b=B91IoyKmgdKFoAdC5kQjStNcM9shifXUx6xj/Z9A4jWyOj2+kJHrppBwozpoJBf2Er
         XfKt95nr9USSmszBXu0d3vONDWKJC5JjbZXYkTnoEII0FQ22XayIG8ZthObExqvwVBtj
         5dF7sx2CYAc3qCxMSuLSj4poJXrRH6qudOaORkiSxLdH/9nz1zFJm4QQ1RSzYsxhkoM1
         Mc5shyEcu7AO6GBN2ed8qgCMjnCqqW8/PmXiCdJ6Z2woSUqz8gN6GmwjEHjtNuDqh6fV
         LK5D7ZNCtVjm4LwInaWN1UGSNiK8G8QMpVPG64fwYdeK2HzRNMrVcdk9xu4H/AHCuGC/
         5B3A==
X-Gm-Message-State: AAQBX9fiDJSQGnF6xnL69MAdOwf7HeEs2f0WeQ/V8YJLDfMM/Crwzegm
        VlcXo8lY4aw2uJixYYgqn5G6kSFSaCaE43Z+Lw4=
X-Google-Smtp-Source: AKy350b110hiRRnRO2oyRNWOm123YhKy0RQQnjnzlfFFQSuvDWkapRzEnWNE+yypdLSgtPsQ+wPMtI+zb8uc8w41WC4=
X-Received: by 2002:a05:6870:c229:b0:187:e563:77b9 with SMTP id
 z41-20020a056870c22900b00187e56377b9mr3674088oae.45.1681912159993; Wed, 19
 Apr 2023 06:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230419122058.3420-1-hackyzh002@gmail.com> <62ae58cb-9fec-37ca-fd40-12bf0c1c5ba3@amd.com>
In-Reply-To: <62ae58cb-9fec-37ca-fd40-12bf0c1c5ba3@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 19 Apr 2023 09:49:08 -0400
Message-ID: <CADnq5_MTgMtHM87YQJcZLcENevcHOuQihoTz-xRetypJ6BQSXQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] drm/radeon: Fix integer overflow in radeon_cs_parser_init
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     hackyzh002 <hackyzh002@gmail.com>, alexander.deucher@amd.com,
        Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        dri-devel@lists.freedesktop.org, sumit.semwal@linaro.org,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Apr 19, 2023 at 8:24=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 19.04.23 um 14:20 schrieb hackyzh002:
> > The type of size is unsigned, if size is 0x40000000, there will be an
> > integer overflow, size will be zero after size *=3D sizeof(uint32_t),
> > will cause uninitialized memory to be referenced later
> >
> > Signed-off-by: hackyzh002 <hackyzh002@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com> for the seri=
es.
>
> > ---
> >   drivers/gpu/drm/radeon/radeon_cs.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_cs.c b/drivers/gpu/drm/radeo=
n/radeon_cs.c
> > index 46a27ebf4..a6700d727 100644
> > --- a/drivers/gpu/drm/radeon/radeon_cs.c
> > +++ b/drivers/gpu/drm/radeon/radeon_cs.c
> > @@ -270,7 +270,8 @@ int radeon_cs_parser_init(struct radeon_cs_parser *=
p, void *data)
> >   {
> >       struct drm_radeon_cs *cs =3D data;
> >       uint64_t *chunk_array_ptr;
> > -     unsigned size, i;
> > +     u64 size;
> > +     unsigned i;
> >       u32 ring =3D RADEON_CS_RING_GFX;
> >       s32 priority =3D 0;
> >
>
