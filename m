Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285B162E318
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbiKQRcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbiKQRcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:32:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8F579E37
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:32:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AF06621DC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69177C433D7;
        Thu, 17 Nov 2022 17:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668706324;
        bh=wdsxeJqew66mU+bgRH2fg2ZV2N2f5g2SvnnRTjBr7ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kAVXC/XpqlxDpWMpNpo9ILQWbCN/M74xUL/zj15/ZTtTTYyYsPXSFmwcp+WgWdEAN
         eQq4sp0ULPi42RwV469PAdnEtLg+soIWqyrgyJnNRCuovQMR8I4Je8eGPb1W11O9rK
         bRCZ6+mfkLeyYqHZJSmn8UGg5gnoB5JxSV9lPinr4Ize/dH2YvBE8I8ih9QNZQiIAa
         Ekn51XTl7SYtEP1+YoWefddLzzZ5wKijwP8a00OURiWcN1kILP5FPNzGYoa9oqWh8p
         IVKL/dSVv2paopySfEFGmzuTRgnycPpCYo9gljEt9EDJDfiSpkHP50qLRyhnIs+Glm
         slRWSj/kCi+MQ==
Date:   Thu, 17 Nov 2022 10:32:01 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        mripard@kernel.org, emma@anholt.net, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] drm/vc4: hdmi: Fix pointer dereference before
 check
Message-ID: <Y3ZwEc4x/wIsroTI@dev-arch.thelio-3990X>
References: <20221110134752.238820-1-jose.exposito89@gmail.com>
 <20221110134752.238820-3-jose.exposito89@gmail.com>
 <20221117172849.hk7bgahjbvycml5v@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117172849.hk7bgahjbvycml5v@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 09:28:49AM -0800, Nick Desaulniers wrote:
> On Thu, Nov 10, 2022 at 02:47:52PM +0100, José Expósito wrote:
> > Commit 6bed2ea3cb38 ("drm/vc4: hdmi: Reset link on hotplug") introduced
> > the vc4_hdmi_reset_link() function. This function dereferences the
> > "connector" pointer before checking whether it is NULL or not.
> > 
> > Rework variable assignment to avoid this issue.
> > 
> > Fixes: 6bed2ea3cb38 ("drm/vc4: hdmi: Reset link on hotplug")
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > ---
> >  drivers/gpu/drm/vc4/vc4_hdmi.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > index a49f88e5d2b9..6b223a5fcf6f 100644
> > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > @@ -318,8 +318,8 @@ static int reset_pipe(struct drm_crtc *crtc,
> >  static int vc4_hdmi_reset_link(struct drm_connector *connector,
> >  			       struct drm_modeset_acquire_ctx *ctx)
> >  {
> > -	struct drm_device *drm = connector->dev;
> > -	struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
> > +	struct drm_device *drm;
> > +	struct vc4_hdmi *vc4_hdmi;
> 
> Hi, I think this change, or another in this area recently, is causing
> the following warning. PTAL
> 
> drivers/gpu/drm/vc4/vc4_hdmi.c:351:14: warning: variable 'vc4_hdmi' is uninitialized when used here [-Wuninitialized]
>         mutex_lock(&vc4_hdmi->mutex);
>                     ^~~~~~~~
> drivers/gpu/drm/vc4/vc4_hdmi.c:322:27: note: initialize the variable 'vc4_hdmi' to silence this warning
>         struct vc4_hdmi *vc4_hdmi;
>                                  ^
>                                   = NULL

Guess we just crossed paths but this is just a problem with -next due to
a bad conflict resolution on Stephen's part:

https://lore.kernel.org/Y3ZvffZiR+SgtY6h@dev-arch.thelio-3990X/

> >  	struct drm_connector_state *conn_state;
> >  	struct drm_crtc_state *crtc_state;
> >  	struct drm_crtc *crtc;
> > @@ -330,6 +330,7 @@ static int vc4_hdmi_reset_link(struct drm_connector *connector,
> >  	if (!connector)
> >  		return 0;
> >  
> > +	drm = connector->dev;
> >  	ret = drm_modeset_lock(&drm->mode_config.connection_mutex, ctx);
> >  	if (ret)
> >  		return ret;
> > @@ -347,6 +348,7 @@ static int vc4_hdmi_reset_link(struct drm_connector *connector,
> >  	if (!crtc_state->active)
> >  		return 0;
> >  
> > +	vc4_hdmi = connector_to_vc4_hdmi(connector);

This version of the patch is fine, as there is no mutex_lock() call
here.

> >  	if (!vc4_hdmi_supports_scrambling(vc4_hdmi))
> >  		return 0;
> >  
> > -- 
> > 2.25.1
> > 
> > 
> 

Cheers,
Nathan
