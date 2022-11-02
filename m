Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E0661619F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiKBLTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKBLTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:19:48 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDF72736
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 04:19:48 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso1853729pjc.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 04:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E6zXVLa2IfbM1r+MEEESAo6MxuWborMv3NhXwQXwvRI=;
        b=aCNh6nz86M3/6f5x/ME9zAV12Z2u5FFjpSBpm6E1cuUKpVNEdpPEniMlj0ukTn2OaJ
         qjTaXQ9VcLxVduu16SVXHKd5UheZHordc6PPutfbjkmtgurj2fXU+HPpdRs+a/xqErBR
         xuIl2WWa0niyQDpt+dlZLY1xjBRVu1X+iFBrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6zXVLa2IfbM1r+MEEESAo6MxuWborMv3NhXwQXwvRI=;
        b=CSQ6Ja5+u/3ZZ/c4OUie2KUnC5dU/s07cE0CKjN06/2RnSl2K5ScMpcOhvnPfjol4f
         5GK4PM34+Txu18TRR1yfpMt9E1C8BYLt0kzoGGR2feDe8LBytP9GQ2ld6kyxE+3cCR63
         hxmvygzGgtSc5I768bVqcA3lk8EbJ3i/yqs3VMVEJo7vlfMx1ztAUoqXETCMuLzazvZM
         lTatJFnBPGea6yoTBMIV/oqUcy1442lMJiUDmVA2+tcRWlja16/7JxhXdW1xxJoMCXUe
         Zvndfnq/Asd4F0TyrhsTmmB3DbM7WEfTp8V5XqDAyR+oLsfkx3oBVIE/afr7rbficMkX
         tchQ==
X-Gm-Message-State: ACrzQf2QNJRtwsi0oenSK+C5uMsya4hWbCHwg/Pfzjd2IoWJudOYqbjs
        +c0gNP+/aHvra1NESbprMQwtsDRz2GKcE00ETNaoEQ==
X-Google-Smtp-Source: AMsMyM7UmtML6gy6indouX9gsyoixVXVkU7RHJ3Y3MBtWpcQLl5OJpKkBUeR/lNxWvoXkCGywmxZIzcLXiIxBLbmGJc=
X-Received: by 2002:a17:902:820b:b0:185:b9a:8ac1 with SMTP id
 x11-20020a170902820b00b001850b9a8ac1mr24802014pln.111.1667387987592; Wed, 02
 Nov 2022 04:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221012042030.573466-1-hsinyi@chromium.org> <CAJMQK-i1GFP_5NsH7MLYS17xacrYZf1u6bjVYBkW-qHMbuh2_w@mail.gmail.com>
 <CAOw6vbLPUkwoaSHyWARZnkcsacf9rsmB6M=97z1-98kgM7BNEQ@mail.gmail.com>
In-Reply-To: <CAOw6vbLPUkwoaSHyWARZnkcsacf9rsmB6M=97z1-98kgM7BNEQ@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 2 Nov 2022 19:19:21 +0800
Message-ID: <CAJMQK-inch8he3_LEAAe4y-y+18cak6PS83TByvO47tFMBceiQ@mail.gmail.com>
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
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
> Sean
>

hi Sean,

v3 is sent: connector will check if any bridge in that chain supports
hdcp by looking up a variable in the bridge:
https://patchwork.kernel.org/project/dri-devel/patch/20221102111148.1810314-1-hsinyi@chromium.org/



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
