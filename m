Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DD56BF0A3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjCQSYM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Mar 2023 14:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjCQSYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:24:08 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CEC5BD9E;
        Fri, 17 Mar 2023 11:24:06 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id eg48so23664045edb.13;
        Fri, 17 Mar 2023 11:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679077445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Bc9jy7+9Ms8bxoETlTTTT6uyflq4wF7OH0nNyODWE8=;
        b=CsmYWEz+ZsJM/T86STV+wp67RJ2wx/RIR4tW+YmNcdcmd4+i7EpD+XC4NzJ75oKHeu
         YyFO4ReZd9Cgc2JtVjr+Fl2y3oSQuoggjfGlCvYhvrcLIFNQWLc+3rXxkiUpEFws3CCg
         Biuq6CHDwLB32C5+p7Uzkwtr/nCbixzxKZ3w7RQNuUDWviyFFrZ1W6X82AYM9FsvNWnc
         rkOHgLAJ4hcCKvmBy5G/qrLeWAIq80uh+cdfT6B6OlmQMOrpWo6LKnpOseLeUyta6mEO
         hCWvCUF6VJk1zRkXA9PRCbkxVGpzYHjenkBxVlonIu4xcPwOmNBmO/RcB3BYM48z2lw1
         Addw==
X-Gm-Message-State: AO0yUKUNHRhTSoMOX9569jU7jrtnH48BRywswirf47jJrsBJxXvT3QNl
        p5ZtakXJuS8EHXEZw9nq+5vJhbhRDSu1HZKilM8icPod
X-Google-Smtp-Source: AK7set8XJyZKcaZquYSbN26agTRR5aN19d+ORi1tGUpD7PMfRgkmJt1cndaO3Q3Uf7Bj5kcdktvBCVPgMNS4gBHMof8=
X-Received: by 2002:a17:906:1b4e:b0:930:310:abcf with SMTP id
 p14-20020a1709061b4e00b009300310abcfmr165544ejg.2.1679077445063; Fri, 17 Mar
 2023 11:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230308030711.4362-1-rui.zhang@intel.com>
In-Reply-To: <20230308030711.4362-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Mar 2023 19:23:54 +0100
Message-ID: <CAJZ5v0h4G_v1VuvCFdpL_2oUmW6=ydppBZ8N5a4iR86jYkKZ0Q@mail.gmail.com>
Subject: Re: [PATCH] thermal/x86_pkg_temp_thermal: Add lower bound check for
 sysfs input
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        error27@gmail.com, srinivas.pandruvada@intel.com
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

On Wed, Mar 8, 2023 at 4:12 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> When setting a trip point temperature from sysfs, there is an upper
> bound check on the user input, but no lower bound check.
>
> As hardware register has 7 bits for a trip point temperature, the offset
> to tj_max of the input temperature must be equal to/less than 0x7f.
> Or else,
> 1. bogus temperature is updated into the trip temperature bits.
> 2. the upper bits of the register can be polluted.
>
> For example,
> $ rdmsr 0x1b2
> 2000003
> $ echo -180000 > /sys/class/thermal/thermal_zone1/trip_point_1_temp
> $ rdmsr 0x1b2
> 3980003
>
> Not only the trip point temp is set to 76C on this platform (tj_max is
> 100), the Power Notification (Bit 24) is also enabled erronously.
>
> Fix the problem by adding lower bound check for sysfs input.
>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/all/add7a378-4d50-4ba1-81d3-a0c17db25a0b@kili.mountain/
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
> Note that I didn't add a Fixes tag here because this problem always
> exists, and even the location of this file has been changed.
>
> Note that I didn't cc -stable because this patch doesn't apply to older
> kernels due to recent changes. If Rafael thinks this is a stable
> material, we can rebase this fix on previous kernel after this patch
> hits upstream.
> ---
>  drivers/thermal/intel/x86_pkg_temp_thermal.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> index 1c2de84742df..128ee02596ed 100644
> --- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> +++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> @@ -124,14 +124,16 @@ sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
>  {
>         struct zone_device *zonedev = tzd->devdata;
>         u32 l, h, mask, shift, intr;
> -       int tj_max, ret;
> +       int tj_max, val, ret;
>
>         tj_max = intel_tcc_get_tjmax(zonedev->cpu);
>         if (tj_max < 0)
>                 return tj_max;
>         tj_max *= 1000;
>
> -       if (trip >= MAX_NUMBER_OF_TRIPS || temp >= tj_max)
> +       val = (tj_max - temp)/1000;
> +
> +       if (trip >= MAX_NUMBER_OF_TRIPS || val < 0 || val > 0x7f)
>                 return -EINVAL;
>
>         ret = rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
> @@ -156,7 +158,7 @@ sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
>         if (!temp) {
>                 l &= ~intr;
>         } else {
> -               l |= (tj_max - temp)/1000 << shift;
> +               l |= val << shift;
>                 l |= intr;
>         }
>
> --

Applied as 6.4 material, thanks!
