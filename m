Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530146E54CB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjDQWwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDQWwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:52:18 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBE92D61
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 15:52:17 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-517baf1bc87so1919844a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 15:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681771937; x=1684363937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zo+QcbgswHVNKq1x8Eye8R2F5dWqFdny9W9Iv3jq8Q=;
        b=xfe80fkH53J5CUQ7FjYITdmYzmnPobKB5CbnFVwIER32p+5u+phsbqFtt6ERbaC6i7
         0TjYjI0EsDC4Pciz56LE2TzEHd20JgQF1Xi3NtPYRrVsO8pjJ6qIqc83SZdEx6Zy/06Z
         bqxzHi+97brr1D8M7hwjJOIyzVeCLZPX19g8iUdTMcrsiifQbdg71iyJWGAAxxojtXWs
         70gOiSGpT1S5JQlQqfXkvMpH6bS8HDyLNdw4GUz/5HNxHmlszC81F9GgvySqSR0j2h33
         aYUrnIqH9Bgae58iZl4NFBa0eWQKe6Aogmlt95RSm+mOxyQluwMk5WunSGqI51E+PFTw
         YDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681771937; x=1684363937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zo+QcbgswHVNKq1x8Eye8R2F5dWqFdny9W9Iv3jq8Q=;
        b=Gb4fGhBSlQTRYBLXaaktmtfK3ykdGegYdvZXNrnxzb3ZuKz3mwfJgDYjMXaSP0Q2N4
         Karyb6gOGV0Ho0tBmoPECl3/p5aZ+eLhUBMap0j+q4rU06/Gw4FOTzUmq8HjyCjWfEHq
         JiN+pat1e5EGR0BVxfgLhsEJ5jhtrZXa3Wg5/BGQlHzml5+GW8/CFe6M0QrBiiSpbovF
         E06XywIORM5tCI6vu1OdXu5imhrSMbq7awHZC5QcsZ9lzLEXXuXkm+1sjBftHlVhzmH+
         7JkfjhpxktcX5O8LJuKhNMkQ3r7qtnCpd62slHae7FTc2SJE7LGvCvnQql+82fCAFk7t
         fHhg==
X-Gm-Message-State: AAQBX9fIjKDhar8Na4ffM8dhgiAfh2o+DbOBHrgE3vcYIpp1MWQKi6nm
        WB6E3E8xADj5w5x6zS4Rpv1TC8i+FcK/tZwwdyNdYw==
X-Google-Smtp-Source: AKy350ZuiYuzhfhEJzAQR9g56AE63lpfBVdvcKCBUP9rE5siupUQJBnvU+9LxQ7dxFv7TslQUKfbJK/JFxB3Kr3MaPE=
X-Received: by 2002:a63:e310:0:b0:503:25f0:9cc5 with SMTP id
 f16-20020a63e310000000b0050325f09cc5mr45727pgh.2.1681771937242; Mon, 17 Apr
 2023 15:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230329014455.1990104-1-wonchung@google.com>
In-Reply-To: <20230329014455.1990104-1-wonchung@google.com>
From:   Manasi Navare <navaremanasi@google.com>
Date:   Mon, 17 Apr 2023 15:52:06 -0700
Message-ID: <CAMNLLoRpWBONxqVG=5ksddZeD-O3LcuTtwDj6CpcvpWsCMcs8w@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 6:45=E2=80=AFPM Won Chung <wonchung@google.com> wro=
te:
>
> Expose DRM connector id in device sysfs so that we can map the connector
> id to the connector syspath. Currently, even if we can derive the
> connector id from modeset, we do not have a way to find the
> corresponding connector's syspath.
>
> This is helpful when determining the root connector of MST tree. When a
> tree of multiple MST hub is connected to the system, modeset describes
> the tree in the PATH blob. For example, consider the following scenario.
>
> +-------------+
> | Source      |    +-------------+
> | (Device)    |    | BranchX     |
> |             |    | (MST)       |
> |       [conn6]--->|       [port1]--->DisplayA
> +-------------+    |             |
>                    |             |    +-------------+
>                    |             |    | BranchY     |
>                    |             |    | (MST)       |
>                    |       [port2]--->|       [port1]----->DisplayB
>                    +-------------+    |             |
>                                       |       [port2]----->DisplayC
>                                       +-------------+
>
> DPMST connector of DisplayA would have "mst:6-1" PATH.
> DPMST connector of DisplayB would have "mst:6-2-1" PATH.
> DPMST connector of DisplayC would have "mst:6-2-2" PATH.
>
> Given that connector id of 6 is the root of the MST connector tree, we
> can utilize this patch to parse through DRM connectors sysfs and find
> which connector syspath corresponds to the root connector (id =3D=3D 6).
>
> ChromeOS intend to use this information for metrics collection. For
> example, we want to tell which port is deriving which displays even with
> a MST hub. Chromium patch for parsing DRM connector id from the kernel
> is at http://crrev.com/c/4317207.
>
> Signed-off-by: Won Chung <wonchung@google.com>

Exposing connector id in device sysfs looks good to me.

Reviewed-by: Manasi Navare <navaremanasi@chromium.org>

Manasi

> ---
>  drivers/gpu/drm/drm_sysfs.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index 183130355997..11f98c5d6103 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -282,16 +282,27 @@ static ssize_t modes_show(struct device *device,
>         return written;
>  }
>
> +static ssize_t connector_id_show(struct device *device,
> +                                struct device_attribute *attr,
> +                                char *buf)
> +{
> +       struct drm_connector *connector =3D to_drm_connector(device);
> +
> +       return sysfs_emit(buf, "%d\n", connector->base.id);
> +}
> +
>  static DEVICE_ATTR_RW(status);
>  static DEVICE_ATTR_RO(enabled);
>  static DEVICE_ATTR_RO(dpms);
>  static DEVICE_ATTR_RO(modes);
> +static DEVICE_ATTR_RO(connector_id);
>
>  static struct attribute *connector_dev_attrs[] =3D {
>         &dev_attr_status.attr,
>         &dev_attr_enabled.attr,
>         &dev_attr_dpms.attr,
>         &dev_attr_modes.attr,
> +       &dev_attr_connector_id.attr,
>         NULL
>  };
>
> --
> 2.40.0.348.gf938b09366-goog
>
