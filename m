Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC8B5B59CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiILMAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiILMAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:00:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ACA3054C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662984024; x=1694520024;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o6Bq1Z3Sr0g8BtqtCAOe8U9O5accgN6ulqcimCetaDA=;
  b=a4Q4ZPdOmsu1vB+Tj54bd3XmDT7NFwfBkvtPZoxAgtJ3iC98BR+3ZJzq
   zXLooKyHoa1rxLSZsf67tH/9xFlpOknFKIh+SjXwzUO6deCY06vhDsoaf
   53CDuHIVTymsycmMi/vcGTpGmgCse/duAZqcA72fj+Ais18tUHYUWnZ2Q
   O7c4J3pTOONZXbpb/SHNwNuxMK9oOgkatX5IrvpvBmB7YjQqwZmRc1ogT
   lDPsQgVqOGw52O7PTccqAmO0+JuZVSOyDg9ikTi7+TjDfI/F6GDNWg3Za
   8A45RhR/NGpgWsFubE8De+TNGJgrHmpFxjuMqqJC5bgTA29BarWbGEp7A
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="284867038"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="284867038"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 05:00:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="705126634"
Received: from vtsymbal-mobl.ger.corp.intel.com (HELO [10.252.32.67]) ([10.252.32.67])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 05:00:19 -0700
Message-ID: <fa14881d-0eb8-f652-aea7-00d8c3f2a6bb@linux.intel.com>
Date:   Mon, 12 Sep 2022 13:43:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 5/5] soundwire: bus: Don't exit early if no device IDs
 were programmed
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220907085259.3602-1-rf@opensource.cirrus.com>
 <20220907085259.3602-6-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220907085259.3602-6-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/22 10:52, Richard Fitzgerald wrote:
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
> ---
>  drivers/soundwire/bus.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 6e569a875a9b..0bcc2d161eb9 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -736,20 +736,19 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>  	struct sdw_slave_id id;
>  	struct sdw_msg msg;
>  	bool found;
> -	int count = 0, ret;
> +	int count = 0, num_programmed = 0, ret;
>  	u64 addr;
>  
>  	/* No Slave, so use raw xfer api */
>  	ret = sdw_fill_msg(&msg, NULL, SDW_SCP_DEVID_0,
>  			   SDW_NUM_DEV_ID_REGISTERS, 0, SDW_MSG_FLAG_READ, buf);
>  	if (ret < 0)
> -		return ret;
> +		return 0;

this doesn't seem quite right to me, there are multiple -EINVAL cases
handled in sdw_fill_msg().

I didn't check if all these error cases are irrelevant in that specific
enumeration case, if that was the case maybe we need to break that
function in two helpers so that all the checks can be skipped.

>  
>  	do {
>  		ret = sdw_transfer(bus, &msg);
>  		if (ret == -ENODATA) { /* end of device id reads */
>  			dev_dbg(bus->dev, "No more devices to enumerate\n");
> -			ret = 0;
>  			break;
>  		}
>  		if (ret < 0) {
> @@ -781,7 +780,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>  				 * assigned a device ID.
>  				 */
>  				if (slave->status != SDW_SLAVE_UNATTACHED)
> -					return 0;
> +					return num_programmed;
>  
>  				/*
>  				 * Assign a new dev_num to this Slave and
> @@ -794,9 +793,11 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>  					dev_err(bus->dev,
>  						"Assign dev_num failed:%d\n",
>  						ret);
> -					return ret;
> +					return num_programmed;
>  				}
>  
> +				++num_programmed;
> +
>  				break;
>  			}
>  		}
> @@ -825,7 +826,7 @@ static int sdw_program_device_num(struct sdw_bus *bus)
>  
>  	} while (ret == 0 && count < (SDW_MAX_DEVICES * 2));
>  
> -	return ret;
> +	return num_programmed;
>  }
>  
>  static void sdw_modify_slave_status(struct sdw_slave *slave,
> @@ -1787,14 +1788,16 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
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
> +		 * But only if any devices were reprogrammed, because
> +		 * this relies on its PING state changing to ATTACHED,
> +		 * triggering a status change.
>  		 */
> -		return ret;
> +		if (sdw_program_device_num(bus))
> +			return 0;
>  	}
>  
>  	/* Continue to check other slave statuses */
