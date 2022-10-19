Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327F06039BE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 08:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiJSGZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 02:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiJSGZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 02:25:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3975C9DA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:25:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so16095140pjl.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0YvuV0EJzgx/CzKHyzjlvPWkSLLbFliwl9A6z1/O4hM=;
        b=Z7PHOUxVbmdPt6GSMk5/jEhKoitcqAZUH6zUw3AIgXq9hVqibAj5b9PWxv3q2sp+tV
         ZpN8E/OYeZgwVo0fPvdwjebOeM7XnFsqB9znTtGuv5N2MyM5/NH03ktlIs7MVks2/8/u
         YvU7qaxh5xUkyLtOSQv+vX++vSPJiRWYx9JtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YvuV0EJzgx/CzKHyzjlvPWkSLLbFliwl9A6z1/O4hM=;
        b=bcaByj/8CaOkAfTeEo8H0+bTNKWZQaT2FH/JBvEiQEWXAGltVBdHkPlua7QGtyKYOB
         EcDjYhj3E4jDohrdlb/Y732GsDAW4WTxMrkRCXNK+fYqbtW5N9H1pOEBs5Uz6IycjAsh
         JaG7IPRsaHkUpH0mh1QulHWzFBCZFmOJHt8V1Mh+ps2RIdh3bppCaNkqT/nC13u+Qfb5
         303CDvwBhJbUrzo0UqCuYAvnPpqD4qL4AzTfCA9l4YCgY1tdt8fD6wzfaIfWEy+0Radu
         3uNCXJ/KVDKvgHLZ4I2Mt7q+FJTb/F9+sLVwTuqgrPp3e6AbrlCG8GB9DgruaFfruAOk
         Vizw==
X-Gm-Message-State: ACrzQf3IXguBBCHOFKQlhXbBFPqkDzF+0mXfAjT2VQqZ09VhWdh5UrJc
        sKpKHQATnUhIQSmRq3fCovwpQbhPngCBhAGzY6A9mw==
X-Google-Smtp-Source: AMsMyM66bYdplNyAXUIbc8nQgt/ursH7ZfCQxsQJMwBPV3sgOhHoXsgNF5pcCI5Xpcet9Zb7lIUBkLeWZYoRPoO/lTo=
X-Received: by 2002:a17:90b:4f4a:b0:20c:64e2:2bf1 with SMTP id
 pj10-20020a17090b4f4a00b0020c64e22bf1mr8263564pjb.30.1666160745922; Tue, 18
 Oct 2022 23:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221012042030.573466-1-hsinyi@chromium.org> <CAJMQK-i1GFP_5NsH7MLYS17xacrYZf1u6bjVYBkW-qHMbuh2_w@mail.gmail.com>
 <CAOw6vbLPUkwoaSHyWARZnkcsacf9rsmB6M=97z1-98kgM7BNEQ@mail.gmail.com>
In-Reply-To: <CAOw6vbLPUkwoaSHyWARZnkcsacf9rsmB6M=97z1-98kgM7BNEQ@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 19 Oct 2022 14:25:19 +0800
Message-ID: <CAJMQK-joM-bZvYydDKAYs7o6KBd+74mZrNBHWybdibWXv3okLg@mail.gmail.com>
Subject: Re: [PATCH v2] drm_bridge: register content protect property
To:     Sean Paul <seanpaul@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 2:26 AM Sean Paul <seanpaul@chromium.org> wrote:
>
> On Mon, Oct 17, 2022 at 9:49 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > On Wed, Oct 12, 2022 at 12:20 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > >
> > > Some bridges are able to update HDCP status from userspace request if
> > > they support HDCP.
> > >
> > > HDCP property is the same as other connector properties that need to be
> > > created after the connecter is initialized and before the connector is
> > > registered.
> > >
> > anx7625 is a user for this.
>
> I feel like we should not unconditionally attach this property for
> bridges, this should be done in the driver which supports it IMO.
>
I sent another version to register the property in drm driver:
https://lore.kernel.org/lkml/20221019061936.3599965-1-hsinyi@chromium.org/T/#u

Ideally it should be registered by the bridge driver. But some bridge
drivers have already changed to DRM_BRIDGE_ATTACH_NO_CONNECTOR, so
they can't get a connector during the attach stage (or any time before
the connector is registered). Is it acceptable that drm driver help
register the property if CONFIG_DRM_DISPLAY_HDCP_HELPER is defined?

Thanks

> Sean
>
> >
> >
> > > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > ---
> > > v2: Fix compile error when config is not set.
> > > ---
> > >  drivers/gpu/drm/drm_bridge_connector.c | 3 +++
> > >  include/drm/display/drm_hdcp_helper.h  | 8 ++++++++
> > >  2 files changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
> > > index 1c7d936523df5..a3b9ef8dc3f0b 100644
> > > --- a/drivers/gpu/drm/drm_bridge_connector.c
> > > +++ b/drivers/gpu/drm/drm_bridge_connector.c
> > > @@ -7,6 +7,7 @@
> > >  #include <linux/module.h>
> > >  #include <linux/slab.h>
> > >
> > > +#include <drm/display/drm_hdcp_helper.h>
> > >  #include <drm/drm_atomic_state_helper.h>
> > >  #include <drm/drm_bridge.h>
> > >  #include <drm/drm_bridge_connector.h>
> > > @@ -398,6 +399,8 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
> > >         if (panel_bridge)
> > >                 drm_panel_bridge_set_orientation(connector, panel_bridge);
> > >
> > > +       drm_connector_attach_content_protection_property(connector, true);
> > > +
> > >         return connector;
> > >  }
> > >  EXPORT_SYMBOL_GPL(drm_bridge_connector_init);
> > > diff --git a/include/drm/display/drm_hdcp_helper.h b/include/drm/display/drm_hdcp_helper.h
> > > index 8aaf87bf27351..c65d9f06a2532 100644
> > > --- a/include/drm/display/drm_hdcp_helper.h
> > > +++ b/include/drm/display/drm_hdcp_helper.h
> > > @@ -15,8 +15,16 @@ struct drm_device;
> > >  struct drm_connector;
> > >
> > >  int drm_hdcp_check_ksvs_revoked(struct drm_device *dev, u8 *ksvs, u32 ksv_count);
> > > +#if defined(CONFIG_DRM_DISPLAY_HDCP_HELPER)
> > >  int drm_connector_attach_content_protection_property(struct drm_connector *connector,
> > >                                                      bool hdcp_content_type);
> > > +#else
> > > +static inline int drm_connector_attach_content_protection_property(struct drm_connector *connector,
> > > +                                                                  bool hdcp_content_type)
> > > +{
> > > +       return 0;
> > > +}
> > > +#endif
> > >  void drm_hdcp_update_content_protection(struct drm_connector *connector, u64 val);
> > >
> > >  #endif
> > > --
> > > 2.38.0.rc1.362.ged0d419d3c-goog
> > >
