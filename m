Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F390718196
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbjEaN1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbjEaN1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:27:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73407101;
        Wed, 31 May 2023 06:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685539665; x=1717075665;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1co+eppkGb8x74kJdaxM0fCWfFP+SSp5abng4FgxhwQ=;
  b=aDcarQDqQIuxEWQb9iyxM3+DzA/RQf7wX0tRUdF/w1eDXf+9BFlaiLxA
   5hZ8NjrXTRQ8IVknays4/ubhA87jtvYwJogjJA9Pqv1nJV70I0LhygKFS
   GQB2r1HmFUITNLUg+lQcCBltnnazcxwDV3QYM+ExtdajqoSYyKgSYFsck
   33hYHGLgJitsP9Jj902GzziBEp4j9lEQXW5WJKRY4zvFNCpcuh11sI/ub
   lVO8Xi2IjBrZTeu4lbn6+0oL7Js0Du4WDJZLCt9JsX7SKSAzCANifbqyD
   SXC30knp5ZaNB6Zc5k4b+quDJzYCy0jgxxIybKh3yujZh9tB3DtRYxMVX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="344746130"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="344746130"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 06:27:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="953639662"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; 
   d="scan'208";a="953639662"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.208.175])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 06:27:31 -0700
Message-ID: <55a83234-afa9-12de-d366-961b6909efaf@intel.com>
Date:   Wed, 31 May 2023 16:27:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V4 3/4] mmc: sdhci: Add VDD2 definition for power control
 register
Content-Language: en-US
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230531111518.396868-1-victorshihgli@gmail.com>
 <20230531111518.396868-4-victorshihgli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230531111518.396868-4-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/23 14:15, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Add new definition for VDD2 - UHS2 or PCIe/NVMe.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index f4f2085c274c..140a0c20d4f2 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -100,6 +100,14 @@
>  #define  SDHCI_POWER_300	0x0C
>  #define  SDHCI_POWER_330	0x0E
>  
> +/*
> + * VDD2 - UHS2 or PCIe/NVMe
> + * VDD2 power on/off and voltage select
> + */
> +#define SDHCI_VDD2_POWER_ON	0x10
> +#define SDHCI_VDD2_POWER_120	0x80
> +#define SDHCI_VDD2_POWER_180	0xA0

They should really align with SDHCI_POWER_330 etc
above as they are all from SDHCI_POWER_CONTROL

> +
>  #define SDHCI_BLOCK_GAP_CONTROL	0x2A
>  
>  #define SDHCI_WAKE_UP_CONTROL	0x2B

