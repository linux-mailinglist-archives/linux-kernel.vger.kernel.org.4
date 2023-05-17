Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3519706AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjEQOLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjEQOLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:11:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BA53C1E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684332701; x=1715868701;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=o06srH45R5xpmlD8rNdT+Y3hwl6m4TP3Oi6PZZsL1IU=;
  b=M6LiDFUNQfQ47aqGYEI/8SnNuKYyS5v+qFya75dMYo4a2LlOD3oq+VR8
   TbZxKOtD4jkHpNFw6qcFKrjDW4aPRc9IH+mCNLXjYmrY76WNHk4mlicq0
   9SOCtVpqzTZUMw17jI2BddZ45EkofVT/SQNpOy94LSjMpO/vvLfGUlfdS
   jQHduOBFdVMPv7UWvDDfiHDUBZ1Yo6H7WLj8p+Zcn0bQ9a/vQj0VuTr4d
   kdVMGzavmCLUMJZv0vHHSY/ZHzSLtEvF1nfkLXaoUiKLyom62z+2mx9K1
   Mgob9xzaTWDCN8TBY7KeqLjuCi04tcEHDt5n5SlNjEYRJjgmsX6ZNohkd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="349273409"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="349273409"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 07:11:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="734709683"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="734709683"
Received: from rdealba-mobl.amr.corp.intel.com (HELO [10.209.16.101]) ([10.209.16.101])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 07:11:40 -0700
Message-ID: <8f9eb906-d8a4-8675-496b-4f7de15f1cbe@linux.intel.com>
Date:   Wed, 17 May 2023 08:27:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 01/12] ASoC: codecs: rt1308: do not store status in state
 container
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230517111416.424420-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230517111416.424420-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/23 06:14, Krzysztof Kozlowski wrote:
> Driver in its update status callback stores Soundwire device status in
> state container but it never uses it later.  Simplify the code a bit.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Good cleanup, not sure why we added this internal status many moons ago.

There's already a slave->status that's updated in
drivers/soundwire/bus.c, fewer state variables are better and in this
case there's no reason to keep a value that could be stale.

For the series

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/codecs/rt1308-sdw.c | 5 +----
>  sound/soc/codecs/rt1308-sdw.h | 1 -
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/sound/soc/codecs/rt1308-sdw.c b/sound/soc/codecs/rt1308-sdw.c
> index 1797af824f60..313e97c94532 100644
> --- a/sound/soc/codecs/rt1308-sdw.c
> +++ b/sound/soc/codecs/rt1308-sdw.c
> @@ -304,9 +304,6 @@ static int rt1308_update_status(struct sdw_slave *slave,
>  {
>  	struct  rt1308_sdw_priv *rt1308 = dev_get_drvdata(&slave->dev);
>  
> -	/* Update the status */
> -	rt1308->status = status;
> -
>  	if (status == SDW_SLAVE_UNATTACHED)
>  		rt1308->hw_init = false;
>  
> @@ -314,7 +311,7 @@ static int rt1308_update_status(struct sdw_slave *slave,
>  	 * Perform initialization only if slave status is present and
>  	 * hw_init flag is false
>  	 */
> -	if (rt1308->hw_init || rt1308->status != SDW_SLAVE_ATTACHED)
> +	if (rt1308->hw_init || status != SDW_SLAVE_ATTACHED)
>  		return 0;
>  
>  	/* perform I/O transfers required for Slave initialization */
> diff --git a/sound/soc/codecs/rt1308-sdw.h b/sound/soc/codecs/rt1308-sdw.h
> index 04ff18fa18e2..f816c73e247e 100644
> --- a/sound/soc/codecs/rt1308-sdw.h
> +++ b/sound/soc/codecs/rt1308-sdw.h
> @@ -159,7 +159,6 @@ struct rt1308_sdw_priv {
>  	struct snd_soc_component *component;
>  	struct regmap *regmap;
>  	struct sdw_slave *sdw_slave;
> -	enum sdw_slave_status status;
>  	struct sdw_bus_params params;
>  	bool hw_init;
>  	bool first_hw_init;
