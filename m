Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7856BD8B6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjCPTRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjCPTRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:17:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837A3738B0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678994214; x=1710530214;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bBOwFeYUzr32M6bMBria6jryjJC/PixHRLws/Jv8nec=;
  b=flrhIMngoLURWTAy/1irgEExnDnGrEJAdXVzGpBlkHle58ZHXMcinrXY
   hVgykJAai9LNlXAHXW63RdmLCGoi+RmcXpxxKRUM/JaLvUsD8+NGIekQT
   c7u2012F+qBcKwKAybHH+gCgt8K7cVFm91mXbUh5BS7tja7/Y+zEMsi2x
   GTPAy9InmgKT9JL66sPjtHQLmaQKyFwpY+iVFZwiFdAvdy8BOrBuohHlO
   cdO7eGEtB63CaSo0811AXImZRPlz8Hjx8Om6UfYrGsuNsTGF/pUiAH1cr
   UGuh58ag5ZSjPwOsxeLZIm/KukiT5O1saDjNz6MN6EYTFDPQTTKBrBfAq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424362295"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="424362295"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 12:16:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="673278485"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="673278485"
Received: from rljames-mobl1.amr.corp.intel.com (HELO [10.255.38.195]) ([10.255.38.195])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 12:16:53 -0700
Message-ID: <447cac77-4cc7-b2a3-23e7-978e1641a401@linux.intel.com>
Date:   Thu, 16 Mar 2023 13:46:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] soundwire: bus: Update sdw_nread/nwrite_no_pm to
 handle page boundaries
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230316155734.3191577-1-ckeepax@opensource.cirrus.com>
 <20230316155734.3191577-2-ckeepax@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230316155734.3191577-2-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/23 10:57, Charles Keepax wrote:
> Currently issuing a sdw_nread/nwrite_no_pm across a page boundary
> will silently fail to write correctly as nothing updates the page
> registers, meaning the same page of the chip will get rewritten
> with each successive page of data.
> 
> As the sdw_msg structure contains page information it seems
> reasonable that a single sdw_msg should always be within one
> page. It is also mostly simpler to handle the paging at the
> bus level rather than each master having to handle it in their
> xfer_msg callback.
> 
> As such add handling to the bus code to split up a transfer into
> multiple sdw_msg's when they go across page boundaries.

This sounds good but we need to clarify that the multiple sdw_msg's will
not necessarily be sent one after the other, the msg_lock is held in the
sdw_transfer() function, so there should be no expectation that e.g. one
big chunk of firmware code can be sent without interruption.

I also wonder if we should have a lower bar than the page to avoid
hogging the bus with large read/write transactions. If there are
multiple devices on the same link and one of them signals an alert
status while a large transfer is on-going, the alert handling will
mechanically be delayed by up to a page - that's 32k reads/writes, isn't it?

> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/soundwire/bus.c | 47 +++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 3c67266f94834..bdd251e871694 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -386,37 +386,42 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
>   * Read/Write IO functions.
>   */
>  
> -int sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
> +static int sdw_ntransfer_no_pm(struct sdw_slave *slave, u32 addr, u8 flags,
> +			       size_t count, u8 *val)
>  {
>  	struct sdw_msg msg;
> +	size_t size;
>  	int ret;
>  
> -	ret = sdw_fill_msg(&msg, slave, addr, count,
> -			   slave->dev_num, SDW_MSG_FLAG_READ, val);
> -	if (ret < 0)
> -		return ret;
> +	while (count) {
> +		// Only handle bytes up to next page boundary
> +		size = min(count, (SDW_REGADDR + 1) - (addr & SDW_REGADDR));
>  
> -	ret = sdw_transfer(slave->bus, &msg);
> -	if (slave->is_mockup_device)
> -		ret = 0;
> -	return ret;
> +		ret = sdw_fill_msg(&msg, slave, addr, size, slave->dev_num, flags, val);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = sdw_transfer(slave->bus, &msg);
> +		if (ret < 0 && !slave->is_mockup_device)
> +			return ret;
> +
> +		addr += size;
> +		val += size;
> +		count -= size;
> +	}
> +
> +	return 0;
> +}
> +
> +int sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
> +{
> +	return sdw_ntransfer_no_pm(slave, addr, SDW_MSG_FLAG_READ, count, val);
>  }
>  EXPORT_SYMBOL(sdw_nread_no_pm);
>  
>  int sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
>  {
> -	struct sdw_msg msg;
> -	int ret;
> -
> -	ret = sdw_fill_msg(&msg, slave, addr, count,
> -			   slave->dev_num, SDW_MSG_FLAG_WRITE, (u8 *)val);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = sdw_transfer(slave->bus, &msg);
> -	if (slave->is_mockup_device)
> -		ret = 0;
> -	return ret;
> +	return sdw_ntransfer_no_pm(slave, addr, SDW_MSG_FLAG_WRITE, count, (u8 *)val);
>  }
>  EXPORT_SYMBOL(sdw_nwrite_no_pm);
>  
