Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF3B675AE4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjATROb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjATROa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:14:30 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29656E411;
        Fri, 20 Jan 2023 09:14:28 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id az20so15674272ejc.1;
        Fri, 20 Jan 2023 09:14:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HOaUAYhm739LoNFEJwmqRC1Dhxspe+wjZsqJfwkoM7Q=;
        b=mayddFjhAucy5y15jD4XpdeMqOvx8Il/dPMaKs/EZz4i8N7AFc4o+T0NQl7v+mrNQ/
         T50ITByT1O7KksygLzUBZiecnJukpRnEWAaMG9B9NpZA6cdty05rf5KXzW068BPI6N0q
         e8MuCCb+XAtgbyPmjYNIzwInTePieidsOq8ipQerrLoILJeUx/YFFKzpba7c127eGSLk
         H90GNw+RMLolunHcznRJRdYXJZCObBfYvNBPRh8H/t2V5vXIp6c4TZNIGWEMyEn0Ufzs
         4Ljwi1ZQhjso8P83m+n1uGsxDvUu78Bgi8STs1rgAEsRSj/tJV7JjnBf/olQNooIHlsQ
         GCfw==
X-Gm-Message-State: AFqh2koLmxwYFNZHee1wfXUU2uqDI0VRSiWBjHnfuaOShczwNKN47vSp
        psMeCdmhPXjk6Y+t1ioXJYjUfvHFbw41x2sp/J0=
X-Google-Smtp-Source: AMrXdXvnDOyGsZ09syGHfLiZisD0Bdt63oUoqu6Hmdfuvdn9Cna9guZOnaJwKjQV5wGwSl1wMskGiMmlJV6JkkK3y8Q=
X-Received: by 2002:a17:906:92c8:b0:877:8b1c:fd7c with SMTP id
 d8-20020a17090692c800b008778b1cfd7cmr581423ejx.67.1674234867333; Fri, 20 Jan
 2023 09:14:27 -0800 (PST)
MIME-Version: 1.0
References: <20230117165029.2782484-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230117165029.2782484-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 18:14:16 +0100
Message-ID: <CAJZ5v0jERF3Ehow=UgpWYrtnxDixXmJYsN1TK7C6y=pLg7ZxPw@mail.gmail.com>
Subject: Re: [PATCH] thermal: int340x_thermal: Add production mode attribute
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 5:50 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> It is possible that system manufacturer locks further thermal tuning. In
> this case user space calibration tools should not try to adjust thermal
> configuration.
>
> Add an attribute "production_mode". This attribute is only present when
> the ACPI DCFG method is present under INT3400 device scope.

I would rewrite the above in the following way:

"It is possible that the system manufacturer locks down thermal tuning
beyond what is usually done on the given platform.  In that case user
space calibration tools should not try to adjust the thermal
configuration of the system.

To allow user space to check if that is the case, add a new sysfs
attribute "production_mode" that will be present when the ACPI DCFG
method is present under the INT3400 device object in the ACPI Namespace."

> When DCFG evaluates to non 0, user space configuration tools should exit.

It is not clear what exactly "should exit" means here.

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../driver-api/thermal/intel_dptf.rst         |  4 ++
>  .../intel/int340x_thermal/int3400_thermal.c   | 48 +++++++++++++++++++
>  2 files changed, 52 insertions(+)
>
> diff --git a/Documentation/driver-api/thermal/intel_dptf.rst b/Documentation/driver-api/thermal/intel_dptf.rst
> index 372bdb4d04c6..9a7b651ba764 100644
> --- a/Documentation/driver-api/thermal/intel_dptf.rst
> +++ b/Documentation/driver-api/thermal/intel_dptf.rst
> @@ -84,6 +84,10 @@ DPTF ACPI Drivers interface
>         https:/github.com/intel/thermal_daemon for decoding
>         thermal table.
>
> +``production_mode`` (RO)
> +       When non zero, manufacturer locked thermal configuration from

It would be slightly better to say "When different from zero, ..." IMO.

> +       further changes.
> +
>
>  ACPI Thermal Relationship table interface
>  ------------------------------------------
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index db8a6f63657d..ec5ec07ccf41 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -60,6 +60,8 @@ struct int3400_thermal_priv {
>         int odvp_count;
>         int *odvp;
>         u32 os_uuid_mask;
> +       int production_mode;
> +       bool production_mode_support;

A negative value could be used as a "no support" indicator, so the
bool field wouldn't be necessary.

>         struct odvp_attr *odvp_attrs;
>  };
>
> @@ -315,6 +317,43 @@ static int int3400_thermal_get_uuids(struct int3400_thermal_priv *priv)
>         return result;
>  }
>
> +static ssize_t production_mode_show(struct device *dev, struct device_attribute *attr,
> +                                    char *buf)
> +{
> +       struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
> +
> +       return sprintf(buf, "%d\n", priv->production_mode);

sysfs_emit() ?

> +}
> +
> +static DEVICE_ATTR_RO(production_mode);
> +
> +static int production_mode_init(struct int3400_thermal_priv *priv)
> +{
> +       unsigned long long mode;
> +       acpi_status status;
> +       int ret;
> +
> +       status = acpi_evaluate_integer(priv->adev->handle, "DCFG", NULL, &mode);
> +       /* If the method is not present, this is not an error */
> +       if (ACPI_FAILURE(status))
> +               return 0;
> +
> +       ret = sysfs_create_file(&priv->pdev->dev.kobj, &dev_attr_production_mode.attr);
> +       if (ret)
> +               return ret;
> +
> +       priv->production_mode_support = true;
> +       priv->production_mode = mode;
> +
> +       return 0;
> +}
> +
> +void production_mode_exit(struct int3400_thermal_priv *priv)
> +{
> +       if (priv->production_mode_support)
> +               sysfs_remove_file(&priv->pdev->dev.kobj, &dev_attr_production_mode.attr);
> +}
> +
>  static ssize_t odvp_show(struct device *dev, struct device_attribute *attr,
>                          char *buf)
>  {
> @@ -610,8 +649,15 @@ static int int3400_thermal_probe(struct platform_device *pdev)
>         if (result)
>                 goto free_sysfs;
>
> +       result = production_mode_init(priv);
> +       if (result)
> +               goto free_notify;
> +
>         return 0;
>
> +free_notify:
> +       acpi_remove_notify_handler(priv->adev->handle, ACPI_DEVICE_NOTIFY,
> +                                  int3400_notify);
>  free_sysfs:
>         cleanup_odvp(priv);
>         if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
> @@ -638,6 +684,8 @@ static int int3400_thermal_remove(struct platform_device *pdev)
>  {
>         struct int3400_thermal_priv *priv = platform_get_drvdata(pdev);
>
> +       production_mode_exit(priv);
> +
>         acpi_remove_notify_handler(
>                         priv->adev->handle, ACPI_DEVICE_NOTIFY,
>                         int3400_notify);
> --
