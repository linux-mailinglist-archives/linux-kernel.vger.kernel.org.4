Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8EF5B8D51
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiINQnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiINQnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:43:40 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF129796A4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p0nNQonitIzyxK9JwPGKSpAgLtU8h121WpYGnuj58kg=; b=aDvgresHHEIy2mC6FZyabKavW7
        RUHQ+xcPelAm99KjFHK5m6gLwFw/5d4Dji5VY269XgsRLS7gHzd4FFcQGJwiSQgx/FyDSBbz/TXY5
        LNQvk5X8mIl5fONDkY1Kzu0a10M+kdhRtVqhKOWzIgWPdTqCsrK0g6XTBKPXrytTcvyfOoa9PudCe
        djsOtpUkuvKD4CN2Ql6OTqFQVYGsdar8BrH12EGJiRCyY5VXMuU/yrB/Z05TNEXn4h+L5PVXt9gbt
        ckO+o8/FTgmT1XfFMqPGT4DRZEc0v2Xyj6Yxp4fhj4uGIiRPBc2tXJ5tE6CzcnVmWjdX2NDxT8HJT
        Xo96LboQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oYVU2-00GF5R-0c;
        Wed, 14 Sep 2022 16:43:30 +0000
Date:   Wed, 14 Sep 2022 17:43:30 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlbfs: use macro SZ_1K to replace 1024
Message-ID: <YyIEsuOm0wEkmpAA@ZenIV>
References: <20220914115723.38271-1-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914115723.38271-1-xhao@linux.alibaba.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 07:57:23PM +0800, Xin Hao wrote:
> Using macro SZ_1K in hugetlbfs_show_options() has no any functional
> changes, just makes code more readable.

Why is it any more readable that way?

> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  fs/hugetlbfs/inode.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index f7a5b5124d8a..9b9784ffe8de 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1023,10 +1023,10 @@ static int hugetlbfs_show_options(struct seq_file *m, struct dentry *root)
>  	if (sbinfo->max_inodes != -1)
>  		seq_printf(m, ",nr_inodes=%lu", sbinfo->max_inodes);
> 
> -	hpage_size /= 1024;
> +	hpage_size /= SZ_1K;
>  	mod = 'K';
> -	if (hpage_size >= 1024) {
> -		hpage_size /= 1024;
> +	if (hpage_size >= SZ_1K) {
> +		hpage_size /= SZ_1K;
>  		mod = 'M';
>  	}
>  	seq_printf(m, ",pagesize=%lu%c", hpage_size, mod);
> --
> 2.31.0
