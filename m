Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C5E73CE80
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 07:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjFYFBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 01:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjFYFBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 01:01:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FA7E65;
        Sat, 24 Jun 2023 22:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687669292; x=1719205292;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KdNqYETF+XtrRZPtYEeWQrXvPosc/lvpXCnD1OhovGE=;
  b=bjMCC3WHIr+FKqpfH9nmBK773oj0q8pXmBQk2+iCQFu/+n2AHPXrrGRt
   NR6f35aIhM+8vcdkgWVHn4LV02BiLk9dBflaCRF+mM3MsrjTypwcV5SWO
   vj96Aqsq/XXdOkSthwV+pCudyV/a692XogUI+cfcCTW0YFUrK+viUVgfM
   x/ZscTeGA7iqXCXBFjDsPrXPMrXJgnvj5Eluf8067ie5MCmBvfyvS0GjY
   uzSXH20spzR8PjOlfCksGluUZZCfVR107q5ARL2z5V4+4N3v2jMqR2gL0
   fjw8r05TruBnzU7Qu9fUtFPYrCK7pWj6W/5w/aePaoxAgiM8g3IiCNtoP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="427015420"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="427015420"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 22:01:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="693087965"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="693087965"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.139]) ([10.238.232.139])
  by orsmga006.jf.intel.com with ESMTP; 24 Jun 2023 22:01:24 -0700
Subject: Re: [PATCH 23/26] media: staging: imgu: use array_size
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     keescook@chromium.org, kernel-janitors@vger.kernel.org,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230623211457.102544-1-Julia.Lawall@inria.fr>
 <20230623211457.102544-24-Julia.Lawall@inria.fr>
From:   Bingbu Cao <bingbu.cao@linux.intel.com>
Message-ID: <778fdf52-9e87-cacd-94a3-cd42554587c5@linux.intel.com>
Date:   Sun, 25 Jun 2023 12:59:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20230623211457.102544-24-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julia,

Thanks for your patch.

On 6/24/23 5:14 AM, Julia Lawall wrote:
> Use array_size to protect against multiplication overflows.
> 
> The changes were done using the following Coccinelle semantic patch:
> 
> // <smpl>
> @@
>     expression E1, E2;
>     constant C1, C2;
>     identifier alloc = {vmalloc,vzalloc};
> @@
>     
> (
>       alloc(C1 * C2,...)
> |
>       alloc(
> -           (E1) * (E2)
> +           array_size(E1, E2)
>       ,...)
> )
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/staging/media/ipu3/ipu3-mmu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/ipu3/ipu3-mmu.c b/drivers/staging/media/ipu3/ipu3-mmu.c
> index cb9bf5fb29a5..9c4adb815c94 100644
> --- a/drivers/staging/media/ipu3/ipu3-mmu.c
> +++ b/drivers/staging/media/ipu3/ipu3-mmu.c
> @@ -464,7 +464,7 @@ struct imgu_mmu_info *imgu_mmu_init(struct device *parent, void __iomem *base)
>  	 * Allocate the array of L2PT CPU pointers, initialized to zero,
>  	 * which means the dummy L2PT allocated above.
>  	 */
> -	mmu->l2pts = vzalloc(IPU3_PT_PTES * sizeof(*mmu->l2pts));
> +	mmu->l2pts = vzalloc(array_size(IPU3_PT_PTES, sizeof(*mmu->l2pts)));
>  	if (!mmu->l2pts)
>  		goto fail_l2pt;
>  
>

Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>


-- 
Best regards,
Bingbu Cao
