Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160C16A6284
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjB1WeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjB1Wdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:33:50 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F385126846
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:33:34 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id y140so4668425iof.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBqlMFlT8eg3MVlu0zFPgF0WXiDAd6+AS6z3qS5hb5I=;
        b=kolb02qTh3ywULDbQkMYd1y1/RKliSHMUTeRL16doSRvrj+fNW9Bau4kPUhV17tLuo
         +DT5Iu0jcvvLKGmIUAbCE0CCNhTTqSH0FqChprSiFAMSiuJOHKf5rLmO6SUAedFgRyiB
         i2SgNm2Wc+Ne3nml01BVn+5oBom06zaSHxhxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBqlMFlT8eg3MVlu0zFPgF0WXiDAd6+AS6z3qS5hb5I=;
        b=VNxmFDbHbf9FOryBRBTkeG3xYncQY6X4HXHiRdGR4as4zobEzgfcudPVu2EQVg4BHx
         D4Bl36h+HJaT4y+Mlcd088onk01Wv0FaT2VksASgISW5SjNEMSPtsD60R/V/JkwqTKS5
         f8tplOzHA6IQBv5GS1C7k7C9IZFNnU6sHCXVokE0IjqQEoQSh6sIDMuSaEYtgE6U2LD9
         k06iRq6id8pOniAWOqVPhhCdyMZVkUC7rfFcXo4xYu25NipoTubkicemR5A2kdy+27fj
         yBdMa6O00iRAvg3Qe8JepnItnPpfPog85bOB/6kyaF/zZDd0RTqG6R+PvZNGqbv1YGmO
         mzaQ==
X-Gm-Message-State: AO0yUKU1/NM12ZwSwBQAIqQaZ+dbRM2CF/rUypollyUsU8WoU9CzB9Fq
        SiDs7jh0Kb6puS7gu7uSuTlf1FWjPPD8Xp7o
X-Google-Smtp-Source: AK7set/G7A2Pjuz08dDX3GXYG5GKKm64LBucmGjMr8adSlsHyXEJ/W6NRE1WnyWh3FJUumges5uAFQ==
X-Received: by 2002:a05:6602:42c9:b0:74c:c594:beaf with SMTP id ce9-20020a05660242c900b0074cc594beafmr3147805iob.18.1677623613988;
        Tue, 28 Feb 2023 14:33:33 -0800 (PST)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id j21-20020a6bf915000000b0071664d0a4d7sm3429003iog.49.2023.02.28.14.33.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 14:33:31 -0800 (PST)
Received: by mail-il1-f179.google.com with SMTP id l2so7285134ilg.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:33:31 -0800 (PST)
X-Received: by 2002:a92:1a0d:0:b0:310:a24c:4231 with SMTP id
 a13-20020a921a0d000000b00310a24c4231mr2161049ila.6.1677623611297; Tue, 28 Feb
 2023 14:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20230224070506.4157738-1-saravanak@google.com> <20230224070506.4157738-3-saravanak@google.com>
In-Reply-To: <20230224070506.4157738-3-saravanak@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Feb 2023 14:33:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WaWmHDX0FVH1KO7b_QDM9xxt86q60MGOtPVVvGZJ+t7A@mail.gmail.com>
Message-ID: <CAD=FV=WaWmHDX0FVH1KO7b_QDM9xxt86q60MGOtPVVvGZJ+t7A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] driver core: Make state_synced device attribute writeable
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 23, 2023 at 11:05=E2=80=AFPM Saravana Kannan <saravanak@google.=
com> wrote:
>
> If the file is written to and sync_state() hasn't been called for the
> device yet, then call sync_state() for the device independent of the
> state of its consumers.
>
> This is useful for supplier devices that have one or more consumers that
> don't have a driver but the consumers are in a state that don't use the
> resources supplied by the supplier device.
>
> This gives finer grained control than using the
> fw_devlink.sync_state=3Dtimeout kernel commandline parameter.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  .../ABI/testing/sysfs-devices-state_synced     |  5 +++++
>  drivers/base/base.h                            |  8 ++++++++
>  drivers/base/core.c                            |  5 +----
>  drivers/base/dd.c                              | 18 +++++++++++++++++-
>  4 files changed, 31 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-state_synced b/Docum=
entation/ABI/testing/sysfs-devices-state_synced
> index 0c922d7d02fc..cc4090c9df75 100644
> --- a/Documentation/ABI/testing/sysfs-devices-state_synced
> +++ b/Documentation/ABI/testing/sysfs-devices-state_synced
> @@ -21,4 +21,9 @@ Description:
>                 at the time the kernel starts are not affected or limited=
 in
>                 any way by sync_state() callbacks.
>
> +               Writing anything to this file will force a call to the de=
vice's
> +               sync_state() function if it hasn't been called already. T=
he
> +               sync_state() call happens is independent of the state of =
the
> +               consumer devices.

Please don't just accept anything written. It doesn't take much to
check that the user wrote some known value here and then if we ever
have a reason to allow something else we don't have to break old ABIs.
Maybe "-1"?


> +
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 6fcd71803d35..b055eba1ec30 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -164,6 +164,14 @@ static inline int driver_match_device(struct device_=
driver *drv,
>         return drv->bus->match ? drv->bus->match(dev, drv) : 1;
>  }
>
> +static inline void dev_sync_state(struct device *dev)

IMO don't force inline. The compiler is probably smarter than you. I
could even believe that it might be more optimal for this rarely
called function to be _not_ inline if it kept the kernel smaller. I
guess that means moving it out of the header...

> +{
> +       if (dev->bus->sync_state)
> +               dev->bus->sync_state(dev);
> +       else if (dev->driver && dev->driver->sync_state)
> +               dev->driver->sync_state(dev);
> +}
> +
>  extern int driver_add_groups(struct device_driver *drv,
>                              const struct attribute_group **groups);
>  extern void driver_remove_groups(struct device_driver *drv,
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 929ec218f180..60bb3551977b 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1215,10 +1215,7 @@ static void device_links_flush_sync_list(struct li=
st_head *list,
>                 if (dev !=3D dont_lock_dev)
>                         device_lock(dev);
>
> -               if (dev->bus->sync_state)
> -                       dev->bus->sync_state(dev);
> -               else if (dev->driver && dev->driver->sync_state)
> -                       dev->driver->sync_state(dev);
> +               dev_sync_state(dev);
>
>                 if (dev !=3D dont_lock_dev)
>                         device_unlock(dev);
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 84f07e0050dd..17b51573f794 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -510,6 +510,22 @@ EXPORT_SYMBOL_GPL(device_bind_driver);
>  static atomic_t probe_count =3D ATOMIC_INIT(0);
>  static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
>
> +static ssize_t state_synced_store(struct device *dev,
> +                                 struct device_attribute *attr,
> +                                 const char *buf, size_t count)
> +{
> +       device_lock(dev);
> +       if (!dev->state_synced) {
> +               dev->state_synced =3D true;
> +               dev_sync_state(dev);
> +       } else {
> +               count =3D -EINVAL;

count is of type "size_t", not "ssize_t". -EINVAL is signed.
