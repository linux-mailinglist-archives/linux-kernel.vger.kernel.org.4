Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6456BF53F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjCQWhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjCQWhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:37:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F30F2ED7D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:37:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id k2so6801399pll.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679092629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89IA/glQL/mkyqO2PtOcIR/GMtVguXs5H6651qpjFr0=;
        b=a1hvKnRAcL6yeuxTTNNTdRe7zdPmjHQ9SdZB/1BksmzpLtTOR1r1yhe3+r/9oaHFnE
         MIm2Pgue8VbxaKLfbM6rDX8FZ95tDrQLvjRUW0SOmLymdK9pT4JNKjmu6HixoWc2MrsD
         9O+hAPZMUhc0SfKXqRJJsTCQPFKygqXLJy+gMXd5g3d80TADykEbYrqjDyk/kmmb13SP
         /qeAR0HUU5N99HlxsZv/EqXxsjdDNFKmM8hB/220auBhrX70kV3CC3KHeCtIP1TQXkXb
         814r/FPmCKyQEwX9aXqSlw9C8FIWkFY+eB5SeKvslv0hOOdKdl6PUacjoIpJK3ap1aFq
         XypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679092629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89IA/glQL/mkyqO2PtOcIR/GMtVguXs5H6651qpjFr0=;
        b=QCDnDJ+xMW74Nvymw2hkiKhaq1LGxZnou2XGf0opPO51bHIYZt6sfXAljZonAfSuA9
         qgRXvrxDwZGQKgU2wFJQTsAxy3VI2jsvNnuYvFmnEAdegVsv/GP3OtW9FHp3GCVIYHb0
         hWWpWQfUKITz3cAtBHP3Fgj3SMYnxd/aJCsoZwvG8BOsOOTnJet5oXu3lJU1r38hyrK0
         NdyUqO+63491k4TR5wNR3yIijs8L87ndLXmtxoAZUVAlJOw7VwHKwtzrqYufmknYCoqA
         NNf2QJkBDA8vv5CYpqfq0CL00YWjFPwTozR/7KV+tWz7xYs1eoXMiD3wGY0b0Mvw6gWQ
         ZIhg==
X-Gm-Message-State: AO0yUKVAFXeKymoZDjclcF/3MXxDsX3ucGFf6lGg9ynxceKM+R/M4wgX
        XH8h220XOlpvMwb4uhVkhCk0yP/T1aQKST1Cv45c0Q==
X-Google-Smtp-Source: AK7set9IsIdsAd8E54XvrIjzRVaTAgLrmWV0OeXdr7iRmMsfE4vL74blGLtVGjasOT+mden5hg28q8MJ8UdSBSjITA0=
X-Received: by 2002:a17:902:f686:b0:1a0:535b:22d9 with SMTP id
 l6-20020a170902f68600b001a0535b22d9mr3922083plg.10.1679092628811; Fri, 17 Mar
 2023 15:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230310063910.2474472-1-saravanak@google.com> <4737cacc741c939ca1d980a4858d0748faad11f8.camel@puri.sm>
In-Reply-To: <4737cacc741c939ca1d980a4858d0748faad11f8.camel@puri.sm>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 17 Mar 2023 15:36:32 -0700
Message-ID: <CAGETcx_0NaSTFFn34nvax2_pG+_5BJtOD0j0wrqU0NSCqwfKWA@mail.gmail.com>
Subject: Re: [PATCH v1] drm/mipi-dsi: Set the fwnode for mipi_dsi_device
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <treding@nvidia.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        kernel-team@android.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 7:45=E2=80=AFAM Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
>
> Am Donnerstag, dem 09.03.2023 um 22:39 -0800 schrieb Saravana Kannan:
> > After commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
> > detection more robust"), fw_devlink prints an error when consumer
> > devices don't have their fwnode set. This used to be ignored
> > silently.
> >
> > Set the fwnode mipi_dsi_device so fw_devlink can find them and
> > properly
> > track their dependencies.
> >
> > This fixes errors like this:
> > [    0.334054] nwl-dsi 30a00000.mipi-dsi: Failed to create device
> > link with regulator-lcd-1v8
> > [    0.346964] nwl-dsi 30a00000.mipi-dsi: Failed to create device
> > link with backlight-dsi
> >
> > Reported-by: Martin Kepplinger <martin.kepplinger@puri.sm>
>
> Reported-and-tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Maintainers,

Nudge nudge. Will this be picked up for 6.3-rcX?

-Saravana

>
> thanks,
>                          martin
>
> > Link:
> > https://lore.kernel.org/lkml/2a8e407f4f18c9350f8629a2b5fa18673355b2ae.c=
amel@puri.sm/
> > Fixes: 068a00233969 ("drm: Add MIPI DSI bus support")
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/drm_mipi_dsi.c
> > b/drivers/gpu/drm/drm_mipi_dsi.c
> > index b41aaf2bb9f1..7923cc21b78e 100644
> > --- a/drivers/gpu/drm/drm_mipi_dsi.c
> > +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> > @@ -221,7 +221,7 @@ mipi_dsi_device_register_full(struct
> > mipi_dsi_host *host,
> >                 return dsi;
> >         }
> >
> > -       dsi->dev.of_node =3D info->node;
> > +       device_set_node(&dsi->dev, of_fwnode_handle(info->node));
> >         dsi->channel =3D info->channel;
> >         strlcpy(dsi->name, info->type, sizeof(dsi->name));
> >
>
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
