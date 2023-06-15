Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20F8731D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjFOQQe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jun 2023 12:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjFOQQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:16:27 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A60919B5;
        Thu, 15 Jun 2023 09:16:26 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9787d11a410so182343266b.0;
        Thu, 15 Jun 2023 09:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686845784; x=1689437784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YxB57F6iRPfxYgCyQDt6O4M+2ztrVFXMcR28M9UUao=;
        b=R0ExtFr+xjCfa2CCySwnV2M+/8D0xCxJTa6mYE4BKAwUtit10etfrewz5wHMiqG2Y5
         TA8RQpIhnAZk/Mb5S2SXpv3QcvpVXZJo7PXhcOmOEm3ATStfP3tKl4N1gJTvbwWStrL2
         2aJSGuuu4Q6QFIuqzOE/+ex9BE42YyZKOqKGcqOrmyzPAPNCd6rFuWh1h5JTneflwWGx
         3/9VOXJ8eaieoy+xCBcmhyYvtu40XIvVftDkWa69y8NgShUJ3LK8RGAXQ9ou3/Hn5p6B
         eLdQG8tfknxzDELAepm7SETRjYUdPghfxKsMfQyzgUpMvz+jyVs57RT4k5IouPRrzSu6
         B0lA==
X-Gm-Message-State: AC+VfDwQhUU8HCljDtTzS3djKhpRQF+jyQ/op2aWTip1yuI/CjJWLtHO
        Gb4+asAF3KDX4OguhoSlCAEx4CU2/bQL4RAz98QEE0Xx
X-Google-Smtp-Source: ACHHUZ75hIGwjEEgEDPtIcVqzkL0hHs2Qm5MjFTh5D7H8auKRvbFlYSzFPkQPnEjT1vRJMJMrpz8CkW0OACp1QrOGys=
X-Received: by 2002:a17:906:289:b0:977:ead3:c91 with SMTP id
 9-20020a170906028900b00977ead30c91mr14683806ejf.1.1686845784419; Thu, 15 Jun
 2023 09:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <ZHSx61V6fgMcXsvh@BLR-5CG13462PL.amd.com> <20230529142551.6726-1-wyes.karny@amd.com>
In-Reply-To: <20230529142551.6726-1-wyes.karny@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Jun 2023 18:16:13 +0200
Message-ID: <CAJZ5v0hviMc_vhnOx_mPLikAX-5X4YjZabP+F5GNH5ac8WNGcw@mail.gmail.com>
Subject: Re: [PATCH v4.1] cpufreq: Fail driver register if it has adjust_perf
 without fast_switch
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, ray.huang@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gautham.shenoy@amd.com
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

On Mon, May 29, 2023 at 4:26 PM Wyes Karny <wyes.karny@amd.com> wrote:
>
> If fast_switch_possible flag is set by the scaling driver, the governor
> is free to select fast_switch function even if adjust_perf is set.  Some
> scaling drivers which use adjust_perf don't set fast_switch thinking
> that the governor would never fall back to fast_switch. But the governor
> can fall back to fast_switch even in runtime if frequency invariance is
> disabled due to some reason. This could crash the kernel if the driver
> didn't set the fast_switch function pointer.
>
> Therefore, fail driver registration if it has adjust_perf without
> fast_switch.
>
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  drivers/cpufreq/cpufreq.c | 3 ++-
>  include/linux/cpufreq.h   | 5 ++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6b52ebe5a890..50bbc969ffe5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2828,7 +2828,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>              (driver_data->setpolicy && (driver_data->target_index ||
>                     driver_data->target)) ||
>              (!driver_data->get_intermediate != !driver_data->target_intermediate) ||
> -            (!driver_data->online != !driver_data->offline))
> +            (!driver_data->online != !driver_data->offline) ||
> +                (driver_data->adjust_perf && !driver_data->fast_switch))
>                 return -EINVAL;
>
>         pr_debug("trying to register driver %s\n", driver_data->name);
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 26e2eb399484..172ff51c1b2a 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -340,7 +340,10 @@ struct cpufreq_driver {
>         /*
>          * ->fast_switch() replacement for drivers that use an internal
>          * representation of performance levels and can pass hints other than
> -        * the target performance level to the hardware.
> +        * the target performance level to the hardware. This can only be set
> +        * if ->fast_switch is set too, because in those cases (under specific
> +        * conditions) scale invariance can be disabled, which causes the
> +        * schedutil governor to fall back to the latter.
>          */
>         void            (*adjust_perf)(unsigned int cpu,
>                                        unsigned long min_perf,
> --

Applied as 6.5 material, thanks!
