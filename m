Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA136F1F67
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346048AbjD1Ub5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346602AbjD1Ubr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:31:47 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B404A5FC7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:31:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24b3451b2fcso285986a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682713882; x=1685305882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXLt9wAJDw5YIyP39CbEzK00xStIP8ydgtlC5ZAJKyQ=;
        b=MnkIoreJEUloIXZzUBXgNzmPaj8SiO0fvhpbdWNeLksM5OxjkW9KMggEtpobPJuoVl
         lA6WEfTWfrjHpi54gX8P6to5K0XiCzaVbaev/Cc5NYOQTszbKNsoaqjI88qdHCkRL24O
         CRtg93BSrJ1monq03RALntx+qcE6wII69WOiXrHZFOTz1ZaMw4a53hCV1ayscU4caPoy
         UTEE4oW58qQ7iN8KnVGATpWbsn+t0Sxj2xD7sVqlAnXW5rcgKXtbwnA7Qi0Rz8v0YhVJ
         FjJDUUjRjqkfUbwA6LExbqwlLDYSpgn/C1tnwfAPdgTJ6PESZUl2iPjyETLYNBkVLwTM
         4l7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682713882; x=1685305882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXLt9wAJDw5YIyP39CbEzK00xStIP8ydgtlC5ZAJKyQ=;
        b=JCa6PtcSudZt3LevW8E200hqOSWP/ePT/Ux76jfm0/xQwiMGYV6qCaetb02QZNB9aq
         S8A3qo9EBMtqK5pVjGDk5eZ4SQ2hlXu7jd9MEctUEgBuJsFMXPOmy9Eng/SfEOa9MG31
         Kuz4ja6YhFXBD+wM71k0iRQEK4n3AhrYw+WyxGlYdMpCiCK83PIapK/Ue82IvR6B7AK8
         DAyvKIZUdJLSuykvuzeHnxtJq4EC4qeQOyk9B7+4ygyOYPuy1e7uYFjey9A4iNZW2fy8
         igEYYba5mnJ52P9nuIppke9lhU+j9FJCKbIp7jxAyssXTIkzup2xB89tBcWnfnfD8hrH
         XGqA==
X-Gm-Message-State: AC+VfDyVMg0G0lGc3f5ox2Y7Yybhqi/FQ89i3Umhf//dOjS+KdIqlHze
        sIQIjGCjpvCDHR+lDmSd2OtEhf2mHplSe61T2Fh/Hw==
X-Google-Smtp-Source: ACHHUZ4Pov48bf0gISCx/rGTtlp+yX9CjKCf4ZJnCB5oghVCg/WhWHjD2AYTgk1SerazyOIYZnJjAs9h3wANb0OQLZM=
X-Received: by 2002:a17:90a:eb06:b0:246:9a43:39e5 with SMTP id
 j6-20020a17090aeb0600b002469a4339e5mr6341864pjz.23.1682713882061; Fri, 28 Apr
 2023 13:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230329014455.1990104-1-wonchung@google.com> <CAMNLLoRpWBONxqVG=5ksddZeD-O3LcuTtwDj6CpcvpWsCMcs8w@mail.gmail.com>
In-Reply-To: <CAMNLLoRpWBONxqVG=5ksddZeD-O3LcuTtwDj6CpcvpWsCMcs8w@mail.gmail.com>
From:   Manasi Navare <navaremanasi@google.com>
Date:   Fri, 28 Apr 2023 13:31:11 -0700
Message-ID: <CAMNLLoT=D5C8o0tQ_Jo4SAPow5n_B8ThzLt45ByJpRTZiNOHJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/sysfs: Expose DRM connector id in each connector sysfs
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Won,

Thanks for the patch, I have now merged to drm-misc-next

Regards
Manasi

On Mon, Apr 17, 2023 at 3:52=E2=80=AFPM Manasi Navare <navaremanasi@google.=
com> wrote:
>
> On Tue, Mar 28, 2023 at 6:45=E2=80=AFPM Won Chung <wonchung@google.com> w=
rote:
> >
> > Expose DRM connector id in device sysfs so that we can map the connecto=
r
> > id to the connector syspath. Currently, even if we can derive the
> > connector id from modeset, we do not have a way to find the
> > corresponding connector's syspath.
> >
> > This is helpful when determining the root connector of MST tree. When a
> > tree of multiple MST hub is connected to the system, modeset describes
> > the tree in the PATH blob. For example, consider the following scenario=
.
> >
> > +-------------+
> > | Source      |    +-------------+
> > | (Device)    |    | BranchX     |
> > |             |    | (MST)       |
> > |       [conn6]--->|       [port1]--->DisplayA
> > +-------------+    |             |
> >                    |             |    +-------------+
> >                    |             |    | BranchY     |
> >                    |             |    | (MST)       |
> >                    |       [port2]--->|       [port1]----->DisplayB
> >                    +-------------+    |             |
> >                                       |       [port2]----->DisplayC
> >                                       +-------------+
> >
> > DPMST connector of DisplayA would have "mst:6-1" PATH.
> > DPMST connector of DisplayB would have "mst:6-2-1" PATH.
> > DPMST connector of DisplayC would have "mst:6-2-2" PATH.
> >
> > Given that connector id of 6 is the root of the MST connector tree, we
> > can utilize this patch to parse through DRM connectors sysfs and find
> > which connector syspath corresponds to the root connector (id =3D=3D 6)=
.
> >
> > ChromeOS intend to use this information for metrics collection. For
> > example, we want to tell which port is deriving which displays even wit=
h
> > a MST hub. Chromium patch for parsing DRM connector id from the kernel
> > is at http://crrev.com/c/4317207.
> >
> > Signed-off-by: Won Chung <wonchung@google.com>
>
> Exposing connector id in device sysfs looks good to me.
>
> Reviewed-by: Manasi Navare <navaremanasi@chromium.org>
>
> Manasi
>
> > ---
> >  drivers/gpu/drm/drm_sysfs.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> > index 183130355997..11f98c5d6103 100644
> > --- a/drivers/gpu/drm/drm_sysfs.c
> > +++ b/drivers/gpu/drm/drm_sysfs.c
> > @@ -282,16 +282,27 @@ static ssize_t modes_show(struct device *device,
> >         return written;
> >  }
> >
> > +static ssize_t connector_id_show(struct device *device,
> > +                                struct device_attribute *attr,
> > +                                char *buf)
> > +{
> > +       struct drm_connector *connector =3D to_drm_connector(device);
> > +
> > +       return sysfs_emit(buf, "%d\n", connector->base.id);
> > +}
> > +
> >  static DEVICE_ATTR_RW(status);
> >  static DEVICE_ATTR_RO(enabled);
> >  static DEVICE_ATTR_RO(dpms);
> >  static DEVICE_ATTR_RO(modes);
> > +static DEVICE_ATTR_RO(connector_id);
> >
> >  static struct attribute *connector_dev_attrs[] =3D {
> >         &dev_attr_status.attr,
> >         &dev_attr_enabled.attr,
> >         &dev_attr_dpms.attr,
> >         &dev_attr_modes.attr,
> > +       &dev_attr_connector_id.attr,
> >         NULL
> >  };
> >
> > --
> > 2.40.0.348.gf938b09366-goog
> >
