Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556815BBD78
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiIRKqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 06:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIRKqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 06:46:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38A92253A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:46:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AC5EB80E64
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 10:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C838C433D6;
        Sun, 18 Sep 2022 10:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663497961;
        bh=zkPDclc9ypZuN/B77L98D9WxEHZJL08EA22fIWMnjYI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ISMYCEyMQgt8MCvRbCbQEQOqVGuuzNi4of9JXjsF/otyM8sQNExscbm4+/+8AOM7j
         FnayjoP/7utWQ0KuTmWkoI6U5b5iowvaXE1FMNyf+HfZMUfmsYoZQa4vO8FCZtpFoM
         ZVTBh6mLvsUAsQHQJBTFvniU6Qq0dsh7mVC1LiKZSxQd93fSIRLrofzEi9+6zpG751
         qUfovQCIZV2CgLZdDoc+ekfz1s5RkdLJczLuaVamAhJL8XZ+O/8o7heM6eZZPiTtHH
         YFQB3ZKjFQsXx0Hex2Im+369SiV0FzSUCAjTMtJ8zu/2iWqNDI8S3SKHo1WHgrCQs4
         BhalNxtTD1wdA==
Message-ID: <9e5b9c8b-e8a5-c1ec-d2ed-a068afb03b4a@kernel.org>
Date:   Sun, 18 Sep 2022 18:45:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH Vx 1/1] f2fs: fix some error handling case in gc
Content-Language: en-US
To:     "zhiguo.niu" <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     lvqiang.huang@unisoc.com
References: <1663222729-27774-1-git-send-email-zhiguo.niu@unisoc.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <1663222729-27774-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/15 14:18, zhiguo.niu wrote:
> During GC, if segment type stored in SSA and SIT is inconsistent,
> we set SBI_NEED_FSCK first and then stop checkpoint, this will
> cause the following issues:
> 1. SBI_NEED_FSCK can not be set to flash truly because of checkpoint
> has been stopped.
> 2. Will cause more EIO error because of CP_ERROR_FLAG is set in
> f2fs_stop_checkpoint, this is not reasonable.
> 
> So we fix this error handling case by recording current victim segment
> as invalid for gc.
> 
> Signed-off-by: zhiguo.niu <zhiguo.niu@unisoc.com>
> ---
>   fs/f2fs/gc.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index d5fb426e0747..66bdf2678b5e 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1700,10 +1700,13 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
> 
>                  sum = page_address(sum_page);
>                  if (type != GET_SUM_TYPE((&sum->footer))) {
> -                       f2fs_err(sbi, "Inconsistent segment (%u) type [%d, %d] in SSA and SIT",
> -                                segno, type, GET_SUM_TYPE((&sum->footer)));
> -                       set_sbi_flag(sbi, SBI_NEED_FSCK);
> -                       f2fs_stop_checkpoint(sbi, false);
> +#ifdef CONFIG_F2FS_CHECK_FS
> +                       if (!test_and_set_bit(segno, SIT_I(sbi)->invalid_segmap)) {
> +                               f2fs_err(sbi, "Inconsistent segment (%u) type [%d, %d] in SSA and SIT",
> +                                       segno, type, GET_SUM_TYPE((&sum->footer)));
> +                               set_sbi_flag(sbi, SBI_NEED_FSCK);
> +                       }
> +#endif

What about:

f2fs_err(sbi, "...");
set_sbi_flag(sbi, SBI_NEED_FSCK);

#ifdef CONFIG_F2FS_CHECK_FS
if (test_bit())
	set_bit();
#endif

>                          goto skip;
>                  }
> 
> --
> 2.17.1
