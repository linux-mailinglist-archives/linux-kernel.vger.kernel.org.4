Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D491714879
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjE2LZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjE2LZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:25:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA174D2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5133861542
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 11:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D921DC433EF;
        Mon, 29 May 2023 11:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685359548;
        bh=M734HCcZquv2Cz/oEOWWN1K6CRi8dZ3pDUyW7P5kdd4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hqAbUCuYJQZZ5gpKSFeiXCkZ9JwR6wRBgfa83pameEjrvVQuIlEJnQT99mA6xEnsU
         DuL94HAz2b7EkzFY3hCkVhdF0oIMD7CCNgSHd+LPw2e64n6NOJ4xx9tomqyUegjTNz
         jCxXO8WndougxwocLVk/vcmeQrOUXjGr8bnod0eTnqpyMDFNNvYkekOXI1gpHY4bf0
         OwDe+s4gKJVKN6LAVhPqZO8aOV6WSxQ7JNOjk4dmllMXm8vrHrecnCdO+LSXFcl2RB
         VWRkyU5aMjeo0TyjqSxphJDFvVpiTXK51e41+lUrE2KpE7S3JfGqWsKIL0LMwwG61Y
         ZnaHn6Mz2n1kA==
Message-ID: <9aa57363-14ce-d851-1b15-e2f376c28abc@kernel.org>
Date:   Mon, 29 May 2023 19:25:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] f2fs: allows setting compress option to files which
 marked with FI_MMAP_FILE
Content-Language: en-US
To:     Qi Han <hanqi@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230524114159.8999-1-hanqi@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230524114159.8999-1-hanqi@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/24 19:41, Qi Han wrote:
> Allow to compress mmap files in commit e3c548323d32 ("f2fs: let's
> allow compression for mmap files"). However, we cannot set the
> compress option to the mmap file. To keep the same concept in both
> compress_modes, f2fs_ioc_set_compress_option should also allow it.
> 
> Let's remove checking mmap files in f2fs_ioc_set_compress_option so
> that we can set compress option to the mmap files.

Could you please check below patch?

https://lore.kernel.org/linux-f2fs-devel/20230529104709.2560779-1-chao@kernel.org

Thanks,

> 
> Signed-off-by: Qi Han <hanqi@vivo.com>
> ---
>   fs/f2fs/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 5ac53d2627d2..3a97b753a074 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3957,7 +3957,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
>   	file_start_write(filp);
>   	inode_lock(inode);
>   
> -	if (f2fs_is_mmap_file(inode) || get_dirty_pages(inode)) {
> +	if (get_dirty_pages(inode)) {
>   		ret = -EBUSY;
>   		goto out;
>   	}
