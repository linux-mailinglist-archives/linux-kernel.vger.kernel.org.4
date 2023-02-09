Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5378B690ED7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjBIRHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBIRHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:07:00 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7D02943E;
        Thu,  9 Feb 2023 09:06:57 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id rp23so8339693ejb.7;
        Thu, 09 Feb 2023 09:06:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8VHFGKaLeh3cYqrzInF4usbI5I5QnVDbyKaNdVm2lg=;
        b=NVzHdFCa8wfpZKy7IqlQXZiqRJFB24fQYU7IJUnbFKQIea6RiIozsnm0LvMJS+68U0
         ++0Z2m8rBHZkDq0bp/ZYw/P9ka5lpwc75VHRgYygQUFtcQkk67ZHp1y/nlRS34CgS/zP
         ow4pm0X/tc7FzkoN9e0JpkJXhpj2Uo9Dgu8f1oKRA2h1UxcypvTFzJd3HY93vv4EPRvw
         y1fGVbevFTN1Tfjk6a1wA5qjTBGykP/wOCu+4xpa66JP6QYLVon9gZrHscYKgvDT8PnR
         D+i6cxep10KjaFP/hhW5Xmu9ZblaoFC1Dlf05RfvIw9N7mncyJfll0FeiU4Mis5MJmWV
         p8Mw==
X-Gm-Message-State: AO0yUKXTmFIbLuy/0rpyJgRSRKy56CmnGgF2Jx/YQSnd+tjz5CAt1fGw
        xIpKaK3nx5ht0LbQk5C2vkLZTnCcpEcCPKJwZnk=
X-Google-Smtp-Source: AK7set+4StgcSJCsQLbtg4LUf87wPyzX8QRiqSdKMMXxY3XgpMGt/5mW9xQjdq7nMDfhVZsecUgxGq34WDi+9ZtDXIo=
X-Received: by 2002:a17:906:ce2e:b0:87f:575a:9b67 with SMTP id
 sd14-20020a170906ce2e00b0087f575a9b67mr2846836ejb.274.1675962416181; Thu, 09
 Feb 2023 09:06:56 -0800 (PST)
MIME-Version: 1.0
References: <20230202013140.30416-1-rui.zhang@intel.com>
In-Reply-To: <20230202013140.30416-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Feb 2023 18:06:44 +0100
Message-ID: <CAJZ5v0gtCffDTVi-SoQ0KanPiSZUS3gONX7a-ZHAXQRr97H-EA@mail.gmail.com>
Subject: Re: [PATCH] powercap/intel_rapl: Fix handling for large time window
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
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

On Thu, Feb 2, 2023 at 2:25 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> When setting the power limit time window, software updates the 'y' bits
> and 'f' bits in the power limit register, and the value hardware takes
> follows the formula below
>
>         Time window = 2 ^ y * (1 + f / 4) * Time_Unit
>
> When handling large time window input from userspace, using left
> shifting breaks in two cases,
> 1. when ilog2(value) is bigger than 31, in expression "1 << y", left
>    shifting by more than 31 bits has undefined behavior. This breaks
>    'y'. For example, on an Alderlake platform, "1 << 32" returns 1.
> 2. when ilog2(value) equals 31, "1 << 31" returns negative value
>    because '1' is recognized as signed int. And this breaks 'f'.
>
> Given that 'y' has 5 bits and hardware can never take a value larger
> than 31, fix the first problem by clamp the time window to the maximum
> possible value that the hardware can take.
>
> Fix the second problem by using unsigned bit left shift.
>
> Note that hardware has its own maximum time window limitation, which
> may be lower than the time window value retrieved from the power limit
> register. When this happens, hardware clamps the input to its maximum
> time window limitation. That is why a software clamp is preferred to
> handle the problem on hand.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 26d00b1853b4..8b30e5259d3b 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -999,7 +999,12 @@ static u64 rapl_compute_time_window_core(struct rapl_package *rp, u64 value,
>
>                 do_div(value, rp->time_unit);
>                 y = ilog2(value);
> -               f = div64_u64(4 * (value - (1 << y)), 1 << y);
> +               if (y > 0x1f) {
> +                       pr_warn("%s: time window too large, clamped\n", rp->name);

IIUC this happens when user space provides a value that is too large.
Why do you want to log a kernel warning in that case?

> +                       return 0x7f;

Because the target hardware field has 7 bits, the function will return
all ones if the exponent is too large.  It would be good to put a
comment stating this here.

> +               }
> +
> +               f = div64_u64(4 * (value - (1ULL << y)), 1ULL << y);
>                 value = (y & 0x1f) | ((f & 0x3) << 5);
>         }
>         return value;
> --
