Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CEA6DE3C1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDKSUB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 14:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDKSTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:19:53 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF8B4C37;
        Tue, 11 Apr 2023 11:19:51 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so656770a12.1;
        Tue, 11 Apr 2023 11:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681237190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRFhel4vItei7jcN1xlLMvb+yM33VbvdduIMfttiDjw=;
        b=h/gdDBrHU9yMtb38KXgn1j8HC5UUu9X8lArfue2KefL6dDhTFtMFNc/T4XnDf/ILhE
         nfcLCGhTxysHXSklwLZQAgyknvwBmIJ26bHKhtDqWqxXu28PHNg1Qnxo8/LKbkIjhZi1
         BQkDc+kJnx99v7E1ItfNvu6t5FZvby1vZsFw3KGv5IFnzHtapHhjKTajOCdfHQiRiNMi
         Ama/WHuXW+VF9zhh1nWEJtxPmgIZofD+UrBjubWA9Fvok5ozs3O7xG1Y93O1QXB3qT4J
         q21yTKue0EKapjZ6sDK6bFqAhpzIe7Pu2MOKwymbKL/+vR3Q0elK+rF5n2b1s1HbJLll
         qW5w==
X-Gm-Message-State: AAQBX9dBDCXll4TY9a1Yu9ZAEm1zIXwt4jPJu2SPcd7EAJZ0ZiK5/00u
        LShVTbNPkCBo6V8KBbXM6kQU/QCG9MlmFnmalM4=
X-Google-Smtp-Source: AKy350ajKXXZ83vvFNPQgzdQ1A+7MWTUTMxNwAASKo1/EsmCjDpqcwjCVOxmtof6xZsZugY6FUKkyZ1BNljgFOtMMgc=
X-Received: by 2002:a05:6402:550b:b0:4fb:e069:77ac with SMTP id
 fi11-20020a056402550b00b004fbe06977acmr104613edb.0.1681237189537; Tue, 11 Apr
 2023 11:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230410205305.1649678-1-daniel.lezcano@linaro.org> <20230410205305.1649678-3-daniel.lezcano@linaro.org>
In-Reply-To: <20230410205305.1649678-3-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Apr 2023 20:19:38 +0200
Message-ID: <CAJZ5v0jysxvCZ2-dXfqfiJfpZGOYwgMwk1kEuiGOQjV3LK4gMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] thermal/core: Encapsulate tz->device field
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
> There are still some drivers needing to play with the thermal zone
> device internals. That is not the best but until we can figure out if
> the information is really needed, let's encapsulate the field used in
> the thermal zone device structure, so we can move forward relocating
> the thermal zone device structure definition in the thermal framework
> private headers.

I'm not really sure why this is needed, so please explain.


> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 6 ++++++
>  include/linux/thermal.h        | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index c5025aca22ee..842f678c1c3e 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1398,6 +1398,12 @@ int thermal_zone_device_id(struct thermal_zone_device *tzd)
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_device_id);
>
> +struct device *thermal_zone_device(struct thermal_zone_device *tzd)
> +{
> +       return &tzd->device;
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_device);
> +
>  /**
>   * thermal_zone_device_unregister - removes the registered thermal zone device
>   * @tz: the thermal zone device to remove
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 82ddb32f9876..87837094d549 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -313,6 +313,7 @@ thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int
>  void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
>  const char *thermal_zone_device_type(struct thermal_zone_device *tzd);
>  int thermal_zone_device_id(struct thermal_zone_device *tzd);
> +struct device *thermal_zone_device(struct thermal_zone_device *tzd);
>
>  int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
>                                      struct thermal_cooling_device *,
> --
> 2.34.1
>
