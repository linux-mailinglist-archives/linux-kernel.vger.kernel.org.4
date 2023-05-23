Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91DB70E554
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbjEWTY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjEWTY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:24:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1003AFA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684869896; x=1716405896;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IEyG284yltYb9FSRi5HqYAoWA0nmo4cXvLBD26DsZN8=;
  b=HXVZwLVNYgdVe69+Al1LPid2PuunAXabElHA2P0lEf1dUreKXo05vP7u
   PfFqhmAgyZL9d604O2fk202baWkpjdnsjMkWAArPhIpnTGfzB/vOpCuH1
   oTGEDVR4+jt20TLM584PK8vKZPpUdDD7GIyVuexs9trn0D4Ca3CmyGHwy
   paVhLdblDT6mEoFmgg3DVOiTAKw9bzmsjXhfksuYPesUPDBbxrcwMTYV+
   Kmtjz3TojKc3jUln/O3ZQ47V9qIY+EBkHxWFQcjTsJsWSnqBQt6XCtnUd
   rGagC8an4w/1LQQDbObN5N+jgGHRfBbJDSE+ejclwsE6Z6BTlzUA9y0bB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="350847606"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="350847606"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 12:24:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="816254807"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="816254807"
Received: from srusakov-mobl.amr.corp.intel.com (HELO [10.209.35.87]) ([10.209.35.87])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 12:24:54 -0700
Message-ID: <1ce6bb84-3140-3953-e995-00eb7b16f386@linux.intel.com>
Date:   Tue, 23 May 2023 14:24:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH] ASoC: rt5682: Use a maple tree based register cache
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230419-asoc-rt5682-maple-v1-1-ed40369c9099@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230419-asoc-rt5682-maple-v1-1-ed40369c9099@kernel.org>
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



On 4/25/23 12:22, Mark Brown wrote:
> regmap has introduced a maple tree based register cache which makes use of
> this more advanced data structure which has been added to the kernel
> recently. Maple trees are much flatter than rbtrees, meaning that they do
> not grow to such depths when the register map is sparse which makes access
> a bit more efficient. The maple tree cache type is still a bit of a work
> in progress but should be effective for some devices already.
> 
> RT5682 seems like a good candidate for maple tree. It only supports single
> register read/write operations so will gain minimal benefit from storing
> the register data in device native format like rbtree does (none for
> SoundWire) and has some sparsity in the register map which is a good fit
> for maple tree.
> 
> Convert to use maple tree. There should be little if any visible difference
> at runtime.

Wondering if this is the root cause of the regression we're seeing in
[1] on a Chromebook with rt5682 in SoundWire mode?

I don't see any other changes to this codec driver and the first problem
detected seemed to happen when we did an upstream merge last week.
Unfortunately the last merge was on April 24 (sof-dev-rebase-20230424)
which is just the day before this commit was added...

[1] https://github.com/thesofproject/linux/issues/4371

> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/codecs/rt5682-sdw.c | 2 +-
>  sound/soc/codecs/rt5682s.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
> index 5f80a5d59b65..fb7951f11c92 100644
> --- a/sound/soc/codecs/rt5682-sdw.c
> +++ b/sound/soc/codecs/rt5682-sdw.c
> @@ -79,7 +79,7 @@ static const struct regmap_config rt5682_sdw_indirect_regmap = {
>  	.max_register = RT5682_I2C_MODE,
>  	.volatile_reg = rt5682_volatile_register,
>  	.readable_reg = rt5682_readable_register,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>  	.reg_defaults = rt5682_reg,
>  	.num_reg_defaults = RT5682_REG_NUM,
>  	.use_single_read = true,
> diff --git a/sound/soc/codecs/rt5682s.c b/sound/soc/codecs/rt5682s.c
> index 9c34dca58f54..36102fa2b806 100644
> --- a/sound/soc/codecs/rt5682s.c
> +++ b/sound/soc/codecs/rt5682s.c
> @@ -3046,7 +3046,7 @@ static const struct regmap_config rt5682s_regmap = {
>  	.max_register = RT5682S_MAX_REG,
>  	.volatile_reg = rt5682s_volatile_register,
>  	.readable_reg = rt5682s_readable_register,
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>  	.reg_defaults = rt5682s_reg,
>  	.num_reg_defaults = ARRAY_SIZE(rt5682s_reg),
>  	.use_single_read = true,
> 
> ---
> base-commit: 4a670ac3e75e517c96cbd01ef870dbd598c3ce71
> change-id: 20230419-asoc-rt5682-maple-7da060991ca4
> 
> Best regards,
