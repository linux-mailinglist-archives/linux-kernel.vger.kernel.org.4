Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2034467F453
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 04:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjA1Dfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 22:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjA1Dfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 22:35:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDE17E699
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 19:35:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE3FFB8218D
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 03:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D347AC433D2;
        Sat, 28 Jan 2023 03:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674876938;
        bh=ApbP8EJRFMfmC3wPXgImgw5jYcobkoKDFxkpXh2Drh0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Js2I/owq0961EyvlPFtUXq5ooYps1yJbvF/JXCs7fUcJ0WOv5Ov+J6HRA0anLaHUM
         qdyhAcmSQaplf4qUaY9Qy+qlwOshueRrLI/VrR082U/vxKi6/dyFZPl9sYDLupHthe
         UZ1WNyTgXL/QTww9HYXWWBhu2tmd0H90nFc0fH6J/FL5RiPcoWksbhv9Gyj7JxXaw5
         aPjE5N1HCgAdgHJGQp/SiyiMff95BnlsFSoAOmewb4lmyfYlCYkXgbw7Ii0ALS8Hdy
         t7xVZPAu84zAa+zXc7p9xUKdgOzIHuHmUCZvNpXc7v2DtZHaXn8PZODdD0M7h9nG0F
         IZo9JSs+GGaMQ==
Message-ID: <7c12ebaa-4d3d-e475-dfb2-7b459cd26e64@kernel.org>
Date:   Sat, 28 Jan 2023 11:35:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2 v2] f2fs: fix wrong calculation of block age
Content-Language: en-US
To:     qixiaoyu1 <qxy65535@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, qixiaoyu1@xiaomi.com,
        xiongping1@xiaomi.com
References: <20230113125859.15651-1-qixiaoyu1@xiaomi.com>
 <20230116030850.20260-1-qixiaoyu1@xiaomi.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230116030850.20260-1-qixiaoyu1@xiaomi.com>
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

On 2023/1/16 11:08, qixiaoyu1 wrote:
> Currently we wrongly calculate the new block age to
> old * LAST_AGE_WEIGHT / 100.
> 
> Fix it to new * (100 - LAST_AGE_WEIGHT) / 100
>                  + old * LAST_AGE_WEIGHT / 100.
> 
> Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
> Signed-off-by: xiongping1 <xiongping1@xiaomi.com>
> ---
> Change log v1 -> v2:
>   - fix udiv
> 
>   fs/f2fs/extent_cache.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 342af24b2f8c..ad5533f178fd 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -874,11 +874,8 @@ void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
>   static unsigned long long __calculate_block_age(unsigned long long new,
>   						unsigned long long old)
>   {
> -	unsigned long long diff;
> -
> -	diff = (new >= old) ? new - (new - old) : new + (old - new);
> -
> -	return div_u64(diff * LAST_AGE_WEIGHT, 100);
> +	return div_u64(new, 100) * (100 - LAST_AGE_WEIGHT)
> +		+ div_u64(old, 100) * LAST_AGE_WEIGHT;

How about updating as below to avoid lossing accuracy if new is less than 100?

return div_u64(new * (100 - LAST_AGE_WEIGHT), 100) +
		div_u64(old * LAST_AGE_WEIGHT, 100);

Thanks,

>   }
>   
>   /* This returns a new age and allocated blocks in ei */
