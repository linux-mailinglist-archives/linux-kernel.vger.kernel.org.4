Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612905E4F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 20:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiIUS3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 14:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIUS26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:28:58 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0547A1D58;
        Wed, 21 Sep 2022 11:28:57 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id cj27so4720892qtb.7;
        Wed, 21 Sep 2022 11:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=O9UTDnRHflfsX+CFhFUlYBP0gI2mmaMDwE85Cy4YTjc=;
        b=TwD3KXA9MaN9HL/v8qJDLpdwuz9xNt1KgB6EzcaDsufdhrqN51n6jcubQzawrqCkUn
         LBXwij/Qb/54t51XYXQyVmSxrp8GLr84za5bE6obS1DWGbbw1O7NamHcKOFNsDEiNh/L
         S0h58Chhv74HXS5O8wDab3/eswwDMn/bnGz7L0/DPBgsl6BMrOsHF+lHO1jRmoDhOYJW
         Pj1sqdCHLw+dZ6AbCmEY10VS0ODp2ammReDx6f350w8ltb35dUAlMq/gQmjkp/qaclou
         BlljJNx5KY3KwR+6m7/LZdacH1T4st1jJ5aLWMa2dSFrHl+MTWK75IHGHQOxtVvv9p8k
         MZsQ==
X-Gm-Message-State: ACrzQf3QF6wn+7cAg/P4fE6Lxx53VncunlSTiZxhKqjcfHe0qy8G3aHn
        ruvYJRX6AW7BQC12VBhRFLSkk9vN3alMx+Vhe/xarkH3
X-Google-Smtp-Source: AMsMyM6gZl77XOFOJuPFhAH/SoYbIKYFNO163WyNcm1yzR1Ck0AopH+l5c0bpp7dPIqwSMZ6WqjH+0oK954Q5XQ3zj4=
X-Received: by 2002:a05:622a:620a:b0:35c:bf9e:8748 with SMTP id
 hj10-20020a05622a620a00b0035cbf9e8748mr24946021qtb.494.1663784936806; Wed, 21
 Sep 2022 11:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220920110657.1948320-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20220920110657.1948320-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Sep 2022 20:28:45 +0200
Message-ID: <CAJZ5v0gWxtm195_SC+Ak+CYRng0GLU4JOfRjiuFtPyVxA-fBVQ@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/intel_powerclamp: Fix bug for smp_processor_id
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen Yu <yu.c.chen@intel.com>
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

On Tue, Sep 20, 2022 at 1:07 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> When CPU 0 is offline and intel_powerclamp is used to inject
> idle, it generates kernel BUG:
>
> BUG: using smp_processor_id() in preemptible [00000000] code: bash/15687
> caller is debug_smp_processor_id+0x17/0x20
> CPU: 4 PID: 15687 Comm: bash Not tainted 5.19.0-rc7+ #57
> Call Trace:
> <TASK>
> dump_stack_lvl+0x49/0x63
> dump_stack+0x10/0x16
> check_preemption_disabled+0xdd/0xe0
> debug_smp_processor_id+0x17/0x20
> powerclamp_set_cur_state+0x7f/0xf9 [intel_powerclamp]
> ...
> ...
>
> Here CPU 0 is the control CPU by default and changed to the current CPU,
> if CPU 0 offlined. This check has to be performed under cpus_read_lock(),
> hence the above warning.
>
> Use get_cpu() instead of smp_processor_id() to avoid this BUG.
>
> Suggested-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index c841ab37e7c6..46cd799af148 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -532,8 +532,10 @@ static int start_power_clamp(void)
>
>         /* prefer BSP */
>         control_cpu = 0;
> -       if (!cpu_online(control_cpu))
> -               control_cpu = smp_processor_id();
> +       if (!cpu_online(control_cpu)) {
> +               control_cpu = get_cpu();
> +               put_cpu();
> +       }
>
>         clamping = true;
>         schedule_delayed_work(&poll_pkg_cstate_work, 0);
> --

Applied as 6.1 material with modified subject, thanks!
