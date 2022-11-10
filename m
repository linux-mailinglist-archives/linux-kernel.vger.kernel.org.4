Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7490B624543
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiKJPMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiKJPLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:11:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D202E6B4;
        Thu, 10 Nov 2022 07:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GDS8SnZZcS0SPQ3hd4JtwYFgNgfG4Z6tO5Aqk4r9P7M=; b=gLSOYkudMtjTwff6AEMIEbcIPL
        assZcfTyw/95zMEu+tf3Nw0TdYYucmP0ADqCUX0A9Th37boVIX1bQPLE67+/Fqs8bHBXqlFFue4ii
        wwnSLzxguQ1BTcXbRSrI9CiMdM+TeXsvpy7Xtth6T91zaKB+zJsohn7ioDLn8QcirNY9VQqLGwRqv
        dvCGU4TcDCkQtQtLovntDH0OiXsa/ZpOkXUSElJWalDEVvJIKUf4UURsOwDI2M8cp4iXZfrqdkLMN
        +Rq+wcOgYS7b1jebjW6Ena/n0/zQTj+Ov8kd6lMdpPS0vKQul8jkr48ixVAZIWGixPan1L0cweuAE
        eF8pcX/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ot9DX-00CA5o-Rz; Thu, 10 Nov 2022 15:11:47 +0000
Date:   Thu, 10 Nov 2022 15:11:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, corbet@lwn.net,
        linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: support fault injection for flush submission
 error
Message-ID: <Y20Us047HVn+dPUg@casper.infradead.org>
References: <20221110032522.64043-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110032522.64043-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 11:25:22AM +0800, Yangtao Li wrote:
> Since we now support read, write, and discard in FAULT_INJECT,
> let's add support for flush.

But _why_?  There is a verifiable thing that didn't happen to the data
if the read/write/discard fails.  If flush fails ... how do you know?
What do you do?  Is this to test that the filesystem fails properly if
the block layer or the device returns a failure?  If so, why have this
code in each filesystem?  We should support that kind of error injection
at the block layer, not individual filesystems.

> This patch supports to inject fault into __submit_flush_wait() to
> simulate flush cmd io error.
> 
> Usage:
> a) echo 524288 > /sys/fs/f2fs/<dev>/inject_type or
> b) mount -o fault_type=524288 <dev> <mountpoint>
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  Documentation/filesystems/f2fs.rst |  1 +
>  fs/f2fs/f2fs.h                     |  1 +
>  fs/f2fs/segment.c                  | 12 +++++++++---
>  fs/f2fs/super.c                    |  1 +
>  4 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 6e67c5e6c7c3..316d153cc5fb 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -202,6 +202,7 @@ fault_type=%d		 Support configuring fault injection type, should be
>  			 FAULT_DQUOT_INIT	  0x000010000
>  			 FAULT_LOCK_OP		  0x000020000
>  			 FAULT_BLKADDR		  0x000040000
> +			 FAULT_FLUSH		  0x000080000
>  			 ===================	  ===========
>  mode=%s			 Control block allocation mode which supports "adaptive"
>  			 and "lfs". In "lfs" mode, there should be no random
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 04ef4cce3d7f..832baf08ecac 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -61,6 +61,7 @@ enum {
>  	FAULT_DQUOT_INIT,
>  	FAULT_LOCK_OP,
>  	FAULT_BLKADDR,
> +	FAULT_FLUSH,
>  	FAULT_MAX,
>  };
>  
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index aa4be7f25963..a4813fa33c0f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -486,7 +486,13 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
>  static int __submit_flush_wait(struct f2fs_sb_info *sbi,
>  				struct block_device *bdev)
>  {
> -	int ret = blkdev_issue_flush(bdev);
> +	int ret;
> +
> +	if (time_to_inject(sbi, FAULT_FLUSH)) {
> +		f2fs_show_injection_info(sbi, FAULT_FLUSH);
> +		ret = -EIO;
> +	} else
> +		ret = blkdev_issue_flush(bdev);
>  
>  	trace_f2fs_issue_flush(bdev, test_opt(sbi, NOBARRIER),
>  				test_opt(sbi, FLUSH_MERGE), ret);
> @@ -1126,13 +1132,13 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  		if (time_to_inject(sbi, FAULT_DISCARD)) {
>  			f2fs_show_injection_info(sbi, FAULT_DISCARD);
>  			err = -EIO;
> -			goto submit;
> +			goto skip;
>  		}
>  		err = __blkdev_issue_discard(bdev,
>  					SECTOR_FROM_BLOCK(start),
>  					SECTOR_FROM_BLOCK(len),
>  					GFP_NOFS, &bio);
> -submit:
> +skip:
>  		if (err) {
>  			spin_lock_irqsave(&dc->lock, flags);
>  			if (dc->state == D_PARTIAL)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index a43d8a46a6e5..3d3d22ac527b 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -62,6 +62,7 @@ const char *f2fs_fault_name[FAULT_MAX] = {
>  	[FAULT_DQUOT_INIT]	= "dquot initialize",
>  	[FAULT_LOCK_OP]		= "lock_op",
>  	[FAULT_BLKADDR]		= "invalid blkaddr",
> +	[FAULT_FLUSH]		= "flush error",
>  };
>  
>  void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
> -- 
> 2.25.1
> 
