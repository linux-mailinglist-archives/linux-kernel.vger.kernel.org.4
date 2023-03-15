Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7746BAD1D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjCOKKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjCOKJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:09:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0EE1B32F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEA0161CC5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EE5C433D2;
        Wed, 15 Mar 2023 10:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678874955;
        bh=eXPQpD4bRYDF5NT+if6f4+A0IwSmQw0qHuuIm39/+L0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmCpI8Pe4X1CTy+4q5l/PX2K8h603UKRaVsu6jOYm99KecuvDlB4RxHE1mUY3mXim
         U/bCTZtrvGWYOSu7ZiFpdlMv3MQ+4aVAKznyxtwDmjSPOO7Jd/7R3ciAyUwrn2mZ0C
         tET5V/IsCdrLTKBjJWMx2ItHjiDc/MT4CApVpTxwQyGAaEZAc1bto8xCfVsOS3Jofb
         4ILpwxA8RWvurwSuaq7hWaoBhIruivmRZwu9pXIVUxXiWVdDpiGTuSzxxrw7eXzqOL
         pwU3s558P+i/T5jF28wo5lY6cvnFQEDnYRgF0s1cLcCfnlOpoM+hxJTJdR/Io5hhsl
         DpdnAphUkV0/A==
Date:   Wed, 15 Mar 2023 15:39:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: stream: uniquify dev_err() logs
Message-ID: <ZBGZR2ACa8AbNmvy@matsya>
References: <20230309054905.21507-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309054905.21507-1-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-03-23, 13:49, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> There are a couple of duplicate logs which makes harder than needed to
> follow the error flows. Add __func__ or make the log unique.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/stream.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 2e39587ed1de..dd09855caac9 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1389,7 +1389,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
>  
>  	ret = do_bank_switch(stream);
>  	if (ret < 0) {
> -		dev_err(bus->dev, "Bank switch failed: %d\n", ret);
> +		pr_err("%s: do_bank_switch failed: %d\n", __func__, ret);

why make it pr_ and loose the dev name? There is a trick to emit
function for dev_err too using dynamic debug


>  		goto restore_params;
>  	}
>  
> @@ -1477,7 +1477,7 @@ static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
>  		/* Program params */
>  		ret = sdw_program_params(bus, false);
>  		if (ret < 0) {
> -			dev_err(bus->dev, "Program params failed: %d\n", ret);
> +			dev_err(bus->dev, "%s: Program params failed: %d\n", __func__, ret);
>  			return ret;
>  		}
>  
> @@ -1497,7 +1497,7 @@ static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
>  
>  	ret = do_bank_switch(stream);
>  	if (ret < 0) {
> -		dev_err(bus->dev, "Bank switch failed: %d\n", ret);
> +		pr_err("%s: do_bank_switch failed: %d\n", __func__, ret);
>  		return ret;
>  	}
>  
> @@ -1567,14 +1567,14 @@ static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
>  		/* Program params */
>  		ret = sdw_program_params(bus, false);
>  		if (ret < 0) {
> -			dev_err(bus->dev, "Program params failed: %d\n", ret);
> +			dev_err(bus->dev, "%s: Program params failed: %d\n", __func__, ret);
>  			return ret;
>  		}
>  	}
>  
>  	ret = do_bank_switch(stream);
>  	if (ret < 0) {
> -		pr_err("Bank switch failed: %d\n", ret);
> +		pr_err("%s: do_bank_switch failed: %d\n", __func__, ret);
>  		return ret;
>  	}
>  
> @@ -1664,7 +1664,7 @@ static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
>  		/* Program params */
>  		ret = sdw_program_params(bus, false);
>  		if (ret < 0) {
> -			dev_err(bus->dev, "Program params failed: %d\n", ret);
> +			dev_err(bus->dev, "%s: Program params failed: %d\n", __func__, ret);
>  			return ret;
>  		}
>  	}
> @@ -1893,7 +1893,8 @@ int sdw_stream_add_master(struct sdw_bus *bus,
>  
>  	m_rt = sdw_master_rt_alloc(bus, stream);
>  	if (!m_rt) {
> -		dev_err(bus->dev, "Master runtime alloc failed for stream:%s\n", stream->name);
> +		dev_err(bus->dev, "%s: Master runtime alloc failed for stream:%s\n",
> +			__func__, stream->name);
>  		ret = -ENOMEM;
>  		goto unlock;
>  	}
> @@ -2012,7 +2013,8 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
>  	 */
>  	m_rt = sdw_master_rt_alloc(slave->bus, stream);
>  	if (!m_rt) {
> -		dev_err(&slave->dev, "Master runtime alloc failed for stream:%s\n", stream->name);
> +		dev_err(&slave->dev, "%s: Master runtime alloc failed for stream:%s\n",
> +			__func__, stream->name);
>  		ret = -ENOMEM;
>  		goto unlock;
>  	}
> -- 
> 2.25.1

-- 
~Vinod
