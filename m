Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CF9720775
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbjFBQXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbjFBQXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:23:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995FB197
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685722995; x=1717258995;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2vScx9xL+4WATF6N210Q9YVlE3QByB+nFbRWxvKBxXE=;
  b=QqcmMyqkXPCoRexgXZY7R/n/rkpI2zsxelTBs6pvBxvEVnge9P6XWITz
   /7O9umXxMau7jixmA3vFLpbionrOoz7nfnyh1BFwCYueREewb+r/IxWmF
   1Zo6U71rm6aXxiGthF3mAjF2XjzbNBWnf3C0PeSdgSanPwdbXc61P/aEw
   Frkz6WwtHn8udXhY/GhR5kWd906NCHH8AxOU065oG7cY2W9mf6ymvTTw7
   xhwVFUsVBKuZFkslAF23f6/1WSUnkU3Fb8UOXYX3Km+5lqW1j6MOHy9e3
   d+dDkXke64E5rWb5c3dfaZ/gHyBJLhv/5I6J4kmey9uSj6ao2uvIFe617
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="442285455"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="442285455"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 09:23:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="685367783"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="685367783"
Received: from joshkuo-mobl.amr.corp.intel.com (HELO [10.209.39.242]) ([10.209.39.242])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 09:23:14 -0700
Message-ID: <8ad62f37-8cf7-6bd0-3d4d-d04d5def893c@linux.intel.com>
Date:   Fri, 2 Jun 2023 10:01:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/5] soundwire: stream: Invert logic on runtime alloc
 flags
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230602101140.2040141-1-ckeepax@opensource.cirrus.com>
 <20230602101140.2040141-4-ckeepax@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230602101140.2040141-4-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/23 05:11, Charles Keepax wrote:
> sdw_stream_add_slave/master have flags to indicate if the master or
> slave runtime where allocated in that call to the function. Currently
> these flags are cleared on all the paths where the runtime is not
> allocated, it is more logic and simpler to set the flag on the one path
> where the runtime is allocated.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Much easier to review indeed, thanks!

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
> 
> Changes since v1:
>  - Split out of the goto patch to ease review
> 
> Also worth noting I guess this patch could be squashed with patch 1 in
> the series really, but I opted to leave them separate as patch 1 is a
> much simpler fix to be cherry-picked back to older kernels if someone
> needs the fixup, rather than mixing the fixup and tidy up.
> 
> Thanks,
> Charles
> 
>  drivers/soundwire/stream.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 6595f47b403b5..df5600a80c174 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1854,7 +1854,7 @@ int sdw_stream_add_master(struct sdw_bus *bus,
>  			  struct sdw_stream_runtime *stream)
>  {
>  	struct sdw_master_runtime *m_rt;
> -	bool alloc_master_rt = true;
> +	bool alloc_master_rt = false;
>  	int ret;
>  
>  	mutex_lock(&bus->bus_lock);
> @@ -1876,10 +1876,8 @@ int sdw_stream_add_master(struct sdw_bus *bus,
>  	 * it first), if so skip allocation and go to configuration
>  	 */
>  	m_rt = sdw_master_rt_find(bus, stream);
> -	if (m_rt) {
> -		alloc_master_rt = false;
> +	if (m_rt)
>  		goto skip_alloc_master_rt;
> -	}
>  
>  	m_rt = sdw_master_rt_alloc(bus, stream);
>  	if (!m_rt) {
> @@ -1888,6 +1886,8 @@ int sdw_stream_add_master(struct sdw_bus *bus,
>  		ret = -ENOMEM;
>  		goto unlock;
>  	}
> +
> +	alloc_master_rt = true;
>  skip_alloc_master_rt:
>  
>  	if (sdw_master_port_allocated(m_rt))
> @@ -1980,8 +1980,8 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
>  {
>  	struct sdw_slave_runtime *s_rt;
>  	struct sdw_master_runtime *m_rt;
> -	bool alloc_master_rt = true;
> -	bool alloc_slave_rt = true;
> +	bool alloc_master_rt = false;
> +	bool alloc_slave_rt = false;
>  
>  	int ret;
>  
> @@ -1992,10 +1992,8 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
>  	 * and go to configuration
>  	 */
>  	m_rt = sdw_master_rt_find(slave->bus, stream);
> -	if (m_rt) {
> -		alloc_master_rt = false;
> +	if (m_rt)
>  		goto skip_alloc_master_rt;
> -	}
>  
>  	/*
>  	 * If this API is invoked by Slave first then m_rt is not valid.
> @@ -2009,21 +2007,22 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
>  		goto unlock;
>  	}
>  
> +	alloc_master_rt = true;
> +
>  skip_alloc_master_rt:
>  	s_rt = sdw_slave_rt_find(slave, stream);
> -	if (s_rt) {
> -		alloc_slave_rt = false;
> +	if (s_rt)
>  		goto skip_alloc_slave_rt;
> -	}
>  
>  	s_rt = sdw_slave_rt_alloc(slave, m_rt);
>  	if (!s_rt) {
>  		dev_err(&slave->dev, "Slave runtime alloc failed for stream:%s\n", stream->name);
> -		alloc_slave_rt = false;
>  		ret = -ENOMEM;
>  		goto alloc_error;
>  	}
>  
> +	alloc_slave_rt = true;
> +
>  skip_alloc_slave_rt:
>  	if (sdw_slave_port_allocated(s_rt))
>  		goto skip_port_alloc;
