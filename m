Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4624768341F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjAaRnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjAaRnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:43:42 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB996582B0;
        Tue, 31 Jan 2023 09:43:23 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id z25-20020a4ad1b9000000b00517affa07c0so300200oor.7;
        Tue, 31 Jan 2023 09:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/8bGXJKT+ieOfI6c5+Z+pFLGLuruZbcv9kpibt6A2mI=;
        b=Xd/YsxlgdykLM3Zm6dMvsNVYJibOxMynYY13SM3lTeXiWAxaBLnOOIeE7HjdDmVHZc
         8n2AL2KaSVc5xQhKLCXZ+IE6NFq8yEv5yA3UKpuUi3gYr9grTK8OISWHlVlKFqx9DGs9
         2Nq6FrIOPxi7seQokXAjYRjsM2KO3cE1XdVkYfHZeDBgkQ6Eoi4mbvcxA561AQYJGNH7
         GEusrqQVzTMCDAMtFJLxJo7D0Vp2UWFTmxh9cQyQCRbkHWb987S25qPquVsOwnnrO4mw
         NrFjUqqwPcOVoLSOmZJmpIwmRyFJwpbmHCENZJoPbuoyeFPgysmgAC/IrbQWwbmvOIbH
         NM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8bGXJKT+ieOfI6c5+Z+pFLGLuruZbcv9kpibt6A2mI=;
        b=bU0RDOrVNT1FQnzDG/fAsBjXgTlwXgJ8Yfjud+RwDMPw+1fSqySz8zc3LQ1XZk5DyS
         p9KXTKBfPearYh17tr6TVMwBG9MqTpm1i3IClPLaPSIdRy46Dwi5evNMu6kXs5R6mP0d
         KYV379+yEtxSxGdFwae/kGriZ7Xz9DXaufxinEGbV9yQQPJrDVrlrl0LjhVUQXqkv2Xs
         PMIRNTjpauY363yXkoPNyDaCoVV1Kdzhk6pf9qJZ4XhTGyWOUKudkS+Erl6kWaeJ5YAK
         9z19gi2UXv8y/axFe4M8865Is1b4U+YQ5Hsc5oSPybvwT3uXYRRNYljxouWeosPuIFkp
         FJ7g==
X-Gm-Message-State: AO0yUKX0V9pyb4m1y4ZxPOWZJNUc9w56qCuVrMjFyEOXSr5lQQi7t+DZ
        lDWWFF0FeBFJp2mUlC+KSCfjGOAs4j0=
X-Google-Smtp-Source: AK7set8KGPFQwOLFCtoCYackv7kJwNnzEryrd/8pL7wuQFoIlYZTuAo66nz4MPTqoZl1NKYu1/GX/A==
X-Received: by 2002:a4a:e395:0:b0:517:b183:24aa with SMTP id l21-20020a4ae395000000b00517b18324aamr1545880oov.9.1675187003180;
        Tue, 31 Jan 2023 09:43:23 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e12-20020a4aaacc000000b005177543fafdsm2798716oon.40.2023.01.31.09.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 09:43:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Jan 2023 09:43:21 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH v2 1/2] watchdog: report fw_version in sysfs
Message-ID: <20230131174321.GA3602958@roeck-us.net>
References: <20221216-watchdog-sysfs-v2-0-6189311103a9@weissschuh.net>
 <20221216-watchdog-sysfs-v2-1-6189311103a9@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221216-watchdog-sysfs-v2-1-6189311103a9@weissschuh.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 09:30:39PM +0000, Thomas Weiﬂschuh wrote:
> This synchronizes the information reported by ioctl and sysfs.
> The mismatch is confusing because "wdctl" from util-linux uses the ioctl
> when used with root privileges and sysfs without.
> 
> The file is called "fw_version" instead of "firmware_version" as
> "firmware_version" is already used as custom attribute by single drivers.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/ABI/testing/sysfs-class-watchdog |  7 +++++++
>  drivers/watchdog/watchdog_dev.c                | 10 ++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-watchdog b/Documentation/ABI/testing/sysfs-class-watchdog
> index 585caecda3a5..27c000238fe4 100644
> --- a/Documentation/ABI/testing/sysfs-class-watchdog
> +++ b/Documentation/ABI/testing/sysfs-class-watchdog
> @@ -6,6 +6,13 @@ Description:
>  		device at boot. It is equivalent to WDIOC_GETBOOTSTATUS of
>  		ioctl interface.
>  
> +What:		/sys/class/watchdog/watchdogn/fw_version
> +Date:		April 2023
> +Contact:	Thomas Weiﬂschuh
> +Description:
> +		It is a read only file. It contains firmware version of
> +		watchdog device.
> +
>  What:		/sys/class/watchdog/watchdogn/identity
>  Date:		August 2015
>  Contact:	Wim Van Sebroeck <wim@iguana.be>
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 55574ed42504..7feeda02a531 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -546,6 +546,15 @@ static ssize_t pretimeout_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(pretimeout);
>  
> +static ssize_t fw_version_show(struct device *dev, struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct watchdog_device *wdd = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", wdd->info->firmware_version);
> +}
> +static DEVICE_ATTR_RO(fw_version);
> +
>  static ssize_t identity_show(struct device *dev, struct device_attribute *attr,
>  				char *buf)
>  {
> @@ -617,6 +626,7 @@ static umode_t wdt_is_visible(struct kobject *kobj, struct attribute *attr,
>  }
>  static struct attribute *wdt_attrs[] = {
>  	&dev_attr_state.attr,
> +	&dev_attr_fw_version.attr,
>  	&dev_attr_identity.attr,
>  	&dev_attr_timeout.attr,
>  	&dev_attr_min_timeout.attr,
