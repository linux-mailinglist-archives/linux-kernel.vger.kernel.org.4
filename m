Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12AF5BC4C5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiISIxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiISIwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:52:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557E82408E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663577540; x=1695113540;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZelDhvYGETW6vTz48/kGx9/Naj6tZGI84ZYZBKLByqw=;
  b=noZHnzLBxHXyY7r+eTvxFG+ErGjIWjDsVCP5VuIPFdb+i5WDnxKUCTxB
   yyTikPO7A4hMvJbhi0l5ISOlitt64mGOj+HLWCmdDZj9oFHRMturVliM4
   3mO7Z3vXuOrldx+1iUlahDhvZh9qRd9hc70gTpLIXosIt3FSEjWVtk8jT
   g1NGkY30EKE6b8YJO+qBfjx3e4T0UipAhr1pxjjEoR8G4Xt/iFXHLI+l7
   4Q//Amzs17Iovgx5t5OkCm0ecFNqEgUI1EMGrhAkzmmWq5LX5c277ebPT
   7KP82XcHjEe9K9yUBFgxgigj/b+21U0bY++b/6qLXS56DA8GutCEuut7C
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="286389370"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="286389370"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 01:52:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="707485785"
Received: from ilick-mobl1.ger.corp.intel.com (HELO [10.252.59.91]) ([10.252.59.91])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 01:52:17 -0700
Message-ID: <8d511299-5f92-603f-35e5-64e87b776286@linux.intel.com>
Date:   Mon, 19 Sep 2022 10:48:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] soundwire: cadence: Simplify error paths in
 cdns_xfer_msg()
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20220917154822.690472-1-rf@opensource.cirrus.com>
 <20220917154822.690472-2-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220917154822.690472-2-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/22 17:48, Richard Fitzgerald wrote:
> There's no need to goto an exit label to return from cdns_xfer_msg().
> It doesn't do any cleanup, only a return statement.
> 
> Replace the gotos with returns.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/cadence_master.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 3543a923ee6b..30b8c628fdbd 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -709,17 +709,14 @@ cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
>  		ret = _cdns_xfer_msg(cdns, msg, cmd, i * CDNS_MCP_CMD_LEN,
>  				     CDNS_MCP_CMD_LEN, false);
>  		if (ret != SDW_CMD_OK)
> -			goto exit;
> +			return ret;
>  	}
>  
>  	if (!(msg->len % CDNS_MCP_CMD_LEN))
> -		goto exit;
> +		return SDW_CMD_OK;
>  
> -	ret = _cdns_xfer_msg(cdns, msg, cmd, i * CDNS_MCP_CMD_LEN,
> -			     msg->len % CDNS_MCP_CMD_LEN, false);
> -
> -exit:
> -	return ret;
> +	return _cdns_xfer_msg(cdns, msg, cmd, i * CDNS_MCP_CMD_LEN,
> +			      msg->len % CDNS_MCP_CMD_LEN, false);
>  }
>  EXPORT_SYMBOL(cdns_xfer_msg);
>  
