Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225AD705D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjEQCbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjEQCbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:31:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AC39B
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:31:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F2A4640E3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D41C433EF;
        Wed, 17 May 2023 02:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684290663;
        bh=U3hlYielRl+Zlfry5z+DIvZqfK56E0/XCd0A2B3lgVQ=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=dspg+YXHIiktfnthq/TguCfKe+h6PuxcJxeqL71F/VnkX1rSCaOqJstrg0WDviutJ
         HiD5KnnD1cZszmksYylYXQn6VkvWwhm37EMD4kC4OtYqm1MORQ9vI4COcymY+r9r+Y
         uDZuF0yYThajzSZnv5jUatXRVEuCbXouiOGgEI1Z3Dgm3D2yBQH3nhrxZCjV9wFtpg
         Tf+RAqJTt35AQxDIhI1vBNvSTJBVqMggqCnH04M7ftGKeoIBlpET2pXpYxDkzmfXva
         rtLUoEldKFmuwMw+MQ88rCo+qnPYnxwDqS2IeFfta+kyPSR7Mm8VAw4lN/IC1pm4K+
         ebS4UiTfqlsLw==
Message-ID: <5f0218d5-f11d-92db-097a-1db76a142138@kernel.org>
Date:   Wed, 17 May 2023 10:31:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230511091308.10509-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: add fsnotify_sb_error() in f2fs_save_errors
In-Reply-To: <20230511091308.10509-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/11 17:13, Yangtao Li wrote:
> When an EFSCORRUPTED error occurs in f2fs, report the error to
> userspace monitoring tools.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/super.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 51812f459581..42d5aa504afe 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -28,6 +28,7 @@
>   #include <linux/part_stat.h>
>   #include <linux/zstd.h>
>   #include <linux/lz4.h>
> +#include <linux/fsnotify.h>
>   
>   #include "f2fs.h"
>   #include "node.h"
> @@ -4000,6 +4001,8 @@ void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag)
>   		sbi->error_dirty = true;
>   	}
>   	spin_unlock_irqrestore(&sbi->error_lock, flags);
> +
> +	fsnotify_sb_error(sbi->sb, NULL, EFSCORRUPTED);

Can we call this function in irq context?

- f2fs_decompress_cluster
  - f2fs_save_errors

Thanks,

>   }
>   
>   static bool f2fs_update_errors(struct f2fs_sb_info *sbi)
