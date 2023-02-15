Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C666697F1C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBOPHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBOPHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:07:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9151BD7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 07:07:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45D2EB81D06
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 15:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F33C433EF;
        Wed, 15 Feb 2023 15:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676473626;
        bh=g4lVOohaJiHCnZenvdv47LjjxECvnXyXGuo9zGit+Hc=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=U626YwjyunoFDLPBetDBtXBER9WrtslNZG1WXf7eiEWLOK3IMbKE3DGHc33maLCQN
         SlBbj4TFH6H5wlS/S7C0KoVhxzTC+cg7AH+H/qacpmlqdGfW0QTTCzb2x4As7gLuDU
         qq7mM/LFtECDemKhpyB+pPObFOIxt506s27cYear5N4CeQvtcy3zN7CA8dpYb1cK31
         ghpDAfPrGd0Jg1PTHzo7P88/LbfFO5w75xYOoNIR/nInYWKu8pH/LYZvZ/PWqJIg5a
         8wkIO6mvVYt968oFGD6ZAq6B/gr0pi8frSPFJ2PoOuR0Ciioy0CtQ0dNnQbae7Nw9P
         ORmvh2woerw1w==
Message-ID: <cf7eae6b-61ea-accb-f981-023fb022919c@kernel.org>
Date:   Wed, 15 Feb 2023 23:07:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     yonggil.song@samsung.com,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Seokhwan Kim <sukka.kim@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>
References: <CGME20230215024850epcms2p22be2cc864d82b44f31c19a7ef28770b6@epcms2p2>
 <20230215024850epcms2p22be2cc864d82b44f31c19a7ef28770b6@epcms2p2>
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v1] f2fs: fix uninitialized skipped_gc_rwsem
In-Reply-To: <20230215024850epcms2p22be2cc864d82b44f31c19a7ef28770b6@epcms2p2>
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

On 2023/2/15 10:48, Yonggil Song wrote:
> When f2fs skipped a gc round during victim migration, there was a bug which
> would skip all upcoming gc rounds unconditionally because skipped_gc_rwsem
> was not initialized. It fixes the bug by correctly initializing the
> skipped_gc_rwsem inside the gc loop.

It makes sense to me.

> 
> Fixes: d147ea4adb96 ("f2fs: introduce f2fs_gc_control to consolidate f2fs_gc parameters")

How does this commits introduce the bug?

Thanks,

> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index b22f49a6f128..81d326abaac1 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1786,8 +1786,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
>   				prefree_segments(sbi));
>   
>   	cpc.reason = __get_cp_reason(sbi);
> -	sbi->skipped_gc_rwsem = 0;
>   gc_more:
> +	sbi->skipped_gc_rwsem = 0;
>   	if (unlikely(!(sbi->sb->s_flags & SB_ACTIVE))) {
>   		ret = -EINVAL;
>   		goto stop;
