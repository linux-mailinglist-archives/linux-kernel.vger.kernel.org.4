Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBDC5FBB57
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJKT2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJKT2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:28:00 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F5879EF1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:27:55 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fw14so13352853pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FuHm+hgGem2uQm1De3fL4nSA6/vrttMC3e6Hbii/Ukg=;
        b=Hi2fY8LxOAmsr7yOOR9k9FUFXnQI+vTxx0FY7PR+l/OBPpmBF0QxtX+YPZutzSF2A3
         KmelJEcXqxDE8dhhvzkqwWKenVa+D52e7+BPnXF8R+MrXGSfv0me0XHgnxTXWDEkJEsb
         cfofsJZfoWt5iUKvKBy6e1jblOJ/++GcBWNybXpE98ZVh0kEiIWCKHrjHdsFY7EWrECy
         1+2BkHX/Q7A+g1UpTS89RuMMJnbCJL2eMbk2McO0dpILqxlRSt8893lcqVZTf4H+w2PX
         NIkYHi9qvU2HROQ9zgdkj45bRF7/KJ8SugtP9+BR9eqID0nJI6C7nYxIYD5hO+pCeZEX
         k2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FuHm+hgGem2uQm1De3fL4nSA6/vrttMC3e6Hbii/Ukg=;
        b=skt71g/FMofFXWnwNHcYfA7HuIocHZNeExOkxor3No1hLScH9nsksgtVXstejDWFuB
         lA22RJPPjyD5YIjw3vOGuQahMuQdj57KBGQR6infzAgbgE/kVADfUr8IdiDWP2xEokNd
         HhLKjlZyEDx2xdiGyeqSzI3cgajHg611mUFh2WlMCrKwAecIrs2T5UaCYr9G/lGariKv
         oZWPtldQhMQviuYq+1NdjQiLd1FtrixXHqBHRQ8Etel6SE6ulArRbIE76/NbzH6Jz/DS
         V4s9Z7/nxDHBt+pke5QJuO02fE1cGaOuL4I1m+iBHdU4JvSxJA5n4RDxuPistuL6SFcX
         sOsQ==
X-Gm-Message-State: ACrzQf2LC8cKMswysiEJQO+R5Kbyu2oPXMKoP5BQJEJkmiACEkJlNApR
        FsixAohl8xR2czkOPocnQtpZWEDz4cp5roDCJrpBmw==
X-Google-Smtp-Source: AMsMyM7Mj7CNGxJnZKWZj3/d+Vdy3OpobsmgepPXTQ4L7Q8aMpmyfkAyY6HHD+XVuoibypQeqDbkj38NAVBEd+MZjHI=
X-Received: by 2002:a17:90a:e7c4:b0:20d:451f:a988 with SMTP id
 kb4-20020a17090ae7c400b0020d451fa988mr735341pjb.57.1665516474482; Tue, 11 Oct
 2022 12:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220926214157.843812-1-wonchung@google.com> <YzK9Wq1qniDcwtkN@kuha.fi.intel.com>
In-Reply-To: <YzK9Wq1qniDcwtkN@kuha.fi.intel.com>
From:   Won Chung <wonchung@google.com>
Date:   Tue, 11 Oct 2022 12:27:43 -0700
Message-ID: <CAOvb9ygJS0ofZygX16fR_RhFjVcqFbJROZ_FvSVeemBBH7Dkwg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/sysfs: Link DRM connectors to corresponding Type-C connectors
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     bleung@google.com, pmalani@chromium.org, imre.deak@intel.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Sep 27, 2022 at 2:07 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Mon, Sep 26, 2022 at 09:41:57PM +0000, Won Chung wrote:
> > Create a symlink pointing to USB Type-C connector for DRM connectors
> > when they are created. The link will be created only if the firmware is
> > able to describe the connection beween the two connectors.
> >
> > Signed-off-by: Won Chung <wonchung@google.com>
>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> > ---
> > Changes from v1:
> > - Fix multiple lines to single line
> >
> >
> >  drivers/gpu/drm/drm_sysfs.c | 40 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> > index 430e00b16eec..6a9904fa9186 100644
> > --- a/drivers/gpu/drm/drm_sysfs.c
> > +++ b/drivers/gpu/drm/drm_sysfs.c
> > @@ -11,12 +11,14 @@
> >   */
> >
> >  #include <linux/acpi.h>
> > +#include <linux/component.h>
> >  #include <linux/device.h>
> >  #include <linux/err.h>
> >  #include <linux/export.h>
> >  #include <linux/gfp.h>
> >  #include <linux/i2c.h>
> >  #include <linux/kdev_t.h>
> > +#include <linux/property.h>
> >  #include <linux/slab.h>
> >
> >  #include <drm/drm_connector.h>
> > @@ -95,6 +97,34 @@ static char *drm_devnode(struct device *dev, umode_t *mode)
> >       return kasprintf(GFP_KERNEL, "dri/%s", dev_name(dev));
> >  }
> >
> > +static int typec_connector_bind(struct device *dev,
> > +     struct device *typec_connector, void *data)
> > +{
> > +     int ret;
> > +
> > +     ret = sysfs_create_link(&dev->kobj, &typec_connector->kobj, "typec_connector");
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = sysfs_create_link(&typec_connector->kobj, &dev->kobj, "drm_connector");
> > +     if (ret)
> > +             sysfs_remove_link(&dev->kobj, "typec_connector");
> > +
> > +     return ret;
> > +}
> > +
> > +static void typec_connector_unbind(struct device *dev,
> > +     struct device *typec_connector, void *data)
> > +{
> > +     sysfs_remove_link(&typec_connector->kobj, "drm_connector");
> > +     sysfs_remove_link(&dev->kobj, "typec_connector");
> > +}
> > +
> > +static const struct component_ops typec_connector_ops = {
> > +     .bind = typec_connector_bind,
> > +     .unbind = typec_connector_unbind,
> > +};
> > +
> >  static CLASS_ATTR_STRING(version, S_IRUGO, "drm 1.1.0 20060810");
> >
> >  /**
> > @@ -355,6 +385,13 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
> >       if (connector->ddc)
> >               return sysfs_create_link(&connector->kdev->kobj,
> >                                &connector->ddc->dev.kobj, "ddc");
> > +
> > +     if (dev_fwnode(kdev)) {
> > +             r = component_add(kdev, &typec_connector_ops);
> > +             if (r)
> > +                     drm_err(dev, "failed to add component\n");
> > +     }
> > +
> >       return 0;
> >
> >  err_free:
> > @@ -367,6 +404,9 @@ void drm_sysfs_connector_remove(struct drm_connector *connector)
> >       if (!connector->kdev)
> >               return;
> >
> > +     if (dev_fwnode(connector->kdev))
> > +             component_del(connector->kdev, &typec_connector_ops);
> > +
> >       if (connector->ddc)
> >               sysfs_remove_link(&connector->kdev->kobj, "ddc");
> >
>
> thanks,
>
> --
> heikki

Hi upstream DRM maintainers,

Can you please take a look at this patch for a review when you have time?

Thank you,
Won
