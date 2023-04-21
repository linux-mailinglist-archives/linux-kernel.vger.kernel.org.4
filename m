Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDC56EA195
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjDUCYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjDUCX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:23:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EEE3C34
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 19:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 738D564D18
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEFCC433D2;
        Fri, 21 Apr 2023 02:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682043837;
        bh=1Nm5Zb6uJo/S3RC7aYlzD7h6cDUnGH6wY4UXaWEbzPs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PPw0tAgskpKmZ3wBuiV3DQzVSL/PFsI7NlcNsk/l/rGRxd5FMaaFab11mduc8ibiu
         oKMu8YJIINLXmc1TsD7VDpqlXc5MlANpML2MPWJPKQU9/1xzPJBOsxy29h3K9ety/Q
         JzQLnnlzkw+DYYNgJ+CTPUg54zDtvh8SjrV/bC7v7JbTNe25yePmSJN+gBvkG0UQnA
         dkfMtbrD8CcqoV22kwdZFW1q5gtBnf56r6HicdRNyu5kK7SsapvN8llL/IOQLo0FZO
         LEVWhX/7UZjcnYsQ4imHKURgw+IcxRm7HIPXasl5faFJWFc3C5susW0bmOjmAudHih
         7zzCEp6Ib5c1w==
Message-ID: <44ca783a-da8c-aec9-ac35-76acc5475cb9@kernel.org>
Date:   Fri, 21 Apr 2023 10:23:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [f2fs-dev] [PATCH] f2fs: use cow inode data when updating atomic
 write
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20230418175206.3282328-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230418175206.3282328-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/19 1:52, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Need to use cow inode data content instead of the one in the original
> inode, when we try to write the already updated atomic write files.
> 

Miss a fixes line?

Otherwise it looks good to me.

Thanks

> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fs/f2fs/data.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8df225014304..7165b1202f53 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3491,7 +3491,7 @@ static int __reserve_data_block(struct inode *inode, pgoff_t index,
>   
>   static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
>   			struct page *page, loff_t pos, unsigned int len,
> -			block_t *blk_addr, bool *node_changed)
> +			block_t *blk_addr, bool *node_changed, bool *use_cow)
>   {
>   	struct inode *inode = page->mapping->host;
>   	struct inode *cow_inode = F2FS_I(inode)->cow_inode;
> @@ -3505,10 +3505,12 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
>   
>   	/* Look for the block in COW inode first */
>   	err = __find_data_block(cow_inode, index, blk_addr);
> -	if (err)
> +	if (err) {
>   		return err;
> -	else if (*blk_addr != NULL_ADDR)
> +	} else if (*blk_addr != NULL_ADDR) {
> +		*use_cow = true;
>   		return 0;
> +	}
>   
>   	if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE))
>   		goto reserve_block;
> @@ -3538,6 +3540,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>   	struct page *page = NULL;
>   	pgoff_t index = ((unsigned long long) pos) >> PAGE_SHIFT;
>   	bool need_balance = false;
> +	bool use_cow = false;
>   	block_t blkaddr = NULL_ADDR;
>   	int err = 0;
>   
> @@ -3597,7 +3600,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>   
>   	if (f2fs_is_atomic_file(inode))
>   		err = prepare_atomic_write_begin(sbi, page, pos, len,
> -					&blkaddr, &need_balance);
> +					&blkaddr, &need_balance, &use_cow);
>   	else
>   		err = prepare_write_begin(sbi, page, pos, len,
>   					&blkaddr, &need_balance);
> @@ -3637,7 +3640,9 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>   			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>   			goto fail;
>   		}
> -		err = f2fs_submit_page_read(inode, page, blkaddr, 0, true);
> +		err = f2fs_submit_page_read(use_cow ?
> +				F2FS_I(inode)->cow_inode : inode, page,
> +				blkaddr, 0, true);
>   		if (err)
>   			goto fail;
>   
