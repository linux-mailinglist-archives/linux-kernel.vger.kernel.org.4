Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFFA74D34C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjGJK06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGJK04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:26:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45224AF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688984815; x=1720520815;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=lmv0G8hZetKfnEAWnNAaFa2Izy9izfDDhRQBoU/UakU=;
  b=cwMoUm3n85MykoFvLEL+NCP5TWFDEUe3kYnzAzwAMSYfN98QGp4wFygO
   mS08uUGR/9fseSp+qAMtpWJoqNt/pAHezx2F4jhZjmOhbz/pl9JdjIsuh
   6dvLerbDJqcdPtnQkeQQWbGhrHxQksOahb6OOYAGWMYgdosaP1Scy9s3X
   oxARYBAoku2Su+rIzq4ex7yGLrUhAuRCnnXxO6sobz/5fTUKttKhlcqVE
   eKEn8CgJzddv6U/lWsq1qDIhS3iD28SyR7wKVPs6Pn9aNDqLU/yyEe8Cd
   ROHVgYmN3keCujpRjh9NJD8Av+XVaLBxzNzi6FV+l2UWy5qaz2UYffGqV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="344634881"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="344634881"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 03:26:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="810771133"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="810771133"
Received: from stoicaan-mobl.ger.corp.intel.com (HELO localhost) ([10.252.52.170])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 03:26:52 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Li Yi <liyi@loongson.cn>
Cc:     loongson-kernel@lists.loongnix.cn, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/loongson: Fix two warnings because of passing wrong
 type
In-Reply-To: <20230710100931.255234-1-suijingfeng@loongson.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230710100931.255234-1-suijingfeng@loongson.cn>
Date:   Mon, 10 Jul 2023 13:26:49 +0300
Message-ID: <87h6qcjc46.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023, Sui Jingfeng <suijingfeng@loongson.cn> wrote:
> When accessing I/O memory, we should pass '__iomem *' type instead of
> 'void *' simply, otherwise sparse tests will complain. After applied
> this patch, the following two sparse warnings got fixed.

Usually the commit message should explain why it's okay to cast away the
warning.

Because realistically this doesn't "fix" the warning, this merely hides
it.

BR,
Jani.

>
> 1) drivers/gpu/drm/loongson/lsdc_benchmark.c:27:35:
>    sparse:     expected void volatile [noderef] __iomem *
>    sparse:     got void *kptr
>
> 2) drivers/gpu/drm/loongson/lsdc_benchmark.c:42:51:
>    sparse:     expected void const volatile [noderef] __iomem *
>    sparse:     got void *kptr
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307100243.v3hv6aes-lkp@intel.com/
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  drivers/gpu/drm/loongson/lsdc_benchmark.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/loongson/lsdc_benchmark.c b/drivers/gpu/drm/loongson/lsdc_benchmark.c
> index b088646a2ff9..36e352820bdb 100644
> --- a/drivers/gpu/drm/loongson/lsdc_benchmark.c
> +++ b/drivers/gpu/drm/loongson/lsdc_benchmark.c
> @@ -24,7 +24,7 @@ static void lsdc_copy_gtt_to_vram_cpu(struct lsdc_bo *src_bo,
>  	lsdc_bo_kmap(dst_bo);
>  
>  	while (n--)
> -		memcpy_toio(dst_bo->kptr, src_bo->kptr, size);
> +		memcpy_toio((void __iomem *)dst_bo->kptr, src_bo->kptr, size);
>  
>  	lsdc_bo_kunmap(src_bo);
>  	lsdc_bo_kunmap(dst_bo);
> @@ -39,7 +39,7 @@ static void lsdc_copy_vram_to_gtt_cpu(struct lsdc_bo *src_bo,
>  	lsdc_bo_kmap(dst_bo);
>  
>  	while (n--)
> -		memcpy_fromio(dst_bo->kptr, src_bo->kptr, size);
> +		memcpy_fromio(dst_bo->kptr, (void __iomem *)src_bo->kptr, size);
>  
>  	lsdc_bo_kunmap(src_bo);
>  	lsdc_bo_kunmap(dst_bo);

-- 
Jani Nikula, Intel Open Source Graphics Center
