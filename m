Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7E76423CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiLEHpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiLEHpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:45:14 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1FA13F22;
        Sun,  4 Dec 2022 23:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670226313; x=1701762313;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Dy6cUKU1bDtIuKsKSF9kSgG90krsYCMVDXa1HRQdkdE=;
  b=DCbReg8jdqWFedmuMCmgG8JWmozUbZIrAAClViDZTuAzyhLS724263lc
   nb5jUJbuTvxevszUOQwTrRBIqoWLewadDSJWLjsotSILpWTH0ApJGk7S6
   ImXRvobF8wMeLlXk2ejsf7X6Gda1P1LhsZUD7BRxFK64dgpc4ApQ9ofx4
   VSvxuH8ez5AKzlHg+AaAN/cUxGKl4WxhQvztWaF6xIvK+woELXBP4ZdSp
   dDW4RSAzB5fhzxNjWdhzxrlGU0UNd09QEmfD7sJv4mzX9VEYQKRWWXzF8
   4b7MXEHl/toQh+nDtm9b2bGkiJe8WTufFO/F8p7LxRTiuhxM0UUyuRztW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="313933380"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="313933380"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 23:45:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="645727543"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="645727543"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.104])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 23:45:10 -0800
Message-ID: <cea65857-071f-e68e-9825-b88d64eeca81@intel.com>
Date:   Mon, 5 Dec 2022 09:45:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v1 1/2] PM: runtime: Do not call __rpm_callback() from
 rpm_idle()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tushar Nimkar <quic_tnimkar@quicinc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Peter Wang <peter.wang@mediatek.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <5627469.DvuYhMxLoT@kreacher> <4789678.31r3eYUQgx@kreacher>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <4789678.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/22 16:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Calling __rpm_callback() from rpm_idle() after adding device links
> support to the former is a clear mistake.
> 
> Not only it causes rpm_idle() to carry out unnecessary actions, but it
> is also against the assumption regarding the stability of PM-runtime
> status accross __rpm_callback() invocations, because rpm_suspend() and

accross -> across

> rpm_resume() may run in parallel with __rpm_callback() when it is called
> by rpm_idle() and the device's PM-runtime status can be updated by any
> of them.
> 
> Fixes: 21d5c57b3726 ("PM / runtime: Use device links")

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/power/runtime.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -484,7 +484,17 @@ static int rpm_idle(struct device *dev,
>  
>  	dev->power.idle_notification = true;
>  
> -	retval = __rpm_callback(callback, dev);
> +	if (dev->power.irq_safe)
> +		spin_unlock(&dev->power.lock);
> +	else
> +		spin_unlock_irq(&dev->power.lock);
> +
> +	retval = callback(dev);
> +
> +	if (dev->power.irq_safe)
> +		spin_lock(&dev->power.lock);
> +	else
> +		spin_lock_irq(&dev->power.lock);
>  
>  	dev->power.idle_notification = false;
>  	wake_up_all(&dev->power.wait_queue);
> 
> 
> 

