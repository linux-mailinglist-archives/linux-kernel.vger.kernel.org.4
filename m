Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6DB5BABF6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbiIPLFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiIPLEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:04:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91732A721D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 03:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663325738; x=1694861738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fJFUW8+1F9qiAKmSsj0VidfyYyZ0hwH8viyxweFmXBk=;
  b=hGHu1g0p6IrWSV9vaPaE5O7LyEbn5yKK7BLzJ3mzH4tdoBOzIj9pVClM
   gd+mPG5kpbjxklfH7SpajuYKSsjF34NkYSsbCEFtAsVMzFLfY00UggtPZ
   iNUZEHAFP1bsVAnW15bPokfTvGa/9F8cHmpUrQPtYebL+cC7+C6cZot+q
   06H6B8R5TjouCRqZIvulJBxM18uuhMqjO/Oi3GCVhbzHEuAs7xJ4+6f7q
   oqcwUkjTyILTvr0jzRJfRNdqGthM6EBl4WqrczWz5XJEXFCiDCB9S/zO3
   ToXy8h4zurg9gwoLB391MIGDLQIn17PbwgpZRdfJ7PYZGSKz8Bixou82e
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="286007010"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="286007010"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 03:55:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="743298468"
Received: from kchan21-mobl1.ger.corp.intel.com (HELO [10.252.61.56]) ([10.252.61.56])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 03:55:35 -0700
Message-ID: <0f4154f6-ad5a-22e7-3b95-5a577c1dff47@linux.intel.com>
Date:   Fri, 16 Sep 2022 12:55:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] soundwire: cadence: Don't overwrite msg->buf during write
 commands
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220916103505.1562210-1-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220916103505.1562210-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/22 12:35, Richard Fitzgerald wrote:
> The buf passed in struct sdw_msg must only be written for a READ,
> in that case the RDATA part of the response is the data value of the
> register.
> 
> For a write command there is no RDATA, and buf should be assumed to
> be const and unmodifable. The original caller should not expect its data
> buffer to be corrupted by an sdw_nwrite().
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/cadence_master.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index be9cd47f31ec..3ef472049980 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -544,9 +544,12 @@ cdns_fill_msg_resp(struct sdw_cdns *cdns,
>  		return SDW_CMD_IGNORED;
>  	}
>  
> -	/* fill response */
> -	for (i = 0; i < count; i++)
> -		msg->buf[i + offset] = FIELD_GET(CDNS_MCP_RESP_RDATA, cdns->response_buf[i]);
> +	if (msg->flags == SDW_MSG_FLAG_READ) {
> +		/* fill response */
> +		for (i = 0; i < count; i++)
> +			msg->buf[i + offset] = FIELD_GET(CDNS_MCP_RESP_RDATA,
> +							 cdns->response_buf[i]);
> +	}
>  
>  	return SDW_CMD_OK;
>  }
