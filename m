Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10356E9A64
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjDTROD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjDTROA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:14:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C8B30F4;
        Thu, 20 Apr 2023 10:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682010839; x=1713546839;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=PEJHCF8o5yRXy8rQpWjSG+FZsMlzywfLjLfQ1k5Fkl0=;
  b=Zgzaluf2vVRAT/nMNm4gFebR5Iee0IuvLG6Z56ckKdKsvGKMD5M541s+
   4yX2RPMPR6aD7QhFa9DMXjq6mdrBrE2iIOQTQhaPeRLoolqi3OACEbT54
   yzKjqUkn3vvqlklD7gwgULj56DW68f7K1iYG/w14woIzckLnUKABhHEnr
   rUk+EdZCqsSy7DeQjfHOOw0eqPxDbe5C8zKsYDhoAV/92qlrm4sOl91Q5
   L91RU5dLRBxnR68lBjH7f+eOAiz4QcNXTA7ZFUlACdOOeMKRE0EEqwhio
   aM5hYth3LWJYe+utW4bBgA1GbHoRUODbhhvHCgrT/GNMbIwwawNtYiW+T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="348574475"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="348574475"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 09:43:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="1021622674"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="1021622674"
Received: from mprabhug-mobl.amr.corp.intel.com (HELO [10.209.102.50]) ([10.209.102.50])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 09:43:00 -0700
Message-ID: <7ee41bcb-8656-49ec-40b6-15072c080d08@linux.intel.com>
Date:   Thu, 20 Apr 2023 11:42:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 5/6] soudnwire: master: protect concurrecnt check for
 bus->md
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Patrick Lai <quic_plai@quicinc.com>
References: <20230420101617.142225-1-krzysztof.kozlowski@linaro.org>
 <20230420101617.142225-6-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
In-Reply-To: <20230420101617.142225-6-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typos in commit title...

On 4/20/23 05:16, Krzysztof Kozlowski wrote:
> The Soundwire master controllers might want to check for bus->md

Apologies for being pedantic but 'manager' and 'controller' are
different concepts in SoundWire, see DisCo spec.
It's not a 1:1 mapping, a controller can rely on M managers

> initialization to avoid race between early interrupt and finish of
> sdw_bus_master_add()/sdw_master_device_add().  Such early interrupt can
> happen if Soundwire devices are not powered off during their probe.
> 
> Add a store release barrier, so the Soundwire controllers can safely
> check it in concurrent (e.g. in interrupt) way.

Can you elaborate on the race condition? I am not following what breaks,
and what entity generates the 'early interrupt'.

I am specifically concerned about adding this in common code without any
matching smp_load_acquire() - which is only added in the following patch
for the Qualcomm manager only, but not added for Intel/AMD managers. Is
this not a problem?

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Patrick Lai <quic_plai@quicinc.com>
> ---
>  drivers/soundwire/master.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
> index 9b05c9e25ebe..d5bf13e7e602 100644
> --- a/drivers/soundwire/master.c
> +++ b/drivers/soundwire/master.c
> @@ -161,7 +161,12 @@ int sdw_master_device_add(struct sdw_bus *bus, struct device *parent,
>  	/* add shortcuts to improve code readability/compactness */
>  	md->bus = bus;
>  	bus->dev = &md->dev;
> -	bus->md = md;
> +	/*
> +	 * Make sure the contents of md is stored before storing bus->md.
> +	 * Paired with new slave attached and slave status interrupts
> +	 * on the Soundwire master side.
> +	 */
> +	smp_store_release(&bus->md, md);
>  
>  	pm_runtime_set_autosuspend_delay(&bus->md->dev, SDW_MASTER_SUSPEND_DELAY_MS);
>  	pm_runtime_use_autosuspend(&bus->md->dev);
