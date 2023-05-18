Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAA3707788
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjERBnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjERBnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:43:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C99BE7A
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:43:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDF8A64723
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 01:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C21AC433D2;
        Thu, 18 May 2023 01:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684374187;
        bh=V1QyoFTT+Ee/QBXVRzPRa7RvNORRIM/WD7FTNTXvJFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZqfaSVcCrvRNg0YPnrXy6Hiv86b0rqwYmk4gmHd7F3jBBr4HGqgRV02uNa+D5NzRc
         9Qv4r0Lw22HKDZFEuI2o9auVMBmF1Khh91DaarMmNMoox4jq4hnUQUWwLALfbWZchc
         JVCGO+VKK5CQdoA4ta7rLgT0TFfjufLbIIOH1dMmlRUu0w4WAETwQWJ50eEzIsohT9
         WQu/rD7qpxvEM9JDJ+hOAxTmAjauDpjiNlW1kWIah2rUsVXP8AthxMU5RquGTtIMIw
         2l0M8xbSvyHVXw0xnXZL+Gz7xWZJSa8VabQl3xMHTgjgc8wYCrm33L4IqRFyHLInMl
         9oKzppjvXTv8A==
Date:   Wed, 17 May 2023 18:43:05 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: flush error flags in workqueue
Message-ID: <ZGWCqZeMS/wsjg7W@google.com>
References: <20230516145911.162431-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516145911.162431-1-chao@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16, Chao Yu wrote:
> In IRQ context, it wakes up workqueue to record errors into on-disk
> superblock fields rather than in-memory fields.
> 

Fixes:?

> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - make f2fs_record_errors() static.
>  fs/f2fs/compress.c |  2 +-
>  fs/f2fs/f2fs.h     |  1 +
>  fs/f2fs/super.c    | 26 +++++++++++++++++++++++---
>  3 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 10b545a1088e..75d3d99fffcc 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -744,7 +744,7 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
>  
>  		/* Avoid f2fs_commit_super in irq context */
>  		if (!in_task)
> -			f2fs_save_errors(sbi, ERROR_FAIL_DECOMPRESSION);
> +			f2fs_handle_error_async(sbi, ERROR_FAIL_DECOMPRESSION);
>  		else
>  			f2fs_handle_error(sbi, ERROR_FAIL_DECOMPRESSION);
>  		goto out_release;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 0f05c1dd633f..99edc4981edf 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3563,6 +3563,7 @@ void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag);
>  void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
>  							bool irq_context);
>  void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error);
> +void f2fs_handle_error_async(struct f2fs_sb_info *sbi, unsigned char error);
>  int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
>  int f2fs_sync_fs(struct super_block *sb, int sync);
>  int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 51812f459581..17082dc3c1a3 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3980,6 +3980,11 @@ static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
>  	f2fs_down_write(&sbi->sb_lock);
>  
>  	spin_lock_irqsave(&sbi->error_lock, flags);
> +	if (sbi->error_dirty) {
> +		memcpy(F2FS_RAW_SUPER(sbi)->s_errors, sbi->errors,
> +							MAX_F2FS_ERRORS);
> +		sbi->error_dirty = false;
> +	}
>  	memcpy(raw_super->s_stop_reason, sbi->stop_reason, MAX_STOP_REASON);
>  	spin_unlock_irqrestore(&sbi->error_lock, flags);
>  
> @@ -4019,12 +4024,10 @@ static bool f2fs_update_errors(struct f2fs_sb_info *sbi)
>  	return need_update;
>  }
>  
> -void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error)
> +static void f2fs_record_errors(struct f2fs_sb_info *sbi, unsigned char error)
>  {
>  	int err;
>  
> -	f2fs_save_errors(sbi, error);
> -
>  	f2fs_down_write(&sbi->sb_lock);
>  
>  	if (!f2fs_update_errors(sbi))
> @@ -4038,6 +4041,23 @@ void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error)
>  	f2fs_up_write(&sbi->sb_lock);
>  }
>  
> +void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error)
> +{
> +	f2fs_save_errors(sbi, error);
> +	f2fs_record_errors(sbi, error);
> +}
> +
> +void f2fs_handle_error_async(struct f2fs_sb_info *sbi, unsigned char error)
> +{
> +	f2fs_save_errors(sbi, error);
> +
> +	if (!sbi->error_dirty)
> +		return;
> +	if (!test_bit(error, (unsigned long *)sbi->errors))
> +		return;
> +	schedule_work(&sbi->s_error_work);
> +}
> +
>  static bool system_going_down(void)
>  {
>  	return system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF
> -- 
> 2.25.1
