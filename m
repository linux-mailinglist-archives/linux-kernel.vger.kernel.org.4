Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393E1738676
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjFUONI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjFUOMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:12:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C8426AF;
        Wed, 21 Jun 2023 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687356723; x=1718892723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9QEdUvQrDLjg3arxdysgvHN5B7VgeWjap2iI9K/7yhU=;
  b=fD1HzSBMcvj6s7z8SPbJUTCVpReS04wup6HFhxHQM6xCjrcQu5i09MCV
   RmrJkfRtx+aktMmfbpsfIZ0TKAAHJC5VdmxI6n1dHsmVsS+M9ZBs7gU7u
   yiiWBuVk8j9H8L5pIxDNgJN1nSiALuFN+/vtBZ6nYluDTv3zmmbt2ZZyO
   Wsmox1YQ+zsdc7z42W8My7tJRMptJVUjQaE6skrADSmEFZdzHpbRhpzWe
   AfVVMkhCsm9nb3Fcd5LeTaaEKzNOr3iBY9/OKPfN36dqcJpFXL6In7Glf
   QWr+PaPvkv+bTyTjEALNXrR9z+Sxuf1BK4DUzzOXh7ozI6Dh4Q84gW5/t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="363604495"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="363604495"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:11:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="714500912"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="714500912"
Received: from araj-dh-work.jf.intel.com (HELO araj-dh-work) ([10.165.157.158])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 07:11:34 -0700
Date:   Wed, 21 Jun 2023 07:09:56 -0700
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     linan666@huaweicloud.com
Cc:     axboe@kernel.dk, linan122@huawei.com, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3 3/4] block/badblocks: fix badblocks loss when
 badblocks combine
Message-ID: <ZJMEtGw+FYT8mRG+@araj-dh-work>
References: <20230621172052.1499919-1-linan666@huaweicloud.com>
 <20230621172052.1499919-4-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621172052.1499919-4-linan666@huaweicloud.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 01:20:51AM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> badblocks will loss if we set it as below:
> 
>   # echo 1 1 > bad_blocks
>   # echo 3 1 > bad_blocks
>   # echo 1 5 > bad_blocks
>   # cat bad_blocks
>     1 3
> 
> In badblocks_set(), if there is an intersection between p[lo] and p[hi],
> we will combine them. The end of new badblocks is p[hi]'s end now. but
> p[lo] may cross p[hi] and new end should be the larger of p[lo] and p[hi].

Reconsider rewriting the commit log. It seems you converted code to
sentence ;-). 

Also it might help to show after the patch how the above example would be
for cat bad_blocks

> 
> Fixes: 9e0e252a048b ("badblocks: Add core badblock management code")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  block/badblocks.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/block/badblocks.c b/block/badblocks.c
> index 7e6ebe2ac12c..2c2ef8284a3f 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -267,16 +267,14 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>  	if (sectors == 0 && hi < bb->count) {
>  		/* we might be able to combine lo and hi */
>  		/* Note: 's' is at the end of 'lo' */
> -		sector_t a = BB_OFFSET(p[hi]);
> -		int lolen = BB_LEN(p[lo]);
> -		int hilen = BB_LEN(p[hi]);
> -		int newlen = lolen + hilen - (s - a);
> +		sector_t a = BB_OFFSET(p[lo]);
> +		int newlen = max(s, BB_OFFSET(p[hi]) + BB_LEN(p[hi])) - a;
>  
> -		if (s >= a && newlen < BB_MAX_LEN) {
> +		if (s >= BB_OFFSET(p[hi]) && newlen < BB_MAX_LEN) {
>  			/* yes, we can combine them */
>  			int ack = BB_ACK(p[lo]) && BB_ACK(p[hi]);
>  
> -			p[lo] = BB_MAKE(BB_OFFSET(p[lo]), newlen, ack);
> +			p[lo] = BB_MAKE(a, newlen, ack);
>  			memmove(p + hi, p + hi + 1,
>  				(bb->count - hi - 1) * 8);
>  			bb->count--;
> -- 
> 2.39.2
> 
