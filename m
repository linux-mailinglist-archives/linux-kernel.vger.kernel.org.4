Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C721B6E10D5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjDMPS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjDMPS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:18:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6351FA5C1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:18:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F220063F85
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 15:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D969C4339B;
        Thu, 13 Apr 2023 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681399104;
        bh=oJARecL2z/ufUOSWn9gIWssQSTMTG3t6QN2XVk8NYeU=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=SnToTb0ZAhL3XGQoIU+SweABJiDOKLq7AnrnyrxPR+wMDu4mk9ChwnR7J/wVDjMHe
         FmJoidudW1OKs7jIhlkix0+QdAxAulxz/aaw2AF+crWLMoan9Jk3f1J2h3FmygcaNZ
         jrTYi4iquEvrrxgYwzQ1De8SJnNyof5rfSwwuhNkCNyjcxN4DVa2OQR8uH3lNDQwmQ
         E0ToeQDnqNn9ckS/hSVyD/skvohujRPfzIzMTgtYHAgzD8xE+jPJRPI/5/D+xpbPcF
         fqAiWoDuhbsmqdkBeT7aSbuJTMr84K63Of7JN+GH9E8ol6yTUSuMjKfn8HGzBjoMdt
         7867BIkFrtIHw==
Message-ID: <2e41d6e0-13bb-fa5d-00aa-75865b8e7c34@kernel.org>
Date:   Thu, 13 Apr 2023 23:18:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230406191629.63024-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: remove bulk remove_proc_entry() and unnecessary
 kobject_del()
In-Reply-To: <20230406191629.63024-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/7 3:16, Yangtao Li wrote:
> Convert to use remove_proc_subtree() and kill kobject_del() directly.
> kobject_put() actually covers kobject removal automatically, which is
> single stage removal.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/sysfs.c | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index dfbd17802549..3aad3500a701 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -1461,25 +1461,14 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
>   
>   void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
>   {
> -	if (sbi->s_proc) {
> -#ifdef CONFIG_F2FS_IOSTAT
> -		remove_proc_entry("iostat_info", sbi->s_proc);
> -#endif
> -		remove_proc_entry("segment_info", sbi->s_proc);
> -		remove_proc_entry("segment_bits", sbi->s_proc);
> -		remove_proc_entry("victim_bits", sbi->s_proc);
> -		remove_proc_entry("discard_plist_info", sbi->s_proc);
> -		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
> -	}
> +	if (sbi->s_proc)
> +		remove_proc_subtree(sbi->sb->s_id, f2fs_proc_root);
>   
> -	kobject_del(&sbi->s_stat_kobj);

- f2fs_register_sysfs
  - kobject_init_and_add(&sbi->s_stat_kobj, ..)

/**
  * kobject_init_and_add() - Initialize a kobject structure and add it to
  *                          the kobject hierarchy.
...
  *
  * This function combines the call to kobject_init() and kobject_add().
...
  */

/**
  * kobject_del() - Unlink kobject from hierarchy.
  * @kobj: object.
  *
  * This is the function that should be called to delete an object
  * successfully added via kobject_add().
  */

Am I missing something?

Thanks,

>   	kobject_put(&sbi->s_stat_kobj);
>   	wait_for_completion(&sbi->s_stat_kobj_unregister);
> -	kobject_del(&sbi->s_feature_list_kobj);
>   	kobject_put(&sbi->s_feature_list_kobj);
>   	wait_for_completion(&sbi->s_feature_list_kobj_unregister);
>   
> -	kobject_del(&sbi->s_kobj);
>   	kobject_put(&sbi->s_kobj);
>   	wait_for_completion(&sbi->s_kobj_unregister);
>   }
