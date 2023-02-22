Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C3B69FC14
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjBVT0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjBVT0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:26:33 -0500
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1347242BE4;
        Wed, 22 Feb 2023 11:26:03 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id da10so36028786edb.3;
        Wed, 22 Feb 2023 11:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bz5zQmNEJOPn/0yWwN4USNlcxHE8XLHZBv89fxLsYN8=;
        b=Nm6f7MLUbi4j1obgWOb9C1+O4PW/tvzrXGpGZXT6RV538BFfNazRe0j8RjcShJZPlx
         1XIy6LPEMwxjzk7WWTq00/ZF0u4Np6llcQb+ySPb/I4q/6TfU4ln5HYuO833fmj7/HFy
         9zQp12KKaHzc/rJ6PW4SvBKmYYhujcSLxjYk9bYFRkPe1cjlhP0LuRp2YOLG+s/oYDa3
         E6Eo3Jgsyv4Ftzei8KVTmVlsoH9Y16KU1ZEIMU51ZzdupmozLdZL7ne2mxkycWbw2ZRT
         2XRhFHcEyRwEQtiJRJzTjRY0p1gXJDc0+x4GG8wBzNLtQDDfvaHYn0sIYnusFjjWjEti
         YHPw==
X-Gm-Message-State: AO0yUKXq1AHYY3ovaj9yhMuvUOwdGOm9ifz/MtIFgRwaSLkm8uyKhA3m
        5Ou/ieMwJU/B/YGHYtpyAl2JrBb5N/4f128ZmvM=
X-Google-Smtp-Source: AK7set9gVkZNKE8FvPoiKyd9mGRwCw7KlpgXOBcbuvNaECyMSEiDdMXuJQRALNPSEMoadF9vtnOSrX7/lwVL18jGSnM=
X-Received: by 2002:a17:906:9251:b0:8ce:cb8f:3747 with SMTP id
 c17-20020a170906925100b008cecb8f3747mr5467513ejx.5.1677093940107; Wed, 22 Feb
 2023 11:25:40 -0800 (PST)
MIME-Version: 1.0
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org> <20230221180710.2781027-3-daniel.lezcano@linaro.org>
In-Reply-To: <20230221180710.2781027-3-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Feb 2023 20:25:29 +0100
Message-ID: <CAJZ5v0hSfXY3MnShyUdjT7FKot0eiYW1DhCQytTPOazYxSL8Mw@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] thermal/core: Show a debug message when
 get_temp() fails
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
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

On Tue, Feb 21, 2023 at 7:07 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The different thermal drivers are showing an error in case the
> get_temp() fails. Actually no traces should be displayed in the
> backend ops but in the call site of this ops.
>
> Furthermore, the message is often a dev_dbg message where the
> tz->device is used, thus using the internal of the structure from the
> driver.
>
> Show a debug message if the thermal_zone_get_temp() fails to read the
> sensor temperature, so code showing the message is factored out and
> the tz->device accesss is in the scope of the thermal core framework.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/thermal/thermal_helpers.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> index 0f648131b0b5..9558339f5633 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -107,6 +107,9 @@ int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>                         *temp = tz->emul_temperature;
>         }
>
> +       if (ret)
> +               dev_dbg(&tz->device, "Failed to get temperature: %d\n", ret);
> +
>         return ret;
>  }
>
> --
> 2.34.1
>
