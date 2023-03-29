Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BAC6CDB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjC2N5l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 09:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjC2N5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:57:34 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68A3C4;
        Wed, 29 Mar 2023 06:57:33 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id h8so63678727ede.8;
        Wed, 29 Mar 2023 06:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680098252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZTShwYbvOvjgqDDpP3UxaUPOYmei9lppEGt3H4hS50=;
        b=wCamshZQFmYD9AYrFd3+Jte7qivmL52aHul/DDLBroeQ2zn8Ynje5IV5DlBssvFrdq
         uTmtChGeGUnDhY0yppHDoiApZghfr/RgczxB7QCXIaKfr1+gWJv4RC0HlheFez5G1zUS
         TY12faC2Jxf4EIuaoX7zZcJhMvRtFLWwkkRjGlrmPAuonJGrxEy9SZNZVdveK4GK2mea
         dPJjd4rQ08QBuF+88qh2Bq9vE1xt1M25/E9GcthO6Af+6FoYpmwtpk9d2kxjZQK/UFRp
         NnaW3vUz8F5hbZbT2kqeqeIyZ5JV4n8Jv35LxacHI20JSw8EdDJ/0KddGHC8MxAKqGXk
         Drfg==
X-Gm-Message-State: AAQBX9d+lMI/xvmFfqr0Vdjt4LtCgZZk/rUacJogwAZnh8WSwB9l/jHZ
        eJ8C2te0fAHtFjYgwhOpqyEfXa0EWzdoqR9HcPjPeG0n
X-Google-Smtp-Source: AKy350bEnKmbjqSz/k4Et/FQy/OslgH+xM6DAPQU/fckaEQpQZpkl+LS6GYZAeVy6aZhI+P+xpijlIE7UVh/Z7VCo4k=
X-Received: by 2002:a17:907:d48d:b0:93e:c1ab:ae67 with SMTP id
 vj13-20020a170907d48d00b0093ec1abae67mr8849591ejc.2.1680098252316; Wed, 29
 Mar 2023 06:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230329122629.3614-1-rui.zhang@intel.com>
In-Reply-To: <20230329122629.3614-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Mar 2023 15:57:21 +0200
Message-ID: <CAJZ5v0goKF1Pn8fJBcRLtbQ0cMpSKR2PS4asbNjf_XTJZG-2-w@mail.gmail.com>
Subject: Re: [PATCH v2 -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL
 pointer dereference
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 2:26 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> When the hwmon device node of a thermal zone device is not found,
> using hwmon->device causes a kernel NULL pointer dereference.
>
> Skip removing hwmon device for thermal zones without hwmon device, and
> fix the kernel NULL pointer dereference when hwmon device is not found.
>
> Fixes: dec07d399cc8 ("thermal: Don't use 'device' internal thermal zone structure field")
> Reported-by: Preble Adam C <adam.c.preble@intel.com>

Do you have a link to the bug report?  I'm wondering where exactly it triggers.

> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
> v1 -> v2
>    Add check for devices without hwmon device.
>    Use pr_debug instead of dev_dbg.
> ---
>  drivers/thermal/thermal_hwmon.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> index c59db17dddd6..1cdee2ee8d4d 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -226,10 +226,12 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
>         struct thermal_hwmon_device *hwmon;
>         struct thermal_hwmon_temp *temp;
>
> +       if (tz->tzp && tz->tzp->no_hwmon)
> +               return;
> +
>         hwmon = thermal_hwmon_lookup_by_type(tz);
>         if (unlikely(!hwmon)) {
> -               /* Should never happen... */
> -               dev_dbg(hwmon->device, "hwmon device lookup failed!\n");
> +               pr_debug("hwmon device lookup failed!\n");
>                 return;
>         }
>
> --
