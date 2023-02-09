Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F456911DC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 21:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjBIUGD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Feb 2023 15:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjBIUFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 15:05:39 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEBD6BD05;
        Thu,  9 Feb 2023 12:05:15 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id hx15so9807174ejc.11;
        Thu, 09 Feb 2023 12:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YwKmOC/1iNnr0DmWAffUNXKTx8ePFRW+osHEjGSodU=;
        b=TMtOVqVIKp4/zkyb7ye0ky/p4LOvLSSpmeESDoyhnMJWK35FIyA9nYlQuAV4DcMnrm
         J9lLzXkuTqQPIGirridRnfZeOMdB7gK3NL48B2lb+KjVY1GH60bZbTn4zoTWg67HBg+O
         Vk9L9t8eRa+IODTmRMfTSpMA+IOke+y3KaeHs+JUq06mbVezsAYcwbwdzaOmBdqV/ITs
         cFPxf4sVjscHEZ+HWOJm/EgAMtYtylzHDr3nepyu/MiPM5uO1WDCFqd5XtIzwS1yZ3ua
         8YZestcVUDmjjYSRRr686c86V7zqgxtC8Lp8O06IPY7IHFF/iLB/47ifMXDy9TI2uyaX
         9QJA==
X-Gm-Message-State: AO0yUKWxlA+f4j3tZy3t5EoBeTF0U+TKGKQoPi9vb80QATmgm/BeO2ze
        j0mRsy2Hk4JzdhYjxLUL4sV5ejgB8KtffOKedOU=
X-Google-Smtp-Source: AK7set/8TFoqEzL8RPv/QQq1r9K94XIwITHESNPDV+aNHvkoh00W6tKeUB7AoLVCTUSjJsvxYD+E6iizgARR7zix/TU=
X-Received: by 2002:a17:906:ce2e:b0:87f:575a:9b67 with SMTP id
 sd14-20020a170906ce2e00b0087f575a9b67mr2962490ejb.274.1675973113416; Thu, 09
 Feb 2023 12:05:13 -0800 (PST)
MIME-Version: 1.0
References: <20230207-kobj_type-cpuidle-v1-1-2ef73398283f@weissschuh.net>
In-Reply-To: <20230207-kobj_type-cpuidle-v1-1-2ef73398283f@weissschuh.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Feb 2023 21:05:02 +0100
Message-ID: <CAJZ5v0jBXhX-kASfd_rUaCANpeac=ntbFV=_8XLH-L7FN9nGUg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: sysfs: make kobj_type structures constant
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 8:55 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
>
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
>
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
>
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  drivers/cpuidle/sysfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index 2b496a53cbca..48948b171749 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -200,7 +200,7 @@ static void cpuidle_sysfs_release(struct kobject *kobj)
>         complete(&kdev->kobj_unregister);
>  }
>
> -static struct kobj_type ktype_cpuidle = {
> +static const struct kobj_type ktype_cpuidle = {
>         .sysfs_ops = &cpuidle_sysfs_ops,
>         .release = cpuidle_sysfs_release,
>  };
> @@ -447,7 +447,7 @@ static void cpuidle_state_sysfs_release(struct kobject *kobj)
>         complete(&state_obj->kobj_unregister);
>  }
>
> -static struct kobj_type ktype_state_cpuidle = {
> +static const struct kobj_type ktype_state_cpuidle = {
>         .sysfs_ops = &cpuidle_state_sysfs_ops,
>         .default_groups = cpuidle_state_default_groups,
>         .release = cpuidle_state_sysfs_release,
> @@ -594,7 +594,7 @@ static struct attribute *cpuidle_driver_default_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(cpuidle_driver_default);
>
> -static struct kobj_type ktype_driver_cpuidle = {
> +static const struct kobj_type ktype_driver_cpuidle = {
>         .sysfs_ops = &cpuidle_driver_sysfs_ops,
>         .default_groups = cpuidle_driver_default_groups,
>         .release = cpuidle_driver_sysfs_release,
>
> ---

Applied as 6.3 material, thanks!
