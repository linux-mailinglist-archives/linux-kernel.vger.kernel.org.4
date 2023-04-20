Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B636E9E06
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 23:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjDTVlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 17:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjDTVlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 17:41:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE01A10D9;
        Thu, 20 Apr 2023 14:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682026904; x=1713562904;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZmQWpwgdjAztW3K7d1k7ytOjttMhc4M4Ah1cz86V6is=;
  b=P2dEN0K5xZ3lVlodY/oVnpVWuCUF9hUI3cCEsqVbeEAEshB3Djksmt4d
   PzG/IY2dyQWcVOV0FkzVVI+3mClfNjXiOwFgJUSARVPU5zbMWTmKoTgpk
   IOAx3qMCJGZ1XfuDAOopDPzO9T/yMmtcaqpAeTyOoJr9r4lDe0FmpsKz4
   Vf8THD3n7/1gSxSm6LrvYO4gpielSl+lgs40WAYbBe5SORANVL9zOBy+J
   h0PSjFeHK25JX3DPu6HV5R8TMIwz05+1Nbjf53tqk9c5hcxmkitrg8skw
   JorsG/2l2WXl7OMkPgL8+MHz+DD1iKV8qe4AgslyiX9vXWy+p7cLl0Gkc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="334725966"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="334725966"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 14:41:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="803487035"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="803487035"
Received: from mprabhug-mobl.amr.corp.intel.com (HELO [10.209.102.50]) ([10.209.102.50])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 14:41:42 -0700
Message-ID: <28141433-2130-e278-0f59-d9ab507b9be3@linux.intel.com>
Date:   Thu, 20 Apr 2023 16:37:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 6/6] soundwire: qcom: do not probe devices before bus/link
 init
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Patrick Lai <quic_plai@quicinc.com>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
 <20230420101617.142225-7-krzysztof.kozlowski@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230420101617.142225-7-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/23 05:16, Krzysztof Kozlowski wrote:
> Soundwire devices are supposed to be kept in reset state (powered off)
> till their probe() or component bind() callbacks.  However if they are
> already powered on, then they might enumerate before the master
> initializes bus in qcom_swrm_init() leading to occasional errors like:

The problem statement is really hard to follow.

The peripheral can only be enumerated AFTER
a) the manager starts the bus clock and transmitting PING frames
b) the peripheral detects the sync words for 16 frames in a row.
c) the peripheral reports as Attached in the Device0 slot

That sequence holds whether the manager does the enumeration manually or
relies on hardware-assisted autoenumeration. This is what the spec requires.

So why can't the bus clock start be controlled by the manager driver,
and started once all required initializations are done?

I mean, there's got to be some sort of parent-child hierarchy with
manager first, peripheral(s) second, I don't get how these steps could
be inverted or race.

>   qcom-soundwire 6d30000.soundwire-controller: Qualcomm Soundwire controller v2.0.0 Registered
>   wcd938x_codec audio-codec: bound sdw:0:0217:010d:00:4 (ops wcd938x_sdw_component_ops)
>   wcd938x_codec audio-codec: bound sdw:0:0217:010d:00:3 (ops wcd938x_sdw_component_ops)
>   qcom-soundwire 6ad0000.soundwire-controller: swrm_wait_for_wr_fifo_avail err write overflow
> 
> The problem primarily lies in Qualcomm Soundwire controller probe() sequence:
> 1. request_threaded_irq()
> 2. sdw_bus_master_add() - which will cause probe() and component bind()
>    of Soundwire devices, e.g. WCD938x codec drivers.  Device drivers
>    might already start accessing their registers.

not if the bus clock hasn't started...

> 3. qcom_swrm_init() - which initializes the link/bus and enables
>    interrupts.

if you can move the clock start in 3) then problem solved. Why can't
this be done?

> Any access to device registers at (2) above, will fail because link/bus
> is not yet initialized.
> 
> However the fix is not as simple as moving qcom_swrm_init() before
> sdw_bus_master_add(), because this will cause early interrupt of new
> slave attached.  The interrupt handler expects bus master (ctrl->bus.md)
> to be allocated, so this would lead to NULL pointer exception.
> 
> Rework the init sequence and change the interrupt handler.  The correct
> sequence fixing accessing device registers before link init is now:
> 1. qcom_swrm_init()
> 2. request_threaded_irq()
> 3. sdw_bus_master_add()
> which still might cause early interrupts, if Soundwire devices are not
> in powered off state before their probe.  This early interrupt issue is

You'd need to clarify in which step the bus clock starts. In general,
you want to clock started last.

> fixed by checking if bus master (ctrl->bus.md) was allocated and if not,
> scheduling delayed work for enumerating the slave device.  Since we
> actually can handle early interrupt now, drop IRQF_TRIGGER_RISING flag
> from the interrupt, because it is not really valid and driver should use
> flags provided by DTS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Change context depends on:
> https://lore.kernel.org/r/20230209131336.18252-3-srinivas.kandagatla@linaro.org
> https://lore.kernel.org/all/20230418095447.577001-1-krzysztof.kozlowski@linaro.org/
> 
> Cc: Patrick Lai <quic_plai@quicinc.com>
> ---
>  drivers/soundwire/qcom.c | 89 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 72 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 679990dc3cc4..802d939ce7aa 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -19,6 +19,7 @@
>  #include <linux/slimbus.h>
>  #include <linux/soundwire/sdw.h>
>  #include <linux/soundwire/sdw_registers.h>
> +#include <linux/workqueue.h>
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
>  #include "bus.h"
> @@ -187,6 +188,7 @@ struct qcom_swrm_ctrl {
>  #endif
>  	struct completion broadcast;
>  	struct completion enumeration;
> +	struct delayed_work new_slave_work;
>  	/* Port alloc/free lock */
>  	struct mutex port_lock;
>  	struct clk *hclk;
> @@ -606,6 +608,37 @@ static int qcom_swrm_enumerate(struct sdw_bus *bus)
>  	return 0;
>  }
>  
> +static void qcom_swrm_new_slave(struct work_struct *work)
> +{
> +	struct qcom_swrm_ctrl *ctrl = container_of(work, struct qcom_swrm_ctrl,
> +						   new_slave_work.work);
> +
> +	/*
> +	 * All Soundwire slave deviecs are expected to be in reset state (powered down)
> +	 * during sdw_bus_master_add().  The slave device should be brougth

typo/grammar: brought out of reset

> +	 * from reset by its probe() or bind() function, as a result of
> +	 * sdw_bus_master_add().
> +	 * Add a simple check to avoid NULL pointer except on early interrupts.
> +	 * Note that if this condition happens, the slave device will not be
> +	 * enumerated. Its driver should be fixed.

???

The codec driver is NEVER involved in enumeration.

The only thing a codec driver should do is provide a callback to be
notified of a status change for additional initialization, but the
enumeration can be done even in the absence of a codec driver.

The proof in the pudding is that you can 'blacklist' a codec driver and
bind it later, after the hardware is enumerated. You can even unbind a
codec driver and nothing bad will happen (we hardened that sequence last
year).

probe != enumeration != initialization for SoundWire codecs.

Probe and enumeration can happen in any order
Initialization can only happen after both probe and enumeration happened.

> +	 *
> +	 * smp_load_acquire() paired with sdw_master_device_add().
> +	 */
> +	if (!smp_load_acquire(&ctrl->bus.md)) {
> +		dev_err(ctrl->dev,
> +			"Got unexpected, early interrupt, device will not be enumerated\n");
> +		return;
> +	}
> +
> +	clk_prepare_enable(ctrl->hclk);
> +
> +	qcom_swrm_get_device_status(ctrl);
> +	qcom_swrm_enumerate(&ctrl->bus);
> +	sdw_handle_slave_status(&ctrl->bus, ctrl->status);
> +
> +	clk_disable_unprepare(ctrl->hclk);
> +};
> +
>  static irqreturn_t qcom_swrm_wake_irq_handler(int irq, void *dev_id)
>  {
>  	struct qcom_swrm_ctrl *ctrl = dev_id;
> @@ -668,9 +701,17 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>  					dev_dbg(ctrl->dev, "Slave status not changed %x\n",
>  						slave_status);
>  				} else {
> -					qcom_swrm_get_device_status(ctrl);
> -					qcom_swrm_enumerate(&ctrl->bus);
> -					sdw_handle_slave_status(&ctrl->bus, ctrl->status);
> +					unsigned long delay = 0;
> +
> +					/*
> +					 * See qcom_swrm_new_slave() for
> +					 * explanation. smp_load_acquire() paired
> +					 * with sdw_master_device_add().
> +					 */
> +					if (!smp_load_acquire(&ctrl->bus.md))
> +						delay = 10;
> +					schedule_delayed_work(&ctrl->new_slave_work,
> +							      delay);
>  				}
>  				break;
>  			case SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET:
> @@ -780,6 +821,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>  
>  	ctrl->intr_mask = SWRM_INTERRUPT_STATUS_RMSK;
>  	/* Mask soundwire interrupts */
> +
>  	if (ctrl->version < SWRM_VERSION_2_0_0)
>  		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
>  				SWRM_INTERRUPT_STATUS_RMSK);
> @@ -1485,6 +1527,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  	mutex_init(&ctrl->port_lock);
>  	init_completion(&ctrl->broadcast);
>  	init_completion(&ctrl->enumeration);
> +	INIT_DELAYED_WORK(&ctrl->new_slave_work, qcom_swrm_new_slave);
>  
>  	ctrl->bus.ops = &qcom_swrm_ops;
>  	ctrl->bus.port_ops = &qcom_swrm_port_ops;
> @@ -1514,9 +1557,10 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  
>  	ctrl->reg_read(ctrl, SWRM_COMP_HW_VERSION, &ctrl->version);
>  
> +	qcom_swrm_init(ctrl);
> +
>  	ret = devm_request_threaded_irq(dev, ctrl->irq, NULL,
>  					qcom_swrm_irq_handler,
> -					IRQF_TRIGGER_RISING |
>  					IRQF_ONESHOT,
>  					"soundwire", ctrl);
>  	if (ret) {
> @@ -1524,18 +1568,6 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  		goto err_clk;
>  	}
>  
> -	ctrl->wake_irq = of_irq_get(dev->of_node, 1);
> -	if (ctrl->wake_irq > 0) {
> -		ret = devm_request_threaded_irq(dev, ctrl->wake_irq, NULL,
> -						qcom_swrm_wake_irq_handler,
> -						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> -						"swr_wake_irq", ctrl);
> -		if (ret) {
> -			dev_err(dev, "Failed to request soundwire wake irq\n");
> -			goto err_init;
> -		}
> -	}
> -
>  	pm_runtime_set_autosuspend_delay(dev, 3000);
>  	pm_runtime_use_autosuspend(dev);
>  	pm_runtime_mark_last_busy(dev);
> @@ -1549,7 +1581,18 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  		goto err_clk;
>  	}
>  
> -	qcom_swrm_init(ctrl);
> +	ctrl->wake_irq = of_irq_get(dev->of_node, 1);
> +	if (ctrl->wake_irq > 0) {
> +		ret = devm_request_threaded_irq(dev, ctrl->wake_irq, NULL,
> +						qcom_swrm_wake_irq_handler,
> +						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +						"swr_wake_irq", ctrl);
> +		if (ret) {
> +			dev_err(dev, "Failed to request soundwire wake irq\n");
> +			goto err_init;
> +		}
> +	}
> +
>  	wait_for_completion_timeout(&ctrl->enumeration,
>  				    msecs_to_jiffies(TIMEOUT_MS));
>  	ret = qcom_swrm_register_dais(ctrl);
> @@ -1589,6 +1632,18 @@ static int qcom_swrm_remove(struct platform_device *pdev)
>  {
>  	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
>  
> +	/*
> +	 * Mask interrupts to be sure no delayed work can be scheduler after

typo/grammar: scheduled

> +	 * removing Soundwire bus master.
> +	 */
> +	if (ctrl->version < SWRM_VERSION_2_0_0)
> +		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_MASK_ADDR],
> +				0);
> +	if (ctrl->mmio)
> +		ctrl->reg_write(ctrl, ctrl->reg_layout[SWRM_REG_INTERRUPT_CPU_EN],
> +				0);
> +
> +	cancel_delayed_work_sync(&ctrl->new_slave_work);
>  	sdw_bus_master_delete(&ctrl->bus);
>  	clk_disable_unprepare(ctrl->hclk);

should the last two be inverted? Keeping a clock running while removing
stuff is asking for trouble.

