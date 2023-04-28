Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961676F0FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 03:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344432AbjD1BDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 21:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjD1BDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 21:03:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303C82684
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 18:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C413A640A4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 01:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA979C433EF;
        Fri, 28 Apr 2023 01:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682643828;
        bh=MWkTz0nO5y2fvrZumB+rPPskXyiiOksV/05GAaM221g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JvDQBwecVOgxkrPwYu+v1ZE2Syz4HWgSmdCkD+mWMa2vI0eHJBgyPn7STtBt1DMHi
         vm50uKsprJrWXrWT7t92FY0Iz6UWkQH8HBLvDdMZBtWdQdCWPz7XwTE7dHIikf5WrO
         UfUo/uaw7f+9laePflt8GStAFuBmmWQ10a+mDUtw5I/n2OU5EJ7S++cYZf5tAfh+q6
         NRzlby4EDG3FCjvrdlGQBXfpf5zljCqwb1ghR4OciI/DOEfi/sQ/LTl9FR0npNnQ+y
         mPBWmKROkHoPZ9HsCs6uLwcLp57Mj83FhFaIHUwhmHXk8hKXT1IJgLCxcqH6eRmcDs
         K4hwbqFLzw6LQ==
Message-ID: <20801e51-623c-d2bb-6159-9d6aebc66ca9@kernel.org>
Date:   Fri, 28 Apr 2023 09:03:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] f2fs: do not allow to defragment files have
 FI_COMPRESS_RELEASED
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Daeho Jeong <daehojeong@google.com>, Qi Han <hanqi@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230425164711.19826-1-frank.li@vivo.com>
 <1a602371-d9b0-7148-c916-a02c40649d53@kernel.org>
 <ZEqhImQzKJJSNLNZ@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZEqhImQzKJJSNLNZ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/28 0:21, Jaegeuk Kim wrote:
> On 04/27, Chao Yu wrote:
>> On 2023/4/26 0:47, Yangtao Li wrote:
>>> If a file has FI_COMPRESS_RELEASED, all writes for it should not be
>>> allowed.
>>>
>>> Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
>>> Signed-off-by: Qi Han <hanqi@vivo.com>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>
>> Oh, I just see v2.
>>
>> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Applied with using goto for code consistency.

It makes sense,

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> +       if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
> +               err = -EINVAL;
> +               goto unlock_out;
> +       }
> +
>          /* if in-place-update policy is enabled, don't waste time here */
>          set_inode_flag(inode, FI_OPU_WRITE);
>          if (f2fs_should_update_inplace(inode, NULL)) {
> @@ -2712,6 +2717,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>          clear_inode_flag(inode, FI_SKIP_WRITES);
>   out:
>          clear_inode_flag(inode, FI_OPU_WRITE);
> +unlock_out:
>          inode_unlock(inode);
>          if (!err)
>                  range->len = (u64)total << PAGE_SHIFT;
> 
>>
>> Thanks,
