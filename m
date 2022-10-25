Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5963260C5ED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiJYH6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJYH6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:58:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8354C160ED6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:58:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F73D6178B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659C9C433C1;
        Tue, 25 Oct 2022 07:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666684722;
        bh=PMF3VvJo3bQWQNenOPvO6ZiLylBNnSBY5EWI1FSgOFQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E5OI4YHlo6c2BHQvdYP1W5YBLpAwPE0X8NubHKfbSBs/tE6vpZ/QGLWd/vpm2TWVd
         ctCMfQCZ7OyfTymZxwfzKOWG6ReLEJOlfLcXvo+ERMlXC9Zovj6TL33J6Fu9zpuSfX
         Rv7w+dnKlH6GKENwkiUeo6L3fI92kpIDZCgKi4Awgia/wxL4BJdyw4UoPVks9c2RED
         6qZjRPB59CPRYspsGwPxJfygT0oAGHc1SohdibP+8rPQm576Eu3sZx2wvoluTkb6YO
         pg1GXvl5A5HJnXCSk8/jhLV6clMkrBxdE18sL0BQamfDFWbe93o7nOI1bvnFL6AueU
         B8ZkK/lEkz/fw==
Message-ID: <5cc0d3cd-8b32-0a05-f662-e2ec4f784900@kernel.org>
Date:   Tue, 25 Oct 2022 15:58:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] f2fs: cleanup in f2fs_create_flush_cmd_control()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221025075623.7958-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221025075623.7958-1-frank.li@vivo.com>
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

On 2022/10/25 15:56, Yangtao Li wrote:
> Remove the local 'err' variable for readable,
> no functional changes.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/segment.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index acf3d3fa4363..ed247195a20c 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -620,12 +620,11 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
>   {
>   	dev_t dev = sbi->sb->s_bdev->bd_dev;
>   	struct flush_cmd_control *fcc;
> -	int err = 0;
>   
>   	if (SM_I(sbi)->fcc_info) {
>   		fcc = SM_I(sbi)->fcc_info;
>   		if (fcc->f2fs_issue_flush)
> -			return err;
> +			return 0;
>   		goto init_thread;
>   	}
>   
> @@ -638,19 +637,18 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
>   	init_llist_head(&fcc->issue_list);
>   	SM_I(sbi)->fcc_info = fcc;
>   	if (!test_opt(sbi, FLUSH_MERGE))
> -		return err;
> +		return 0;
>   
>   init_thread:
>   	fcc->f2fs_issue_flush = kthread_run(issue_flush_thread, sbi,
>   				"f2fs_flush-%u:%u", MAJOR(dev), MINOR(dev));
>   	if (IS_ERR(fcc->f2fs_issue_flush)) {
> -		err = PTR_ERR(fcc->f2fs_issue_flush);
>   		kfree(fcc);
>   		SM_I(sbi)->fcc_info = NULL;
> -		return err;
> +		return PTR_ERR(fcc->f2fs_issue_flush);

It will cause use-after-free issue.

Thanks,

>   	}
>   
> -	return err;
> +	return 0;
>   }
>   
>   void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free)
