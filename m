Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E2A60C172
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiJYBx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJYBxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:53:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349B5E86
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:53:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E04F5B81730
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659EAC433D6;
        Tue, 25 Oct 2022 01:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666662800;
        bh=AFgp/5bljv1xkC2WXg28XrrmXC0YtFMKV40o9tRVu2I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DzsJe2NWo41YbYaoOY8Qy9c6NCwUwP+6srq630XEkkouFJJzjjeCIcUqbocIvqFog
         Ba9RS8XMlc+3lVlcfk4QSE7VxE3+LuoIx354P9S7CHJiFOs0S+sJM1dNquW+UsD4fJ
         r+At/C2cBjzr83SyEnMxvUKY7A5ZT8rEdr7Bya7P3BY5J8EuW5hFKTFeVdkOiwM1jj
         rfTWVecLji+mE8HI7Wkt3gxI7BDpqKd72VjuoiJnrLIwOJAbo+w3p/coxXxZEVLBHf
         ogFvzd4M1ieWEG9aUUcA0kXDdAji8ruyuAZ5iEnm7aeVVVHW2c163YydlvwqGYzoip
         meiPjQNMVKoIw==
Message-ID: <dfc051bb-71ca-035c-b945-ad298aa5e1ae@kernel.org>
Date:   Tue, 25 Oct 2022 09:53:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] f2fs: make gc_idle sysfs node readable
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221021082657.26559-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221021082657.26559-1-frank.li@vivo.com>
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

On 2022/10/21 16:26, Yangtao Li wrote:
> Changed a way of showing values of them to use strings.

This change breaks forward compatibility of gc_idle interface.

Thanks,

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/sysfs.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index b4476adea776..555849d4c744 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -332,6 +332,10 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
>   		return sysfs_emit(buf, "%u\n", sbi->compr_new_inode);
>   #endif
>   
> +	if (!strcmp(a->attr.name, "gc_idle"))
> +		return sysfs_emit(buf, "%s\n",
> +				gc_mode_names[sbi->gc_mode]);
> +
>   	if (!strcmp(a->attr.name, "gc_urgent"))
>   		return sysfs_emit(buf, "%s\n",
>   				gc_mode_names[sbi->gc_mode]);
