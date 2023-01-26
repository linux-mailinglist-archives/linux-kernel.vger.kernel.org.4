Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B395F67D015
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjAZPYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjAZPYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:24:15 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AD9C64E;
        Thu, 26 Jan 2023 07:24:03 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ss4so5870230ejb.11;
        Thu, 26 Jan 2023 07:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9mQTrKO47iVy6ecofzVF7H1qY1Ps8Tg5sjQ9tgtCXwE=;
        b=gydInbp5vcpiQN63OHROrBnyPSemg9fL/5Tlx3YBwugzeh2/+eVEQnCluc4rN8N8jJ
         49OEgqBOMv4h1Hx55uirI2aPZJeeXhFGsDgiAM2Z+2jyybEdE+dJaVlr4B13Pjlrwrz2
         oh18ODRvgqr63UFGD5Lq+rb+tFrokmYEwqYze+zV8zNlbeSbawoVL+S9OmqTLOnG+SHl
         J3AYK2Am0m9A/g93jKUyFkLK7S8yOpultz5PjzdJz2D87Uax4InzkU1GhJHhBP9e5jXR
         CwWX1I0phPSUda1s/KiIT7+G98VZ+6uEGysPjjgWu6veLmieRlYu4bL0TcJpcjFJ1DqG
         Y0QQ==
X-Gm-Message-State: AFqh2krJseMRWamBaEnmQAnNj/ZjKGh/wYL+FuDE2bqkmNfJS9mMASRI
        1Y1N8ayoT93Y9D9Xlw9WATmOnI+hF2j6Q+LX+SY=
X-Google-Smtp-Source: AMrXdXtUirjeZqai26ZIG2nsvBwgblruf53rcbGBcN0jkCktmiA9ANGtQMqLxKmWo9J3NKVPxG6NUpAJVYypPh4r/EE=
X-Received: by 2002:a17:907:d10f:b0:872:be4b:1b65 with SMTP id
 uy15-20020a170907d10f00b00872be4b1b65mr5262556ejc.125.1674746339134; Thu, 26
 Jan 2023 07:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20230118181622.33335-1-daniel.lezcano@linaro.org> <20230118181622.33335-2-daniel.lezcano@linaro.org>
In-Reply-To: <20230118181622.33335-2-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Jan 2023 16:18:47 +0100
Message-ID: <CAJZ5v0hGDDemXBa0jMHeBr4sLX24WO6+AWzrnA2--knP3Kg9zQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] thermal/drivers/intel: Use generic trip points for processor_thermal_device_pci
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 7:16 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The thermal framework gives the possibility to register the trip
> points with the thermal zone. When that is done, no get_trip_* ops are
> needed and they can be removed.
>
> Convert ops content logic into generic trip points and register them with the
> thermal zone.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../processor_thermal_device_pci.c            | 53 ++++++++-----------
>  1 file changed, 22 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> index bf1b1cdfade4..c7d50862bf56 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
> @@ -144,34 +144,6 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
>         return 0;
>  }
>
> -static int sys_get_trip_temp(struct thermal_zone_device *tzd,
> -                            int trip, int *temp)
> -{
> -       struct proc_thermal_pci *pci_info = tzd->devdata;
> -       u32 _temp;
> -
> -       proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_THRES_0, &_temp);
> -       if (!_temp) {
> -               *temp = THERMAL_TEMP_INVALID;
> -       } else {
> -               int tjmax;
> -
> -               proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_TJMAX, &tjmax);
> -               _temp = tjmax - _temp;
> -               *temp = (unsigned long)_temp * 1000;
> -       }
> -
> -       return 0;
> -}
> -
> -static int sys_get_trip_type(struct thermal_zone_device *tzd, int trip,
> -                             enum thermal_trip_type *type)
> -{
> -       *type = THERMAL_TRIP_PASSIVE;
> -
> -       return 0;
> -}
> -
>  static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
>  {
>         struct proc_thermal_pci *pci_info = tzd->devdata;
> @@ -200,10 +172,26 @@ static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp
>         return 0;
>  }
>
> +static int get_trip_temp(struct proc_thermal_pci *pci_info)
> +{
> +       int temp, tjmax;
> +
> +       proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_THRES_0, &temp);
> +       if (!temp)
> +               return THERMAL_TEMP_INVALID;
> +
> +       proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_TJMAX, &tjmax);
> +       temp = (tjmax - temp) * 1000;
> +
> +       return temp;
> +}
> +
> +static struct thermal_trip psv_trip = {
> +       .type = THERMAL_TRIP_PASSIVE,
> +};
> +
>  static struct thermal_zone_device_ops tzone_ops = {
>         .get_temp = sys_get_curr_temp,
> -       .get_trip_temp = sys_get_trip_temp,
> -       .get_trip_type = sys_get_trip_type,
>         .set_trip_temp  = sys_set_trip_temp,
>  };
>
> @@ -251,7 +239,10 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
>         if (ret)
>                 goto err_ret_thermal;
>
> -       pci_info->tzone = thermal_zone_device_register("TCPU_PCI", 1, 1, pci_info,
> +       psv_trip.temperature = get_trip_temp(pci_info);
> +
> +       pci_info->tzone = thermal_zone_device_register_with_trips("TCPU_PCI", &psv_trip,
> +                                                       1, 1, pci_info,
>                                                         &tzone_ops,
>                                                         &tzone_params, 0, 0);
>         if (IS_ERR(pci_info->tzone)) {
> --

Applied as 6.3 material with edits in the subject and changelog, thanks!
