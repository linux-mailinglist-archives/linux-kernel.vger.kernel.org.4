Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAD9712B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbjEZRFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjEZRFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:05:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA3CBC
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B6AD61A73
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 17:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBD1C433EF;
        Fri, 26 May 2023 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685120705;
        bh=ePK1BfFlvFrWar0yL2hBGckKFKq2mnc2EzLSm0R6ijc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GXgdFunLkyGrpkIU9YdEqlG2fBFk9ls+vr4FDXPuJGWqELhwebezmSz8ZUR5HR2da
         B8NYURXh77JegpXXuG8HPqF4UkB9PUu4sASuJEl1ME4u1LqzY47zim5rbmpJJmXHd2
         vMAlAcqxK8UURKtgU5YSO0npZFMmsQwgjKjr6YUYY9JA1A+RfYkV38jDXerzOBg5M7
         Z3/oTIeEuOK04HAm3otUSozyENpAkWbYyQhyavImhT1oTkYTDgTr3/jQZtXEV7WqKn
         wR/rmo/c4CeOGo5oSTdlB0x2N7f2jLHsQZRS5CF/YPUJe0pGbAdK+M1LYBWippl8Zi
         VVZlpvYs0S57w==
Date:   Fri, 26 May 2023 10:05:03 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: fix to set noatime and immutable flag for quota
 file
Message-ID: <ZHDmv2hLR9WZ16Pl@google.com>
References: <20230525082508.2320763-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525082508.2320763-1-chao@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/25, Chao Yu wrote:
> We should set noatime bit for quota files, since no one cares about
> atime of quota file, and we should set immutalbe bit as well, due to
> nobody should write to the file through exported interfaces.
> 
> Meanwhile this patch use inode_lock to avoid race condition during
> inode->i_flags, f2fs_inode->i_flags update.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - fix to detect i_flags status correctly.
>  fs/f2fs/super.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 51812f459581..1cf84c993d7c 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2763,7 +2763,17 @@ static int f2fs_quota_enable(struct super_block *sb, int type, int format_id,
>  	}
>  
>  	/* Don't account quota for quota files to avoid recursion */
> +	inode_lock(qf_inode);
>  	qf_inode->i_flags |= S_NOQUOTA;
> +
> +	if (!(F2FS_I(qf_inode)->i_flags & F2FS_NOATIME_FL) ||
> +		!(F2FS_I(qf_inode)->i_flags & F2FS_IMMUTABLE_FL)) {

What about this?

if ((F2FS_I(qf_inode)->i_flags & qf_flag) != qf_flag)

> +		F2FS_I(qf_inode)->i_flags |=
> +				F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
> +		f2fs_set_inode_flags(qf_inode);
> +	}
> +	inode_unlock(qf_inode);
> +
>  	err = dquot_load_quota_inode(qf_inode, type, format_id, flags);
>  	iput(qf_inode);
>  	return err;
> -- 
> 2.40.1
