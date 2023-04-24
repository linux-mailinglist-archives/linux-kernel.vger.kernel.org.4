Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60076ED7DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjDXW0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjDXW03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:26:29 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF6BAD38
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 15:26:00 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-52160f75920so3685866a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 15:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682375158; x=1684967158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTelMTGfe+xaUOUgF2MhBTIkN8wlin/OXx8NFFe76ao=;
        b=N+yvdjdnJyzvZelhstrIbdgVW6dE4A0RCqiqupuwgDNh/Z1bwLC26VQi5bq78fFo0n
         EAUztMT4nMYiO3msDunw7wLlBGF+5RqK/OEY3Mz64i+HDzNbiwZ6ZbZCQ/KJJh1qbSpN
         5HPdtE7I4SCGLNYccVOzIbuobEJKVHHvIomEaZOj5VG/tL68NXs+iK11zwFfQQgDrVCb
         2OQnqXP8qDRs1PRhn0nNTmeaXO9lViaemvyjrI//vNavZZNlC9Of4uHBIaN4h6ilh2a0
         yqYb1RCSVExovE7KU9iAO5Nf6B+itPUU5HwN0bwkNMW8ZWTnuItuXdLJTJvV6U8/MxhZ
         r4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682375158; x=1684967158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTelMTGfe+xaUOUgF2MhBTIkN8wlin/OXx8NFFe76ao=;
        b=Ph+eFtJ4Pwuy53ozpaPtJ2IzZo2hOiBqhFHGAb+CZLzEEHE6FLfUTzytHr2E9vEalw
         Q6tuL3L4SCzFs54ZuQHLnaUuND6ItWZrUkuQilLf8zhQN+ISEGYc4KMEhfveVtZYhzO0
         TlkFqXXbKs8Lh+sKskKQ9krjRLiPfuaegVbPR48T635j6fgUDEGJrzzxy1SRMImM5xv0
         IEBSqbNjr1coOQ2Y99cHmKWA7gdsNnTaGQRLwXWxoBNIxjXMTO7/DmZ/sXN5XuXpSs2+
         p6SsVb63RCu3YypHwut7v7I/sO2GeueRE/yFGblPF/lwVj08DEX55s2wjMKBVprsKnz5
         4/4g==
X-Gm-Message-State: AAQBX9dD8/4KkXjk6Fie1tFa4Oxing9THQphccwu5zdhrwDPyVp4vxY/
        5ugyaPWIp+LI31G5teMTnlFRahPLI9BpjBeRa8rGHA==
X-Google-Smtp-Source: AKy350ZXg8pfqWIixq9GJXWeVoa+6XZS8zLmPctEir8nuGopAQMXwTTd5AEPFxcwAenhpFgwalIYgITXDjlMQkiRYR8=
X-Received: by 2002:a17:90a:3487:b0:240:9ccf:41ff with SMTP id
 p7-20020a17090a348700b002409ccf41ffmr13231878pjb.49.1682375158075; Mon, 24
 Apr 2023 15:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230329012147.1908231-1-wonchung@google.com>
In-Reply-To: <20230329012147.1908231-1-wonchung@google.com>
From:   Manasi Navare <navaremanasi@google.com>
Date:   Mon, 24 Apr 2023 15:25:47 -0700
Message-ID: <CAMNLLoQ=tOf4VT2_1qNX+fzHYv-8HL-WB8EVh_AAJ7BSmcm3eg@mail.gmail.com>
Subject: Re: [PATCH v5] drm/sysfs: Link DRM connectors to corresponding Type-C connectors
To:     Won Chung <wonchung@google.com>
Cc:     bleung@google.com, pmalani@chromium.org,
        heikki.krogerus@linux.intel.com, imre.deak@intel.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, gildekel@chromium.org,
        seanpaul@chromium.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 6:23=E2=80=AFPM Won Chung <wonchung@google.com> wro=
te:
>
> Create a symlink pointing to USB Type-C connector for DRM connectors
> when they are created. The link will be created only if the firmware is
> able to describe the connection beween the two connectors.
>
> Currently, even if a display uses a USB Type-C port, there is no way for
> the userspace to find which port is used for which display. With the
> symlink, display information would be accessible from Type-C connectors
> and port information would be accessible from DRM connectors.
>
> Associating the two subsystems, userspace would have potential to expose
> and utilize more complex information. ChromeOS intend to use this
> information for metrics collection. For example, we want to tell which
> port is deriving which displays. Also, combined with USB PD information,
> we can tell whether user is charging their device through display.
> Chromium patch for parsing the symlink from the kernel is at
> http://crrev.com/c/4317207.
>
> We already have a framework in typec port-mapper.c where it goes through
> component devices and runs the bind functions for those with matching
> _PLD (physical location of device).
> https://elixir.bootlin.com/linux/v5.18.1/source/drivers/usb/typec/port-ma=
pper.c
> Since _PLD is ACPI specific field, this linking would only work on ACPI
> x86 as long as _PLD field for Type-C connectors and DRM connectors are
> correctly added to the firmware.
>
> Currently, USB ports and USB4 ports are added as components to create a
> symlink with Type C connector.
> USB:
> https://lore.kernel.org/all/20211223082349.45616-1-heikki.krogerus@linux.=
intel.com/
> USB4:
> https://lore.kernel.org/all/20220418175932.1809770-3-wonchung@google.com/
> So, we follow the same pattern in this patch.
>
> Signed-off-by: Won Chung <wonchung@google.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> Changes from v4: (4 months ago)
> - Update commit message with an actual use case from cros userspace
> - Move component_add to before ddc check which possibly returns
> - Rebased
>
> Changes from v3:
> - Append to the commit message on why this patch is needed
>
> Changes from v2:
> - Resend the patch to dri-devel list
>
> Changes from v1:
> - Fix multiple lines to single line
>
>
>  drivers/gpu/drm/drm_sysfs.c | 40 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index 183130355997..c21312e87aa2 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -11,12 +11,14 @@
>   */
>
>  #include <linux/acpi.h>
> +#include <linux/component.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/gfp.h>
>  #include <linux/i2c.h>
>  #include <linux/kdev_t.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>
>  #include <drm/drm_accel.h>
> @@ -96,6 +98,34 @@ static char *drm_devnode(const struct device *dev, umo=
de_t *mode)
>         return kasprintf(GFP_KERNEL, "dri/%s", dev_name(dev));
>  }
>
> +static int typec_connector_bind(struct device *dev,
> +       struct device *typec_connector, void *data)
> +{
> +       int ret;
> +
> +       ret =3D sysfs_create_link(&dev->kobj, &typec_connector->kobj, "ty=
pec_connector");
> +       if (ret)
> +               return ret;
> +
> +       ret =3D sysfs_create_link(&typec_connector->kobj, &dev->kobj, "dr=
m_connector");
> +       if (ret)
> +               sysfs_remove_link(&dev->kobj, "typec_connector");
> +
> +       return ret;
> +}
> +
> +static void typec_connector_unbind(struct device *dev,
> +       struct device *typec_connector, void *data)
> +{
> +       sysfs_remove_link(&typec_connector->kobj, "drm_connector");
> +       sysfs_remove_link(&dev->kobj, "typec_connector");
> +}
> +
> +static const struct component_ops typec_connector_ops =3D {
> +       .bind =3D typec_connector_bind,
> +       .unbind =3D typec_connector_unbind,
> +};
> +
>  static CLASS_ATTR_STRING(version, S_IRUGO, "drm 1.1.0 20060810");
>
>  /**
> @@ -353,9 +383,16 @@ int drm_sysfs_connector_add(struct drm_connector *co=
nnector)
>
>         connector->kdev =3D kdev;
>
> +       if (dev_fwnode(kdev)) {
> +               r =3D component_add(kdev, &typec_connector_ops);
> +               if (r)
> +                       drm_err(dev, "failed to add component\n");

Can you add more info in this drm_err message about the component that fail=
ed to
make it more intuitive

After this fix,

Reviewed-by: Manasi Navare <navaremanasi@chromium.org>

Manasi

> +       }
> +
>         if (connector->ddc)
>                 return sysfs_create_link(&connector->kdev->kobj,
>                                  &connector->ddc->dev.kobj, "ddc");
> +
>         return 0;
>
>  err_free:
> @@ -371,6 +408,9 @@ void drm_sysfs_connector_remove(struct drm_connector =
*connector)
>         if (connector->ddc)
>                 sysfs_remove_link(&connector->kdev->kobj, "ddc");
>
> +       if (dev_fwnode(connector->kdev))
> +               component_del(connector->kdev, &typec_connector_ops);
> +
>         DRM_DEBUG("removing \"%s\" from sysfs\n",
>                   connector->name);
>
> --
> 2.40.0.348.gf938b09366-goog
>
