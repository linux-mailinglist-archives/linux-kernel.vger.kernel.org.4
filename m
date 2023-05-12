Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD11700AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbjELOyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240862AbjELOyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:54:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D712684;
        Fri, 12 May 2023 07:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683903261; x=1715439261;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6saWosouMLDzYlSpYW/bFTK6PyfiECPlNWIHcYbRx5Q=;
  b=mxlK70rR7I+KGv2LMdgHq0da/pjR8c3ZMWHZjS146a2vKQoJUPdZVxke
   ecgd6N1XqcuSbBq5gvHjefiVbcHqCI/gj2bKtN7Sq2n6In0rPPKf/cVT7
   7RalvsuyPL+DB8QwcQgztDH5ctc+UNKTi+GwxpiXhUhrWuNNg+m/0Jol1
   X/RdJz6P9UQ6MM/usqiqCHtZ8E3ca89mNc4TXZs9/xGzcGn+joDZY4nE2
   KtT7dyExsfaXhscZUUJ4P+93/8e5HoHyb9Oiu3dT86CMyBLYFG6L3lLC/
   Cf2TD/V6TV588Kd+RKuxGsfqDuxLMWI1NBez/TD+sEDYe0nKkKfo9z4TW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="437140389"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="437140389"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:54:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="844441268"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="844441268"
Received: from winkelru-mobl.amr.corp.intel.com (HELO [10.212.144.249]) ([10.212.144.249])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:54:19 -0700
Message-ID: <0471f085-14bf-c159-9b92-62983af6c19a@linux.intel.com>
Date:   Fri, 12 May 2023 08:45:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 01/10] soundwire: bus: Allow SoundWire peripherals to
 register IRQ handlers
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
 <20230512122838.243002-2-ckeepax@opensource.cirrus.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230512122838.243002-2-ckeepax@opensource.cirrus.com>
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




> @@ -1711,6 +1739,9 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>  				struct device *dev = &slave->dev;
>  				struct sdw_driver *drv = drv_to_sdw_driver(dev->driver);
>  
> +				if (slave->prop.use_domain_irq && slave->irq)
> +					handle_nested_irq(slave->irq);
> +

I am a bit lost here, I can understand that alerts would be handled by a
dedicated handler, but here the code continues and will call the
existing interrupt_callback.

Is this intentional? I wonder if there's a risk with two entities
dealing with the same event and programming the same registers.
Shouldn't there be some sort of 'either or' rule?

>  				if (drv->ops && drv->ops->interrupt_callback) {
>  					slave_intr.sdca_cascade = sdca_cascade;
>  					slave_intr.control_port = clear;
> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
> index 1f43ee848eac8..fafbc284e82da 100644
> --- a/drivers/soundwire/bus_type.c
> +++ b/drivers/soundwire/bus_type.c
> @@ -122,6 +122,12 @@ static int sdw_drv_probe(struct device *dev)
>  	if (drv->ops && drv->ops->read_prop)
>  		drv->ops->read_prop(slave);
>  
> +	if (slave->prop.use_domain_irq) {
> +		slave->irq = irq_create_mapping(slave->bus->domain, slave->dev_num);
> +		if (!slave->irq)
> +			dev_warn(dev, "Failed to map IRQ\n");
> +	}
> +
>  	/* init the sysfs as we have properties now */
>  	ret = sdw_slave_sysfs_init(slave);
>  	if (ret < 0)
> @@ -166,7 +172,13 @@ static int sdw_drv_remove(struct device *dev)
>  	int ret = 0;
>  
>  	mutex_lock(&slave->sdw_dev_lock);
> +
>  	slave->probed = false;
> +
> +	if (slave->prop.use_domain_irq)
> +		irq_dispose_mapping(irq_find_mapping(slave->bus->domain,
> +						     slave->dev_num));
> +
>  	mutex_unlock(&slave->sdw_dev_lock);
>  
>  	if (drv->remove)
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index ef645de13ae93..c3ab5e5f9cfa4 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -5,6 +5,8 @@
>  #define __SOUNDWIRE_H
>  
>  #include <linux/bug.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/bitfield.h>
>  
> @@ -369,6 +371,7 @@ struct sdw_dpn_prop {
>   * @clock_reg_supported: the Peripheral implements the clock base and scale
>   * registers introduced with the SoundWire 1.2 specification. SDCA devices
>   * do not need to set this boolean property as the registers are required.
> + * @use_domain_irq: call actual IRQ handler on slave, as well as callback

what callback, the interrupt_callback? That would mean the interrupt is
handled twice?

I am probably missing something here?

>   */
>  struct sdw_slave_prop {
>  	u32 mipi_revision;
> @@ -393,6 +396,7 @@ struct sdw_slave_prop {
>  	u8 scp_int1_mask;
>  	u32 quirks;
>  	bool clock_reg_supported;
> +	bool use_domain_irq;
>  };
