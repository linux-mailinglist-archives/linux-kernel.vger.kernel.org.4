Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F4A67EEB8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjA0TqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjA0Toj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:44:39 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805582129E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:20 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id n2so4004302pfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/oF44rT15tnjTMjQqM9aBjASabRej4gnAjmMBpVIsHQ=;
        b=av1vpqTXDSdm9xZW/Pg/m0TrwGFvEz3WN0oSIPaCtlst7AUmhhMvzYihzOQ3jpxqEK
         HrDRzoWFLwx63eVyZyD+Dmu4KB8bgEP7vuGqBPqTd0ggMBMz0OCaE7TPLICA+PlL0OaW
         fuHtg+LAkdqb5FNHESN/k20N8PGx4fxm5NKkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oF44rT15tnjTMjQqM9aBjASabRej4gnAjmMBpVIsHQ=;
        b=DOtYIrzCAjpUKxqMts+2+IAP9L650S5EGxN6V7To83kDJWB+bnivSz+5i/DCOChy02
         rwPlntsv6Hh/qiVMYN87u1pKPXAwn1YfyM+F8gj/XvnnuGRiMTScgcAEEJOc2P4rKZ5a
         yy7cE2QCMNbPmqt2oUbAO/Bi7PukS4A9oeGbJJJkbsWEObBdFwTydiuAGpDudi4n1cE7
         S0RMbph+URGhIdh4c3YDQE6pflBt5iHRPQos8O+SQYgycJdgYU+f6QjltccVKsqnBACn
         qTVMHLYrwehN9veyC9gbnzPxvJ3TSKqJ7TpR07nzXzLopbUEniTyj36bAp1HnWBXiYQp
         6lng==
X-Gm-Message-State: AO0yUKVkb6z8HmFZBIy5v4ONch1aQskJJFlpV8wWA5obUWx6JswnwMEA
        adXT9H/BR5wRRIE+FANjFuux+g==
X-Google-Smtp-Source: AK7set+Z9W6Rrw9FWwFFm8G6j0bcNgI/h1gaBfNaPxU5jp1YhAt6lKHsciXU4RrC0pla1N+iDmml2A==
X-Received: by 2002:a05:6a00:2484:b0:592:514f:636d with SMTP id c4-20020a056a00248400b00592514f636dmr7324690pfv.22.1674848544849;
        Fri, 27 Jan 2023 11:42:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i19-20020aa796f3000000b0058dbd7a5e0esm3002526pfq.89.2023.01.27.11.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:42:24 -0800 (PST)
Date:   Fri, 27 Jan 2023 11:42:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau/disp: Fix nvif_outp_acquire_dp() argument
 size
Message-ID: <202301271141.6741F43@keescook>
References: <20221127183036.never.139-kees@kernel.org>
 <202301251214.8E52414D0@keescook>
 <9c53c624604b7415ceeedf7222e78abc2c64430f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c53c624604b7415ceeedf7222e78abc2c64430f.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 04:24:19PM -0500, Lyude Paul wrote:
> Sorry! I've been pretty busy until now, this is:
> 
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> 
> Let me know if you've pushed it already or if you want me to push it to drm-
> misc

Either way is fine. I'm currently carrying it, but I can easily drop it
if you prefer it go via drm-misc.

Thanks!

-Kees

> 
> On Wed, 2023-01-25 at 12:15 -0800, Kees Cook wrote:
> > Ping. I'll take this via my tree unless someone else wants to take it...
> > 
> > On Sun, Nov 27, 2022 at 10:30:41AM -0800, Kees Cook wrote:
> > > Both Coverity and GCC with -Wstringop-overflow noticed that
> > > nvif_outp_acquire_dp() accidentally defined its second argument with 1
> > > additional element:
> > > 
> > > drivers/gpu/drm/nouveau/dispnv50/disp.c: In function 'nv50_pior_atomic_enable':
> > > drivers/gpu/drm/nouveau/dispnv50/disp.c:1813:17: error: 'nvif_outp_acquire_dp' accessing 16 bytes in a region of size 15 [-Werror=stringop-overflow=]
> > >  1813 |                 nvif_outp_acquire_dp(&nv_encoder->outp, nv_encoder->dp.dpcd, 0, 0, false, false);
> > >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/gpu/drm/nouveau/dispnv50/disp.c:1813:17: note: referencing argument 2 of type 'u8[16]' {aka 'unsigned char[16]'}
> > > drivers/gpu/drm/nouveau/include/nvif/outp.h:24:5: note: in a call to function 'nvif_outp_acquire_dp'
> > >    24 | int nvif_outp_acquire_dp(struct nvif_outp *, u8 dpcd[16],
> > >       |     ^~~~~~~~~~~~~~~~~~~~
> > > 
> > > Avoid these warnings by defining the argument size using the matching
> > > define (DP_RECEIVER_CAP_SIZE, 15) instead of having it be a literal
> > > (and incorrect) value (16).
> > > 
> > > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > > Addresses-Coverity-ID: 1527269 ("Memory - corruptions")
> > > Addresses-Coverity-ID: 1527268 ("Memory - corruptions")
> > > Link: https://lore.kernel.org/lkml/202211100848.FFBA2432@keescook/
> > > Link: https://lore.kernel.org/lkml/202211100848.F4C2819BB@keescook/
> > > Fixes: 813443721331 ("drm/nouveau/disp: move DP link config into acquire")
> > > Cc: Ben Skeggs <bskeggs@redhat.com>
> > > Cc: Karol Herbst <kherbst@redhat.com>
> > > Cc: Lyude Paul <lyude@redhat.com>
> > > Cc: David Airlie <airlied@gmail.com>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: Dave Airlie <airlied@redhat.com>
> > > Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: nouveau@lists.freedesktop.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  drivers/gpu/drm/nouveau/include/nvif/outp.h | 3 ++-
> > >  drivers/gpu/drm/nouveau/nvif/outp.c         | 2 +-
> > >  2 files changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/nouveau/include/nvif/outp.h b/drivers/gpu/drm/nouveau/include/nvif/outp.h
> > > index 45daadec3c0c..fa76a7b5e4b3 100644
> > > --- a/drivers/gpu/drm/nouveau/include/nvif/outp.h
> > > +++ b/drivers/gpu/drm/nouveau/include/nvif/outp.h
> > > @@ -3,6 +3,7 @@
> > >  #define __NVIF_OUTP_H__
> > >  #include <nvif/object.h>
> > >  #include <nvif/if0012.h>
> > > +#include <drm/display/drm_dp.h>
> > >  struct nvif_disp;
> > >  
> > >  struct nvif_outp {
> > > @@ -21,7 +22,7 @@ int nvif_outp_acquire_rgb_crt(struct nvif_outp *);
> > >  int nvif_outp_acquire_tmds(struct nvif_outp *, int head,
> > >  			   bool hdmi, u8 max_ac_packet, u8 rekey, u8 scdc, bool hda);
> > >  int nvif_outp_acquire_lvds(struct nvif_outp *, bool dual, bool bpc8);
> > > -int nvif_outp_acquire_dp(struct nvif_outp *, u8 dpcd[16],
> > > +int nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[DP_RECEIVER_CAP_SIZE],
> > >  			 int link_nr, int link_bw, bool hda, bool mst);
> > >  void nvif_outp_release(struct nvif_outp *);
> > >  int nvif_outp_infoframe(struct nvif_outp *, u8 type, struct nvif_outp_infoframe_v0 *, u32 size);
> > > diff --git a/drivers/gpu/drm/nouveau/nvif/outp.c b/drivers/gpu/drm/nouveau/nvif/outp.c
> > > index 7da39f1eae9f..c24bc5eae3ec 100644
> > > --- a/drivers/gpu/drm/nouveau/nvif/outp.c
> > > +++ b/drivers/gpu/drm/nouveau/nvif/outp.c
> > > @@ -127,7 +127,7 @@ nvif_outp_acquire(struct nvif_outp *outp, u8 proto, struct nvif_outp_acquire_v0
> > >  }
> > >  
> > >  int
> > > -nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[16],
> > > +nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[DP_RECEIVER_CAP_SIZE],
> > >  		     int link_nr, int link_bw, bool hda, bool mst)
> > >  {
> > >  	struct nvif_outp_acquire_v0 args;
> > > -- 
> > > 2.34.1
> > > 
> > 
> 
> -- 
> Cheers,
>  Lyude Paul (she/her)
>  Software Engineer at Red Hat
> 

-- 
Kees Cook
