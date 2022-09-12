Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253DF5B59C8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiILMAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiILMAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:00:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3D513E03
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 05:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662984004; x=1694520004;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X2vL0QfGvfcJedB7T4NQXZPHTO62VdP8mJAlZZ57BQQ=;
  b=FoR/SySjWNnYxDbIK1Naql/OMRCEKQSGuUwTBaYtq7v3K38RMKEXa1Mc
   wQquTlxnKVaXubYmasMPvsFF2gxV4sE608QMbcp/BkigKM9iboPIyM6S1
   ABo/5me+n9HV4hx3xwehPRFrsXE6Wdvb4a04DBZruR0s+1XYU2RZbKp8a
   S/8rQd2T7P9PbJLs98PqPiB6UrC+NV6JQ2+ZU4JRiesuEDtpQdRedAj4q
   EoTAeQEhqH62SYBRHyqF9sijOKsopFLJo50iu/TStkyexZd56npYtml9m
   ZN15zae7rTWTJ4jgQ/DEQQq3fBafd5pWDin2h7e/hPuStfbcK39Lgo7kj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="299186097"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="299186097"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 05:00:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="705126409"
Received: from vtsymbal-mobl.ger.corp.intel.com (HELO [10.252.32.67]) ([10.252.32.67])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 04:59:57 -0700
Message-ID: <fde38f21-bd19-0326-ffc9-6abf6a9aff3b@linux.intel.com>
Date:   Mon, 12 Sep 2022 12:57:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 7/7] soundwire: bus: Fix premature removal of sdw_slave
 objects
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        sanyog.r.kale@intel.com, broonie@kernel.org
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20220907101402.4685-1-rf@opensource.cirrus.com>
 <20220907101402.4685-8-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220907101402.4685-8-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/22 12:14, Richard Fitzgerald wrote:
> When the bus manager is removed sdw_bus_master_delete() should not
> be deleting the struct sdw_slave objects until the bus manager has
> been stopped. The first step of removing child drivers should only
> be calling device_unregister() on the child. The counterpart to
> sdw_drv_probe() is sdw_drv_remove(), not sdw_delete_slave().
> 
> The sdw_slave objects are created by the bus manager probe() from
> ACPI/DT information. They are not created when a child driver probes
> so should not be deleted by a child driver remove.
> 
> Change-Id: I25cc145df12fdc7c126f8f594a5f76eedce25488

spurious Change-Id

> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/soundwire/bus.c   | 30 ++++++++++++++++++++++++++----
>  drivers/soundwire/slave.c | 21 +++++++++++++++++----
>  2 files changed, 43 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 1327a312be86..5533eb589286 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -146,9 +146,8 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
>  }
>  EXPORT_SYMBOL(sdw_bus_master_add);
>  
> -static int sdw_delete_slave(struct device *dev, void *data)
> +static int sdw_delete_slave(struct sdw_slave *slave)
>  {
> -	struct sdw_slave *slave = dev_to_sdw_dev(dev);
>  	struct sdw_bus *bus = slave->bus;
>  
>  	sdw_slave_debugfs_exit(slave);
> @@ -163,7 +162,24 @@ static int sdw_delete_slave(struct device *dev, void *data)
>  	list_del_init(&slave->node);
>  	mutex_unlock(&bus->bus_lock);
>  
> +	mutex_destroy(&slave->sdw_dev_lock);
> +	kfree(slave);
> +
> +	return 0;
> +}
> +
> +static int sdw_remove_child(struct device *dev, void *data)
> +{
> +	/*
> +	 * Do not remove the struct sdw_slave yet. This is created by
> +	 * the bus manager probe() from ACPI information and used by the
> +	 * bus manager to hold status of each peripheral. Its lifetime
> +	 * is that of the bus manager.
> +	 */
> +
> +	/* This will call sdw_drv_remove() */
>  	device_unregister(dev);
> +
>  	return 0;
>  }
>  
> @@ -171,16 +187,22 @@ static int sdw_delete_slave(struct device *dev, void *data)
>   * sdw_bus_master_delete() - delete the bus master instance
>   * @bus: bus to be deleted
>   *
> - * Remove the instance, delete the child devices.
> + * Remove the child devices, remove the master instance.
>   */
>  void sdw_bus_master_delete(struct sdw_bus *bus)
>  {
> -	device_for_each_child(bus->dev, NULL, sdw_delete_slave);
> +	struct sdw_slave *slave, *tmp;
> +
> +	device_for_each_child(bus->dev, NULL, sdw_remove_child);
>  
>  	/* Children have been removed so it is now safe for the bus to stop */
>  	if (bus->ops->remove)
>  		bus->ops->remove(bus);
>  
> +	/* Now the bus is stopped it is safe to free things */
> +	list_for_each_entry_safe(slave, tmp, &bus->slaves, node)
> +		sdw_delete_slave(slave);
> +
>  	sdw_master_device_del(bus);
>  
>  	sdw_bus_debugfs_exit(bus);
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index c1c1a2ac293a..b6161d002b97 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -10,10 +10,23 @@
>  
>  static void sdw_slave_release(struct device *dev)
>  {
> -	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> -
> -	mutex_destroy(&slave->sdw_dev_lock);
> -	kfree(slave);
> +	/*
> +	 * The release() callback should not be empty
> +	 * (see Documentation/core-api/kobject.rst) but the ownership
> +	 * of struct sdw_slave is muddled. It is used for two separate
> +	 * purposes:
> +	 * 1) by the bus driver to track its own state information for
> +	 *    physical devices on the bus and found in ACPI/DT, whether
> +	 *    or not there is a child driver for it;
> +	 * 2) to hold the child driver object.
> +	 *
> +	 * The struct sdw_slave cannot be freed when the child driver
> +	 * is released because it is holding info used by the bus
> +	 * driver. It is freed when the bus driver is removed.
> +	 *
> +	 * Until the ownership issue is untangled this cannot free
> +	 * the struct sdw_slave object containing the child dev.
> +	 */
>  }
>  
>  struct device_type sdw_slave_type = {
