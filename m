Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F90603067
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiJRP7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiJRP7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:59:24 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0531FB9D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:59:21 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1370acb6588so17301276fac.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZN69xuQm2c6PKH22c+9Q2bjVWUVl8bcz7rztLXwnaI=;
        b=oqhBCJCQNN0gNeu67PqXuDHNskdCnZHhJDplOmiEOXGQ1bfOrWsAhz3untjgRIkWGM
         yqCnYJQE3HjDVMxniL9hyPnV8fEbVvIqAV/b/m91zbZBGBStet2452A+P4cuiQEyq4ve
         bbq4r8BxCJ+Goak8YrJJPRnsObvkYx+Ynhex53/2ouiui+TJWbPL8E35bsjxWmueqPhh
         tTLELYlAwl5V6SLXrnAUS0jXkoDGV5TUMzBaLZEZFeTMHO8YX1CvOoqEIMGRCqMlmX3N
         sVd90AAQ7kRIDv5rgI7HFUjZYBSyiFzg7Tywq5yfEES4F2pNwXXWAx85A4+jNXfECMXk
         KKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ZN69xuQm2c6PKH22c+9Q2bjVWUVl8bcz7rztLXwnaI=;
        b=GU6xxtJrQRye4l/a/15ezM7NOhhm0JwfoVTnYV7j+NZRp9kqCpVFr/Vo653J+b//Ga
         dTEDY9a7Zd9fMJttgNzqOnP0ACEiyypr9auMsdkdlNSYTmlv6tC4dCKOtbecolD8d4Nc
         qhFjNgw2h0oBINrTeFHLSVc3ruP+uQtP0ck8UkdGn4wCqORPW7mSgjRQIN0zU1qpa+RA
         ULPH1o4roY4CINAEGWnJtwsX6bo99X7h7ItNJS+bH65+LyJSPXmDZLv612Fq9PGq8UN4
         iEfai7ie3jPxXIBq9PehPjpqVJPUtsnsCY1uqVYb9k49RfunFvJINWre0Yc0BzVXAJwj
         6iuA==
X-Gm-Message-State: ACrzQf0l5Myk9P0lP1Fi3tbgB614ZdA2pHatuhdX/4JvmxPdFFtPKdPA
        zQL/hqvkmoigKTtqavQaQ0BZamjBDb3XRdfErDw=
X-Google-Smtp-Source: AMsMyM5oYHBWpOm3cQNeoGaH9Crfv+3DU6wqAoUt7+7GNbkl38+RHKBcvGqXlPFtc/c7DvCP1gY1VJKqGFe49u8A+f8=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr2076264oao.96.1666108761134; Tue, 18
 Oct 2022 08:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221018005357.887009-1-rafaelmendsr@gmail.com> <DM6PR12MB261914D4B306F738E6CA9B27E4289@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB261914D4B306F738E6CA9B27E4289@DM6PR12MB2619.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 18 Oct 2022 11:59:09 -0400
Message-ID: <CADnq5_PjcAHt=sDqes81F=j5j0p4o3tZEyPYk_2MgQku2XBBWg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay/psm: Fix memory leak in power state init
To:     "Quan, Evan" <Evan.Quan@amd.com>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Oct 17, 2022 at 9:07 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Reviewed-by: Evan Quan <evan.quan@amd.com>
>
> > -----Original Message-----
> > From: Rafael Mendonca <rafaelmendsr@gmail.com>
> > Sent: Tuesday, October 18, 2022 8:54 AM
> > To: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
> > Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>
> > Cc: Rafael Mendonca <rafaelmendsr@gmail.com>; amd-
> > gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
> > kernel@vger.kernel.org
> > Subject: [PATCH] drm/amdgpu/powerplay/psm: Fix memory leak in power
> > state init
> >
> > Commit 902bc65de0b3 ("drm/amdgpu/powerplay/psm: return an error in
> > power state init") made the power state init function return early in case of
> > failure to get an entry from the powerplay table, but it missed to clean up the
> > allocated memory for the current power state before returning.
> >
> > Fixes: 902bc65de0b3 ("drm/amdgpu/powerplay/psm: return an error in
> > power state init")
> > Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> > b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> > index 67d7da0b6fed..1d829402cd2e 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pp_psm.c
> > @@ -75,8 +75,10 @@ int psm_init_power_state_table(struct pp_hwmgr
> > *hwmgr)
> >       for (i = 0; i < table_entries; i++) {
> >               result = hwmgr->hwmgr_func->get_pp_table_entry(hwmgr,
> > i, state);
> >               if (result) {
> > +                     kfree(hwmgr->current_ps);
> >                       kfree(hwmgr->request_ps);
> >                       kfree(hwmgr->ps);
> > +                     hwmgr->current_ps = NULL;
> >                       hwmgr->request_ps = NULL;
> >                       hwmgr->ps = NULL;
> >                       return -EINVAL;
> > --
> > 2.34.1
