Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F45171EFB4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjFAQwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjFAQwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:52:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D686FE54
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685638319; x=1717174319;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=unaIhnrbLjV7sEpHjjq64t0b2CFQcNQSWZs0Xy3lg8E=;
  b=XsLZv5GzLoxuKi7Bhw7lOwkV46rMWOTWftWQjAvsoibkC93eihy2ukds
   gaZT8VyaFaA/YYvQz/37tMjBYdzwjchYty6hILBaUfNoJC/YPntYQZP/m
   SSqgc+kLD5BXfE8G26wosEm2SUjbb3a/fa159uUiV4X5ap4cKPegGFzhJ
   o32sfcGWxIlZW4uzBVGNyheC7NaPxHa/xstMSPcS/360f8mNuNO/RJ6ao
   NNh4Z4SZVHJdTWa156bWc/kbP1M8PHwxSTPkyRrjNuht1DyeC5SEUzYvz
   HVuJyukGe9q5UbaOPhG3BVmHlc6u8Icoh3XwM2qW/R5k+Uj5Q8Y1qjQpy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="421426868"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="421426868"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:51:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="777283278"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="777283278"
Received: from rcelisco-mobl.amr.corp.intel.com (HELO [10.212.207.82]) ([10.212.207.82])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:51:54 -0700
Message-ID: <40d09b30-3323-f438-0f12-bc322ee389e9@linux.intel.com>
Date:   Thu, 1 Jun 2023 11:37:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] soundwire: stream: Remove unnecessary gotos
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230601161622.1808135-1-ckeepax@opensource.cirrus.com>
 <20230601161622.1808135-3-ckeepax@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230601161622.1808135-3-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/23 11:16, Charles Keepax wrote:
> There is a lot of code using gotos to skip small sections of code, this
> is a fairly dubious use of a goto, especially when the level of
> intentation is really low. Most of this code doesn't even breach 80
> characters when naively shifted over.
> 
> Simplify the code a bit, by replacing these unnecessary gotos with
> simple ifs.

it's probably ok but far from simple to review with the inverted states
for variables. I don't have the time and energy to revisit this...

I would err on the side of if it ain't broke don't fix it here.

> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/soundwire/stream.c | 131 +++++++++++++++++--------------------
>  1 file changed, 59 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 379228f221869..248ab243ec6e4 100644
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
> @@ -1864,7 +1862,7 @@ int sdw_stream_add_master(struct sdw_bus *bus,
>  			  struct sdw_stream_runtime *stream)
>  {
>  	struct sdw_master_runtime *m_rt;
> -	bool alloc_master_rt = true;
> +	bool alloc_master_rt = false;
>  	int ret;
>  
>  	mutex_lock(&bus->bus_lock);
> @@ -1886,30 +1884,25 @@ int sdw_stream_add_master(struct sdw_bus *bus,
>  	 * it first), if so skip allocation and go to configuration
>  	 */
>  	m_rt = sdw_master_rt_find(bus, stream);
> -	if (m_rt) {
> -		alloc_master_rt = false;
> -		goto skip_alloc_master_rt;
> -	}
> -
> -	m_rt = sdw_master_rt_alloc(bus, stream);
>  	if (!m_rt) {
> -		dev_err(bus->dev, "%s: Master runtime alloc failed for stream:%s\n",
> -			__func__, stream->name);
> -		ret = -ENOMEM;
> -		goto unlock;
> -	}
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
> @@ -1990,8 +1983,8 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
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
> @@ -2002,47 +1995,41 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
>  	 * and go to configuration
>  	 */
>  	m_rt = sdw_master_rt_find(slave->bus, stream);
> -	if (m_rt) {
> -		alloc_master_rt = false;
> -		goto skip_alloc_master_rt;
> -	}
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
> -skip_alloc_master_rt:
> -	s_rt = sdw_slave_rt_find(slave, stream);
> -	if (s_rt) {
> -		alloc_slave_rt = false;
> -		goto skip_alloc_slave_rt;
> +		alloc_master_rt = true;
>  	}
>  
> -	s_rt = sdw_slave_rt_alloc(slave, m_rt);
> +	s_rt = sdw_slave_rt_find(slave, stream);
>  	if (!s_rt) {
> -		dev_err(&slave->dev, "Slave runtime alloc failed for stream:%s\n", stream->name);
> -		alloc_slave_rt = false;
> -		ret = -ENOMEM;
> -		goto alloc_error;
> -	}
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
