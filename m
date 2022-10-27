Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B282660F8E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiJ0NT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiJ0NTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:19:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D270C1A228
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:19:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18965622FB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F367C433D7;
        Thu, 27 Oct 2022 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666876787;
        bh=Synhsdq7aucXPF27l++LXoYHda67bqMcrjW8SAWdwL0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OmGZrQE6Hfm5Rpy/xlALCIt1kch5oV0oWlFhX74YaA0MLqfAQB+ZuMKNhmX5i9cZ0
         r4BvXAujrkUZeCz0M5+xT67EkvI4sLs3oR/X8ErntaWwbXnQEWqJHd9bJHcrCk+G/Z
         MRZAhjkfONUnLeH9OE0gEAs+TbVwu+4pGeiQef4EW2kiX+7NMQxzoMMezecCKojdkO
         DC6lWUGNfhgQzZtjP7JNlinZAJFJBAdeux+o7kBNWGvG2LohoR/uUdy1dlkuSY0ql/
         YpGiSK+w+I5b1AtQJiQHD1Eol/niTOPjKeDKI/HHTWbYTaDCn3BCzJsyEBX8ayX0TD
         /BTYwzQLbbpkg==
Message-ID: <38e9d711-a3c6-3f02-19c4-9d298d386e4c@kernel.org>
Date:   Thu, 27 Oct 2022 21:19:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/2] f2fs: cleanup in f2fs_create_flush_cmd_control() and
 f2fs_start_gc_thread()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221027102447.75708-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221027102447.75708-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/27 18:24, Yangtao Li wrote:
> Just cleanup for readable, no functional changes.

How about doing such cleanup in one patch?

Thanks,

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/gc.c      | 14 ++++++--------
>   fs/f2fs/segment.c |  3 +--
>   2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 674a905063db..85d16f4106de 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -171,13 +171,10 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
>   {
>   	struct f2fs_gc_kthread *gc_th;
>   	dev_t dev = sbi->sb->s_bdev->bd_dev;
> -	int err = 0;
>   
>   	gc_th = f2fs_kmalloc(sbi, sizeof(struct f2fs_gc_kthread), GFP_KERNEL);
> -	if (!gc_th) {
> -		err = -ENOMEM;
> -		goto out;
> -	}
> +	if (!gc_th)
> +		return -ENOMEM;
>   
>   	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
>   	gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME;
> @@ -192,12 +189,13 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
>   	sbi->gc_thread->f2fs_gc_task = kthread_run(gc_thread_func, sbi,
>   			"f2fs_gc-%u:%u", MAJOR(dev), MINOR(dev));
>   	if (IS_ERR(gc_th->f2fs_gc_task)) {
> -		err = PTR_ERR(gc_th->f2fs_gc_task);
> +		int err = PTR_ERR(gc_th->f2fs_gc_task);
>   		kfree(gc_th);
>   		sbi->gc_thread = NULL;
> +		return err;
>   	}
> -out:
> -	return err;
> +
> +	return 0;
>   }
>   
>   void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 282616e6852a..becceee8e337 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -638,7 +638,6 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
>   {
>   	dev_t dev = sbi->sb->s_bdev->bd_dev;
>   	struct flush_cmd_control *fcc;
> -	int err;
>   
>   	if (SM_I(sbi)->fcc_info) {
>   		fcc = SM_I(sbi)->fcc_info;
> @@ -662,7 +661,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
>   	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
>   				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
>   	if (IS_ERR(fcc->f2fs_issue_flush)) {
> -		err = PTR_ERR(fcc->f2fs_issue_flush);
> +		int err = PTR_ERR(fcc->f2fs_issue_flush);
>   		kfree(fcc);
>   		SM_I(sbi)->fcc_info = NULL;
>   		return err;
