Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E60F720778
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbjFBQX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbjFBQXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:23:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3F1B6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685722994; x=1717258994;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sF8tH3G/ocxW4x77NN0zlyUDCOV5pH0gtR7CSxkyAIw=;
  b=KYRjm7q9/WdQuW+4PMDZb5qILBemxPNYSXOfcWTkiN4Yp+y6rLgyMZfS
   hkta14fd3iHB8Xy4qDvSNuPTgpqlj5WBHcWSl95PxiI8NnFNa8Al9ZeIZ
   n2l3gwP3Yvfa83sIJcrDZDnlxtmgs0BEsqOn+a9QS/6dvm36CHJ1gaBga
   F43ICGOcj0yR7bE2rTKK74O9dqmNokQKfrfhFTvJdyTnbgEaetJpRJpu4
   NsCoMqJfXFEnkb1ZaEi1fYS68GWnNiOItGURlnM1YY8Uk6exttchF+4dI
   Af206PIXLq3L1OkyvQsAl9J+brzqNHY9o2xWTgspMX/yk3AdqkqS8JDGS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="442285444"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="442285444"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 09:23:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="685367779"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="685367779"
Received: from joshkuo-mobl.amr.corp.intel.com (HELO [10.209.39.242]) ([10.209.39.242])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 09:23:13 -0700
Message-ID: <e041a75f-82d5-32cc-c885-7245220bb392@linux.intel.com>
Date:   Fri, 2 Jun 2023 09:57:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/5] soundwire: stream: Remove unneeded checks for NULL
 bus
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230602101140.2040141-1-ckeepax@opensource.cirrus.com>
 <20230602101140.2040141-3-ckeepax@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230602101140.2040141-3-ckeepax@opensource.cirrus.com>
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
> Version of the code prior to commit d014688eb373 ("soundwire: stream:
> remove bus->dev from logs on multiple buses"), used bus->dev in the
> error message after do_bank_switch, this necessitated some checking to
> ensure the bus pointer was valid. As the code no longer uses bus->dev
> said checking is now redundant, so remove it.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Good cleanup, thanks

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
> 
> Changes since v1:
>  - Left the duplicate error prints in.
> 
> Thanks,
> Charles
> 
>  drivers/soundwire/stream.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 379228f221869..6595f47b403b5 100644
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
> @@ -1382,11 +1382,6 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
>  		}
>  	}
>  
> -	if (!bus) {
> -		pr_err("Configuration error in %s\n", __func__);
> -		return -EINVAL;
> -	}
> -
>  	ret = do_bank_switch(stream);
>  	if (ret < 0) {
>  		pr_err("%s: do_bank_switch failed: %d\n", __func__, ret);
> @@ -1467,7 +1462,7 @@ EXPORT_SYMBOL(sdw_prepare_stream);
>  static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
>  {
>  	struct sdw_master_runtime *m_rt;
> -	struct sdw_bus *bus = NULL;
> +	struct sdw_bus *bus;
>  	int ret;
>  
>  	/* Enable Master(s) and Slave(s) port(s) associated with stream */
> @@ -1490,11 +1485,6 @@ static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
>  		}
>  	}
>  
> -	if (!bus) {
> -		pr_err("Configuration error in %s\n", __func__);
> -		return -EINVAL;
> -	}
> -
>  	ret = do_bank_switch(stream);
>  	if (ret < 0) {
>  		pr_err("%s: do_bank_switch failed: %d\n", __func__, ret);
