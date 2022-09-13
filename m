Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2BC5B7B80
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 21:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiIMTeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 15:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiIMTdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 15:33:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E3374CCF;
        Tue, 13 Sep 2022 12:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 538F3B80EA6;
        Tue, 13 Sep 2022 19:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298FDC433C1;
        Tue, 13 Sep 2022 19:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663097506;
        bh=j/v69bXvry1xb4f+97n6K3T7fs6hJ0fCxlm1mq9iVCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZqen9i4lzPMsvnPMOBwAB7N4GMgpmZ6+v1OxOjd2LKX2hFsZmpfW7aeClcRIrKfB
         aeBLbZX22L+yfYnnh7JeiLVAWld0wnqT5woRxMbu9Hd7/l4DAFgoDZxjpLs+04k55g
         g/JH0IdaA89HqdLfp5EY62BqvE6Yeh/+Ai062CXDkmQkD5O3BJGHUB2Rr83++9Nc/K
         eb1nzVV8AopBUeL7Idk5QOmhP2QTOrjOeXEDul1NG593DZnQkQu2ueFHjrD6Xml9u/
         ITW6pD+tJV5RtfMmarZgL3XdAkAbgcRNfFLsibXSP41YaNLoR6XfOP/+P3Gm3k1K7x
         uee1LDOVKhZzQ==
Date:   Tue, 13 Sep 2022 14:31:43 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-pm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: Re: [PATCH v4 3/4] thermal: qcom: tsens: Add driver support for
 re-initialization quirk
Message-ID: <20220913193143.3zd4gjnm55ol5kwu@builder.lan>
References: <20220901105414.1171813-1-bhupesh.sharma@linaro.org>
 <20220901105414.1171813-4-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901105414.1171813-4-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 04:24:13PM +0530, Bhupesh Sharma wrote:
> Since for some Qualcomm tsens controllers, its suggested to
> monitor the controller health periodically and in case an
> issue is detected, to re-initialize the tsens controller
> via trustzone, add the support for the same in the
> qcom tsens driver.
> 
> Note that once the tsens controller is reset using scm call,
> all SROT and TM region registers will enter the reset mode.
> 
> While all the SROT registers will be re-programmed and
> re-enabled in trustzone prior to the scm call exit, the TM
> region registers will not re-initialized in trustzone and thus
> need to be handled by the tsens driver.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-v2.c |   3 +
>  drivers/thermal/qcom/tsens.c    | 190 ++++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.h    |  12 ++
>  3 files changed, 205 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index b293ed32174b..f521e4479cc5 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -88,6 +88,9 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>  
>  	/* TRDY: 1=ready, 0=in progress */
>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
> +
> +	/* FIRST_ROUND_COMPLETE: 1=complete, 0=not complete */
> +	[FIRST_ROUND_COMPLETE] = REG_FIELD(TM_TRDY_OFF, 3, 3),
>  };
>  
>  static const struct tsens_ops ops_generic_v2 = {
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index b1b10005fb28..ecf544683e73 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -7,6 +7,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/qcom_scm.h>
>  #include <linux/module.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
> @@ -594,6 +595,107 @@ static void tsens_disable_irq(struct tsens_priv *priv)
>  	regmap_field_write(priv->rf[INT_EN], 0);
>  }
>  
> +static void tsens_reenable_hw_after_scm(struct tsens_priv *priv)
> +{
> +	/*
> +	 * Re-enable watchdog, unmask the bark and
> +	 * disable cycle completion monitoring.
> +	 */
> +	regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 1);
> +	regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 0);
> +	regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
> +	regmap_field_write(priv->rf[CC_MON_MASK], 1);
> +
> +	/* Re-enable interrupts */
> +	tsens_enable_irq(priv);
> +}
> +
> +static int tsens_health_check_and_reinit(struct tsens_priv *priv,
> +					 int hw_id)

This function is much easier to read now, thanks.

> +{
> +	int ret, trdy, first_round, sw_reg;
> +	unsigned long timeout;
> +
> +	/* Check early if the mutex is in locked state */
> +	WARN_ON(!mutex_is_locked(&priv->reinit_mutex));
> +
> +	/* First check if TRDY is SET */
> +	ret = regmap_field_read(priv->rf[TRDY], &trdy);
> +	if (ret)
> +		goto err;
> +
> +	if (trdy)
> +		return 0; /* success */
> +
> +	ret = regmap_field_read(priv->rf[FIRST_ROUND_COMPLETE], &first_round);
> +	if (ret)
> +		goto err;
> +
> +	if (first_round)
> +		return 0; /* success */
> +
> +	/* Wait for 2 ms for tsens controller to recover */
> +	ret = regmap_field_read_poll_timeout(priv->rf[FIRST_ROUND_COMPLETE],
> +					     first_round, first_round, 100,
> +					     RESET_TIMEOUT_MS * USEC_PER_MSEC);
> +	if (ret == 0) {
> +		dev_dbg(priv->dev, "tsens controller recovered\n");
> +		return 0; /* success */
> +	}
> +
> +	if (ret)
> +		goto err;
> +
> +	spin_lock(&priv->reinit_lock);

This spinlock is only used to ensure mutual exclusion of the
reinitialization attempt, but this is only attempted under the
reinit_mutex.

As such you should be able to eliminate the spinlock.

> +
> +	/*
> +	 * Invoke SCM call only if SW register write is reflecting in controller.
> +	 * Try it for 2 ms. In case that fails mark the tsens controller as
> +	 * unrecoverable.
> +	 */
> +	timeout = jiffies + msecs_to_jiffies(RESET_TIMEOUT_MS);
> +	do {
> +		ret = regmap_field_write(priv->rf[INT_EN], CRITICAL_INT_EN);
> +		if (ret)
> +			goto err_unlock;
> +
> +		ret = regmap_field_read(priv->rf[INT_EN], &sw_reg);
> +		if (ret)
> +			goto err_unlock;
> +	} while ((sw_reg & CRITICAL_INT_EN) && (time_before(jiffies, timeout)));
> +
> +	if (!(sw_reg & CRITICAL_INT_EN)) {
> +		ret = -ENOTRECOVERABLE;
> +		goto err_unlock;
> +	}
> +
> +	/* tsens controller did not recover, proceed with SCM call to re-init it. */
> +	ret = qcom_scm_tsens_reinit();
> +	if (ret) {
> +		dev_err(priv->dev, "tsens reinit scm call failed (%d)\n", ret);
> +		goto err_unlock;
> +	}
> +
> +	/*
> +	 * After the SCM call, we need to re-enable the interrupts and also set
> +	 * active threshold for each sensor.
> +	 */
> +	tsens_reenable_hw_after_scm(priv);
> +
> +	/* Notify reinit wa worker */
> +	queue_work(system_highpri_wq, &priv->reinit_wa_notify);
> +
> +	spin_unlock(&priv->reinit_lock);
> +
> +	return 0; /* success */
> +
> +err_unlock:
> +	spin_unlock(&priv->reinit_lock);
> +
> +err:
> +	return ret;
> +}
> +
>  int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>  {
>  	struct tsens_priv *priv = s->priv;
> @@ -607,6 +709,20 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
>  	if (tsens_version(priv) == VER_0)
>  		goto get_temp;
>  
> +	/*
> +	 * For some tsens controllers, its suggested to monitor the controller
> +	 * health periodically and in case an issue is detected to reinit tsens
> +	 * controller via trustzone.
> +	 */
> +	if (priv->needs_reinit_wa) {
> +		mutex_lock(&priv->reinit_mutex);
> +		ret = tsens_health_check_and_reinit(priv, hw_id);
> +		mutex_unlock(&priv->reinit_mutex);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/* Valid bit is 0 for 6 AHB clock cycles.
>  	 * At 19.2MHz, 1 AHB clock is ~60ns.
>  	 * We should enter this loop very, very rarely.
> @@ -739,6 +855,40 @@ static const struct regmap_config tsens_srot_config = {
>  	.reg_stride	= 4,
>  };
>  
> +static void __tsens_reinit_worker(struct tsens_priv *priv)
> +{
> +	int ret, temp;
> +	unsigned int i;
> +	struct tsens_irq_data d;
> +
> +	for (i = 0; i < priv->num_sensors; i++) {
> +		const struct tsens_sensor *s = &priv->sensor[i];
> +		u32 hw_id = s->hw_id;
> +
> +		if (!s->tzd)
> +			continue;
> +		if (!tsens_threshold_violated(priv, hw_id, &d))
> +			continue;
> +
> +		ret = get_temp_tsens_valid(s, &temp);
> +		if (ret) {
> +			dev_err(priv->dev, "[%u] error reading sensor during reinit\n", hw_id);
> +			continue;
> +		}
> +
> +		tsens_read_irq_state(priv, hw_id, s, &d);
> +
> +		if ((d.up_thresh < temp) || (d.low_thresh > temp)) {
> +			dev_dbg(priv->dev, "[%u] TZ update trigger during reinit (%d mC)\n",
> +				hw_id, temp);
> +			thermal_zone_device_update(s->tzd, THERMAL_EVENT_UNSPECIFIED);
> +		} else {
> +			dev_dbg(priv->dev, "[%u] no violation during reinit (%d)\n",
> +				hw_id, temp);
> +		}
> +	}
> +}
> +
>  int __init init_common(struct tsens_priv *priv)
>  {
>  	void __iomem *tm_base, *srot_base;
> @@ -860,6 +1010,14 @@ int __init init_common(struct tsens_priv *priv)
>  		goto err_put_device;
>  	}
>  
> +	priv->rf[FIRST_ROUND_COMPLETE] = devm_regmap_field_alloc(dev,
> +								priv->tm_map,
> +								priv->fields[FIRST_ROUND_COMPLETE]);
> +	if (IS_ERR(priv->rf[FIRST_ROUND_COMPLETE])) {
> +		ret = PTR_ERR(priv->rf[FIRST_ROUND_COMPLETE]);
> +		goto err_put_device;
> +	}
> +
>  	/* This loop might need changes if enum regfield_ids is reordered */
>  	for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
>  		for (i = 0; i < priv->feat->max_sensors; i++) {
> @@ -1082,6 +1240,14 @@ static int tsens_register(struct tsens_priv *priv)
>  	return ret;
>  }
>  
> +static void tsens_reinit_worker_notify(struct work_struct *work)
> +{
> +	struct tsens_priv *priv = container_of(work, struct tsens_priv,
> +					       reinit_wa_notify);
> +
> +	__tsens_reinit_worker(priv);

Seems reasonable to inline that.

> +}
> +
>  static int tsens_probe(struct platform_device *pdev)
>  {
>  	int ret, i;
> @@ -1123,6 +1289,11 @@ static int tsens_probe(struct platform_device *pdev)
>  
>  	priv->dev = dev;
>  	priv->num_sensors = num_sensors;
> +	priv->needs_reinit_wa = data->needs_reinit_wa;
> +
> +	if (priv->needs_reinit_wa && !qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +
>  	priv->ops = data->ops;
>  	for (i = 0;  i < priv->num_sensors; i++) {
>  		if (data->hw_ids)
> @@ -1138,6 +1309,25 @@ static int tsens_probe(struct platform_device *pdev)
>  	if (!priv->ops || !priv->ops->init || !priv->ops->get_temp)
>  		return -EINVAL;
>  
> +	/*
> +	 * Reinitialization workaround is currently supported only for
> +	 * tsens controller versions v2.
> +	 *
> +	 * If incorrect platform data is passed to this effect, ignore
> +	 * the requested setting and move forward.
> +	 */
> +	if (priv->needs_reinit_wa && (tsens_version(priv) < VER_2_X)) {
> +		dev_warn(dev,
> +			 "%s: Reinit quirk available only for tsens v2\n", __func__);
> +		priv->needs_reinit_wa = false;
> +	}
> +
> +	mutex_init(&priv->reinit_mutex);
> +	spin_lock_init(&priv->reinit_lock);
> +
> +	if (priv->needs_reinit_wa)
> +		INIT_WORK(&priv->reinit_wa_notify, tsens_reinit_worker_notify);
> +
>  	ret = priv->ops->init(priv);
>  	if (ret < 0) {
>  		dev_err(dev, "%s: init failed\n", __func__);
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 92787017c6ab..900d2a74d25e 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -14,9 +14,12 @@
>  #define SLOPE_FACTOR		1000
>  #define SLOPE_DEFAULT		3200
>  #define TIMEOUT_US		100
> +#define RESET_TIMEOUT_MS	2
>  #define THRESHOLD_MAX_ADC_CODE	0x3ff
>  #define THRESHOLD_MIN_ADC_CODE	0x0
>  
> +#define CRITICAL_INT_EN		(BIT(2))
> +
>  #include <linux/interrupt.h>
>  #include <linux/thermal.h>
>  #include <linux/regmap.h>
> @@ -165,6 +168,7 @@ enum regfield_ids {
>  	/* ----- TM ------ */
>  	/* TRDY */
>  	TRDY,
> +	FIRST_ROUND_COMPLETE,
>  	/* INTERRUPT ENABLE */
>  	INT_EN,	/* v2+ has separate enables for crit, upper and lower irq */
>  	/* STATUS */
> @@ -564,6 +568,14 @@ struct tsens_priv {
>  	u32				tm_offset;
>  	bool				needs_reinit_wa;
>  
> +	struct work_struct		reinit_wa_notify;
> +
> +	/* protects reinit related serialization */

/* serializes health check and reinit */ ?

> +	struct mutex			reinit_mutex;
> +
> +	/* lock for reinit workaround */
> +	spinlock_t			reinit_lock;
> +

Regards,
Bjorn

>  	/* lock for upper/lower threshold interrupts */
>  	spinlock_t			ul_lock;
>  
> -- 
> 2.37.1
> 
