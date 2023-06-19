Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882BF734999
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 03:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjFSBBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 21:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFSBBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:01:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5829D19C
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 18:01:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E099160C86
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0D3C433C0;
        Mon, 19 Jun 2023 01:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687136477;
        bh=0yBXOWC+sGbvgh0ahDkRtxdfWqQ6lj+N8XLvthihCmo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M5rD5E3Ze2nXZwcc+ZT7BY5+u9m/Yd34459/26YyOIIqIV6+3wbZ2kBwi+CrPksQU
         JmWq4EI+0ZERTnqOmn8D0rbqqplv9RTLNjdvSfFahLM0+scWkhl5ZxCKhD37B3PcEn
         lsJ119Ik8kCd9GokQSnnCc3UBAOYjgx/Wy2qE+PbgJHAFXpsoFI6TnFSgc4MQBrrVd
         1x2k0Rd27lEOvHDmArXJjFjbLK82FcnuAhrsHa4xH+W0giltepbM7M+yjquh7eOoBY
         u+KmW5hz7+vtzdRQ2GAUzonaQCBsGjMhhFagry+kjHCmEcK4UitTVhpaZiwY/b8L2B
         6aH3iAc6KrdyA==
Message-ID: <700bd4aa-20ac-a73d-2fb8-416e41ba208b@kernel.org>
Date:   Mon, 19 Jun 2023 09:01:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [f2fs-dev][PATCH] f2fs: count mmap write io more accurately
Content-Language: en-US
To:     Yunlei He <heyunlei@oppo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230613065135.3517335-1-heyunlei@oppo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230613065135.3517335-1-heyunlei@oppo.com>
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

On 2023/6/13 14:51, Yunlei He wrote:
> This patch count mmap write io more accurately and remove
> redundant PageUptodate judgement in f2fs_vm_page_mkwrite.

Yunlei,

What about separating this patch:
- remove unneeded uptodate check/set.
- fix incorrect PageMappedToDisk check and goto logic.

Thanks,

> 
> Signed-off-by: Yunlei He <heyunlei@oppo.com>
> ---
>   fs/f2fs/file.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4dd4e2bd000a..34a6177c64a4 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -149,14 +149,12 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>                  zero_user_segment(page, offset, PAGE_SIZE);
>          }
>          set_page_dirty(page);
> -       if (!PageUptodate(page))
> -               SetPageUptodate(page);
> 
> +out_sem:
>          f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, F2FS_BLKSIZE);
>          f2fs_update_time(sbi, REQ_TIME);
> 
>          trace_f2fs_vm_page_mkwrite(page, DATA);
> -out_sem:
>          filemap_invalidate_unlock_shared(inode->i_mapping);
> 
>          sb_end_pagefault(inode->i_sb);
> --
