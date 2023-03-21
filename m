Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C245B6C2F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCUKhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjCUKhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:37:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0D67D9E;
        Tue, 21 Mar 2023 03:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679395008; x=1710931008;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=02a4bSS1l3THSC25dR3CqSQi5ey23+yWCWwus1hx1S8=;
  b=A9dxe6wk30QOTsfr9q6ywD+q1qkQj9LivVFhzs3kH8IV3qDwequH05zf
   fRuvssExYN6hgscdDZJkp63yEzpK3d9xnfWZCunLkZ2rbn9zjd+hjjeZh
   umP46KF43ECY1WjdQ9/EyOczCadtg3I93/ITpbjDDGWeAAs0pDvwpcwJt
   VrOHYmq75lpEKHTDyXhLWZmA7xukvtzpi9CM/0s5HTACYKbBOOw8fJqRX
   Ctwf9e9tUltCmQ/qcYGnKVcaKZtbiAAqcXm3LS3O7jaoN9Z9r8UkIzlF3
   5DFWXKIJTNpsG8xfcmdSM3ASiGhJUwdNtrIMU7C0KfaSj3uon/Ig5dUxq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="322747494"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="322747494"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 03:36:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="631520210"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="631520210"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.109])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 03:36:45 -0700
Message-ID: <8d6d12b5-39d4-ac07-f725-18ae9df9765b@intel.com>
Date:   Tue, 21 Mar 2023 12:36:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH] mmc: core: Allow to avoid REQ_FUA if the eMMC supports an
 internal cache
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Wenchao Chen <wenchao.chen666@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
References: <20230316164514.1615169-1-ulf.hansson@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230316164514.1615169-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/23 18:45, Ulf Hansson wrote:
> REQ_FUA translates into so called "reliable writes" (atomic writes) for
> eMMC cards, which is generally supported as it was introduced as a
> mandatory feature already in the v4.3 (2007) of the eMMC spec. To fully
> support the reliable writes (thus REQ_FUA), the mmc host driver needs to
> support the CMD23 (MMC_CAP_CMD23) too, which is rather common nowadays.
> 
> File systems typically uses REQ_FUA for writing their meta-data and other
> important information. Ideally it should provide an increased protection
> against data-corruption, during sudden power-failures. This said, file
> systems have other ways to handle sudden power-failures too, like using
> checksums to detect partly-written data, for example.
> 
> It has been reported that the reliable writes are costly for some eMMCs,
> leading to performance degradations. Exactly why, is in the implementation
> details of the internals of the eMMC.
> 
> Moreover, in the v4.5 (2011) of the eMMC spec, the cache-control was
> introduced as an optional feature. It allows the host to trigger a flush of
> the eMMC's internal write-cache. In the past, before the cache-control
> feature was added, the reliable write acted as trigger for the eMMC, to
> also flush its internal write-cache, even if that too remains as an
> implementation detail of the eMMC.
> 
> In a way to try to improve the situation with costly reliable writes and
> REQ_FUA, let's add a new card quirk MMC_QUIRK_AVOID_REL_WRITE, which may be
> set to avoid announcing the support for it. However, as mentioned above,
> due to the specific relationship with the cache-control feature, we must
> keep REQ_FUA unless that is supported too.
> 
> Reported-by: Wenchao Chen <wenchao.chen666@gmail.com>
> Acked-by: Bean Huo <beanhuo@micron.com>
> Acked-by: Avri Altman <avri.altman@wdc.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Minor cosmetic suggestion below, but nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Updated since the RFC:
> 	Added a card quirk to maintain the current behaviour. The quirk isn't
> 	set for any cards yet, which is needed (a patch on top) to move forward
> 	with this.
> 
> ---
>  drivers/mmc/core/block.c | 16 ++++++++++++----
>  drivers/mmc/core/card.h  |  5 +++++
>  include/linux/mmc/card.h |  1 +
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 672ab90c4b2d..35292e36a1fb 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2409,8 +2409,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>  	struct mmc_blk_data *md;
>  	int devidx, ret;
>  	char cap_str[10];
> -	bool cache_enabled = false;
> -	bool fua_enabled = false;
> +	bool cache_enabled, avoid_fua, fua_enabled = false;
>  
>  	devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
>  	if (devidx < 0) {
> @@ -2494,11 +2493,20 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>  	    ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
>  	     card->ext_csd.rel_sectors)) {
>  		md->flags |= MMC_BLK_REL_WR;
> +	}
> +
> +	/*
> +	 * REQ_FUA is supported through eMMC reliable writes, which has been
> +	 * reported to be a bit costly for some eMMCs. In these cases, let's
> +	 * rely on the flush requests (REQ_OP_FLUSH) instead, if we can use the
> +	 * cache-control feature too.
> +	 */
> +	cache_enabled = mmc_cache_enabled(card->host);
> +	avoid_fua = cache_enabled && mmc_card_avoid_rel_write(card);
> +	if (md->flags & MMC_BLK_REL_WR && !avoid_fua) {
>  		fua_enabled = true;
>  		cache_enabled = true;
>  	}

looks like this could be just:

	fua_enabled = (md->flags & MMC_BLK_REL_WR) && !avoid_fua;

with fua_enabled no longer needing initialization

> -	if (mmc_cache_enabled(card->host))
> -		cache_enabled  = true;
>  
>  	blk_queue_write_cache(md->queue.queue, cache_enabled, fua_enabled);
>  
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index cfdd1ff40b86..2ab448fa2841 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -229,6 +229,11 @@ static inline int mmc_blksz_for_byte_mode(const struct mmc_card *c)
>  	return c->quirks & MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
>  }
>  
> +static inline int mmc_card_avoid_rel_write(const struct mmc_card *c)
> +{
> +	return c->quirks & MMC_QUIRK_AVOID_REL_WRITE;
> +}
> +
>  static inline int mmc_card_disable_cd(const struct mmc_card *c)
>  {
>  	return c->quirks & MMC_QUIRK_DISABLE_CD;
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index c726ea781255..4d297d565c83 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -282,6 +282,7 @@ struct mmc_card {
>  						/* for byte mode */
>  #define MMC_QUIRK_NONSTD_SDIO	(1<<2)		/* non-standard SDIO card attached */
>  						/* (missing CIA registers) */
> +#define MMC_QUIRK_AVOID_REL_WRITE (1<<3)	/* Avoid rel-write (REQ_FUA) */
>  #define MMC_QUIRK_NONSTD_FUNC_IF (1<<4)		/* SDIO card has nonstd function interfaces */
>  #define MMC_QUIRK_DISABLE_CD	(1<<5)		/* disconnect CD/DAT[3] resistor */
>  #define MMC_QUIRK_INAND_CMD38	(1<<6)		/* iNAND devices have broken CMD38 */

