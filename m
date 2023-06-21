Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8804973861C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjFUOEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjFUOEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:04:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0038A107;
        Wed, 21 Jun 2023 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687356250; x=1718892250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B3WkrieyXyIX7KwvKr4S3D6Hsup+3jNM58nqpAkT058=;
  b=dP32R2VASl/w2rahudzK/2llfP7qLj5DX2fP+hi35CFCq461LuR2Ufjn
   Q/Pp6OGB+qvxLKApz6Fe0B+BoU3eIWaF85MZlQoSWz4Vom+CgUJcIO98v
   GBkcVjnyDxWBPyoyQOiAyD4u3mNAYrWY5S7p7p/QmBqWWY/CbZsHP0am/
   KPjM7STZ8BNHlgYWGVi+R75yymuQxY0PBOVOYaqOgmJrhiG1n5h/s8Kna
   bRx3wt6jJbFwEX3H3zmS04HZZKhfrIvOL5Ict+Itf87flZcSpVn2EzIjG
   u4Zv74SYU7xwn1v+rcqk6WaOMmPb95d34gIgUROU/u2aWysLImv1PGc7P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="340527115"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="340527115"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:04:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="708709876"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="708709876"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:04:08 -0700
Date:   Wed, 21 Jun 2023 07:02:30 -0700
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     linan666@huaweicloud.com
Cc:     axboe@kernel.dk, linan122@huawei.com, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3 1/4] block/badblocks: change some members of badblocks
 to bool
Message-ID: <ZJMC9rWFRqOTYgVk@araj-dh-work>
References: <20230621172052.1499919-1-linan666@huaweicloud.com>
 <20230621172052.1499919-2-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621172052.1499919-2-linan666@huaweicloud.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 01:20:49AM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> "changed" and "unacked_exist" are used as boolean type. Change the type
> of them to bool. And reorder fields to reduce memory hole.

minor nit: If you use a .gitorderfile to list .h before .c it will help review them in
order.

I don't know if its even worth doing this manual compaction unless you are
storing the entire struct in some flash or its in a sensitive cache
thrashing structure.

bool is useful that it makes the code easier to read and can eliminate some
class of bugs that you would otherwise use !! operator.

> 
> No functional changed intended.
> 
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  block/badblocks.c         | 14 +++++++-------
>  include/linux/badblocks.h | 10 +++++-----
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/block/badblocks.c b/block/badblocks.c
> index 3afb550c0f7b..1b4caa42c5f1 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -141,7 +141,7 @@ static void badblocks_update_acked(struct badblocks *bb)
>  	}
>  
>  	if (!unacked)
> -		bb->unacked_exist = 0;
> +		bb->unacked_exist = false;
>  }
>  
>  /**
> @@ -302,9 +302,9 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>  		}
>  	}
>  
> -	bb->changed = 1;
> +	bb->changed = true;
>  	if (!acknowledged)
> -		bb->unacked_exist = 1;
> +		bb->unacked_exist = true;
>  	else
>  		badblocks_update_acked(bb);
>  	write_sequnlock_irqrestore(&bb->lock, flags);
> @@ -414,7 +414,7 @@ int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
>  	}
>  
>  	badblocks_update_acked(bb);
> -	bb->changed = 1;
> +	bb->changed = true;
>  out:
>  	write_sequnlock_irq(&bb->lock);
>  	return rv;
> @@ -435,7 +435,7 @@ void ack_all_badblocks(struct badblocks *bb)
>  		return;
>  	write_seqlock_irq(&bb->lock);
>  
> -	if (bb->changed == 0 && bb->unacked_exist) {
> +	if (bb->changed == false && bb->unacked_exist) {

	if (!bb->changed && bb->unacked_exist)


>  		u64 *p = bb->page;
>  		int i;
>  
> @@ -447,7 +447,7 @@ void ack_all_badblocks(struct badblocks *bb)
>  				p[i] = BB_MAKE(start, len, 1);
>  			}
>  		}
> -		bb->unacked_exist = 0;
> +		bb->unacked_exist = false;
>  	}
>  	write_sequnlock_irq(&bb->lock);
>  }
> @@ -493,7 +493,7 @@ ssize_t badblocks_show(struct badblocks *bb, char *page, int unack)
>  				length << bb->shift);
>  	}
>  	if (unack && len == 0)
> -		bb->unacked_exist = 0;
> +		bb->unacked_exist = false;
>  
>  	if (read_seqretry(&bb->lock, seq))
>  		goto retry;
> diff --git a/include/linux/badblocks.h b/include/linux/badblocks.h
> index 2426276b9bd3..c2723f97d22d 100644
> --- a/include/linux/badblocks.h
> +++ b/include/linux/badblocks.h
> @@ -27,15 +27,15 @@
>  struct badblocks {
>  	struct device *dev;	/* set by devm_init_badblocks */
>  	int count;		/* count of bad blocks */
> -	int unacked_exist;	/* there probably are unacknowledged
> -				 * bad blocks.  This is only cleared
> -				 * when a read discovers none
> -				 */
>  	int shift;		/* shift from sectors to block size
>  				 * a -ve shift means badblocks are
>  				 * disabled.*/
> +	bool unacked_exist;	/* there probably are unacknowledged
> +				 * bad blocks.  This is only cleared
> +				 * when a read discovers none

read of what?

> +				 */
> +	bool changed;
>  	u64 *page;		/* badblock list */
> -	int changed;
>  	seqlock_t lock;
>  	sector_t sector;
>  	sector_t size;		/* in sectors */
> -- 
> 2.39.2
> 
