Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD99B69E555
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjBUQ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjBUQ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:58:58 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE33B2279A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676998734; x=1708534734;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L9NPR+Zq1qFdZyeHHPaPHPgPLrfPEEPJFtM2qLEzmnA=;
  b=Zy+f0ivKA3XBlBv4q+9AmtWmxtxN/9UZVY/iYnq2mrchQW/v8UynrR2M
   7r3ytjKwQLYPCoenkJjjwLwPOOBSzYqmbenyUljrEQ7D72pSElDlaVp0W
   ZgHsypxzlA4g8H6SRT2Pd4PzwUpWypb+Gx/8piFcYsyEGhbW9zwS8/saw
   v74yFOvO/IgM5caDrY8eUFFtGglAJmunrf44/+o+oaVa0R8yqV7t4PHSu
   TMxTD8YIl/zw5vX9J9eyzs1cAqH8YBWM5U4jn0ndQj8iQBwB2kFFMBt8h
   A1cMcyqvSY0sr8jcNWVoMNOWuGmeRKt743owI8SF4NWl12BtLRIxgw6Xt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="334884709"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="334884709"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:58:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="814569131"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="814569131"
Received: from taevough-mobl.amr.corp.intel.com (HELO [10.209.174.213]) ([10.209.174.213])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:58:43 -0800
Message-ID: <2d55b8c9-e7f9-6b2e-aad8-5cc902d69000@linux.intel.com>
Date:   Tue, 21 Feb 2023 11:45:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 08/10] ASoC: cs35l56: Add driver for Cirrus Logic CS35L56
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
        cezary.rojewski@intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, kai.vehmanen@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230217161410.915202-1-rf@opensource.cirrus.com>
 <20230217161410.915202-9-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230217161410.915202-9-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +static int cs35l56_sdw_interrupt(struct sdw_slave *peripheral,
> +				 struct sdw_slave_intr_status *status)
> +{
> +	struct cs35l56_private *cs35l56 = dev_get_drvdata(&peripheral->dev);
> +
> +	/* SoundWire core holds our pm_runtime when calling this function. */
> +
> +	dev_dbg(cs35l56->dev, "int control_port=%#x\n", status->control_port);
> +
> +	if ((status->control_port & SDW_SCP_INT1_IMPL_DEF) == 0)
> +		return 0;
> +
> +	/* Prevent host controller suspending before we handle the interrupt */
> +	pm_runtime_get_noresume(cs35l56->dev);

can this happen that the manager suspends in this function?

Or is this needed because of the queued work which the manager has no
knowledge of?

> +
> +	/*
> +	 * Mask and clear until it has been handled. The read of GEN_INT_STAT_1
> +	 * is required as per the SoundWire spec for interrupt status bits
> +	 * to clear. GEN_INT_MASK_1 masks the _inputs_ to GEN_INT_STAT1.
> +	 * None of the interrupts are time-critical so use the
> +	 * power-efficient queue.
> +	 */
> +	sdw_write_no_pm(peripheral, CS35L56_SDW_GEN_INT_MASK_1, 0);
> +	sdw_read_no_pm(peripheral, CS35L56_SDW_GEN_INT_STAT_1);
> +	sdw_write_no_pm(peripheral, CS35L56_SDW_GEN_INT_STAT_1, 0xFF);
> +	queue_work(system_power_efficient_wq, &cs35l56->sdw_irq_work);
> +
> +	return 0;
> +}

> +static int __maybe_unused cs35l56_sdw_handle_unattach(struct cs35l56_private *cs35l56)
> +{
> +	struct sdw_slave *peripheral = cs35l56->sdw_peripheral;
> +
> +	if (peripheral->unattach_request) {
> +		/* Cannot access registers until master re-attaches. */

not sure what the comment means, the manager does not attach. did you
mean resume the bus?

> +		dev_dbg(cs35l56->dev, "Wait for initialization_complete\n");
> +		if (!wait_for_completion_timeout(&peripheral->initialization_complete,
> +						 msecs_to_jiffies(5000))) {
> +			dev_err(cs35l56->dev, "initialization_complete timed out\n");
> +			return -ETIMEDOUT;
> +		}
> +
> +		peripheral->unattach_request = 0;
> +
> +		/*
> +		 * Don't call regcache_mark_dirty(), we can't be sure that the
> +		 * Manager really did issue a Bus Reset.
> +		 */
> +	}
> +
> +	return 0;
> +}
...

> +static void cs35l56_dsp_work(struct work_struct *work)
> +{
> +	struct cs35l56_private *cs35l56 = container_of(work,
> +						       struct cs35l56_private,
> +						       dsp_work);
> +	unsigned int reg;
> +	unsigned int val;
> +	int ret = 0;
> +
> +	if (!wait_for_completion_timeout(&cs35l56->init_completion,
> +					 msecs_to_jiffies(5000))) {
> +		dev_err(cs35l56->dev, "%s: init_completion timed out\n", __func__);
> +		goto complete;
> +	}
> +
> +	if (!cs35l56->init_done || cs35l56->removing)
> +		goto complete;
> +
> +	cs35l56->dsp.part = devm_kasprintf(cs35l56->dev, GFP_KERNEL, "cs35l56%s-%02x",
> +					   cs35l56->secured ? "s" : "", cs35l56->rev);
> +
> +	if (!cs35l56->dsp.part)
> +		goto complete;
> +
> +	pm_runtime_get_sync(cs35l56->dev);

test that this is successful?

> +
> +	/*
> +	 * Disable SoundWire interrupts to prevent race with IRQ work.
> +	 * Setting sdw_irq_no_unmask prevents the handler re-enabling
> +	 * the SoundWire interrupt.
> +	 */
> +	if (cs35l56->sdw_peripheral) {
> +		cs35l56->sdw_irq_no_unmask = true;
> +		cancel_work_sync(&cs35l56->sdw_irq_work);
> +		sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_MASK_1, 0);
> +		sdw_read_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_STAT_1);
> +		sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_STAT_1, 0xFF);
> +	}
> +
> +	ret = cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_SHUTDOWN);
> +	if (ret) {
> +		dev_dbg(cs35l56->dev, "%s: CS35L56_MBOX_CMD_SHUTDOWN ret %d\n", __func__, ret);
> +		goto err;
> +	}
> +
> +	if (cs35l56->rev < CS35L56_REVID_B0)
> +		reg = CS35L56_DSP1_PM_CUR_STATE_A1;
> +	else
> +		reg = CS35L56_DSP1_PM_CUR_STATE;
> +
> +	ret = regmap_read_poll_timeout(cs35l56->regmap, reg,
> +				       val, (val == CS35L56_HALO_STATE_SHUTDOWN),
> +				       CS35L56_HALO_STATE_POLL_US,
> +				       CS35L56_HALO_STATE_TIMEOUT_US);
> +	if (ret < 0)
> +		dev_err(cs35l56->dev, "Failed to poll PM_CUR_STATE to 1 is %d (ret %d)\n",
> +			val, ret);
> +
> +	/* Use wm_adsp to load and apply the firmware patch and coefficient files */
> +	ret = wm_adsp_power_up(&cs35l56->dsp);
> +	if (ret) {
> +		dev_dbg(cs35l56->dev, "%s: wm_adsp_power_up ret %d\n", __func__, ret);
> +		goto err;
> +	}
> +
> +	if (cs35l56->removing)
> +		goto err;
> +
> +	mutex_lock(&cs35l56->irq_lock);
> +
> +	init_completion(&cs35l56->init_completion);
> +
> +	cs35l56_system_reset(cs35l56);
> +
> +	if (cs35l56->sdw_peripheral) {
> +		if (!wait_for_completion_timeout(&cs35l56->init_completion,
> +						 msecs_to_jiffies(5000))) {
> +			dev_err(cs35l56->dev, "%s: init_completion timed out (SDW)\n", __func__);

shouldn't do the same routine as for a regular pm_runtime resume,
including re-synching regmaps?


> +			goto err_unlock;
> +		}
> +	} else {
> +		if (cs35l56_init(cs35l56))
> +			goto err_unlock;
> +	}
> +
> +	cs35l56->fw_patched = true;
> +
> +err_unlock:
> +	mutex_unlock(&cs35l56->irq_lock);
> +err:
> +	pm_runtime_mark_last_busy(cs35l56->dev);
> +	pm_runtime_put_autosuspend(cs35l56->dev);
> +
> +	/* Re-enable SoundWire interrupts */
> +	if (cs35l56->sdw_peripheral) {
> +		cs35l56->sdw_irq_no_unmask = false;
> +		sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_MASK_1,
> +				CS35L56_SDW_INT_MASK_CODEC_IRQ);
> +	}
> +
> +complete:
> +	complete_all(&cs35l56->dsp_ready_completion);
> +}
