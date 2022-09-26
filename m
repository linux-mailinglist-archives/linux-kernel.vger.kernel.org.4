Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF875EB14B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiIZT2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiIZT2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:28:12 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5BC5AC47;
        Mon, 26 Sep 2022 12:28:11 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id i17so1789257qkk.12;
        Mon, 26 Sep 2022 12:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5Y3qxibv8l/fmxXFEFy17abcwdGsCVgDmmM76oi7nSE=;
        b=Taj7mhtuGddrPjZ57L+BWeKA9jh5eim15erKp3/PtsJC4cxVRvkF36ulI9igS9rlqs
         CPm5R6wWqOCDNVgOqytkqH7ScYqkjSv479W5wcURCvc6ZrSQ2P+Q2DXyBFzjeeHPXK4z
         TDI+HEc1oBnS1Eitmaw6k5X3KANYS4tOAh+Qg0UYGcbQboFsDy4W9pWc3l6qgSmz5ngB
         Gg5wsa14h8g4A1Aq8YLcxM5/9hFqtjxJUI43qq3Ir8th9NYsAGqW6bPi/PO0xupCSvvz
         jgATWzdoTb70wfShJHs7mMZWrVvSJGL95fnUT9tmNZBgCdQ+j8sEqjRSTjfgN61E2bJs
         iKFQ==
X-Gm-Message-State: ACrzQf23WkMPgX0Nx58jbfpxaNb+ubbtHevtXcyg0VEk8WgT+7gYxDBD
        Jz0DWGJ+9CyEn1yGGNeBCZVFQh1zjAVH/RcT8ZQ=
X-Google-Smtp-Source: AMsMyM7aJS+cDG8PTFrMvt/VueGDSzTBjRTPiJ5oZptGGfej3myZTddQZ91kU6alv5Ub85Dz95ct0JET4L9EjOxIhtU=
X-Received: by 2002:a05:620a:290d:b0:6b6:1a92:d88a with SMTP id
 m13-20020a05620a290d00b006b61a92d88amr15599970qkp.58.1664220490587; Mon, 26
 Sep 2022 12:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org> <20220926140604.4173723-5-daniel.lezcano@linaro.org>
In-Reply-To: <20220926140604.4173723-5-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Sep 2022 21:27:59 +0200
Message-ID: <CAJZ5v0j_OcdN3ybT5-Y5G+bH=4COdNWQGD+L5KdLjC-cBPW6Jg@mail.gmail.com>
Subject: Re: [PATCH v5 04/30] thermal/core: Add a generic thermal_zone_get_crit_temp()
 function
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 4:06 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The thermal zone ops defines a callback to retrieve the critical
> temperature. As the trip handling is being reworked, all the trip
> points will be the same whatever the driver and consequently finding
> the critical trip temperature will be just a loop to search for a
> critical trip point type.
>
> Provide such a generic function, so we encapsulate the ops
> get_crit_temp() which can be removed when all the backend drivers are
> using the generic trip points handling.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  include/linux/thermal.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 5350a437f245..66373f872237 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -343,6 +343,8 @@ int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
>
>  int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
>
> +int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
> +

Well, this only adds a function header which by itself is not
particularly useful (and the code change doesn't match the changelog
even), so I would fold it into the patch that actually adds the
function, including its body.

>  #ifdef CONFIG_THERMAL
>  struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
>                 void *, struct thermal_zone_device_ops *,
> --
> 2.34.1
>
