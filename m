Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63C16E6A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjDRQtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjDRQtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:49:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5866B13F8A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681836535; x=1713372535;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mv5aeyc9AF/wZVIT6x7Ib/pmfKZsMj/o3PD+5kYSdd8=;
  b=fgDhPpnawsaxlLRc/AYAq9BYJe5ovuUdVOdbXjlTRJvZ/NbYLEw+up0x
   99AhyNh7KS0oiulsG1mV05P3MUMAAPVcJ0B7tVVW4gCX/SgFJN9efto/s
   iYWMdAl5s2FlleC4xAea4fENtghzdsLmFmoR1S+qBvHwJFHw01vj/vzUY
   HJk1ejZuZu13VnJOH2I+7vh2j9RiTreGM/sVup2jTfgtsDT90YMikDbc0
   UZleHT7Izk6mjfxk5ZXqOeAi7KzUWPO/Zh4ZM/YsiNM3Ig4PhNNYjb5AO
   kXne9GqOoWINuSPXw7W37KaTNPnhqQ7z7Q0OIEfniuO+NybaQKu1TXOai
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="431510746"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="431510746"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 09:47:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="780546182"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="780546182"
Received: from rdfoulge-mobl.amr.corp.intel.com (HELO [10.209.38.230]) ([10.209.38.230])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 09:47:44 -0700
Message-ID: <3e1b86fb-0a3f-6dce-b3b4-6ee3971fb61d@linux.intel.com>
Date:   Tue, 18 Apr 2023 10:45:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2] soundwire: bus: Don't filter slave alerts
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20230418140650.297279-1-ckeepax@opensource.cirrus.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230418140650.297279-1-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/23 09:06, Charles Keepax wrote:
> It makes sense to have only a single point responsible for ensuring
> that all currently pending IRQs are handled. The current code in
> sdw_handle_slave_alerts confusingly splits this process in two.  This
> code will loop until the asserted IRQs are cleared but it will only
> handle IRQs that were already asserted when it was called. This
> means the caller must also loop (either manually, or through its IRQ
> mechanism) until the IRQs are all handled. It makes sense to either do
> all the looping in sdw_handle_slave_alerts or do no looping there and
> let the host controller repeatedly call it until things are handled.
> 
> There are realistically two sensible host controllers, those that
> will generate an IRQ when the alert status changes and those
> that will generate an IRQ continuously whilst the alert status
> is high. The current code will work fine for the second of those
> systems but not the first with out additional looping in the host
> controller.  Removing the code that filters out new IRQs whilst
> the handler is running enables both types of host controller to be
> supported and simplifies the code. The code will still only loop up to
> SDW_READ_INTR_CLEAR_RETRY times, so it shouldn't be possible for it to
> get completely stuck handling IRQs forever, and if you are generating
> IRQs faster than you can handle them you likely have bigger problems
> anyway.
> 
> This fixes an issue on the Cadence SoundWire IP, which only generates
> IRQs on an alert status change, where an alert which arrives whilst
> another alert is being handled will never be handled and will block
> all future alerts from being handled.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Makes sense to me, thanks for the patch.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
> 
> Changes since v1:
>  - Update commit message
> 
> Thanks,
> Charles
> 
>  drivers/soundwire/bus.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 1ea6a64f8c4a5..338f4f0b5d0cc 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -1588,7 +1588,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>  	unsigned long port;
>  	bool slave_notify;
>  	u8 sdca_cascade = 0;
> -	u8 buf, buf2[2], _buf, _buf2[2];
> +	u8 buf, buf2[2];
>  	bool parity_check;
>  	bool parity_quirk;
>  
> @@ -1745,9 +1745,9 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
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
> @@ -1765,12 +1765,8 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
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
