Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EBC61610F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiKBKkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiKBKjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:39:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BF22704;
        Wed,  2 Nov 2022 03:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667385583; x=1698921583;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QzUjkSMafkPbPgE1dNobZk1ze8uLc0QV5kQo05Y3j5w=;
  b=XcRuCCBUYdbiVjy7GkuySixhp6YwR/JEToxRar4otLWrrOhCXg5qVahU
   BERfxLkPTN+Yi3d+29mXMLtZN5ioivu2bugndIPYUhdwrSIZfwMbUTg6f
   Dk5FF7495BJg616rZHaMV/OR5ahkUULHUBHgmw4kKWTkCJ9AZLFmp2Rjv
   KMI3jsAGU12ajRr31KplsUHPeu0OrfcfwIC51qHqPseHTWoPVaSXziwJk
   +qb75nuaq1aQV7NoQm+z6AqcFNb1rnrs8YbCcwdBcPfSGYK0mM87u+j0O
   rS1JGfsJ79GKpebKD60o0hPeDSCIrHyO0/qZ8nVMdkF5+8U79jJQv7fzi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="308092066"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="308092066"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 03:39:40 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="697760090"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="697760090"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.47.170])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 03:39:38 -0700
Message-ID: <ded98e91-ed36-6457-54d6-ad03303a743f@intel.com>
Date:   Wed, 2 Nov 2022 12:19:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH] mmc: sdhci-pci: Set PROBE_PREFER_ASYNCHRONOUS
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20221028155633.1.I6c4bfb31e88fad934e7360242cb662e01612c1bb@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221028155633.1.I6c4bfb31e88fad934e7360242cb662e01612c1bb@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/22 01:56, Brian Norris wrote:
> This driver often takes on the order of 10ms to start, but in some cases
> as much as 190ms. It shouldn't have many cross-device dependencies to
> race with, nor racy access to shared state with other drivers, so this
> should be a relatively low risk change. We've done similarly with a
> variety of other MMC host drivers already.
> 
> This driver was pinpointed as part of a survey of top slowest initcalls
> (i.e., are built in, and probing synchronously) on a lab of ChromeOS
> systems.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
>  drivers/mmc/host/sdhci-pci-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 34ea1acbb3cc..0449630acbb3 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -2281,7 +2281,8 @@ static struct pci_driver sdhci_driver = {
>  	.probe =	sdhci_pci_probe,
>  	.remove =	sdhci_pci_remove,
>  	.driver =	{
> -		.pm =   &sdhci_pci_pm_ops
> +		.pm =   &sdhci_pci_pm_ops,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  };
>  

