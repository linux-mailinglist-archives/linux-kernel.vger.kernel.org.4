Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E0872C8C4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbjFLOix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbjFLOip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:38:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1A4CF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:38:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0207D625CB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FC6C433A1;
        Mon, 12 Jun 2023 14:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686580723;
        bh=gcogc2MHa/anB+TUpT1xFrrgFluTtUso9EJEcBuwueM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j9fmqTSsfjuhMrrIloRBYfqCcAKIl0C+hg6AJ7uKGF6ASRismfc+gJNawGKSLKTf/
         PFtahFp71ewjLRU0LT3kYtgc6FnHKAiM3AFioNpmo3rSA0qw48o8sChR28x3Dl/4N7
         Zq4FWMMOEn9hvk9F9vNbcVjb/4dEoJAETSW2SF/SwQh6vGI1mfB5Z6nJ6OXnaFp6VT
         E+p2W7Yu13ckbAzQirdtN18huUeSeLwN+vyNRglKsrQJCWlNn/ISB9t1UAm4ewnqg3
         w3v4K5NrFwK09hBwL5JwfZHxEMGTBzTl70hu8H9XGwCh6iCmCx2ovGgijvfccSVGVS
         Z0rcl4WUZp5OA==
Message-ID: <8097d4d9-815e-2527-0fb7-90ec0609a4a3@kernel.org>
Date:   Mon, 12 Jun 2023 22:38:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] f2fs: compress: don't force buffered io when in
 COMPR_MODE_USER mode
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Qi Han <hanqi@vivo.com>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230609131555.56651-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230609131555.56651-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/9 21:15, Yangtao Li wrote:
> It is observed that when in user compression mode (compress_extension=*),
> even though the file is not compressed, the file is still forced to use
> buffer io, which makes the AndroBench sequential read and write drop
> significantly. In fact, when the file is not compressed, we don't need
> to force it to buffer io.
> 
>                   | w/o patch | w/ patch |
> seq read  (MB/s) | 1320.068  | 3696.154 |
> seq write (MB/s) | 617.996   | 2978.478 |
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Qi Han <hanqi@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/f2fs.h | 14 ++++++++++++++
>   fs/f2fs/file.c |  2 +-
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 1efcfd9e5a99..7f5472525310 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3168,6 +3168,20 @@ static inline int f2fs_compressed_file(struct inode *inode)
>   		is_inode_flag_set(inode, FI_COMPRESSED_FILE);
>   }
>   
> +static inline bool f2fs_is_compressed_file(struct inode *inode)
> +{
> +	int compress_mode = F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
> +
> +	if (compress_mode == COMPR_MODE_FS)
> +		return f2fs_compressed_file(inode);
> +	else if (atomic_read(&F2FS_I(inode)->i_compr_blocks) ||

Should check dirty page as well? i_compr_blocks may increase after
data writeback.

Thanks,

> +		is_inode_flag_set(inode, FI_COMPRESS_RELEASED) ||
> +		is_inode_flag_set(inode, FI_ENABLE_COMPRESS))
> +		return true;
> +
> +	return false;
> +}
> +
>   static inline bool f2fs_need_compress_data(struct inode *inode)
>   {
>   	int compress_mode = F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 74ecc9e20619..0698129b2165 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -821,7 +821,7 @@ static bool f2fs_force_buffered_io(struct inode *inode, int rw)
>   		return true;
>   	if (fsverity_active(inode))
>   		return true;
> -	if (f2fs_compressed_file(inode))
> +	if (f2fs_is_compressed_file(inode))
>   		return true;
>   
>   	/* disallow direct IO if any of devices has unaligned blksize */
