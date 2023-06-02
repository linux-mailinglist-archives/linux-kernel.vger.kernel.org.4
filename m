Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6E8720779
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbjFBQX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbjFBQXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:23:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2E91AD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685722996; x=1717258996;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P/aBOqyU1q7iZ4JIPu4JBjlwp0Z/TDUhLugAjN+JF18=;
  b=T1AjBSGafbhq4luqR9KD4zAYQyK14scUWaDZQ89YBYXO36YQWlRRrwfD
   iMvciECVvFyKTFKCI4a3s4ZEQDMHZ3Frv6fsUa/5S392XRyESCiD/viis
   TY7uxQiC10kP86uR2qIDkM2A4CEXCW2ldDa9etRl48yjs2Ew+BkJTd0Oe
   MRUcWlrM7knQiINNYrg1wxyOugfLHrF/x0yJban9P5yDY7HFe1i+oirOz
   nKDX0FxOHqynZqZJC3Zanz7bZ4+60EG1Tj3XEM3BDFUg/5cmyRH+ivbXO
   qyrng/OpToJ7/l3PrWq1aSBEWXARae3HsPIIcJOrPesbZgSk/aOEg9Ne8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="442285465"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="442285465"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 09:23:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="685367786"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="685367786"
Received: from joshkuo-mobl.amr.corp.intel.com (HELO [10.209.39.242]) ([10.209.39.242])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 09:23:15 -0700
Message-ID: <aa039ad4-ebb8-0ce6-80f9-480b7a0bf5ac@linux.intel.com>
Date:   Fri, 2 Jun 2023 10:13:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 5/5] soundwire: stream: Remove unnecessary gotos
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230602101140.2040141-1-ckeepax@opensource.cirrus.com>
 <20230602101140.2040141-5-ckeepax@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230602101140.2040141-5-ckeepax@opensource.cirrus.com>
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
> There is a lot of code using gotos to skip small sections of code, this
> is a fairly dubious use of a goto, especially when the level of
> intentation is really low. Most of this code doesn't even breach 80
> characters when naively shifted over.
> 
> Simplify the code a bit, by replacing these unnecessary gotos with
> simple ifs.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v1:
>  - Split out the inversion of the alloc_*_rt logic
> 
> Worth noting this patch has no functional corrections it is just a
> stylistic change, so as Pierre said on v1 we could just leave things
> as is. Personally, I would prefer to merge it though, whilst the diff
> is a little more of a pain to review (hopefully eased somewhat by
> splitting out the alloc_*_rt logic into a separate patch), the
> resulting code reads much nicer and the code will be read a lot more
> times than this patch will be.

Indeed, the resulting code is much nicer to look at. I ignored the diffs
and just looked at the result to make up my mind.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Thanks,
> Charles
> 
>  drivers/soundwire/stream.c | 124 +++++++++++++++++--------------------
>  1 file changed, 56 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index df5600a80c174..93baca08a0dea 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1355,25 +1355,23 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
>  			return -EINVAL;
>  		}
>  
> -		if (!update_params)
> -			goto program_params;
> -
> -		/* Increment cumulative bus bandwidth */
> -		/* TODO: Update this during Device-Device support */
> -		bus->params.bandwidth += m_rt->stream->params.rate *
> -			m_rt->ch_count * m_rt->stream->params.bps;
> -
> -		/* Compute params */
> -		if (bus->compute_params) {
> -			ret = bus->compute_params(bus);
> -			if (ret < 0) {
> -				dev_err(bus->dev, "Compute params failed: %d\n",
> -					ret);
> -				goto restore_params;
> +		if (update_params) {
> +			/* Increment cumulative bus bandwidth */
> +			/* TODO: Update this during Device-Device support */
> +			bus->params.bandwidth += m_rt->stream->params.rate *
> +				m_rt->ch_count * m_rt->stream->params.bps;
> +
> +			/* Compute params */
> +			if (bus->compute_params) {
> +				ret = bus->compute_params(bus);
> +				if (ret < 0) {
> +					dev_err(bus->dev, "Compute params failed: %d\n",
> +						ret);
> +					goto restore_params;
> +				}
>  			}
>  		}
>  
> -program_params:
>  		/* Program params */
>  		ret = sdw_program_params(bus, true);
>  		if (ret < 0) {
> @@ -1876,30 +1874,25 @@ int sdw_stream_add_master(struct sdw_bus *bus,
>  	 * it first), if so skip allocation and go to configuration
>  	 */
>  	m_rt = sdw_master_rt_find(bus, stream);
> -	if (m_rt)
> -		goto skip_alloc_master_rt;
> -
> -	m_rt = sdw_master_rt_alloc(bus, stream);
>  	if (!m_rt) {
> -		dev_err(bus->dev, "%s: Master runtime alloc failed for stream:%s\n",
> -			__func__, stream->name);
> -		ret = -ENOMEM;
> -		goto unlock;
> -	}
> -
> -	alloc_master_rt = true;
> -skip_alloc_master_rt:
> -
> -	if (sdw_master_port_allocated(m_rt))
> -		goto skip_alloc_master_port;
> +		m_rt = sdw_master_rt_alloc(bus, stream);
> +		if (!m_rt) {
> +			dev_err(bus->dev, "%s: Master runtime alloc failed for stream:%s\n",
> +				__func__, stream->name);
> +			ret = -ENOMEM;
> +			goto unlock;
> +		}
>  
> -	ret = sdw_master_port_alloc(m_rt, num_ports);
> -	if (ret)
> -		goto alloc_error;
> +		alloc_master_rt = true;
> +	}
>  
> -	stream->m_rt_count++;
> +	if (!sdw_master_port_allocated(m_rt)) {
> +		ret = sdw_master_port_alloc(m_rt, num_ports);
> +		if (ret)
> +			goto alloc_error;
>  
> -skip_alloc_master_port:
> +		stream->m_rt_count++;
> +	}
>  
>  	ret = sdw_master_rt_config(m_rt, stream_config);
>  	if (ret < 0)
> @@ -1992,46 +1985,41 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
>  	 * and go to configuration
>  	 */
>  	m_rt = sdw_master_rt_find(slave->bus, stream);
> -	if (m_rt)
> -		goto skip_alloc_master_rt;
> -
> -	/*
> -	 * If this API is invoked by Slave first then m_rt is not valid.
> -	 * So, allocate m_rt and add Slave to it.
> -	 */
> -	m_rt = sdw_master_rt_alloc(slave->bus, stream);
>  	if (!m_rt) {
> -		dev_err(&slave->dev, "%s: Master runtime alloc failed for stream:%s\n",
> -			__func__, stream->name);
> -		ret = -ENOMEM;
> -		goto unlock;
> -	}
> +		/*
> +		 * If this API is invoked by Slave first then m_rt is not valid.
> +		 * So, allocate m_rt and add Slave to it.
> +		 */
> +		m_rt = sdw_master_rt_alloc(slave->bus, stream);
> +		if (!m_rt) {
> +			dev_err(&slave->dev, "%s: Master runtime alloc failed for stream:%s\n",
> +				__func__, stream->name);
> +			ret = -ENOMEM;
> +			goto unlock;
> +		}
>  
> -	alloc_master_rt = true;
> +		alloc_master_rt = true;
> +	}
>  
> -skip_alloc_master_rt:
>  	s_rt = sdw_slave_rt_find(slave, stream);
> -	if (s_rt)
> -		goto skip_alloc_slave_rt;
> -
> -	s_rt = sdw_slave_rt_alloc(slave, m_rt);
>  	if (!s_rt) {
> -		dev_err(&slave->dev, "Slave runtime alloc failed for stream:%s\n", stream->name);
> -		ret = -ENOMEM;
> -		goto alloc_error;
> -	}
> -
> -	alloc_slave_rt = true;
> +		s_rt = sdw_slave_rt_alloc(slave, m_rt);
> +		if (!s_rt) {
> +			dev_err(&slave->dev, "Slave runtime alloc failed for stream:%s\n",
> +				stream->name);
> +			ret = -ENOMEM;
> +			goto alloc_error;
> +		}
>  
> -skip_alloc_slave_rt:
> -	if (sdw_slave_port_allocated(s_rt))
> -		goto skip_port_alloc;
> +		alloc_slave_rt = true;
> +	}
>  
> -	ret = sdw_slave_port_alloc(slave, s_rt, num_ports);
> -	if (ret)
> -		goto alloc_error;
> +	if (!sdw_slave_port_allocated(s_rt)) {
> +		ret = sdw_slave_port_alloc(slave, s_rt, num_ports);
> +		if (ret)
> +			goto alloc_error;
> +	}
>  
> -skip_port_alloc:
>  	ret =  sdw_master_rt_config(m_rt, stream_config);
>  	if (ret)
>  		goto unlock;
