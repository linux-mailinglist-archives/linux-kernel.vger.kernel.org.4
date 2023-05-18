Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCC7707BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjERIPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjERIPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:15:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB7DE49;
        Thu, 18 May 2023 01:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684397737; x=1715933737;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U727CdahcBMQvs3cEg8kNz1KABw1O+LzKboiSQLa9Ag=;
  b=dV1v022CXeWKECzGwGkv3y5KQLvbnWDp65YDCR3wAs9JOuagECz8JyGw
   ZxdVV7nCktujFmKpPc6KPP/iEQ7Zc5LUWdLhazzFcEUGhB5PB36VwHgJb
   8ywAak6UmmSPJCHXfTv861zWWowBR8gROlPaPIjIdx6EQP142TXLNit/Q
   X3UcsXXRaMGiOQSYUUSKxB6Lono3E5p3eJM309rQublKcAMa/RdO+rTSO
   lGKovDsKfWWKRN75RWQaSBWQ7j70TsjxtOjzNFEpybCGZstsQZQGR4gzr
   B+P5ALyIU35o9bPaABbWfl3vGmg7gTEVh1xfacH0Q3manCdO+I1+uiTGU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="415428799"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="415428799"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 01:15:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="734988929"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="734988929"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.52])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 01:15:34 -0700
Message-ID: <36e805fa-338d-a945-2621-75c5077572fc@intel.com>
Date:   Thu, 18 May 2023 11:15:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH] mmc: core: Fix error checking
Content-Language: en-US
To:     Yeqi Fu <asuk4.q@gmail.com>, ulf.hansson@linaro.org,
        CLoehle@hyperstone.com, avri.altman@wdc.com, axboe@kernel.dk
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>
References: <20230517192654.367892-1-asuk4.q@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230517192654.367892-1-asuk4.q@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/23 22:26, Yeqi Fu wrote:
> The functions debugfs_create_dir and debugfs_create_file_unsafe return
> ERR_PTR if an error occurs, and the appropriate way to verify for errors
> is to use the inline function IS_ERR. The patch will substitute the
> null-comparison with IS_ERR.
> 
> Suggested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Signed-off-by: Yeqi Fu <asuk4.q@gmail.com>
> ---
>  drivers/mmc/core/block.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 00c33edb9fb9..507bebc22636 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2908,7 +2908,7 @@ static int mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
>  			debugfs_create_file_unsafe("status", 0400, root,
>  						   card,
>  						   &mmc_dbg_card_status_fops);
> -		if (!md->status_dentry)
> +		if (IS_ERR(md->status_dentry))
>  			return -EIO;
>  	}
>  
> @@ -2916,7 +2916,7 @@ static int mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
>  		md->ext_csd_dentry =
>  			debugfs_create_file("ext_csd", S_IRUSR, root, card,
>  					    &mmc_dbg_ext_csd_fops);
> -		if (!md->ext_csd_dentry)
> +		if (IS_ERR(md->ext_csd_dentry))
>  			return -EIO;
>  	}
>  

The patch is not wrong, but you also need to look at the bigger picture.
In this case, the return value is not used.  And debugfs API is designed
so that return values can be ignored - for example, it is ok to pass NULL
or an error code to debugfs_remove().  Generally we don't care if debugfs
fails, because it is only for debugging, but it only uses memory resources
so it essentially doesn't fail anyway - except when it is not compiled in.

So you could change mmc_blk_add_debugfs() to return void, and drop the error
checks entirely.

The error checks in mmc_blk_remove_debugfs() also serve no purpose.

