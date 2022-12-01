Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC59963F93E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiLAUij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiLAUi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:38:26 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE39CA13F8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 12:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669927105; x=1701463105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FTyZ93Sc1W4VIQsNHMxgJlH0sdHFINQo9kc6bxOlM0w=;
  b=Rni0dKtc+s1lWVAzp3uasy6tARZoglmwC0hzNBL+vwHow/NS7grkUsi/
   HNdTn8TiXj6hkxvvEp9uN5qdXHquw99i8i0DckoTXQaFD/wbzwhhaGFwX
   T+lTL8rICwMl6ooMdCTA3CJQcq/3VkzdVWH1KL4VNJLs572h7lNaYiHjf
   TGpmE65/EocAfIFKKQ2r8bd/A8xYKw/8AoU3D6quohJmANXx0b3drXLXg
   tAa34Rv9kTwB888S7VZ4KnA/gsNMacW5ezaMDso57oSsAT0ecuFuOJXJF
   SH+HaciGJDiY7SAqZt0CTqHIyMmRuj7G1ABJfXW7dCjXZ6WK2UgLUwTEW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="314498386"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="314498386"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 12:38:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="644781664"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="644781664"
Received: from twcarol-mobl.amr.corp.intel.com (HELO [10.212.10.40]) ([10.212.10.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 12:38:06 -0800
Message-ID: <0f0fa03a-b7aa-6cdb-38b8-a09bf03f9efd@linux.intel.com>
Date:   Thu, 1 Dec 2022 12:20:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] soundwire: cadence: Drain the RX FIFO after an IO
 timeout
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
        yung-chuan.liao@linux.intel.com
References: <20221201134845.4055907-1-rf@opensource.cirrus.com>
 <20221201134845.4055907-4-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221201134845.4055907-4-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/22 07:48, Richard Fitzgerald wrote:
> If wait_for_completion_timeout() times-out in _cdns_xfer_msg() it
> is possible that something could have been written to the RX FIFO.
> In this case, we should drain the RX FIFO so that anything in it
> doesn't carry over and mess up the next transfer.
> 
> Obviously, if we got to this state something went wrong, and we
> don't really know the state of everything. The cleanup in this
> situation cannot be bullet-proof but we should attempt to avoid
> breaking future transaction, if only to reduce the amount of
> error noise when debugging the failure from a kernel log.
> 
> Note that this patch only implements the draining for blocking
> (non-deferred) transfers. The deferred API doesn't have any proper
> handling of error conditions and would need some re-design before
> implementing cleanup. That is a task for a separate patch...

It's nearly impossible to deal with error conditions with deferred
transfers, specifically in the case where deferred transfers deal with
bank switches to synchronize changes across multiple links. The NAK is
visible only in the scope of a link, and it could happen that a bank
switch happens on one link and not the other. We don't have any means to
recover at this point.

That said, draining the FIFO on timeouts for regular commands is a good
idea - or it cannot hurt, so

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/soundwire/cadence_master.c | 48 ++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 95c84d9f0775..6bffecf3d61a 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -555,6 +555,28 @@ cdns_fill_msg_resp(struct sdw_cdns *cdns,
>  	return SDW_CMD_OK;
>  }
>  
> +static void cdns_read_response(struct sdw_cdns *cdns)
> +{
> +	u32 num_resp, cmd_base;
> +	int i;
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(cdns->response_buf) < CDNS_MCP_CMD_LEN);
> +
> +	num_resp = cdns_readl(cdns, CDNS_MCP_FIFOSTAT);
> +	num_resp &= CDNS_MCP_RX_FIFO_AVAIL;
> +	if (num_resp > ARRAY_SIZE(cdns->response_buf)) {
> +		dev_warn(cdns->dev, "RX AVAIL %d too long\n", num_resp);
> +		num_resp = CDNS_MCP_CMD_LEN;
> +	}
> +
> +	cmd_base = CDNS_MCP_CMD_BASE;
> +
> +	for (i = 0; i < num_resp; i++) {
> +		cdns->response_buf[i] = cdns_readl(cdns, cmd_base);
> +		cmd_base += CDNS_MCP_CMD_WORD_LEN;
> +	}
> +}
> +
>  static enum sdw_command_response
>  _cdns_xfer_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int cmd,
>  	       int offset, int count, bool defer)
> @@ -596,6 +618,10 @@ _cdns_xfer_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int cmd,
>  		dev_err(cdns->dev, "IO transfer timed out, cmd %d device %d addr %x len %d\n",
>  			cmd, msg->dev_num, msg->addr, msg->len);
>  		msg->len = 0;
> +
> +		/* Drain anything in the RX_FIFO */
> +		cdns_read_response(cdns);
> +
>  		return SDW_CMD_TIMEOUT;
>  	}
>  
> @@ -769,28 +795,6 @@ EXPORT_SYMBOL(cdns_read_ping_status);
>   * IRQ handling
>   */
>  
> -static void cdns_read_response(struct sdw_cdns *cdns)
> -{
> -	u32 num_resp, cmd_base;
> -	int i;
> -
> -	BUILD_BUG_ON(ARRAY_SIZE(cdns->response_buf) < CDNS_MCP_CMD_LEN);
> -
> -	num_resp = cdns_readl(cdns, CDNS_MCP_FIFOSTAT);
> -	num_resp &= CDNS_MCP_RX_FIFO_AVAIL;
> -	if (num_resp > ARRAY_SIZE(cdns->response_buf)) {
> -		dev_warn(cdns->dev, "RX AVAIL %d too long\n", num_resp);
> -		num_resp = CDNS_MCP_CMD_LEN;
> -	}
> -
> -	cmd_base = CDNS_MCP_CMD_BASE;
> -
> -	for (i = 0; i < num_resp; i++) {
> -		cdns->response_buf[i] = cdns_readl(cdns, cmd_base);
> -		cmd_base += CDNS_MCP_CMD_WORD_LEN;
> -	}
> -}
> -
>  static int cdns_update_slave_status(struct sdw_cdns *cdns,
>  				    u64 slave_intstat)
>  {
