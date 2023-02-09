Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6BE6910DB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjBIS7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBIS7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:59:40 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178E05C8B1;
        Thu,  9 Feb 2023 10:59:35 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id hx15so9281547ejc.11;
        Thu, 09 Feb 2023 10:59:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiyGANvUi7CG2nP+Z/39gI28IwpjlwQL3B6Oq/vm7zs=;
        b=sWwp3GYvsBlhb8lZ/Rmjb6UPLofBqPSgsaRrJjDad7FktINfWs4jivY1roCC/Is2H2
         R0ITaT7PLPeFCuo4mcCG+jd0XLRkn7swxapHd8Ik4S6c17GCQHNgvtkkcbO2g2T2muWq
         mBMdDK7MEcVexVMiGiGnmR7A1vppJ8M+H8oa/iEuKZ9xZnZ/JMqQn1TLYR9S8tc9sZkY
         9Xcz9Lk4DEj/aPr85fBfGAOlyvSDk5yA75eqfOPNurUgUlD6mljDu5GgOFz4+OdcEhNf
         7fJOUYA48qJlH5fHggraAMO2n33O3FoHPu9u97cImdkepyYVmE6XPaDovcti5zAk55Jp
         wfjA==
X-Gm-Message-State: AO0yUKWaWMd1MoWSVttD9/YKql/UQNXOEmVzpcqgrcutzA0r/4mhQ7ic
        ElgZM2BtDZvOwZgKfnhVfPGljRSLkw8h/IyKnbU=
X-Google-Smtp-Source: AK7set9bZPg4pYp6LeMMikBXuphqV7Irs09di6YNJcIC/wXGqBjU7r3V9Jv1PLeITOb0KOMq0p1dsNLo+RSEKmuLkE0=
X-Received: by 2002:a17:906:ce2e:b0:87f:575a:9b67 with SMTP id
 sd14-20020a170906ce2e00b0087f575a9b67mr2923351ejb.274.1675969173664; Thu, 09
 Feb 2023 10:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20230208070908.41702-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230208070908.41702-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Feb 2023 19:59:22 +0100
Message-ID: <CAJZ5v0imyHuuE4pAwVamnYnsido5TnGDEuKEELZEatAc8ovmPg@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/intel_powerclamp: Fix module param for duration
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Feb 8, 2023 at 8:09 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> After switch to use powercap/idle-inject framework in the Intel
> powerclamp driver, the idle "duration" is changed to micro seconds.
>
> But the module parameter for idle "duration" is in milli seconds. So,
> convert to micro seconds in the set callback and convert back to milli
> seconds by adding a get callback.
>
> While here also use mutex protection for setting and getting "duration".
> The other uses of "duration" is already protected by mutex.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> This patch is for linux-pm bleeding-edge branch. Can be after patch:
> "
> commit 8526eb7fc75abcd09d8bd061610215baf0ca948a
> Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Date:   Wed Feb 1 10:28:53 2023 -0800
>
>     thermal: intel: powerclamp: Use powercap idle-inject feature
> "
> Can't add Fixes tag as commit ID will change once merged to mainline.
> Or wait till the above patch is merged to mainline.
>
>  drivers/thermal/intel/intel_powerclamp.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
> index 1390748706a6..038acccc0509 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -74,6 +74,7 @@ static struct thermal_cooling_device *cooling_dev;
>
>  static DEFINE_MUTEX(powerclamp_lock);
>
> +/* This duration is in micro seconds */
>  static unsigned int duration;
>  static unsigned int pkg_cstate_ratio_cur;
>  static unsigned int window_size;
> @@ -90,23 +91,34 @@ static int duration_set(const char *arg, const struct kernel_param *kp)
>                 pr_err("Out of recommended range %lu, between 6-25ms\n",
>                         new_duration);
>                 ret = -EINVAL;
> +               goto exit;
>         }
>
> -       duration = clamp(new_duration, 6ul, 25ul);
> -       smp_mb();
> -
> +       mutex_lock(&powerclamp_lock);
> +       duration = clamp(new_duration, 6ul, 25ul) * 1000;
> +       mutex_unlock(&powerclamp_lock);
>  exit:
>
>         return ret;
>  }
>
> +static int duration_get(char *buf, const struct kernel_param *kp)
> +{
> +       int ret;
> +
> +       mutex_lock(&powerclamp_lock);
> +       ret = sysfs_emit(buf, "%d\n", duration / 1000);
> +       mutex_unlock(&powerclamp_lock);
> +
> +       return ret;
> +}
> +
>  static const struct kernel_param_ops duration_ops = {
>         .set = duration_set,
> -       .get = param_get_int,
> +       .get = duration_get,
>  };
>
> -
> -module_param_cb(duration, &duration_ops, &duration, 0644);
> +module_param_cb(duration, &duration_ops, NULL, 0644);
>  MODULE_PARM_DESC(duration, "forced idle time for each attempt in msec.");
>
>  struct powerclamp_calibration_data {
> --

Applied with some edits in the subject and changelog, thanks!
