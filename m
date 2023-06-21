Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8117E73869F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjFUOR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjFUOR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:17:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA19294;
        Wed, 21 Jun 2023 07:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687357045; x=1718893045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rqIpWeE4xesI6qrEd6LN7Ec+WOzNpkbsOTd3PZCftzA=;
  b=Zc6yjTwbWtt9aXwEbSGrCbvL0ZtZ7Isjnu+B9IzUwFaX6Th9Hoqix9xW
   QHiZhS0zbILmSes9MZ7viH6BFf747mVU4ljQY4n6WwGXeFhpKxzbs5OH7
   wUKVqjN/R8X9lonODiL45IGWqwlaMvA/vp+/vN7Mcq2+UU17wISCMrZcG
   SkXzXgU2snq0LqMZ0jo4EyO6cubHyBvvR4Zbg0Ytk5AtF9sFv+uP01g2j
   aeX8sSUUZZ2q2ZVeRt6hrt5eyEfQMXU3gToBxNi8rqPvN0uq51cZKeBWJ
   BcfMNx0/eCGX6ES4VbTR263t6q+0pMsG24o8OXEsoBvEPkO/tgUxp/dMM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="363606395"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="363606395"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:17:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="744186433"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="744186433"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:17:18 -0700
Date:   Wed, 21 Jun 2023 07:15:40 -0700
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     linan666@huaweicloud.com
Cc:     axboe@kernel.dk, linan122@huawei.com, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3 4/4] block/badblocks: fix the bug of reverse order
Message-ID: <ZJMGDLkRbaVD9VA8@araj-dh-work>
References: <20230621172052.1499919-1-linan666@huaweicloud.com>
 <20230621172052.1499919-5-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621172052.1499919-5-linan666@huaweicloud.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 01:20:52AM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> Order of badblocks will be reversed if we set a large area at once. 'hi'
> remains unchanged while adding continuous badblocks is wrong, the next
> setting is greater than 'hi', it should be added to the next position.
> Let 'hi' +1 each cycle.

The commitlog needs more work. 
> 
>   # echo 0 2048 > bad_blocks
>   # cat bad_blocks
>     1536 512
>     1024 512
>     512 512
>     0 512

Is the above before or after this patch is applied?

> 
> Fixes: 9e0e252a048b ("badblocks: Add core badblock management code")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  block/badblocks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/badblocks.c b/block/badblocks.c
> index 2c2ef8284a3f..3b816690b940 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -301,6 +301,7 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>  			p[hi] = BB_MAKE(s, this_sectors, acknowledged);
>  			sectors -= this_sectors;
>  			s += this_sectors;
> +			hi++;
>  			changed = true;
>  		}
>  	}
> -- 
> 2.39.2
> 
