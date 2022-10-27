Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B4660F8F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiJ0NYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiJ0NYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:24:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F7417A00E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:24:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE9E9622E3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23476C433D6;
        Thu, 27 Oct 2022 13:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666877045;
        bh=rcl0QpMk9vrgc+zfC7BBi5aKHO8WAR1sc8YjGavKyNM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WeNfr1pPzbmcG2AxJ7St2fBchXUO9ILLCEDSP1H3ws3zvAXF24sSuJgRtrQd9M/hP
         Ox4qG/N9+eS6gqqm9AXg9azq1hHGvGMJqzU8LRbuUgtidYLT7H0Se+Llp4YMGp8AnJ
         E+6pe/0gdj+I/WOcJfKaJV/2WU9exs+5YfDO6hjQlXNMKeYLnLB3POCtTHFar8UQbx
         3GgRfIWNP5iMHQz2sNokvtWPT/35lVZaMP+cfap7WxwA8QDoGu/s7KPDPUcRLOU0uu
         Dvaq9qgOmccvHaexynaurN2V5r5C8Th8sDdLhbfm1FsKzhRhp/QH1tKSFW3UWrGVId
         s3+sSw8Ww3bkw==
Message-ID: <d0e09d40-89be-8f62-dfbb-1053405ad5d7@kernel.org>
Date:   Thu, 27 Oct 2022 21:24:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/3] f2fs: rename flush_error_work() to
 f2fs_record_error_work()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221027120807.6337-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221027120807.6337-1-frank.li@vivo.com>
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

On 2022/10/27 20:08, Yangtao Li wrote:
> Since it is an f2fs module, it is best to prefix function names
> with f2fs_. At the same time, there is already a flush thread
> and related functions in the system, rename flush_error_work()
> to f2fs_record_error_work().

It won't pollute global namespace since it's a static function just be
used in f2fs/super.c...

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/super.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index a241e4073f1d..fc220b5c5599 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4019,7 +4019,7 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
>   	f2fs_stop_discard_thread(sbi);
>   }
>   
> -static void flush_error_work(struct work_struct *work)
> +static void f2fs_record_error_work(struct work_struct *work)
>   {
>   	struct f2fs_sb_info *sbi = container_of(work,
>   					struct f2fs_sb_info, s_error_work);
> @@ -4374,7 +4374,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>   		goto free_devices;
>   	}
>   
> -	INIT_WORK(&sbi->s_error_work, flush_error_work);
> +	INIT_WORK(&sbi->s_error_work, f2fs_record_error_work);
>   	spin_lock_init(&sbi->error_lock);
>   	memcpy(sbi->errors, raw_super->s_errors, MAX_F2FS_ERRORS);
>   	memcpy(sbi->stop_reason, raw_super->s_stop_reason, MAX_STOP_REASON);
