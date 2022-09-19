Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683C85BC4C2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiISIwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiISIw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:52:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106A422BFD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663577530; x=1695113530;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=soUQOddqp60l+A0SvBrHsI8rwpW1H/6Q8f4MbqONHts=;
  b=SoZzs+736uPee0XWD4l9aAjuXnKTrl5pgTLdYytmTmiZ9PjbKQF1cVkx
   LzhJoB8SuHNZdymSWHFZnL3JQwgjRWVEDAPO9HmXJ+IkFbMmpmWErl1m6
   kus2oyi+SQrHw8gZF/Ky+2HasEx0+gSZrjc4OWXeF5KMS125airA2p7l7
   FDMhjfzyOkrGTWD7DDvBHJ+Cq33sImh1gtwrOW89Vw2Z2Os0DAJ/Dm04g
   GYIvTKSAffqdwTXfNPNLLKgTwPlJ0e9GGoiJcdmTs93Dz1F/bJgzWjC80
   uqEpm+lRZSZtIyNyYSb0wwMhJMJvA0/q7s5tLFiWiRX58NEh0Bj8FjdmE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="298073445"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="298073445"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 01:52:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="680761406"
Received: from ilick-mobl1.ger.corp.intel.com (HELO [10.252.59.91]) ([10.252.59.91])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 01:52:03 -0700
Message-ID: <5b9040e8-fe19-2438-0072-74b2f0d914e3@linux.intel.com>
Date:   Mon, 19 Sep 2022 10:39:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] soundwire: cadence: Write to correct address for each
 FIFO chunk
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20220917123517.229153-1-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220917123517.229153-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/22 14:35, Richard Fitzgerald wrote:
> _cdns_xfer_msg() must add the fragment offset to msg->addr to get the
> base target address of each FIFO chunk. Otherwise every chunk will
> be written to the first 32 register addresses.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  drivers/soundwire/cadence_master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index 3ef472049980..ca241bbeadd9 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -569,7 +569,7 @@ _cdns_xfer_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int cmd,
>  	}
>  
>  	base = CDNS_MCP_CMD_BASE;
> -	addr = msg->addr;
> +	addr = msg->addr + offset;

LGTM, probably means that sending a large command broken in several
pieces never worked. D'oh.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks Richard!

>  
>  	for (i = 0; i < count; i++) {
>  		data = FIELD_PREP(CDNS_MCP_CMD_DEV_ADDR, msg->dev_num);
