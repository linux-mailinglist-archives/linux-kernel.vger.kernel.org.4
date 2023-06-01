Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FC171EFAE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjFAQw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjFAQwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:52:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAFC1AC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685638317; x=1717174317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g5y1GHVsR7iAG9EmS8Ihu9Jzn9ts5cBKEcy8VFO6/sw=;
  b=YOpZVQDUQrvUDw4eq9dGifhvSdUz3tRvosPGU6sh070ujDyd15i69JsF
   X8SZ3vc0onth6MjRj++Sapz9rTUJxG6GRe5bg5Gr2xdf4m6NiNMNI6ogk
   rchWs7745170xpLJwbFo7OewvuaBrSQnECfWIDOITySlq0zhQIYSJvaAq
   VEfm1IBKdN4s5ynm03HJG/6kZSGJAxZ8DgA5c/YnhEEAVOmLJ4bYuAPIO
   VTfmwB0irWZGUVMPqL1Hii1EqjpvUHq1kuE6xNdIYeRCJs3IhI7RZzpps
   rW2wq76Du8bxRzTSR2K34zzJ6WjIXpveqC9y4KWQEiBfL8SEdE8hfue+w
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="421426856"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="421426856"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:51:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="777283273"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="777283273"
Received: from rcelisco-mobl.amr.corp.intel.com (HELO [10.212.207.82]) ([10.212.207.82])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 09:51:52 -0700
Message-ID: <4e90380f-b328-5806-4305-0a794cadc550@linux.intel.com>
Date:   Thu, 1 Jun 2023 11:34:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] soundwire: stream: Tidy do_bank_switch error messages
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230601161622.1808135-1-ckeepax@opensource.cirrus.com>
 <20230601161622.1808135-4-ckeepax@opensource.cirrus.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230601161622.1808135-4-ckeepax@opensource.cirrus.com>
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
> Every error path in do_bank_switch prints an error message so there is no
> need for the callers to also print error messages. Indeed in multi-master
> cases these extra messages are confusing because they print out against a
> random bus device whereas the do_bank_switch messages print against the bus
> that actually failed.

Errm, what?

There is no way to know which bus failed in multi-master mode, and the
'stream' can span multiple buses so the use of pr_err was intentional.
There's just no other way to report issues, and I don't see why one
would remove such logs and fail silently.

I just don't get what you are trying to address.

> This also allows clean up of a couple of if's and variable initialisations
> that were only there to silence potentially uninitialised variable
> warnings on the bus variable.

That should be a separate patch IMHO.


> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/soundwire/stream.c | 26 +++++---------------------
>  1 file changed, 5 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 248ab243ec6e4..b5c7a52aac19e 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1338,7 +1338,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
>  			       bool update_params)
>  {
>  	struct sdw_master_runtime *m_rt;
> -	struct sdw_bus *bus = NULL;
> +	struct sdw_bus *bus;
>  	struct sdw_master_prop *prop;
>  	struct sdw_bus_params params;
>  	int ret;
> @@ -1380,16 +1380,9 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
>  		}
>  	}
>  
> -	if (!bus) {
> -		pr_err("Configuration error in %s\n", __func__);
> -		return -EINVAL;
> -	}
> -
>  	ret = do_bank_switch(stream);
> -	if (ret < 0) {
> -		pr_err("%s: do_bank_switch failed: %d\n", __func__, ret);
> +	if (ret < 0)
>  		goto restore_params;
> -	}
>  
>  	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
>  		bus = m_rt->bus;
> @@ -1465,7 +1458,7 @@ EXPORT_SYMBOL(sdw_prepare_stream);
>  static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
>  {
>  	struct sdw_master_runtime *m_rt;
> -	struct sdw_bus *bus = NULL;
> +	struct sdw_bus *bus;
>  	int ret;
>  
>  	/* Enable Master(s) and Slave(s) port(s) associated with stream */
> @@ -1488,16 +1481,9 @@ static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
>  		}
>  	}
>  
> -	if (!bus) {
> -		pr_err("Configuration error in %s\n", __func__);
> -		return -EINVAL;
> -	}
> -
>  	ret = do_bank_switch(stream);
> -	if (ret < 0) {
> -		pr_err("%s: do_bank_switch failed: %d\n", __func__, ret);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	stream->state = SDW_STREAM_ENABLED;
>  	return 0;
> @@ -1571,10 +1557,8 @@ static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
>  	}
>  
>  	ret = do_bank_switch(stream);
> -	if (ret < 0) {
> -		pr_err("%s: do_bank_switch failed: %d\n", __func__, ret);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	/* make sure alternate bank (previous current) is also disabled */
>  	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
