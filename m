Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277566AD7AD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjCGGxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGGxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:53:11 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D797F32503;
        Mon,  6 Mar 2023 22:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678171989; x=1709707989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o4vxxs09UibrXR8t/gMPNy1OiYjqks0QoD2JEDe2IAE=;
  b=fG/TX814reWD0Qdiei+C0zV+dJh+OtEqcNgt/uE0a4v2+pUFW0cP2itg
   HO2t7GPAcwiwW1tiimt1AuSuz+8inGo00zOYEGbN46ruJi+T+5She+9sh
   7+0sakVw58LhyNw/S7e5JAqGWugWAZr6qXWS173eYpWQacnSCeuT+ZIdD
   AfbsG61VyGQCj7eAUBNmO0lF9fe74nsg6Mkc6E5OkNr5Vnn+kkckxBCQP
   Mjtici8oDn2nFrSt0AHOr8krLr0bvVcf1/Aj/24jVVw+qdaOHouFn3quj
   ZcKG59ng7qOzUHhz7Oz3nhdrLpe/NxwY6ZjKckT82lxB67Aixx26LWssw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="335797798"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="335797798"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 22:53:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="1005759014"
X-IronPort-AV: E=Sophos;i="5.98,240,1673942400"; 
   d="scan'208";a="1005759014"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.218.236])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 22:53:07 -0800
Message-ID: <75d48dce-192f-0950-8770-839cfb53588b@intel.com>
Date:   Tue, 7 Mar 2023 08:53:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v1] mmc: sdhci_am654: lower power-on failed message
 severity
To:     Francesco Dolcini <francesco@dolcini.it>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-kernel@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>
References: <20230306162751.163369-1-francesco@dolcini.it>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230306162751.163369-1-francesco@dolcini.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/03/23 18:27, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Lower the power-on failed message severity from warn to info when the
> controller does not power-up. It's normal to have this situation when
> the SD card slot is empty, therefore we should not warn the user about
> it.
> 
> Fixes: 7ca0f166f5b2 ("mmc: sdhci_am654: Add workaround for card detect debounce timer")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci_am654.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 7ef828942df3..89953093e20c 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -369,7 +369,7 @@ static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
>  					MAX_POWER_ON_TIMEOUT, false, host, val,
>  					reg);
>  		if (ret)
> -			dev_warn(mmc_dev(host->mmc), "Power on failed\n");
> +			dev_info(mmc_dev(host->mmc), "Power on failed\n");
>  	}
>  }
>  

