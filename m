Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8FD727826
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbjFHHGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjFHHGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:06:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309341BD6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9E47648EE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 07:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480A8C4339E;
        Thu,  8 Jun 2023 07:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686207975;
        bh=P79MCRt+hiRe7B8a/nvhZY8cLwClvWjf6ZV0bkWmcl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pJGw4mbNj45zXuKQqRtGgnGHaNm/XKKoY8m2Bb/9RrcDVOsL/QzkdMnzUfV8SSjgE
         xCbz8yjDL1w6EGSo79xcGw1hJtCuIo5xYuK88O/Bh8UsLzGSIRj+3DxLrxwyQhkeXN
         vuCqQ/dwP1oIRnLoyKPu8GSYyv5ug4YzdtlhKD5UPEOW6AH8PHeMY810HZvfAHRK9G
         FbOWMq3xKd8ZldvnO894r2cPp5PX8t8rqV6vdKZweaTIsXYAil2cfj/2MfJVn9BYyf
         RpuPzLdIzgKvVITgQC7dlV7uuOGTXtMfgIP7UHuXBVB5c80mBEMovQ7vZp0UIVf86q
         u44O+Xzq67d9g==
Date:   Thu, 8 Jun 2023 12:36:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 2/4] soundwire: introduce SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY
Message-ID: <ZIF94vZHzeGXfyin@matsya>
References: <20230531033736.792464-1-yung-chuan.liao@linux.intel.com>
 <20230531033736.792464-3-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531033736.792464-3-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-05-23, 11:37, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> This patch adds a new Device Number allocation strategy, with the IDA
> used only for devices that are wake-capable.
> 
> "regular" devices such as amplifiers will use Device Numbers
> [1..min_ida-1].
> 
> "wake-capable" devices such as jack or microphone codecs will use
> Device Numbers [min_ida..11].
> 
> This hybrid strategy extends the number of supported devices in a
> system by only constraining the allocation if required, e.g. in the
> case of Intel LunarLake platforms the wake-capable devices are
> required to have a unique address to use the HDaudio SDI and HDAudio
> WAKEEN/WAKESTS registers.

This seems to be a consequence of Intel hardware decisions, so I guess
best suited place for this is Intel controller, do we really want to
have this in core logic?

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/bus.c       | 26 +++++++++++++++++++++-----
>  include/linux/soundwire/sdw.h |  4 ++++
>  2 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index e8c1c55a2a73..6f465cce8369 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -159,7 +159,9 @@ static int sdw_delete_slave(struct device *dev, void *data)
>  
>  	if (slave->dev_num) { /* clear dev_num if assigned */
>  		clear_bit(slave->dev_num, bus->assigned);
> -		if (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA)
> +		if (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA ||
> +		    (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY &&
> +		     slave->prop.wake_capable))
>  			ida_free(&sdw_peripheral_ida, slave->dev_num);
>  	}
>  	list_del_init(&slave->node);
> @@ -699,17 +701,31 @@ EXPORT_SYMBOL(sdw_compare_devid);
>  /* called with bus_lock held */
>  static int sdw_get_device_num(struct sdw_slave *slave)
>  {
> +	struct sdw_bus *bus = slave->bus;
>  	int bit;
>  
> -	if (slave->bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA) {
> +	if (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA ||
> +	    (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY &&
> +	     slave->prop.wake_capable)) {
>  		bit = ida_alloc_range(&sdw_peripheral_ida,
> -				      slave->bus->dev_num_ida_min, SDW_MAX_DEVICES,
> +				      bus->dev_num_ida_min, SDW_MAX_DEVICES,
>  				      GFP_KERNEL);
>  		if (bit < 0)
>  			goto err;
>  	} else {
> -		bit = find_first_zero_bit(slave->bus->assigned, SDW_MAX_DEVICES);
> -		if (bit == SDW_MAX_DEVICES) {
> +		int max_devices = SDW_MAX_DEVICES;
> +
> +		if (bus->dev_num_alloc == SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY &&
> +		    !slave->prop.wake_capable) {
> +			max_devices = bus->dev_num_ida_min - 1;
> +
> +			/* range check */
> +			if (max_devices < 1 || max_devices > SDW_MAX_DEVICES)
> +				return -EINVAL;
> +		}
> +
> +		bit = find_first_zero_bit(bus->assigned, max_devices);
> +		if (bit == max_devices) {
>  			bit = -ENODEV;
>  			goto err;
>  		}
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 4656d6d0f3bb..8a7541ac735e 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -869,10 +869,14 @@ struct sdw_master_ops {
>   * @SDW_DEV_NUM_ALLOC_DEFAULT: unconstrained first-come-first-serve allocation,
>   * using range [1, 11]
>   * @SDW_DEV_NUM_ALLOC_IDA: IDA-based allocation, using range [ida_min, 11]
> + * @SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY: Hybrid allocation where wake-capable devices rely on
> + * IDA-based allocation and range [ida_min, 11], while regular devices rely on default
> + * allocation in range [1, ida_min - 1]
>   */
>  enum sdw_dev_num_alloc {
>  	SDW_DEV_NUM_ALLOC_DEFAULT = 0,
>  	SDW_DEV_NUM_ALLOC_IDA,
> +	SDW_DEV_NUM_ALLOC_IDA_WAKE_ONLY,
>  };
>  
>  /**
> -- 
> 2.25.1

-- 
~Vinod
