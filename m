Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEEC62FE95
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiKRULb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKRULa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:11:30 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59CB248EF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:11:28 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-142612a5454so6580634fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J3I3CkdX4BAay5C0IaiSoCWmkDjQWfYtrKIg7MfvyUY=;
        b=Q/x00Xs+INcK9wrEmPasiROezIpYZC96sD9AlGuzIT/Z3B5xav8JQrZLsf0bVIgp5+
         5Q+2qjQy3fS+GISqFZJhFMnzu47CkNAZE7m71SW9UQ17vnGUQpwiS9OKW6/MUhhtScw5
         rmQE+jvC32tw6PE3xkMOHh8unguMDvvorOw4YTLgyM14YhM+ybgTfJCq5rWOqyrj2Ap3
         0/J11dqVCnkqj+XSIJQ+DxDn4vpz+4MOBl12IFG7tH8JhO7TnWt2jfOI1cmSB1SxSAjN
         3paOxl0zP4YAjdfDjVQFzbaNMzytEaPUXeT1hSYrktGE7oTwcUpZPOnfTAvg/bpL13nL
         mF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3I3CkdX4BAay5C0IaiSoCWmkDjQWfYtrKIg7MfvyUY=;
        b=J4rCSl0tVltvm5A5El1FKVRQ6OdWeGBB3BLC8//7zCEmpSlOSOM1WCPTTCKG6K9dhn
         0TfzYPNcgoRGnhBQ48klBDRCKIb7fvie+SREjkmCoAB0yjvH/R7fWQR7S7o/UkrNmDhm
         eZuiIqYu/wEqlRuVEpIrW88zvkJoVmyPP8riPcypBNzuCepQgEZH+ghGWRFfUeKxkhqT
         lgIweLvddYL6UyzCh/gPzGCWLWz6PFaMQdD4uInnVsVdvGbISMNY6iQEy4IUsYsBd9HT
         VGa2SC9rXQHa/tqCGi877enHvpWG02BQoosF3k1J92w5eWBL5kGe+7B9K3AVeA4zadyq
         KWfw==
X-Gm-Message-State: ANoB5plL9hRGn3lnbwFxb7phKOOMUV3iQTR0yM3LSzvnM2tLtzsQ2DNu
        c+8/T0ME08vQvL9TLzJiV4moftNcfPpE1sElc5b5OFPt
X-Google-Smtp-Source: AA0mqf4HAPt5v1Yu7vw9aDVSNnvY2xhI05VAW34pXE3l0dIiWaEtvxVZJXNOHwbRMWzNZ+ydN1qTwgQIHgLOBuRB8/A=
X-Received: by 2002:a05:6870:2b05:b0:12d:58c1:33f9 with SMTP id
 ld5-20020a0568702b0500b0012d58c133f9mr8296943oab.46.1668802288282; Fri, 18
 Nov 2022 12:11:28 -0800 (PST)
MIME-Version: 1.0
References: <20221118195406.95779-1-lyude@redhat.com> <b7c8a41d-6657-2646-4f18-ed13293369b2@amd.com>
In-Reply-To: <b7c8a41d-6657-2646-4f18-ed13293369b2@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 18 Nov 2022 15:11:16 -0500
Message-ID: <CADnq5_M0zdoSe3w1A-XxLc4G_x4-a2RT6CkRfhwP_4OLdP=Uow@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/dm/mst: Fix uninitialized var in pre_compute_mst_dsc_configs_for_state()
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Lyude Paul <lyude@redhat.com>, amd-gfx@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Leo Li <sunpeng.li@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <Roman.Li@amd.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        hersen wu <hersenxs.wu@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Nov 18, 2022 at 3:03 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 11/18/22 14:54, Lyude Paul wrote:
> > Coverity noticed this one, so let's fix it.
> >
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > index 59648f5ffb59..6483ba266893 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> > @@ -1180,7 +1180,7 @@ static int pre_compute_mst_dsc_configs_for_state(struct drm_atomic_state *state,
> >       struct amdgpu_dm_connector *aconnector;
> >       struct drm_dp_mst_topology_mgr *mst_mgr;
> >       int link_vars_start_index = 0;
> > -     int ret;
> > +     int ret = 0;
> >
> >       for (i = 0; i < dc_state->stream_count; i++)
> >               computed_streams[i] = false;
>
