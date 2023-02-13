Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E659694BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjBMQDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjBMQDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:03:11 -0500
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110C81C32E;
        Mon, 13 Feb 2023 08:03:10 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id jg8so33084295ejc.6;
        Mon, 13 Feb 2023 08:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tIYbWRKiVNoa7/EuTrE22y6ppQgPNllhOKadHyKY/90=;
        b=lsKAlJb5xsO3ioRWwtXmRTD+TU8PnThwqNlMUgL9t5feSPcxbQ2Y6LE/DA0jqYyXAn
         JYo9rqNQuZ9WMSWADelCx03+I8sqPCcb7zh5ijQbfqOb7AwJax+qFoSkLDABwC92MI1M
         SB56CrLuQxxDLNxR1vkYQ5IinWBHH0X2rthb1SRzw3epXltOpaYRsBluKqqDfYwPS2xI
         d7xziETlqwgZ3RmRpgGvhxVJPwwlFOInLTIlCqGIpr0gamORVq8iGxV/goXfayCSe5w5
         8t/oL+CoRHKNQUSltgMWRxplTw/WWwZ6RnZ4Uhe0Pzs9lBpRQtN32hCJ6vzjMsSs9kag
         yQww==
X-Gm-Message-State: AO0yUKVibE8ox63WiX/Nsi/oIGVZcCRtj66tnqzi47T+y3ddQKOsEYyx
        eGw1EIPEeq9rwtccdmzeSgw4hbXCfBJtOHkA1e6Wjs+Q
X-Google-Smtp-Source: AK7set92Iou7Ljt6rtlOYRoZOVjTEwOKtb5y9wb2NtJPJlmVkPSs6KeZCqBsBgsflbdwqZvcHEV32IAPqcOws8pLlxU=
X-Received: by 2002:a17:906:3659:b0:8ae:e92e:eab7 with SMTP id
 r25-20020a170906365900b008aee92eeab7mr4681821ejb.4.1676304188428; Mon, 13 Feb
 2023 08:03:08 -0800 (PST)
MIME-Version: 1.0
References: <20230211031710.277459-1-rui.zhang@intel.com>
In-Reply-To: <20230211031710.277459-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 17:02:57 +0100
Message-ID: <CAJZ5v0iXfXVDfxjjA+iy4eThsHFTuv=8RvKCrmtWHrwLmrMy9g@mail.gmail.com>
Subject: Re: [PATCH V2] powercap/intel_rapl: Fix handling for large time window
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        srinivas.pandruvada@intel.com
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

On Sat, Feb 11, 2023 at 4:17 AM Zhang Rui <rui.zhang@intel.com> wrote:
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
> Change since V1:
> 1. drop pr_warn message for bogus userspace input.
> 2. Add a comment when handling the large exponent.
> ---
>  drivers/powercap/intel_rapl_common.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 26d00b1853b4..69526d21699d 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -999,7 +999,15 @@ static u64 rapl_compute_time_window_core(struct rapl_package *rp, u64 value,
>
>                 do_div(value, rp->time_unit);
>                 y = ilog2(value);
> -               f = div64_u64(4 * (value - (1 << y)), 1 << y);
> +
> +               /*
> +                * The target hardware field has 7 bits, return all ones if
> +                * the exponent is too large.
> +                */
> +               if (y > 0x1f)
> +                       return 0x7f;
> +
> +               f = div64_u64(4 * (value - (1ULL << y)), 1ULL << y);
>                 value = (y & 0x1f) | ((f & 0x3) << 5);
>         }
>         return value;
> --

Applied as 6.3 material with a minor adjustment of the new comment, thanks!
