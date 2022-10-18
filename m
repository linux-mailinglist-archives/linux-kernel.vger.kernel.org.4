Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33F9603264
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJRS02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJRS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:26:26 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C916A47E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:26:25 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b79so12326880iof.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RTmzq7eoqYW6NBc3Vsko4U0xjZphvkiO+FIl89OP+4g=;
        b=KAEU2iVH6lvM1Vadrgtxn8/Ndza1LhSV1UA/xU5Cb4JE6wwmI7gzeJFoYih/YCwK5S
         786yGxRpOOesWqPk0wkYuMgol6ThR+tJLe+h4KqiG0Q91wemNG0ssmKeUN+Df26cnL9d
         rrlQcBy4e7Yl0rwWEeLx54JAAS8j92neXQVB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTmzq7eoqYW6NBc3Vsko4U0xjZphvkiO+FIl89OP+4g=;
        b=uTJVmPS83/xv4jCFMexY3XSGs5utYpaMC+kPjJ1PyxFgZVyv+5AtQzILS1/fVuwFmD
         orMs+EcW94XGnSwiIrJHURGEriya+m3fN5XS1UOazBlxwWSwC6GAsfHLHadmOXFeN0TM
         SqnMPGSxqM/BC57sID2aufNORIv9qAWnCcx2euhz7O4sFZhe2HJsWf3diw/Rn0Qm4lRs
         T36CALR/rsR+aaHnT+fdMACtx7R19LODHW1ogUbwH9RaD8xqD/mjgS17SBez5MNAJWiT
         ad2wKl3YWs3pwJTGqzbaJJQaYv3ZjH+rUWKqcf4Rl8r2xKT6XSeVUAQiNRqSJY+Y6KLg
         pyNA==
X-Gm-Message-State: ACrzQf0+wCTP7H9mxdlIQni/n5dpqZbcoumjTng0boylm/Dlgi42WTA9
        CDiUYzdU+x2BvlYtnuqdC/7VUPDFtFZAiQ==
X-Google-Smtp-Source: AMsMyM6XOSHDwcu0PtJMFlQnAQc64qQWTFYYfgBaO1mQ08Fl0ExPV0lqi0MNhrpLj04/PzGgS4Iubw==
X-Received: by 2002:a05:6602:2e8d:b0:6bc:77d8:7713 with SMTP id m13-20020a0566022e8d00b006bc77d87713mr2450000iow.144.1666117584208;
        Tue, 18 Oct 2022 11:26:24 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id g14-20020a02850e000000b00363ff12ca47sm1275814jai.125.2022.10.18.11.26.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 11:26:21 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id o65so12500131iof.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:26:21 -0700 (PDT)
X-Received: by 2002:a05:6602:125d:b0:6bc:61ec:29c0 with SMTP id
 o29-20020a056602125d00b006bc61ec29c0mr2464726iou.81.1666117580728; Tue, 18
 Oct 2022 11:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221012042030.573466-1-hsinyi@chromium.org> <CAJMQK-i1GFP_5NsH7MLYS17xacrYZf1u6bjVYBkW-qHMbuh2_w@mail.gmail.com>
In-Reply-To: <CAJMQK-i1GFP_5NsH7MLYS17xacrYZf1u6bjVYBkW-qHMbuh2_w@mail.gmail.com>
From:   Sean Paul <seanpaul@chromium.org>
Date:   Tue, 18 Oct 2022 14:25:41 -0400
X-Gmail-Original-Message-ID: <CAOw6vbLPUkwoaSHyWARZnkcsacf9rsmB6M=97z1-98kgM7BNEQ@mail.gmail.com>
Message-ID: <CAOw6vbLPUkwoaSHyWARZnkcsacf9rsmB6M=97z1-98kgM7BNEQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm_bridge: register content protect property
To:     Hsin-Yi Wang <hsinyi@chromium.org>
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

On Mon, Oct 17, 2022 at 9:49 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Wed, Oct 12, 2022 at 12:20 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > Some bridges are able to update HDCP status from userspace request if
> > they support HDCP.
> >
> > HDCP property is the same as other connector properties that need to be
> > created after the connecter is initialized and before the connector is
> > registered.
> >
> anx7625 is a user for this.

I feel like we should not unconditionally attach this property for
bridges, this should be done in the driver which supports it IMO.

Sean

>
>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> > v2: Fix compile error when config is not set.
> > ---
> >  drivers/gpu/drm/drm_bridge_connector.c | 3 +++
> >  include/drm/display/drm_hdcp_helper.h  | 8 ++++++++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
> > index 1c7d936523df5..a3b9ef8dc3f0b 100644
> > --- a/drivers/gpu/drm/drm_bridge_connector.c
> > +++ b/drivers/gpu/drm/drm_bridge_connector.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >
> > +#include <drm/display/drm_hdcp_helper.h>
> >  #include <drm/drm_atomic_state_helper.h>
> >  #include <drm/drm_bridge.h>
> >  #include <drm/drm_bridge_connector.h>
> > @@ -398,6 +399,8 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
> >         if (panel_bridge)
> >                 drm_panel_bridge_set_orientation(connector, panel_bridge);
> >
> > +       drm_connector_attach_content_protection_property(connector, true);
> > +
> >         return connector;
> >  }
> >  EXPORT_SYMBOL_GPL(drm_bridge_connector_init);
> > diff --git a/include/drm/display/drm_hdcp_helper.h b/include/drm/display/drm_hdcp_helper.h
> > index 8aaf87bf27351..c65d9f06a2532 100644
> > --- a/include/drm/display/drm_hdcp_helper.h
> > +++ b/include/drm/display/drm_hdcp_helper.h
> > @@ -15,8 +15,16 @@ struct drm_device;
> >  struct drm_connector;
> >
> >  int drm_hdcp_check_ksvs_revoked(struct drm_device *dev, u8 *ksvs, u32 ksv_count);
> > +#if defined(CONFIG_DRM_DISPLAY_HDCP_HELPER)
> >  int drm_connector_attach_content_protection_property(struct drm_connector *connector,
> >                                                      bool hdcp_content_type);
> > +#else
> > +static inline int drm_connector_attach_content_protection_property(struct drm_connector *connector,
> > +                                                                  bool hdcp_content_type)
> > +{
> > +       return 0;
> > +}
> > +#endif
> >  void drm_hdcp_update_content_protection(struct drm_connector *connector, u64 val);
> >
> >  #endif
> > --
> > 2.38.0.rc1.362.ged0d419d3c-goog
> >
