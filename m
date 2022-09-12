Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553FC5B59CB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiILMA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiILMAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:00:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B22FFEE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 05:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662984015; x=1694520015;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zkOXQ6fic21iBzYMitvf8khwq2yyDU+RwPlIGr7j6/o=;
  b=XZ66qjPgwf02zEUJu7xVJsocl4+FYFtbcEw/06SaEqnruzU6RoUyLOgI
   Oq60kxJ9GH87hrbg1IzlIKHiMbXYQESKZgXgPsVLhWgP5JTuCwgB1rWIE
   z+OMNclFVUZfCa9x/LwdiVf/Xn4fFuLg2YPUsmU6550V63CTWgZG2Jbtf
   g3zutcFrsJvgX2up8dSSZN6/VteR+r13MKOjs91SbUyrVGFRN96BpCxGu
   MwM2l5s4furunvDvZrLSM8VerR6PFMoUtvsxkS7KFNClhFDa47vNg/w+P
   tTn1Imjrf+4FArWmTRcP/XmJEXEDrLKQuDavlLZevfWNJb0zTlP6F3+U5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="296581473"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="296581473"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 05:00:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="705126574"
Received: from vtsymbal-mobl.ger.corp.intel.com (HELO [10.252.32.67]) ([10.252.32.67])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 05:00:11 -0700
Message-ID: <35122b05-4d2f-8c9c-eb5e-c0f96ef585a4@linux.intel.com>
Date:   Mon, 12 Sep 2022 13:05:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/5] soundwire: cadence: Fix lost ATTACHED interrupts
 when enumerating
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20220907085259.3602-1-rf@opensource.cirrus.com>
 <20220907085259.3602-5-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220907085259.3602-5-rf@opensource.cirrus.com>
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



On 9/7/22 10:52, Richard Fitzgerald wrote:
> The correct way to handle interrupts is to clear the bits we
> are about to handle _before_ handling them. Thus if the condition
> then re-asserts during the handling we won't lose it.
> 
> This patch changes cdns_update_slave_status_work() to do this.
> 
> The previous code cleared the interrupts after handling them.
> The problem with this is that when handling enumeration of devices
> the ATTACH statuses can be accidentally cleared and so some or all
> of the devices never complete their enumeration.
> 
> Thus we can have a situation like this:
> - one or more devices are reverting to ID #0
> 
> - accumulated status bits indicate some devices attached and some
>   on ID #0. (Remember: status bits are sticky until they are handled)
> 
> - Because of device on #0 sdw_handle_slave_status() programs the
>   device ID and exits without handling the other status, expecting
>   to get an ATTACHED from this reprogrammed device.
> 
> - The device immediately starts reporting ATTACHED in PINGs, which
>   will assert its CDNS_MCP_SLAVE_INTSTAT_ATTACHED bit.
> 
> - cdns_update_slave_status_work() clears INTSTAT0/1. If the initial
>   status had CDNS_MCP_SLAVE_INTSTAT_ATTACHED bit set it will be
>   cleared.
> 
> - The ATTACHED change for the device has now been lost.
> 
> - cdns_update_slave_status_work() clears CDNS_MCP_INT_SLAVE_MASK so
>   if the new ATTACHED state had set it, it will be cleared without
>   ever having been handled.
> 
> Unless there is some other state change from another device to cause
> a new interrupt, the ATTACHED state of the reprogrammed device will
> never cause an interrupt so its enumeration will not be completed.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/soundwire/cadence_master.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 245191d22ccd..3acd7b89c940 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -954,9 +954,22 @@ static void cdns_update_slave_status_work(struct work_struct *work)
>  	u32 device0_status;
>  	int retry_count = 0;
>  
> +	/*
> +	 * Clear main interrupt first so we don't lose any assertions
> +	 * the happen during this function.
> +	 */
> +	cdns_writel(cdns, CDNS_MCP_INTSTAT, CDNS_MCP_INT_SLAVE_MASK);
> +
>  	slave0 = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT0);
>  	slave1 = cdns_readl(cdns, CDNS_MCP_SLAVE_INTSTAT1);
>  
> +	/*
> +	 * Clear the bits before handling so we don't lose any
> +	 * bits that re-assert.
> +	 */
> +	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT0, slave0);
> +	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT1, slave1);
> +
>  	/* combine the two status */
>  	slave_intstat = ((u64)slave1 << 32) | slave0;
>  
> @@ -964,8 +977,6 @@ static void cdns_update_slave_status_work(struct work_struct *work)
>  
>  update_status:
>  	cdns_update_slave_status(cdns, slave_intstat);
> -	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT0, slave0);
> -	cdns_writel(cdns, CDNS_MCP_SLAVE_INTSTAT1, slave1);

this one is hard to review, if you don't clear the status here, then how
does the retry work if there is a new event?

Put differently, do we need to retry and the 'goto update_status' any more?

>  
>  	/*
>  	 * When there is more than one peripheral per link, it's
> @@ -1001,8 +1012,7 @@ static void cdns_update_slave_status_work(struct work_struct *work)
>  		}
>  	}
>  
> -	/* clear and unmask Slave interrupt now */
> -	cdns_writel(cdns, CDNS_MCP_INTSTAT, CDNS_MCP_INT_SLAVE_MASK);
> +	/* unmask Slave interrupt now */
>  	cdns_updatel(cdns, CDNS_MCP_INTMASK,
>  		     CDNS_MCP_INT_SLAVE_MASK, CDNS_MCP_INT_SLAVE_MASK);
>  
