Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EA96DE3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjDKSX3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 14:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDKSX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:23:28 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D40746BB;
        Tue, 11 Apr 2023 11:23:27 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-947abd74b10so460874066b.2;
        Tue, 11 Apr 2023 11:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681237406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9I88KzYwTfgVOVqx5a6cLuDweAMKwPiePasaGOIA6lM=;
        b=6JRDkrkvkk9ccBd/OcR5ogEZRgHoU5ZRGAmUsBbUGry/PdxnDbbnoA4jzDTstdOU+N
         pMUf4KhjaQ0gG+kKlmBaynFGokKy4AskBvUINQtTfiKihY8ygrD/ZFTNsxrqcg0jZumI
         Lc+fa1rkKolKfNMqJsgLPU7ePNe3e74kOx+EHDjhP6rrSCqfcvmMK4x835FnmqQKCssK
         PYAVfKXI8BQBW6nj5C7aCPa0h1V4R/AEDo+7rKem1l9Saa4HYARKx+GW1YqrCf0tPCXH
         aaxsMIQ+qyVMhYbVRmilmejbGSCqbRe6bFhLWCzS8bMySw25tn+L7DZyNnWy6qJCgfCO
         9WBw==
X-Gm-Message-State: AAQBX9epto7ir9XYqFnpCSx+Uff2+tEwvO0Pk91z1sgKH86K3iBfvlQG
        B5CHpodUsjzZ+6FjaScNQ9lHnV6asepSO1bGGYc=
X-Google-Smtp-Source: AKy350bFx8QHLSD/DS4PKiAulmtCxS/55SK4IcirOWqY0s0FsUjPWKuZEaRzMiJ9Bl0ymLA2tMOt1hwxsRXWMYbW6HA=
X-Received: by 2002:a50:9ee9:0:b0:504:efc0:9f97 with SMTP id
 a96-20020a509ee9000000b00504efc09f97mr35595edf.3.1681237405932; Tue, 11 Apr
 2023 11:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230410205305.1649678-1-daniel.lezcano@linaro.org> <20230410205305.1649678-6-daniel.lezcano@linaro.org>
In-Reply-To: <20230410205305.1649678-6-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Apr 2023 20:23:14 +0200
Message-ID: <CAJZ5v0iOPsQKrnK3UsR+9vLhTf2jysTAEJD+71aeyfT8Gy1R1Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] thermal/core: Prepare sanitizing thermal class
 sysfs content
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
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

On Mon, Apr 10, 2023 at 10:53 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Some drivers are accessing the thermal zone device structure to create
> specific entries in /sys/class/thermal regardless the documentation.
>
> It is questionable as the specific information should be in the
> driver's sysfs directory, not the framework it is dealing with.
>
> It has been long time these specific attributes were added in the
> thermal sysfs directory and are limited to the ACPI thermal driver and
> the Menlon driver.
>
> It is probable those are not really needed, so in order to figure out
> if that is the case, let's create a default option disabling the
> attribute in order to prepare a definitive removal.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/Kconfig | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 4cd7ab707315..cca4e5cf6f30 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -33,6 +33,18 @@ config THERMAL_STATISTICS
>
>           If in doubt, say N.
>
> +config THERMAL_SYSFS_OBSOLETE_SINGULARITY
> +       bool "Enable obsolete and undocumented sysfs extra information"

I was talking about making an extra Kconfig option in the Menlow
driver to make the extra sysfs stuff depend on.

Throwing ACPI in the same bucket is a non-starter.

> +       def_bool n
> +       help
> +         Enable sysfs extra information added in the thermal zone and
> +         the driver specific sysfs directories. That could be a link
> +         to the associated thermal zone as well as a link pointing to
> +         the device from the thermal zone. By default those are
> +         disabled and are candidate for removal, if you need these
> +         information anyway, enable the option or upgrade the
> +         userspace program using them.
> +
>  config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
>         int "Emergency poweroff delay in milli-seconds"
>         default 0
> --
> 2.34.1
>
