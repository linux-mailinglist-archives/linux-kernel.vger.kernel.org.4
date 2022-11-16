Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBA062C347
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbiKPQAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiKPQAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:00:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D202554E2;
        Wed, 16 Nov 2022 08:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668614433; x=1700150433;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=diJ0/bMYPdgdoRRxsbkYzGpbwIEt/0wPceeq6oditiA=;
  b=DN5NVqOYkemURYECoAzNCqxh/sBt4Tu5OCHrGhncfc63apjITSh/26gz
   iUsnjc6AyYeTgefyJhJJYgWB7LzFk8InluPMKiI5KjXRc5m7erBnKBne0
   aWeZhkCCabuAV0lxeJf0+SrtEC9NUCHdl+uPJvOVycKG75X6ObZLW0+De
   jDv1CBaS3bp0fAlcJHXtvtBIxOsvB4bB1LFgHFigU3fVBCyDRWh6kY/IH
   YPu5txj1udrhNw/WpeNwN7iiEbC24ueYe4TzZG+DanK1bqMVRavz4W1Vm
   r/EeNbQ5Elo3JDAZs14eX98YZuBY3D/adH22/CJX6hvUHpWhEbgLZRP3f
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="339396458"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="339396458"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 08:00:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="670543951"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="670543951"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.88])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 08:00:23 -0800
Message-ID: <59fc95ec-c0db-4011-eca3-3d101f0bc908@intel.com>
Date:   Wed, 16 Nov 2022 18:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 1/1] mmc: sdhci: Fixed too many logs being printed during
 tuning
Content-Language: en-US
To:     Wenchao Chen <wenchao.chen666@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
References: <20221111084214.14822-1-wenchao.chen666@gmail.com>
 <20221111084214.14822-2-wenchao.chen666@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221111084214.14822-2-wenchao.chen666@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/22 10:42, Wenchao Chen wrote:
> From: Wenchao Chen <wenchao.chen@unisoc.com>
> 
> During the HS200 tuning process, too many tuning errors are printed in
> the log.
> 
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
>  drivers/mmc/host/sdhci.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index fef03de85b99..a503b54305eb 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3401,6 +3401,10 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  		if (host->pending_reset)
>  			return;
>  
> +		command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
> +		if (command == MMC_SEND_TUNING_BLOCK || command == MMC_SEND_TUNING_BLOCK_HS200)
> +			return;

Normally we wouldn't get here even if a request got an error because
then we either reset the data circuit which should stop further
interrupts, or set host->pending_reset.

Can you elaborate on what is going wrong?

> +
>  		pr_err("%s: Got data interrupt 0x%08x even though no data operation was in progress.\n",
>  		       mmc_hostname(host->mmc), (unsigned)intmask);
>  		sdhci_err_stats_inc(host, UNEXPECTED_IRQ);

