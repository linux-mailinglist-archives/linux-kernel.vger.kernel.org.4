Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F64F673FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjASROM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjASROG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:14:06 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD5B78A85
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674148444; x=1705684444;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3PfvGA6LG6n0VOKqUA3+pvpEy/KwfivVBi7XGfFWq54=;
  b=VKPJnIyrtg7c3uOASQj8qFfTJ0ZNGAaboo6ku+6Xx8Af4i8d6p5RPMJ0
   mRYX/5jppTY2YoRGhiZm1H+hYqpzALEliSLTAPMnM/Bsek0331x07ya25
   8vJt9y3xTbNeAJ6OnQI0+R8WILyAM5lZlM/IST21GMnki8OKdfpKBKIfv
   IqLkC3SisB9hclxHX3xSiSpb6KLj854BIgB3+/dkar5+PXdynZzZh0LbA
   8XJdPTlUhiMYwDTouVp692ktyb+1Cb22JDN1kyYDiXE7efbOAHlbKp2ws
   5bduK2EPi9AOCmmz5nKQrSpW1cp7NMBMSWdgCzZKtD4Hdsy8ZV32AVivJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="325391664"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="325391664"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 09:12:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="728786641"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="728786641"
Received: from sahamad-mobl1.amr.corp.intel.com (HELO [10.213.187.97]) ([10.213.187.97])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 09:12:05 -0800
Message-ID: <c05a6791-96a7-2b10-d353-eb7b316aefc8@linux.intel.com>
Date:   Thu, 19 Jan 2023 11:12:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] soundwire: bus: Allow SoundWire peripherals to
 register IRQ handlers
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230119165104.3433290-1-ckeepax@opensource.cirrus.com>
 <20230119165104.3433290-2-ckeepax@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230119165104.3433290-2-ckeepax@opensource.cirrus.com>
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

No objection on this addition, just a couple of comments to improve it:

>  EXPORT_SYMBOL(sdw_bus_master_add);
> @@ -158,6 +183,8 @@ static int sdw_delete_slave(struct device *dev, void *data)
>  	mutex_lock(&bus->bus_lock);
>  
>  	if (slave->dev_num) { /* clear dev_num if assigned */
> +		irq_dispose_mapping(irq_find_mapping(bus->domain, slave->dev_num));
> +

could this be done conditionally. e.g.

if (slave->prop.irq)
    irq_dispose_mapping(irq_find_mapping(bus->domain, slave->dev_num));

...

>  		clear_bit(slave->dev_num, bus->assigned);
>  		if (bus->dev_num_ida_min)
>  			ida_free(&sdw_peripheral_ida, slave->dev_num);
> @@ -178,6 +205,9 @@ static int sdw_delete_slave(struct device *dev, void *data)
>  void sdw_bus_master_delete(struct sdw_bus *bus)
>  {
>  	device_for_each_child(bus->dev, NULL, sdw_delete_slave);
> +
> +	irq_domain_remove(bus->domain);
> +
>  	sdw_master_device_del(bus);
>  
>  	sdw_bus_debugfs_exit(bus);
> @@ -717,6 +747,12 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
>  			slave->dev_num = dev_num;
>  			slave->dev_num_sticky = dev_num;
>  			new_device = true;
> +
> +			slave->irq = irq_create_mapping(bus->domain, dev_num);
> +			if (!slave->irq) {
> +				dev_err(bus->dev, "Failed to map IRQ\n");
> +				return -EINVAL;
> +			}

...and here....

if (slave->prop.irq) {
	slave->irq = irq_create_mapping(bus->domain, dev_num);
	if (!slave->irq) {
		dev_err(bus->dev, "Failed to map IRQ\n");
		return -EINVAL;
	}
}

>  		} else {
>  			slave->dev_num = slave->dev_num_sticky;
>  		}
> @@ -1682,6 +1718,9 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>  				struct device *dev = &slave->dev;
>  				struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
>  
> +				if (slave->prop.irq && slave->irq)
> +					handle_nested_irq(slave->irq);

.... that would be consistent with this conditional use.


> @@ -369,6 +371,7 @@ struct sdw_dpn_prop {
>   * @clock_reg_supported: the Peripheral implements the clock base and scale
>   * registers introduced with the SoundWire 1.2 specification. SDCA devices
>   * do not need to set this boolean property as the registers are required.
> + * @irq: call actual IRQ handler on slave, as well as callback
>   */
>  struct sdw_slave_prop {
>  	u32 mipi_revision;
> @@ -393,6 +396,7 @@ struct sdw_slave_prop {
>  	u8 scp_int1_mask;
>  	u32 quirks;
>  	bool clock_reg_supported;
> +	bool irq;

this can be confused with the 'wake_capable' property.

maybe 'out_of_band_irq' ?

There should be an explanation and something checking that both are not
used concurrently.
