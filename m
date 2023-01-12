Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A58666784E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbjALO5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbjALO5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:57:01 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE83942625
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:43:31 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id d10so12884191pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zS2T9dR6c6kcyaKB6UcxI33YN3XGf+D0vGX3KbZ3PWA=;
        b=RqqsuRR0KYxhbPvkZ1HoHrS8MIu2IOY06CzW1KCEFA6JQ1VjCAs24Zc99f2uLKtKFH
         OjPpm3zS9LyKUcxQWYfC4w0puKjDi/KsIwbR36xbjeXQvp5/ydTFz1RBzaI2xGJBQd9U
         qmGp51o+emTJ4VkmFaaCv5p3jcfCCg0I2QwEbAeqqisC7cRMQFFjX3bYlN8pqJfbUWpT
         d2XiyxKCSlMeoBQvx9FveR2XKvEhrcoAXPiK5XdR0FNJZCIMuyLuiF7w0gKMf3A5SNCX
         Ilmq8KHLKc1zEaH52gNGLOIccQo2m6WUqX2p1PdWyKJbP6run/fh2Qu9S20AQ26+e9st
         gaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zS2T9dR6c6kcyaKB6UcxI33YN3XGf+D0vGX3KbZ3PWA=;
        b=ghjb/BUI5Pu1LnunH/7SJopIUxiQcYS04g75AKfUO+eos2CkxadT63XJP2yqzngiIy
         L7hhtGjBiAo9mdsCpx7wHsAOZVDPxPrP3k89N8irUqMicdUUp0Pgs2D5oEczclMLeJA2
         Gjnwbne1h3Yo2dV4Ih5nQdKqaVlX3xsB7wFO5LD/wsKsY2yMV8euVUypsR7WfLqcBG7+
         LRqxACF3XwuE2PHMIDrpVHvVONxZIvuqEWOQHtnYMX0PvDJyPzJU9wW0tVoaXBBg3k6p
         akQW1xEBGbmdDJ7FaQMZY8TAEuQpmr/CMyjAPm1fgWr7kMt0hcc5PDJdPIgLq7FDN1QA
         Vlkw==
X-Gm-Message-State: AFqh2krQxf/rCUlETh1BMs2hGYiSKcV6+k72S9xFz9RhtDFdgy3N7ePf
        bxWeINuMLYQa9GnSP/CMn8HU3ahLb4PbG9Jr6Kq8eQ==
X-Google-Smtp-Source: AMrXdXsaRC2qltV1ZFSeM2VDtEEGgSrnh3q8shAR5baprOgapilQYAMEVUxsYnfcd3af6b1u2TipOp6OK87AQwuuN6w=
X-Received: by 2002:a62:be08:0:b0:581:c0d:19ea with SMTP id
 l8-20020a62be08000000b005810c0d19eamr4324713pff.31.1673534611219; Thu, 12 Jan
 2023 06:43:31 -0800 (PST)
MIME-Version: 1.0
References: <20230110110736.2709917-1-james.clark@arm.com> <20230110110736.2709917-4-james.clark@arm.com>
In-Reply-To: <20230110110736.2709917-4-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 12 Jan 2023 14:43:19 +0000
Message-ID: <CAJ9a7ViT6vTdq8BMt0nv1CK1FNDOAF8r2Ca8HPWuKeeEXRSRVg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] coresight: cti: Remove atomic type from enable_req_count
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        suzuki.poulose@arm.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023 at 11:08, James Clark <james.clark@arm.com> wrote:
>
> enable_req_count is only ever accessed inside the spinlock, so to avoid
> confusion that there are concurrent accesses and simplify the code,
> change it to an int.
>
> One access outside of the spinlock is in enable_show() which appears to
> allow partially written data to be displayed between enable_req_count,
> powered and enabled so move this one inside the spin lock too.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-cti-core.c  | 14 +++++++-------
>  drivers/hwtracing/coresight/coresight-cti-sysfs.c |  2 +-
>  drivers/hwtracing/coresight/coresight-cti.h       |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> index 838872f2484d..277c890a1f1f 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> @@ -107,12 +107,12 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
>         cti_write_all_hw_regs(drvdata);
>
>         config->hw_enabled = true;
> -       atomic_inc(&drvdata->config.enable_req_count);
> +       drvdata->config.enable_req_count++;
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>         return rc;
>
>  cti_state_unchanged:
> -       atomic_inc(&drvdata->config.enable_req_count);
> +       drvdata->config.enable_req_count++;
>
>         /* cannot enable due to error */
>  cti_err_not_enabled:
> @@ -129,7 +129,7 @@ static void cti_cpuhp_enable_hw(struct cti_drvdata *drvdata)
>         config->hw_powered = true;
>
>         /* no need to do anything if no enable request */
> -       if (!atomic_read(&drvdata->config.enable_req_count))
> +       if (!drvdata->config.enable_req_count)
>                 goto cti_hp_not_enabled;
>
>         /* try to claim the device */
> @@ -156,13 +156,13 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
>         spin_lock(&drvdata->spinlock);
>
>         /* don't allow negative refcounts, return an error */
> -       if (!atomic_read(&drvdata->config.enable_req_count)) {
> +       if (!drvdata->config.enable_req_count) {
>                 ret = -EINVAL;
>                 goto cti_not_disabled;
>         }
>
>         /* check refcount - disable on 0 */
> -       if (atomic_dec_return(&drvdata->config.enable_req_count) > 0)
> +       if (--drvdata->config.enable_req_count > 0)
>                 goto cti_not_disabled;
>
>         /* no need to do anything if disabled or cpu unpowered */
> @@ -239,7 +239,7 @@ static void cti_set_default_config(struct device *dev,
>         /* Most regs default to 0 as zalloc'ed except...*/
>         config->trig_filter_enable = true;
>         config->ctigate = GENMASK(config->nr_ctm_channels - 1, 0);
> -       atomic_set(&config->enable_req_count, 0);
> +       config->enable_req_count = 0;
>  }
>
>  /*
> @@ -696,7 +696,7 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
>                 drvdata->config.hw_enabled = false;
>
>                 /* check enable reference count to enable HW */
> -               if (atomic_read(&drvdata->config.enable_req_count)) {
> +               if (drvdata->config.enable_req_count) {
>                         /* check we can claim the device as we re-power */
>                         if (coresight_claim_device(csdev))
>                                 goto cti_notify_exit;
> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> index 71e7a8266bb3..e528cff9d4e2 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> @@ -84,8 +84,8 @@ static ssize_t enable_show(struct device *dev,
>         bool enabled, powered;
>         struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
>
> -       enable_req = atomic_read(&drvdata->config.enable_req_count);
>         spin_lock(&drvdata->spinlock);
> +       enable_req = drvdata->config.enable_req_count;
>         powered = drvdata->config.hw_powered;
>         enabled = drvdata->config.hw_enabled;
>         spin_unlock(&drvdata->spinlock);
> diff --git a/drivers/hwtracing/coresight/coresight-cti.h b/drivers/hwtracing/coresight/coresight-cti.h
> index acf7b545e6b9..8b106b13a244 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.h
> +++ b/drivers/hwtracing/coresight/coresight-cti.h
> @@ -141,7 +141,7 @@ struct cti_config {
>         int nr_trig_max;
>
>         /* cti enable control */
> -       atomic_t enable_req_count;
> +       int enable_req_count;
>         bool hw_enabled;
>         bool hw_powered;
>
> --
> 2.25.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
