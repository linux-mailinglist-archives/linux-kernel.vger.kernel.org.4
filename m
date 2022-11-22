Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15FD633683
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiKVICP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiKVICA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:02:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E061EAFB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:01:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BE3BB81985
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8DDC433D6;
        Tue, 22 Nov 2022 08:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669104117;
        bh=NOXarNOHdXXBuICnUwVDtYZMYcKMQ/aOjAW33SMD19w=;
        h=Date:To:References:From:Subject:In-Reply-To:From;
        b=UkOQD0PxLUVkb/17jR6J3yNTjiACQgT6mFyn0h2nbzFWnb4Msp9nyVjr/U/A2rwMY
         MlspqpX8BEVAFsXs/u8yr3GBABMjimM3oMeZzzmkC9/OmmDB/xmXB2MRU52UxdgF8W
         quMFacZaopt5I0zbdIijV7c7WIxRIi4yqnkQ9m2uPvVTkqNoE1OxRZiFz8GVSiuEpB
         SIT+7XlHt7AKiCmUeuNBGRKsHXAs3T1HwsR13T/oQ3jtHzE9EZe0pHH7Uq/ssslV3w
         MnwLK6Q4oJrkouN48auHLbM/Q5qTrpVhjMACkw/y56W4/6R33aeYjwXrkM3O8J21jZ
         qCb7Y48Sx/RhA==
Message-ID: <af5ae747-5552-aeb0-885e-ddc9ab6f39c3@kernel.org>
Date:   Tue, 22 Nov 2022 16:01:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To:     yonggil.song@samsung.com,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20221102100756epcms2p23dfabe90c467313ce094c5c81a99c6d7@epcms2p4>
 <20221122023656epcms2p4468d4feb97711516206e19890dad09ac@epcms2p4>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v1] f2fs: avoid victim selection from previous victim
 section
In-Reply-To: <20221122023656epcms2p4468d4feb97711516206e19890dad09ac@epcms2p4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yonggil,

I guess your email client forces converting tab and space characters of
patch, please check that.

On 2022/11/22 10:36, Yonggil Song wrote:
> When f2fs chooses GC victim in large section & LFS mode,
> next_victim_seg[gc_type] is referenced first. After segment is freed,
> next_victim_seg[gc_type] has the next segment number.
> However, next_victim_seg[gc_type] still has the last segment number
> even after the last segment of section is freed. In this case, when f2fs
> chooses a victim for the next GC round, the last segment of previous victim
> section is chosen as a victim.
> 
> Initialize next_victim_seg[gc_type] to NULL_SEGNO for the last segment in
> large section.
> 
> Fixes: e3080b0120a1 ("f2fs: support subsectional garbage collection")

Good catch, I'm fine with this fix.

Thanks,

> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
> ---
>   fs/f2fs/gc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 4546e01b2ee0..10677d53ef0e 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1744,8 +1744,9 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
>                                   get_valid_blocks(sbi, segno, false) == 0)
>                           seg_freed++;
>   
> -                if (__is_large_section(sbi) && segno + 1 < end_segno)
> -                        sbi->next_victim_seg[gc_type] = segno + 1;
> +                if (__is_large_section(sbi))
> +                        sbi->next_victim_seg[gc_type] =
> +                                (segno + 1 < end_segno) ? segno + 1 : NULL_SEGNO;
>   skip:
>                   f2fs_put_page(sum_page, 0);
>           }
> -- 
> 2.34.1
