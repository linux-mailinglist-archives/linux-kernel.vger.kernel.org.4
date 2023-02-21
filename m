Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CD169E6C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBUSEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjBUSEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:04:48 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9ED16AD1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677002686; x=1708538686;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f71ElcehqpD2P1ixjpnvjYiYksBwubpwIvqQZ04sWHs=;
  b=SeNDGaLLbR7KblhyIvxCFmg/ADRKwh8p0LnGwZo+SKZTOZWDxOZ8evue
   PWrFnUp1W3WT0nA2Bi/NmbIYKdBTRRLAEflni7UHi2hcQQfWbR43fjKyj
   es+FCQg86RcrZdjErmrDfwqrcxwRv3ymiOk/ggp14uXk1CxuqT3Fmm17A
   tPFUCVHiKgklzuq8DC36ohxtA7t8EjoTkAgIkc5HqpVuIZe+iCrnKPc3o
   Xqx2Ect1PEAW1pIgjMJQQUX1lw1f9Zz4MYlmBzXiqqXthw55Jp7kHMsfd
   NyZ4TM1oe7NMeXGcxZ5Hx+pty1QYzbOhHtKlfe0Ze0dTeEga3jdohaHxA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="397398169"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="397398169"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 10:04:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="740501457"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="740501457"
Received: from taevough-mobl.amr.corp.intel.com (HELO [10.209.174.213]) ([10.209.174.213])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 10:04:14 -0800
Message-ID: <3b8dd6a8-363e-2c38-b1a5-5361fb7bff85@linux.intel.com>
Date:   Tue, 21 Feb 2023 12:58:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 08/10] ASoC: cs35l56: Add driver for Cirrus Logic CS35L56
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
        cezary.rojewski@intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, kai.vehmanen@linux.intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230217161410.915202-1-rf@opensource.cirrus.com>
 <20230217161410.915202-9-rf@opensource.cirrus.com>
 <2d55b8c9-e7f9-6b2e-aad8-5cc902d69000@linux.intel.com>
 <59866a98-077a-4645-b85b-a18fc1d65a54@opensource.cirrus.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <59866a98-077a-4645-b85b-a18fc1d65a54@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/23 12:18, Richard Fitzgerald wrote:
> On 21/02/2023 16:45, Pierre-Louis Bossart wrote:
>>
>>> +static int cs35l56_sdw_interrupt(struct sdw_slave *peripheral,
>>> +                 struct sdw_slave_intr_status *status)
>>> +{
>>> +    struct cs35l56_private *cs35l56 =
>>> dev_get_drvdata(&peripheral->dev);
>>> +
>>> +    /* SoundWire core holds our pm_runtime when calling this
>>> function. */
>>> +
>>> +    dev_dbg(cs35l56->dev, "int control_port=%#x\n",
>>> status->control_port);
>>> +
>>> +    if ((status->control_port & SDW_SCP_INT1_IMPL_DEF) == 0)
>>> +        return 0;
>>> +
>>> +    /* Prevent host controller suspending before we handle the
>>> interrupt */
>>> +    pm_runtime_get_noresume(cs35l56->dev);
>>
>> can this happen that the manager suspends in this function?
>>
>> Or is this needed because of the queued work which the manager has no
>> knowledge of?
>>
> 
> Because you issue a Bus-Reset when you suspend and clock-stop, if we
> didn't take our pm_runtime there is a small window of time where we
> could be reset before we've handled the interrupt. It's unlikely to
> happen but better to be safe than to rely on autosuspend delays.

What I meant is that the pm_runtime refcount should be increased prior
to the SoundWire core using the interrupt_callback.

So the only window I see is in the second part of in the interrupt
handling, before the workqueue is scheduled.
> 
>>> +
>>> +    /*
>>> +     * Mask and clear until it has been handled. The read of
>>> GEN_INT_STAT_1
>>> +     * is required as per the SoundWire spec for interrupt status bits
>>> +     * to clear. GEN_INT_MASK_1 masks the _inputs_ to GEN_INT_STAT1.
>>> +     * None of the interrupts are time-critical so use the
>>> +     * power-efficient queue.
>>> +     */
>>> +    sdw_write_no_pm(peripheral, CS35L56_SDW_GEN_INT_MASK_1, 0);
>>> +    sdw_read_no_pm(peripheral, CS35L56_SDW_GEN_INT_STAT_1);
>>> +    sdw_write_no_pm(peripheral, CS35L56_SDW_GEN_INT_STAT_1, 0xFF);
>>> +    queue_work(system_power_efficient_wq, &cs35l56->sdw_irq_work);
>>> +
>>> +    return 0;
>>> +}
>>
>>> +static int __maybe_unused cs35l56_sdw_handle_unattach(struct
>>> cs35l56_private *cs35l56)
>>> +{
>>> +    struct sdw_slave *peripheral = cs35l56->sdw_peripheral;
>>> +
>>> +    if (peripheral->unattach_request) {
>>> +        /* Cannot access registers until master re-attaches. */
>>
>> not sure what the comment means, the manager does not attach. did you
>> mean resume the bus?
>>
> 
> If the manager has forced us to reset we can't access the registers
> until the manager has recovered its state.

"until the manager restarted the bus and re-enumerated devices" ?

> 
>>> +        dev_dbg(cs35l56->dev, "Wait for initialization_complete\n");
>>> +        if
>>> (!wait_for_completion_timeout(&peripheral->initialization_complete,
>>> +                         msecs_to_jiffies(5000))) {
>>> +            dev_err(cs35l56->dev, "initialization_complete timed
>>> out\n");
>>> +            return -ETIMEDOUT;
>>> +        }
>>> +
>>> +        peripheral->unattach_request = 0;
>>> +
>>> +        /*
>>> +         * Don't call regcache_mark_dirty(), we can't be sure that the
>>> +         * Manager really did issue a Bus Reset.
>>> +         */
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>> ...
>>
>>> +static void cs35l56_dsp_work(struct work_struct *work)
>>> +{
>>> +    struct cs35l56_private *cs35l56 = container_of(work,
>>> +                               struct cs35l56_private,
>>> +                               dsp_work);
>>> +    unsigned int reg;
>>> +    unsigned int val;
>>> +    int ret = 0;
>>> +
>>> +    if (!wait_for_completion_timeout(&cs35l56->init_completion,
>>> +                     msecs_to_jiffies(5000))) {
>>> +        dev_err(cs35l56->dev, "%s: init_completion timed out\n",
>>> __func__);
>>> +        goto complete;
>>> +    }
>>> +
>>> +    if (!cs35l56->init_done || cs35l56->removing)
>>> +        goto complete;
>>> +
>>> +    cs35l56->dsp.part = devm_kasprintf(cs35l56->dev, GFP_KERNEL,
>>> "cs35l56%s-%02x",
>>> +                       cs35l56->secured ? "s" : "", cs35l56->rev);
>>> +
>>> +    if (!cs35l56->dsp.part)
>>> +        goto complete;
>>> +
>>> +    pm_runtime_get_sync(cs35l56->dev);
>>
>> test that this is successful?
>>
> 
> Could do. Wasn't really expecting it to fail unless the hardware is
> already broken.

it's not supposed to happen indeed, but our CI caught a couple of issues
over the last two years. Better add a check.

> 
>>> +
>>> +    /*
>>> +     * Disable SoundWire interrupts to prevent race with IRQ work.
>>> +     * Setting sdw_irq_no_unmask prevents the handler re-enabling
>>> +     * the SoundWire interrupt.
>>> +     */
>>> +    if (cs35l56->sdw_peripheral) {
>>> +        cs35l56->sdw_irq_no_unmask = true;
>>> +        cancel_work_sync(&cs35l56->sdw_irq_work);
>>> +        sdw_write_no_pm(cs35l56->sdw_peripheral,
>>> CS35L56_SDW_GEN_INT_MASK_1, 0);
>>> +        sdw_read_no_pm(cs35l56->sdw_peripheral,
>>> CS35L56_SDW_GEN_INT_STAT_1);
>>> +        sdw_write_no_pm(cs35l56->sdw_peripheral,
>>> CS35L56_SDW_GEN_INT_STAT_1, 0xFF);
>>> +    }
>>> +
>>> +    ret = cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_SHUTDOWN);
>>> +    if (ret) {
>>> +        dev_dbg(cs35l56->dev, "%s: CS35L56_MBOX_CMD_SHUTDOWN ret
>>> %d\n", __func__, ret);
>>> +        goto err;
>>> +    }
>>> +
>>> +    if (cs35l56->rev < CS35L56_REVID_B0)
>>> +        reg = CS35L56_DSP1_PM_CUR_STATE_A1;
>>> +    else
>>> +        reg = CS35L56_DSP1_PM_CUR_STATE;
>>> +
>>> +    ret = regmap_read_poll_timeout(cs35l56->regmap, reg,
>>> +                       val, (val == CS35L56_HALO_STATE_SHUTDOWN),
>>> +                       CS35L56_HALO_STATE_POLL_US,
>>> +                       CS35L56_HALO_STATE_TIMEOUT_US);
>>> +    if (ret < 0)
>>> +        dev_err(cs35l56->dev, "Failed to poll PM_CUR_STATE to 1 is
>>> %d (ret %d)\n",
>>> +            val, ret);
>>> +
>>> +    /* Use wm_adsp to load and apply the firmware patch and
>>> coefficient files */
>>> +    ret = wm_adsp_power_up(&cs35l56->dsp);
>>> +    if (ret) {
>>> +        dev_dbg(cs35l56->dev, "%s: wm_adsp_power_up ret %d\n",
>>> __func__, ret);
>>> +        goto err;
>>> +    }
>>> +
>>> +    if (cs35l56->removing)
>>> +        goto err;
>>> +
>>> +    mutex_lock(&cs35l56->irq_lock);
>>> +
>>> +    init_completion(&cs35l56->init_completion);
>>> +
>>> +    cs35l56_system_reset(cs35l56);
>>> +
>>> +    if (cs35l56->sdw_peripheral) {
>>> +        if (!wait_for_completion_timeout(&cs35l56->init_completion,
>>> +                         msecs_to_jiffies(5000))) {
>>> +            dev_err(cs35l56->dev, "%s: init_completion timed out
>>> (SDW)\n", __func__);
>>
>> shouldn't do the same routine as for a regular pm_runtime resume,
>> including re-synching regmaps?
>>
> 
> Not sure it would help. It's not the same as runtime_resume because
> we've changed the firmware and rebooted it (the firmware is retained
> in a runtime_suspend). We need to do some of the first-time init()
> code again, which we don't need to do in runtime_resume.
> 
> Also would create a circular dependency between this driver and the
> cs35l56-sdw driver. (We _could_ call our dev->pm->runtime_resume pointer
> but that's a bit ugly)

I wasn't suggesting using a pm_runtime suspend/resume cycle but rather
use a common helper called from here and from the pm_runtime_resume.

It's a suggestion only.

> 
>>
>>> +            goto err_unlock;
>>> +        }
>>> +    } else {
>>> +        if (cs35l56_init(cs35l56))
>>> +            goto err_unlock;
>>> +    }
>>> +
>>> +    cs35l56->fw_patched = true;
>>> +
>>> +err_unlock:
>>> +    mutex_unlock(&cs35l56->irq_lock);
>>> +err:
>>> +    pm_runtime_mark_last_busy(cs35l56->dev);
>>> +    pm_runtime_put_autosuspend(cs35l56->dev);
>>> +
>>> +    /* Re-enable SoundWire interrupts */
>>> +    if (cs35l56->sdw_peripheral) {
>>> +        cs35l56->sdw_irq_no_unmask = false;
>>> +        sdw_write_no_pm(cs35l56->sdw_peripheral,
>>> CS35L56_SDW_GEN_INT_MASK_1,
>>> +                CS35L56_SDW_INT_MASK_CODEC_IRQ);
>>> +    }
>>> +
>>> +complete:
>>> +    complete_all(&cs35l56->dsp_ready_completion);
>>> +}
