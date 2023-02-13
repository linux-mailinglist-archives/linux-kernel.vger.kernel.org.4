Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570AB69418F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjBMJme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjBMJma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:42:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA94715CAE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:42:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25A5E60F4F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43C4C433EF;
        Mon, 13 Feb 2023 09:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676281321;
        bh=l5IXwvpcb8RzRjt++C3qtxOkpWxUcc0oGQB/6S5HGGo=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=LVkw+rgN+9Fgdoh/f2VrvBjyOV+W8qNMS/+rNX0nb3i8RRBZM71EJlvn3xZXGCK5M
         r0XtiVL2akR1QcwgfSuzfHXQO6Cwgn6DmTXAWWvxiz7z+q8Hgsq2zxSA43MLuZeYG+
         Hon37E+1SCCkkhiXt0aB9FUlUbEl5ZOViK0tHycYVLK0al7EdzxPqcvpUIFkvmZcXn
         hn53E5XLixMT9PQN1bVkzlXscNWmyJyrJwXkZMyHi+Ssu5q9XMsPTdhtG1nRUJ4WgK
         rDm2p9PV5EAqdCWveNcwcA7HlLvtd5eSAe9Jb2dwJVT6c1H7XM+PyU6kY7jVxkReek
         DUGORYGTAd6MQ==
Message-ID: <1a66e32b-efc0-626b-b585-7f2bfac506a7@kernel.org>
Date:   Mon, 13 Feb 2023 17:41:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix wrong segment count
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20230210213250.3471246-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230210213250.3471246-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/11 5:32, Jaegeuk Kim wrote:
> MAIN_SEGS is for data area, while TOTAL_SEGS includes data and metadata.

Good catch!

Could you please add fixes line?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/segment.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 8ee5e5db9287..6003fbaf4b7d 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -720,7 +720,7 @@ static inline unsigned char curseg_alloc_type(struct f2fs_sb_info *sbi,
>   
>   static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
>   {
> -	f2fs_bug_on(sbi, segno > TOTAL_SEGS(sbi) - 1);
> +	f2fs_bug_on(sbi, segno > MAIN_SEGS(sbi) - 1);
>   }
>   
>   static inline void verify_fio_blkaddr(struct f2fs_io_info *fio)
> @@ -775,7 +775,7 @@ static inline int check_block_count(struct f2fs_sb_info *sbi,
>   
>   	/* check segment usage, and check boundary of a given segment number */
>   	if (unlikely(GET_SIT_VBLOCKS(raw_sit) > usable_blks_per_seg
> -					|| segno > TOTAL_SEGS(sbi) - 1)) {
> +					|| segno > MAIN_SEGS(sbi) - 1)) {
>   		f2fs_err(sbi, "Wrong valid blocks %d or segno %u",
>   			 GET_SIT_VBLOCKS(raw_sit), segno);
>   		set_sbi_flag(sbi, SBI_NEED_FSCK);
