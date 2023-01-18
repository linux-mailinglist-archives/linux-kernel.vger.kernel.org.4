Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDC2672730
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjARSiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjARSiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:38:16 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0843B10F0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674067096; x=1705603096;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rLOjY01QTq0Btsgrlpy5oCl1OvMXzrTFhGhJXtQRRpc=;
  b=dSYho92L3QUblh87jJcrbbcPE5C5e8CzOt1k/IP7HV8AKLfqrFj+ZH4j
   PPQ7SIeOcd6NvWK37/jBUlkAnakVXRCt1+RXpP+UIhAChLq+Qk4uMrKD+
   qwjuOwgF/01DHk3UIOll/o7MQTEKQBoPa+PlsHbJlOF7PjW/lQVvCulM1
   fcBeb5SuT+v8QTkcnxeVMeGTEWF623yVsPJz88a68kZluyTV1X9jutHON
   /KUHkAADtDu3lEDkYkBrLifg/KpcLDV//7lHzuLZOKjaIjM75it7qbb7F
   ylTtfrDws9O8a2afH+0tHzhHv+SVcZ36GnGY/m6Jb0CDoLz6gf3693Uco
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="327138516"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="327138516"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:37:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="783777249"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="783777249"
Received: from jaibarra-mobl.amr.corp.intel.com (HELO [10.209.131.1]) ([10.209.131.1])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:37:55 -0800
Message-ID: <eb9fe53e-013b-e477-1d14-8d0c1c7514fc@linux.intel.com>
Date:   Wed, 18 Jan 2023 10:41:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/8] ASoC: cs42l42: Add SOFT_RESET_REBOOT register
Content-Language: en-US
To:     Stefan Binding <sbinding@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Richard Fitzgerald <rf@opensource.cirrus.com>
References: <20230118160452.2385494-1-sbinding@opensource.cirrus.com>
 <20230118160452.2385494-3-sbinding@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230118160452.2385494-3-sbinding@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/23 10:04, Stefan Binding wrote:
> From: Richard Fitzgerald <rf@opensource.cirrus.com>
> 
> The SOFT_RESET_REBOOT register is needed to recover CS42L42 state after
> a Soundwire bus reset.

Humm, you probably want to clarify the terminology, the 'soft reset' is
defined in the SoundWire spec as the case where the peripheral device
loses sync. Bus reset is a Severe Reset, but there's also a Hard Reset.

does this 'SOFT_RESET_REBOOT' need to be accessed when there's a soft
reset, or only after a Severe/Hard Reset?

> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
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
