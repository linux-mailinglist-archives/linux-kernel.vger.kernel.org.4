Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909656E1122
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjDMP3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjDMP3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:29:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9782910F3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:29:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29B416182A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329FBC433D2;
        Thu, 13 Apr 2023 15:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681399742;
        bh=SbY4cgzPfRHfySIlq6Z98QogrSfw3n716DdbqzyZ3AI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=roxE3wZlWsu6I92M2tndR+hD1mYLGKDdnpBO7elo3D3XGuItF06TZeCgJaeBizQUP
         Mye1jmF0gT7bg9xuK/df8jsihs2IthFf3DueAF/ODv6Czg3wqOCzkaLnlTOkhvJeeA
         Q9IQP65MJPwf/6bTHWLFtAw7XyFC85Ys8onT8RLf2Dq2eMGgfGTUieod+Tt8Ej+3HZ
         a9RPQ4j9u+6iSu1mOmxcGzbzRtDsqw4WHLQySv2lyN6o88LTthgvmWfpahCH8w6f7J
         npGeUAqGHQOa4+QK3FmOIgvUW1jCk9FKdx4sUkI+gQa8IEdNRMdhHGOYrIc+FIzYCB
         kMnl6HVsBNRMQ==
Message-ID: <82ecc91f-a739-4744-29da-227daf5e45a2@kernel.org>
Date:   Thu, 13 Apr 2023 23:28:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: relax sanity check if checkpoint is
 corrupted
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230407181539.4136580-1-jaegeuk@kernel.org>
 <ZDbZlwH5u3/nOTwL@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZDbZlwH5u3/nOTwL@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/13 0:17, Jaegeuk Kim wrote:
> 1. extent_cache
>   - let's drop the largest extent_cache
> 2. invalidate_block
>   - don't show the warnings
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> 
>   Change log from v1:
>    - add one more case to skip the error message
> 
>   fs/f2fs/checkpoint.c   | 10 ++++++++++
>   fs/f2fs/extent_cache.c | 22 +++++++++++++++-------
>   2 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 448ecf5000b8..64b3860f50ee 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -152,6 +152,11 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
>   	se = get_seg_entry(sbi, segno);
>   
>   	exist = f2fs_test_bit(offset, se->cur_valid_map);
> +
> +	/* skip data, if we already have an error in checkpoint. */
> +	if (unlikely(f2fs_cp_error(sbi)))
> +		return exist;
> +
>   	if (exist && type == DATA_GENERIC_ENHANCE_UPDATE) {
>   		f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
>   			 blkaddr, exist);
> @@ -202,6 +207,11 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>   	case DATA_GENERIC_ENHANCE_UPDATE:
>   		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
>   				blkaddr < MAIN_BLKADDR(sbi))) {
> +
> +			/* Skip to emit an error message. */
> +			if (unlikely(f2fs_cp_error(sbi)))
> +				return false;
> +
>   			f2fs_warn(sbi, "access invalid blkaddr:%u",
>   				  blkaddr);
>   			set_sbi_flag(sbi, SBI_NEED_FSCK);
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 9a8153895d20..bea6ab9d846a 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -23,18 +23,26 @@ bool sanity_check_extent_cache(struct inode *inode)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	struct f2fs_inode_info *fi = F2FS_I(inode);
> +	struct extent_tree *et = fi->extent_tree[EX_READ];
>   	struct extent_info *ei;
>   
> -	if (!fi->extent_tree[EX_READ])
> +	if (!et)
> +		return true;
> +
> +	ei = &et->largest;
> +	if (!ei->len)
>   		return true;
>   
> -	ei = &fi->extent_tree[EX_READ]->largest;
> +	/* Let's drop, if checkpoint got corrupted. */
> +	if (is_set_ckpt_flags(sbi, CP_ERROR_FLAG)) {
> +		ei->len = 0;
> +		et->largest_updated = true;

Thsi field indicates whether it is needed to update largest extent into
inode page, since cp_error is unrecoverable, it seems we don't needed to
update it.

Thanks,

> +		return true;
> +	}
>   
> -	if (ei->len &&
> -		(!f2fs_is_valid_blkaddr(sbi, ei->blk,
> -					DATA_GENERIC_ENHANCE) ||
> -		!f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
> -					DATA_GENERIC_ENHANCE))) {
> +	if (!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE) ||
> +	    !f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
> +					DATA_GENERIC_ENHANCE)) {
>   		set_sbi_flag(sbi, SBI_NEED_FSCK);
>   		f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
>   			  __func__, inode->i_ino,
