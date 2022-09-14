Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED525B89B5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiINOCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiINOBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:01:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF6C33428
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663164044; x=1694700044;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1ap74b2ShIK5B36wgT8k9kVTGGgttMUTr1hjPhiYPXU=;
  b=JtyfvbruDWSlq97jeKhWa9YiPTtIB9Sfq3ciijXIBEUWznn2OSm7/NT/
   VpljYEC3gYaxVoQR65Mh4jspcSvep67pLlmfI0AZPThLw2g+heuXPp5Hw
   YIejzaZ5CN6qut0fDqjlSmVFQFzwUE44z5tByt8x8zWED+zscB7SROCfB
   dCzkZyiVFl+2ZromE5r82ExR9eOhxJMvDyaW8AjTTti2RVTMUycp5sRN+
   kpkouRl7pMyxV1kuLB0kyyiQr2R8ZcQxStjWvXhZglQ7Oa9vC5xlyMGUW
   8TLRDgl6cvm2zkUKh2Dibu1Iq0R+EBt/k+mAy9VEf/H2yTCjxc3jJ/Ym0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="324688444"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="324688444"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 07:00:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="705968826"
Received: from blaesing-mobl.ger.corp.intel.com (HELO [10.249.45.209]) ([10.249.45.209])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 07:00:41 -0700
Message-ID: <3b51ec11-772c-3263-46f8-a32ccd4b89b9@linux.intel.com>
Date:   Wed, 14 Sep 2022 15:58:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 5/5] soundwire: bus: Don't exit early if no device IDs
 were programmed
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220914120949.747951-1-rf@opensource.cirrus.com>
 <20220914120949.747951-6-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220914120949.747951-6-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/22 14:09, Richard Fitzgerald wrote:
> Only exit sdw_handle_slave_status() right after calling
> sdw_program_device_num() if it actually programmed an ID into at
> least one device.
> 
> sdw_handle_slave_status() should protect itself against phantom
> device #0 ATTACHED indications. In that case there is no actual
> device still on #0. The early exit relies on there being a status
> change to ATTACHED on the reprogrammed device to trigger another
> call to sdw_handle_slave_status() which will then handle the status
> of all peripherals. If no device was actually programmed with an
> ID there won't be a new ATTACHED indication. This can lead to the
> status of other peripherals not being handled.
> 
> The status passed to sdw_handle_slave_status() is obviously always
> from a point of time in the past, and may indicate accumulated
> unhandled events (depending how the bus manager operates). It's
> possible that a device ID is reprogrammed but the last PING status
> captured state just before that, when it was still reporting on
> ID #0. Then sdw_handle_slave_status() is called with this PING info,
> just before a new PING status is available showing it now on its new
> ID. So sdw_handle_slave_status() will receive a phantom report of a
> device on #0, but it will not find one.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Nice work, thanks Richard

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> ---
>  drivers/soundwire/bus.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 6e569a875a9b..8eded1a55227 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -729,7 +729,7 @@ void sdw_extract_slave_id(struct sdw_bus *bus,
>  }
>  EXPORT_SYMBOL(sdw_extract_slave_id);
>  
> -static int sdw_program_device_num(struct sdw_bus *bus)
> +static int sdw_program_device_num(struct sdw_bus *bus, bool *programmed)
>  {
>  	u8 buf[SDW_NUM_DEV_ID_REGISTERS] = {0};
>  	struct sdw_slave *slave, *_s;
> @@ -739,6 +739,8 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>  	int count = 0, ret;
>  	u64 addr;
>  
> +	*programmed = false;
> +
>  	/* No Slave, so use raw xfer api */
>  	ret = sdw_fill_msg(&msg, NULL, SDW_SCP_DEVID_0,
>  			   SDW_NUM_DEV_ID_REGISTERS, 0, SDW_MSG_FLAG_READ, buf);
> @@ -797,6 +799,8 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>  					return ret;
>  				}
>  
> +				*programmed = true;
> +
>  				break;
>  			}
>  		}
> @@ -1756,7 +1760,7 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
>  {
>  	enum sdw_slave_status prev_status;
>  	struct sdw_slave *slave;
> -	bool attached_initializing;
> +	bool attached_initializing, id_programmed;
>  	int i, ret = 0;
>  
>  	/* first check if any Slaves fell off the bus */
> @@ -1787,14 +1791,23 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
>  
>  	if (status[0] == SDW_SLAVE_ATTACHED) {
>  		dev_dbg(bus->dev, "Slave attached, programming device number\n");
> -		ret = sdw_program_device_num(bus);
> -		if (ret < 0)
> -			dev_err(bus->dev, "Slave attach failed: %d\n", ret);
> +
>  		/*
> -		 * programming a device number will have side effects,
> -		 * so we deal with other devices at a later time
> +		 * Programming a device number will have side effects,
> +		 * so we deal with other devices at a later time.
> +		 * This relies on those devices reporting ATTACHED, which will
> +		 * trigger another call to this function. This will only
> +		 * happen if at least one device ID was programmed.
> +		 * Error returns from sdw_program_device_num() are currently
> +		 * ignored because there's no useful recovery that can be done.
> +		 * Returning the error here could result in the current status
> +		 * of other devices not being handled, because if no device IDs
> +		 * were programmed there's nothing to guarantee a status change
> +		 * to trigger another call to this function.
>  		 */
> -		return ret;
> +		sdw_program_device_num(bus, &id_programmed);
> +		if (id_programmed)
> +			return 0;
>  	}
>  
>  	/* Continue to check other slave statuses */
