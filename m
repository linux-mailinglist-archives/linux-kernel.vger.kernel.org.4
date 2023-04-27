Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1296F0AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244151AbjD0RXz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Apr 2023 13:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244098AbjD0RXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:23:53 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A1549E1;
        Thu, 27 Apr 2023 10:23:45 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso251648166b.0;
        Thu, 27 Apr 2023 10:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682616224; x=1685208224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTP6a1svEFt7abENC6zMHAYb3w6MJh1QQije0TuLlWg=;
        b=Q//gNQB1mbsSgvZxX7ZbOHqiLYsnnT2JmOx7m3SS7o3FI2u3qCSFYyeuDukQ61AD3k
         rlZ2EEfYeqcCiGKOMrB7J0YZggtDD4wWwYV5Cncp5BJdgvVZ+MFDV5YX7OIFgL9gPD0l
         ql03LR5mmstihwA545j5p8tWC98joGOdKFQljTznkTHmcQUkgl0fGKl2DwDaVcStcYG8
         UnRXO5XRf6uKSzbG0Xo2R5MdIPlGyXrF7RgQtLr8Kku385aXKT1knPvrn9SlisRlB511
         YLodC6XET3uD41uvQUm6GsNEg8c1s/5+ofcUWH24XhMDuWQOjr0ZTbxwxBZkR98cWKpV
         o8Rw==
X-Gm-Message-State: AC+VfDwOaXYvnRLVKH9mXcY4x9kCysWreNMHyEa3WSo/UR+zFvLLiZWf
        +b15LXoIGj6AdxmOZ/d9LNRNODZ/QElcnWLUlzY=
X-Google-Smtp-Source: ACHHUZ485dQluQHN4run1SAAMDSnNxSG6T1tkQu1Rp6Zfkxp/1f927W3m4kcbh1mQ1P6tLO4gZLHu7N7D2lh42LTgf8=
X-Received: by 2002:a17:906:2211:b0:94e:d5d7:67eb with SMTP id
 s17-20020a170906221100b0094ed5d767ebmr2250405ejs.5.1682616224026; Thu, 27 Apr
 2023 10:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230419083343.505780-1-daniel.lezcano@linaro.org>
In-Reply-To: <20230419083343.505780-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Apr 2023 19:23:32 +0200
Message-ID: <CAJZ5v0jKRew48KNXXBJjENxpOhEE5jxwfAcmiuu_4nvhQL-FGA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Thermal zone device structure encapsulation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 10:33 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The thermal zone device structure is defined in the exported thermal
> header include/linux/thermal.h
>
> Given the definition being public, the structure is exposed to the
> external components other than the thermal framework core code. It
> results the drivers are tampering the structure internals like taking
> the lock or changing the field values.
>
> Obviously that is bad for several reasons as the drivers can hook the
> thermal framework behavior and makes very difficult the changes in the
> core code as external components depend on it directly.
>
> Moreover, the thermal trip points being reworked, we don't want the
> drivers to access the trips array directly in the thermal zone
> structure and doing assumptions on how they are organized.
>
> This series provides a second set of changes moving to the thermal
> zone device structure self-encapsulation.
>
> The ACPI and the Menlon drivers are using the thermal zone's device
> fields to create symlinks and new attributes in the sysfs thermal zone
> directory. These changes provide a hopefully temporary wrapper to
> access it in order to allow moving forward in the thermal zone device
> self-encapsulation and a Kconfig option to disable by default such a
> extra sysfs information.
>
> Changelog:
>         v4:
>         - Encapsulate extra sysfs information inside a function for
>           ACPI but remove the Kconfig option
>         - Encapsulate extra sysfs information inside a function,
>           create the stubs and put that conditionnal to a Kconfig
>           option for Menlow
>         v3:
>         - Split the Kconfig option to be driver related when disabling
>           the specific attributes
>         - Use the thermal zone's device wrapper to write a trace in
>           the pch intel driver
>         v2:
>         - Add the Kconfig option to remove specific attributes
>         - Add a thermal_zone_device() wrapper to access tz->device
>
> Daniel Lezcano (6):
>   thermal/core: Encapsulate tz->device field
>   thermal/drivers/intel_pch_thermal: Use thermal driver device to write
>     a trace
>   thermal/drivers/acpi: Use thermal_zone_device()
>   thermal/drivers/menlow: Use thermal_zone_device()
>   thermal/drivers/acpi: Move to dedicated function sysfs extra attr
>     creation
>   thermal/drivers/intel_menlow: Make additionnal sysfs information
>     optional
>
>  drivers/acpi/thermal.c                    | 47 +++++++++++++++--------
>  drivers/thermal/intel/Kconfig             | 11 ++++++
>  drivers/thermal/intel/intel_menlow.c      | 18 +++++++--
>  drivers/thermal/intel/intel_pch_thermal.c |  3 +-
>  drivers/thermal/thermal_core.c            |  6 +++
>  include/linux/thermal.h                   |  1 +
>  6 files changed, 67 insertions(+), 19 deletions(-)
>
> --

Patches [4/6] and [6/6] were superseded by the Menlow driver removal.

I've applied the rest as 6.4-rc material, with some subject
adjustments and after removing some trailing white space in a few
places.

Thanks!
