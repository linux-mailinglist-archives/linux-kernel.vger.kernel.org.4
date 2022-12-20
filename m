Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA88651A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 05:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiLTEzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 23:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiLTEzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 23:55:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DF6FD04
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 20:55:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C01CF6115E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B7BC433EF;
        Tue, 20 Dec 2022 04:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671512145;
        bh=GO91DA62dHcU7Q/IJM2c+OtFqkL8CSTiPULcSnxTK68=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=p7XZpBHyVGDRJbYNgkBWTtK0s0fOTBFN9ejLUyQLm7pBGJX3weslrBmxnFeLyc/Hh
         7WqRpWndI3aGmtghZopcWqi+tdQq2Vdtd4b/i4YHIiRT+c7EhTBLcbZVfnUs6yO88u
         4Kv6CJhtODRsevqrSd7Q4eRia55jtQyP+x9h1Y6AlEQvbE9HhvmwwYauVotm7FWIap
         wql6qDCPiLT+heQNh8j/De08euUpEnvv4E/p+8WjFAeED6Oc7m2SJLLtccnKQyDij8
         fkox45tyLYq7EdjUraUxNb0Tlfuacw94BiibuK+eSChQHZ+3ea+1tGPXp5UO8vK83z
         ReQwA+dK4YcTQ==
Message-ID: <7cd515b7-cc24-bc66-416d-c9d27fade0ec@kernel.org>
Date:   Tue, 20 Dec 2022 12:55:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] f2fs: maintain discard in separated file
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221217132318.37718-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221217132318.37718-1-frank.li@vivo.com>
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

On 2022/12/17 21:23, Yangtao Li wrote:
> This patch moves discard related code from segment.c into discard.c
> since discard is independent feature, and it's better to maintain
> them in separated place.
> 
> There is no functionality change.

Please check Jaegeuk's comments on similar patch:

https://lore.kernel.org/linux-f2fs-devel/20180426160819.GI68594@jaegeuk-macbookpro.roam.corp.google.com/

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/Makefile  |    2 +-
>   fs/f2fs/discard.c | 1271 +++++++++++++++++++++++++++++++++++++++++++++
>   fs/f2fs/f2fs.h    |   37 +-
>   fs/f2fs/segment.c | 1268 +-------------------------------------------
>   4 files changed, 1317 insertions(+), 1261 deletions(-)
>   create mode 100644 fs/f2fs/discard.c
> 
> diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
> index 8a7322d229e4..3d2874633db0 100644
> --- a/fs/f2fs/Makefile
> +++ b/fs/f2fs/Makefile
> @@ -3,7 +3,7 @@ obj-$(CONFIG_F2FS_FS) += f2fs.o
>   
>   f2fs-y		:= dir.o file.o inode.o namei.o hash.o super.o inline.o
>   f2fs-y		+= checkpoint.o gc.o data.o node.o segment.o recovery.o
> -f2fs-y		+= shrinker.o extent_cache.o sysfs.o
> +f2fs-y		+= shrinker.o extent_cache.o sysfs.o discard.o
>   f2fs-$(CONFIG_F2FS_STAT_FS) += debug.o
>   f2fs-$(CONFIG_F2FS_FS_XATTR) += xattr.o
>   f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
> diff --git a/fs/f2fs/discard.c b/fs/f2fs/discard.c
> new file mode 100644
> index 000000000000..794f88fc729d
> --- /dev/null
> +++ b/fs/f2fs/discard.c
> @@ -0,0 +1,1271 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * f2fs discard support
> + *
> + * Copyright (c) 2022 Vivo Communication Technology Co.,Ltd.
> + * Author: Yangtao Li <frank.li@vivo.com>

Oops, this is not a right way that changing copyright & anthor to vivo...

Thanks,
