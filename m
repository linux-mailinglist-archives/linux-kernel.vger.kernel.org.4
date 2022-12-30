Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12A6659A09
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbiL3Pja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiL3PjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:39:11 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA871C109;
        Fri, 30 Dec 2022 07:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672414675; x=1703950675;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PAx56ZENjsCB5hUOX9aS/7Fwz8yCIwa/E6TZBG11sYI=;
  b=UD6MxC97ffPJHsIvjxiZYJDOXCbRx67DS57ZZdMJvLR6zWQwSdfMLSsF
   /zoX4K6b4/20XkYvTvIDNtsWdHlSwrWPTuPfjmKahIi1DYnegR0HU2+JS
   6A0JMm9A8RdihGdpWwZ+TYhVgXChpN8ZZTmRWH7FKSb3ILZm7RPBGr6+L
   Ra9ynmuQfnFXS51KBGiALOj2wSkK3VOJrPPHVTx7WB8INAMUljuvJqokI
   7pmASNttibrVkgwkEhMfcb/fTdu1xGnhDzdUGayWijpzRja8ewSk6wj2p
   wDnLAEHoWfcFsc/dgLaHJyvAL1D+CSdUIrZ3vf3YUJG90y5BuxYVUT686
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="348433409"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="348433409"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 07:37:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10576"; a="631556267"
X-IronPort-AV: E=Sophos;i="5.96,287,1665471600"; 
   d="scan'208";a="631556267"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.2.40]) ([10.213.2.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 07:37:44 -0800
Message-ID: <eb919e0b-8dd3-00e3-a2e9-2b6daf378539@intel.com>
Date:   Fri, 30 Dec 2022 16:37:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/bridge: tc358767: Use devm_clk_get_enabled() helper
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <4f855984ea895e1488169e77935fa6e044912ac2.1672414073.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <4f855984ea895e1488169e77935fa6e044912ac2.1672414073.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.12.2022 16:29, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>     - calls devm_clk_get()
>     - calls clk_prepare_enable() and registers what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
>
> This simplifies the code and avoids the need of a dedicated function used
> with devm_add_action_or_reset().
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/gpu/drm/bridge/tc358767.c | 17 +----------------
>   1 file changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 2a58eb271f70..b95c36ca660d 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -2022,13 +2022,6 @@ static int tc_probe_bridge_endpoint(struct tc_data *tc)
>   	return -EINVAL;
>   }
>   
> -static void tc_clk_disable(void *data)
> -{
> -	struct clk *refclk = data;
> -
> -	clk_disable_unprepare(refclk);
> -}
> -
>   static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   {
>   	struct device *dev = &client->dev;
> @@ -2045,21 +2038,13 @@ static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   	if (ret)
>   		return ret;
>   
> -	tc->refclk = devm_clk_get(dev, "ref");
> +	tc->refclk = devm_clk_get_enabled(dev, "ref");
>   	if (IS_ERR(tc->refclk)) {
>   		ret = PTR_ERR(tc->refclk);
>   		dev_err(dev, "Failed to get refclk: %d\n", ret);

You can adjust the message and convert to dev_err_probe.
With that:
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej


>   		return ret;
>   	}
>   
> -	ret = clk_prepare_enable(tc->refclk);
> -	if (ret)
> -		return ret;
> -
> -	ret = devm_add_action_or_reset(dev, tc_clk_disable, tc->refclk);
> -	if (ret)
> -		return ret;
> -
>   	/* tRSTW = 100 cycles , at 13 MHz that is ~7.69 us */
>   	usleep_range(10, 15);
>   

