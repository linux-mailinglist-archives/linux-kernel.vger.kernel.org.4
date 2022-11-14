Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD463628C50
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbiKNWtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiKNWtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:49:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D56CFACF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:49:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9DAFB815AA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3746DC433C1;
        Mon, 14 Nov 2022 22:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668466159;
        bh=NUbobJY+jZAYI21ip8NyjBvUaJMuLs3oukj+yekIM1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Deqfpor/mvS8DHCUD46/1r7FOV8/ZrVbcLDz1CK2AdntkhEOWmtCNBrEZb6UMsM1+
         yTI4RyduIkMiHSrbh/9/pSRSUo8wkaqeMXh0q0bwBVHGPfRQXgyU3giet8LnwWnjdP
         Hgsw0upseB/DqjvrV3EIhOALCWGUAcIO0TiPYGGyD5fEZBaS9ZKM+vjbbKvWlHrT3n
         mz3lOoIi2zRy82GVoBJ/iBI4Hl5JcVV+E2vJtZnlQT0twlF2MGEX01vveVmN5YyGNF
         Q6UGuLZy8MKyuc+KLB78Hn05saCLsa8ZdE31UjkIuA5EeKLBZ6Lnii4XsiN6+ZBtDn
         tOwASrZTkixdA==
Date:   Mon, 14 Nov 2022 14:49:17 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: remove submit label in __submit_discard_cmd()
Message-ID: <Y3LF7SjCLKaz7OWi@google.com>
References: <20221111161349.60689-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111161349.60689-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12, Yangtao Li wrote:
> Complaint from Matthew Wilcox in another similar place:
> 
> 	"submit?  You don't submit anything at the 'submit' label.
> 	it should be called 'skip' or something.  But I think this
> 	is just badly written and you don't need a goto at all."
> 
> Let's remove submit label for readability.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/segment.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 3654c30e0517..0a72e787c585 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1144,13 +1144,11 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  		if (time_to_inject(sbi, FAULT_DISCARD)) {
>  			f2fs_show_injection_info(sbi, FAULT_DISCARD);
>  			err = -EIO;
> -			goto submit;
> -		}
> -		err = __blkdev_issue_discard(bdev,
> +		} else
> +			err = __blkdev_issue_discard(bdev,
>  					SECTOR_FROM_BLOCK(start),
>  					SECTOR_FROM_BLOCK(len),
>  					GFP_NOFS, &bio);

Thanks. I added {} to meet the coding style.

> -submit:
>  		if (err) {
>  			spin_lock_irqsave(&dc->lock, flags);
>  			if (dc->state == D_PARTIAL)
> -- 
> 2.25.1
