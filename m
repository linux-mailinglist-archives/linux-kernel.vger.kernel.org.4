Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843816D2C29
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 02:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjDAAxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 20:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjDAAxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 20:53:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397002101
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 17:53:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04B4262CB3
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 00:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E05C433D2;
        Sat,  1 Apr 2023 00:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680310412;
        bh=tjj1t2PTYkZFmbtF1kyMqydk62CVEgDkZgmOGSTAPhM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l8k6O9jpxq+f4XQI/SnWJhczCG4eHTK8BxXQ2hirUpQf7vYHBO4O4/dTdcXotCGhO
         0/Ba8QBDcEUhB0y8O1hY6KcqQWAV28h7H3ow2X/X3cr88D21K5ajedCoDqwTij6IfC
         YC49epT+pGYkWmkbFvthWkrgMYDeTkpem2Gx5exh/IfAf4HvYkI5eCJqouWIehQb0d
         mWyoo0brrvrJwnyYMwMh16J1vM+7Ve7pGq7VHQilU+3rDe0BwDfU2C4TyyzLYO3JNl
         NkaRMuF67VgNyZaS8taJUy+4PMuCHYGDKAxZsW10Lf/6TTRn2kRytLEjtAT0lCmwOi
         yNoUSAGh/vDoA==
Message-ID: <203ef118-30ca-0ce9-f73e-c5ee45f61369@kernel.org>
Date:   Sat, 1 Apr 2023 08:53:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] f2fs: fix iostat lock protection
To:     Bo Ye <bo.ye@mediatek.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     yongdong.zhang@mediatek.com, peng.zhou@mediatek.com,
        browse.zhang@mediatek.com, light.hsieh@mediatek.com,
        Qilin Tan <qilin.tan@mediatek.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230331092658.72386-1-bo.ye@mediatek.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230331092658.72386-1-bo.ye@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/31 17:26, Bo Ye wrote:
> From: Qilin Tan <qilin.tan@mediatek.com>
> 
> Made iostat lock irq safe to avoid potentinal deadlock.
> 
> Deadlock scenario:
> f2fs_attr_store
>    -> f2fs_sbi_store
>    -> _sbi_store
>    -> spin_lock(sbi->iostat_lock)
>      <interrupt request>
>      -> scsi_end_request
>      -> bio_endio
>      -> f2fs_dio_read_end_io
>      -> f2fs_update_iostat
>      -> spin_lock_irqsave(sbi->iostat_lock)  ===> Dead lock here
> 

Fixes: 61803e984307 ("f2fs: fix iostat related lock protection")
Fixes: a1e09b03e6f5 ("f2fs: use iomap for direct I/O")

> Signed-off-by: Qilin Tan <qilin.tan@mediatek.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> ---
>   fs/f2fs/sysfs.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 0b19163c90d4..fd238a68017e 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -575,9 +575,9 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   	if (!strcmp(a->attr.name, "iostat_period_ms")) {
>   		if (t < MIN_IOSTAT_PERIOD_MS || t > MAX_IOSTAT_PERIOD_MS)
>   			return -EINVAL;
> -		spin_lock(&sbi->iostat_lock);
> +		spin_lock_irq(&sbi->iostat_lock);
>   		sbi->iostat_period_ms = (unsigned int)t;
> -		spin_unlock(&sbi->iostat_lock);
> +		spin_unlock_irq(&sbi->iostat_lock);
>   		return count;
>   	}
>   #endif
