Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F260696769
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbjBNOyF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Feb 2023 09:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBNOyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:54:03 -0500
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD4F1724;
        Tue, 14 Feb 2023 06:54:02 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id dz21so5730081edb.13;
        Tue, 14 Feb 2023 06:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fquT604O2VKG0dy0dPb5euckKeSoIjzvnpt9mbYzgo=;
        b=Fk4Ikyo24Menx9ZptnnqTHaO4rQ3XyunoDPPndBpMGR3oFgbjif4u8rr/9o05diuhP
         zWxGyIoj7COhC2zV215sJVcPRvRppIZSg+G1q4wEsPux9VCdfh1VDgfqlrqYrtMLCcIX
         VHep2tCUlAHv9kPqlYogI4c+++tYnl14rPlItrCpgUd+HZvdNjBIp3ECeiiKRkmFl2Lt
         Zy7FuSRjPGih7GZ5lz+p/E/KqTN2CnwoJnfMUQ8UoG+hd/ncmhhOrjxaU6WsDtkRXT/a
         7D01qybEpi80bRM5nkuzXYrBeOkttL8z75kZESLcEqpnf86e6frHov5D5SKdQJMcbVrh
         6PwQ==
X-Gm-Message-State: AO0yUKWKkrnuOVp2OlndRxA7GJP0XXYWDoaw01nrx5Nr05/mAO8vgFRE
        e74gItK9UC/BD84uK0lhi3ynYKD9OdxXOQ3wN+M=
X-Google-Smtp-Source: AK7set8buxZQw0XjmI6afN7MQchlfI8N6hS4XFRBsgIr/41nEv3IJGONREA4D7ADzqoX4aYAor1i6DSlYBzhpFR/+o8=
X-Received: by 2002:a50:bace:0:b0:4ac:ce81:9c1d with SMTP id
 x72-20020a50bace000000b004acce819c1dmr1108530ede.0.1676386441268; Tue, 14 Feb
 2023 06:54:01 -0800 (PST)
MIME-Version: 1.0
References: <20230214-kobj_type-acpi-v1-1-6dbe3840208b@weissschuh.net>
In-Reply-To: <20230214-kobj_type-acpi-v1-1-6dbe3840208b@weissschuh.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Feb 2023 15:53:50 +0100
Message-ID: <CAJZ5v0g8UABDmB_ywGGbfMHcW_X7w7wnMi=42=yfPBh71z0J2Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: make kobj_type structures constant
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 4:23 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
>
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
>
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
>
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  drivers/acpi/cppc_acpi.c    | 2 +-
>  drivers/acpi/device_sysfs.c | 2 +-
>  drivers/acpi/sysfs.c        | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 0f17b1c32718..a8f58b32d66f 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -193,7 +193,7 @@ static struct attribute *cppc_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(cppc);
>
> -static struct kobj_type cppc_ktype = {
> +static const struct kobj_type cppc_ktype = {
>         .sysfs_ops = &kobj_sysfs_ops,
>         .default_groups = cppc_groups,
>  };
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 120873dad2cc..c3aa15571f16 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -78,7 +78,7 @@ static void acpi_data_node_release(struct kobject *kobj)
>         complete(&dn->kobj_done);
>  }
>
> -static struct kobj_type acpi_data_node_ktype = {
> +static const struct kobj_type acpi_data_node_ktype = {
>         .sysfs_ops = &acpi_data_node_sysfs_ops,
>         .default_groups = acpi_data_node_default_groups,
>         .release = acpi_data_node_release,
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 7db3b530279b..7f4ff56c9d42 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -953,7 +953,7 @@ static struct attribute *hotplug_profile_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(hotplug_profile);
>
> -static struct kobj_type acpi_hotplug_profile_ktype = {
> +static const struct kobj_type acpi_hotplug_profile_ktype = {
>         .sysfs_ops = &kobj_sysfs_ops,
>         .default_groups = hotplug_profile_groups,
>  };
>
> ---

Applied as 6.3 material, thanks!
