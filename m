Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE516C6C17
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjCWPRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjCWPRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:17:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA0920A2D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C3D46279B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A867FC433D2;
        Thu, 23 Mar 2023 15:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679584662;
        bh=QtIAtDLDIoKln0bsHHFK0vxtR/850kTuSdnFC8ym8bA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=a22tikQRQmcohKDLd6X39kaUMGIbozfwYExk+fQBxjKH/XmL7TPPhlmbbDl1PWygK
         PmF4dPhmvOyX0frC1rs9w11NZ86PWNFkdR9HzxGARg79XxM+0N8CW+oqfffLCM7uz5
         Na2/CNoHUIrUPPkTbB2VFPUSoj7sSJXbINaKuPVNh+/u1Jk0zYOSlBVDVwOgif+a4h
         qmeWDX1bdF/P3TCIi9CDKa/M8d0pUmdkeiV8mbgP/mear1kbLz39SZgXUv9uqEGty4
         3L2fEXLfcYqy0xpXf1Yms0jtWqJMm3somhV5MaY9swUZXvpndUVzYoE36T050fMguB
         xzbfKpvVYVXrQ==
Message-ID: <a24d66ad-4048-fd5c-ae47-2dd17c87bcbe@kernel.org>
Date:   Thu, 23 Mar 2023 23:17:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] f2fs: Fix discard bug on zoned block devices with 2MiB
 zone size
Content-Language: en-US
To:     yonggil.song@samsung.com,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6@epcms2p7>
 <20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6@epcms2p7>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230313094825epcms2p71e6cb549251dc55e8d202dd64b9913a6@epcms2p7>
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

On 2023/3/13 17:48, Yonggil Song wrote:
> When using f2fs on a zoned block device with 2MiB zone size, IO errors
> occurs because f2fs tries to write data to a zone that has not been reset.
> 
> The cause is that f2fs tries to discard multiple zones at once. This is
> caused by a condition in f2fs_clear_prefree_segments that does not check
> for zoned block devices when setting the discard range. This leads to
> invalid reset commands and write pointer mismatches.
> 
> This patch fixes the zoned block device with 2MiB zone size to reset one
> zone at a time.
> 
> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
> ---
>   fs/f2fs/segment.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index acf3d3fa4363..2b6cb6df623b 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1953,7 +1953,8 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>   					(end - 1) <= cpc->trim_end)
>   				continue;
>   
> -		if (!f2fs_lfs_mode(sbi) || !__is_large_section(sbi)) {
> +		if (!f2fs_sb_has_blkzoned(sbi) &&

Could you please add one line comment here for this change?

Otherwise it looks good to me.

Thanks,

> +		    (!f2fs_lfs_mode(sbi) || !__is_large_section(sbi))) {
>   			f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
>   				(end - start) << sbi->log_blocks_per_seg);
>   			continue;
