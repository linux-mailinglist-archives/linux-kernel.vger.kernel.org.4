Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399B16F82CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjEEMWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjEEMV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:21:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EEA18DC5
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 05:21:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97CC863DC1
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BDFC433EF;
        Fri,  5 May 2023 12:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683289317;
        bh=kVbC8QvtTP91akM/8g+e5cDFlJlaPkveDFGRjOeaEKM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qUYjMmblucGyhbYQG0FO69Lqlm7ZsgApRx0RohzGK+UBJHCp9HEfAa+qCspEh2X3B
         Q+SsPwEj+98C0tGiKZp9irP6uO3Ue2VYHUShHvRSvastgfDy94gw0KUvucjRWGHdGj
         5aQc+ITUIgrsgU6F/4HDG4gL9CUTy0A61ub7hGpszwaDKau6wHmtv/K+UjN34gg593
         1tZDFmC33ZW34x2OvYc8EAuP6p9kX5RvYha8H4oOnBdz1y7ZN16SXQdE++s/El8UjW
         +RjVh5lVtMntV3E5eaqgOiO24iPRveYNbF8vJZJn3HrHv/l7iWvgpP8GPnBG2gSIT3
         j4K9kvuEgXAZQ==
Message-ID: <c0fbc92e-2ba1-0500-023e-743ac297d587@kernel.org>
Date:   Fri, 5 May 2023 20:21:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] f2fs: fix to call invalidate_mapping_pages in
 f2fs_move_file_range
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230504185238.19488-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230504185238.19488-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/5 2:52, Yangtao Li wrote:
> In the following scenario, after executing the move_range ioctl syscall,
> the block size of the source file is 0, but data can still be read.
> 
>    # stat test
>    File: test
>    Size: 6               Blocks: 8          IO Block: 4096   regular file
>    # ./new_f2fs_io move_range test test_move_range 0 0 0
>    move range ret=0
>    # stat test
>    File: test
>    Size: 6               Blocks: 0          IO Block: 4096   regular file
>    # cat test
>    nihao
> 
> Let's fix to call invalidate_mapping_pages() after __exchange_data_block()
> success.
> 
> Fixes: 4dd6f977fc77 ("f2fs: support an ioctl to move a range of data blocks")
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/file.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 78aa8cff4b41..ae7752c5cd0a 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2870,6 +2870,9 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>   			f2fs_i_size_write(dst, dst_max_i_size);
>   		else if (dst_osize != dst->i_size)
>   			f2fs_i_size_write(dst, dst_osize);
> +
> +		invalidate_mapping_pages(src->i_mapping,
> +				pos_out, pos_in + len);

It needs to consider error cases?

Should we call this to drop page cache of src_inode after __clone_blkaddrs()
for each round exchange in __exchange_data_block()? and also drop page cache
of dst_indoe in roll_back case?

Thanks,

>   	}
>   	f2fs_unlock_op(sbi);
>   
