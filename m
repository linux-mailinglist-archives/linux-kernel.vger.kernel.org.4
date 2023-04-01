Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03BF6D2D7A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 03:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjDAB5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 21:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjDAB5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 21:57:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E892D26595
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 18:55:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74512B83347
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 01:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7C4C433EF;
        Sat,  1 Apr 2023 01:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680313759;
        bh=jT5FBQyI7dpDl0WTd9grmQmwScdfcc+9wiwY0baN8Kc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=elrvg/Oo5WlLKQy73XlerIavUGkkTcdArmOZXaJ1/SBdzXYmLyYL3xebLJ1L3lTMN
         AEWrGzdl5GCOkmKLJzD4rO1LcfzOi1ZeeSPNyvn0VfZfl4rz6m+eC7HpudqXfyPPwr
         xzsHX2yWdfd+Exd46Ui+PWop1ejTmf4oJhFBjskAPQbwqkBBS6ONtGHm5PU+VoAzS+
         0CgNSU4rPHK5JEw11R6edygxr4ZoR9IeUMb+qPiUeOm+c7MtXga/qGt9Z7Nd3dNtiA
         oG46adXJUrxZSWyb/ZEd0WA6VElFNkT6SeFXVpzd/hYO++6FtJjtwMWK2xqi4XBkCm
         lYpVkAqKiT2cQ==
Message-ID: <6db7be47-9455-c466-f99a-497f8fe8930a@kernel.org>
Date:   Sat, 1 Apr 2023 09:49:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix align check for npo2
Content-Language: en-US
To:     Yohan Joung <jyh429@gmail.com>, jaegeuk@kernel.org
Cc:     lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        oe-kbuild-all@lists.linux.dev
References: <ZBzlJ36kO5KvxODB@google.com>
 <20230324130747.523-1-jyh429@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230324130747.523-1-jyh429@gmail.com>
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

On 2023/3/24 21:07, Yohan Joung wrote:
> Fix alignment check to be correct in npo2 as well
> 
> Signed-off-by: Yohan Joung <yohan.joung@sk.com>
> ---
>   fs/f2fs/segment.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 055e70e77aa2..f4a22a065277 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1842,6 +1842,7 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
>   	sector_t sector, nr_sects;
>   	block_t lblkstart = blkstart;
>   	int devi = 0;
> +	u32 remainder = 0;
>   
>   	if (f2fs_is_multi_device(sbi)) {
>   		devi = f2fs_target_device_index(sbi, blkstart);
> @@ -1857,9 +1858,9 @@ static int __f2fs_issue_discard_zone(struct f2fs_sb_info *sbi,
>   	if (f2fs_blkz_is_seq(sbi, devi, blkstart)) {
>   		sector = SECTOR_FROM_BLOCK(blkstart);
>   		nr_sects = SECTOR_FROM_BLOCK(blklen);
> +		div_u64_rem(sector, bdev_zone_sectors(bdev), &remainder);

Should use div64_u64_rem()? As both sector and return value of bdev_zone_sectors()
are u64.

Thanks,

>   
> -		if (sector & (bdev_zone_sectors(bdev) - 1) ||
> -				nr_sects != bdev_zone_sectors(bdev)) {
> +		if (remainder || nr_sects != bdev_zone_sectors(bdev)) {
>   			f2fs_err(sbi, "(%d) %s: Unaligned zone reset attempted (block %x + %x)",
>   				 devi, sbi->s_ndevs ? FDEV(devi).path : "",
>   				 blkstart, blklen);
