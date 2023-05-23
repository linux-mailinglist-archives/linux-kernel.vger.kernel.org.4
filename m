Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6172270E90A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 00:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbjEWWYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 18:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjEWWYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 18:24:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E67283
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 15:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684880643; x=1716416643;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8mTAJOJyftZoVl7OI8gfE34nvkq733E8blhSnki+qW4=;
  b=hdLjgn9KCB78oWoy2fUV+PuLOX2OQRZVwc13oM25kB8Do4jxsQdCXvAm
   RcoTYtgbtnY4e0EUuws7PAo4i2dAakVqoJRbLPedqd3m2+k2cf/meLDa/
   IS54C/FqtlmNu1obNqjHIWjIhkt9K4NIKo+ddpwTcPRL/IAVol7qJYhAe
   L29eRzgka3+D4VuqJoJP2CF/y2FvNSX4mctLIstYzTdnLh9FpuCK3dBZs
   369ouEjnXJKKkvesHI16OhgUclwUc5wYhyY3yofeTV0yVNKaWqMmQwlz3
   umlR7p6laI9nC2ZH3N7LPCiOzSTn69xicIDO6iBEot60zam+SkGmC+96b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="355734591"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="355734591"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 15:24:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="848468210"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="848468210"
Received: from srusakov-mobl.amr.corp.intel.com (HELO [10.209.35.87]) ([10.209.35.87])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 15:24:01 -0700
Message-ID: <778b936a-6a79-d54e-95bd-033495087622@linux.intel.com>
Date:   Tue, 23 May 2023 17:24:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH] regmap: maple: Drop the RCU read lock while syncing
 registers
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20230523-regcache-maple-sync-lock-v1-1-530e4d68dfab@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230523-regcache-maple-sync-lock-v1-1-530e4d68dfab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 17:18, Mark Brown wrote:
> Unfortunately the maple tree requires us to explicitly lock it so we need
> to take the RCU read lock while iterating. When syncing this means that we
> end up trying to write out register values while holding the RCU read lock
> which triggers lockdep issues since that is an atomic context but most
> buses can't be used in atomic context. Pause the iteration and drop the
> lock for each register we check to avoid this.
> 
> Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Closes: https://github.com/thesofproject/linux/issues/4371
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/base/regmap/regcache-maple.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
> index 9b1b559107ef..c2e3a0f6c218 100644
> --- a/drivers/base/regmap/regcache-maple.c
> +++ b/drivers/base/regmap/regcache-maple.c
> @@ -203,15 +203,18 @@ static int regcache_maple_sync(struct regmap *map, unsigned int min,
>  
>  	mas_for_each(&mas, entry, max) {
>  		for (r = max(mas.index, lmin); r <= min(mas.last, lmax); r++) {
> +			mas_pause(&mas);
> +			rcu_read_unlock();
>  			ret = regcache_sync_val(map, r, entry[r - mas.index]);
>  			if (ret != 0)
>  				goto out;
> +			rcu_read_lock();
>  		}
>  	}
>  
> -out:
>  	rcu_read_unlock();
>  
> +out:
>  	map->cache_bypass = false;
>  
>  	return ret;
> 
> ---
> base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
> change-id: 20230523-regcache-maple-sync-lock-57ea356dc60b
> 
> Best regards,
