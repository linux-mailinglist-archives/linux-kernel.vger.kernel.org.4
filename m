Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9143D6E0DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 14:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjDMM6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 08:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjDMM6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 08:58:45 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BFA422F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:58:44 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1842f69fe1fso17608369fac.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 05:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681390723; x=1683982723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXjaBjti/iUKdry4pNZBLkaqpq0jQFzIVSNb+LjTSOQ=;
        b=GoxhB8EAWQLdu/H8D47oCGd/cfMPV2dy4XSBNDggUf5GV2RkgV107+ijoGDiV8RWD2
         7OzTimBVJWeMzkRFKh2OH7uSc5N87ODop70VIkkxcSeeMyb9S11wjdQdk1g+crnDytj+
         RwZ6adC+ZcMp2dMa/WQpTGY1Jn8+iwi30NQx2uZ9qC1G1UzNGlfhu5jq1sZNjg5jEGh1
         6yhDJnDms8pLt5wdhKvGXeZIYvj1bjDCYqjp6f2rPNrIeCA2ghNd4zRcaHXSDRfWMswJ
         13HHrdSLTJh3VeyZxN1sNrbTEFSZHizpoeqGhYyJYh3wgM11JL/DwuLkvmEkeSnaj+Tj
         GWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681390723; x=1683982723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXjaBjti/iUKdry4pNZBLkaqpq0jQFzIVSNb+LjTSOQ=;
        b=eVbIA89W0XnDGk6pvhQnWM8da3/Y93eR876XkvJTSan6zqNxvaHTc8LAmy5FvXakQR
         ybKu6MwZTHTd8m3QWBB3JRr79/w/vpe486p2JI2LI2YkzV0Z8nGzxXujssSBObR5A6Gu
         bsn3CmPv/xzdEf832ynP4rGMDk4zix3pVew1j3ugCkzQE8guTAiuL1lmmkbK2JMuNZjt
         OakmwdLHN0gfcnPh2fsQM5tbmwcjQOcpy6FO9RZ/4drp9mcWIYetNqafo83nefGkeBWy
         NR9Sj5glKhpwOw2djcRQGKh6rqmzJOYinY2NoifSHOBnEUNZukv/Y4DOgK6Rkaak1xZ5
         tUBg==
X-Gm-Message-State: AAQBX9fsHbFrDzIJIKlzf22UIgRZORQr6TQ7yy59q4YP3y4Bp7QdRzcY
        vmGz8RltgRGB0JBjA4scEDKg0iyfQyf+oKoIaTE=
X-Google-Smtp-Source: AKy350Z1y9dM8iDVgqISOzZ8l/mDEHlY3dZL7T9/F8xpHHg9PmiemxUsmXcY7nQjhZqbl+/yA+iAn6qjSqRrUiZSI2Y=
X-Received: by 2002:a05:6870:390d:b0:184:2e38:c7af with SMTP id
 b13-20020a056870390d00b001842e38c7afmr1270788oap.3.1681390723671; Thu, 13 Apr
 2023 05:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230413111254.22458-1-jlayton@kernel.org> <87edooarpq.fsf@intel.com>
In-Reply-To: <87edooarpq.fsf@intel.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 13 Apr 2023 08:58:32 -0400
Message-ID: <CADnq5_PVnYMSiKO77+cfg_V-tDKYkVJYN3qGNb1vhQO3QtXskA@mail.gmail.com>
Subject: Re: [PATCH] drm: make drm_dp_add_payload_part2 gracefully handle NULL
 state pointer
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Wayne Lin <Wayne.Lin@amd.com>
Cc:     Jeff Layton <jlayton@kernel.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Wayne

On Thu, Apr 13, 2023 at 8:31=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Thu, 13 Apr 2023, Jeff Layton <jlayton@kernel.org> wrote:
> > I've been experiencing some intermittent crashes down in the display
> > driver code. The symptoms are ususally a line like this in dmesg:
> >
> >     amdgpu 0000:30:00.0: [drm] Failed to create MST payload for port 00=
0000006d3a3885: -5
> >
> > ...followed by an Oops due to a NULL pointer dereference.
> >
> > The real bug is probably in the caller of this function, which is
> > passing it a NULL state pointer, but this patch at least keeps my
> > machine from oopsing when this occurs.
>
> My fear is that papering over this makes the root cause harder to find.
>
> Cc: Harry, Alex
>
>
> BR,
> Jani.
>
>
> >
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2184855
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  drivers/gpu/drm/display/drm_dp_mst_topology.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gp=
u/drm/display/drm_dp_mst_topology.c
> > index 38dab76ae69e..87ad406c50f9 100644
> > --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> > @@ -3404,7 +3404,8 @@ int drm_dp_add_payload_part2(struct drm_dp_mst_to=
pology_mgr *mgr,
> >
> >       /* Skip failed payloads */
> >       if (payload->vc_start_slot =3D=3D -1) {
> > -             drm_dbg_kms(state->dev, "Part 1 of payload creation for %=
s failed, skipping part 2\n",
> > +             drm_dbg_kms(state ? state->dev : NULL,
> > +                         "Part 1 of payload creation for %s failed, sk=
ipping part 2\n",
> >                           payload->port->connector->name);
> >               return -EIO;
> >       }
>
> --
> Jani Nikula, Intel Open Source Graphics Center
