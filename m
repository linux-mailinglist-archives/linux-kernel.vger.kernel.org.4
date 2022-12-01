Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FAA63F93B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 21:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiLAUi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 15:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiLAUiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 15:38:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A72CA13C3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 12:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669927104; x=1701463104;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=38oa5iNj8+pu7Dm8hMinaLo5Pj+hXioLhzHtZupPIes=;
  b=YtQSPoc/qvEhRdHG+HA+v860UvB0LyQsZVwrO/kQNfmJXWmVHXXsgjE2
   X/HSf8b2GZa1ugaBnwIdlf9vFfnZvPYTvIWixBAc0gfVz8VtQmgPojIyT
   oNNUu+c672eDhOMXyIbhWhegL+5P7U8Gr1PxGRFtg1BSd/6BLRxNxloKB
   9LNkupBOAojZCA7BpEIFAnvWrED/2L6ARrimlIWccQEMyJx8tLAZmxJ6n
   dPyQg9QXPbEsCrUczwZFcMDBiLX6YPeB+9TRP4X1g+nV0w3pcA6SRkviP
   TBfWTOWib5Pkji3nzphNIV4QIN7FXMzK/V+oyDD8H9GU32DOubpyFFfev
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="314498377"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="314498377"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 12:38:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="644781661"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="644781661"
Received: from twcarol-mobl.amr.corp.intel.com (HELO [10.212.10.40]) ([10.212.10.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 12:38:04 -0800
Message-ID: <cdc6b2ea-d20d-0e2e-0791-faf8f0994c78@linux.intel.com>
Date:   Thu, 1 Dec 2022 12:12:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] soundwire: cadence: Remove wasted space in
 response_buf
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20221201134845.4055907-1-rf@opensource.cirrus.com>
 <20221201134845.4055907-3-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221201134845.4055907-3-rf@opensource.cirrus.com>
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
> The response_buf was declared much larger (128 entries) than the number
> of responses that could ever be written into it (maximum 8).

Indeed I don't know why we used 128 entries. This is a magic value that
doesn't appear in any specs I've looked at.

Note that there's 'sniffer' mode when each response takes two
consecutive 32-words in the FIFO. we've never used this mode though so
it's not really an issue.

It's also possible that this is related to the automatic command retry,
where a failed command can be re-issued 15 times. However in that case
the worst case would be 32 commands * 15 = 480. The value of 128 makes
no sense at all, unless it was an upper bound for 8 * 15. We don't use
this hardware retry btw.

See more below...

> Reduce response_buf to 8 entries and add checking in cdns_read_response()
> to prevent overflowing reponse_buf if CDNS_MCP_RX_FIFO_AVAIL contains
> an unexpectedly large number.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/soundwire/cadence_master.c | 6 ++++++
>  drivers/soundwire/cadence_master.h | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 27699f341f2c..95c84d9f0775 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -774,8 +774,14 @@ static void cdns_read_response(struct sdw_cdns *cdns)
>  	u32 num_resp, cmd_base;
>  	int i;
>  
> +	BUILD_BUG_ON(ARRAY_SIZE(cdns->response_buf) < CDNS_MCP_CMD_LEN);
> +
>  	num_resp = cdns_readl(cdns, CDNS_MCP_FIFOSTAT);
>  	num_resp &= CDNS_MCP_RX_FIFO_AVAIL;
> +	if (num_resp > ARRAY_SIZE(cdns->response_buf)) {
> +		dev_warn(cdns->dev, "RX AVAIL %d too long\n", num_resp);
> +		num_resp = CDNS_MCP_CMD_LEN;

.... this is different from what the hardware documentation tells me.
The range of values to RX_FIFO_AVAIL is 0..RX_FIFO_DEPTH + 2.

I don't understand the +2, but we should maybe be more cautious and use
u32 response_buf[CDNS_MCP_CMD_LEN + 2];

> +	}
>  
>  	cmd_base = CDNS_MCP_CMD_BASE;
>  
> diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
> index 0434d70d4b1f..c2d817e8e22a 100644
> --- a/drivers/soundwire/cadence_master.h
> +++ b/drivers/soundwire/cadence_master.h
> @@ -117,7 +117,7 @@ struct sdw_cdns {
>  	struct sdw_bus bus;
>  	unsigned int instance;
>  
> -	u32 response_buf[0x80];
> +	u32 response_buf[8];
>  	struct completion tx_complete;
>  	struct sdw_defer *defer;
>  
