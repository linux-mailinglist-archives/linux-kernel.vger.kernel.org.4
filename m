Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BDD724808
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbjFFPk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238647AbjFFPkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:40:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E8E100
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686066035; x=1717602035;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JJbvRmCCUFV7p9M3l0n0kZA62PxQNfMx1/Z0AS4CdW4=;
  b=ZuzRX1BDwFN+zwvnLJeHFE5sjeZKovmzY3QANB1aV+4jrKGNhU3Bb1JB
   H/wfRripsf66oTHCRWrkDY72agIyFvj71Bu5LwNPyaCkd3ngRWjd9ValZ
   Lpstc/XhMIVPqT6Z6UM1UeEhBoWnJ31HeWHcYAxYHCg1r7RPM76twASXT
   mJV7Jns0Hv3tFoHCdnnMPp6Y611LpqRYWKLuhX8KvCkSSVNMbtKYO9Vqb
   up6qCkyXXd4rWPhlbjvTm9J8ADero+QGOOS/1nNwTikoi/WVQB15PDVwz
   PtAO4mBTFQU84SBvuiLsCD0/74SJYNUwsLu3JXs+p4gzJT2eV26sy8M2y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="422550267"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="422550267"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 08:39:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="955816530"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="955816530"
Received: from pdonvalk-mobl2.amr.corp.intel.com (HELO [10.255.231.168]) ([10.255.231.168])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 08:39:15 -0700
Message-ID: <b9487589-7149-cdbe-59f3-d5279f25b02e@linux.intel.com>
Date:   Tue, 6 Jun 2023 10:06:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH V3 9/9] ASoC: amd: ps: Add SoundWire specific checks in
 pci driver in pm ops.
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230606060724.2038680-1-Vijendar.Mukunda@amd.com>
 <20230606060724.2038680-10-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230606060724.2038680-10-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/23 01:07, Vijendar Mukunda wrote:
> AMD SoundWire manager supports different power modes.
> In case of SoundWire Power off Mode, ACP pci parent driver
> should invoke acp de-init and init sequence during suspend/resume
> callbacks.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/ps/pci-ps.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> index daf54fe9cafd..5802a701b3b1 100644
> --- a/sound/soc/amd/ps/pci-ps.c
> +++ b/sound/soc/amd/ps/pci-ps.c
> @@ -662,10 +662,15 @@ static int snd_acp63_probe(struct pci_dev *pci,
>  static int __maybe_unused snd_acp63_suspend(struct device *dev)
>  {
>  	struct acp63_dev_data *adata;
> -	int ret;
> +	int ret = 0;
>  
>  	adata = dev_get_drvdata(dev);
> -	ret = acp63_deinit(adata->acp63_base, dev);
> +	if (adata->pdev_mask & ACP63_SDW_DEV_MASK) {

And now back to my comment from the first patch, you are using a
bit-wise operation with an enum which is not explicitly defined as a
mask. This test would be true for ACP63_SDW_PDM_DEV_MASK as well.

+enum acp_pdev_mask {
+	ACP63_PDM_DEV_MASK = 1,
+	ACP63_SDW_DEV_MASK,
+	ACP63_SDW_PDM_DEV_MASK,
+};

> +		if (adata->acp_reset)
> +			ret = acp63_deinit(adata->acp63_base, dev);
> +	} else {
> +		ret = acp63_deinit(adata->acp63_base, dev);
> +	}
>  	if (ret)
>  		dev_err(dev, "ACP de-init failed\n");
>  	return ret;
> @@ -674,10 +679,15 @@ static int __maybe_unused snd_acp63_suspend(struct device *dev)
>  static int __maybe_unused snd_acp63_resume(struct device *dev)
>  {
>  	struct acp63_dev_data *adata;
> -	int ret;
> +	int ret = 0;
>  
>  	adata = dev_get_drvdata(dev);
> -	ret = acp63_init(adata->acp63_base, dev);
> +	if (adata->pdev_mask & ACP63_SDW_DEV_MASK) {
> +		if (adata->acp_reset)
> +			ret = acp63_init(adata->acp63_base, dev);
> +	} else {
> +		ret = acp63_init(adata->acp63_base, dev);
> +	}
>  	if (ret)
>  		dev_err(dev, "ACP init failed\n");
>  	return ret;
