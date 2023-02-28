Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7E46A6270
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjB1WdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjB1WdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:33:19 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD971C311
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:33:17 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id s8so7266508ilv.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDZFHOktHxS/XDKrIMefDxSktOzxgIy4sJlU+F/fZDA=;
        b=XcdYgB1yBTrJ0aYQ0dsS8hFi/aaKG4F8Ds0GxVsXWTTIN6NWfXAZ4D3+9snIiGmDpk
         qcv/TZW88idkK+8CkUbjAmZ4nhvjrvug00Qh4Env3wOG1Er5byNPRO3d2+QnoNdsByVU
         I+xpXzBw+p5vYHbknDO3bqjr11W4h+GV5UIT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDZFHOktHxS/XDKrIMefDxSktOzxgIy4sJlU+F/fZDA=;
        b=wcMXstADBzjsieFZet5j6uvsV8w7EgAcLKjocUkOuAee5jvt0S1BApcZa8TpJWolzV
         pvBBCssaUsZO4OYeqppT5Z68tsxPoxFvJO+mtHJfvsFh8cP8jR/LCbhzoI1jcmDZsELG
         HeBmfTuOjhIFqs2Hg2SydtXjuRDHF80aJRKArxGFdmkvAWpZoecW8y2G3k/Gd8OLIJam
         p0Kr2TQBCCNxW2Gl38R1A3AKS/UVV5MHtmZA4LE7LdfK8FPIVB7jQcK1g5aj5mIXPwZN
         OnOgC7w+YE5urX1VnV4JApGRwNxa0jcaSEjXIeps3e5bTOR1Ch+bJDzNcjYexy+Q7792
         X20A==
X-Gm-Message-State: AO0yUKUJkOJPNBKhQDGserqwcDb9Klt4ApQbgh+SMtbbP1sIcDcLxM15
        OPJNieI9+8ZOkhdxmscI/JF724vO9hjjwpFi
X-Google-Smtp-Source: AK7set9dmP7HxzH5Veo4QRsVjeHHeGiZyobqf8+uBrxS+/BdyOydKGfYwDgLcehF/97JWZlhIA0igQ==
X-Received: by 2002:a05:6e02:1a61:b0:310:c6f7:c1e9 with SMTP id w1-20020a056e021a6100b00310c6f7c1e9mr4028375ilv.5.1677623596543;
        Tue, 28 Feb 2023 14:33:16 -0800 (PST)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id 14-20020a056e020cae00b00316dc3afe57sm2979183ilg.86.2023.02.28.14.33.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 14:33:14 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id v10so4664237iox.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:33:14 -0800 (PST)
X-Received: by 2002:a05:6602:151:b0:745:c41a:8f0f with SMTP id
 v17-20020a056602015100b00745c41a8f0fmr1934398iot.2.1677623593416; Tue, 28 Feb
 2023 14:33:13 -0800 (PST)
MIME-Version: 1.0
References: <20230224070506.4157738-1-saravanak@google.com> <20230224070506.4157738-2-saravanak@google.com>
In-Reply-To: <20230224070506.4157738-2-saravanak@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Feb 2023 14:33:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XQnLpD1P8sRBcizTMjCQyHTjaiNvjcPdgyZc5JCzvOtw@mail.gmail.com>
Message-ID: <CAD=FV=XQnLpD1P8sRBcizTMjCQyHTjaiNvjcPdgyZc5JCzvOtw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] driver core: Add fw_devlink.sync_state command
 line param
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 23, 2023 at 11:05=E2=80=AFPM Saravana Kannan <saravanak@google.=
com> wrote:
>
> When all devices that could probe have finished probing, this parameter
> controls what to do with devices that haven't yet received their
> sync_state() calls.
>
> fw_devlink.sync_state=3Dstrict is the default and the driver core will
> continue waiting on consumers to probe successfully in the future.

This description is misleading / borderline wrong. You say that when
"sync_state=3Dstrict" that you'll wait on consumers to probe
successfully in the future. As talked about below, I think that when
the pre-existing "deferred_probe_timeout" (which you're tying into)
expires, it's unlikely that devices will probe successfully in the
future. Sure, it's possible, but in general once the
"deferred_probe_timeout" expires then the system is done waiting for
new devices to show up. While it's still _possible_ to add new
devices, you need to take care to deal with the fact that some
important devices might have already given up and also that you're
adding these new devices in strict dependency order...

IMO better would be to say something like when sync_state=3Dstrict that
you'll just leave resources in a high power state if not all devices
have shown up and the system thinks probing is done.


> This
> is the default behavior since calling sync_state() when all the
> consumers haven't probed could make some systems unusable/unstable.
>
> fw_devlink.sync_state=3Dtimeout will cause the driver core to give up
> waiting on consumers and call sync_state() on any devices that haven't
> yet received their sync_state() calls. This option is provided for
> systems that won't become unusable/unstable as they might be able to
> save power (depends on state of hardware before kernel starts) if all
> devices get their sync_state().

While I don't object to this being a kernel command line flag, the
default should also be a Kconfig option. The kernel command line is
not a great place for general configuration. As we jam too much stuff
in the kernel command line it gets unwieldy quickly. IMO:

* Kconfig: the right place for stuff for config options that a person
building the kernel might want to tweak.

* Kernel command line: the right place for a user of a pre-built
kernel to tweak; also (sometimes) the right place for the bootloader
to pass info to the kernel; also a good place for debug options that a
kernel engineer might want to tweak w/out rebuilding the kernel.

In this case it makes sense for the person building the kernel to
choose a default that makes sense for the hardware that their kernel
is targetting. It can also make sense for a user of a pre-built kernel
to tweak this if their hardware isn't working correctly. Thus it makes
sense for Kconfig to choose the default and the kernel command line to
override.


> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 12 ++++
>  drivers/base/base.h                           |  1 +
>  drivers/base/core.c                           | 58 +++++++++++++++++++
>  drivers/base/dd.c                             |  6 ++
>  4 files changed, 77 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 6cfa6e3996cf..f0bf2f40af64 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1594,6 +1594,18 @@
>                         dependencies. This only applies for fw_devlink=3D=
on|rpm.
>                         Format: <bool>
>
> +       fw_devlink.sync_state =3D

Is there a reason this is nested under "fw_devlink"? The sysfs
attribute "sync_state" that you modify in patch #2 doesn't reference
"fw_devlink" at all.


> +                       [KNL] When all devices that could probe have fini=
shed
> +                       probing, this parameter controls what to do with
> +                       devices that haven't yet received their sync_stat=
e()
> +                       calls.
> +                       Format: { strict | timeout }
> +                       strict -- Default. Continue waiting on consumers =
to
> +                               probe successfully.
> +                       timeout -- Give up waiting on consumers and call
> +                               sync_state() on any devices that haven't =
yet
> +                               received their sync_state() calls.

Some description needs to be included about how long the timeout is.
Specifically, tie it into the "deferred_probe_timeout" feature since
that's what you're using.


> +
>         gamecon.map[2|3]=3D
>                         [HW,JOY] Multisystem joystick and NES/SNES/PSX pa=
d
>                         support via parallel port (up to 5 devices per po=
rt)
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 726a12a244c0..6fcd71803d35 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -209,6 +209,7 @@ extern void device_links_no_driver(struct device *dev=
);
>  extern bool device_links_busy(struct device *dev);
>  extern void device_links_unbind_consumers(struct device *dev);
>  extern void fw_devlink_drivers_done(void);
> +extern void fw_devlink_probing_done(void);
>
>  /* device pm support */
>  void device_pm_move_to_tail(struct device *dev);
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index f9297c68214a..929ec218f180 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1727,6 +1727,26 @@ static int __init fw_devlink_strict_setup(char *ar=
g)
>  }
>  early_param("fw_devlink.strict", fw_devlink_strict_setup);
>
> +#define FW_DEVLINK_SYNC_STATE_STRICT   0
> +#define FW_DEVLINK_SYNC_STATE_TIMEOUT  1

I don't care tons, but I feel like this should be an enum, or a bool.


> +
> +static int fw_devlink_sync_state;
> +static int __init fw_devlink_sync_state_setup(char *arg)
> +{
> +       if (!arg)
> +               return -EINVAL;
> +
> +       if (strcmp(arg, "strict") =3D=3D 0) {
> +               fw_devlink_sync_state =3D FW_DEVLINK_SYNC_STATE_STRICT;
> +               return 0;
> +       } else if (strcmp(arg, "timeout") =3D=3D 0) {
> +               fw_devlink_sync_state =3D FW_DEVLINK_SYNC_STATE_TIMEOUT;
> +               return 0;
> +       }
> +       return -EINVAL;
> +}
> +early_param("fw_devlink.sync_state", fw_devlink_sync_state_setup);
> +
>  static inline u32 fw_devlink_get_flags(u8 fwlink_flags)
>  {
>         if (fwlink_flags & FWLINK_FLAG_CYCLE)
> @@ -1797,6 +1817,44 @@ void fw_devlink_drivers_done(void)
>         device_links_write_unlock();
>  }
>
> +static int fw_devlink_dev_sync_state(struct device *dev, void *data)
> +{
> +       struct device_link *link =3D to_devlink(dev);
> +       struct device *sup =3D link->supplier;
> +
> +       if (!(link->flags & DL_FLAG_MANAGED) ||
> +           link->status =3D=3D DL_STATE_ACTIVE || sup->state_synced ||
> +           !dev_has_sync_state(sup))
> +               return 0;
> +
> +       if (fw_devlink_sync_state =3D=3D FW_DEVLINK_SYNC_STATE_STRICT) {
> +               dev_warn(sup, "sync_state() pending due to %s\n",
> +                        dev_name(link->consumer));

This warning message is (IMO) an important feature of your patch. IMO
it deserves a mention in the commit message and even if (for some
reason) we decide we don't like the concept of forcing sync_state
after a timeout then we should still find a way to get this warning
message printed out. Maybe promote it to its own patch?

Specifically, I think this warning message gets printed out after
we've given up waiting for devices to show up. At this point
-EPROBE_DEFER becomes an error that we won't retry. That means that we
expect that sync state will _never_ be called in the future and that
resources will be left enabled / in a higher power state than needed.

I would perhaps also make it sound a little scarier since, IMO, this
is a problem that really shouldn't be "shipped" if this is an embedded
kernel. Maybe something like:

  sync_state pending (%s); resources left in high power state


> +               return 0;
> +       }
> +
> +       if (!list_empty(&sup->links.defer_sync))
> +               return 0;
> +
> +       dev_warn(sup, "Timed out. Calling sync_state()\n");

nit: since you aren't directly calling it after this print (you're
adding it to the queue), maybe change to "Forcing sync_state()".
