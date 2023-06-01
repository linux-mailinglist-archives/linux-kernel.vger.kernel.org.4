Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401BC71927A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjFAFoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjFAFoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:44:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE9FE61;
        Wed, 31 May 2023 22:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685598231; x=1717134231;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R5LxuEEiR62rgKF6q4fziDA3Jz/DKBPGM3/Cs/Lh8RY=;
  b=gYIIn9hqlCXEZI1MrRuQyo06Zhe4eJZ4h/9zWjZCNJuU/srAMsUiraVP
   EZO7lESBH0FhlBlbmdJ4I3RlvmhQutm6tK26OTcb0VHXX1n+9NvBuObLu
   8En7pROI6usdo9Ig3dAwVCNnAzIwoJfPr9iybBweeLb9fVT/QAz5lF/Rv
   yP0xUkklCupTppDiKLnCwj+fLej4fBUaYTRwT3fw0JuHoSPqEhUdISu/2
   5klBcOSyB2H0t+ipSZxHz6/lTunhldTWSsPg/YZAU32vc263SEiFwdzLu
   KbhiDPRjxbhk+HFcebHLYxaCdzS8Gf4i57GlHrC8hxW2hqiGEQ1ulVWnI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="335079684"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="335079684"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 22:41:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="701405411"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="701405411"
Received: from alupas-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.54.252])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 22:41:45 -0700
Message-ID: <16a70f99-8ae7-41fa-5af8-6fc0dcb5db8a@intel.com>
Date:   Thu, 1 Jun 2023 08:41:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH V5 3/4] mmc: sdhci: Add VDD2 definition for power control
 register
Content-Language: en-US
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230601015115.406002-1-victorshihgli@gmail.com>
 <20230601015115.406002-4-victorshihgli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230601015115.406002-4-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/06/23 04:51, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Add new definition for VDD2 - UHS2 or PCIe/NVMe.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index f4f2085c274c..f219bdea8f28 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -99,6 +99,13 @@
>  #define  SDHCI_POWER_180	0x0A
>  #define  SDHCI_POWER_300	0x0C
>  #define  SDHCI_POWER_330	0x0E
> +/*
> + * VDD2 - UHS2 or PCIe/NVMe
> + * VDD2 power on/off and voltage select
> + */
> +#define  SDHCI_VDD2_POWER_ON	0x10
> +#define  SDHCI_VDD2_POWER_120	0x80
> +#define  SDHCI_VDD2_POWER_180	0xA0
>  
>  #define SDHCI_BLOCK_GAP_CONTROL	0x2A
>  

