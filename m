Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BE1700ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241558AbjELOyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241536AbjELOyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:54:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A4FD2D3;
        Fri, 12 May 2023 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683903270; x=1715439270;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=LsQQVwQKDu5wqILYLhD8gDsG8ROmJlBhf0DL4ry9z4M=;
  b=kC9tWUajZaan+1H55Gxo3e+0DadzTB6flsUd7nYjHE9CzMadfk8u3ijr
   xOkmuMN6EAiJdaw+7IKk52fbeQXpJXpFhyyDAxsCR9EbGC775SfMvMn2J
   NTwU2wdx4PYgXfOEyeBAUzW8D7z6K21Qe00amiuIS8S7dIYU8NXvSvOZ2
   sx13ZxYkWc4NYxaF40vArDhGu+J9jpyG9N5Y94nMkYcLnysJ4iDz+2czV
   UR3pICIyrufil+WOObgdKnqqLnDNKGHCr48BZF2VKKbvdQdWvN1rtUQ6e
   U9WR5lNPvBmfKaMj/Gyw0zIXFCTc2bpkCvnudUACSb5BavGTJDNkP9SX4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="437140453"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="437140453"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:54:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="844441335"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="844441335"
Received: from winkelru-mobl.amr.corp.intel.com (HELO [10.212.144.249]) ([10.212.144.249])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:54:28 -0700
Message-ID: <c79e354d-4d09-a04b-798b-e42bdc47d694@linux.intel.com>
Date:   Fri, 12 May 2023 09:52:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 06/10] mfd: cs42l43: Add support for cs42l43 core driver
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linus.walleij@linaro.org,
        vkoul@kernel.org
Cc:     lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-7-ckeepax@opensource.cirrus.com>
Content-Language: en-US
In-Reply-To: <20230512122838.243002-7-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> +static int cs42l43_sdw_update_status(struct sdw_slave *sdw, enum sdw_slave_status status)
> +{
> +	struct cs42l43 *cs42l43 = dev_get_drvdata(&sdw->dev);
> +
> +	switch (status) {
> +	case SDW_SLAVE_ATTACHED:
> +		dev_dbg(cs42l43->dev, "Device attach\n");
> +
> +		sdw_write_no_pm(sdw, CS42L43_GEN_INT_MASK_1,
> +				CS42L43_INT_STAT_GEN1_MASK);
> +
> +		cs42l43->attached = true;
> +
> +		complete(&cs42l43->device_attach);
> +		break;
> +	case SDW_SLAVE_UNATTACHED:
> +		dev_dbg(cs42l43->dev, "Device detach\n");
> +
> +		cs42l43->attached = false;
> +
> +		reinit_completion(&cs42l43->device_attach);
> +		complete(&cs42l43->device_detach);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cs42l43_sdw_interrupt(struct sdw_slave *sdw,
> +				 struct sdw_slave_intr_status *status)
> +{
> +	/*
> +	 * There is only a single bit in GEN_INT_STAT_1 and it doesn't clear if
> +	 * IRQs are still pending so doing a read/write here after handling the
> +	 * IRQ is fine.
> +	 */
> +	sdw_read_no_pm(sdw, CS42L43_GEN_INT_STAT_1);
> +	sdw_write_no_pm(sdw, CS42L43_GEN_INT_STAT_1, 1);
> +
> +	return 0;
> +}

not really getting the comment and code above. Where is the IRQ handled?
In the 'other non-SoundWire part"?


> +static void cs42l43_boot_work(struct work_struct *work)
> +{
> +	struct cs42l43 *cs42l43 = container_of(work, struct cs42l43, boot_work);
> +	unsigned int devid, revid, otp;
> +	int ret;
> +
> +	dev_dbg(cs42l43->dev, "Boot work running\n");
> +
> +	ret = cs42l43_wait_for_attach(cs42l43);
> +	if (ret)
> +		goto err;
> +
> +	if (cs42l43->sdw)
> +		cs42l43->irq = cs42l43->sdw->irq;
> +
> +	ret = regmap_read(cs42l43->regmap, CS42L43_DEVID, &devid);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to read devid: %d\n", ret);
> +		goto err;
> +	}
> +
> +	switch (devid) {
> +	case 0x42a43:
> +		break;
> +	default:
> +		dev_err(cs42l43->dev, "Unrecognised devid: 0x%06x\n", devid);
> +		goto err;
> +	}
> +
> +	ret = regmap_read(cs42l43->regmap, CS42L43_REVID, &revid);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to read rev: %d\n", ret);
> +		goto err;
> +	}
> +
> +	ret = regmap_read(cs42l43->regmap, CS42L43_OTP_REVISION_ID, &otp);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to read otp rev: %d\n", ret);
> +		goto err;
> +	}
> +
> +	dev_info(cs42l43->dev,
> +		 "devid: 0x%06x, rev: 0x%02x, otp: 0x%02x\n", devid, revid, otp);
> +
> +	ret = cs42l43_mcu_update(cs42l43);
> +	if (ret)
> +		goto err;
> +
> +	ret = regmap_register_patch(cs42l43->regmap, cs42l43_reva_patch,
> +				    ARRAY_SIZE(cs42l43_reva_patch));
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to apply register patch: %d\n", ret);
> +		goto err;
> +	}
> +
> +	pm_runtime_mark_last_busy(cs42l43->dev);
> +	pm_runtime_put_autosuspend(cs42l43->dev);

any reason why the two pm_runtime routines are not placed last, just
before the return?

> +	ret = devm_mfd_add_devices(cs42l43->dev, PLATFORM_DEVID_NONE,
> +				   cs42l43_devs, ARRAY_SIZE(cs42l43_devs),
> +				   NULL, 0, NULL);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to add subdevices: %d\n", ret);
> +		goto err;
> +	}
> +
> +	dev_dbg(cs42l43->dev, "Successfully initialised\n");
> +
> +	return;
> +
> +err:
> +	pm_runtime_put_sync(cs42l43->dev);
> +	cs42l43_dev_remove(cs42l43);
> +}


> +int cs42l43_dev_probe(struct cs42l43 *cs42l43)
> +{
> +	int i, ret;
> +
> +	dev_set_drvdata(cs42l43->dev, cs42l43);
> +
> +	mutex_init(&cs42l43->pll_lock);
> +	init_completion(&cs42l43->device_attach);
> +	init_completion(&cs42l43->device_detach);
> +	init_completion(&cs42l43->firmware_download);
> +	INIT_WORK(&cs42l43->boot_work, cs42l43_boot_work);
> +
> +	regcache_cache_only(cs42l43->regmap, true);
> +
> +	cs42l43->reset = devm_gpiod_get_optional(cs42l43->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(cs42l43->reset)) {
> +		ret = PTR_ERR(cs42l43->reset);
> +		dev_err(cs42l43->dev, "Failed to get reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	cs42l43->vdd_p = devm_regulator_get(cs42l43->dev, "VDD_P");
> +	if (IS_ERR(cs42l43->vdd_p)) {
> +		ret = PTR_ERR(cs42l43->vdd_p);
> +		dev_err(cs42l43->dev, "Failed to get VDD_P: %d\n", ret);
> +		return ret;
> +	}
> +
> +	cs42l43->vdd_d = devm_regulator_get(cs42l43->dev, "VDD_D");
> +	if (IS_ERR(cs42l43->vdd_d)) {
> +		ret = PTR_ERR(cs42l43->vdd_d);
> +		dev_err(cs42l43->dev, "Failed to get VDD_D: %d\n", ret);
> +		return ret;
> +	}
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(cs42l43_core_supplies) != CS42L43_N_SUPPLIES);
> +
> +	for (i = 0; i < CS42L43_N_SUPPLIES; i++)
> +		cs42l43->core_supplies[i].supply = cs42l43_core_supplies[i];
> +
> +	ret = devm_regulator_bulk_get(cs42l43->dev, CS42L43_N_SUPPLIES,
> +				      cs42l43->core_supplies);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to get core supplies: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = cs42l43_power_up(cs42l43);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_set_autosuspend_delay(cs42l43->dev, 250);
> +	pm_runtime_use_autosuspend(cs42l43->dev);
> +	pm_runtime_set_active(cs42l43->dev);> +	pm_runtime_get_noresume(cs42l43->dev);

you probably want a comment to explain that the get_noresume() is
intentional to prevent the device from suspending before the workqueue
is handled.

> +	pm_runtime_enable(cs42l43->dev);
> +
> +	queue_work(system_long_wq, &cs42l43->boot_work);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cs42l43_dev_probe, MFD_CS42L43);

> +static int __maybe_unused cs42l43_suspend(struct device *dev)
> +{
> +	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
> +	int ret;
> +
> +	dev_dbg(cs42l43->dev, "System suspend\n");
> +
> +	/*
> +	 * Don't care about being resumed here, but we do want force_resume to
> +	 * always trigger an actual resume, so that register state for the
> +	 * MCU/GPIOs is returned as soon as possible after system resume
> +	 */
> +	pm_runtime_get_noresume(dev);
> +
> +	ret = pm_runtime_force_suspend(dev);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to force suspend: %d\n", ret);
> +		return ret;
> +	}
> +
> +	pm_runtime_put_noidle(dev);

Is the get_noresume/put_noidle useful here? What does it do?

And it seems wrong anyways, if pm_runtime_force_suspend() fails then the
usage-count is not decreased.

Surprising sequence...

> +
> +	ret = cs42l43_power_down(cs42l43);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused cs42l43_resume(struct device *dev)
> +{
> +	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
> +	int ret;
> +
> +	dev_dbg(cs42l43->dev, "System resume\n");
> +
> +	ret = cs42l43_power_up(cs42l43);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to force resume: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused cs42l43_runtime_suspend(struct device *dev)
> +{
> +	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
> +
> +	dev_dbg(cs42l43->dev, "Runtime suspend\n");
> +
> +	/*
> +	 * Whilst we don't power the chip down here, going into runtime
> +	 * suspend lets the SoundWire bus power down, which means we can't
> +	 * communicate with the device any more.
> +	 */
> +	regcache_cache_only(cs42l43->regmap, true);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused cs42l43_runtime_resume(struct device *dev)
> +{
> +	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
> +	unsigned int reset_canary;
> +	int ret;
> +
> +	dev_dbg(cs42l43->dev, "Runtime resume\n");
> +
> +	ret = cs42l43_wait_for_attach(cs42l43);

is there a specific reason why the existing initialization_complete is
not used?

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(cs42l43->regmap, CS42L43_RELID, &reset_canary);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to check reset canary: %d\n", ret);
> +		goto err;
> +	}
> +
> +	if (!reset_canary) {
> +		/*
> +		 * If the canary has cleared the chip has reset, re-handle the
> +		 * MCU and mark the cache as dirty to indicate the chip reset.
> +		 */
> +		ret = cs42l43_mcu_update(cs42l43);
> +		if (ret)
> +			goto err;
> +
> +		regcache_mark_dirty(cs42l43->regmap);
> +	}
> +
> +	ret = regcache_sync(cs42l43->regmap);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to restore register cache: %d\n", ret);
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	regcache_cache_only(cs42l43->regmap, true);
> +
> +	return ret;
> +}
