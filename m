Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432EF63C1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiK2OHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbiK2OHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:07:36 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352025599
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:07:35 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-12c8312131fso17129489fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 06:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+Gx0LMLOcjHUeGcLpNChIem5hR5zVu45lf2JDHJKUo=;
        b=Nrys2ATlqgKSV5/iunJeF2MPgpIgrsVsMfo/q5YlIhfPupHgOyuiTlt7PmeZse4IiM
         rCqXxkaOv+eU+Nl6Jzyd+kyXweW0FMNe2omP3/cabCaUYu5LkfPFIjG0tGszf4SLEeoo
         uLZQvaW3rE29aPwK1miJ+ERe/gVynNlIwb2V5fT/V1UTESmivNoOm4AppAUhFvTDJJ0h
         h5lldDnUJIhty+h9HifTc0MnBEaUpf71n2gRFJv8qhHoS+wPFshbyp8ORLSCVS5ONjc2
         StqiMGsAOx16nJcadqwLNMFOkfAZWTCtPdRLkQiDI/iDjo0XR6b5gAq90JY54Wg1YLCa
         9u+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+Gx0LMLOcjHUeGcLpNChIem5hR5zVu45lf2JDHJKUo=;
        b=lRVe4rQaVYOdoRWCJD0SvyoIPhWRXytjtMyaxLx1N80A/FrnaaZrLIJ3A6nO1p+nVj
         0Evi/hy5M3z9j4kEJ46e7FqIyGY1aU27ZTKYMEshxRxdk2YbtHHH+T6k4CpPLCQUQfbA
         9KXUXg2P1lsZB1qjKIfPLk49/XSS4HioXDeNF9+AeXsQKzk8Pk/Cr0OMSmLnZDoLkPJt
         GCaUL+OdibGQH++hv2tWlbgJWM9UALuiFcpvuTgHE8GXdxskVU7k1X4xxlJagMd3cQWb
         T0Tn6um8BRn3LE+e/vu92wXDv/dyvfg9ijTx9OKbLTsoRmi4FmZqNBbqUEePaSdnL8u1
         OObA==
X-Gm-Message-State: ANoB5pnUqCPpmoThwE6t4ug2Bom65QhA/FjWWOhLip7/19muQIQBk7bZ
        ezDj6l4k1CnntL7KiehHH7KYatBk/Ez60x3d4qU=
X-Google-Smtp-Source: AA0mqf6X7/2sjENwUXQ9/pOfiqzb/aJ0jK/F8dQAxVZWQXnl7KiktOV2Rzd6QwDYbbSZ8yXa9YGuwDNiRf4bSWGH2gk=
X-Received: by 2002:a05:6870:2b05:b0:12d:58c1:33f9 with SMTP id
 ld5-20020a0568702b0500b0012d58c133f9mr21990892oab.46.1669730854511; Tue, 29
 Nov 2022 06:07:34 -0800 (PST)
MIME-Version: 1.0
References: <20221125175203.52481-1-andrealmeid@igalia.com> <20221125175203.52481-2-andrealmeid@igalia.com>
In-Reply-To: <20221125175203.52481-2-andrealmeid@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 29 Nov 2022 09:07:23 -0500
Message-ID: <CADnq5_MxQd5RDeAFe4j5J14Czk5YB7e-1=JFWxQAD=z-vFuQ-w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm: Add GPU reset sysfs event
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, pierre-eric.pelloux-prayer@amd.com,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Simon Ser <contact@emersion.fr>, amaranath.somalapuram@amd.com,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Shashank Sharma <shashank.sharma@amd.com>,
        Rob Clark <robdclark@gmail.com>, kernel-dev@igalia.com,
        alexander.deucher@amd.com, contactshashanksharma@gmail.com,
        Dave Airlie <airlied@gmail.com>, christian.koenig@amd.com,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 12:52 PM Andr=C3=A9 Almeida <andrealmeid@igalia.com=
> wrote:
>
> From: Shashank Sharma <shashank.sharma@amd.com>
>
> Add a sysfs event to notify userspace about GPU resets providing:
> - PID that triggered the GPU reset, if any. Resets can happen from
>   kernel threads as well, in that case no PID is provided
> - Information about the reset (e.g. was VRAM lost?)
>
> Co-developed-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>
> V3:
>    - Reduce information to just PID and flags
>    - Use pid pointer instead of just pid number
>    - BUG() if no reset info is provided
>
> V2:
>    - Addressed review comments from Christian and Amar
>    - move the reset information structure to DRM layer
>    - drop _ctx from struct name
>    - make pid 32 bit(than 64)
>    - set flag when VRAM invalid (than valid)
>    - add process name as well (Amar)
> ---
>  drivers/gpu/drm/drm_sysfs.c | 26 ++++++++++++++++++++++++++
>  include/drm/drm_sysfs.h     | 13 +++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index 430e00b16eec..85777abf4194 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -409,6 +409,32 @@ void drm_sysfs_hotplug_event(struct drm_device *dev)
>  }
>  EXPORT_SYMBOL(drm_sysfs_hotplug_event);
>
> +/**
> + * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU reset
> + * @dev: DRM device
> + * @reset_info: The contextual information about the reset (like PID, fl=
ags)
> + *
> + * Send a uevent for the DRM device specified by @dev. This informs
> + * user that a GPU reset has occurred, so that an interested client
> + * can take any recovery or profiling measure.
> + */
> +void drm_sysfs_reset_event(struct drm_device *dev, struct drm_reset_even=
t_info *reset_info)
> +{
> +       unsigned char pid_str[13];
> +       unsigned char flags_str[18];
> +       unsigned char reset_str[] =3D "RESET=3D1";
> +       char *envp[] =3D { reset_str, pid_str, flags_str, NULL };
> +
> +       DRM_DEBUG("generating reset event\n");
> +
> +       BUG_ON(!reset_info);
> +
> +       snprintf(pid_str, sizeof(pid_str), "PID=3D%u", pid_vnr(reset_info=
->pid));
> +       snprintf(flags_str, sizeof(flags_str), "FLAGS=3D0x%llx", reset_in=
fo->flags);
> +       kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
> +}
> +EXPORT_SYMBOL(drm_sysfs_reset_event);
> +
>  /**
>   * drm_sysfs_connector_hotplug_event - generate a DRM uevent for any con=
nector
>   * change
> diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
> index 6273cac44e47..dbb0ac6230b8 100644
> --- a/include/drm/drm_sysfs.h
> +++ b/include/drm/drm_sysfs.h
> @@ -2,15 +2,28 @@
>  #ifndef _DRM_SYSFS_H_
>  #define _DRM_SYSFS_H_
>
> +#define DRM_RESET_EVENT_VRAM_LOST (1 << 0)

I was thinking about this a bit more last night, and I think we should add:
DRM_RESET_EVENT_APP_ROBUSTNESS
When an application that supports robustness extensions starts, the
UMD can set a flag when it creates the context with the KMD.  That way
if the app causes a GPU hang, the reset daemon would see this flag if
the guilty app supports robustness and adjust it's behavior as
appropriate.  E.g., rather than killing the app, it might let it run
or set some grace period, etc.

Alex


> +
>  struct drm_device;
>  struct device;
>  struct drm_connector;
>  struct drm_property;
>
> +/**
> + * struct drm_reset_event_info - Information about a GPU reset event
> + * @pid: Process that triggered the reset, if any
> + * @flags: Extra information around the reset event (e.g. is VRAM lost?)
> + */
> +struct drm_reset_event_info {
> +       struct pid *pid;
> +       uint64_t flags;
> +};
> +
>  int drm_class_device_register(struct device *dev);
>  void drm_class_device_unregister(struct device *dev);
>
>  void drm_sysfs_hotplug_event(struct drm_device *dev);
> +void drm_sysfs_reset_event(struct drm_device *dev, struct drm_reset_even=
t_info *reset_info);
>  void drm_sysfs_connector_hotplug_event(struct drm_connector *connector);
>  void drm_sysfs_connector_status_event(struct drm_connector *connector,
>                                       struct drm_property *property);
> --
> 2.38.1
>
