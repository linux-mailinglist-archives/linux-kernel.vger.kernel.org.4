Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B2D64F6B4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 02:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLQBO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 20:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQBOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 20:14:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F4D27D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 17:14:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56EBEB81E4A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 01:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3488C433D2;
        Sat, 17 Dec 2022 01:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671239656;
        bh=XQs9wEArOAjfkpOf9evtR3fsz46BwnN0f73p8uara+U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NN0pK48o5qpl6Po0hECTTtkQlyc7Bs9p7cAtQsj781QP8fwQbiRgZw8YEAMJ+WyTZ
         tVmTje9hukeqfo77qR4GOBLsC+TO/LEbYyOYt/zB27Y+xAaQalV9p09ir/BO5nhtJ1
         Lzf7Dz8TQAsjsNIJjQHH065cFCap9tgHPLPHXbBujmNRt402AVbBSdzy4jVqUkEYpJ
         RgV1Yqiphd6SGVtmJH9x4wqhiBTOZYvz6oLU8xmxnKfvS7YPxZ7c/wOlz5n3hamqlj
         e79tBzyc7XvKqNqTyBJomYZNViQQS7NecIGWBwFM82Zf5XAs1TAI8bx0LfEhF/fFll
         GDusB3ZM9pn8A==
Message-ID: <0377292c-ba43-06cd-2638-8e41e2e75f3a@kernel.org>
Date:   Sat, 17 Dec 2022 09:14:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] f2fs: merge f2fs_show_injection_info() into
 time_to_inject()
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <a2c286e1-470f-ff83-196a-f7ea490096ff@kernel.org>
 <20221216193248.71333-1-frank.li@vivo.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221216193248.71333-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/17 3:32, Yangtao Li wrote:
> Hi Chao,
> 
>> After moving f2fs_show_injection_info() core functionality into time_to_inject(),
>> __builtin_return_address(0) result changes from return address of caller of
>> f2fs_show_injection_info() to return address of time_to_inject().
> 
> It seems you are wrong, and the original patch didn't change the logic here.
> Because time_to_inject is an inline function, __builtin_return_address(0)
> has not return address of time_to_inject().

Yeah, but it depends on compile option, right? If user use -O0 or -fno-inline
option, inline function will not be expanded...

How about using deterministic implementation?

Thanks,

> 
> My test:
> 
> (1). w/ below patch, we found that the value of __builtin_return_address(0) in
> 	__time_to_inject() is the same as that in f2fs_show_injection_info().
> 
> # mount -t f2fs -o fault_type=0xffff,fault_injection=1 /mnt/9p/f2fs.img /mnt/f2fs
> [   19.739661] loop0: detected capacity change from 0 to 2097152
> [   19.749759]  new F2FS-fs (loop0) : inject kmalloc in f2fs_kmalloc of f2fs_fill_super+0x7eb/0x1780
> [   19.750313] raw F2FS-fs (loop0) : inject kmalloc in f2fs_kmalloc of f2fs_fill_super+0x7eb/0x1780
> mount: mounting /dev/loop0 on /mnt/f2fs failed: Cannot allocate memory
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4035dab1f570..1e5030633f4d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1876,11 +1876,13 @@ struct f2fs_sb_info {
> 
>   #ifdef CONFIG_F2FS_FAULT_INJECTION
>   #define f2fs_show_injection_info(sbi, type)                                    \
> -       printk_ratelimited("%sF2FS-fs (%s) : inject %s in %s of %pS\n", \
> +       printk_ratelimited("%sraw F2FS-fs (%s) : inject %s in %s of %pS\n",     \
>                  KERN_INFO, sbi->sb->s_id,                               \
>                  f2fs_fault_name[type],                                  \
>                  __func__, __builtin_return_address(0))
> -static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
> +
> +#define time_to_inject(sbi, type) __time_to_inject(sbi, type, __func__)
> +static inline bool __time_to_inject(struct f2fs_sb_info *sbi, int type, const char *func_name)
>   {
>          struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;
> 
> @@ -1893,6 +1895,10 @@ static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
>          atomic_inc(&ffi->inject_ops);
>          if (atomic_read(&ffi->inject_ops) >= ffi->inject_rate) {
>                  atomic_set(&ffi->inject_ops, 0);
> +               printk_ratelimited("%s new F2FS-fs (%s) : inject %s in %s of %pS\n",
> +                       KERN_INFO, sbi->sb->s_id,
> +                       f2fs_fault_name[type],
> +                       func_name, __builtin_return_address(0));
>                  return true;
>          }
>          return false;
> 
> (2). w/ below patch(remove inline form __time_to_inject()), we found that the value of
> 	__builtin_return_address(0) in __time_to_inject() is different from that in
> 	f2fs_show_injection_info().
> 
> # mount -t f2fs -o fault_type=0xffff,fault_injection=1 /mnt/9p/f2fs.img /mnt/f2fs
> [   81.019451] loop0: detected capacity change from 0 to 2097152
> [   81.031058]  new F2FS-fs (loop0) : inject kmalloc in f2fs_kmalloc of f2fs_init_write_merge_io+0x35/0x1c0
> [   81.031745] raw F2FS-fs (loop0) : inject kmalloc in f2fs_kmalloc of f2fs_fill_super+0x7eb/0x1710
> mount: mounting /dev/loop0 on /mnt/f2fs failed: Cannot allocate memory
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4035dab1f570..f15001b5d73b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1876,11 +1876,13 @@ struct f2fs_sb_info {
> 
>   #ifdef CONFIG_F2FS_FAULT_INJECTION
>   #define f2fs_show_injection_info(sbi, type)                                    \
> -       printk_ratelimited("%sF2FS-fs (%s) : inject %s in %s of %pS\n", \
> +       printk_ratelimited("%sraw F2FS-fs (%s) : inject %s in %s of %pS\n",     \
>                  KERN_INFO, sbi->sb->s_id,                               \
>                  f2fs_fault_name[type],                                  \
>                  __func__, __builtin_return_address(0))
> -static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
> +
> +#define time_to_inject(sbi, type) __time_to_inject(sbi, type, __func__)
> +static bool __time_to_inject(struct f2fs_sb_info *sbi, int type, const char *func_name)
>   {
>          struct f2fs_fault_info *ffi = &F2FS_OPTION(sbi).fault_info;
> 
> @@ -1893,6 +1895,10 @@ static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
>          atomic_inc(&ffi->inject_ops);
>          if (atomic_read(&ffi->inject_ops) >= ffi->inject_rate) {
>                  atomic_set(&ffi->inject_ops, 0);
> +               printk_ratelimited("%s new F2FS-fs (%s) : inject %s in %s of %pS\n",
> +                       KERN_INFO, sbi->sb->s_id,
> +                       f2fs_fault_name[type],
> +                       func_name, __builtin_return_address(0));
>                  return true;
>          }
>          return false;
> 
> Thx,
> Yangtao
