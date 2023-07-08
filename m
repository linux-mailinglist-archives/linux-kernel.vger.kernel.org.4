Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F91D74BA73
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 02:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjGHAHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 20:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjGHAHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 20:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A73C1709
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 17:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688774810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ClNl+J5kZre4g9U4Ilh/C86VTLXimbatUVRVhRP/EmY=;
        b=K4+uD5dugJ5qlg2ymE4QggX1VqesB4TTxY4GBESrG4VuWbYEWJJHfjDKyNSqcICfWaity1
        dasYi6W/so3yMF+7ZXR7ty3purys5FECh2MiAejuXk+27sptozaDwzVyNDdsNFrdmQcZue
        r/Z+zcgYUdr1mqE5umrNFm42sTi57dg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-7MYZ4YfZMAuU1eHiLoUKBQ-1; Fri, 07 Jul 2023 20:06:49 -0400
X-MC-Unique: 7MYZ4YfZMAuU1eHiLoUKBQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b6a64c5aa5so4313311fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 17:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688774807; x=1691366807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClNl+J5kZre4g9U4Ilh/C86VTLXimbatUVRVhRP/EmY=;
        b=eFy112oOSXn3mXmtN5uG1aSQihGj7B8er1u9ECYHZLsU+421gO6ahkXmo/M9M7LIBM
         NH5z1QsgpfR2HwClk0f6+cxcGvzyYXnxskNoc+5PDuZc/xV1TZHxqQZxxm3jr+ghnFTS
         IZ2LQAY4cKabfXqhZRg1O+X7xDtKbNjukUOZWUsCLHSNh0o7G9LOh1buUtBMOMoGkrmC
         kfx2Dsk71pyYeLZLJ27gqnplLd7Cu4KGbEDKonCYXFSja8u/gV+9IYQgry8i4Zdzp6Gb
         LrsXM/Mth6hiDn8l0zukLk9XJwpvqU1MJuHAZ+wZlVqGd2xkQKEpLnrdxKx5EaZltNGM
         lirw==
X-Gm-Message-State: ABy/qLZynQ88uD8QMY1PAYQXDJcVL6TYnjLqf9RRHspY/HZEKMdgp/6D
        6StpSIPMDtCmK4bWqgQdwMMAjlxHY0FQWpucw9vA0zout7XARSmtSfZvWlbGRGmLDsPRPNgI4Qz
        ktIAJ/YF0JvbnwtiKmlz9l85KwBrnkXzmUmhnsU1b
X-Received: by 2002:a2e:a4af:0:b0:2b6:cd7f:5ea8 with SMTP id g15-20020a2ea4af000000b002b6cd7f5ea8mr3974260ljm.1.1688774807530;
        Fri, 07 Jul 2023 17:06:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFpPr6r6JoBVvnvb4DwD31nWTUtEWSpKheU8SGmCkexh44pjRQR6+zxMEjOSNetT8JZmG/XoPxNZG9/X8BANUg=
X-Received: by 2002:a2e:a4af:0:b0:2b6:cd7f:5ea8 with SMTP id
 g15-20020a2ea4af000000b002b6cd7f5ea8mr3974256ljm.1.1688774807136; Fri, 07 Jul
 2023 17:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230630160645.3984596-1-kherbst@redhat.com> <14f2b03302c07a62cce1ec272f54727b2ad39721.camel@redhat.com>
In-Reply-To: <14f2b03302c07a62cce1ec272f54727b2ad39721.camel@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Sat, 8 Jul 2023 02:06:36 +0200
Message-ID: <CACO55tv_2Oisgkm+FqQ6xz91zJ8KidwFV6hMoCxHS-JYMkiFxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/disp/g94: enable HDMI
To:     Lyude Paul <lyude@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 7, 2023 at 11:03=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrote=
:
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
>
> But seeing as I looked at this + some other patches yesterday I assume th=
ere's
> still more to this?
>

not really. All those patches are all independent and just a bunch of
fixes. I just figured this one out a bit later.

> On Fri, 2023-06-30 at 18:06 +0200, Karol Herbst wrote:
> > Cc: Ben Skeggs <bskeggs@redhat.com>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Fixes: f530bc60a30b ("drm/nouveau/disp: move HDMI config into acquire +=
 infoframe methods")
> > Signed-off-by: Karol Herbst <kherbst@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c b/drivers/g=
pu/drm/nouveau/nvkm/engine/disp/g94.c
> > index a4853c4e5ee3..67ef889a0c5f 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c
> > @@ -295,6 +295,7 @@ g94_sor =3D {
> >       .clock =3D nv50_sor_clock,
> >       .war_2 =3D g94_sor_war_2,
> >       .war_3 =3D g94_sor_war_3,
> > +     .hdmi =3D &g84_sor_hdmi,
> >       .dp =3D &g94_sor_dp,
> >  };
> >
>
> --
> Cheers,
>  Lyude Paul (she/her)
>  Software Engineer at Red Hat
>

