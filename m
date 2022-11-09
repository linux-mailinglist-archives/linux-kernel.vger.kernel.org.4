Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A3862335A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiKITVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKITVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:21:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459CEB7FB;
        Wed,  9 Nov 2022 11:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZQ2vPUoDxUbbcy9diqgjC3Orai/rhdTHUsZfq/DDEpw=; b=FhhabxTgJncNJEnewud2PD9ANd
        LFGrejsVxd/AAHK4Rl2XgoIINKNfyd1xajmnrteTPbfpvlfDvwTIELsl+Dovpu7KIbC+S92p3fCL5
        1sp3qOtUHKvkUIls5mjzrBb8NG+QBC3k9RhCEo5kWjn8c6i1pWJNppcBhz9GsxNoj5VWdOUjYJbtv
        UKWCIK+b7SFP0vsZT1Y5EZOAGV5ylSvrW2H3iPe+nNO4DGTJQAwY1HrR4YXPe+whrsmmUO7lwR3h2
        XWf8a9nF5NRoyt3nXNLnHm12iFtW3YZKZ5yfTmplds0kw1WPKH4e7b02UbYYFVMVvUhF7wUFlTzRX
        qWcgMG2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osqdZ-00BSTh-CT; Wed, 09 Nov 2022 19:21:25 +0000
Date:   Wed, 9 Nov 2022 19:21:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, corbet@lwn.net,
        linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: support fault injection for flush submission error
Message-ID: <Y2v9tZEXxSyF0LnZ@casper.infradead.org>
References: <20221109183549.11012-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109183549.11012-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 02:35:49AM +0800, Yangtao Li wrote:
> +++ b/fs/f2fs/segment.c
> @@ -486,7 +486,17 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
>  static int __submit_flush_wait(struct f2fs_sb_info *sbi,
>  				struct block_device *bdev)
>  {
> -	int ret = blkdev_issue_flush(bdev);
> +	int ret;
> +
> +	if (time_to_inject(sbi, FAULT_FLUSH)) {
> +		f2fs_show_injection_info(sbi, FAULT_FLUSH);
> +		ret = -EIO;
> +		goto submit;

submit?  You don't submit anything at the 'submit' label.  it should
be called 'skip' or something.  But I think this is just badly written
and you don't need a goto at all.

What I don't understand about this patch is why you want it at all.
What failure are you simulating?  It appears to me that you're
simulating a bug in the filesystem, or maybe a bug in the device
firmware.  But why do you want to do that?

> +	}
> +
> +	ret = blkdev_issue_flush(bdev);
> +
> +submit:
>  
>  	trace_f2fs_issue_flush(bdev, test_opt(sbi, NOBARRIER),
>  				test_opt(sbi, FLUSH_MERGE), ret);
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
