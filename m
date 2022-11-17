Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59F362DCE9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiKQNhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240136AbiKQNhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:37:14 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1D57341C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668692233; x=1700228233;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S2LL1Qvk1qH+6CRpB+yCup1YqVOGXcciNvz60LpQwfM=;
  b=PqQwHRCHm8KskEKglh594kF41cT8a1N1lY6TYuqRPsNu3derYQB6s9XJ
   Kwd1BKSNoYGSb81tBkRnT2C1NBNqgPwTNKjk/fz6lMu3CqD0DpOdE2OFb
   xQKY05ypv/f8+EY8L708zG4acAAdokNbIYn11kM4BWhVpTDKEclU8rHFJ
   fmQGaYuT1d0XXB5TT5kmc5AGVSkpuGx7LWJeGFIE2euPUsVUBFQTZFJLM
   xei/zENmpTafSDiIfUd8/ostGcqmSzk8NZqCkGuGfB5Zndk4zfu2ky+2Y
   Lz/F7ioqMmaIyTknmUloM/LWc/n+GCENu0gfTJ7OHbx/WmGlIG2vGFsPb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="292556307"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="292556307"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 05:37:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="590622508"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="590622508"
Received: from crequinx-mobl1.ger.corp.intel.com (HELO [10.252.19.12]) ([10.252.19.12])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 05:37:09 -0800
Message-ID: <4942f328-8bb6-9880-8901-0cae5ca73873@linux.intel.com>
Date:   Thu, 17 Nov 2022 15:37:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/1] ASoC: SOF: probes: Check ops before memory
 allocation
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Jyri Sarha <jyri.sarha@intel.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20221117103223.74425-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20221117103223.74425-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/11/2022 12:32, Andy Shevchenko wrote:
> We may check ops before spending resources on memory allocation.

we might.

Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> While at it, utilize dev_get_platdata() helper.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  sound/soc/sof/sof-client-probes.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/sof/sof-client-probes.c b/sound/soc/sof/sof-client-probes.c
> index d08395182b1a..fff126808bc0 100644
> --- a/sound/soc/sof/sof-client-probes.c
> +++ b/sound/soc/sof/sof-client-probes.c
> @@ -399,23 +399,21 @@ static int sof_probes_client_probe(struct auxiliary_device *auxdev,
>  	if (!sof_probes_enabled)
>  		return -ENXIO;
>  
> -	if (!dev->platform_data) {
> +	ops = dev_get_platdata(dev);
> +	if (!ops) {
>  		dev_err(dev, "missing platform data\n");
>  		return -ENODEV;
>  	}
> -
> -	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;
> -
> -	ops = dev->platform_data;
> -
>  	if (!ops->startup || !ops->shutdown || !ops->set_params || !ops->trigger ||
>  	    !ops->pointer) {
>  		dev_err(dev, "missing platform callback(s)\n");
>  		return -ENODEV;
>  	}
>  
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
>  	priv->host_ops = ops;
>  
>  	switch (sof_client_get_ipc_type(cdev)) {

-- 
Péter
