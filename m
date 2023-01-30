Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5456816C2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjA3Qpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjA3Qpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:45:49 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054FCEC59
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675097149; x=1706633149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7TnxnDL6sOPeKME426fnoBb2LpMx6BEWRmPV9j5lEzY=;
  b=QjOvp8aDGLjsMrAqVhcpjGv/G7aXAnbsEBgfZz+KqWfX5hR0VavslHpQ
   cPoTovAhSGLC94XVs3AensTGVyR2p7pxVX39CWSTmQPYAZ2oBmT9cr+kX
   hJaT5MJVyyIzhxp7QAbFaBtMvinoPSvuHpDv84Moj8Kt8pSpWMi/sPzFx
   W1utZqNR2tiOx1/uAHVvV9EHAHyFAgJjwpNDGKCBVU/posB99Dk7KniNa
   jl3hnFR616T5UiImD2mPLt0WTrMsIMYsp7kT5ponNeEUhkZGuRX7zMbxd
   JWyWiV4UKUD0qnRGEvtkKyoQMg8fIhWBkTkW9kTex3KSsgreElKjJ2mpe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="307260816"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="307260816"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 08:45:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="732763599"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="732763599"
Received: from inuber-mobl5.amr.corp.intel.com (HELO [10.212.58.60]) ([10.212.58.60])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 08:45:48 -0800
Message-ID: <960b66c7-f476-b40c-b507-6932ff51ce76@linux.intel.com>
Date:   Mon, 30 Jan 2023 10:32:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/8] ASoC: cs42l42: Add SOFT_RESET_REBOOT register
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
References: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
 <20230127165111.3010960-3-sbinding@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230127165111.3010960-3-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/23 10:51, Stefan Binding wrote:
> From: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> The SOFT_RESET_REBOOT register is needed to recover CS42L42 state after
> a Soundwire bus reset.
> 
> This is required to be set whenever there is severe/hard bus reset.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  include/sound/cs42l42.h    | 5 +++++
>  sound/soc/codecs/cs42l42.c | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/include/sound/cs42l42.h b/include/sound/cs42l42.h
> index 1d1c24fdd0cae..3994e933db195 100644
> --- a/include/sound/cs42l42.h
> +++ b/include/sound/cs42l42.h
> @@ -34,6 +34,7 @@
>  #define CS42L42_PAGE_24		0x2400
>  #define CS42L42_PAGE_25		0x2500
>  #define CS42L42_PAGE_26		0x2600
> +#define CS42L42_PAGE_27		0x2700
>  #define CS42L42_PAGE_28		0x2800
>  #define CS42L42_PAGE_29		0x2900
>  #define CS42L42_PAGE_2A		0x2A00
> @@ -720,6 +721,10 @@
>  
>  #define CS42L42_SRC_SDOUT_FS		(CS42L42_PAGE_26 + 0x09)
>  
> +/* Page 0x27 DMA */
> +#define CS42L42_SOFT_RESET_REBOOT	(CS42L42_PAGE_27 + 0x01)
> +#define CS42L42_SFT_RST_REBOOT_MASK	BIT(1)
> +
>  /* Page 0x28 S/PDIF Registers */
>  #define CS42L42_SPDIF_CTL1		(CS42L42_PAGE_28 + 0x01)
>  #define CS42L42_SPDIF_CTL2		(CS42L42_PAGE_28 + 0x02)
> diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
> index 2fefbcf7bd130..82aa11d6937be 100644
> --- a/sound/soc/codecs/cs42l42.c
> +++ b/sound/soc/codecs/cs42l42.c
> @@ -293,6 +293,7 @@ bool cs42l42_readable_register(struct device *dev, unsigned int reg)
>  	case CS42L42_SPDIF_SW_CTL1:
>  	case CS42L42_SRC_SDIN_FS:
>  	case CS42L42_SRC_SDOUT_FS:
> +	case CS42L42_SOFT_RESET_REBOOT:
>  	case CS42L42_SPDIF_CTL1:
>  	case CS42L42_SPDIF_CTL2:
>  	case CS42L42_SPDIF_CTL3:
> @@ -358,6 +359,7 @@ bool cs42l42_volatile_register(struct device *dev, unsigned int reg)
>  	case CS42L42_LOAD_DET_DONE:
>  	case CS42L42_DET_STATUS1:
>  	case CS42L42_DET_STATUS2:
> +	case CS42L42_SOFT_RESET_REBOOT:
>  		return true;
>  	default:
>  		return false;
