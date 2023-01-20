Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820F8675B61
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjATRae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjATRad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:30:33 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA001DBCE;
        Fri, 20 Jan 2023 09:30:27 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id ss4so15668643ejb.11;
        Fri, 20 Jan 2023 09:30:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sN0PSQag0tcwUzY5X+frwcic7C4pJSMJyVbEv7noVTE=;
        b=s7Dv9mDd7KEdxxv82Zz1d+u1HHnll+Gb1XKVHiNaJYvf2Nyr2h6kBtR3sAoMpX0bEM
         4RitrscbrVnmEwlkWt3iFUOMvVLsWnQHYAG9dZJN2CNlM6HQtCU3DhGxbX1ntLdswgbP
         FtPwECfi1RQDjSAWtSCrprv0SNUbC+qJEwMr1F9Dgx3cb1LLUhVNYzIiFYnV9woh8gJY
         VlzSVqLrLmjevXVwR//j3ecF6Nk3o6GV2vORtkOSwmIFyRaq3UatDUSO7JCRvPI/+dQh
         uwrOkXGHiF/sPpjKLe5uiTv7OpEciPp4lSxyen3xJ+sbCrrTF/MbJcULRwTP9b9fFMdL
         f+/A==
X-Gm-Message-State: AFqh2krUNXvFEDO/3+NBLkmv/hf2Udv5ncqeIgRd5wghHlJiHKJ6gHZM
        54RsIedEbhMX3JfxwoSIweFvno2VcHNKvkI/Vxk=
X-Google-Smtp-Source: AMrXdXu5puPtkKEsmzys+RRoxegVJqcv1U+3h3RwvTcHcZmZSffWb6JjdxqdLw7RkRwMK/bh/5aqTDGl6i4Un3xN61A=
X-Received: by 2002:a17:906:940c:b0:86f:d628:e184 with SMTP id
 q12-20020a170906940c00b0086fd628e184mr1947206ejx.96.1674235826481; Fri, 20
 Jan 2023 09:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20230117182240.2817822-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230117182240.2817822-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 18:30:15 +0100
Message-ID: <CAJZ5v0gnx4R0M86O5+Eth4kEoxk1-=Ym7Wrs0-DzRUsvAvR-KA@mail.gmail.com>
Subject: Re: [PATCH] thermal/idle_inject: Support 100% idle injection
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com
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

It's powercap/idle_inject.

On Tue, Jan 17, 2023 at 7:23 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> The users of idle injection framework allow 100% idle injection. For
> example: thermal/cpuidle_cooling.c driver. When the ratio set to 100%,
> the runtime_duration becomes zero.
>
> In the function idle_inject_set_duration() in idle injection framework
> run_duration_us == 0 is silently ignored, without any error (it is a
> void function). So, the caller will assume that everything is fine and
> 100% idle is effective. But in reality the idle inject will be whatever
> set before.
>
> There are two options:
> - The caller change their max state to 99% instead of 100% and
> document that 100% is not supported by idle inject framework
> - Support 100% idle support in idle inject framework
>
> Since there are other protections via RT throttling, this framework can
> allow 100% idle. The RT throttling will be activated at 95% idle by
> default. The caller disabling RT throttling and injecting 100% idle,
> should be aware that CPU can't be used at all.
>
> The idle inject timer is started for (run_duration_us + idle_duration_us)
> duration. Hence replace (run_duration_us && idle_duration_us) with
> (run_duration_us + idle_duration_us) in the function
> idle_inject_set_duration(). Also check for !(run_duration_us +
> idle_duration_us) to return -EINVAL in the function idle_inject_start().

And I have edited the changelog somewhat.

> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> Change log:
> Compared to RFC/RFT
> - Add a pr_debug for 100% idle
>
>  drivers/powercap/idle_inject.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index c57b40477246..3ac81086d71f 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -170,10 +170,12 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
>                               unsigned int run_duration_us,
>                               unsigned int idle_duration_us)
>  {
> -       if (run_duration_us && idle_duration_us) {
> +       if (run_duration_us + idle_duration_us) {
>                 WRITE_ONCE(ii_dev->run_duration_us, run_duration_us);
>                 WRITE_ONCE(ii_dev->idle_duration_us, idle_duration_us);
>         }
> +       if (!run_duration_us)
> +               pr_debug("CPU is forced to 100 percent idle\n");
>  }
>  EXPORT_SYMBOL_NS_GPL(idle_inject_set_duration, IDLE_INJECT);
>
> @@ -219,7 +221,7 @@ int idle_inject_start(struct idle_inject_device *ii_dev)
>         unsigned int idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
>         unsigned int run_duration_us = READ_ONCE(ii_dev->run_duration_us);
>
> -       if (!idle_duration_us || !run_duration_us)
> +       if (!(idle_duration_us + run_duration_us))
>                 return -EINVAL;
>
>         pr_debug("Starting injecting idle cycles on CPUs '%*pbl'\n",
> --

Applied as 6.3 material, thanks!
