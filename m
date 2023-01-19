Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3414D673FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjASR1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjASR1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:27:19 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C8581028
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674149236; x=1705685236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hvKnPzV818Q2MTrJsqR3kbZNsGKViKmjEv5oxYAd76U=;
  b=iDlaGHmBGBl4x+WrSrZaLcpJizbAlqpIOvi8A26fbhJ68ByAUF5qrNam
   IIR7yf/FyUf1isc67D95j3wtUCRp/F5vUXqrOzGXhvlJkyBGQJnsDfHFO
   JmkNSyjfe5R8aHLdUuBRAXHgYDMEIwldi/p/fYfJyw66XhdBlpDHdh6Bm
   hkV6n46ZXOa4neHwVUYtPwrAdhO7UvT7HukSFXrsJGdIjvpO6fBuj3Ls9
   UuEEc4tUHAQ38KkKmHeTydQp90VdWlaEZsJbGWQ1qJAsKCGRuGImJS+wU
   UL47yOeMSj6tVChV5TdVlp/q6KcB12M0k1CuLUpcxhozsIfw7l6wlO+QD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="313243574"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="313243574"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 09:27:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="905621057"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="905621057"
Received: from sahamad-mobl1.amr.corp.intel.com (HELO [10.213.187.97]) ([10.213.187.97])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 09:27:15 -0800
Message-ID: <db571218-1adb-cb46-5b76-55eaf379f6ca@linux.intel.com>
Date:   Thu, 19 Jan 2023 11:27:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] soundwire: bus: Don't filter slave alerts
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
        yung-chuan.liao@linux.intel.com
References: <20230119165104.3433290-1-ckeepax@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230119165104.3433290-1-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/23 10:51, Charles Keepax wrote:
> Currently the SoundWire core will loop handling slave alerts but it will
> only handle those present when the alert was first raised. This causes
> some issues with the Cadence SoundWire IP, which only generates an IRQ
> when alert changes state. This means that if a new alert arrives whilst
> old alerts are being handled it will not be handled in the currently
> loop and then no further alerts will be processed since alert never
> changes state to trigger a new IRQ.
> 
> Correct this issue by allowing the core to handle all pending alerts in
> the IRQ handling loop. The code will still only loop up to
> SDW_READ_INTR_CLEAR_RETRY times, so it shouldn't be possible for it get
> completely stuck and if you are generating IRQs faster than you can
> handle them you likely have bigger problems anyway.

The change makes sense, but it's a bit odd to change the way the
interrupts are handled because of a specific design. The bus should be
able to deal with various designs, not force a one-size-fits-all policy
that may not be quite right in all cases.

Could we have a new flag at the bus level that says that peripheral
interrupts are not filtered, and set if for the Intel case?

We could similarly make the SDW_READ_INTR_CLEAR_RETRY constant
bus/platform specific. The SoundWire spec mandates that we re-read the
status after clearing the interrupt, but it doesn't say how to deal with
recurring interrupts.

> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/soundwire/bus.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 633d411b64f35..daee2cca94a4d 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -1560,7 +1560,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>  	unsigned long port;
>  	bool slave_notify;
>  	u8 sdca_cascade = 0;
> -	u8 buf, buf2[2], _buf, _buf2[2];
> +	u8 buf, buf2[2];
>  	bool parity_check;
>  	bool parity_quirk;
>  
> @@ -1716,9 +1716,9 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>  				"SDW_SCP_INT1 recheck read failed:%d\n", ret);
>  			goto io_err;
>  		}
> -		_buf = ret;
> +		buf = ret;
>  
> -		ret = sdw_nread_no_pm(slave, SDW_SCP_INTSTAT2, 2, _buf2);
> +		ret = sdw_nread_no_pm(slave, SDW_SCP_INTSTAT2, 2, buf2);
>  		if (ret < 0) {
>  			dev_err(&slave->dev,
>  				"SDW_SCP_INT2/3 recheck read failed:%d\n", ret);
> @@ -1736,12 +1736,8 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>  		}
>  
>  		/*
> -		 * Make sure no interrupts are pending, but filter to limit loop
> -		 * to interrupts identified in the first status read
> +		 * Make sure no interrupts are pending
>  		 */
> -		buf &= _buf;
> -		buf2[0] &= _buf2[0];
> -		buf2[1] &= _buf2[1];
>  		stat = buf || buf2[0] || buf2[1] || sdca_cascade;
>  
>  		/*
